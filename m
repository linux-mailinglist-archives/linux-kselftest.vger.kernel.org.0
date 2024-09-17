Return-Path: <linux-kselftest+bounces-18061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46397AA43
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB23B20F9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559712B73;
	Tue, 17 Sep 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Om2BL8GQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B8EAD8
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726537392; cv=none; b=jT2Y9LGRSm85WGJ4oLDIxhepWeisH6mAnXfRAWoKI+OkWxHNBCmwEZu4I4okvIWtjMVHBAITVR08Fo2fJ9QVFzWhEROZEVJ6jBhPvCrgcM1fDoCee4kKEl2Ny5KXSK8VNlU/jdv+4ALy42Qa0/Sq/CqRpXI0jbtVrEMTSR+WdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726537392; c=relaxed/simple;
	bh=SFcWc1WmbX0vO/W+lgo9m6RoHifIehMnmRS68bx09Xw=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=b/SVhhO3aCh4tqnq007E/EC9D1vjqrMdjcWgJsgQvaSH0CpdYGjIDzWkU1QQ2e2qv7HPH1vGqFqBiQSAmbjswPfSn4zABDTzuFApKlVndjPox1UbN9civM55LLXi/8akInBdypkSjB0uP4Aq8yBdv+jy7S/WaN96qr8UwOOI7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Om2BL8GQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-711009878e2so1932440a34.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726537388; x=1727142188; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fguZJhGgPHETd4UiqrKTvBlbZG1+BZyjNBt8fALpw+g=;
        b=Om2BL8GQVtJXg1P7vCWBnfPHKJdPEYPl4DPVGLIclotiZOFpE7rL78K4m11aCjNblQ
         ke8HtIY83xEb2tYhLadvtyJhm1UngbH1Vllk+B0Z7w8PDtB8n5jB3bJ/707oad5AwVUt
         4yjz2+pXEwWT2jpe/1v+q1FlcQjbPvbP3FK8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726537388; x=1727142188;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fguZJhGgPHETd4UiqrKTvBlbZG1+BZyjNBt8fALpw+g=;
        b=SLscj21hUrK8OFfpmcGQ0GFcG34+UdOqptsngllHONC/kHd5+aVsEz8zpz+YuWi9JB
         +UH4v/dmVwXSiSpw4ZPM3utMVwyWYZhbxcJlBP4cbnbDpa7Ms+yAt4Gp35eDOOmSiOq1
         Fd12Arrxz2NWSWKpKuWNu8PfZmQJZRRe1+kua4e9oA8M32mQjKHy/uRLZ2rkbTkL7ZMA
         TsBrn4+XTb9Yny7WDcVw32ynGLHp3h2CK7BFrfAacS9+J4I3zmTGVipeR/7bZyj7XJa0
         +fejYHpxyfHSEPPVlvPqkIql0I0DlI5LmsM4BephMoZIROCai31ja1jApfxtOD5JI+ri
         7fdA==
X-Forwarded-Encrypted: i=1; AJvYcCWRQ0iap1uFhLHISUhoopt9zF5L2UgxrSgOzfguPUxk16w42k6Q12lm+dWmvmThjZbQeNckLfPOb7Ou215zZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUR6L9kTj2mwwy+w5QilRD3OY16P3p+yICfZGZ1GUAkihq+9HU
	XkEsvQlA0Vn48TO8jH7dNQ4tQKod2a5LLxwqH8NhCyhi0aaDWu6ZPkd3BKKj/Gk=
X-Google-Smtp-Source: AGHT+IEEUnMOyB/lW4B8UcljdY9G+v154ZdnfUO4v2IbzyZjNWYuJkF11G5lPkla6TTfxLauI0Oeow==
X-Received: by 2002:a05:6830:3693:b0:710:efd5:f467 with SMTP id 46e09a7af769-711095729b1mr10863572a34.29.1726537387915;
        Mon, 16 Sep 2024 18:43:07 -0700 (PDT)
