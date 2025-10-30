Return-Path: <linux-kselftest+bounces-44453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF5C22552
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 21:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E161AA4EDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66C2F659C;
	Thu, 30 Oct 2025 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aECMP8/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BB34D38B
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856873; cv=none; b=mnws+eiy5QhfM6f8c6zhv+ErHvU8bHdA5SqAEOKNuVBb9dipOKiVEN/N68kjsNtDC3nfwmJ2pgO9t2Dmbaj/9lugusf5Upz7Cta6iyOhM/c3IS4vCblIyZHqorxfX+GWXfYedcZd5EdIUYdiQ78jTN+w0bQFUBG8DxJPxZP14Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856873; c=relaxed/simple;
	bh=DGKM+D/8dORnCmZVB7KeVfaU9rAIsFyobxq5iITPV7M=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=IWyQFw5aYxtIMI4jy/sqZ2srhQEfTrE/mdoobJL7iKsL+jlNHa2hFGOP+qzZUb0UJVYOdpsuROSsZEtdfSmkX9Dnq9miqx2wNs/a9bzOFSHldfkUAE0SQ1TDHmGjAS8kY0q/ggKLIu9XO8312DRlP6DaqsR2n8kqFkLRgQXGwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aECMP8/D; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-93e7c7c3d0bso142464839f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761856870; x=1762461670; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tMbzFRN4VDnIbSBdbg+M282JI0CZVXK2l1hvzFW/aYw=;
        b=aECMP8/DeDqsDFkmErD6HTMw1O5xnON8lv7lY1mLE39Tz6oFVn1T7vXXhQr/6Pjtmh
         Sqn8JMK+ZqlSgnHDZ/cmxwaND10geGPGGbQuSBYxhxRPAV6RqapLgPwvyrBgrrnHHh4h
         6xPQkUG9M4Sn/0QB6xXLSTRtsoNA5D8Qi1FY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761856870; x=1762461670;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMbzFRN4VDnIbSBdbg+M282JI0CZVXK2l1hvzFW/aYw=;
        b=JdKOP9XfNsI3gdqZUjYz3W2hRziRItcXOsJkjRPeKvNghD23v1OkE64FjqdlNzvd9T
         ErsYce3k21v2h5fSQHj89IQczRNykJApQkbJbqb5w21DrIn5cP7RdOTqXRDE4H0YOcBR
         gJDjI7Kh9wWex1rDjm86Eml7R4CS+kBITNeaUHKv9xMnl0sguYb1VF5E7LYGSUxlfDqM
         TU1lLw3/hOu5XxBEH70eJcbijUi5VOe3TfnKrfY2zqffQP1EiE85jxHBAeyVo+0EQkP2
         NdgsQhaMInV5RJPynhSCNP3DbYsGYSKDAPH36gjNzgpZn24gLleFBw/XdZKfM1aLTHK8
         cDyA==
X-Forwarded-Encrypted: i=1; AJvYcCWZbo7BesafppSVkiFEpTLeUqmQTMB5jIDiPTmJCow9wvWQK0j6Fp4X0L2c6gX6V76IiSChgF2fdHlBn4/ADys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZr5RyTRFr5HxFtdLITDb2Emzp1F742cHrylVElsH1TB4kwJQ
	Tbxr4Dm3Ji1j3HxNqkmPbPFC7Ph3M5ux9i0BYw4MFCj1MrheyaT1cGoFTKGsfJGCsOqJQoD4pCF
	GR6k0
X-Gm-Gg: ASbGncu8YjVdnBnOR6TBdQfHOI6JHeP0BSZ4SxtXJctuc851shEDdt696KqohB7FX3c
	KIZCDoiucxAOPYwjBoYzL+fvgKCorLp49ceOBrEw+NW3MfF4QpZwdrXy8+wLbhO4ZTtO7J3K4Cq
	VB6rHuHDdHuISdNiGWhKtX0ePhAmSEX7ZPrH9yzJcXc3BwTF0GKeaiEV5wHGXG7p1M4sJ8w6YMn
	V3AY8A59xAmYKkRYluwgbprqoVUxt1WGjY6JxpeBuelexIV90AquIetODtNiPOFwqrAatE2U7Kq
	BpJpbJKqRL/AY3/5ck7a6Q2lcOab+DVpw6lGDDgKtROVIsLCeqovAWnPX7AOYxPcb00qNz74lZX
	aFQryFTgZFSV4y86ofmRlof6riCCGRbrqN24OHsO4GEKpeEM6pz6UIuoV/mLCgisFI5jBNeP1J8
	XlLQWjabdG0e4x5ZNwOj/+8TY=
