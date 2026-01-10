Return-Path: <linux-kselftest+bounces-48670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D760BD0DA79
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 19:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045FF301F7D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2C29D26B;
	Sat, 10 Jan 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtI11y9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFC13957E
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768070022; cv=none; b=j8L/NZzUL+siIdvOZ5tpc7iuPk0xNZGET9jSgQkifbHHwHMGKie756c+CHANJ9nrwKUVvbEFZeHnyZLZ9J1AX3qdTRhOxk27fBmXd99Z0oB2K7laoid0gq7EH0lR+lt5jUEtDfPtjykrimoe7BqTyqY4euAPTXv0dyh1mjEN870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768070022; c=relaxed/simple;
	bh=X1FZaOHWniex3yPFe/1Ey/fEwAaZfBt1wUh5u7yhL0Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=EdumRqUTuyIx/DpTZhvO3sfZ8ivuYFBuHjOTasu+vzF/05X0QhBpkc7KsRNDLd081Pj0KYEIU/5fu15TErpu671nPKMQfhSUYkOlEgVkRT3rbZFfUk27qfMWuM/EK+mrV588r6ClbNNjoqpGgzxgw+XIePM9Mo1flk1yGbMqy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtI11y9a; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45a84c6746cso867786b6e.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jan 2026 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768070019; x=1768674819; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MUoPodehysTledp845KJ5VeyY4pSUj8NKNgN8iJSr5s=;
        b=AtI11y9aLdS/XincFDulu/Bc6YZrRPjrY3Q/vcdZeBFF78cZl4sXiYYCAyPbSPK6zI
         iPZfl+dmTnRsJbnd6d/1ZW3JImQ/xRmtduX2UlAynb7LaZvNURIWISxpeBw+f2pcQxaN
         Ik2pLT87s/OsrLR0rhR5oAmDR6IvfiBp4IrAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768070019; x=1768674819;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUoPodehysTledp845KJ5VeyY4pSUj8NKNgN8iJSr5s=;
        b=QBTCE7SM9WRAIBFMSrK7hm7vnkxsFDPC9hm2kP3Ls/VDG34NH8kzQzzmfkaE65Zyaj
         kzA+ri+NfbThniJlWZI19jNrAfTkB2i3MqL92IJkouPEWcx4HhdOPNKNybNWvKM5x44J
         x1iOzq2c1IXoiSrJKIICyRIwoNJ7CnHgXp9/d7hXJ01hamiFAPk4YM2KikyidpxnJ9tV
         bY0m9kK0tCbC+PjXSbWdK1Ql6Vtk5SiZBOMEu/MzatAjrD/NjAz2POpFq8/JYUEdxzY8
         sRyxchgh/NiQ3/fAA0L7vTKVUCs9tg7R3QKpMwvgBwG/nKIKesWOA7R7ACd/hlED+QYd
         qNUg==
X-Forwarded-Encrypted: i=1; AJvYcCUBeNdLmjFgqig/PJNSyxXtfwKbv1rWzmTSLNr4/F49AakFfZU4V6fty0LzbhWem60SEB7VkWjINxm39/faVlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmP6HUenHRMXi/DU7vUQ6+pH//g6D70N4H8ETsr80WuPwhC1L
	hWXSHp8a1FbryvVbY/9bIuFKuCCH6GX92ttMo8fSvz+PatA0T95EFdvBhqOaqZFNt2k=
X-Gm-Gg: AY/fxX5VAqRJdsEyqHCCtPcdpO9LztvmNHHTCGNKLQJooCN3s93nVBI3ktmF3VaKOSK
	ZmBx1hry9iqb/s4sKVab4jyKqRr/dGkw50yucjRJE7ajqH7hBPBh/C+AGzRnUVzmxIMbOrBCppL
	H9V1CHTep/shswuqqgvF8vffT3jLar1/1sagpE//GTkO3tm5aTwZq9Djt3sbISKeuCcQc3DFE1J
	LRnnsaMm7XFdPEvxR8v1R5D5dnbn/NhafBW6UYwiBy/ql1JZCKd1w3qP51ihWpZJ4qEFIuEHiH9
	5meR3ZcRVLq3MCTgNCmfUNyI5bSHkKcDJTznbYQZiSJSGHQWJE/LmZ1m3MpsdOmLYsnDLbh0XNy
	3+JcPIERbOMfCp3nTc2L0HOVd7d2te6ymNp+BggGCo9KMHPT8774/9IEZw9GELWmUTCbRgaLjAU
	NXzlPGNurQn8IDQsd7+MjuATc=
