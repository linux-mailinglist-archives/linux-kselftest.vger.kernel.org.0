Return-Path: <linux-kselftest+bounces-23198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32469ED74D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8D0163918
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A420A5DD;
	Wed, 11 Dec 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjHgHMd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADD1FF1D7
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949466; cv=none; b=a9+bSWqY7HxRnFJRI65OJuJerxYD18l2QFy47wh+jcCOdlYpd60Pbwod7rDB6cYELB6ppWERlhauJlV++4SeTX1f4cN3yfq7+w0keeVzsKwz+F6yhSUmiyuvYb6GQHiONZmfpC2zNgukdW6k3PLwzir072yMhRca9O+qtxZ7NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949466; c=relaxed/simple;
	bh=9YSjFkd0Ikd+gYJR9d1ukXVWZnbDGV+dFE1EVawD6Bg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=QyARmze7ir6AubDyaFFSOT8n+03kBcH9ArYIjZNInWYaqmsQnnIT/o7CwmslLjhFzX6hynKOKZuESaJmqm9XRMZsWhZ4LrWZ29fvupF6IcIiyAJNZTKm0tCAiK8R3GAeB1JOp1i3lpsWwsJvjPeIXjvzOgqf67f1p/q3YIeeuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjHgHMd0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844c5f31d48so138012839f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733949463; x=1734554263; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SxohKwxXt9yfnit8Y5nOLuGD3ESesQ489Y5a7mGse+U=;
        b=RjHgHMd0+Kgs6uvj26+3ydKZq1uc/w/dPVsc8YWu05HNV3AYTSMPMpQuclGTcYkfhl
         lBP2o3L/MtApTBSmRomGMQwGkWSKeWREj1LM/SrEkOQTtRnp7agcZqMyhshPH5m0IHnb
         JgMV5R76kMpOhwhDC4KY8+VE1rbhOmeHPGchw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949463; x=1734554263;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxohKwxXt9yfnit8Y5nOLuGD3ESesQ489Y5a7mGse+U=;
        b=Mp4xCPOosf9D4Kam3uWQVLqcAkxGOtLBXaZoKepC9xyWm1VUqrJGXLpHHpM++XTI/D
         dAHnEF+abqk02U0TpozOsYPuVBRmiR6C9QpjelATqqB8jPTYUmSsIlxfaFj5orJVAFfr
         j3W9vpvnehtieru82pqMsRmBKAh0WsVNYcRGh7y9Ba+AQUgdcZvRMAMLP7f856fPWZPp
         KIBhrOlykS9iz+7Bx1ysOqoONePLQOwirIi5uEE+Pwz5JAu1qUr5HfXbRsqv3t5KqdXy
         udZrJoHTb17eaEZqtNbts71RljYNJI/NIhQpdaJQAaR/oBGjVdQ3jkIWNycmw17Fw9rt
         9PGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV383SNldcjDLqy+Jzj3exhZYbDi1o/ZpJRcvLJ1i1V0OORveuzRQRdLAAuyAhdPxZ+Y1p+vnE06iI98o2NrXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHtEBHE5AlLhxmKBcNSJwMLCEJzPcMsamRTjxgoW8tyNXhFgY
	vzik+/w2ZJjZeVP14HcbY9iQxd98S3xvD9KEEQjspW4skWkTEF+pWlj4mE9w9PjscmGRa5JqgTR
	C
X-Gm-Gg: ASbGncsSXfT3xy1NfmmQ0aNUJyLw2jHHtFJneZBNY0Im2sTd+jodR8RpKuAD4vmf4q+
	/Yi3HbvFzXYENF/HkPDz8hjBNWU7bOi4QqRJsOjQZyfB/2J5Y+iOJQ2RQDmkfSo3LeocSqCv3Z+
	Zg+jMU9hOFzdL/SP6lJwMYbvUkbpTUDqV1WgFlvIjJqFE+peqXlnF3uyB8WECrzlvh4LtwRNdBi
	Eoa63q6k+Rhvgfa5XullQ9tiJipcQAQ66kFYeJ4bG3j2GJFJSPVVMfjdvpZuryRHQ==
