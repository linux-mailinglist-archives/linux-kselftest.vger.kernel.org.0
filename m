Return-Path: <linux-kselftest+bounces-47753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849FCD2AB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 09:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3097302488E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2912F747D;
	Sat, 20 Dec 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OOEsFKAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D422F7AD8
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766220050; cv=none; b=evlWX27y35uuw1C5rbMQhb70SvSoMGWdJk6yae+WE/+yAQ04Vkv4ODO/xwwwaN+qTfEfqFw1fEcI39Sj2+XuIUAHeeVDIsUVjmRa2fZ+V4/zmFWUs+EbB8ahL+6zRNIk9vOXqt2IdJPPxqGydniDJ4TlWX7HcZF3RNP3bL95hM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766220050; c=relaxed/simple;
	bh=FRajVEDUh8gEqx43aId0ua5mBbesxkPl+wr1C72PJnk=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=CHK8GCjHKndTInCz1HFY0YaddjOi9LoHO6W2qp28mkmk/ICHOobgJ3NYXGqehUSE0V+hGXrkmDOz2kaCkYtJGkOQ4xr/AsCHO5Mfcg1F0SmpTNukDiENPSTJMyQ6Ua3R2pjSjpbrsg6sU/ImeC1KpNhmbJYhFl5gb6qt259m6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OOEsFKAY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34b75fba315so2883214a91.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 00:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1766220048; x=1766824848; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=19E4hJzzPqMJlZnl8+tE9HPkC41N9egwC+Aclj4CIFg=;
        b=OOEsFKAYQTrB5/5WvW1daKbt69T/Kc+z6qYJKhkHvRksFiXqWST8Usb1PHXaSm0/WW
         F+Mz/v4g8HH4DDrWDY64ctKYfzssRrwo+ls1HkEefcZqK0PpWmalAZ8dfV87leAWW93n
         PGgNh2rmELP21QpOIr+S6d+t4OTk0ys3fjwJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766220048; x=1766824848;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19E4hJzzPqMJlZnl8+tE9HPkC41N9egwC+Aclj4CIFg=;
        b=moV+uw7qWCZjO48aFHMNk5pCCHLq0SRm7CrcwxushKkBQOQJ5nJNHI+GuUCCpOZ2IV
         ifeIpdquyEzPnZnRk0JkxlK1YrjFyWhs6fl7k9cFHKJkXZ6cb4hgNXZrzzOCVZJr+H9h
         rhpx20zk5V2lwvDAhT+9uDlmQ7gQA8hjyGkE+73e+XfvKt3XW6UIaGXXCK6uJjlfSlak
         heM9UcyYqPYU/HnqJ3UkCbU5lk4zXXtnfkeXTqxUwmgD7RwIGf1+PJQJMrqGXDt3fgk8
         XZBTLpLkfrAyOfEZ2zkPTm/DLYCvfIkNpP3Dlwo4mJl+EfwYwCZFuwVNXfk6PHZ2161Z
         Ih7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqPdw9Oj8POSiJAMbFYdPPSOrCel6r79g5ftHcet/k8sjR9ZXhQK5h9FyrA5gdUHI3iOm2ouD0+yo29Kh0HPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIugZtmFj4XQVIIAAARrEGYuF4pKWHUsan2EQTAqEcRhcPGVdI
	eLaYdSh1nRvSlZ9Ab/KCFnAh/l+5hA4qivpd96F1PjTjpXNdOcPyFAn+zYgnVHf3Hdo=
