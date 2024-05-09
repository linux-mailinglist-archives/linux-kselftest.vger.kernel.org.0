Return-Path: <linux-kselftest+bounces-9754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E338C092F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 03:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812BF1F25B3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454A3DF78;
	Thu,  9 May 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="P5LMIqdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1BBA2B
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218372; cv=none; b=uKjao5N2O55BgojQoKbHjMDZgSncRc9MSKePGD2CyxMagfsHNB0JBCem45w1tAIkdzyf4ahK3UnqJ1WYcly0tLH1WCuO+n+9sGPplLsXISmD7hFeHpiEWWTTSAMuD301+CO6+2sm2iTWGvERztfosb0/aFYaDvVebC0Rbu2JGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218372; c=relaxed/simple;
	bh=QqyslRyIIKbTNxJSsZyHF+Orz1Ei2a2ba/eectQ03oc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=D723ltCb2rpnZv6QorrMhrrY7G4RZmN9pCj23AssCPsuaQYRUktBENMfxvn1Wn0M4u21TByJ79qdaGKNNPyP9yVaRjDU9HoOMyt5nfv1jo3nF5kyRli5EZ/St9vcnXfARZcwDXt+2z1eGoLIUcpGRlarZ4K9qan3GYhcKw/SFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=P5LMIqdS; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c96a34a263so226520b6e.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 18:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715218369; x=1715823169; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QqyslRyIIKbTNxJSsZyHF+Orz1Ei2a2ba/eectQ03oc=;
        b=P5LMIqdSMI2En4zJ7HnKBdSNb/gIe1k5iWNFe5QyW1oskiTqHWDsLaWn41GuF2kaqv
         yLJLS7Ybp5bLaEhHtx1Ux6W2vYLXvuiRh/dCaz5LuLAkqlARYQzfIQ2k7ICcHv86hCiz
         J/1gjfY4dgcesHQHYPoQ0wSIzWTE+opWqTxKzQKROp+mN8Xhavn1cuZeS352YhJi1+rU
         MNDSDSvmlFzhE3IvL441P1j7pwcayq3PM40v8K0bMKCP6PwjDsHmSbLLHTUN/cNFJ6cM
         pWiQnIRcrqeeH73+0uhnooOnmI8yNpFV+xrV9lM+VrqOhiZ6g3VohbyiUjrf4jEe4ASU
         MRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715218369; x=1715823169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqyslRyIIKbTNxJSsZyHF+Orz1Ei2a2ba/eectQ03oc=;
        b=bHmt1hp8PLsgzEEJNWfgFxkHRDW2V75Ql8zF5mPNb4awFUVet9ZYqOmpAxqM8Fdy6E
         W6l7s7LJYeW3HRFWFW2nYGQgwIvoN622MN97D5hMPlWu/tlADaXfPHOQxo20PS9jKEDm
         zD2O/fLEGMbG4yzTzKBYD/TOYz/JDZsMFqRdG6hu0fDwEL8q3wP+fNY4aiCFdvNjzuZY
         IehPmzHlEXexHT2xzgoFWoF/+5pu5YYMKUGoRjx3OfmWAc09W9CT5WI4oWqgjWKO2MKt
         KBplLdv+40/brnQuVgv1cdWeVJHKrz2h35JLuGRwYqwMOqWnMGFdEEHexrzhm6bTqoXy
         Yjbw==
X-Forwarded-Encrypted: i=1; AJvYcCUe2s77q351qcQB3uiHXMIb8kyHoKfCWN6FAMSfp2+UL/krr5CSrwym7AmtycG0HpJ61l6u8cDkrPjs5Z0BZe2XMSehoK0wta4GqhSjWBc1
X-Gm-Message-State: AOJu0YxY7Ija4Lfl5uPHoTZnb8xcz+afBgc9Ycc6KnOWK0U5B9REc4m8
	2/3eh62aoAsLo5kWPamxyvtIHATvWqdz3yWcoEPv+CZr7878RGPPzGB2lH94/h4=
X-Google-Smtp-Source: AGHT+IEoPEk7UK1K/NLBIMIUs+8Q4ZvhZkRk759D5cMwHzK/KCOho4BAXJamfY+eK+xFYIDcwnJWSg==
X-Received: by 2002:aca:1e07:0:b0:3c5:f86f:a5e5 with SMTP id 5614622812f47-3c9852ffb0dmr4337382b6e.38.1715218368159;
        Wed, 08 May 2024 18:32:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0de0sm198742b3a.116.2024.05.08.18.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:32:47 -0700 (PDT)
Message-ID: <663c27bf.050a0220.36726.0e19@mx.google.com>
Date: Wed, 08 May 2024 18:32:47 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc7-44-g2c3b8f8f37c6
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 3 builds: 0 failed,
 3 passed (v6.9-rc7-44-g2c3b8f8f37c6)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 3 builds: 0 failed, 3 passed (v6.9-rc7-44-g2c3b8f8f37=
c6)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc7-44-g2c3b8f8f37c6/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc7-44-g2c3b8f8f37c6
Git Commit: 2c3b8f8f37c6c0c926d584cf4158db95e62b960c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

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

---
For more info write to <info@kernelci.org>