X-Google-Smtp-Source: AGHT+IFakvpKG+9hRpBEPAnACboJindxqb6rGLetngrQQzz2gzfaNZLtJ0K6Ssj2ijKWbbPgS6FmwA==
X-Received: by 2002:a05:6602:1612:b0:843:ea96:f707 with SMTP id ca18e2360f4ac-844d7472524mr106813539f.8.1733949463429;
        Wed, 11 Dec 2024 12:37:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844d3f37f77sm25248039f.46.2024.12.11.12.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:37:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------LuOvLp4AF8WW5w5iynxNMIZU"
Message-ID: <e3c2e67e-c80f-417c-a44f-e2f568e90d44@linuxfoundation.org>
Date: Wed, 11 Dec 2024 13:37:41 -0700
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
Subject: [GIT PULL] Kselftest fixes for Linux 6.13-rc3

This is a multi-part message in MIME format.
--------------LuOvLp4AF8WW5w5iynxNMIZU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following fixes update for Linux 6.13-rc3.

linux_kselftest-fixes-6.13-rc3

-- fixes the offset for kprobe syntax error test case when checking the
    BTF arguments on 64-bit powerpc.

Note: This fix has been in linux-next since last week. I had to drop
a patch and rebase this morning.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.13-rc3

for you to fetch changes up to 777f290ab328de333b85558bb6807a69a59b36ba:

   selftests/ftrace: adjust offset for kprobe syntax error test (2024-12-11 10:08:04 -0700)

----------------------------------------------------------------
linux_kselftest-fixes-6.13-rc3

-- fixes the offset for kprobe syntax error test case when checking the
    BTF arguments on 64-bit powerpc.

----------------------------------------------------------------
Hari Bathini (1):
       selftests/ftrace: adjust offset for kprobe syntax error test

  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

----------------------------------------------------------------
--------------LuOvLp4AF8WW5w5iynxNMIZU
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.13-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.13-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3By
b2JlL2twcm9iZV9zeW50YXhfZXJyb3JzLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZnRyYWNlL3Rlc3QuZC9rcHJvYmUva3Byb2JlX3N5bnRheF9lcnJvcnMudGMKaW5kZXggYTE2
YzZhNmY2MDU1Li44ZjFjNThmMGMyMzkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2twcm9iZV9zeW50YXhfZXJyb3JzLnRjCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2twcm9i
ZV9zeW50YXhfZXJyb3JzLnRjCkBAIC0xMTEsNyArMTExLDcgQEAgY2hlY2tfZXJyb3IgJ3Ag
dmZzX3JlYWQgJGFyZyogXiRhcmcqJwkJIyBET1VCTEVfQVJHUwogaWYgIWdyZXAgLXEgJ2tl
cm5lbCByZXR1cm4gcHJvYmVzIHN1cHBvcnQ6JyBSRUFETUU7IHRoZW4KIGNoZWNrX2Vycm9y
ICdyIHZmc19yZWFkIF4kYXJnKicJCQkjIE5PRkVOVFJZX0FSR1MKIGZpCi1jaGVja19lcnJv
ciAncCB2ZnNfcmVhZCs4IF4kYXJnKicJCSMgTk9GRU5UUllfQVJHUworY2hlY2tfZXJyb3Ig
J3AgdmZzX3JlYWQrMjAgXiRhcmcqJwkJIyBOT0ZFTlRSWV9BUkdTCiBjaGVja19lcnJvciAn
cCB2ZnNfcmVhZCBeaG9nZScJCQkjIE5PX0JURkFSRwogY2hlY2tfZXJyb3IgJ3Aga2ZyZWUg
XiRhcmcxMCcJCQkjIE5PX0JURkFSRyAoZXhjZWVkIHRoZSBudW1iZXIgb2YgcGFyYW1ldGVy
cykKIGNoZWNrX2Vycm9yICdyIGtmcmVlIF4kcmV0dmFsJwkJCSMgTk9fUkVUVkFMCg==

--------------LuOvLp4AF8WW5w5iynxNMIZU--

