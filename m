Return-Path: <linux-kselftest+bounces-8557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78D8ABC44
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448611F2115E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F312942C;
	Sat, 20 Apr 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnkgFBek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08E168CC;
	Sat, 20 Apr 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628585; cv=none; b=uW5sonNPm+f2glDdc2dhwG37ptQilZ+A/wEIouLCgUe7r3tLjEleM+cIYNfq9fYITfvLeE/u6H8ZZ/up9Xe/t4yJZesChb/KzCjS/8Sa5NTHBwA8qm9o4k81GdN8vvgCa7RNGL0bcNDAo3GHU4E+iFK6mYERERKNyEBVRgh2G9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628585; c=relaxed/simple;
	bh=IL8ftlVCyiThRde54WO4VBaa+vli9Brmh003NPNWL/Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=QUtGNy5HSMgSAFR4ZITe6Hczjr3zT3RBlhZxCf/0lkA/So7fU+4S6kYtysOg69Ft9AgNgw4F+TuXoh2mOIPU/MKg+ttUuMiCnrDraDPAjmm/BF4yfrdsKtVNNGMKze7DBJWvWsP7ZkXimB49pMbhEyFKYtES4Q/bViAQKnobu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnkgFBek; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5196fe87775so3334991e87.3;
        Sat, 20 Apr 2024 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713628581; x=1714233381; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvm98D9S2oAwkEN1/z98FY7laSqwrQffvAkdVqirHeQ=;
        b=HnkgFBekodu0p6wSv/P/WJRnztijw9/hS1PFs23KEYndfYJahAIvtEor8GLAiezsvf
         emISrhZV9cx+NazN/M6YA6CBboK+/sS4WSpAdIAU9nByHo5+MPL7evjnnq0BTbITusQ2
         gdOYS7LFKyrOQ/qe9T0HLcACXjyrxoJrLIOTcEWbkeyYwVQuWDbRYg7k+frZk1MQ2WV1
         TvA4pmAG1d4U6ROwppPVBFz/GXDTGKlUgQxYmmuDmbrslKap9DBrHkz6pmhIOhcUHYG9
         MaCVU7mNbKfhz8IsDXLGPvNEWuHKfFvFM7McEpJ9y9bJGB22aqV7dlf1PJfYLBYtx1Xm
         0uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713628581; x=1714233381;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvm98D9S2oAwkEN1/z98FY7laSqwrQffvAkdVqirHeQ=;
        b=I9YEsB3RSrmFPRzWNGtjX6Him7kINHb9vMPITXMRqrr8mmemDxswgIv+UMWdFDVG26
         m4KmygrWUTkxBo986NnNOCyC1NUrr3Yok6GA+EKEDbEqwCcwi13ktkslyVwZ/Vv5fi3W
         SgMjsJx12LDDJiHO/Pm/pg+ENsr/oPXeW5jER5JMGR5JDEB5O2oQT/EqzJ4M146auYZa
         0XsVjx9QrPZrHoJT4ew5oqwMyPLIcqZ5iTv+XZRPlJ2Rp90VWT612jmAKg1SK/RJb59P
         FjPfF7J49jdVe92replFwt9dSd2M0BjU6wCNPAUz7vbpBLsXnjfx+6cNTgOIzr2G2aUR
         RMbA==
X-Forwarded-Encrypted: i=1; AJvYcCX6F3fJh1Hi3oW3fMU19KTujnV4Frir4p9kNsbpV5Y7aK82m0gLuDu5CnCJi6iQ8Uw9p//Q2+KPpNUbsSRJsqqLjyHH6wYFtTALGH/Nqd6GAcJQKiPtTpAog8bvKC/1kXa6kbPekL9AG/PQNCYx
X-Gm-Message-State: AOJu0Ywh/MzLK3ADfZZguYBKxnsmk12NlmdftASVXsOJjvhH8Cljr0eZ
	KQHyLU/E9Ym58g/LlpW28BsB59tVMGQjfGNHQO2kcucK8WWONDFQ
X-Google-Smtp-Source: AGHT+IED/jB3nLyJLNEQx/JXSBHxcoQL3Bzxtg0TTyw4CbLk+6wIC0f4wFCzlBwCL1ZlE/Gz4EdBog==
X-Received: by 2002:a19:9157:0:b0:51a:b46c:6e67 with SMTP id y23-20020a199157000000b0051ab46c6e67mr3758814lfj.1.1713628581073;
        Sat, 20 Apr 2024 08:56:21 -0700 (PDT)
