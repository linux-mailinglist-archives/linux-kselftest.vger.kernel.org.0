Return-Path: <linux-kselftest+bounces-33677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3FFAC2A7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E8544F7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221E29CB49;
	Fri, 23 May 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LC69EzI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F61D54D8
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029147; cv=none; b=OmnbuoHWvoVUqnl/iOLc58WTBnTbavGnmgIm6fT8myMAQm5AMnOHdGK7vEL8EaCBgMCgG36Bxo+MKYc7zxiSLmNvSzG1phLzVI04D7oSpCD3uRmGp6EQ35Q5EN8H7FatX+XYNhCJGh8fIcpwVBjO05hvk6RVJ6w6cugh5IoAC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029147; c=relaxed/simple;
	bh=YNwPytqdIzXCb6Dbj/QZRhK3L6OYlfCpOdYMdfQBCdY=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=YfpfXBd1K/Sh3B5v0MdNMBjKpWKQtwLlQAxM1L3IPmJkD+6Umus+VtVtGKJ8jtTVUSt4+piWPoa4UMWIyOoFWn+6Byb4qBkLnF0WoeUa1h9sSV+T5lSOBhPehEXgnXTX9P3+O8RYrwtc0xftfUX/idtIfZNiqE5Lt2hKDcQd8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LC69EzI2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da73998419so869005ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748029143; x=1748633943; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSYaT5YyCnlhGvAeQksD3b6RZkgUC/+VazTkW+Ql7Jo=;
        b=LC69EzI2hbwSunwV25rg76ONuvZnnyySf8AEtcfR96ZUby05PuA3PIo8jZTgK2m3Z9
         Yw9HmkhkO3fpWmHWpBmJNO8CQ5JH4Gl1Bn5Fx+cASLTLSzlvbeBqd2BuRfXHDpxOa51s
         5IRXmTGBqpzL/sF4zK8fhFFROailAxBhCHhO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029143; x=1748633943;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSYaT5YyCnlhGvAeQksD3b6RZkgUC/+VazTkW+Ql7Jo=;
        b=YPXktvOkAavsKb32L9xshyTKiV17MS/Vdv5lQ1GadFvyhLADx+HQtHDVUpE+YKmPkv
         vx4TKlRXHJnebH3OcG11kYqCAwTXERdFgNE/rCkv01kGui5QNpmL6iY9zjeC3fpe8Yyh
         M9oAgZ2FgYFwoUXWLcqegf6NLDwWJmnr1Fznq5Pe7ApZ08Jj0e11AT4U9D+PVKbfccgv
         kjC2xvqy6ll927GFa0Sn9iin53xavLTjeWgGV5mlN83hk8m5wm2Udr6Z4iXOuMxCNK3m
         CiyiyvTXv3h7kJpVSEzWs4Zyn6xWd0wYoloWGGudCNdKh+404pJFJYEf3YsgCV5M+bWm
         OZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0jzBXbSMqsC/YVVUWnuh4D2/Zl1Elem4bNoLDf5Z6nguiAGgFHpOezFrutuBV/0VXDySnLdH1TICYVe+UPKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlVTO7l/tVnXTQ7dPiUkKo+I6wwhkqFN/M3xSr3i1xyGOkVmd
	Kms853I7Ehb0LuxKqqNxW05fwRPCiO5jxqbzzZ23DbiDs+v/1RiA+aRbCHNzJRCdHwk=
X-Gm-Gg: ASbGncvt+7uo2ub0Tk+Ayi7n7AJw3XCgSmaDlsQmoBUkZPW/xw23FlBlld1t9qzpUxA
	zQF7ZUkkYoIAV0T6d4SfR/l9JoyeAUWc9hdS5EFSCaNabfLaE+U40VqcMJ0RBXT5e41j4T+nNNo
	iR/FRbYL+RcbBsYlJd6rWae5rizIHnN735HsuSANr2Jm4CSr0PTUvnp6PThJHga4l6MP9gTNpWB
	LxVGbJoxKEdB+ya48mcgyZu9ahQyvJ9GeXOqPcWgIb6NTcY9uifZWlaIN9Tcl0IHr1vo51vW+Vv
	XsFEEe1u6S+gZGvjW38wwJsZKrNuSMyyYCiejQfhCORDCUGJzE5WX9m0ie/wGw==