X-Gm-Gg: AY/fxX7SgyyJGafM3z72QmWiBbxoRVJY/GG5yF7J5ui7QTOcs1rqacKO4ajVzewq7I1
	gMXhj3VW+oy24yfb41LoUyBTLVs9sb3BnDiT/uCRO+t7AUjyhZu53M9u0979MwwXP0sUhc0fHOj
	+BsKwX6QdUnHE/iALhKi0/RTF4Lz53JCHKjNUO1GgIDNn4cvr7INlUDsUdKWuuTJKd55a+DKZLa
	1xgIgEHxS9+ZVjUoU9eVM6IEISImd20ZLeHnfBxOh8i6Vxq4oFTM6BYdQkQWXoVAXrLXAXQHWQP
	qHHPh3iMnOSeHsY9uFwmC5JKDvyn0xWABmSaZScNdBExBA6xAX41+5xSoXAsKgEa/McY2WcuOus
	DJM8w2JzWU66xNBxDaibA+NfIMxYyYwrGyUG0TPXvOAdfEJUOWODw0RR2i2k972EqjyyxIYE6YO
	30XrNt+Vw+Qi/1/24cm005ifk=
X-Google-Smtp-Source: AGHT+IEWUB8CmiA1fAJFEhS3V7KuZ3t4LRPHOTq1d/ZaNau+5Zq304VYSMPDeqvRgh5XKXjte+Ddyg==
X-Received: by 2002:a17:90b:2f47:b0:340:ad5e:c3 with SMTP id 98e67ed59e1d1-34e9212a474mr4517134a91.1.1766220047693;
        Sat, 20 Dec 2025 00:40:47 -0800 (PST)