X-Google-Smtp-Source: AGHT+IFtYidU8HOSyon4KC9wbVGvadMzueXcw2TTQkSOKcTkQVusdlwswmE74yQXfBqazFfMlhr8YA==
X-Received: by 2002:a05:6e02:258a:b0:430:bf60:6b01 with SMTP id e9e14a558f8ab-4330d1b72d8mr17053015ab.19.1761856870301;
        Thu, 30 Oct 2025 13:41:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995e766sm7073374173.51.2025.10.30.13.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:41:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ScomMdE0WD2e84oLSRwxQVR0"
Message-ID: <d721dc87-5021-4404-af2d-d44489dbe249@linuxfoundation.org>
Date: Thu, 30 Oct 2025 14:41:08 -0600
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest fixes update for Linux 6.18-rc4

This is a multi-part message in MIME format.
--------------ScomMdE0WD2e84oLSRwxQVR0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.18-rc4.

Fixes build warning in cachestat found during clang build and adds
tmpshmcstat to .gitignore.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc4

for you to fetch changes up to 920aa3a7705a061cb3004572d8b7932b54463dbf:

   selftests: cachestat: Fix warning on declaration under label (2025-10-22 09:23:18 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.18-rc4

Fixes build warning in cachestat found during clang build and adds
tmpshmcstat to .gitignore.

----------------------------------------------------------------
Madhur Kumar (1):
       selftests/cachestat: add tmpshmcstat file to .gitignore

Sidharth Seela (1):
       selftests: cachestat: Fix warning on declaration under label

  tools/testing/selftests/cachestat/.gitignore       | 1 +
  tools/testing/selftests/cachestat/test_cachestat.c | 4 ++--
  2 files changed, 3 insertions(+), 2 deletions(-)
----------------------------------------------------------------
--------------ScomMdE0WD2e84oLSRwxQVR0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.18-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.18-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhY2hlc3RhdC8uZ2l0aWdu
b3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FjaGVzdGF0Ly5naXRpZ25vcmUKaW5k
ZXggZDZjMzBiNDNhNGJiLi5hYmJiMTNiNmU5NmIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2NhY2hlc3RhdC8uZ2l0aWdub3JlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2NhY2hlc3RhdC8uZ2l0aWdub3JlCkBAIC0xLDIgKzEsMyBAQAogIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CiB0ZXN0X2NhY2hlc3RhdAordG1w
c2htY3N0YXQKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhY2hlc3Rh
dC90ZXN0X2NhY2hlc3RhdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FjaGVzdGF0
L3Rlc3RfY2FjaGVzdGF0LmMKaW5kZXggYzk1MjY0MGYxNjNiLi5hYjgzOGJjYjllYzUgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhY2hlc3RhdC90ZXN0X2NhY2hl
c3RhdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhY2hlc3RhdC90ZXN0X2Nh
Y2hlc3RhdC5jCkBAIC0yMjYsNyArMjI2LDcgQEAgYm9vbCBydW5fY2FjaGVzdGF0X3Rlc3Qo
ZW51bSBmaWxlX3R5cGUgdHlwZSkKIAlpbnQgc3lzY2FsbF9yZXQ7CiAJc2l6ZV90IGNvbXB1
dGVfbGVuID0gUFMgKiA1MTI7CiAJc3RydWN0IGNhY2hlc3RhdF9yYW5nZSBjc19yYW5nZSA9
IHsgUFMsIGNvbXB1dGVfbGVuIH07Ci0JY2hhciAqZmlsZW5hbWUgPSAidG1wc2htY3N0YXQi
OworCWNoYXIgKmZpbGVuYW1lID0gInRtcHNobWNzdGF0IiwgKm1hcDsKIAlzdHJ1Y3QgY2Fj
aGVzdGF0IGNzOwogCWJvb2wgcmV0ID0gdHJ1ZTsKIAlpbnQgZmQ7CkBAIC0yNTcsNyArMjU3
LDcgQEAgYm9vbCBydW5fY2FjaGVzdGF0X3Rlc3QoZW51bSBmaWxlX3R5cGUgdHlwZSkKIAkJ
fQogCQlicmVhazsKIAljYXNlIEZJTEVfTU1BUDoKLQkJY2hhciAqbWFwID0gbW1hcChOVUxM
LCBmaWxlc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKKwkJbWFwID0gbW1hcChOVUxM
LCBmaWxlc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKIAkJCQkgTUFQX1NIQVJFRCwg
ZmQsIDApOwogCiAJCWlmIChtYXAgPT0gTUFQX0ZBSUxFRCkgewo=

--------------ScomMdE0WD2e84oLSRwxQVR0--