Received: from [10.67.234.135] ([185.204.1.218])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b005175dab1cfdsm1160703lfr.257.2024.04.20.08.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 08:56:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------edyGg5wGXkIIsLAnqjuMxBjN"
Message-ID: <be7b90cd-c1fc-4e42-85a9-325d7c92c396@gmail.com>
Date: Sat, 20 Apr 2024 17:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: add missing stddef header
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240417161623.37166-1-amer.shanawany@gmail.com>
 <4b66cfb8-5d42-4432-b930-e23482a48dc6@collabora.com>
Content-Language: en-US
From: Amer Al Shanawany <amer.shanawany@gmail.com>
In-Reply-To: <4b66cfb8-5d42-4432-b930-e23482a48dc6@collabora.com>

This is a multi-part message in MIME format.
--------------edyGg5wGXkIIsLAnqjuMxBjN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 18:45, Muhammad Usama Anjum wrote:
> On 4/17/24 9:16 PM, Amer Al Shanawany wrote:
>> fix compiler warning and errors when compiling statmount test.
> The error description or the compiler with version is required to reproduce
> the error easily. I'm unable to reproduce the error by gcc 12 and clang 17.
I'm using gcc 12.3 (Ubuntu 12.3.0-1ubuntu1~22.04), for the error please see the attached log file (statmount.txt)
I was wondering if it's worth adding this include to kselftest.h
>>
>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>> ---
>>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> index 3eafd7da58e2..e6d7c4f1c85b 100644
>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>> @@ -3,6 +3,7 @@
>>  #define _GNU_SOURCE
>>  
>>  #include <assert.h>
>> +#include <stddef.h>
>>  #include <stdint.h>
>>  #include <sched.h>
>>  #include <fcntl.h>
> 

Thanks

Amer
--------------edyGg5wGXkIIsLAnqjuMxBjN
Content-Type: text/plain; charset=UTF-8; name="statmount.txt"
Content-Disposition: attachment; filename="statmount.txt"
Content-Transfer-Encoding: base64

