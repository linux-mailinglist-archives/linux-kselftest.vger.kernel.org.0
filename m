Return-Path: <linux-kselftest+bounces-44452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1DC2239F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E21189F6EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936C34D3BF;
	Thu, 30 Oct 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NOOqTHC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027634D3B5
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855812; cv=none; b=pOYuLWwCCUvn8EKBsHizXLB1g+Ttx4f9d9xkqGa+eUvSV+JeTaf1RH4SWjSYc+MS6NrCL9ufKSrErJrA79zv/vLeQgV2PX6kJNR8u8GQ/ZaXzVHHS9BAPUkE/f1asVfDa67yHFgXwOsaR5y1nH/NtFkzp3YRdWcokcSrvNcfx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855812; c=relaxed/simple;
	bh=MlzJ5B6r0+3j4EPXrXbwqf6T0HUfZ5wJXo6viDfH6H8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=uwYV3eWZQ30W/ojbIYvqBwO8CSDULBfLxsEcYMMtcgLLgXlv0fh0UCVNGfTgGZMXS7KbVcNlPnusvFHtR2wwCbvRVYfmBzwJQeWBwtHEyNACDGZ4eNZWRk4b/aR1WDZq13fz9026uCCvWgsHbrbwVo7hbKgnaeULeyslBW42dXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NOOqTHC4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-945a5731dd3so59329439f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761855809; x=1762460609; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPfJcPgVpU5VuT4Jc6pVlOvtjh3aFfucJllUlD13XuY=;
        b=NOOqTHC4blVraFivTlme3iihTFxloK4XaGVO5mQhi/CzH2AO+XOf7GIddLGfqVY6KV
         pWE1UCSHgDhar1DBueRBMNwHE/dX7d5e4l89Y12K5j5J6ZHW8/Ak7/dyi2gNXw+DjBgX
         SD/DTOtRLTLuOLMhgirGRdtfIkxBqmlZ1NuXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855809; x=1762460609;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPfJcPgVpU5VuT4Jc6pVlOvtjh3aFfucJllUlD13XuY=;
        b=iR/gOmuwrxlZmVt+2u3WSUzSc9echp7LwbuU4H8KapW/AENXpubZOxaInl+pqqujDv
         JBD/ApL9MwWoDLJBOI3Ma7wn47CYlFiPaUX3EiwgSEUHfGEKm6CqNuB9YfMj+7qeOABW
         4mjSNsBAoEzgI3yq1dLA9LpsjVr90lZhljRTOaBZtaRug4RuhGH+0hC9rVf+KhlBlE5L
         k2Z9RiOlIW7rruMi3NpftkwFmJRc4AAjDO2jt/gzuYhGZAGbpGCw3tQJ/EQXs5OJTVM4
         0RBdnIVvKCWkJwDq/DJH3oANRVVUsvibd8jIUnEEqK8deCdWuhRH++JkTlX+tlh+tF15
         kj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXccmiycD8NRiwBBZWLSxEm7XqHR3PMTMBQAKGvWa/zpTGitl2cv01P+NJ/S3kpyWaSyzJZG8DvNI/tVJ2dcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNmn868TSyq/n89O3xAKZlwXk0aqHdKQ/LxbZhCpwkrybSJJ1
	KuXT2bX7oiTzXdbnZSXuPZpnwNqN3cXfmyx4kMcD9wGKSPJasd17HBNTSt3Ndu6TA/A=
X-Gm-Gg: ASbGnctJHCe8bleI0YEeYa4IxLw6nYR15nK5xHVi89XCr6lTBLLqaGK9tK+Fb0FK2EW
	lXZ7Q7rb49LO6YD8elSRN+4Rrda+KGnwmonFTIEIEiYvkRbB42/i2aUv97g7PVRXmr2He6DM2hc
	REBr8k+haAl13HzhT7v59ln3yEdAnRO2rHFgBOK/SCsu12ypq9JtEauy4B3VS1l7LCeaEyApJo3
	K/XG/1pyvUIR5nayXFHE8XU7GUxZUvC349vByQLgM3suvTOHQuvMDec5m4P2/CZ6OlLBkZONnXq
	Mf2Vx/xSWX94skggNuWqWJr0h+XFaC4KVs6btti9+qOQknn4HA5cCumPRpbJjEHWbrNoG44R9Si
	Q1IsaYtAvL3qE31DhhrFV5OOUXIoTQUWCTynvcmBWW3UoFU46p8tN75OHN4nM9BnOnyV5KzailY
	Sk9BghuRvknXK1RWR/fGkGzi0=