X-Google-Smtp-Source: AGHT+IEtFR96KAft0blY/PutWzL551E5JYiKFBNXI7Q9jh7VeCljH5BFRRRFyvZU58UAeAumrIl4oA==
X-Received: by 2002:a05:6e02:1b0e:b0:3db:86fc:d328 with SMTP id e9e14a558f8ab-3dc9b67097cmr3837105ab.5.1748029142916;
        Fri, 23 May 2025 12:39:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a56esm3727986173.12.2025.05.23.12.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:39:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------HRIk7LgMU2M3W6ui30NdDtq7"
Message-ID: <ab676145-a8cb-4f0f-83e3-79e073c47380@linuxfoundation.org>
Date: Fri, 23 May 2025 13:39:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit next update for Linux 6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------HRIk7LgMU2M3W6ui30NdDtq7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kunit next update for Linux 6.16-rc1.

- Enables qemu_config for riscv32, sparc 64-bit, PowerPC 32-bit BE and
   64-bit LE.
- Enables CONFIG_SPARC32 to clearly differentiate between sparc 32-bit
   and 64-bit configurations.
- Enables CONFIG_CPU_BIG_ENDIAN to clearly differentiate between powerpc
   LE and BE configurations.
- Adds feature to list available architectures to kunit tool.
- Fixes to bugs and changes to documentation.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

   Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.16-rc1