Z2NjIChVYnVudHUgMTIuMy4wLTF1YnVudHUxfjIyLjA0KSAxMi4zLjAKQ29weXJpZ2h0IChD
KSAyMDIyIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLgpUaGlzIGlzIGZyZWUgc29m
dHdhcmU7IHNlZSB0aGUgc291cmNlIGZvciBjb3B5aW5nIGNvbmRpdGlvbnMuICBUaGVyZSBp
cyBOTwp3YXJyYW50eTsgbm90IGV2ZW4gZm9yIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KCm1ha2UgLS1uby1wcmludC1kaXJlY3Rvcnkg
LUMgL2hvbWUvYW1lci9EZXNrdG9wL2xpbnV4LW5leHQgXAotZiAvaG9tZS9hbWVyL0Rlc2t0
b3AvbGludXgtbmV4dC9NYWtlZmlsZSBrc2VsZnRlc3QKc2V0IC1lOyBta2RpciAtcCBpbmNs
dWRlL2dlbmVyYXRlZC91YXBpL2xpbnV4LzsgdHJhcCAicm0gLWYgaW5jbHVkZS9nZW5lcmF0
ZWQvdWFwaS9saW51eC8udG1wX3ZlcnNpb24uaCIgRVhJVDsgeyAJaWYgWyAwIC1ndCAyNTUg
XTsgdGhlbiBlY2hvIFwjZGVmaW5lIExJTlVYX1ZFUlNJT05fQ09ERSAzOTU3NzU7IGVsc2Ug
ZWNobyBcI2RlZmluZSBMSU5VWF9WRVJTSU9OX0NPREUgMzk1NTIwOyBmaTsgZWNobyAnI2Rl
ZmluZSBLRVJORUxfVkVSU0lPTihhLGIsYykgKCgoYSkgPDwgMTYpICsgKChiKSA8PCA4KSAr
ICgoYykgPiAyNTUgPyAyNTUgOiAoYykpKSc7IGVjaG8gXCNkZWZpbmUgTElOVVhfVkVSU0lP
Tl9NQUpPUiA2OyBlY2hvIFwjZGVmaW5lIExJTlVYX1ZFUlNJT05fUEFUQ0hMRVZFTCA5OyBl
Y2hvIFwjZGVmaW5lIExJTlVYX1ZFUlNJT05fU1VCTEVWRUwgMDsgfSA+IGluY2x1ZGUvZ2Vu
ZXJhdGVkL3VhcGkvbGludXgvLnRtcF92ZXJzaW9uLmg7IGlmIFsgISAtciBpbmNsdWRlL2dl
bmVyYXRlZC91YXBpL2xpbnV4L3ZlcnNpb24uaCBdIHx8ICEgY21wIC1zIGluY2x1ZGUvZ2Vu
ZXJhdGVkL3VhcGkvbGludXgvdmVyc2lvbi5oIGluY2x1ZGUvZ2VuZXJhdGVkL3VhcGkvbGlu
dXgvLnRtcF92ZXJzaW9uLmg7IHRoZW4gOiAnICBVUEQgICAgIGluY2x1ZGUvZ2VuZXJhdGVk
L3VhcGkvbGludXgvdmVyc2lvbi5oJzsgbXYgLWYgaW5jbHVkZS9nZW5lcmF0ZWQvdWFwaS9s
aW51eC8udG1wX3ZlcnNpb24uaCBpbmNsdWRlL2dlbmVyYXRlZC91YXBpL2xpbnV4L3ZlcnNp
b24uaDsgZmkKbWFrZSAtZiAuL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQgb2JqPXNjcmlwdHMv
YmFzaWMKbWFrZSAtZiAuL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQgb2JqPXNjcmlwdHMgc2Ny
aXB0cy91bmlmZGVmCm1ha2UgLWYgLi9zY3JpcHRzL01ha2VmaWxlLmFzbS1nZW5lcmljIG9i
aj1hcmNoL3g4Ni9pbmNsdWRlL2dlbmVyYXRlZC91YXBpL2FzbSBcCmdlbmVyaWM9aW5jbHVk
ZS91YXBpL2FzbS1nZW5lcmljCm1ha2UgLWYgLi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkIG9i
aj1hcmNoL3g4Ni9lbnRyeS9zeXNjYWxscyBhbGwKbWFrZSAtZiAuL3NjcmlwdHMvTWFrZWZp
bGUuYnVpbGQgb2JqPWFyY2gveDg2L3Rvb2xzIHJlbG9jcwptYWtlIC1mIC4vc2NyaXB0cy9N
YWtlZmlsZS5oZWFkZXJzaW5zdCBvYmo9aW5jbHVkZS91YXBpCm1ha2UgLWYgLi9zY3JpcHRz
L01ha2VmaWxlLmhlYWRlcnNpbnN0IG9iaj1hcmNoL3g4Ni9pbmNsdWRlL3VhcGkKbWFrZSAt
QyAuL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzIHJ1bl90ZXN0cwptYWtlWzNdOiBFbnRlcmlu
ZyBkaXJlY3RvcnkgJy9ob21lL2FtZXIvRGVza3RvcC9saW51eC1uZXh0L3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL3N0YXRtb3VudCcKZ2NjIC1XYWxsIC1PMiAtZyAt
aXN5c3RlbSAvaG9tZS9hbWVyL0Rlc2t0b3AvbGludXgtbmV4dC91c3IvaW5jbHVkZSAgICAg
c3RhdG1vdW50X3Rlc3QuYyAgLW8gL2hvbWUvYW1lci9EZXNrdG9wL2xpbnV4LW5leHQvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50L3N0YXRtb3VudF90
ZXN0CnN0YXRtb3VudF90ZXN0LmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnN0YXRtb3Vu
dF90ZXN0LmM6NTcyOjI0OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiDigJhvZmZzZXRvZuKAmSBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0K
ICA1NzIgfCAjZGVmaW5lIHN0cl9vZmYobWVtYikgKG9mZnNldG9mKHN0cnVjdCBzdGF0bW91
bnQsIG1lbWIpIC8gc2l6ZW9mKHVpbnQzMl90KSkKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+CnN0YXRtb3VudF90ZXN0LmM6NTk4OjUxOiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8g4oCYc3RyX29mZuKAmQogIDU5OCB8ICAgICAgICAgdGVzdF9zdGF0
bW91bnRfc3RyaW5nKFNUQVRNT1VOVF9NTlRfUk9PVCwgc3RyX29mZihtbnRfcm9vdCksICJt
b3VudCByb290Iik7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+CnN0YXRtb3VudF90ZXN0LmM6MTg6MTogbm90ZTog
4oCYb2Zmc2V0b2bigJkgaXMgZGVmaW5lZCBpbiBoZWFkZXIg4oCYPHN0ZGRlZi5oPuKAmTsg
ZGlkIHlvdSBmb3JnZXQgdG8g4oCYI2luY2x1ZGUgPHN0ZGRlZi5oPuKAmT8KICAgMTcgfCAj
aW5jbHVkZSAiLi4vLi4va3NlbGZ0ZXN0LmgiCiAgKysrIHwrI2luY2x1ZGUgPHN0ZGRlZi5o
PgogICAxOCB8IApzdGF0bW91bnRfdGVzdC5jOjU3MjozMzogZXJyb3I6IGV4cGVjdGVkIGV4
cHJlc3Npb24gYmVmb3JlIOKAmHN0cnVjdOKAmQogIDU3MiB8ICNkZWZpbmUgc3RyX29mZiht
ZW1iKSAob2Zmc2V0b2Yoc3RydWN0IHN0YXRtb3VudCwgbWVtYikgLyBzaXplb2YodWludDMy
X3QpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+CnN0
YXRtb3VudF90ZXN0LmM6NTk4OjUxOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCY
c3RyX29mZuKAmQogIDU5OCB8ICAgICAgICAgdGVzdF9zdGF0bW91bnRfc3RyaW5nKFNUQVRN
T1VOVF9NTlRfUk9PVCwgc3RyX29mZihtbnRfcm9vdCksICJtb3VudCByb290Iik7CiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+CnN0YXRtb3VudF90ZXN0LmM6NTcyOjMzOiBlcnJvcjogZXhwZWN0ZWQgZXhwcmVz
c2lvbiBiZWZvcmUg4oCYc3RydWN04oCZCiAgNTcyIHwgI2RlZmluZSBzdHJfb2ZmKG1lbWIp
IChvZmZzZXRvZihzdHJ1Y3Qgc3RhdG1vdW50LCBtZW1iKSAvIHNpemVvZih1aW50MzJfdCkp
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4Kc3RhdG1v
dW50X3Rlc3QuYzo1OTk6NTI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhzdHJf
b2Zm4oCZCiAgNTk5IHwgICAgICAgICB0ZXN0X3N0YXRtb3VudF9zdHJpbmcoU1RBVE1PVU5U
X01OVF9QT0lOVCwgc3RyX29mZihtbnRfcG9pbnQpLCAibW91bnQgcG9pbnQiKTsKICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+CnN0YXRtb3VudF90ZXN0LmM6NTcyOjMzOiBlcnJvcjogZXhwZWN0ZWQgZXhwcmVz
c2lvbiBiZWZvcmUg4oCYc3RydWN04oCZCiAgNTcyIHwgI2RlZmluZSBzdHJfb2ZmKG1lbWIp
IChvZmZzZXRvZihzdHJ1Y3Qgc3RhdG1vdW50LCBtZW1iKSAvIHNpemVvZih1aW50MzJfdCkp
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4Kc3RhdG1v
dW50X3Rlc3QuYzo2MDA6NTA6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhzdHJf
b2Zm4oCZCiAgNjAwIHwgICAgICAgICB0ZXN0X3N0YXRtb3VudF9zdHJpbmcoU1RBVE1PVU5U
X0ZTX1RZUEUsIHN0cl9vZmYoZnNfdHlwZSksICJmcyB0eXBlIik7CiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4Kc3Rh
dG1vdW50X3Rlc3QuYzo1NzI6MzM6IGVycm9yOiBleHBlY3RlZCBleHByZXNzaW9uIGJlZm9y
ZSDigJhzdHJ1Y3TigJkKICA1NzIgfCAjZGVmaW5lIHN0cl9vZmYobWVtYikgKG9mZnNldG9m
KHN0cnVjdCBzdGF0bW91bnQsIG1lbWIpIC8gc2l6ZW9mKHVpbnQzMl90KSkKICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgpzdGF0bW91bnRfdGVzdC5j
OjYwMTo0MTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmHN0cl9vZmbigJkKICA2
MDEgfCAgICAgICAgIHRlc3Rfc3RhdG1vdW50X3N0cmluZyhhbGxfbWFzaywgc3RyX29mZiht
bnRfcm9vdCksICJtb3VudCByb290ICYgYWxsIik7CiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4Kc3RhdG1vdW50X3Rlc3QuYzo1NzI6
MzM6IGVycm9yOiBleHBlY3RlZCBleHByZXNzaW9uIGJlZm9yZSDigJhzdHJ1Y3TigJkKICA1
NzIgfCAjZGVmaW5lIHN0cl9vZmYobWVtYikgKG9mZnNldG9mKHN0cnVjdCBzdGF0bW91bnQs
IG1lbWIpIC8gc2l6ZW9mKHVpbnQzMl90KSkKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fgpzdGF0bW91bnRfdGVzdC5jOjYwMjo0MTogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvIOKAmHN0cl9vZmbigJkKICA2MDIgfCAgICAgICAgIHRlc3Rf
c3RhdG1vdW50X3N0cmluZyhhbGxfbWFzaywgc3RyX29mZihtbnRfcG9pbnQpLCAibW91bnQg
cG9pbnQgJiBhbGwiKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fgpzdGF0bW91bnRfdGVzdC5jOjU3MjozMzogZXJyb3I6IGV4cGVj
dGVkIGV4cHJlc3Npb24gYmVmb3JlIOKAmHN0cnVjdOKAmQogIDU3MiB8ICNkZWZpbmUgc3Ry
X29mZihtZW1iKSAob2Zmc2V0b2Yoc3RydWN0IHN0YXRtb3VudCwgbWVtYikgLyBzaXplb2Yo
dWludDMyX3QpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+CnN0YXRtb3VudF90ZXN0LmM6NjAzOjQxOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8g4oCYc3RyX29mZuKAmQogIDYwMyB8ICAgICAgICAgdGVzdF9zdGF0bW91bnRfc3RyaW5n
KGFsbF9tYXNrLCBzdHJfb2ZmKGZzX3R5cGUpLCAiZnMgdHlwZSAmIGFsbCIpOwogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+CnN0YXRt
b3VudF90ZXN0LmM6IEluIGZ1bmN0aW9uIOKAmGNsZWFudXBfbmFtZXNwYWNl4oCZOgpzdGF0
bW91bnRfdGVzdC5jOjEyNzo5OiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2Yg
4oCYZmNoZGly4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdhcm5fdW51c2VkX3Jl
c3VsdOKAmSBbLVd1bnVzZWQtcmVzdWx0XQogIDEyNyB8ICAgICAgICAgZmNoZGlyKG9yaWdf
cm9vdCk7CiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgpzdGF0bW91bnRfdGVz
dC5jOjEyODo5OiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2Yg4oCYY2hyb290
4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdhcm5fdW51c2VkX3Jlc3VsdOKAmSBb
LVd1bnVzZWQtcmVzdWx0XQogIDEyOCB8ICAgICAgICAgY2hyb290KCIuIik7CiAgICAgIHwg
ICAgICAgICBefn5+fn5+fn5+fgptYWtlWzNdOiAqKiogWy4uLy4uL2xpYi5tazoyMDM6IC9o
b21lL2FtZXIvRGVza3RvcC9saW51eC1uZXh0L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Zp
bGVzeXN0ZW1zL3N0YXRtb3VudC9zdGF0bW91bnRfdGVzdF0gRXJyb3IgMQptYWtlWzNdOiBM
ZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvYW1lci9EZXNrdG9wL2xpbnV4LW5leHQvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50JwptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjE5MTogYWxsXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbL2hvbWUvYW1lci9E
ZXNrdG9wL2xpbnV4LW5leHQvTWFrZWZpbGU6MTM3MDoga3NlbGZ0ZXN0XSBFcnJvciAyCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MjQwOiBfX3N1Yi1tYWtlXSBFcnJvciAyCg==

--------------edyGg5wGXkIIsLAnqjuMxBjN--

