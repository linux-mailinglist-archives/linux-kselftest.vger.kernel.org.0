Return-Path: <linux-kselftest+bounces-4610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4641C8540B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 01:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16F128275A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1CB18E;
	Wed, 14 Feb 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwE61G5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C47F
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869223; cv=none; b=lCS4T4w2zclLEvoHSY3nNsb37MLrQjXBJen4zqa+eFRZvKNzXms2xdCgg59G96NoN5ibCQ4Fq1E8z38E2vY3VmCla5zpVYlT3r5CoVA1SgkEgNweGLMz0n/jq58gbQPS4LTKSuQpElPZ1QD0ZKw6tEbEol7Z5gsAU9V006f038o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869223; c=relaxed/simple;
	bh=kRl2xvjnEqYqUWOmQ7ofjTzJ/cSkkaVkiE+7IUsfJIA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=Y6wKMbyBoMueyD/+KfBJ7SfmDoa7qEuPjkAl5S3WITkS9TPLH+cCN5E2cW/IYnxfMqQtL0AVQVYK0CXKYu25SqpRGE4elBi6IDcDKwSY5yDtYxXhj2jt76V7YsHjJsz42ZNgPW3YmawEefeHTvYFM6almphiWj3HYzfCs37JNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QwE61G5Q; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso29479039f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 16:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869219; x=1708474019; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GhnQu6FmXGPVZCi3UFjGPAyQfbh2TxR1NXwH/TlSM+w=;
        b=QwE61G5QxGU6+NPISDK5K/zPcZoewOWpMO53VHQQhTvAeiRApupQZRirnDOMz4Mr7D
         osl1qNBUquu6R7VqofaZUxuBAOZM+vsMGUPrlcPZpsXy+MOq+b4geSgiMsdhIzm4XdbJ
         jGIt6QuSn8rJ/KaVXEsm2qa61KPBH6zymYsU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869219; x=1708474019;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhnQu6FmXGPVZCi3UFjGPAyQfbh2TxR1NXwH/TlSM+w=;
        b=dkc9bsiP3RqAFtd2sub4Zy+A1KjHKdsfDTvHRoGpTXZo+xU3EzB0bho8CB8rgT7yjW
         xoII1c/ugBKsIkFSSNrNKoPEG8/1HLZmNE2feNhz4NMlnU8KW6J8mg7FEJQP5lqq9TJV
         jbLNvgbxytSAeg6dLu6K6qKPqMMi/Pcz9PZTcCox7JRE+ijZR8hn4tYyUogkhWcj8ejY
         Q8/8lNGXk4TeXQFGNrJDFvesZwt+tGVyuKD8lPyhDHjt5rkU28j6pErnVWikyIvd6XOo
         LRViGaMsV5C8DQAIiIkMMlMxKYRM3pTa/MLbVeqcn5uZAFFpfySBrQemNYeMeGyScorV
         qrgA==
X-Forwarded-Encrypted: i=1; AJvYcCWyVuhLIqMEc9NDO43ilkoqUpKAMXBeV136AD6Ik7/9wcmeYxl5SMxWqH3jPnArabAorbxH/vcJNLU7aZjeDQ+qLO58XZ25LOcnM5esH0di
X-Gm-Message-State: AOJu0YyxyIfTjiXQhlxNs+7i2pHJqs8xGGY3fUeesDYvQSPysGtuP4fr
	uclkGD8fNpLOEyn/1BCYo99D3p0Zb6ozZM0K5iXdAVN4W6VrkozhhLVnIK3wAls=
X-Google-Smtp-Source: AGHT+IHJKYRzo/PlZVd0iIErIR69DKw3o9VDIiU5d2kUn3AtE/swPSe1OtmTzjtH+2nxZIpUxXzPwQ==
X-Received: by 2002:a6b:fe01:0:b0:7c4:8032:5724 with SMTP id x1-20020a6bfe01000000b007c480325724mr809467ioh.0.1707869219183;
        Tue, 13 Feb 2024 16:06:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXA4aTCw0RK9urTQ3ld4zkHTrIyDI62ZmJAw8XHTRnc+Cf9qmTZe9wUE4VytcuFEsKt28Assj+UwSbhwoKX1NH6EefWt9fsDYDqnZ4KSda9xxk2H3KI3oRUb0M3+TL6c7q8urMVMQgGg0aD/HORoX4GxOTZO6AUfDk6Mfy5td1nOyRw9JWXlHTE7ozVe12yoCDqpHIn574Da3TVmICHwQKIYphqF13wLv3vMRQYtn3CnJyfoUrutyZn
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u25-20020a02cbd9000000b0047129817ee3sm2209721jaq.141.2024.02.13.16.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:06:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------BEVlR5zmYlGmqCSr00K4AOwP"
Message-ID: <876716d6-f865-42cb-94d0-67e9193a96f3@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:06:58 -0700
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
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.8-rc5

This is a multi-part message in MIME format.
--------------BEVlR5zmYlGmqCSr00K4AOwP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.8-rc5.