X-Google-Smtp-Source: AGHT+IFXIlq8qxFBX/eoeWI8YlY6JKL0hh/c/KBYA3U4s40BIgCUfc6o9AvUiZdsG04CYvv4J+9xQA==
X-Received: by 2002:a05:6808:c185:b0:450:7a38:cabd with SMTP id 5614622812f47-45a6bdbcf83mr7221181b6e.25.1768070018837;
        Sat, 10 Jan 2026 10:33:38 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm6399601b6e.3.2026.01.10.10.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 10:33:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------900sEa3m36B7Ny4qtUV0aSx4"
Message-ID: <7bb8e251-6f09-42a8-bead-2ef9427bbe8e@linuxfoundation.org>
Date: Sat, 10 Jan 2026 11:33:37 -0700
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
 Steven Rostedt <rostedt@goodmis.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest fixes update for Linux 6.19-rc5

This is a multi-part message in MIME format.
--------------900sEa3m36B7Ny4qtUV0aSx4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the fixes kselftest fixes update for Linux 6.19-rc5.

Fixes tracing test_multiple_writes stalls when buffer_size_kb is less
than 12KB.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

   Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc5

for you to fetch changes up to 6e39903c73df08b256322d04c4dfe4a82ec63a45:

   selftests/tracing: Fix test_multiple_writes stall (2026-01-09 15:49:32 -0700)

----------------------------------------------------------------
linux_kselftest-fixes-6.19-rc5

Fixes tracing test_multiple_writes stalls when buffer_size_kb is less
than 12KB.

----------------------------------------------------------------
Fushuai Wang (1):
       selftests/tracing: Fix test_multiple_writes stall

  .../ftrace/test.d/00basic/trace_marker_raw.tc          | 18 +++++++++++++++++-
  1 file changed, 17 insertions(+), 1 deletion(-)
----------------------------------------------------------------
--------------900sEa3m36B7Ny4qtUV0aSx4
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.19-rc5.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.19-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvMDBi
YXNpYy90cmFjZV9tYXJrZXJfcmF3LnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRy
YWNlL3Rlc3QuZC8wMGJhc2ljL3RyYWNlX21hcmtlcl9yYXcudGMKaW5kZXggN2RhZjcyOTIy
MDllLi5hMmM0MmUxM2Y2MTQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS90ZXN0LmQvMDBiYXNpYy90cmFjZV9tYXJrZXJfcmF3LnRjCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvMDBiYXNpYy90cmFjZV9tYXJrZXJf
cmF3LnRjCkBAIC04OSw2ICs4OSw3IEBAIHRlc3RfYnVmZmVyKCkgewogCSMgVGhlIGlkIG11
c3QgYmUgZm91ciBieXRlcywgdGVzdCB0aGF0IDMgYnl0ZXMgZmFpbHMgYSB3cml0ZQogCWlm
IGVjaG8gLW4gYWJjID4gLi90cmFjZV9tYXJrZXJfcmF3IDsgdGhlbgogCQllY2hvICJUb28g
c21hbGwgb2Ygd3JpdGUgZXhwZWN0ZWQgdG8gZmFpbCBidXQgZGlkIG5vdCIKKwkJZWNobyAk
e09SSUd9ID4gYnVmZmVyX3NpemVfa2IKIAkJZXhpdF9mYWlsCiAJZmkKIApAQCAtOTksOSAr
MTAwLDI0IEBAIHRlc3RfYnVmZmVyKCkgewogCiAJaWYgd3JpdGVfYnVmZmVyIDB4ZGVhZGJl
ZWYgJHNpemUgOyB0aGVuCiAJCWVjaG8gIlRvbyBiaWcgb2Ygd3JpdGUgZXhwZWN0ZWQgdG8g
ZmFpbCBidXQgZGlkIG5vdCIKKwkJZWNobyAke09SSUd9ID4gYnVmZmVyX3NpemVfa2IKIAkJ
ZXhpdF9mYWlsCiAJZmkKIH0KIAorT1JJRz1gY2F0IGJ1ZmZlcl9zaXplX2tiYAorCisjIHRl
c3RfbXVsdGlwbGVfd3JpdGVzIHRlc3QgbmVlZHMgYXQgbGVhc3QgMTJLQiBidWZmZXIKK05F
V19TSVpFPTEyCisKK2lmIFsgJHtPUklHfSAtbHQgJHtORVdfU0laRX0gXTsgdGhlbgorCWVj
aG8gJHtORVdfU0laRX0gPiBidWZmZXJfc2l6ZV9rYgorZmkKKwogdGVzdF9idWZmZXIKLXRl
c3RfbXVsdGlwbGVfd3JpdGVzCitpZiAhIHRlc3RfbXVsdGlwbGVfd3JpdGVzOyB0aGVuCisJ
ZWNobyAke09SSUd9ID4gYnVmZmVyX3NpemVfa2IKKwlleGl0X2ZhaWwKK2ZpCisKK2VjaG8g
JHtPUklHfSA+IGJ1ZmZlcl9zaXplX2tiCg==

--------------900sEa3m36B7Ny4qtUV0aSx4--

