Return-Path: <linux-kselftest+bounces-14800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3F9483D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 23:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC59C1C21EF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5616C69A;
	Mon,  5 Aug 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCOp4SjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2616ABF3
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Aug 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892095; cv=none; b=e2Yj7CniPnEiEpKTkDNzNEXepDEtCyOzSeRarsl+aIkxU34QHWDN/g4iY4MWLAlNx6p1XFX3Wty77J/gOUWHMvIykGWLpOi9g+UiOacjUkKW1SdlTpQhY2BCCmGV03uIk+VpcBBHKZ/o4YqHJTLFn9088pWzBsi1HoHFMvWvOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892095; c=relaxed/simple;
	bh=1hgE1tHYTzoNT4ZaVAJ9uX7zwlujJ5HbNKj22V8PvTg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=BE1Iz8rc8MjXOchdoX9ZZ7IhgiWJPzKB9ztv9rgFL0j1a+zxfvenPwiCQMpT3VOaZFQz/gvAvXrGs3BhrxHg6RhKY9tPPhSs1eNWg7F1KPrD6eCeZIrBer7PIlJx+gN88fr3A4HDARYGVNU3jBCiB1ffyu1/MtdhG61k6w66D8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCOp4SjD; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f7faff04dso279439f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722892091; x=1723496891; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RoZN9WiORe0ITjlZlmSzWf3fhNCsHe6Tv0uWDr+78DY=;
        b=CCOp4SjDrTb9uWQitAer6R3CNc17jeUszVR3sXWB0cnxT0zba7Jjj0s87FJ65y3jYH
         vvew9mFtNWURCfXuy0qNaEI4VX2t3jmK9z80LCl5R/0//5UkWQ7tCYqNyP5730aBkCtK
         dziEunfYEHrYOKp1Wrqyr5QRyy9u1SDbhxiRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892091; x=1723496891;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoZN9WiORe0ITjlZlmSzWf3fhNCsHe6Tv0uWDr+78DY=;
        b=UVMu5xj8NvgCEkzdB7M3AJC1Q9/uoiLuShdQAoxnVkWjBR8Hjjri6DQMBdtOPMCRV+
         YGeShf5bRQ8jpd/9rsapMtf10oUmyVgNZODaHYi9tRxokEVfBT4fSLhax35twltzewlR
         kLWJD+lzCVUUfDHpoNmFY3la37MUW9rLrdnAlObfMWj++AUrU1RzmOVcWOEGY1FcV+zE
         2+dI4GqbWF6aUjY6k3vHSZfao2qEKOIChEjxD79IgqvbmvYNy69L79ST+ApiVjf0PTsx
         1xQXNY+XCJgCDmJgA7vyprh1jAvBIJQ0RMY3nmA5cOMyFTLD182tbrX7HLFqe2azjv4k
         4Pbw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3nhYTAXK98aKGd9DRwCXPgD91b10rmjopKqrsg4DWtUd0wUXQ5fCLh3XBHLDsvXDx22Yq1Ivu7tqxgP/LY6V0jF5ZTperTqOuPd7YDxg
X-Gm-Message-State: AOJu0YyXSDCBDjbIO5WH4dmT3YwAecTwF13dHxsy+J0uIwBXh7AeUbS/
	kiIqoEv2h3aWIcqy7MuoRFep89b6wIhijfL8LZ50U55Vc7/IIbd3sooQx2g7LyQ=
X-Google-Smtp-Source: AGHT+IG06IJu0JjiFmVnxTP6Y8qg0xKaMfM6fJWXNb6BQKehWJuVWwjXR3HnoavVyGtfFIUnPoP4fA==
X-Received: by 2002:a5d:8b0a:0:b0:81f:dccd:844e with SMTP id ca18e2360f4ac-81fdccd8609mr580759839f.0.1722892091241;
        Mon, 05 Aug 2024 14:08:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a5ad04sm1907722173.178.2024.08.05.14.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:08:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------LlER0KbKGvSKZ6L4wyCWLfpp"
Message-ID: <732e15a1-f219-45b1-8836-ebd5ca3101cf@linuxfoundation.org>
Date: Mon, 5 Aug 2024 15:08:10 -0600
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.11-rc3

This is a multi-part message in MIME format.
--------------LlER0KbKGvSKZ6L4wyCWLfpp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the kselftest fixes update for Linux 6.11-rc3.

This kselftest fixes update consists of a single fix to the conditional
in ksft.py script which incorrectly flags a test suite failed when there
are skipped tests in the mix. The logic is fixed to take skipped tests
into account and report the test as passed.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.11-rc3

for you to fetch changes up to 170c966cbe274e664288cfc12ee919d5e706dc50:

   selftests: ksft: Fix finished() helper exit code on skipped tests (2024-07-31 11:38:56 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.11-rc3

This kselftest fixes update consists of a single fix to the conditional
in ksft.py script which incorrectly flags a test suite failed when there
are skipped tests in the mix. The logic is fixed to take skipped tests
into account and report the test as passed.

----------------------------------------------------------------
Laura Nao (1):
       selftests: ksft: Fix finished() helper exit code on skipped tests

  tools/testing/selftests/kselftest/ksft.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------LlER0KbKGvSKZ6L4wyCWLfpp
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.11-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.11-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9rc2Z0LnB5
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L2tzZnQucHkKaW5kZXggY2Q4
OWZiMmJjMTBlLi5iZjIxNTc5MGE4OWQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2tzZWxmdGVzdC9rc2Z0LnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2tzZWxmdGVzdC9rc2Z0LnB5CkBAIC03MCw3ICs3MCw3IEBAIGRlZiB0ZXN0X3Jlc3VsdChj
b25kaXRpb24sIGRlc2NyaXB0aW9uPSIiKToKIAogCiBkZWYgZmluaXNoZWQoKToKLSAgICBp
ZiBrc2Z0X2NudFsicGFzcyJdID09IGtzZnRfbnVtX3Rlc3RzOgorICAgIGlmIGtzZnRfY250
WyJwYXNzIl0gKyBrc2Z0X2NudFsic2tpcCJdID09IGtzZnRfbnVtX3Rlc3RzOgogICAgICAg
ICBleGl0X2NvZGUgPSBLU0ZUX1BBU1MKICAgICBlbHNlOgogICAgICAgICBleGl0X2NvZGUg
PSBLU0ZUX0ZBSUwK

--------------LlER0KbKGvSKZ6L4wyCWLfpp--

