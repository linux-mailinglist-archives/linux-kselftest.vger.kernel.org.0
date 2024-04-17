Return-Path: <linux-kselftest+bounces-8243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C78A7C1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 08:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BEC1F2208A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 06:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642C537ED;
	Wed, 17 Apr 2024 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZRyfb5z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAB535A9
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334130; cv=none; b=tqyDEzyJTtsf9KvWdbJYWA/5ThsFAcSJHD2F/trrQm2zerudyf9yTFmPGH6mXuD0/xYd7V8hXaFPbzcjBaAfHwFni81w8wN8V8aor+69M47sNO9+OM+OokImQ2ZzZu4yi6UeYmLlk4H3qy03znSkohCsLN0YO2gwl2pXwqWxXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334130; c=relaxed/simple;
	bh=/+LsxB+urUqwaQyFXq2WlKtNVBLyvJBMLRwOO8NMwS8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=JEtHIo/x/brl4IyFIM6XXuPGcmKmltXG15SJ9FJipvmeHwBSYFQi8Y1YDAKQO34bPlxRj1XnYLZL1+ihXoUG6zVgDLO1JVb7quWJpPW2zs7UuKyg3+VK9uW1dmxhHYhfYu0kkorhy2dPeFzAtADGaZFGDDWOcMOzfOZC1Sm6IDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZRyfb5z+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2793238a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1713334128; x=1713938928; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+LsxB+urUqwaQyFXq2WlKtNVBLyvJBMLRwOO8NMwS8=;
        b=ZRyfb5z+kOjGGM80JC46ONIm7JS8FDWcil1jVBlwkSj+uymDUwGNG2GjXka69l68B5
         wykwsrAWAaZ4nDBHh0X5hzO+v8wBWlPi3eeQGrtQ8h4tLzyBbj7TDMxtqnnG+YQ4bJGG
         Ulo/DMpwK5m/vCVjI8I6N9iLK2UoExiQB7ZVFIGaAaE3BS92/9yO3IYtadrNssgxovPR
         Y3ef3dZ1rxNKtLPJvz/3tqw8uxLg95Qj+0mo7FW6+zRemzThu31M77SYNj+oIE519VbQ
         o3VMx+InEVP/E6YN1kWNQtKc5wDpGGhK1qjGINLHMffV0Y2Tyoq2T2XshNtvSyT9D9tp
         PPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713334128; x=1713938928;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+LsxB+urUqwaQyFXq2WlKtNVBLyvJBMLRwOO8NMwS8=;
        b=MZewSQEYJjNI/OcmZr+Z8pWamJFkzrLm4rTlZ2fRe2faZl09DEWPbuufWWhNUhS720
         UJRvInpw65AFgFhxC8XEKCN6tbalQ5pJd8/aTP7/I1hh8Rtrbchz0/qrWofPx8iN86AR
         eEj7p5ZPhzqhuVwnrDGustCIJLuZHcGPZkgg4+mPi916mEYE2coppBn+yIntYJxIFANS
         eavo6SN91x0x5jIh09TL1hJffIgifioYLICK13+SvnE+2OV3OCWdkuzefJfrnxJx0upj
         OWYdiZy9Jyo+HPjNVNEGcHgAjP3IOvGeoLPdk06vW5q3K1E+MPdGHXBbOg2PGC1qu2qw
         nCNw==
X-Forwarded-Encrypted: i=1; AJvYcCX3OMAek4vP3yegUVuV083K8aW99N+1QYooAH82mnbsknmGm4IvHghQlae2oz/f0+MEPG3wPK5urQvONGe4DR5B7ToVNfLSOHFe1udxSCuy
X-Gm-Message-State: AOJu0YxX85fXkxf2y+8c/yjU+1ZsDU/tZs4TSFwucnve2oE1UPOY88qL
	qt+zd+er4hG7ctF5lwDM+gNLjB7nGwFpQX7QILMTSYgPVGjfjE6SdRRKlMemeVk=
X-Google-Smtp-Source: AGHT+IFnV4VFjfaoePb8fkqyV5nzE2x4izOgFbJLayiNLNHL9JJL/Oqr3bJkqrph+xwjJz1WsxIzzg==
X-Received: by 2002:a05:6a20:a113:b0:1a9:4055:6dce with SMTP id q19-20020a056a20a11300b001a940556dcemr15439631pzk.58.1713334128226;
        Tue, 16 Apr 2024 23:08:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jy7-20020a17090342c700b001e3f0cde2desm10808943plb.253.2024.04.16.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 23:08:47 -0700 (PDT)
Message-ID: <661f676f.170a0220.b003f.00b0@mx.google.com>
Date: Tue, 16 Apr 2024 23:08:47 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-19-g00ab560eb0e3
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 0 failed,
 4 passed (v6.9-rc4-19-g00ab560eb0e3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 0 failed, 4 passed (v6.9-rc4-19-g00ab560eb0=
e3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc4-19-g00ab560eb0e3/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc4-19-g00ab560eb0e3
Git Commit: 00ab560eb0e3f9725521c9fec2e8992e9e7e6c29
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

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

