Return-Path: <linux-kselftest+bounces-7318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C689A5CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC891F218E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F0174EDB;
	Fri,  5 Apr 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i7tHLLYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D64C8D
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349785; cv=none; b=IJh+saM2rupJzJeeMFlcu7veP5Jf0W3wEwJgTxwev6aERa39ZfTLrtPftQxM1cgtDTwR1C8UlevmYHxWArPe2g1berHSVPxCaOIhb0WE0kiU5UMbIOodKtxhyzbmxNl3jfpdJB7d15mRtglB9ps51L4x90stBfwgvpyky5fct8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349785; c=relaxed/simple;
	bh=c+hgrtDcRzwvJygcVHefXFNY33ivuV+mCEt07qvRhOI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Cy5cTm7shxH85XzM3u9nyQ4CIxc050FCXsQ6J4Q5Ip3hvxPzplSnPi6yAJeFQiyUu1lRj0N72mcDsEcndYzPBs6s4CN5/hQiWe8Lkir3zHTTViPEFt3L+g8OwcvAr3SUcP2ie7vS/N8OxQBMukSrzGv2K8OCFv4f7YjrCaJ8Xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=i7tHLLYH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e2b137d666so18527575ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712349784; x=1712954584; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c+hgrtDcRzwvJygcVHefXFNY33ivuV+mCEt07qvRhOI=;
        b=i7tHLLYH29liz4k0Gpg3gQPoSVqN4ZD7+sxieA9Qs4mJ3JS/zw56Xq0zp4+kcrFnwp
         A1FW6nVAFWsHlZJiA1omN4Ohrgt3gPwyd/sbrcZplkdzH4Dxy6RCGOzXllIncnvMCh1w
         x3Dao8uSOxhatcCPNUPL00tO+dX1sK/ZCInthsRKymAUHwW93DBpa2Fq41+m/lCHMVC2
         e+gwYBfm8r7isZ0Y/rqi7IfgwHHgzi9T/O+qmesp8IDv+EuNZRYe9TJ9nSAQydVWcZTK
         ZhDim5kWnUoelJEto4NthxodEj8JRIBWmqNJAtvV97ZqhQ0lluOgDPJSCn3HBRztb2xR
         Q5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349784; x=1712954584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+hgrtDcRzwvJygcVHefXFNY33ivuV+mCEt07qvRhOI=;
        b=GcU3wFwB8VMuxsgtaqJW56Usdhb2aKp9sxyyzBZRAyizprYeh8La1t5b0MmPina7Tc
         416hkM8ri9Y7toQcq9H/DbAfvvDWD5QgIBtiUkjA+QziTINAXP3i38QMWzS+9cruEwab
         uDBrtTrAEk3qLkZl+XhEeGpPrcaGkxgQe6m/telSLnCE7ojmkd9ifdVgp8K96R9LCO/A
         8GUS4qhTnYplY57XEUTIwVdPVUqH7V1i1WS5M+c/6MhsnTj51ylFikc+4xhkO41h/8KH
         oIkJJLmrvk5GUP82Vf8mv+/9rT92SwFv4khotLefJ56Q6wWnNrM3ti53O/tx1S4gZqk1
         KNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK0BDe1OHAw8D5/DjYPbODNesOCatj2F3hVRO8Gy6549oxKi73KpfqEpDlm4WapgdYRlOfhN/4/u6B8V3LhrvhsNdzjSFN/JSvsg5sctrH
X-Gm-Message-State: AOJu0Yy/R3w48gLgO5TthAE2D8H0fLTuPZHUyaJSyQmsDSezyBJQX2vM
	aMzA4Lm56DYr+dS+yJ+3mcSfEq7myJpCmYulNHHIN4NuoHGb07f1HWMhYmlFZCS7M8m9sP4qkW+
	L/3g=
X-Google-Smtp-Source: AGHT+IEmdoRS0tz3vUmVK8R+T37bCuy8lnivAbLgQGevOEwV5/Y3cSL3vK+iI+sELqXu4/uHQqEHwQ==
X-Received: by 2002:a17:902:d1cd:b0:1e3:999a:9726 with SMTP id g13-20020a170902d1cd00b001e3999a9726mr2237500plb.29.1712349783725;
        Fri, 05 Apr 2024 13:43:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001e0b5ef2bcbsm2023951plg.128.2024.04.05.13.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:43:03 -0700 (PDT)
Message-ID: <66106257.170a0220.7e21a.6f84@mx.google.com>
Date: Fri, 05 Apr 2024 13:43:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc2-16-g3f4d0fa96430
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 2 builds: 0 failed,
 2 passed (v6.9-rc2-16-g3f4d0fa96430)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 2 builds: 0 failed, 2 passed (v6.9-rc2-16-g3f4d0fa964=
30)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc2-16-g3f4d0fa96430/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc2-16-g3f4d0fa96430
Git Commit: 3f4d0fa96430b23553fc9c8c36c2ff9cdb8e9667
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