X-Google-Smtp-Source: AGHT+IE7nybp/8OgjNb43kcoVp8ksbIRECKRfLtgfo000BMqyTFoQfCDVvVH8ISq3Zcey7+THyElgQ==
X-Received: by 2002:a05:6e02:258c:b0:430:c49d:750c with SMTP id e9e14a558f8ab-4330d1f9b6amr18083705ab.27.1761855809011;
        Thu, 30 Oct 2025 13:23:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67f8d3asm71621555ab.16.2025.10.30.13.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:23:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rws6wvEiGuY1FVZAV4mDVEMh"
Message-ID: <b5aa8141-b80d-487b-b3e9-fea244e69ca8@linuxfoundation.org>
Date: Thu, 30 Oct 2025 14:23:27 -0600
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
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 raemoar63@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit fixes update for Linux 6.18-rc4

This is a multi-part message in MIME format.
--------------rws6wvEiGuY1FVZAV4mDVEMh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit fixes update for Linux 6.18-rc4.

Fixes log overwrite in param_tests and fixes incorrect cast of priv
pointer in test_dev_action(). Updates email address for Rae Moar in
MAINTAINERS KUnit entry.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.18-rc4

for you to fetch changes up to f3903ec76ae6afcdba0347681d1dda005fb145cd:

   MAINTAINERS: Update KUnit email address for Rae Moar (2025-10-29 14:57:54 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.18-rc4

Fixes log overwrite in param_tests and fixes incorrect cast of priv
pointer in test_dev_action(). Updates email address for Rae Moar in
MAINTAINERS KUnit entry.

----------------------------------------------------------------
Carlos Llamas (1):
       kunit: prevent log overwrite in param_tests

Florian Schmaus (1):
       kunit: test_dev_action: Correctly cast 'priv' pointer to long*

Rae Moar (1):
       MAINTAINERS: Update KUnit email address for Rae Moar

  .mailmap               | 1 +
  MAINTAINERS            | 2 +-
  lib/kunit/kunit-test.c | 2 +-
  lib/kunit/test.c       | 3 ++-
  4 files changed, 5 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------rws6wvEiGuY1FVZAV4mDVEMh
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.18-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.18-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhLy5tYWlsbWFwIGIvLm1haWxtYXAKaW5kZXggZDJlZGQyNTZiMTlkLi4y
ZmNmN2U0YTVjZmQgMTAwNjQ0Ci0tLSBhLy5tYWlsbWFwCisrKyBiLy5tYWlsbWFwCkBAIC02
NDIsNiArNjQyLDcgQEAgUWFpcyBZb3VzZWYgPHF5b3VzZWZAbGF5YWxpbmEuaW8+IDxxYWlz
LnlvdXNlZkBhcm0uY29tPgogUXVlbnRpbiBNb25uZXQgPHFtb0BrZXJuZWwub3JnPiA8cXVl
bnRpbi5tb25uZXRAbmV0cm9ub21lLmNvbT4KIFF1ZW50aW4gTW9ubmV0IDxxbW9Aa2VybmVs
Lm9yZz4gPHF1ZW50aW5AaXNvdmFsZW50LmNvbT4KIFF1ZW50aW4gUGVycmV0IDxxcGVycmV0
QHFwZXJyZXQubmV0PiA8cXVlbnRpbi5wZXJyZXRAYXJtLmNvbT4KK1JhZSBNb2FyIDxyYWVt
b2FyNjNAZ21haWwuY29tPiA8cm1vYXJAZ29vZ2xlLmNvbT4KIFJhZmFlbCBKLiBXeXNvY2tp
IDxyandAcmp3eXNvY2tpLm5ldD4gPHJqd0BzaXNrLnBsPgogUmFqZWV2IE5hbmRhbiA8cXVp
Y19yYWplZXZueUBxdWljaW5jLmNvbT4gPHJhamVldm55QGNvZGVhdXJvcmEub3JnPgogUmFq
ZW5kcmEgTmF5YWsgPHF1aWNfcmplbmRyYUBxdWljaW5jLmNvbT4gPHJuYXlha0Bjb2RlYXVy
b3JhLm9yZz4KZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXgg
NDYxMjZjZTJmOTY4Li5lZWZjZmY5OTA5ODcgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisr
KyBiL01BSU5UQUlORVJTCkBAIC0xMzYwMSw3ICsxMzYwMSw3IEBAIEY6CWZzL3NtYi9zZXJ2
ZXIvCiBLRVJORUwgVU5JVCBURVNUSU5HIEZSQU1FV09SSyAoS1VuaXQpCiBNOglCcmVuZGFu
IEhpZ2dpbnMgPGJyZW5kYW4uaGlnZ2luc0BsaW51eC5kZXY+CiBNOglEYXZpZCBHb3cgPGRh
dmlkZ293QGdvb2dsZS5jb20+Ci1SOglSYWUgTW9hciA8cm1vYXJAZ29vZ2xlLmNvbT4KK1I6
CVJhZSBNb2FyIDxyYWVtb2FyNjNAZ21haWwuY29tPgogTDoJbGludXgta3NlbGZ0ZXN0QHZn
ZXIua2VybmVsLm9yZwogTDoJa3VuaXQtZGV2QGdvb2dsZWdyb3Vwcy5jb20KIFM6CU1haW50
YWluZWQKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMgYi9saWIva3VuaXQv
a3VuaXQtdGVzdC5jCmluZGV4IDhjMDFlYWJkNGVhZi4uNjMxMzBhNDhlMjM3IDEwMDY0NAot
LS0gYS9saWIva3VuaXQva3VuaXQtdGVzdC5jCisrKyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0
LmMKQEAgLTczOSw3ICs3MzksNyBAQCBzdGF0aWMgc3RydWN0IGt1bml0X2Nhc2Uga3VuaXRf
Y3VycmVudF90ZXN0X2Nhc2VzW10gPSB7CiAKIHN0YXRpYyB2b2lkIHRlc3RfZGV2X2FjdGlv
bih2b2lkICpwcml2KQogewotCSoodm9pZCAqKilwcml2ID0gKHZvaWQgKikxOworCSoobG9u
ZyAqKXByaXYgPSAxOwogfQogCiBzdGF0aWMgdm9pZCBrdW5pdF9kZXZpY2VfdGVzdChzdHJ1
Y3Qga3VuaXQgKnRlc3QpCmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVzdC5jIGIvbGliL2t1
bml0L3Rlc3QuYwppbmRleCBiYjY2ZWExYTNlYWMuLjYyZWI1Mjk4MjRjNiAxMDA2NDQKLS0t
IGEvbGliL2t1bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5jCkBAIC03NDUsNyAr
NzQ1LDggQEAgaW50IGt1bml0X3J1bl90ZXN0cyhzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRl
KQogCQkJCQkucGFyYW1faW5kZXggPSArK3Rlc3QucGFyYW1faW5kZXgsCiAJCQkJCS5wYXJl
bnQgPSAmdGVzdCwKIAkJCQl9OwotCQkJCWt1bml0X2luaXRfdGVzdCgmcGFyYW1fdGVzdCwg
dGVzdF9jYXNlLT5uYW1lLCB0ZXN0X2Nhc2UtPmxvZyk7CisJCQkJa3VuaXRfaW5pdF90ZXN0
KCZwYXJhbV90ZXN0LCB0ZXN0X2Nhc2UtPm5hbWUsIE5VTEwpOworCQkJCXBhcmFtX3Rlc3Qu
bG9nID0gdGVzdF9jYXNlLT5sb2c7CiAJCQkJa3VuaXRfcnVuX2Nhc2VfY2F0Y2hfZXJyb3Jz
KHN1aXRlLCB0ZXN0X2Nhc2UsICZwYXJhbV90ZXN0KTsKIAogCQkJCWlmIChwYXJhbV9kZXNj
WzBdID09ICdcMCcpIHsK

--------------rws6wvEiGuY1FVZAV4mDVEMh--

