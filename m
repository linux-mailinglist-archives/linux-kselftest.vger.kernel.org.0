Return-Path: <linux-kselftest+bounces-8866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C08B2625
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4531F23BB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BBF14D6E7;
	Thu, 25 Apr 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="O9mbrnhq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA114D282
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061845; cv=none; b=Our4hco0FAfJcXTI9R5Uu7d9NkChgof/CwDQ2zyuS7Cdd7AGUPtw04D5/j7rQC8LFl7ZM7w2M9uFBNMmqAqAthZaJg8lVtzQCusmOG58G9T2bHxaSPpRxt/cOPoTpKBG/cScsGfBXKCojWr27d9/r4kjjHrYP48z5JKWedm3/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061845; c=relaxed/simple;
	bh=cyER0tCDsBziw32uLRrW1CVxp/jAM0IiNflpsGJ0Pto=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Uj1YqLBQyY9eKdmMRNfby3t39pPrezr1KSJWFsq/k0oEfzt0TTB56dTfJGTZSxKYqdFHaGQDknVSwljOh/jbgXcuXENdHQ8LvReO3n0KeFkCV3xNgbkpczNbkaiUTJLU2TvJ7oa27pg5XrWd/6/VJA6kgaOB1Ir8XidBS67o4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=O9mbrnhq; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c191991e2so5475085ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714061843; x=1714666643; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cyER0tCDsBziw32uLRrW1CVxp/jAM0IiNflpsGJ0Pto=;
        b=O9mbrnhqkgGqlkIWLWjfywNk+b8hvzOFOtVes64QnVvrIkNY7g0LGaX+D7LJwv967q
         SyD+MUjyNvmRag0P33RAvYU+nDLhqW3OeIsyBOiI/bMDMkxz/TOJJIzehO+4qjc+7V30
         HMDAdR4RumU69xi1Jp8B/sjobsU52e/o/A4Kp6kMmiuOkGd0Ouv47+9SDZfHpbYJ5awL
         PWDlstLz6XbEVJELVAlwriuEFt0BSY2jMRl59TEZKnuq6CVbqNFYd9KBNHCdX5/lv1Ud
         FfcFJugxcLWvx+Mvaat7x7J+eDCMEeLO+3bs0xtt0S7Ql1mj57DXOJ07pZL2rH6M0zSC
         xIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061843; x=1714666643;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyER0tCDsBziw32uLRrW1CVxp/jAM0IiNflpsGJ0Pto=;
        b=S/aDK7nNVIKkCQIUJgMSMOrq2nrBzzSIwMgd/e5+6uw3Oz4Q190ewhByzhFllhTjP8
         UVESO72C+NBRjJs1vNdZ3ueRPouQXoW6tOL1tbzFd6W51ny5aVwNwhC2mWwRwmiBjihm
         MuOGp3Np9113Pu9ZZ7kwghvHF+NaPjMhrd104CLWX4fjjW/qul6uoFjeP5frN08QkHH/
         i3i787jiCMTtIU0GM4Euh/b0eflJxSFO1n4BS6UcX17PuDYdBkIuab3de97V8BnrsByY
         srfi1FBdie4+5SjI01ciy+1wCBOkjSr5HEBSDj4cO2NaSNyZOdk56iCnMb6dzBd2lcrM
         HDQw==
X-Forwarded-Encrypted: i=1; AJvYcCV63dY2u7YdShB7xz1p0iieI+XELGa5EFujj10K03mXUL4ODHQaGDRnUWlVUFqUMbSXUr5hafeJNi2ZxRKQGr3henyrdKyt2veA9qfFWDZR
X-Gm-Message-State: AOJu0YznLt0dUuv2TJXe3e3fFT/S8UgRnHqpq8Q4qgqjMbslBShUh+7N
	thVIMsWIXFg1oXYxYe6Q+SmkK3Og3cTYSXEuqx+2yZR22rQqEqYqbJTbUfszsZs=
X-Google-Smtp-Source: AGHT+IFiKKwCjlGCOK2QLiD684Fa0eyjQAMOCz/bbiL68N5tcmcGRSJea+bnlaWtzh6UXfIXUt5Ccg==
X-Received: by 2002:a05:6e02:170f:b0:36c:297d:2c96 with SMTP id u15-20020a056e02170f00b0036c297d2c96mr234632ill.19.1714061843206;
        Thu, 25 Apr 2024 09:17:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b005dc4806ad7dsm11611129pgu.40.2024.04.25.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:17:22 -0700 (PDT)
Message-ID: <662a8212.650a0220.eb522.809c@mx.google.com>
Date: Thu, 25 Apr 2024 09:17:22 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-32-g693fe2f6a9ea
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 0 failed,
 5 passed (v6.9-rc4-32-g693fe2f6a9ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 0 failed, 5 passed (v6.9-rc4-32-g693fe2f6a9=
ea)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc4-32-g693fe2f6a9ea/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc4-32-g693fe2f6a9ea
Git Commit: 693fe2f6a9ea17e4241e5114f54c6ae7bc2512d3
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
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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

