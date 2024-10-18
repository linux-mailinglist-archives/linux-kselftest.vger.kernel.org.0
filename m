Return-Path: <linux-kselftest+bounces-20173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8311D9A479F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D5F1C22CA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8804202F9A;
	Fri, 18 Oct 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nw3GzzIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A7136341
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281909; cv=none; b=bw8S5POoVFJsz5HTYioKVCpnn//wvcrS1BF0ABHRbZb5lGZYWQbuDFd0MX3S+JtfKC+sg666E37IZ54EdAWa+9eCFr3B1ynyib/3t5zrirfRbS/cD4Vj1D7dYjKZh6fLMsJerYcePAhPjPmGuEHq9LauH7EPJKV59FpA5zROs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281909; c=relaxed/simple;
	bh=mkaOtpb3HNeDJA0nxy7+7OowOpaC33RcU/eLe93HduA=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=E9dqLIyVRF8WN4OEcoAEo2fn+urLnXxkxByxmhjAP6R/CeRzqFf2CyP9uAqAN2tj9OVXhjXsADc1iKZnTdhLdDKfqfirMED1/OKCnscyRpUBejBnw57/xElie2IzJmT2fDTMKB1IJlzpEqHnAqZM1wMOgVFrySS9vQHTy8alN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nw3GzzIm; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso10551285ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729281906; x=1729886706; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rPxHTXyKrbypbqAH2vVCeHWTcQMbDX/8MEJl9C0+I7A=;
        b=Nw3GzzImwuXW6o4JIZyRY2qF3ItNh//irPkZRJVBtit/njkavAkjK1c/AlZN3ikdiT
         g8z3SUhiWEpUUv2Si6ebGA43LhGhicS6wDqL0BAbLtBa9+62o1njXiGFTtznNx3Oa+wh
         VM+hqR+c/kwA8tbOPCa98CEl0zM+yB0sgJyDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281906; x=1729886706;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPxHTXyKrbypbqAH2vVCeHWTcQMbDX/8MEJl9C0+I7A=;
        b=edDUK4wV7uKPcoXFvxAV+4SiBMeRVp1YDoK8zhObsYO+Z46ycMXor/CNYwyUFgW26+
         q4E18VEMjbIL+0yrv+YgqusFOHg+MFhew0utGOEX1sOA5ZwkFq5pzTC9QKzCUAhwR+iU
         69MVyS75diEAqrD5+HAW8LknIMT1plt1qMR+6JYEnPq9lq4VKY5yOPA3SMtNpagwH6mw
         +ZKQo6XvMKxArc1osdjGCiMn50qVOL7q4RX4JhfU619W2hJMGThaJJojUWScZdjf3i1J
         JKGtIBMU660v3s5iZSUPfMFQaIJSDMLhpDglJHQy7ld/u+OHhMNgTU5Q27ksB0iqZlmB
         bioA==
X-Forwarded-Encrypted: i=1; AJvYcCX4VXAj0X0RyinAeZ/lTNY5yq4y8vZ5Jjeenfrhg9tEkLwNDNiIGnww3/mMxwxddH9Q8l9+1UIP1Sbr7vlBRaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2Z3UjwVNzfTlZWkexFtuoLWw/Zg3plD0AalGZRIwyJ8o93ED
	/+yVwjWQOi89X19Dksu6KLkvV/MRpKProVQ1OvZJUZ04RLRR43+P+uZujQeKWOo=
X-Google-Smtp-Source: AGHT+IFoS8dBAqr9LnFIvB1nC4+F22eafH96GYg4T3IeiyRLXhgA3mdRdXgQaRAS8j+4rtJWvCQXZw==
X-Received: by 2002:a92:190d:0:b0:3a3:f860:9c79 with SMTP id e9e14a558f8ab-3a3f860c229mr13965005ab.18.1729281906207;
        Fri, 18 Oct 2024 13:05:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c67f35sm574680173.158.2024.10.18.13.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:05:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ZlneuxfJq1Xpvfa6ANCD9Syw"
Message-ID: <399ec96b-1d84-4aa0-9030-0e42282a6d4a@linuxfoundation.org>
Date: Fri, 18 Oct 2024 14:05:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.12-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZlneuxfJq1Xpvfa6ANCD9Syw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.12-rc4.

-- fixes test makefile to install tests directory without which
    the test fails with errors.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4ee5ca9a29384fcf3f18232fdf8474166dea8dca:

   ftrace/selftest: Test combination of function_graph tracer and function profiler

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc4

for you to fetch changes up to fe05c40ca9c18cfdb003f639a30fc78a7ab49519:

   selftest: hid: add the missing tests directory (2024-10-16 15:55:14 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.12-rc4

kselftest fixes for Linux 6.12-rc4

-- fixes test makefile to install tests directory without which
    the test fails with errors.

----------------------------------------------------------------
Yun Lu (1):
       selftest: hid: add the missing tests directory

  tools/testing/selftests/hid/Makefile | 1 +
  1 file changed, 1 insertion(+)
----------------------------------------------------------------
--------------ZlneuxfJq1Xpvfa6ANCD9Syw
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.12-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.12-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZSBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZQppbmRleCAzOGFlMzFiYjA3YjUu
LjY2MjIwOWY1ZmFiYyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlk
L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2hpZC9NYWtlZmlsZQpA
QCAtMTgsNiArMTgsNyBAQCBURVNUX1BST0dTICs9IGhpZC11c2JfY3Jhc2guc2gKIFRFU1Rf
UFJPR1MgKz0gaGlkLXdhY29tLnNoCiAKIFRFU1RfRklMRVMgOj0gcnVuLWhpZC10b29scy10
ZXN0cy5zaAorVEVTVF9GSUxFUyArPSB0ZXN0cwogCiBDWFggPz0gJChDUk9TU19DT01QSUxF
KWcrKwogCg==

--------------ZlneuxfJq1Xpvfa6ANCD9Syw--