Received: from [172.20.0.160] ([50.202.43.9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71239ece57asm1349778a34.41.2024.09.16.18.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 18:43:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------lDmTx2uXH530aimSr6U5KQT6"
Message-ID: <fec42732-fc6b-4025-8326-38cb8157057c@linuxfoundation.org>
Date: Mon, 16 Sep 2024 19:43:05 -0600
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 6.12-rc1

This is a multi-part message in MIME format.
--------------lDmTx2uXH530aimSr6U5KQT6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit update for Linux 6.12-rc1.

This kunit update for Linux 6.12-rc1 consists of:

-- a new int_pow test suite
-- documentation update to clarify filename best practices
-- kernel-doc fix for EXPORT_SYMBOL_IF_KUNIT
-- change to build compile_commands.json automatically instead
    of requiring a manual build.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.12-rc1

for you to fetch changes up to 7fcc9b53216cd87f73cc6dbb404220350ddc93b8:

   lib/math: Add int_pow test suite (2024-09-12 10:03:00 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-6.12-rc1

This kunit update for Linux 6.12-rc1 consists of:

-- a new int_pow test suite
-- documentation update to clarify filename best practices
-- kernel-doc fix for EXPORT_SYMBOL_IF_KUNIT
-- change to build compile_commands.json automatically instead
    of requiring a manual build.

----------------------------------------------------------------
Brendan Jackman (1):
       kunit: tool: Build compile_commands.json

Kees Cook (1):
       Documentation: KUnit: Update filename best practices

Luis Felipe Hernandez (1):
       lib/math: Add int_pow test suite

Michal Wajdeczko (1):
       kunit: Fix kernel-doc for EXPORT_SYMBOL_IF_KUNIT

  Documentation/dev-tools/kunit/style.rst | 29 ++++++++++++------
  include/kunit/visibility.h              |  1 +
  lib/Kconfig.debug                       | 16 ++++++++++
  lib/math/Makefile                       |  1 +
  lib/math/tests/Makefile                 |  3 ++
  lib/math/tests/int_pow_kunit.c          | 52 +++++++++++++++++++++++++++++++++
  tools/testing/kunit/kunit_kernel.py     |  3 +-
  7 files changed, 95 insertions(+), 10 deletions(-)
  create mode 100644 lib/math/tests/Makefile
  create mode 100644 lib/math/tests/int_pow_kunit.c

----------------------------------------------------------------
--------------lDmTx2uXH530aimSr6U5KQT6
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.12-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.12-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3N0eWxlLnJzdCBi
L0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3N0eWxlLnJzdAppbmRleCBiNmQwZDcz
NTlmMDAuLmVhYzgxYTcxNGEyOSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9v
bHMva3VuaXQvc3R5bGUucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0
L3N0eWxlLnJzdApAQCAtMTg4LDE1ICsxODgsMjYgQEAgRm9yIGV4YW1wbGUsIGEgS2NvbmZp
ZyBlbnRyeSBtaWdodCBsb29rIGxpa2U6CiBUZXN0IEZpbGUgYW5kIE1vZHVsZSBOYW1lcwog
PT09PT09PT09PT09PT09PT09PT09PT09PT0KIAotS1VuaXQgdGVzdHMgY2FuIG9mdGVuIGJl
IGNvbXBpbGVkIGFzIGEgbW9kdWxlLiBUaGVzZSBtb2R1bGVzIHNob3VsZCBiZSBuYW1lZAot
YWZ0ZXIgdGhlIHRlc3Qgc3VpdGUsIGZvbGxvd2VkIGJ5IGBgX3Rlc3RgYC4gSWYgdGhpcyBp
cyBsaWtlbHkgdG8gY29uZmxpY3Qgd2l0aAotbm9uLUtVbml0IHRlc3RzLCB0aGUgc3VmZml4
IGBgX2t1bml0YGAgY2FuIGFsc28gYmUgdXNlZC4KK0tVbml0IHRlc3RzIGFyZSBvZnRlbiBj
b21waWxlZCBhcyBhIHNlcGFyYXRlIG1vZHVsZS4gVG8gYXZvaWQgY29uZmxpY3RpbmcKK3dp
dGggcmVndWxhciBtb2R1bGVzLCBLVW5pdCBtb2R1bGVzIHNob3VsZCBiZSBuYW1lZCBhZnRl
ciB0aGUgdGVzdCBzdWl0ZSwKK2ZvbGxvd2VkIGJ5IGBgX2t1bml0YGAgKGUuZy4gaWYgImZv
b2JhciIgaXMgdGhlIGNvcmUgbW9kdWxlLCB0aGVuCisiZm9vYmFyX2t1bml0IiBpcyB0aGUg
S1VuaXQgdGVzdCBtb2R1bGUpLgogCi1UaGUgZWFzaWVzdCB3YXkgb2YgYWNoaWV2aW5nIHRo
aXMgaXMgdG8gbmFtZSB0aGUgZmlsZSBjb250YWluaW5nIHRoZSB0ZXN0IHN1aXRlCi1gYDxz
dWl0ZT5fdGVzdC5jYGAgKG9yLCBhcyBhYm92ZSwgYGA8c3VpdGU+X2t1bml0LmNgYCkuIFRo
aXMgZmlsZSBzaG91bGQgYmUKLXBsYWNlZCBuZXh0IHRvIHRoZSBjb2RlIHVuZGVyIHRlc3Qu
CitUZXN0IHNvdXJjZSBmaWxlcywgd2hldGhlciBjb21waWxlZCBhcyBhIHNlcGFyYXRlIG1v
ZHVsZSBvciBhbgorYGAjaW5jbHVkZWBgIGluIGFub3RoZXIgc291cmNlIGZpbGUsIGFyZSBi
ZXN0IGtlcHQgaW4gYSBgYHRlc3RzL2BgCitzdWJkaXJlY3RvcnkgdG8gbm90IGNvbmZsaWN0
IHdpdGggb3RoZXIgc291cmNlIGZpbGVzIChlLmcuIGZvcgordGFiLWNvbXBsZXRpb24pLgor
CitOb3RlIHRoYXQgdGhlIGBgX3Rlc3RgYCBzdWZmaXggaGFzIGFsc28gYmVlbiB1c2VkIGlu
IHNvbWUgZXhpc3RpbmcKK3Rlc3RzLiBUaGUgYGBfa3VuaXRgYCBzdWZmaXggaXMgcHJlZmVy
cmVkLCBhcyBpdCBtYWtlcyB0aGUgZGlzdGluY3Rpb24KK2JldHdlZW4gS1VuaXQgYW5kIG5v
bi1LVW5pdCB0ZXN0cyBjbGVhcmVyLgorCitTbyBmb3IgdGhlIGNvbW1vbiBjYXNlLCBuYW1l
IHRoZSBmaWxlIGNvbnRhaW5pbmcgdGhlIHRlc3Qgc3VpdGUKK2BgdGVzdHMvPHN1aXRlPl9r
dW5pdC5jYGAuIFRoZSBgYHRlc3RzYGAgZGlyZWN0b3J5IHNob3VsZCBiZSBwbGFjZWQgYXQK
K3RoZSBzYW1lIGxldmVsIGFzIHRoZSBjb2RlIHVuZGVyIHRlc3QuIEZvciBleGFtcGxlLCB0
ZXN0cyBmb3IKK2BgbGliL3N0cmluZy5jYGAgbGl2ZSBpbiBgYGxpYi90ZXN0cy9zdHJpbmdf
a3VuaXQuY2BgLgogCiBJZiB0aGUgc3VpdGUgbmFtZSBjb250YWlucyBzb21lIG9yIGFsbCBv
ZiB0aGUgbmFtZSBvZiB0aGUgdGVzdCdzIHBhcmVudAotZGlyZWN0b3J5LCBpdCBtYXkgbWFr
ZSBzZW5zZSB0byBtb2RpZnkgdGhlIHNvdXJjZSBmaWxlbmFtZSB0byByZWR1Y2UgcmVkdW5k
YW5jeS4KLUZvciBleGFtcGxlLCBhIGBgZm9vX2Zpcm13YXJlYGAgc3VpdGUgY291bGQgYmUg
aW4gdGhlIGBgZm9vL2Zpcm13YXJlX3Rlc3QuY2BgCi1maWxlLgorZGlyZWN0b3J5LCBpdCBt
YXkgbWFrZSBzZW5zZSB0byBtb2RpZnkgdGhlIHNvdXJjZSBmaWxlbmFtZSB0byByZWR1Y2UK
K3JlZHVuZGFuY3kuIEZvciBleGFtcGxlLCBhIGBgZm9vX2Zpcm13YXJlYGAgc3VpdGUgY291
bGQgYmUgaW4gdGhlCitgYGZvby90ZXN0cy9maXJtd2FyZV9rdW5pdC5jYGAgZmlsZS4KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdmlzaWJpbGl0eS5oIGIvaW5jbHVkZS9rdW5pdC92
aXNpYmlsaXR5LmgKaW5kZXggMGRmZTM1ZmVlZWM2Li5lZmZmNzdiNThkZDYgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUva3VuaXQvdmlzaWJpbGl0eS5oCisrKyBiL2luY2x1ZGUva3VuaXQvdmlz
aWJpbGl0eS5oCkBAIC0yMiw2ICsyMiw3IEBACiAgICAgICogRVhQT1JURURfRk9SX0tVTklU
X1RFU1RJTkcgbmFtZXNwYWNlIG9ubHkgaWYgQ09ORklHX0tVTklUIGlzCiAgICAgICogZW5h
YmxlZC4gTXVzdCB1c2UgTU9EVUxFX0lNUE9SVF9OUyhFWFBPUlRFRF9GT1JfS1VOSVRfVEVT
VElORykKICAgICAgKiBpbiB0ZXN0IGZpbGUgaW4gb3JkZXIgdG8gdXNlIHN5bWJvbHMuCisg
ICAgICogQHN5bWJvbDogdGhlIHN5bWJvbCBpZGVudGlmaWVyIHRvIGV4cG9ydAogICAgICAq
LwogICAgICNkZWZpbmUgRVhQT1JUX1NZTUJPTF9JRl9LVU5JVChzeW1ib2wpIEVYUE9SVF9T
WU1CT0xfTlMoc3ltYm9sLCBcCiAJICAgIEVYUE9SVEVEX0ZPUl9LVU5JVF9URVNUSU5HKQpk
aWZmIC0tZ2l0IGEvbGliL0tjb25maWcuZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1ZwppbmRl
eCBhMzBjMDNhNjYxNzIuLmI1Njk2NjU5ZjAyNyAxMDA2NDQKLS0tIGEvbGliL0tjb25maWcu
ZGVidWcKKysrIGIvbGliL0tjb25maWcuZGVidWcKQEAgLTMwNTEsMyArMzA1MSwxOSBAQCBj
b25maWcgUlVTVF9LRVJORUxfRE9DVEVTVFMKIGVuZG1lbnUgIyAiUnVzdCIKIAogZW5kbWVu
dSAjIEtlcm5lbCBoYWNraW5nCisKK2NvbmZpZyBJTlRfUE9XX1RFU1QKKwl0cmlzdGF0ZSAi
SW50ZWdlciBleHBvbmVudGlhdGlvbiAoaW50X3BvdykgdGVzdCIgaWYgIUtVTklUX0FMTF9U
RVNUUworCWRlcGVuZHMgb24gS1VOSVQKKwlkZWZhdWx0IEtVTklUX0FMTF9URVNUUworCWhl
bHAKKwkgIFRoaXMgb3B0aW9uIGVuYWJsZXMgdGhlIEtVbml0IHRlc3Qgc3VpdGUgZm9yIHRo
ZSBpbnRfcG93IGZ1bmN0aW9uLAorCSAgd2hpY2ggcGVyZm9ybXMgaW50ZWdlciBleHBvbmVu
dGlhdGlvbi4gVGhlIHRlc3Qgc3VpdGUgaXMgZGVzaWduZWQgdG8KKwkgIHZlcmlmeSB0aGF0
IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBpbnRfcG93IGNvcnJlY3RseSBjb21wdXRlcyB0aGUg
cG93ZXIKKwkgIG9mIGEgZ2l2ZW4gYmFzZSByYWlzZWQgdG8gYSBnaXZlbiBleHBvbmVudC4K
KworCSAgRW5hYmxpbmcgdGhpcyBvcHRpb24gd2lsbCBpbmNsdWRlIHRlc3RzIHRoYXQgY2hl
Y2sgdmFyaW91cyBzY2VuYXJpb3MKKwkgIGFuZCBlZGdlIGNhc2VzIHRvIGVuc3VyZSB0aGUg
YWNjdXJhY3kgYW5kIHJlbGlhYmlsaXR5IG9mIHRoZSBleHBvbmVudGlhdGlvbgorCSAgZnVu
Y3Rpb24uCisKKwkgIElmIHVuc3VyZSwgc2F5IE4KZGlmZiAtLWdpdCBhL2xpYi9tYXRoL01h
a2VmaWxlIGIvbGliL21hdGgvTWFrZWZpbGUKaW5kZXggOTFmY2RiMGM5ZWZlLi4zYzFmOTJh
NzQ1OWQgMTAwNjQ0Ci0tLSBhL2xpYi9tYXRoL01ha2VmaWxlCisrKyBiL2xpYi9tYXRoL01h
a2VmaWxlCkBAIC01LDUgKzUsNiBAQCBvYmotJChDT05GSUdfQ09SRElDKQkJKz0gY29yZGlj
Lm8KIG9iai0kKENPTkZJR19QUklNRV9OVU1CRVJTKQkrPSBwcmltZV9udW1iZXJzLm8KIG9i
ai0kKENPTkZJR19SQVRJT05BTCkJCSs9IHJhdGlvbmFsLm8KIAorb2JqLSQoQ09ORklHX0lO
VF9QT1dfVEVTVCkgICs9IHRlc3RzL2ludF9wb3dfa3VuaXQubwogb2JqLSQoQ09ORklHX1RF
U1RfRElWNjQpCSs9IHRlc3RfZGl2NjQubwogb2JqLSQoQ09ORklHX1JBVElPTkFMX0tVTklU
X1RFU1QpICs9IHJhdGlvbmFsLXRlc3QubwpkaWZmIC0tZ2l0IGEvbGliL21hdGgvdGVzdHMv
TWFrZWZpbGUgYi9saWIvbWF0aC90ZXN0cy9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjZhMTY5MTIzMzIwYQotLS0gL2Rldi9udWxsCisrKyBi
L2xpYi9tYXRoL3Rlc3RzL01ha2VmaWxlCkBAIC0wLDAgKzEsMyBAQAorIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CisKK29iai0kKENPTkZJR19JTlRfUE9XX1RF
U1QpICs9IGludF9wb3dfa3VuaXQubwpkaWZmIC0tZ2l0IGEvbGliL21hdGgvdGVzdHMvaW50
X3Bvd19rdW5pdC5jIGIvbGliL21hdGgvdGVzdHMvaW50X3Bvd19rdW5pdC5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMzRiMzM2NzdkNDU4Ci0tLSAvZGV2
L251bGwKKysrIGIvbGliL21hdGgvdGVzdHMvaW50X3Bvd19rdW5pdC5jCkBAIC0wLDAgKzEs
NTIgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKworI2lu
Y2x1ZGUgPGt1bml0L3Rlc3QuaD4KKyNpbmNsdWRlIDxsaW51eC9tYXRoLmg+CisKK3N0cnVj
dCB0ZXN0X2Nhc2VfcGFyYW1zIHsKKwl1NjQgYmFzZTsKKwl1bnNpZ25lZCBpbnQgZXhwb25l
bnQ7CisJdTY0IGV4cGVjdGVkX3Jlc3VsdDsKKwljb25zdCBjaGFyICpuYW1lOworfTsKKwor
c3RhdGljIGNvbnN0IHN0cnVjdCB0ZXN0X2Nhc2VfcGFyYW1zIHBhcmFtc1tdID0geworCXsg
NjQsIDAsIDEsICJQb3dlciBvZiB6ZXJvIiB9LAorCXsgNjQsIDEsIDY0LCAiUG93ZXIgb2Yg
b25lIn0sCisJeyAwLCA1LCAwLCAiQmFzZSB6ZXJvIiB9LAorCXsgMSwgNjQsIDEsICJCYXNl
IG9uZSIgfSwKKwl7IDIsIDIsIDQsICJUd28gc3F1YXJlZCJ9LAorCXsgMiwgMywgOCwgIlR3
byBjdWJlZCJ9LAorCXsgNSwgNSwgMzEyNSwgIkZpdmUgcmFpc2VkIHRvIHRoZSBmaWZ0aCBw
b3dlciIgfSwKKwl7IFU2NF9NQVgsIDEsIFU2NF9NQVgsICJNYXggYmFzZSIgfSwKKwl7IDIs
IDYzLCA5MjIzMzcyMDM2ODU0Nzc1ODA4VUxMLCAiTGFyZ2UgcmVzdWx0In0sCit9OworCitz
dGF0aWMgdm9pZCBnZXRfZGVzYyhjb25zdCBzdHJ1Y3QgdGVzdF9jYXNlX3BhcmFtcyAqdGMs
IGNoYXIgKmRlc2MpCit7CisJc3Ryc2NweShkZXNjLCB0Yy0+bmFtZSwgS1VOSVRfUEFSQU1f
REVTQ19TSVpFKTsKK30KKworS1VOSVRfQVJSQVlfUEFSQU0oaW50X3BvdywgcGFyYW1zLCBn
ZXRfZGVzYyk7CisKK3N0YXRpYyB2b2lkIGludF9wb3dfdGVzdChzdHJ1Y3Qga3VuaXQgKnRl
c3QpCit7CisJY29uc3Qgc3RydWN0IHRlc3RfY2FzZV9wYXJhbXMgKnRjID0gKGNvbnN0IHN0
cnVjdCB0ZXN0X2Nhc2VfcGFyYW1zICopdGVzdC0+cGFyYW1fdmFsdWU7CisKKwlLVU5JVF9F
WFBFQ1RfRVEodGVzdCwgdGMtPmV4cGVjdGVkX3Jlc3VsdCwgaW50X3Bvdyh0Yy0+YmFzZSwg
dGMtPmV4cG9uZW50KSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qga3VuaXRfY2FzZSBtYXRoX2lu
dF9wb3dfdGVzdF9jYXNlc1tdID0geworCUtVTklUX0NBU0VfUEFSQU0oaW50X3Bvd190ZXN0
LCBpbnRfcG93X2dlbl9wYXJhbXMpLAorCXt9Cit9OworCitzdGF0aWMgc3RydWN0IGt1bml0
X3N1aXRlIGludF9wb3dfdGVzdF9zdWl0ZSA9IHsKKwkubmFtZSA9ICJtYXRoLWludF9wb3ci
LAorCS50ZXN0X2Nhc2VzID0gbWF0aF9pbnRfcG93X3Rlc3RfY2FzZXMsCit9OworCitrdW5p
dF90ZXN0X3N1aXRlcygmaW50X3Bvd190ZXN0X3N1aXRlKTsKKworTU9EVUxFX0RFU0NSSVBU
SU9OKCJtYXRoLmludF9wb3cgS1VuaXQgdGVzdCBzdWl0ZSIpOworTU9EVUxFX0xJQ0VOU0Uo
IkdQTCIpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF9rZXJuZWwu
cHkgYi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0X2tlcm5lbC5weQppbmRleCA3MjU0YzEx
MGZmMjMuLjYxOTMxYzQ5MjZmZCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9rZXJuZWwucHkKKysrIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF9rZXJuZWwu
cHkKQEAgLTcyLDcgKzcyLDggQEAgY2xhc3MgTGludXhTb3VyY2VUcmVlT3BlcmF0aW9uczoK
IAkJCXJhaXNlIENvbmZpZ0Vycm9yKGUub3V0cHV0LmRlY29kZSgpKQogCiAJZGVmIG1ha2Uo
c2VsZiwgam9iczogaW50LCBidWlsZF9kaXI6IHN0ciwgbWFrZV9vcHRpb25zOiBPcHRpb25h
bFtMaXN0W3N0cl1dKSAtPiBOb25lOgotCQljb21tYW5kID0gWydtYWtlJywgJ0FSQ0g9JyAr
IHNlbGYuX2xpbnV4X2FyY2gsICdPPScgKyBidWlsZF9kaXIsICctLWpvYnM9JyArIHN0cihq
b2JzKV0KKwkJY29tbWFuZCA9IFsnbWFrZScsICdhbGwnLCAnY29tcGlsZV9jb21tYW5kcy5q
c29uJywgJ0FSQ0g9JyArIHNlbGYuX2xpbnV4X2FyY2gsCisJCQkgICAnTz0nICsgYnVpbGRf
ZGlyLCAnLS1qb2JzPScgKyBzdHIoam9icyldCiAJCWlmIG1ha2Vfb3B0aW9uczoKIAkJCWNv
bW1hbmQuZXh0ZW5kKG1ha2Vfb3B0aW9ucykKIAkJaWYgc2VsZi5fY3Jvc3NfY29tcGlsZToK


--------------lDmTx2uXH530aimSr6U5KQT6--