This KUnit update for Linux 6.8-rc5 consists of one important fix
to unregister kunit_bus when KUnit module is unloaded. Not doing
so causes an error when KUnit module tries to re-register the bus
when it gets reloaded.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 1a9f2c776d1416c4ea6cb0d0b9917778c41a1a7d:

   Documentation: KUnit: Update the instructions on how to test static functions (2024-01-22 07:59:03 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc5

for you to fetch changes up to 829388b725f8d266ccec32a2f446717d8693eaba:

   kunit: device: Unregister the kunit_bus on shutdown (2024-02-06 17:07:37 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.8-rc5

This KUnit update for Linux 6.8-rc5 consists of one important fix
to unregister kunit_bus when KUnit module is unloaded. Not doing
so causes an error when KUnit module tries to re-register the bus
when it gets reloaded.

----------------------------------------------------------------
David Gow (1):
       kunit: device: Unregister the kunit_bus on shutdown

  lib/kunit/device-impl.h |  2 ++
  lib/kunit/device.c      | 14 ++++++++++++++
  lib/kunit/test.c        |  3 +++
  3 files changed, 19 insertions(+)
----------------------------------------------------------------
--------------BEVlR5zmYlGmqCSr00K4AOwP
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.8-rc5.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.8-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9kZXZpY2UtaW1wbC5oIGIvbGliL2t1bml0L2Rldmlj
ZS1pbXBsLmgKaW5kZXggNTRiZDU1ODM2NDA1Li41ZmNkNDhmZjBmMzYgMTAwNjQ0Ci0tLSBh
L2xpYi9rdW5pdC9kZXZpY2UtaW1wbC5oCisrKyBiL2xpYi9rdW5pdC9kZXZpY2UtaW1wbC5o
CkBAIC0xMyw1ICsxMyw3IEBACiAKIC8vIEZvciBpbnRlcm5hbCB1c2Ugb25seSAtLSByZWdp
c3RlcnMgdGhlIGt1bml0X2J1cy4KIGludCBrdW5pdF9idXNfaW5pdCh2b2lkKTsKKy8vIEZv
ciBpbnRlcm5hbCB1c2Ugb25seSAtLSB1bnJlZ2lzdGVycyB0aGUga3VuaXRfYnVzLgordm9p
ZCBrdW5pdF9idXNfc2h1dGRvd24odm9pZCk7CiAKICNlbmRpZiAvL19LVU5JVF9ERVZJQ0Vf
SU1QTF9ICmRpZmYgLS1naXQgYS9saWIva3VuaXQvZGV2aWNlLmMgYi9saWIva3VuaXQvZGV2
aWNlLmMKaW5kZXggMDc0YzZkZDJlMzZhLi42NDRhMzhhMWY1YjEgMTAwNjQ0Ci0tLSBhL2xp
Yi9rdW5pdC9kZXZpY2UuYworKysgYi9saWIva3VuaXQvZGV2aWNlLmMKQEAgLTU0LDYgKzU0
LDIwIEBAIGludCBrdW5pdF9idXNfaW5pdCh2b2lkKQogCXJldHVybiBlcnJvcjsKIH0KIAor
LyogVW5yZWdpc3RlciB0aGUgJ2t1bml0X2J1cycgaW4gY2FzZSB0aGUgS1VuaXQgbW9kdWxl
IGlzIHVubG9hZGVkLiAqLwordm9pZCBrdW5pdF9idXNfc2h1dGRvd24odm9pZCkKK3sKKwkv
KiBNYWtlIHN1cmUgdGhlIGJ1cyBleGlzdHMgYmVmb3JlIHdlIHVucmVnaXN0ZXIgaXQuICov
CisJaWYgKElTX0VSUl9PUl9OVUxMKGt1bml0X2J1c19kZXZpY2UpKQorCQlyZXR1cm47CisK
KwlidXNfdW5yZWdpc3Rlcigma3VuaXRfYnVzX3R5cGUpOworCisJcm9vdF9kZXZpY2VfdW5y
ZWdpc3RlcihrdW5pdF9idXNfZGV2aWNlKTsKKworCWt1bml0X2J1c19kZXZpY2UgPSBOVUxM
OworfQorCiAvKiBSZWxlYXNlIGEgJ2Zha2UnIEtVbml0IGRldmljZS4gKi8KIHN0YXRpYyB2
b2lkIGt1bml0X2RldmljZV9yZWxlYXNlKHN0cnVjdCBkZXZpY2UgKmQpCiB7CmRpZmYgLS1n
aXQgYS9saWIva3VuaXQvdGVzdC5jIGIvbGliL2t1bml0L3Rlc3QuYwppbmRleCAzMWE1YTk5
MmU2NDYuLjFkMTQ3NTU3ODUxNSAxMDA2NDQKLS0tIGEvbGliL2t1bml0L3Rlc3QuYworKysg
Yi9saWIva3VuaXQvdGVzdC5jCkBAIC05MjgsNiArOTI4LDkgQEAgc3RhdGljIHZvaWQgX19l
eGl0IGt1bml0X2V4aXQodm9pZCkKICNpZmRlZiBDT05GSUdfTU9EVUxFUwogCXVucmVnaXN0
ZXJfbW9kdWxlX25vdGlmaWVyKCZrdW5pdF9tb2RfbmIpOwogI2VuZGlmCisKKwlrdW5pdF9i
dXNfc2h1dGRvd24oKTsKKwogCWt1bml0X2RlYnVnZnNfY2xlYW51cCgpOwogfQogbW9kdWxl
X2V4aXQoa3VuaXRfZXhpdCk7Cg==

--------------BEVlR5zmYlGmqCSr00K4AOwP--