for you to fetch changes up to 772e50a76ee664e75581624f512df4e45582605a:

   kunit: Fix wrong parameter to kunit_deactivate_static_stub() (2025-05-21 09:51:23 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-6.16-rc1

- Enables qemu_config for riscv32, sparc 64-bit, PowerPC 32-bit BE and
   64-bit LE.
- Enables CONFIG_SPARC32 to clearly differentiate between sparc 32-bit
   and 64-bit configurations.
- Enables CONFIG_CPU_BIG_ENDIAN to clearly differentiate between powerpc
   LE and BE configurations.
- Add feature to list available architectures to kunit tool.
- Fixes to bugs and changes to documentation.

----------------------------------------------------------------
David Gow (1):
       kunit: qemu_configs: Disable faulting tests on 32-bit SPARC

Kees Cook (1):
       kunit: executor: Remove const from kunit_filter_suites() allocation type

Rae Moar (2):
       Documentation: kunit: improve example on testing static functions
       kunit: tool: add test counts to JSON output

Richard Fitzgerald (1):
       kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests

Thomas Weißschuh (6):
       kunit: qemu_configs: Add riscv32 config
       kunit: tool: Implement listing of available architectures
       kunit: qemu_configs: powerpc: Explicitly enable CONFIG_CPU_BIG_ENDIAN=y
       kunit: qemu_configs: Add PowerPC 32-bit BE and 64-bit LE
       kunit: qemu_configs: sparc: Explicitly enable CONFIG_SPARC32=y
       kunit: qemu_configs: Add 64-bit SPARC configuration

Tzung-Bi Shih (1):
       kunit: Fix wrong parameter to kunit_deactivate_static_stub()

  Documentation/dev-tools/kunit/run_wrapper.rst |  2 ++
  Documentation/dev-tools/kunit/usage.rst       | 38 +++++++++++++++++++++------
  lib/kunit/executor.c                          |  2 +-
  lib/kunit/static_stub.c                       |  2 +-
  tools/testing/kunit/configs/all_tests.config  |  1 +
  tools/testing/kunit/kunit_json.py             | 10 +++++++
  tools/testing/kunit/kunit_kernel.py           |  8 ++++++
  tools/testing/kunit/qemu_configs/powerpc.py   |  1 +
  tools/testing/kunit/qemu_configs/powerpc32.py | 17 ++++++++++++
  tools/testing/kunit/qemu_configs/powerpcle.py | 14 ++++++++++
  tools/testing/kunit/qemu_configs/riscv32.py   | 17 ++++++++++++
  tools/testing/kunit/qemu_configs/sparc.py     |  2 ++
  tools/testing/kunit/qemu_configs/sparc64.py   | 16 +++++++++++
  13 files changed, 120 insertions(+), 10 deletions(-)
  create mode 100644 tools/testing/kunit/qemu_configs/powerpc32.py
  create mode 100644 tools/testing/kunit/qemu_configs/powerpcle.py
  create mode 100644 tools/testing/kunit/qemu_configs/riscv32.py
  create mode 100644 tools/testing/kunit/qemu_configs/sparc64.py
----------------------------------------------------------------
--------------HRIk7LgMU2M3W6ui30NdDtq7
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.16-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.16-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bl93cmFwcGVy
LnJzdCBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bl93cmFwcGVyLnJzdApp
bmRleCAxOWRkZjVlMDcwMTMuLjY2OTdjNzFlZThjYSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXYtdG9vbHMva3VuaXQvcnVuX3dyYXBwZXIucnN0CisrKyBiL0RvY3VtZW50YXRp
b24vZGV2LXRvb2xzL2t1bml0L3J1bl93cmFwcGVyLnJzdApAQCAtMTgyLDYgKzE4Miw4IEBA
IHZpYSBVTUwuIFRvIHJ1biB0ZXN0cyBvbiBxZW11LCBieSBkZWZhdWx0IGl0IHJlcXVpcmVz
IHR3byBmbGFnczoKICAgaXMgaWdub3JlZCksIHRoZSB0ZXN0cyB3aWxsIHJ1biB2aWEgVU1M
LiBOb24tVU1MIGFyY2hpdGVjdHVyZXMsCiAgIGZvciBleGFtcGxlOiBpMzg2LCB4ODZfNjQs
IGFybSBhbmQgc28gb247IHJ1biBvbiBxZW11LgogCisgIGBgLS1hcmNoIGhlbHBgYCBsaXN0
cyBhbGwgdmFsaWQgYGAtLWFyY2hgYCB2YWx1ZXMuCisKIC0gYGAtLWNyb3NzX2NvbXBpbGVg
YDogU3BlY2lmaWVzIHRoZSBLYnVpbGQgdG9vbGNoYWluLiBJdCBwYXNzZXMgdGhlCiAgIHNh
bWUgYXJndW1lbnQgYXMgcGFzc2VkIHRvIHRoZSBgYENST1NTX0NPTVBJTEVgYCB2YXJpYWJs
ZSB1c2VkIGJ5CiAgIEtidWlsZC4gQXMgYSByZW1pbmRlciwgdGhpcyB3aWxsIGJlIHRoZSBw
cmVmaXggZm9yIHRoZSB0b29sY2hhaW4KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
LXRvb2xzL2t1bml0L3VzYWdlLnJzdCBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0
L3VzYWdlLnJzdAppbmRleCAyMjk1NWQ1NmIzNzkuLjAzOGY0ODAwNzRmZCAxMDA2NDQKLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvdXNhZ2UucnN0CisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdApAQCAtNjcwLDI4ICs2NzAsNTAg
QEAgd2l0aCBgYGt1bml0X3JlbW92ZV9hY3Rpb25gYC4KIFRlc3RpbmcgU3RhdGljIEZ1bmN0
aW9ucwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLUlmIHdlIGRvIG5vdCB3YW50IHRv
IGV4cG9zZSBmdW5jdGlvbnMgb3IgdmFyaWFibGVzIGZvciB0ZXN0aW5nLCBvbmUgb3B0aW9u
IGlzIHRvCi1jb25kaXRpb25hbGx5IGV4cG9ydCB0aGUgdXNlZCBzeW1ib2wuIEZvciBleGFt
cGxlOgorSWYgeW91IHdhbnQgdG8gdGVzdCBzdGF0aWMgZnVuY3Rpb25zIHdpdGhvdXQgZXhw
b3NpbmcgdGhvc2UgZnVuY3Rpb25zIG91dHNpZGUgb2YKK3Rlc3RpbmcsIG9uZSBvcHRpb24g
aXMgY29uZGl0aW9uYWxseSBleHBvcnQgdGhlIHN5bWJvbC4gV2hlbiBLVW5pdCBpcyBlbmFi
bGVkLAordGhlIHN5bWJvbCBpcyBleHBvc2VkIGJ1dCByZW1haW5zIHN0YXRpYyBvdGhlcndp
c2UuIFRvIHVzZSB0aGlzIG1ldGhvZCwgZm9sbG93Cit0aGUgdGVtcGxhdGUgYmVsb3cuCiAK
IC4uIGNvZGUtYmxvY2s6OiBjCiAKLQkvKiBJbiBteV9maWxlLmMgKi8KKwkvKiBJbiB0aGUg
ZmlsZSBjb250YWluaW5nIGZ1bmN0aW9ucyB0byB0ZXN0ICJteV9maWxlLmMiICovCiAKLQlW
SVNJQkxFX0lGX0tVTklUIGludCBkb19pbnRlcmVzdGluZ190aGluZygpOworCSNpbmNsdWRl
IDxrdW5pdC92aXNpYmlsaXR5Lmg+CisJI2luY2x1ZGUgPG15X2ZpbGUuaD4KKwkuLi4KKwlW
SVNJQkxFX0lGX0tVTklUIGludCBkb19pbnRlcmVzdGluZ190aGluZygpCisJeworCS4uLgor
CX0KIAlFWFBPUlRfU1lNQk9MX0lGX0tVTklUKGRvX2ludGVyZXN0aW5nX3RoaW5nKTsKIAot
CS8qIEluIG15X2ZpbGUuaCAqLworCS8qIEluIHRoZSBoZWFkZXIgZmlsZSAibXlfZmlsZS5o
IiAqLwogCiAJI2lmIElTX0VOQUJMRUQoQ09ORklHX0tVTklUKQogCQlpbnQgZG9faW50ZXJl
c3RpbmdfdGhpbmcodm9pZCk7CiAJI2VuZGlmCiAKLUFsdGVybmF0aXZlbHksIHlvdSBjb3Vs
ZCBjb25kaXRpb25hbGx5IGBgI2luY2x1ZGVgYCB0aGUgdGVzdCBmaWxlIGF0IHRoZSBlbmQg
b2YKLXlvdXIgLmMgZmlsZS4gRm9yIGV4YW1wbGU6CisJLyogSW4gdGhlIEtVbml0IHRlc3Qg
ZmlsZSAibXlfZmlsZV90ZXN0LmMiICovCisKKwkjaW5jbHVkZSA8a3VuaXQvdmlzaWJpbGl0
eS5oPgorCSNpbmNsdWRlIDxteV9maWxlLmg+CisJLi4uCisJTU9EVUxFX0lNUE9SVF9OUyhF
WFBPUlRFRF9GT1JfS1VOSVRfVEVTVElORyk7CisJLi4uCisJLy8gVXNlIGRvX2ludGVyZXN0
aW5nX3RoaW5nKCkgaW4gdGVzdHMKKworRm9yIGEgZnVsbCBleGFtcGxlLCBzZWUgdGhpcyBg
cGF0Y2ggPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMTIwNzAxNDAyNC4zNDAy
MzAtMy1ybW9hckBnb29nbGUuY29tLz5gXword2hlcmUgYSB0ZXN0IGlzIG1vZGlmaWVkIHRv
IGNvbmRpdGlvbmFsbHkgZXhwb3NlIHN0YXRpYyBmdW5jdGlvbnMgZm9yIHRlc3RpbmcKK3Vz
aW5nIHRoZSBtYWNyb3MgYWJvdmUuCisKK0FzIGFuICoqYWx0ZXJuYXRpdmUqKiB0byB0aGUg
bWV0aG9kIGFib3ZlLCB5b3UgY291bGQgY29uZGl0aW9uYWxseSBgYCNpbmNsdWRlYGAKK3Ro
ZSB0ZXN0IGZpbGUgYXQgdGhlIGVuZCBvZiB5b3VyIC5jIGZpbGUuIFRoaXMgaXMgbm90IHJl
Y29tbWVuZGVkIGJ1dCB3b3JrcworaWYgbmVlZGVkLiBGb3IgZXhhbXBsZToKIAogLi4gY29k
ZS1ibG9jazo6IGMKIAotCS8qIEluIG15X2ZpbGUuYyAqLworCS8qIEluICJteV9maWxlLmMi
ICovCiAKIAlzdGF0aWMgaW50IGRvX2ludGVyZXN0aW5nX3RoaW5nKCk7CiAKZGlmZiAtLWdp
dCBhL2xpYi9rdW5pdC9leGVjdXRvci5jIGIvbGliL2t1bml0L2V4ZWN1dG9yLmMKaW5kZXgg
M2YzOTk1NWNiMGYxLi4wMDYxZDRjN2UzNTEgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9leGVj
dXRvci5jCisrKyBiL2xpYi9rdW5pdC9leGVjdXRvci5jCkBAIC0xNzcsNyArMTc3LDcgQEAg
a3VuaXRfZmlsdGVyX3N1aXRlcyhjb25zdCBzdHJ1Y3Qga3VuaXRfc3VpdGVfc2V0ICpzdWl0
ZV9zZXQsCiAKIAljb25zdCBzaXplX3QgbWF4ID0gc3VpdGVfc2V0LT5lbmQgLSBzdWl0ZV9z
ZXQtPnN0YXJ0OwogCi0JY29weSA9IGtjYWxsb2MobWF4LCBzaXplb2YoKmZpbHRlcmVkLnN0
YXJ0KSwgR0ZQX0tFUk5FTCk7CisJY29weSA9IGtjYWxsb2MobWF4LCBzaXplb2YoKmNvcHkp
LCBHRlBfS0VSTkVMKTsKIAlpZiAoIWNvcHkpIHsgLyogd29uJ3QgYmUgYWJsZSB0byBydW4g
YW55dGhpbmcsIHJldHVybiBhbiBlbXB0eSBzZXQgKi8KIAkJcmV0dXJuIGZpbHRlcmVkOwog
CX0KZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9zdGF0aWNfc3R1Yi5jIGIvbGliL2t1bml0L3N0
YXRpY19zdHViLmMKaW5kZXggOTJiMmNjY2Q1ZTc2Li40ODRmZDg1MjUxYjQgMTAwNjQ0Ci0t
LSBhL2xpYi9rdW5pdC9zdGF0aWNfc3R1Yi5jCisrKyBiL2xpYi9rdW5pdC9zdGF0aWNfc3R1
Yi5jCkBAIC05Niw3ICs5Niw3IEBAIHZvaWQgX19rdW5pdF9hY3RpdmF0ZV9zdGF0aWNfc3R1
YihzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAKIAkvKiBJZiB0aGUgcmVwbGFjZW1lbnQgYWRkcmVz
cyBpcyBOVUxMLCBkZWFjdGl2YXRlIHRoZSBzdHViLiAqLwogCWlmICghcmVwbGFjZW1lbnRf
YWRkcikgewotCQlrdW5pdF9kZWFjdGl2YXRlX3N0YXRpY19zdHViKHRlc3QsIHJlcGxhY2Vt
ZW50X2FkZHIpOworCQlrdW5pdF9kZWFjdGl2YXRlX3N0YXRpY19zdHViKHRlc3QsIHJlYWxf
Zm5fYWRkcik7CiAJCXJldHVybjsKIAl9CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
a3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29uZmlnIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9j
b25maWdzL2FsbF90ZXN0cy5jb25maWcKaW5kZXggY2RkOTc4MmY5NjQ2Li40YTYwYmI3MWZl
NzIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMu
Y29uZmlnCisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29u
ZmlnCkBAIC0xMCw2ICsxMCw3IEBAIENPTkZJR19LVU5JVF9FWEFNUExFX1RFU1Q9eQogQ09O
RklHX0tVTklUX0FMTF9URVNUUz15CiAKIENPTkZJR19GT1JUSUZZX1NPVVJDRT15CitDT05G
SUdfSU5JVF9TVEFDS19BTExfUEFUVEVSTj15CiAKIENPTkZJR19JSU89eQogCmRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL2t1bml0L2t1bml0X2pzb24ucHkgYi90b29scy90ZXN0aW5n
L2t1bml0L2t1bml0X2pzb24ucHkKaW5kZXggMTBmZjY1Njg5ZGQ4Li44MGZhNGUzNTRhMTcg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfanNvbi5weQorKysgYi90
b29scy90ZXN0aW5nL2t1bml0L2t1bml0X2pzb24ucHkKQEAgLTM5LDEwICszOSwyMCBAQCBk
ZWYgX2dldF9ncm91cF9qc29uKHRlc3Q6IFRlc3QsIGNvbW1vbl9maWVsZHM6IEpzb25PYmop
IC0+IEpzb25PYmo6CiAJCXN0YXR1cyA9IF9zdGF0dXNfbWFwLmdldChzdWJ0ZXN0LnN0YXR1
cywgIkZBSUwiKQogCQl0ZXN0X2Nhc2VzLmFwcGVuZCh7Im5hbWUiOiBzdWJ0ZXN0Lm5hbWUs
ICJzdGF0dXMiOiBzdGF0dXN9KQogCisJdGVzdF9jb3VudHMgPSB0ZXN0LmNvdW50cworCWNv
dW50c19qc29uID0geworCQkidGVzdHMiOiB0ZXN0X2NvdW50cy50b3RhbCgpLAorCQkicGFz
c2VkIjogdGVzdF9jb3VudHMucGFzc2VkLAorCQkiZmFpbGVkIjogdGVzdF9jb3VudHMuZmFp
bGVkLAorCQkiY3Jhc2hlZCI6IHRlc3RfY291bnRzLmNyYXNoZWQsCisJCSJza2lwcGVkIjog
dGVzdF9jb3VudHMuc2tpcHBlZCwKKwkJImVycm9ycyI6IHRlc3RfY291bnRzLmVycm9ycywK
Kwl9CiAJdGVzdF9ncm91cCA9IHsKIAkJIm5hbWUiOiB0ZXN0Lm5hbWUsCiAJCSJzdWJfZ3Jv
dXBzIjogc3ViX2dyb3VwcywKIAkJInRlc3RfY2FzZXMiOiB0ZXN0X2Nhc2VzLAorCQkibWlz
YyI6IGNvdW50c19qc29uCiAJfQogCXRlc3RfZ3JvdXAudXBkYXRlKGNvbW1vbl9maWVsZHMp
CiAJcmV0dXJuIHRlc3RfZ3JvdXAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQv
a3VuaXRfa2VybmVsLnB5IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF9rZXJuZWwucHkK
aW5kZXggZDNmMzliYzFjZWVjLi4yNjBkOGQ5YWExZGIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcva3VuaXQva3VuaXRfa2VybmVsLnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQv
a3VuaXRfa2VybmVsLnB5CkBAIC0xNCw2ICsxNCw3IEBAIGltcG9ydCBvcwogaW1wb3J0IHNo
bGV4CiBpbXBvcnQgc2h1dGlsCiBpbXBvcnQgc2lnbmFsCitpbXBvcnQgc3lzCiBpbXBvcnQg
dGhyZWFkaW5nCiBmcm9tIHR5cGluZyBpbXBvcnQgSXRlcmF0b3IsIExpc3QsIE9wdGlvbmFs
LCBUdXBsZQogZnJvbSB0eXBlcyBpbXBvcnQgRnJhbWVUeXBlCkBAIC0yMDEsNiArMjAyLDEz
IEBAIGRlZiBfZGVmYXVsdF9xZW11X2NvbmZpZ19wYXRoKGFyY2g6IHN0cikgLT4gc3RyOgog
CQlyZXR1cm4gY29uZmlnX3BhdGgKIAogCW9wdGlvbnMgPSBbZls6LTNdIGZvciBmIGluIG9z
Lmxpc3RkaXIoUUVNVV9DT05GSUdTX0RJUikgaWYgZi5lbmRzd2l0aCgnLnB5JyldCisKKwlp
ZiBhcmNoID09ICdoZWxwJzoKKwkJcHJpbnQoJ3VtJykKKwkJZm9yIG9wdGlvbiBpbiBvcHRp
b25zOgorCQkJcHJpbnQob3B0aW9uKQorCQlzeXMuZXhpdCgpCisKIAlyYWlzZSBDb25maWdF
cnJvcihhcmNoICsgJyBpcyBub3QgYSB2YWxpZCBhcmNoLCBvcHRpb25zIGFyZSAnICsgc3Ry
KHNvcnRlZChvcHRpb25zKSkpCiAKIGRlZiBfZ2V0X3FlbXVfb3BzKGNvbmZpZ19wYXRoOiBz
dHIsCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmlncy9wb3dl
cnBjLnB5IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9xZW11X2NvbmZpZ3MvcG93ZXJwYy5weQpp
bmRleCA3ZWMzOGQ0MTMxZjcuLjViNGM4OTVkNWQ1YSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9rdW5pdC9xZW11X2NvbmZpZ3MvcG93ZXJwYy5weQorKysgYi90b29scy90ZXN0aW5n
L2t1bml0L3FlbXVfY29uZmlncy9wb3dlcnBjLnB5CkBAIC0zLDYgKzMsNyBAQCBmcm9tIC4u
cWVtdV9jb25maWcgaW1wb3J0IFFlbXVBcmNoUGFyYW1zCiBRRU1VX0FSQ0ggPSBRZW11QXJj
aFBhcmFtcyhsaW51eF9hcmNoPSdwb3dlcnBjJywKIAkJCSAgIGtjb25maWc9JycnCiBDT05G
SUdfUFBDNjQ9eQorQ09ORklHX0NQVV9CSUdfRU5ESUFOPXkKIENPTkZJR19TRVJJQUxfODI1
MD15CiBDT05GSUdfU0VSSUFMXzgyNTBfQ09OU09MRT15CiBDT05GSUdfSFZDX0NPTlNPTEU9
eScnJywKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3Bv
d2VycGMzMi5weSBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3Bvd2VycGMz
Mi5weQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjg4YmQ2MGRi
Yjk0OAotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25m
aWdzL3Bvd2VycGMzMi5weQpAQCAtMCwwICsxLDE3IEBACisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wCisKK2Zyb20gLi5xZW11X2NvbmZpZyBpbXBvcnQgUWVtdUFyY2hQ
YXJhbXMKKworUUVNVV9BUkNIID0gUWVtdUFyY2hQYXJhbXMobGludXhfYXJjaD0ncG93ZXJw
YycsCisJCQkgICBrY29uZmlnPScnJworQ09ORklHX1BQQzMyPXkKK0NPTkZJR19DUFVfQklH
X0VORElBTj15CitDT05GSUdfQURCX0NVREE9eQorQ09ORklHX1NFUklBTF9QTUFDWklMT0c9
eQorQ09ORklHX1NFUklBTF9QTUFDWklMT0dfVFRZUz15CitDT05GSUdfU0VSSUFMX1BNQUNa
SUxPR19DT05TT0xFPXkKKycnJywKKwkJCSAgIHFlbXVfYXJjaD0ncHBjJywKKwkJCSAgIGtl
cm5lbF9wYXRoPSd2bWxpbnV4JywKKwkJCSAgIGtlcm5lbF9jb21tYW5kX2xpbmU9J2NvbnNv
bGU9dHR5UzAnLAorCQkJICAgZXh0cmFfcWVtdV9wYXJhbXM9WyctTScsICdnM2JlaWdlJywg
Jy1jcHUnLCAnbWF4J10pCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0L3FlbXVf
Y29uZmlncy9wb3dlcnBjbGUucHkgYi90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmln
cy9wb3dlcnBjbGUucHkKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li43ZGRlZThhZjRiZDcKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL2t1bml0
L3FlbXVfY29uZmlncy9wb3dlcnBjbGUucHkKQEAgLTAsMCArMSwxNCBAQAorIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAorCitmcm9tIC4ucWVtdV9jb25maWcgaW1wb3J0
IFFlbXVBcmNoUGFyYW1zCisKK1FFTVVfQVJDSCA9IFFlbXVBcmNoUGFyYW1zKGxpbnV4X2Fy
Y2g9J3Bvd2VycGMnLAorCQkJICAga2NvbmZpZz0nJycKK0NPTkZJR19QUEM2ND15CitDT05G
SUdfQ1BVX0xJVFRMRV9FTkRJQU49eQorQ09ORklHX0hWQ19DT05TT0xFPXkKKycnJywKKwkJ
CSAgIHFlbXVfYXJjaD0ncHBjNjQnLAorCQkJICAga2VybmVsX3BhdGg9J3ZtbGludXgnLAor
CQkJICAga2VybmVsX2NvbW1hbmRfbGluZT0nY29uc29sZT10dHlTMCcsCisJCQkgICBleHRy
YV9xZW11X3BhcmFtcz1bJy1NJywgJ3BzZXJpZXMnLCAnLWNwdScsICdwb3dlcjgnXSkKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3Jpc2N2MzIucHkg
Yi90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmlncy9yaXNjdjMyLnB5Cm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYjc5YmEwYWUzMGY4Ci0tLSAvZGV2
L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9xZW11X2NvbmZpZ3MvcmlzY3YzMi5w
eQpAQCAtMCwwICsxLDE3IEBACisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
CisKK2Zyb20gLi5xZW11X2NvbmZpZyBpbXBvcnQgUWVtdUFyY2hQYXJhbXMKKworUUVNVV9B
UkNIID0gUWVtdUFyY2hQYXJhbXMobGludXhfYXJjaD0ncmlzY3YnLAorCQkJICAga2NvbmZp
Zz0nJycKK0NPTkZJR19OT05QT1JUQUJMRT15CitDT05GSUdfQVJDSF9SVjMyST15CitDT05G
SUdfQVJDSF9WSVJUPXkKK0NPTkZJR19TRVJJQUxfODI1MD15CitDT05GSUdfU0VSSUFMXzgy
NTBfQ09OU09MRT15CitDT05GSUdfU0VSSUFMX09GX1BMQVRGT1JNPXkKKycnJywKKwkJCSAg
IHFlbXVfYXJjaD0ncmlzY3YzMicsCisJCQkgICBrZXJuZWxfcGF0aD0nYXJjaC9yaXNjdi9i
b290L0ltYWdlJywKKwkJCSAgIGtlcm5lbF9jb21tYW5kX2xpbmU9J2NvbnNvbGU9dHR5UzAn
LAorCQkJICAgZXh0cmFfcWVtdV9wYXJhbXM9WyctbWFjaGluZScsICd2aXJ0J10pCmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmlncy9zcGFyYy5weSBiL3Rv
b2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3NwYXJjLnB5CmluZGV4IDI1NmQ5NTcz
YjQ0Ni4uMjAxOTU1MGExYjY5IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL2t1bml0L3Fl
bXVfY29uZmlncy9zcGFyYy5weQorKysgYi90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29u
Zmlncy9zcGFyYy5weQpAQCAtMiw2ICsyLDggQEAgZnJvbSAuLnFlbXVfY29uZmlnIGltcG9y
dCBRZW11QXJjaFBhcmFtcwogCiBRRU1VX0FSQ0ggPSBRZW11QXJjaFBhcmFtcyhsaW51eF9h
cmNoPSdzcGFyYycsCiAJCQkgICBrY29uZmlnPScnJworQ09ORklHX0tVTklUX0ZBVUxUX1RF
U1Q9bgorQ09ORklHX1NQQVJDMzI9eQogQ09ORklHX1NFUklBTF9TVU5aSUxPRz15CiBDT05G
SUdfU0VSSUFMX1NVTlpJTE9HX0NPTlNPTEU9eQogJycnLApkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9rdW5pdC9xZW11X2NvbmZpZ3Mvc3BhcmM2NC5weSBiL3Rvb2xzL3Rlc3Rpbmcv
a3VuaXQvcWVtdV9jb25maWdzL3NwYXJjNjQucHkKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMDAwLi41M2Q0ZTVhOGM5NzIKLS0tIC9kZXYvbnVsbAorKysgYi90b29s
cy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmlncy9zcGFyYzY0LnB5CkBAIC0wLDAgKzEsMTYg
QEAKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKworZnJvbSAuLnFlbXVf
Y29uZmlnIGltcG9ydCBRZW11QXJjaFBhcmFtcworCitRRU1VX0FSQ0ggPSBRZW11QXJjaFBh
cmFtcyhsaW51eF9hcmNoPSdzcGFyYycsCisJCQkgICBrY29uZmlnPScnJworQ09ORklHXzY0
QklUPXkKK0NPTkZJR19TUEFSQzY0PXkKK0NPTkZJR19QQ0k9eQorQ09ORklHX1NFUklBTF9T
VU5TVT15CitDT05GSUdfU0VSSUFMX1NVTlNVX0NPTlNPTEU9eQorJycnLAorCQkJICAgcWVt
dV9hcmNoPSdzcGFyYzY0JywKKwkJCSAgIGtlcm5lbF9wYXRoPSdhcmNoL3NwYXJjL2Jvb3Qv
aW1hZ2UnLAorCQkJICAga2VybmVsX2NvbW1hbmRfbGluZT0nY29uc29sZT10dHlTMCBrdW5p
dF9zaHV0ZG93bj1wb3dlcm9mZicsCisJCQkgICBleHRyYV9xZW11X3BhcmFtcz1bXSkK

--------------HRIk7LgMU2M3W6ui30NdDtq7--

