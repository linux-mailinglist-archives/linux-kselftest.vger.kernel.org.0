Return-Path: <linux-kselftest+bounces-18530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8129890EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BA41C20E56
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527C1474D3;
	Sat, 28 Sep 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MATxLJXc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9261442F6
	for <linux-kselftest@vger.kernel.org>; Sat, 28 Sep 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545933; cv=none; b=dSfxN4UNCgWG+j8NAkMHeEtpJhuFE38iScue/ziTBSK2my8oGXlRKkxAjPg6MA3LigMm3WKpxXv2+6ii8iJwOBobgPIzWvq+RMmb86l2E8c1LfiQ/gNfakl+k20Tmu3XEU6IyEiUUlVEKknP+ebhjlUHPQtkm6EC8qIq0C+Zzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545933; c=relaxed/simple;
	bh=Uqa0aEiRfMZ+tjgDQ+k3MiilKxrdHHuBjZJGMcQkgL4=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=RRmg3sEvUvchemnLVH/sOJQeMrAIA+gDVwYteCCELuB5X7IcHjnHFCFYMfRfG46N+2a3Qu6T/qcsQbihoR+lMyukYHBOmqBtCFSmK8tyUH/Ap0/OYPf/DO5Gbmr75LM5QZvmDVWbbZc2GaWKkkTumrYa9neg7rccdzUFJwoTWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MATxLJXc; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a345142c25so8046055ab.3
        for <linux-kselftest@vger.kernel.org>; Sat, 28 Sep 2024 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727545931; x=1728150731; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sANlHcjzzNRn/6XZ2NNaKzZHLFRqKomEKfHup3G5og8=;
        b=MATxLJXcuqfFAL5v4HVu/JNVaRnWUgvF4yBOTpy+Ut2STfue+jR9r9rZX9OZNGB+KU
         K/IjBddE0506L+PDJAZbislcXH0A8hwGha72DxERg/fk2AKkLNYigAmyj3pM8Le+T46i
         3BHb2PMaph1mHeIRk10FSYBYH3sfmrMsV7dPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727545931; x=1728150731;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sANlHcjzzNRn/6XZ2NNaKzZHLFRqKomEKfHup3G5og8=;
        b=gF2TBwcSxb1g57zokDqIgMWViIBvnXthOAhhAlOQ9k/LzEWkxhdKxtn1YGKr+HUZJS
         pC5OGe18633SzlSo3FaPXrFv2/smMilyGCW0u0BgDavu/3XFDUg1kl26Wk7zPq0s9FVV
         bYA4Bn5RZ2vvh/TGDjJFtnyQKgITCHG3EfOsrH8uYpCcqwddFuFwSEaYOVJi42yoV6xT
         V5DaInCR/40tThKti7JE4SPXEbkllB6QCVxrhrMX58oyBExHPdBI650vYYjUv8ohvxAI
         N5qu/Ald3rAkXl5WcuAgbOYbZxXW1LJ2wK52YuB/wWsp/OEkopJrQ9AJ02jrTTQRylM8
         dPJw==
X-Forwarded-Encrypted: i=1; AJvYcCUTL91NSYg9q0eZR82SHHBIEPZo6Mr9uWRJ6KJD5cAtvZ97ex9mEhHLfxWruno/azUYB543JTeGOazpSv0Fdk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQTr0/kKa9jZcRl8cbz5rrdQXJ/j7GNLhLpviVDjFYrO0EZfL
	ipfNmvgxvbTxUBgGYz+3/bKArOCxuTJgyV/Gi/2QjvOkC8UbiV8FkKpSot7N9cQ=
X-Google-Smtp-Source: AGHT+IEU5yZwhVRSrXXrwLhldFY2D8FvVGZE+sYgS1tvITXCgrK3nwuukm2dkTL9RsYMiAxcFwELxQ==
X-Received: by 2002:a05:6e02:219d:b0:39b:640e:c5e6 with SMTP id e9e14a558f8ab-3a3451b0742mr59663715ab.17.1727545930622;
        Sat, 28 Sep 2024 10:52:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888849dadsm1192630173.46.2024.09.28.10.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:52:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SkJ87yNwIGKhcZkAxDH2hxv6"
Message-ID: <8b5ae15e-fce7-48ed-a0cf-8ca0b00c6ea1@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:52:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.12-rc1

This is a multi-part message in MIME format.
--------------SkJ87yNwIGKhcZkAxDH2hxv6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this fixes update for Linux 6.12-rc1.

This kselftest fixes update for Linux 6.12-rc1 consists of an urgent
fix to vDSO as automated testing is failing due to this bug.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a0474b8d5974e142461ac7584c996feea167bcc1:

   selftests: kselftest: Use strerror() on nolibc (2024-09-11 09:52:33 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.12-rc1-fixes

for you to fetch changes up to 4b721fcc094e9eb6dd4702df8d79ab11e120833d:

   selftests: vDSO: align stack for O2-optimized memcpy (2024-09-27 12:17:12 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.12-rc1-fixes

This kselftest fixes update for Linux 6.12-rc1 consists of an urgent
fix to vDSO as automated testing is failing due to this bug.

----------------------------------------------------------------
Jason A. Donenfeld (1):
       selftests: vDSO: align stack for O2-optimized memcpy

  tools/testing/selftests/vDSO/vdso_standalone_test_x86.c | 2 ++
  1 file changed, 2 insertions(+)
----------------------------------------------------------------
--------------SkJ87yNwIGKhcZkAxDH2hxv6
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.12-rc1-fixes.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-next-6.12-rc1-fixes.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb19zdGFuZGFs
b25lX3Rlc3RfeDg2LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fc3Rh
bmRhbG9uZV90ZXN0X3g4Ni5jCmluZGV4IDI3ZjZmZGYxMTk2OS4uNjQ0OTE1ODYyYWY4IDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fc3RhbmRhbG9u
ZV90ZXN0X3g4Ni5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb19z
dGFuZGFsb25lX3Rlc3RfeDg2LmMKQEAgLTEzMSw2ICsxMzEsOCBAQCBhc20gKAogCSJfc3Rh
cnQ6XG5cdCIKICNpZmRlZiBfX3g4Nl82NF9fCiAJIm1vdiAlcnNwLCVyZGlcblx0IgorCSJh
bmQgJC0xNiwlcnNwXG5cdCIKKwkic3ViICQ4LCVyc3Bcblx0IgogCSJqbXAgY19tYWluIgog
I2Vsc2UKIAkicHVzaCAlZXNwXG5cdCIK

--------------SkJ87yNwIGKhcZkAxDH2hxv6--

