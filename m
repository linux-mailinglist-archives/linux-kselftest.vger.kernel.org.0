Return-Path: <linux-kselftest+bounces-13631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465F692F18F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 00:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEDA1C22CE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD21A01A8;
	Thu, 11 Jul 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RFf7vATU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E416D33D
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735225; cv=none; b=QuyWj6tzaPK5dCHmiOUvP5crNi+h+yyMErdvselNQ6fwRuoN/ULDJ0Kev6h2+o7YsXZrW7twqbRWza7DSpu9DIid+NMDCHYN7T1VwXaWMMDezEsDNverT4V5OlPDxM84SLkH0JCD/M+WH7cooEU1+PyqNDszoVtBDdZt/Xcoyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735225; c=relaxed/simple;
	bh=rQEfR9tUF2lpFgcn7Uqt7g3DWsju3nqviVH7sD2hapg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Yn/mwK1qICJnjdtWP8FQM9ByWcg5MU7jV2TXY5NnSeYAbqwmOTNxE8afwRaorP0GFclaHBGi6sFQELZVeK9sBmoOlaCqAyVirRzc/NfkNWK9fBib6xVi5PzqnMycACTBKi7zfvroLkTTXWF+hRI5yzPmwp7ZoBv2+VFRzgQen54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=RFf7vATU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fbcf71d543so10569265ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720735223; x=1721340023; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQEfR9tUF2lpFgcn7Uqt7g3DWsju3nqviVH7sD2hapg=;
        b=RFf7vATUpW+2H6NUVHH3lFUN2BIO3d0dMvkgYAJQr9u+ZddLZLJOEd5GJzqadUtdMv
         Jd0iy503TSnYUfgvso+oFHEhThGXh4Hse3N0aA4HzQ9qzgnW7jRffabWsnkfUDTnCZWY
         MeS6ciGQmAT1uknm3XwspvbCEUa5JIEHvZNt+Ms42kxi7yWD3y9xCOsds/BVMA+h4JUq
         eJGS6fn1fqrVNwdXKuGky3gWa40eC08xSdzVAhsgMg9jGnC5MVDKaXZN6fNJAVJGzN1Q
         edgz4hXoco5Apigj7eKr8PKTpGSdJC9EduB+dqm748cSh29SosHyeHcdhLgTKFTraKeh
         C2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735223; x=1721340023;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQEfR9tUF2lpFgcn7Uqt7g3DWsju3nqviVH7sD2hapg=;
        b=uNegcZRCcn/bnisGVRgUsSZHGWe3B3j85675hBHnwl8D6MWgyHFuXOeg11p+yh3Noa
         FK5qOHre4FwTqu7UetNRUp+7OZVoaJi7jer7sobWEjusWNB1S+encIpjJljpoazwHj7h
         U7lyUWmdsWE6QF0Iv4rm+RFtL9KjGjNdIQT1P6rg5KK1whl2lzQx45PrEIypT4jNkXYD
         oDFDwcgw3C2Tmd7Me4O6XA3enp/XvepKAdlw9Pg7uZOFQarFWq9qMoaJalVXuzoQQe6T
         4kKO2xFiHC3FiQIcu+lZC5jxKYNC85/vxDi5ZCO1QHi0k2rjPl4MyXY3Oq0FZSQoKWUc
         hXfg==
X-Forwarded-Encrypted: i=1; AJvYcCVAWkAJdFYFEMkqpi2SjVpjNQELuVXMzSwHT8V3EVYQbi9zU7RpLRb5VGSXWj4Q+JxOGEtk4cY9KB+Cote2Uh4X2lE9MfVThjwCU/X0oEgg
X-Gm-Message-State: AOJu0YxvJl+jnZh+9kiqggCbcR+0P21Cg4Y0OOVRfWkDxm9zO7Gbe8JU
	okrls4Z8beffRm6+nLQ8x4mObbSmbHbJAHNDsPlv2Clqubx+61QiI7I+tx1FVMOpE5cLsskd9Hd
	c
X-Google-Smtp-Source: AGHT+IFqyYVIVvCJNs9g+KEnH+OwptyLC3WD+LC31YR8/t9MWjX488HqJdy97Hqsr7TneBjKb5esKw==
X-Received: by 2002:a17:902:ea05:b0:1fb:a1c6:db72 with SMTP id d9443c01a7336-1fbb6eb2a71mr74883555ad.60.1720735221482;
        Thu, 11 Jul 2024 15:00:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2a708sm55236335ad.85.2024.07.11.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:00:20 -0700 (PDT)
Message-ID: <669055f4.170a0220.4e725.976b@mx.google.com>
Date: Thu, 11 Jul 2024 15:00:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc7-33-gbb408dae9e73
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 1 build: 0 failed,
 1 passed (v6.10-rc7-33-gbb408dae9e73)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 1 build: 0 failed, 1 passed (v6.10-rc7-33-gbb408dae9e=
73)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc7-33-gbb408dae9e73/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc7-33-gbb408dae9e73
Git Commit: bb408dae9e73803eab8a648115d6c4a1bca4dba3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---
For more info write to <info@kernelci.org>