Received: from [10.100.14.146] ([58.84.225.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm4595615b3a.45.2025.12.20.00.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Dec 2025 00:40:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------maHtP0Fa1s3WL54oYYMQRISe"
Message-ID: <11a7c86a-459d-46c2-bfe5-9237fb586584@linuxfoundation.org>
Date: Sat, 20 Dec 2025 01:40:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit fixes update for Linux 6.19-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, raemoar63@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------maHtP0Fa1s3WL54oYYMQRISe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following fixes update for Linux 6.19-rc3.

Drops unused parameter from kunit_device_register_internal and makes
FAULT_TEST default to n when PANIC_ON_OOPS.

Note: Sending this early for 6.19-rc3 (way too late for rc2 anyways)

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.19-rc3

for you to fetch changes up to c33b68801fbe9d5ee8a9178beb5747ec65873530:

   kunit: make FAULT_TEST default to n when PANIC_ON_OOPS (2025-12-15 09:27:19 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.19-rc3

Drops unused parameter from kunit_device_register_internal and makes
FAULT_TEST default to n when PANIC_ON_OOPS.

----------------------------------------------------------------
Brendan Jackman (1):
       kunit: make FAULT_TEST default to n when PANIC_ON_OOPS

Uwe Kleine-König (1):
       kunit: Drop unused parameter from kunit_device_register_internal

  lib/kunit/Kconfig  | 2 +-
  lib/kunit/device.c | 7 +++----
  2 files changed, 4 insertions(+), 5 deletions(-)
----------------------------------------------------------------
--------------maHtP0Fa1s3WL54oYYMQRISe
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.19-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.19-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9LY29uZmlnIGIvbGliL2t1bml0L0tjb25maWcKaW5k
ZXggNTBlY2Y1NWQyYjljLi40OThjYzUxZTQ5M2QgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9L
Y29uZmlnCisrKyBiL2xpYi9rdW5pdC9LY29uZmlnCkBAIC0yOCw3ICsyOCw3IEBAIGNvbmZp
ZyBLVU5JVF9GQVVMVF9URVNUCiAJYm9vbCAiRW5hYmxlIEtVbml0IHRlc3RzIHdoaWNoIHBy
aW50IEJVRyBzdGFja3RyYWNlcyIKIAlkZXBlbmRzIG9uIEtVTklUX1RFU1QKIAlkZXBlbmRz
IG9uICFVTUwKLQlkZWZhdWx0IHkKKwlkZWZhdWx0ICFQQU5JQ19PTl9PT1BTCiAJaGVscAog
CSAgRW5hYmxlcyBmYXVsdCBoYW5kbGluZyB0ZXN0cyBmb3IgdGhlIEtVbml0IGZyYW1ld29y
ay4gVGhlc2UgdGVzdHMgbWF5CiAJICB0cmlnZ2VyIGEga2VybmVsIEJVRygpLCBhbmQgdGhl
IGFzc29jaWF0ZWQgc3RhY2sgdHJhY2UsIGV2ZW4gd2hlbiB0aGV5CmRpZmYgLS1naXQgYS9s
aWIva3VuaXQvZGV2aWNlLmMgYi9saWIva3VuaXQvZGV2aWNlLmMKaW5kZXggNTIwYzFmY2Nl
ZThhLi5mMjAxYWFhY2Q0Y2YgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9kZXZpY2UuYworKysg
Yi9saWIva3VuaXQvZGV2aWNlLmMKQEAgLTEwNiw4ICsxMDYsNyBAQCBFWFBPUlRfU1lNQk9M
X0dQTChrdW5pdF9kcml2ZXJfY3JlYXRlKTsKIAogLyogSGVscGVyIHdoaWNoIGNyZWF0ZXMg
YSBrdW5pdF9kZXZpY2UsIGF0dGFjaGVzIGl0IHRvIHRoZSBrdW5pdF9idXMqLwogc3RhdGlj
IHN0cnVjdCBrdW5pdF9kZXZpY2UgKmt1bml0X2RldmljZV9yZWdpc3Rlcl9pbnRlcm5hbChz
dHJ1Y3Qga3VuaXQgKnRlc3QsCi0JCQkJCQkJICAgY29uc3QgY2hhciAqbmFtZSwKLQkJCQkJ
CQkgICBjb25zdCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KQorCQkJCQkJCSAgIGNvbnN0
IGNoYXIgKm5hbWUpCiB7CiAJc3RydWN0IGt1bml0X2RldmljZSAqa3VuaXRfZGV2OwogCWlu
dCBlcnIgPSAtRU5PTUVNOwpAQCAtMTUwLDcgKzE0OSw3IEBAIHN0cnVjdCBkZXZpY2UgKmt1
bml0X2RldmljZV9yZWdpc3Rlcl93aXRoX2RyaXZlcihzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAJ
CQkJCQkgY29uc3QgY2hhciAqbmFtZSwKIAkJCQkJCSBjb25zdCBzdHJ1Y3QgZGV2aWNlX2Ry
aXZlciAqZHJ2KQogewotCXN0cnVjdCBrdW5pdF9kZXZpY2UgKmt1bml0X2RldiA9IGt1bml0
X2RldmljZV9yZWdpc3Rlcl9pbnRlcm5hbCh0ZXN0LCBuYW1lLCBkcnYpOworCXN0cnVjdCBr
dW5pdF9kZXZpY2UgKmt1bml0X2RldiA9IGt1bml0X2RldmljZV9yZWdpc3Rlcl9pbnRlcm5h
bCh0ZXN0LCBuYW1lKTsKIAogCWlmIChJU19FUlJfT1JfTlVMTChrdW5pdF9kZXYpKQogCQly
ZXR1cm4gRVJSX0NBU1Qoa3VuaXRfZGV2KTsKQEAgLTE3Miw3ICsxNzEsNyBAQCBzdHJ1Y3Qg
ZGV2aWNlICprdW5pdF9kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25z
dCBjaGFyICpuYW1lKQogCWlmIChJU19FUlIoZHJ2KSkKIAkJcmV0dXJuIEVSUl9DQVNUKGRy
dik7CiAKLQlkZXYgPSBrdW5pdF9kZXZpY2VfcmVnaXN0ZXJfaW50ZXJuYWwodGVzdCwgbmFt
ZSwgZHJ2KTsKKwlkZXYgPSBrdW5pdF9kZXZpY2VfcmVnaXN0ZXJfaW50ZXJuYWwodGVzdCwg
bmFtZSk7CiAJaWYgKElTX0VSUihkZXYpKSB7CiAJCWt1bml0X3JlbGVhc2VfYWN0aW9uKHRl
c3QsIGRyaXZlcl91bnJlZ2lzdGVyX3dyYXBwZXIsICh2b2lkICopZHJ2KTsKIAkJcmV0dXJu
IEVSUl9DQVNUKGRldik7Cg==

--------------maHtP0Fa1s3WL54oYYMQRISe--

