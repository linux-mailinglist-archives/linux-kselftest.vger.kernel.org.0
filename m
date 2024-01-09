Return-Path: <linux-kselftest+bounces-2762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F39828CB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF221C24E4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9A3C49D;
	Tue,  9 Jan 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA+ctkli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013536D6FC
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jan 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso39031139f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704825457; x=1705430257; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2oH/VZxvoetgMc/k3MiG/99MRCCtdXG/aQKWFR0vvjY=;
        b=UA+ctkliR3pRnqXiwSF0bpeSKwS70NJKp5oZKTGZLXv5V0GSO84c9lM/dDDXAPczpF
         GyNY8DE3DCnW5JoTpv/V2qrRWXjz0nJ+IjWVvqSROFqaYvvNLYhzu+UrAHSCt7ifN/Kx
         ptXbcof6TkYBGP8mvOCOHR+iQzTaxxwo0oPtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825457; x=1705430257;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oH/VZxvoetgMc/k3MiG/99MRCCtdXG/aQKWFR0vvjY=;
        b=SSJeUvre9ezQNsn/b+xDB5bwrmZ5dk9jvJOeSmwnkRV0Fu18FDlA9sHni+M04rG2O2
         Kxetg+1C8LwgNY+P2uaMBbMpPn4Ql3DXzqvDaMN3wG9iUGWa9ukpv/rfVxnRNGzZdYLg
         xvKTGsqADd7bEq7KCOJOPWeP9nUan3QnISmzrYGKMp7nWIjlg5T4MDFKIqEDLN4HqGBY
         Jr364cX86dsIYT/IwUvbcRdHUkDA9QrChTs1hq9zZaG7Z5LvEh7BHv9HXX3oxorlCASm
         IihYBSL8fMT2LRYnZnrDw+FkLj/WKDx2WQMl4z/ISfmpfd/S0qSFyJOqk6zZZAYVeSe0
         zKWQ==
X-Gm-Message-State: AOJu0Yz3g40iEWnEODSYbZbxwKE6MRADywaMrlyvBi5FuvmXWtQ/h3mj
	FKv+0fHll3mPoFEmaU2lpdHpTZ9z+cDDeA==
X-Google-Smtp-Source: AGHT+IE+2AAJD8EPl+IWMEc85M3JLfrricHxCM+IKADvqqmwVBfelnRPCO9Fs1YKMWbFrbi/QTwqFA==
X-Received: by 2002:a6b:c94e:0:b0:7be:edbc:629f with SMTP id z75-20020a6bc94e000000b007beedbc629fmr1100327iof.0.1704825456926;
        Tue, 09 Jan 2024 10:37:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y66-20020a029548000000b0046e139ad407sm798426jah.71.2024.01.09.10.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 10:37:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------iq8LG0chExFtyjSpGrBvnQOH"
Message-ID: <ec8e9234-fcda-4573-96de-ebec9586670b@linuxfoundation.org>
Date: Tue, 9 Jan 2024 11:37:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit next update for Linux 6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------iq8LG0chExFtyjSpGrBvnQOH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit next update for Linux 6.8-rc1.

This KUnit update for Linux 6.8-rc1 consists of:

- a new feature that adds APIs for managing devices introducing
   a set of helper functions which allow devices (internally a
   struct kunit_device) to be created and managed by KUnit.
   These devices will be automatically unregistered on
   test exit. These helpers can either use a user-provided
   struct device_driver, or have one automatically created and
   managed by KUnit. In both cases, the device lives on a new
   kunit_bus.

- changes to switch drm/tests to use kunit devices

- several fixes and enhancements to attribute feature

- changes to reorganize deferred action function introducing
   KUNIT_DEFINE_ACTION_WRAPPER

- new feature adds ability to run tests after boot using debugfs

- fixes and enhancements to string-stream-test:
   - parse ERR_PTR in string_stream_destroy()
   - unchecked dereference in bug fix in debugfs_print_results()
   - handling errors from alloc_string_stream()
   - NULL-dereference bug fix in kunit_init_suite()

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb:

   Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.8-rc1

for you to fetch changes up to 539e582a375dedee95a4fa9ca3f37cdb25c441ec:

   kunit: Fix some comments which were mistakenly kerneldoc (2024-01-03 09:10:37 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-6.8-rc1

This KUnit update for Linux 6.8-rc1 consists of:

- a new feature that adds APIs for managing devices introducing
   a set of helper functions which allow devices (internally a
   struct kunit_device) to be created and managed by KUnit.
   These devices will be automatically unregistered on
   test exit. These helpers can either use a user-provided
   struct device_driver, or have one automatically created and
   managed by KUnit. In both cases, the device lives on a new
   kunit_bus.

- changes to switch drm/tests to use kunit devices

- several fixes and enhancements to attribute feature

- changes to reorganize deferred action function introducing
   KUNIT_DEFINE_ACTION_WRAPPER

- new feature adds ability to run tests after boot using debugfs

- fixes and enhancements to string-stream-test:
   - parse ERR_PTR in string_stream_destroy()
   - unchecked dereference in bug fix in debugfs_print_results()
   - handling errors from alloc_string_stream()
   - NULL-dereference bug fix in kunit_init_suite()

----------------------------------------------------------------
David Gow (4):
       kunit: Add a macro to wrap a deferred action function
       drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
       drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
       kunit: Fix some comments which were mistakenly kerneldoc

Maxime Ripard (1):
       drm/tests: Switch to kunit devices

Michal Wajdeczko (2):
       kunit: Add example for using test->priv
       kunit: Reset test->priv after each param iteration

Rae Moar (8):
       kunit: tool: fix parsing of test attributes
       kunit: tool: add test for parsing attributes
       kunit: move KUNIT_TABLE out of INIT_DATA
       kunit: add KUNIT_INIT_TABLE to init linker section
       kunit: add example suite to test init suites
       kunit: add is_init test attribute
       kunit: add ability to run tests after boot using debugfs
       Documentation: Add debugfs docs with run after boot

Richard Fitzgerald (8):
       kunit: string-stream-test: Avoid cast warning when testing gfp_t flags
       kunit: string-stream: Allow ERR_PTR to be passed to string_stream_destroy()
       kunit: debugfs: Fix unchecked dereference in debugfs_print_results()
       kunit: debugfs: Handle errors from alloc_string_stream()
       kunit: Fix NULL-dereference in kunit_init_suite() if suite->log is NULL
       kunit: Allow passing function pointer to kunit_activate_static_stub()
       kunit: Add example of kunit_activate_static_stub() with pointer-to-function
       kunit: Protect string comparisons against NULL

davidgow@google.com (4):
       kunit: Add APIs for managing devices
       fortify: test: Use kunit_device
       overflow: Replace fake root_device with kunit_device
       ASoC: topology: Replace fake root_device with kunit_device in tests

  Documentation/dev-tools/kunit/api/resource.rst     |   9 +
  Documentation/dev-tools/kunit/run_manual.rst       |  51 +++++-
  Documentation/dev-tools/kunit/running_tips.rst     |   7 +
  Documentation/dev-tools/kunit/usage.rst            |  60 ++++++-
  drivers/gpu/drm/tests/drm_kunit_helpers.c          |  78 +--------
  drivers/gpu/drm/vc4/tests/vc4_mock.c               |   9 +-
  include/asm-generic/vmlinux.lds.h                  |  11 +-
  include/kunit/device.h                             |  80 +++++++++
  include/kunit/resource.h                           |  21 +++
  include/kunit/static_stub.h                        |   2 +-
  include/kunit/test.h                               |  33 ++--
  include/linux/module.h                             |   2 +
  kernel/module/main.c                               |   3 +
  lib/fortify_kunit.c                                |   5 +-
  lib/kunit/Makefile                                 |   3 +-
  lib/kunit/attributes.c                             |  60 +++++++
  lib/kunit/debugfs.c                                | 102 +++++++++++-
  lib/kunit/device-impl.h                            |  17 ++
  lib/kunit/device.c                                 | 181 +++++++++++++++++++++
  lib/kunit/executor.c                               |  68 +++++++-
  lib/kunit/kunit-example-test.c                     |  87 ++++++++++
  lib/kunit/kunit-test.c                             | 139 +++++++++++++++-
  lib/kunit/string-stream-test.c                     |   2 +-
  lib/kunit/string-stream.c                          |   2 +-
  lib/kunit/test.c                                   |  48 +++++-
  lib/overflow_kunit.c                               |   5 +-
  sound/soc/soc-topology-test.c                      |  10 +-
  tools/testing/kunit/kunit_parser.py                |   4 +-
  tools/testing/kunit/kunit_tool_test.py             |  16 ++
  .../kunit/test_data/test_parse_attributes.log      |   9 +
  30 files changed, 978 insertions(+), 146 deletions(-)
  create mode 100644 include/kunit/device.h
  create mode 100644 lib/kunit/device-impl.h
  create mode 100644 lib/kunit/device.c
  create mode 100644 tools/testing/kunit/test_data/test_parse_attributes.log
----------------------------------------------------------------
--------------iq8LG0chExFtyjSpGrBvnQOH
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.8-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-kunit-6.8-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L2FwaS9yZXNvdXJj
ZS5yc3QgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9hcGkvcmVzb3VyY2UucnN0
CmluZGV4IDBhOTRmODMxMjU5ZS4uZWM2MDAyYTZiMGRiIDEwMDY0NAotLS0gYS9Eb2N1bWVu
dGF0aW9uL2Rldi10b29scy9rdW5pdC9hcGkvcmVzb3VyY2UucnN0CisrKyBiL0RvY3VtZW50
YXRpb24vZGV2LXRvb2xzL2t1bml0L2FwaS9yZXNvdXJjZS5yc3QKQEAgLTExLDMgKzExLDEy
IEBAIHN0YXRlIG9uIGEgcGVyLXRlc3QgYmFzaXMsIHJlZ2lzdGVyIGN1c3RvbSBjbGVhbnVw
IGFjdGlvbnMsIGFuZCBtb3JlLgogCiAuLiBrZXJuZWwtZG9jOjogaW5jbHVkZS9rdW5pdC9y
ZXNvdXJjZS5oCiAgICA6aW50ZXJuYWw6CisKK01hbmFnZWQgRGV2aWNlcworLS0tLS0tLS0t
LS0tLS0tCisKK0Z1bmN0aW9ucyBmb3IgdXNpbmcgS1VuaXQtbWFuYWdlZCBzdHJ1Y3QgZGV2
aWNlIGFuZCBzdHJ1Y3QgZGV2aWNlX2RyaXZlci4KK0luY2x1ZGUgYGBrdW5pdC9kZXZpY2Uu
aGBgIHRvIHVzZSB0aGVzZS4KKworLi4ga2VybmVsLWRvYzo6IGluY2x1ZGUva3VuaXQvZGV2
aWNlLmgKKyAgIDppbnRlcm5hbDoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRv
b2xzL2t1bml0L3J1bl9tYW51YWwucnN0IGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3Vu
aXQvcnVuX21hbnVhbC5yc3QKaW5kZXggZTdiNDY0MjFmMjQ3Li42OTlkOTI4ODUwNzUgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bl9tYW51YWwucnN0
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bl9tYW51YWwucnN0CkBA
IC00OSw5ICs0OSw1MiBAQCBsb2FkZWQuCiAKIFRoZSByZXN1bHRzIHdpbGwgYXBwZWFyIGlu
IFRBUCBmb3JtYXQgaW4gYGBkbWVzZ2BgLgogCitkZWJ1Z2ZzCis9PT09PT09CisKK0tVbml0
IGNhbiBiZSBhY2Nlc3NlZCBmcm9tIHVzZXJzcGFjZSB2aWEgdGhlIGRlYnVnZnMgZmlsZXN5
c3RlbSAoU2VlIG1vcmUKK2luZm9ybWF0aW9uIGFib3V0IGRlYnVnZnMgYXQgRG9jdW1lbnRh
dGlvbi9maWxlc3lzdGVtcy9kZWJ1Z2ZzLnJzdCkuCisKK0lmIGBgQ09ORklHX0tVTklUX0RF
QlVHRlNgYCBpcyBlbmFibGVkLCB0aGUgS1VuaXQgZGVidWdmcyBmaWxlc3lzdGVtIGlzCitt
b3VudGVkIGF0IC9zeXMva2VybmVsL2RlYnVnL2t1bml0LiBZb3UgY2FuIHVzZSB0aGlzIGZp
bGVzeXN0ZW0gdG8gcGVyZm9ybQordGhlIGZvbGxvd2luZyBhY3Rpb25zLgorCitSZXRyaWV2
ZSBUZXN0IFJlc3VsdHMKKz09PT09PT09PT09PT09PT09PT09PQorCitZb3UgY2FuIHVzZSBk
ZWJ1Z2ZzIHRvIHJldHJpZXZlIEtVbml0IHRlc3QgcmVzdWx0cy4gVGhlIHRlc3QgcmVzdWx0
cyBhcmUKK2FjY2Vzc2libGUgZnJvbSB0aGUgZGVidWdmcyBmaWxlc3lzdGVtIGluIHRoZSBm
b2xsb3dpbmcgcmVhZC1vbmx5IGZpbGU6CisKKy4uIGNvZGUtYmxvY2sgOjogYmFzaAorCisJ
L3N5cy9rZXJuZWwvZGVidWcva3VuaXQvPHRlc3Rfc3VpdGU+L3Jlc3VsdHMKKworVGhlIHRl
c3QgcmVzdWx0cyBhcmUgcHJpbnRlZCBpbiBhIEtUQVAgZG9jdW1lbnQuIE5vdGUgdGhpcyBk
b2N1bWVudCBpcyBzZXBhcmF0ZQordG8gdGhlIGtlcm5lbCBsb2cgYW5kIHRodXMsIG1heSBo
YXZlIGRpZmZlcmVudCB0ZXN0IHN1aXRlIG51bWJlcmluZy4KKworUnVuIFRlc3RzIEFmdGVy
IEtlcm5lbCBIYXMgQm9vdGVkCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
KworWW91IGNhbiB1c2UgdGhlIGRlYnVnZnMgZmlsZXN5c3RlbSB0byB0cmlnZ2VyIGJ1aWx0
LWluIHRlc3RzIHRvIHJ1biBhZnRlcgorYm9vdC4gVG8gcnVuIHRoZSB0ZXN0IHN1aXRlLCB5
b3UgY2FuIHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgdG8gd3JpdGUgdG8KK3RoZSBgYC9z
eXMva2VybmVsL2RlYnVnL2t1bml0Lzx0ZXN0X3N1aXRlPi9ydW5gYCBmaWxlOgorCisuLiBj
b2RlLWJsb2NrIDo6IGJhc2gKKworCWVjaG8gImFueSBzdHJpbmciID4gL3N5cy9rZXJuZWwv
ZGVidWdmcy9rdW5pdC88dGVzdF9zdWl0ZT4vcnVuCisKK0FzIGEgcmVzdWx0LCB0aGUgdGVz
dCBzdWl0ZSBydW5zIGFuZCB0aGUgcmVzdWx0cyBhcmUgcHJpbnRlZCB0byB0aGUga2VybmVs
Citsb2cuCisKK0hvd2V2ZXIsIHRoaXMgZmVhdHVyZSBpcyBub3QgYXZhaWxhYmxlIHdpdGgg
S1VuaXQgc3VpdGVzIHRoYXQgdXNlIGluaXQgZGF0YSwKK2JlY2F1c2UgaW5pdCBkYXRhIG1h
eSBoYXZlIGJlZW4gZGlzY2FyZGVkIGFmdGVyIHRoZSBrZXJuZWwgYm9vdHMuIEtVbml0Citz
dWl0ZXMgdGhhdCB1c2UgaW5pdCBkYXRhIHNob3VsZCBiZSBkZWZpbmVkIHVzaW5nIHRoZQor
a3VuaXRfdGVzdF9pbml0X3NlY3Rpb25fc3VpdGVzKCkgbWFjcm8uCisKK0Fsc28sIHlvdSBj
YW5ub3QgdXNlIHRoaXMgZmVhdHVyZSB0byBydW4gdGVzdHMgY29uY3VycmVudGx5LiBJbnN0
ZWFkIGEgdGVzdAord2lsbCB3YWl0IHRvIHJ1biB1bnRpbCBvdGhlciB0ZXN0cyBoYXZlIGNv
bXBsZXRlZCBvciBmYWlsZWQuCisKIC4uIG5vdGUgOjoKIAotCUlmIGBgQ09ORklHX0tVTklU
X0RFQlVHRlNgYCBpcyBlbmFibGVkLCBLVW5pdCB0ZXN0IHJlc3VsdHMgd2lsbAotCWJlIGFj
Y2Vzc2libGUgZnJvbSB0aGUgYGBkZWJ1Z2ZzYGAgZmlsZXN5c3RlbSAoaWYgbW91bnRlZCku
Ci0JVGhleSB3aWxsIGJlIGluIGBgL3N5cy9rZXJuZWwvZGVidWcva3VuaXQvPHRlc3Rfc3Vp
dGU+L3Jlc3VsdHNgYCwgaW4KLQlUQVAgZm9ybWF0LgorCUZvciB0ZXN0IGF1dGhvcnMsIHRv
IHVzZSB0aGlzIGZlYXR1cmUsIHRlc3RzIHdpbGwgbmVlZCB0byBjb3JyZWN0bHkgaW5pdGlh
bGlzZQorCWFuZC9vciBjbGVhbiB1cCBhbnkgZGF0YSwgc28gdGhlIHRlc3QgcnVucyBjb3Jy
ZWN0bHkgYSBzZWNvbmQgdGltZS4KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRv
b2xzL2t1bml0L3J1bm5pbmdfdGlwcy5yc3QgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
dW5pdC9ydW5uaW5nX3RpcHMucnN0CmluZGV4IDc2NmY5Y2RlYTBmYS4uMDI0ZTlhZDFkMWU5
IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9ydW5uaW5nX3Rp
cHMucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bm5pbmdfdGlw
cy5yc3QKQEAgLTQyOCwzICs0MjgsMTAgQEAgVGhpcyBhdHRyaWJ1dGUgaW5kaWNhdGVzIHRo
ZSBuYW1lIG9mIHRoZSBtb2R1bGUgYXNzb2NpYXRlZCB3aXRoIHRoZSB0ZXN0LgogCiBUaGlz
IGF0dHJpYnV0ZSBpcyBhdXRvbWF0aWNhbGx5IHNhdmVkIGFzIGEgc3RyaW5nIGFuZCBpcyBw
cmludGVkIGZvciBlYWNoIHN1aXRlLgogVGVzdHMgY2FuIGFsc28gYmUgZmlsdGVyZWQgdXNp
bmcgdGhpcyBhdHRyaWJ1dGUuCisKK2BgaXNfaW5pdGBgCisKK1RoaXMgYXR0cmlidXRlIGlu
ZGljYXRlcyB3aGV0aGVyIHRoZSB0ZXN0IHVzZXMgaW5pdCBkYXRhIG9yIGZ1bmN0aW9ucy4K
KworVGhpcyBhdHRyaWJ1dGUgaXMgYXV0b21hdGljYWxseSBzYXZlZCBhcyBhIGJvb2xlYW4g
YW5kIHRlc3RzIGNhbiBhbHNvIGJlCitmaWx0ZXJlZCB1c2luZyB0aGlzIGF0dHJpYnV0ZS4K
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdCBi
L0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdAppbmRleCBjMjdlMTY0
NmVjZDkuLjUzYzZmN2RjOGE0MiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9v
bHMva3VuaXQvdXNhZ2UucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0
L3VzYWdlLnJzdApAQCAtNjUxLDEyICs2NTEsMTYgQEAgRm9yIGV4YW1wbGU6CiAJfQogCiBO
b3RlIHRoYXQsIGZvciBmdW5jdGlvbnMgbGlrZSBkZXZpY2VfdW5yZWdpc3RlciB3aGljaCBv
bmx5IGFjY2VwdCBhIHNpbmdsZQotcG9pbnRlci1zaXplZCBhcmd1bWVudCwgaXQncyBwb3Nz
aWJsZSB0byBkaXJlY3RseSBjYXN0IHRoYXQgZnVuY3Rpb24gdG8KLWEgYGBrdW5pdF9hY3Rp
b25fdGBgIHJhdGhlciB0aGFuIHdyaXRpbmcgYSB3cmFwcGVyIGZ1bmN0aW9uLCBmb3IgZXhh
bXBsZToKK3BvaW50ZXItc2l6ZWQgYXJndW1lbnQsIGl0J3MgcG9zc2libGUgdG8gYXV0b21h
dGljYWxseSBnZW5lcmF0ZSBhIHdyYXBwZXIKK3dpdGggdGhlIGBgS1VOSVRfREVGSU5FX0FD
VElPTl9XUkFQUEVSKClgYCBtYWNybywgZm9yIGV4YW1wbGU6CiAKIC4uIGNvZGUtYmxvY2s6
OiBDCiAKLQlrdW5pdF9hZGRfYWN0aW9uKHRlc3QsIChrdW5pdF9hY3Rpb25fdCAqKSZkZXZp
Y2VfdW5yZWdpc3RlciwgJmRldik7CisJS1VOSVRfREVGSU5FX0FDVElPTl9XUkFQUEVSKGRl
dmljZV91bnJlZ2lzdGVyLCBkZXZpY2VfdW5yZWdpc3Rlcl93cmFwcGVyLCBzdHJ1Y3QgZGV2
aWNlICopOworCWt1bml0X2FkZF9hY3Rpb24odGVzdCwgJmRldmljZV91bnJlZ2lzdGVyX3dy
YXBwZXIsICZkZXYpOworCitZb3Ugc2hvdWxkIGRvIHRoaXMgaW4gcHJlZmVyZW5jZSB0byBt
YW51YWxseSBjYXN0aW5nIHRvIHRoZSBgYGt1bml0X2FjdGlvbl90YGAgdHlwZSwKK2FzIGNh
c3RpbmcgZnVuY3Rpb24gcG9pbnRlcnMgd2lsbCBicmVhayBDb250cm9sIEZsb3cgSW50ZWdy
aXR5IChDRkkpLgogCiBgYGt1bml0X2FkZF9hY3Rpb25gYCBjYW4gZmFpbCBpZiwgZm9yIGV4
YW1wbGUsIHRoZSBzeXN0ZW0gaXMgb3V0IG9mIG1lbW9yeS4KIFlvdSBjYW4gdXNlIGBga3Vu
aXRfYWRkX2FjdGlvbl9vcl9yZXNldGBgIGluc3RlYWQgd2hpY2ggcnVucyB0aGUgYWN0aW9u
CkBAIC03OTMsMyArNzk3LDUzIEBAIHN0cnVjdHVyZXMgYXMgc2hvd24gYmVsb3c6CiBLVW5p
dCBpcyBub3QgZW5hYmxlZCwgb3IgaWYgbm8gdGVzdCBpcyBydW5uaW5nIGluIHRoZSBjdXJy
ZW50IHRhc2ssIGl0IHdpbGwgZG8KIG5vdGhpbmcuIFRoaXMgY29tcGlsZXMgZG93biB0byBl
aXRoZXIgYSBuby1vcCBvciBhIHN0YXRpYyBrZXkgY2hlY2ssIHNvIHdpbGwKIGhhdmUgYSBu
ZWdsaWdpYmxlIHBlcmZvcm1hbmNlIGltcGFjdCB3aGVuIG5vIHRlc3QgaXMgcnVubmluZy4K
KworTWFuYWdpbmcgRmFrZSBEZXZpY2VzIGFuZCBEcml2ZXJzCistLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KKworV2hlbiB0ZXN0aW5nIGRyaXZlcnMgb3IgY29kZSB3aGlj
aCBpbnRlcmFjdHMgd2l0aCBkcml2ZXJzLCBtYW55IGZ1bmN0aW9ucyB3aWxsCityZXF1aXJl
IGEgYGBzdHJ1Y3QgZGV2aWNlYGAgb3IgYGBzdHJ1Y3QgZGV2aWNlX2RyaXZlcmBgLiBJbiBt
YW55IGNhc2VzLCBzZXR0aW5nCit1cCBhIHJlYWwgZGV2aWNlIGlzIG5vdCByZXF1aXJlZCB0
byB0ZXN0IGFueSBnaXZlbiBmdW5jdGlvbiwgc28gYSBmYWtlIGRldmljZQorY2FuIGJlIHVz
ZWQgaW5zdGVhZC4KKworS1VuaXQgcHJvdmlkZXMgaGVscGVyIGZ1bmN0aW9ucyB0byBjcmVh
dGUgYW5kIG1hbmFnZSB0aGVzZSBmYWtlIGRldmljZXMsIHdoaWNoCithcmUgaW50ZXJuYWxs
eSBvZiB0eXBlIGBgc3RydWN0IGt1bml0X2RldmljZWBgLCBhbmQgYXJlIGF0dGFjaGVkIHRv
IGEgc3BlY2lhbAorYGBrdW5pdF9idXNgYC4gVGhlc2UgZGV2aWNlcyBzdXBwb3J0IG1hbmFn
ZWQgZGV2aWNlIHJlc291cmNlcyAoZGV2cmVzKSwgYXMKK2Rlc2NyaWJlZCBpbiBEb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvZHJpdmVyLW1vZGVsL2RldnJlcy5yc3QKKworVG8gY3JlYXRl
IGEgS1VuaXQtbWFuYWdlZCBgYHN0cnVjdCBkZXZpY2VfZHJpdmVyYGAsIHVzZSBgYGt1bml0
X2RyaXZlcl9jcmVhdGUoKWBgLAord2hpY2ggd2lsbCBjcmVhdGUgYSBkcml2ZXIgd2l0aCB0
aGUgZ2l2ZW4gbmFtZSwgb24gdGhlIGBga3VuaXRfYnVzYGAuIFRoaXMgZHJpdmVyCit3aWxs
IGF1dG9tYXRpY2FsbHkgYmUgZGVzdHJveWVkIHdoZW4gdGhlIGNvcnJlc3BvbmRpbmcgdGVz
dCBmaW5pc2hlcywgYnV0IGNhbiBhbHNvCitiZSBtYW51YWxseSBkZXN0cm95ZWQgd2l0aCBg
YGRyaXZlcl91bnJlZ2lzdGVyKClgYC4KKworVG8gY3JlYXRlIGEgZmFrZSBkZXZpY2UsIHVz
ZSB0aGUgYGBrdW5pdF9kZXZpY2VfcmVnaXN0ZXIoKWBgLCB3aGljaCB3aWxsIGNyZWF0ZQor
YW5kIHJlZ2lzdGVyIGEgZGV2aWNlLCB1c2luZyBhIG5ldyBLVW5pdC1tYW5hZ2VkIGRyaXZl
ciBjcmVhdGVkIHdpdGggYGBrdW5pdF9kcml2ZXJfY3JlYXRlKClgYC4KK1RvIHByb3ZpZGUg
YSBzcGVjaWZpYywgbm9uLUtVbml0LW1hbmFnZWQgZHJpdmVyLCB1c2UgYGBrdW5pdF9kZXZp
Y2VfcmVnaXN0ZXJfd2l0aF9kcml2ZXIoKWBgCitpbnN0ZWFkLiBMaWtlIHdpdGggbWFuYWdl
ZCBkcml2ZXJzLCBLVW5pdC1tYW5hZ2VkIGZha2UgZGV2aWNlcyBhcmUgYXV0b21hdGljYWxs
eQorY2xlYW5lZCB1cCB3aGVuIHRoZSB0ZXN0IGZpbmlzaGVzLCBidXQgY2FuIGJlIG1hbnVh
bGx5IGNsZWFuZWQgdXAgZWFybHkgd2l0aAorYGBrdW5pdF9kZXZpY2VfdW5yZWdpc3Rlcigp
YGAuCisKK1RoZSBLVW5pdCBkZXZpY2VzIHNob3VsZCBiZSB1c2VkIGluIHByZWZlcmVuY2Ug
dG8gYGByb290X2RldmljZV9yZWdpc3RlcigpYGAsIGFuZAoraW5zdGVhZCBvZiBgYHBsYXRm
b3JtX2RldmljZV9yZWdpc3RlcigpYGAgaW4gY2FzZXMgd2hlcmUgdGhlIGRldmljZSBpcyBu
b3Qgb3RoZXJ3aXNlCithIHBsYXRmb3JtIGRldmljZS4KKworRm9yIGV4YW1wbGU6CisKKy4u
IGNvZGUtYmxvY2s6OiBjCisKKwkjaW5jbHVkZSA8a3VuaXQvZGV2aWNlLmg+CisKKwlzdGF0
aWMgdm9pZCB0ZXN0X215X2RldmljZShzdHJ1Y3Qga3VuaXQgKnRlc3QpCisJeworCQlzdHJ1
Y3QgZGV2aWNlICpmYWtlX2RldmljZTsKKwkJY29uc3QgY2hhciAqZGV2X21hbmFnZWRfc3Ry
aW5nOworCisJCS8vIENyZWF0ZSBhIGZha2UgZGV2aWNlLgorCQlmYWtlX2RldmljZSA9IGt1
bml0X2RldmljZV9yZWdpc3Rlcih0ZXN0LCAibXlfZGV2aWNlIik7CisJCUtVTklUX0FTU0VS
VF9OT1RfRVJSX09SX05VTEwodGVzdCwgZmFrZV9kZXZpY2UpCisKKwkJLy8gUGFzcyBpdCB0
byBmdW5jdGlvbnMgd2hpY2ggbmVlZCBhIGRldmljZS4KKwkJZGV2X21hbmFnZWRfc3RyaW5n
ID0gZGV2bV9rc3RyZHVwKGZha2VfZGV2aWNlLCAiSGVsbG8sIFdvcmxkISIpOworCisJCS8v
IEV2ZXJ5dGhpbmcgaXMgY2xlYW5lZCB1cCBhdXRvbWF0aWNhbGx5IHdoZW4gdGhlIHRlc3Qg
ZW5kcy4KKwl9ClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3Rlc3RzL2RybV9rdW5pdF9oZWxwZXJzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vdGVzdHMvZHJtX2t1bml0X2hlbHBlcnMuYwppbmRleCBiY2NiMzNiOTAwZjMuLmNhNGY4
ZTRjNWQ1ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9rdW5pdF9o
ZWxwZXJzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9rdW5pdF9oZWxwZXJz
LmMKQEAgLTUsNiArNSw3IEBACiAjaW5jbHVkZSA8ZHJtL2RybV9rdW5pdF9oZWxwZXJzLmg+
CiAjaW5jbHVkZSA8ZHJtL2RybV9tYW5hZ2VkLmg+CiAKKyNpbmNsdWRlIDxrdW5pdC9kZXZp
Y2UuaD4KICNpbmNsdWRlIDxrdW5pdC9yZXNvdXJjZS5oPgogCiAjaW5jbHVkZSA8bGludXgv
ZGV2aWNlLmg+CkBAIC0xNSw0MCArMTYsNiBAQAogc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1f
bW9kZV9jb25maWdfZnVuY3MgZHJtX21vZGVfY29uZmlnX2Z1bmNzID0gewogfTsKIAotc3Rh
dGljIGludCBmYWtlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCi17Ci0J
cmV0dXJuIDA7Ci19Ci0KLXN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGZha2VfcGxh
dGZvcm1fZHJpdmVyID0gewotCS5wcm9iZQk9IGZha2VfcHJvYmUsCi0JLmRyaXZlciA9IHsK
LQkJLm5hbWUJPSBLVU5JVF9ERVZJQ0VfTkFNRSwKLQl9LAotfTsKLQotc3RhdGljIHZvaWQg
a3VuaXRfYWN0aW9uX3BsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKHZvaWQgKnB0cikKLXsK
LQlzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyICpkcnYgPSBwdHI7Ci0KLQlwbGF0Zm9ybV9kcml2
ZXJfdW5yZWdpc3RlcihkcnYpOwotCi19Ci0KLXN0YXRpYyB2b2lkIGt1bml0X2FjdGlvbl9w
bGF0Zm9ybV9kZXZpY2VfcHV0KHZvaWQgKnB0cikKLXsKLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2ID0gcHRyOwotCi0JcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsKLX0KLQot
c3RhdGljIHZvaWQga3VuaXRfYWN0aW9uX3BsYXRmb3JtX2RldmljZV9kZWwodm9pZCAqcHRy
KQotewotCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBwdHI7Ci0KLQlwbGF0Zm9y
bV9kZXZpY2VfZGVsKHBkZXYpOwotfQotCiAvKioKICAqIGRybV9rdW5pdF9oZWxwZXJfYWxs
b2NfZGV2aWNlIC0gQWxsb2NhdGUgYSBtb2NrIGRldmljZSBmb3IgYSBLVW5pdCB0ZXN0CiAg
KiBAdGVzdDogVGhlIHRlc3QgY29udGV4dCBvYmplY3QKQEAgLTY2LDM0ICszMyw3IEBAIHN0
YXRpYyB2b2lkIGt1bml0X2FjdGlvbl9wbGF0Zm9ybV9kZXZpY2VfZGVsKHZvaWQgKnB0cikK
ICAqLwogc3RydWN0IGRldmljZSAqZHJtX2t1bml0X2hlbHBlcl9hbGxvY19kZXZpY2Uoc3Ry
dWN0IGt1bml0ICp0ZXN0KQogewotCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7Ci0J
aW50IHJldDsKLQotCXJldCA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmZmFrZV9wbGF0
Zm9ybV9kcml2ZXIpOwotCUtVTklUX0FTU0VSVF9FUSh0ZXN0LCByZXQsIDApOwotCi0JcmV0
ID0ga3VuaXRfYWRkX2FjdGlvbl9vcl9yZXNldCh0ZXN0LAotCQkJCQlrdW5pdF9hY3Rpb25f
cGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIsCi0JCQkJCSZmYWtlX3BsYXRmb3JtX2RyaXZl
cik7Ci0JS1VOSVRfQVNTRVJUX0VRKHRlc3QsIHJldCwgMCk7Ci0KLQlwZGV2ID0gcGxhdGZv
cm1fZGV2aWNlX2FsbG9jKEtVTklUX0RFVklDRV9OQU1FLCBQTEFURk9STV9ERVZJRF9OT05F
KTsKLQlLVU5JVF9BU1NFUlRfTk9UX0VSUl9PUl9OVUxMKHRlc3QsIHBkZXYpOwotCi0JcmV0
ID0ga3VuaXRfYWRkX2FjdGlvbl9vcl9yZXNldCh0ZXN0LAotCQkJCQlrdW5pdF9hY3Rpb25f
cGxhdGZvcm1fZGV2aWNlX3B1dCwKLQkJCQkJcGRldik7Ci0JS1VOSVRfQVNTRVJUX0VRKHRl
c3QsIHJldCwgMCk7Ci0KLQlyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKHBkZXYpOwotCUtV
TklUX0FTU0VSVF9FUSh0ZXN0LCByZXQsIDApOwotCi0JcmV0ID0ga3VuaXRfYWRkX2FjdGlv
bl9vcl9yZXNldCh0ZXN0LAotCQkJCQlrdW5pdF9hY3Rpb25fcGxhdGZvcm1fZGV2aWNlX2Rl
bCwKLQkJCQkJcGRldik7Ci0JS1VOSVRfQVNTRVJUX0VRKHRlc3QsIHJldCwgMCk7Ci0KLQly
ZXR1cm4gJnBkZXYtPmRldjsKKwlyZXR1cm4ga3VuaXRfZGV2aWNlX3JlZ2lzdGVyKHRlc3Qs
IEtVTklUX0RFVklDRV9OQU1FKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGRybV9rdW5pdF9o
ZWxwZXJfYWxsb2NfZGV2aWNlKTsKIApAQCAtMTA2LDE5ICs0Niw3IEBAIEVYUE9SVF9TWU1C
T0xfR1BMKGRybV9rdW5pdF9oZWxwZXJfYWxsb2NfZGV2aWNlKTsKICAqLwogdm9pZCBkcm1f
a3VuaXRfaGVscGVyX2ZyZWVfZGV2aWNlKHN0cnVjdCBrdW5pdCAqdGVzdCwgc3RydWN0IGRl
dmljZSAqZGV2KQogewotCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0
Zm9ybV9kZXZpY2UoZGV2KTsKLQotCWt1bml0X3JlbGVhc2VfYWN0aW9uKHRlc3QsCi0JCQkg
ICAgIGt1bml0X2FjdGlvbl9wbGF0Zm9ybV9kZXZpY2VfZGVsLAotCQkJICAgICBwZGV2KTsK
LQotCWt1bml0X3JlbGVhc2VfYWN0aW9uKHRlc3QsCi0JCQkgICAgIGt1bml0X2FjdGlvbl9w
bGF0Zm9ybV9kZXZpY2VfcHV0LAotCQkJICAgICBwZGV2KTsKLQotCWt1bml0X3JlbGVhc2Vf
YWN0aW9uKHRlc3QsCi0JCQkgICAgIGt1bml0X2FjdGlvbl9wbGF0Zm9ybV9kcml2ZXJfdW5y
ZWdpc3RlciwKLQkJCSAgICAgJmZha2VfcGxhdGZvcm1fZHJpdmVyKTsKKwlrdW5pdF9kZXZp
Y2VfdW5yZWdpc3Rlcih0ZXN0LCBkZXYpOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoZHJtX2t1
bml0X2hlbHBlcl9mcmVlX2RldmljZSk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS92YzQvdGVzdHMvdmM0X21vY2suYyBiL2RyaXZlcnMvZ3B1L2RybS92YzQvdGVzdHMvdmM0
X21vY2suYwppbmRleCA2M2NhNDZmNGNiMzUuLmJlY2IzZGJhYTU0OCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3ZjNC90ZXN0cy92YzRfbW9jay5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS92YzQvdGVzdHMvdmM0X21vY2suYwpAQCAtMTUzLDEyICsxNTMsOSBAQCBzdGF0aWMg
aW50IF9fYnVpbGRfbW9jayhzdHJ1Y3Qga3VuaXQgKnRlc3QsIHN0cnVjdCBkcm1fZGV2aWNl
ICpkcm0sCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIGt1bml0X2FjdGlvbl9kcm1f
ZGV2X3VucmVnaXN0ZXIodm9pZCAqcHRyKQotewotCXN0cnVjdCBkcm1fZGV2aWNlICpkcm0g
PSBwdHI7Ci0KLQlkcm1fZGV2X3VucmVnaXN0ZXIoZHJtKTsKLX0KK0tVTklUX0RFRklORV9B
Q1RJT05fV1JBUFBFUihrdW5pdF9hY3Rpb25fZHJtX2Rldl91bnJlZ2lzdGVyLAorCQkJICAg
IGRybV9kZXZfdW5yZWdpc3RlciwKKwkJCSAgICBzdHJ1Y3QgZHJtX2RldmljZSAqKTsKIAog
c3RhdGljIHN0cnVjdCB2YzRfZGV2ICpfX21vY2tfZGV2aWNlKHN0cnVjdCBrdW5pdCAqdGVz
dCwgYm9vbCBpc192YzUpCiB7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL3Zt
bGludXgubGRzLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGludXgubGRzLmgKaW5kZXgg
YmFlMGZlNGQ0OTliLi41ZGQzYTYxZDY3M2QgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdl
bmVyaWMvdm1saW51eC5sZHMuaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGludXgu
bGRzLmgKQEAgLTM3MCw3ICszNzAsOCBAQAogCUJSQU5DSF9QUk9GSUxFKCkJCQkJCQlcCiAJ
VFJBQ0VfUFJJTlRLUygpCQkJCQkJCVwKIAlCUEZfUkFXX1RQKCkJCQkJCQkJXAotCVRSQUNF
UE9JTlRfU1RSKCkKKwlUUkFDRVBPSU5UX1NUUigpCQkJCQkJXAorCUtVTklUX1RBQkxFKCkK
IAogLyoKICAqIERhdGEgc2VjdGlvbiBoZWxwZXJzCkBAIC03MDAsNyArNzAxLDcgQEAKIAlF
QVJMWUNPTl9UQUJMRSgpCQkJCQkJXAogCUxTTV9UQUJMRSgpCQkJCQkJCVwKIAlFQVJMWV9M
U01fVEFCTEUoKQkJCQkJCVwKLQlLVU5JVF9UQUJMRSgpCisJS1VOSVRfSU5JVF9UQUJMRSgp
CiAKICNkZWZpbmUgSU5JVF9URVhUCQkJCQkJCVwKIAkqKC5pbml0LnRleHQgLmluaXQudGV4
dC4qKQkJCQkJXApAQCAtOTI2LDYgKzkyNywxMiBAQAogCQkuID0gQUxJR04oOCk7CQkJCQkJ
XAogCQlCT1VOREVEX1NFQ1RJT05fUE9TVF9MQUJFTCgua3VuaXRfdGVzdF9zdWl0ZXMsIF9f
a3VuaXRfc3VpdGVzLCBfc3RhcnQsIF9lbmQpCiAKKy8qIEFsaWdubWVudCBtdXN0IGJlIGNv
bnNpc3RlbnQgd2l0aCAoa3VuaXRfc3VpdGUgKikgaW4gaW5jbHVkZS9rdW5pdC90ZXN0Lmgg
Ki8KKyNkZWZpbmUgS1VOSVRfSU5JVF9UQUJMRSgpCQkJCQkJXAorCQkuID0gQUxJR04oOCk7
CQkJCQkJXAorCQlCT1VOREVEX1NFQ1RJT05fUE9TVF9MQUJFTCgua3VuaXRfaW5pdF90ZXN0
X3N1aXRlcywgXAorCQkJCV9fa3VuaXRfaW5pdF9zdWl0ZXMsIF9zdGFydCwgX2VuZCkKKwog
I2lmZGVmIENPTkZJR19CTEtfREVWX0lOSVRSRAogI2RlZmluZSBJTklUX1JBTV9GUwkJCQkJ
CQlcCiAJLiA9IEFMSUdOKDQpOwkJCQkJCQlcCmRpZmYgLS1naXQgYS9pbmNsdWRlL2t1bml0
L2RldmljZS5oIGIvaW5jbHVkZS9rdW5pdC9kZXZpY2UuaApuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjI0NTAxMTBhZDY0ZQotLS0gL2Rldi9udWxsCisrKyBi
L2luY2x1ZGUva3VuaXQvZGV2aWNlLmgKQEAgLTAsMCArMSw4MCBAQAorLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KKy8qCisgKiBLVW5pdCBiYXNpYyBkZXZpY2Ug
aW1wbGVtZW50YXRpb24KKyAqCisgKiBIZWxwZXJzIGZvciBjcmVhdGluZyBhbmQgbWFuYWdp
bmcgZmFrZSBkZXZpY2VzIGZvciBLVW5pdCB0ZXN0cy4KKyAqCisgKiBDb3B5cmlnaHQgKEMp
IDIwMjMsIEdvb2dsZSBMTEMuCisgKiBBdXRob3I6IERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29v
Z2xlLmNvbT4KKyAqLworCisjaWZuZGVmIF9LVU5JVF9ERVZJQ0VfSAorI2RlZmluZSBfS1VO
SVRfREVWSUNFX0gKKworI2lmIElTX0VOQUJMRUQoQ09ORklHX0tVTklUKQorCisjaW5jbHVk
ZSA8a3VuaXQvdGVzdC5oPgorCitzdHJ1Y3QgZGV2aWNlOworc3RydWN0IGRldmljZV9kcml2
ZXI7CisKKy8qKgorICoga3VuaXRfZHJpdmVyX2NyZWF0ZSgpIC0gQ3JlYXRlIGEgc3RydWN0
IGRldmljZV9kcml2ZXIgYXR0YWNoZWQgdG8gdGhlIGt1bml0X2J1cworICogQHRlc3Q6IFRo
ZSB0ZXN0IGNvbnRleHQgb2JqZWN0LgorICogQG5hbWU6IFRoZSBuYW1lIHRvIGdpdmUgdGhl
IGNyZWF0ZWQgZHJpdmVyLgorICoKKyAqIENyZWF0ZXMgYSBzdHJ1Y3QgZGV2aWNlX2RyaXZl
ciBhdHRhY2hlZCB0byB0aGUga3VuaXRfYnVzLCB3aXRoIHRoZSBuYW1lIEBuYW1lLgorICog
VGhpcyBkcml2ZXIgd2lsbCBhdXRvbWF0aWNhbGx5IGJlIGNsZWFuZWQgdXAgb24gdGVzdCBl
eGl0LgorICoKKyAqIFJldHVybjogYSBzdHViIHN0cnVjdCBkZXZpY2VfZHJpdmVyLCBtYW5h
Z2VkIGJ5IEtVbml0LCB3aXRoIHRoZSBuYW1lIEBuYW1lLgorICovCitzdHJ1Y3QgZGV2aWNl
X2RyaXZlciAqa3VuaXRfZHJpdmVyX2NyZWF0ZShzdHJ1Y3Qga3VuaXQgKnRlc3QsIGNvbnN0
IGNoYXIgKm5hbWUpOworCisvKioKKyAqIGt1bml0X2RldmljZV9yZWdpc3RlcigpIC0gQ3Jl
YXRlIGEgc3RydWN0IGRldmljZSBmb3IgdXNlIGluIEtVbml0IHRlc3RzCisgKiBAdGVzdDog
VGhlIHRlc3QgY29udGV4dCBvYmplY3QuCisgKiBAbmFtZTogVGhlIG5hbWUgdG8gZ2l2ZSB0
aGUgY3JlYXRlZCBkZXZpY2UuCisgKgorICogQ3JlYXRlcyBhIHN0cnVjdCBrdW5pdF9kZXZp
Y2UgKHdoaWNoIGlzIGEgc3RydWN0IGRldmljZSkgd2l0aCB0aGUgZ2l2ZW4gbmFtZSwKKyAq
IGFuZCBhIGNvcnJlc3BvbmRpbmcgZHJpdmVyLiBUaGUgZGV2aWNlIGFuZCBkcml2ZXIgd2ls
bCBiZSBjbGVhbmVkIHVwIG9uIHRlc3QKKyAqIGV4aXQsIG9yIHdoZW4ga3VuaXRfZGV2aWNl
X3VucmVnaXN0ZXIgaXMgY2FsbGVkLiBTZWUgYWxzbworICoga3VuaXRfZGV2aWNlX3JlZ2lz
dGVyX3dpdGhfZHJpdmVyLCBpZiB5b3Ugd2lzaCB0byBwcm92aWRlIHlvdXIgb3duCisgKiBz
dHJ1Y3QgZGV2aWNlX2RyaXZlci4KKyAqCisgKiBSZXR1cm46IGEgcG9pbnRlciB0byBhIHN0
cnVjdCBkZXZpY2Ugd2hpY2ggd2lsbCBiZSBjbGVhbmVkIHVwIHdoZW4gdGhlIHRlc3QKKyAq
IGV4aXRzLCBvciBhbiBlcnJvciBwb2ludGVyIGlmIHRoZSBkZXZpY2UgY291bGQgbm90IGJl
IGFsbG9jYXRlZCBvciByZWdpc3RlcmVkLgorICovCitzdHJ1Y3QgZGV2aWNlICprdW5pdF9k
ZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCBjaGFyICpuYW1lKTsK
KworLyoqCisgKiBrdW5pdF9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9kcml2ZXIoKSAtIENyZWF0
ZSBhIHN0cnVjdCBkZXZpY2UgZm9yIHVzZSBpbiBLVW5pdCB0ZXN0cworICogQHRlc3Q6IFRo
ZSB0ZXN0IGNvbnRleHQgb2JqZWN0LgorICogQG5hbWU6IFRoZSBuYW1lIHRvIGdpdmUgdGhl
IGNyZWF0ZWQgZGV2aWNlLgorICogQGRydjogVGhlIHN0cnVjdCBkZXZpY2VfZHJpdmVyIHRv
IGFzc29jaWF0ZSB3aXRoIHRoZSBkZXZpY2UuCisgKgorICogQ3JlYXRlcyBhIHN0cnVjdCBr
dW5pdF9kZXZpY2UgKHdoaWNoIGlzIGEgc3RydWN0IGRldmljZSkgd2l0aCB0aGUgZ2l2ZW4K
KyAqIG5hbWUsIGFuZCBkcml2ZXIuIFRoZSBkZXZpY2Ugd2lsbCBiZSBjbGVhbmVkIHVwIG9u
IHRlc3QgZXhpdCwgb3Igd2hlbgorICoga3VuaXRfZGV2aWNlX3VucmVnaXN0ZXIgaXMgY2Fs
bGVkLiBTZWUgYWxzbyBrdW5pdF9kZXZpY2VfcmVnaXN0ZXIsIGlmIHlvdQorICogd2lzaCBL
VW5pdCB0byBjcmVhdGUgYW5kIG1hbmFnZSBhIGRyaXZlciBmb3IgeW91LgorICoKKyAqIFJl
dHVybjogYSBwb2ludGVyIHRvIGEgc3RydWN0IGRldmljZSB3aGljaCB3aWxsIGJlIGNsZWFu
ZWQgdXAgd2hlbiB0aGUgdGVzdAorICogZXhpdHMsIG9yIGFuIGVycm9yIHBvaW50ZXIgaWYg
dGhlIGRldmljZSBjb3VsZCBub3QgYmUgYWxsb2NhdGVkIG9yIHJlZ2lzdGVyZWQuCisgKi8K
K3N0cnVjdCBkZXZpY2UgKmt1bml0X2RldmljZV9yZWdpc3Rlcl93aXRoX2RyaXZlcihzdHJ1
Y3Qga3VuaXQgKnRlc3QsCisJCQkJCQkgY29uc3QgY2hhciAqbmFtZSwKKwkJCQkJCSBjb25z
dCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KTsKKworLyoqCisgKiBrdW5pdF9kZXZpY2Vf
dW5yZWdpc3RlcigpIC0gVW5yZWdpc3RlciBhIEtVbml0LW1hbmFnZWQgZGV2aWNlCisgKiBA
dGVzdDogVGhlIHRlc3QgY29udGV4dCBvYmplY3Qgd2hpY2ggY3JlYXRlZCB0aGUgZGV2aWNl
CisgKiBAZGV2OiBUaGUgZGV2aWNlLgorICoKKyAqIFVucmVnaXN0ZXJzIGFuZCBkZXN0cm95
cyBhIHN0cnVjdCBkZXZpY2Ugd2hpY2ggd2FzIGNyZWF0ZWQgd2l0aAorICoga3VuaXRfZGV2
aWNlX3JlZ2lzdGVyIG9yIGt1bml0X2RldmljZV9yZWdpc3Rlcl93aXRoX2RyaXZlci4gSWYg
S1VuaXQgY3JlYXRlZAorICogYSBkcml2ZXIsIGNsZWFucyBpdCB1cCBhcyB3ZWxsLgorICov
Cit2b2lkIGt1bml0X2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdCBrdW5pdCAqdGVzdCwgc3Ry
dWN0IGRldmljZSAqZGV2KTsKKworI2VuZGlmCisKKyNlbmRpZgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9rdW5pdC9yZXNvdXJjZS5oIGIvaW5jbHVkZS9rdW5pdC9yZXNvdXJjZS5oCmluZGV4
IGM3MzgzZTkwZjVjOS4uNGFkNjlhMjY0MmE1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2t1bml0
L3Jlc291cmNlLmgKKysrIGIvaW5jbHVkZS9rdW5pdC9yZXNvdXJjZS5oCkBAIC0zOTAsNiAr
MzkwLDI3IEBAIHZvaWQga3VuaXRfcmVtb3ZlX3Jlc291cmNlKHN0cnVjdCBrdW5pdCAqdGVz
dCwgc3RydWN0IGt1bml0X3Jlc291cmNlICpyZXMpOwogLyogQSAnZGVmZXJyZWQgYWN0aW9u
JyBmdW5jdGlvbiB0byBiZSB1c2VkIHdpdGgga3VuaXRfYWRkX2FjdGlvbi4gKi8KIHR5cGVk
ZWYgdm9pZCAoa3VuaXRfYWN0aW9uX3QpKHZvaWQgKik7CiAKKy8qKgorICogS1VOSVRfREVG
SU5FX0FDVElPTl9XUkFQUEVSKCkgLSBXcmFwIGEgZnVuY3Rpb24gZm9yIHVzZSBhcyBhIGRl
ZmVycmVkIGFjdGlvbi4KKyAqCisgKiBAd3JhcHBlcjogVGhlIG5hbWUgb2YgdGhlIG5ldyB3
cmFwcGVyIGZ1bmN0aW9uIGRlZmluZS4KKyAqIEBvcmlnOiBUaGUgb3JpZ2luYWwgZnVuY3Rp
b24gdG8gd3JhcC4KKyAqIEBhcmdfdHlwZTogVGhlIHR5cGUgb2YgdGhlIGFyZ3VtZW50IGFj
Y2VwdGVkIGJ5IEBvcmlnLgorICoKKyAqIERlZmluZXMgYSB3cmFwcGVyIGZvciBhIGZ1bmN0
aW9uIHdoaWNoIGFjY2VwdHMgYSBzaW5nbGUsIHBvaW50ZXItc2l6ZWQKKyAqIGFyZ3VtZW50
LiBUaGlzIHdyYXBwZXIgY2FuIHRoZW4gYmUgcGFzc2VkIHRvIGt1bml0X2FkZF9hY3Rpb24o
KSBhbmQKKyAqIHNpbWlsYXIuIFRoaXMgc2hvdWxkIGJlIHVzZWQgaW4gcHJlZmVyZW5jZSB0
byBjYXN0aW5nIGEgZnVuY3Rpb24KKyAqIGRpcmVjdGx5IHRvIGt1bml0X2FjdGlvbl90LCBh
cyBjYXN0aW5nIGZ1bmN0aW9uIHBvaW50ZXJzIHdpbGwgYnJlYWsKKyAqIGNvbnRyb2wgZmxv
dyBpbnRlZ3JpdHkgKENGSSksIGxlYWRpbmcgdG8gY3Jhc2hlcy4KKyAqLworI2RlZmluZSBL
VU5JVF9ERUZJTkVfQUNUSU9OX1dSQVBQRVIod3JhcHBlciwgb3JpZywgYXJnX3R5cGUpCVwK
KwlzdGF0aWMgdm9pZCB3cmFwcGVyKHZvaWQgKmluKQkJCQlcCisJewkJCQkJCQlcCisJCWFy
Z190eXBlIGFyZyA9IChhcmdfdHlwZSlpbjsJCQlcCisJCW9yaWcoYXJnKTsJCQkJCVwKKwl9
CisKKwogLyoqCiAgKiBrdW5pdF9hZGRfYWN0aW9uKCkgLSBDYWxsIGEgZnVuY3Rpb24gd2hl
biB0aGUgdGVzdCBlbmRzLgogICogQHRlc3Q6IFRlc3QgY2FzZSB0byBhc3NvY2lhdGUgdGhl
IGFjdGlvbiB3aXRoLgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rdW5pdC9zdGF0aWNfc3R1Yi5o
IGIvaW5jbHVkZS9rdW5pdC9zdGF0aWNfc3R1Yi5oCmluZGV4IDg1MzE1YzgwYjMwMy4uYmY5
NDAzMjJkZmMwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2t1bml0L3N0YXRpY19zdHViLmgKKysr
IGIvaW5jbHVkZS9rdW5pdC9zdGF0aWNfc3R1Yi5oCkBAIC05Myw3ICs5Myw3IEBAIHZvaWQg
X19rdW5pdF9hY3RpdmF0ZV9zdGF0aWNfc3R1YihzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAgKiBU
aGUgcmVkaXJlY3Rpb24gY2FuIGJlIGRpc2FibGVkIGFnYWluIHdpdGgga3VuaXRfZGVhY3Rp
dmF0ZV9zdGF0aWNfc3R1YigpLgogICovCiAjZGVmaW5lIGt1bml0X2FjdGl2YXRlX3N0YXRp
Y19zdHViKHRlc3QsIHJlYWxfZm5fYWRkciwgcmVwbGFjZW1lbnRfYWRkcikgZG8gewlcCi0J
dHlwZWNoZWNrX2ZuKHR5cGVvZigmcmVhbF9mbl9hZGRyKSwgcmVwbGFjZW1lbnRfYWRkcik7
CQkJXAorCXR5cGVjaGVja19mbih0eXBlb2YoJnJlcGxhY2VtZW50X2FkZHIpLCByZWFsX2Zu
X2FkZHIpOwkJCVwKIAlfX2t1bml0X2FjdGl2YXRlX3N0YXRpY19zdHViKHRlc3QsIHJlYWxf
Zm5fYWRkciwgcmVwbGFjZW1lbnRfYWRkcik7CVwKIH0gd2hpbGUgKDApCiAKZGlmZiAtLWdp
dCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgKaW5kZXgg
MjBlZDlmOTI3NWM5Li5jMmNlMzc5YzMyOWIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUva3VuaXQv
dGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC0yNTMsNiArMjUzLDcgQEAg
c3RydWN0IGt1bml0X3N1aXRlIHsKIAlzdHJ1Y3QgZGVudHJ5ICpkZWJ1Z2ZzOwogCXN0cnVj
dCBzdHJpbmdfc3RyZWFtICpsb2c7CiAJaW50IHN1aXRlX2luaXRfZXJyOworCWJvb2wgaXNf
aW5pdDsKIH07CiAKIC8qIFN0b3JlcyBhbiBhcnJheSBvZiBzdWl0ZXMsIGVuZCBwb2ludHMg
b25lIHBhc3QgdGhlIGVuZCAqLwpAQCAtMzM3LDYgKzMzOCw5IEBAIHZvaWQgX19rdW5pdF90
ZXN0X3N1aXRlc19leGl0KHN0cnVjdCBrdW5pdF9zdWl0ZSAqKnN1aXRlcywgaW50IG51bV9z
dWl0ZXMpOwogdm9pZCBrdW5pdF9leGVjX3J1bl90ZXN0cyhzdHJ1Y3Qga3VuaXRfc3VpdGVf
c2V0ICpzdWl0ZV9zZXQsIGJvb2wgYnVpbHRpbik7CiB2b2lkIGt1bml0X2V4ZWNfbGlzdF90
ZXN0cyhzdHJ1Y3Qga3VuaXRfc3VpdGVfc2V0ICpzdWl0ZV9zZXQsIGJvb2wgaW5jbHVkZV9h
dHRyKTsKIAorc3RydWN0IGt1bml0X3N1aXRlX3NldCBrdW5pdF9tZXJnZV9zdWl0ZV9zZXRz
KHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgaW5pdF9zdWl0ZV9zZXQsCisJCXN0cnVjdCBrdW5p
dF9zdWl0ZV9zZXQgc3VpdGVfc2V0KTsKKwogI2lmIElTX0JVSUxUSU4oQ09ORklHX0tVTklU
KQogaW50IGt1bml0X3J1bl9hbGxfdGVzdHModm9pZCk7CiAjZWxzZQpAQCAtMzcxLDYgKzM3
NSwxMSBAQCBzdGF0aWMgaW5saW5lIGludCBrdW5pdF9ydW5fYWxsX3Rlc3RzKHZvaWQpCiAK
ICNkZWZpbmUga3VuaXRfdGVzdF9zdWl0ZShzdWl0ZSkJa3VuaXRfdGVzdF9zdWl0ZXMoJnN1
aXRlKQogCisjZGVmaW5lIF9fa3VuaXRfaW5pdF90ZXN0X3N1aXRlcyh1bmlxdWVfYXJyYXks
IC4uLikJCQkgICAgICAgXAorCXN0YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUgKnVuaXF1ZV9h
cnJheVtdCQkJICAgICAgIFwKKwlfX2FsaWduZWQoc2l6ZW9mKHN0cnVjdCBrdW5pdF9zdWl0
ZSAqKSkJCQkJICAgICAgIFwKKwlfX3VzZWQgX19zZWN0aW9uKCIua3VuaXRfaW5pdF90ZXN0
X3N1aXRlcyIpID0geyBfX1ZBX0FSR1NfXyB9CisKIC8qKgogICoga3VuaXRfdGVzdF9pbml0
X3NlY3Rpb25fc3VpdGVzKCkgLSB1c2VkIHRvIHJlZ2lzdGVyIG9uZSBvciBtb3JlICZzdHJ1
Y3QKICAqCQkJCSAgICAgIGt1bml0X3N1aXRlIGNvbnRhaW5pbmcgaW5pdCBmdW5jdGlvbnMg
b3IKQEAgLTM3OCwyMSArMzg3LDIxIEBAIHN0YXRpYyBpbmxpbmUgaW50IGt1bml0X3J1bl9h
bGxfdGVzdHModm9pZCkKICAqCiAgKiBAX19zdWl0ZXM6IGEgc3RhdGljYWxseSBhbGxvY2F0
ZWQgbGlzdCBvZiAmc3RydWN0IGt1bml0X3N1aXRlLgogICoKLSAqIFRoaXMgZnVuY3Rpb25z
IGlkZW50aWNhbGx5IGFzIGt1bml0X3Rlc3Rfc3VpdGVzKCkgZXhjZXB0IHRoYXQgaXQgc3Vw
cHJlc3NlcwotICogbW9kcG9zdCB3YXJuaW5ncyBmb3IgcmVmZXJlbmNpbmcgZnVuY3Rpb25z
IG1hcmtlZCBfX2luaXQgb3IgZGF0YSBtYXJrZWQKLSAqIF9faW5pdGRhdGE7IHRoaXMgaXMg
T0sgYmVjYXVzZSBjdXJyZW50bHkgS1VuaXQgb25seSBydW5zIHRlc3RzIHVwb24gYm9vdAot
ICogZHVyaW5nIHRoZSBpbml0IHBoYXNlIG9yIHVwb24gbG9hZGluZyBhIG1vZHVsZSBkdXJp
bmcgdGhlIGluaXQgcGhhc2UuCisgKiBUaGlzIGZ1bmN0aW9ucyBzaW1pbGFyIHRvIGt1bml0
X3Rlc3Rfc3VpdGVzKCkgZXhjZXB0IHRoYXQgaXQgY29tcGlsZXMgdGhlCisgKiBsaXN0IG9m
IHN1aXRlcyBkdXJpbmcgaW5pdCBwaGFzZS4KKyAqCisgKiBUaGlzIG1hY3JvIGFsc28gc3Vm
Zml4ZXMgdGhlIGFycmF5IGFuZCBzdWl0ZSBkZWNsYXJhdGlvbnMgaXQgbWFrZXMgd2l0aAor
ICogX3Byb2JlOyBzbyB0aGF0IG1vZHBvc3Qgc3VwcHJlc3NlcyB3YXJuaW5ncyBhYm91dCBy
ZWZlcmVuY2luZyBpbml0IGRhdGEKKyAqIGZvciBzeW1ib2xzIG5hbWVkIGluIHRoaXMgbWFu
bmVyLgogICoKLSAqIE5PVEUgVE8gS1VOSVQgREVWUzogSWYgd2UgZXZlciBhbGxvdyBLVW5p
dCB0ZXN0cyB0byBiZSBydW4gYWZ0ZXIgYm9vdCwgdGhlc2UKLSAqIHRlc3RzIG11c3QgYmUg
ZXhjbHVkZWQuCisgKiBOb3RlOiB0aGVzZSBpbml0IHRlc3RzIGFyZSBub3QgYWJsZSB0byBi
ZSBydW4gYWZ0ZXIgYm9vdCBzbyB0aGVyZSBpcyBubworICogInJ1biIgZGVidWdmcyBmaWxl
IGdlbmVyYXRlZCBmb3IgdGhlc2UgdGVzdHMuCiAgKgotICogVGhlIG9ubHkgdGhpbmcgdGhp
cyBtYWNybyBkb2VzIHRoYXQncyBkaWZmZXJlbnQgZnJvbSBrdW5pdF90ZXN0X3N1aXRlcyBp
cwotICogdGhhdCBpdCBzdWZmaXhlcyB0aGUgYXJyYXkgYW5kIHN1aXRlIGRlY2xhcmF0aW9u
cyBpdCBtYWtlcyB3aXRoIF9wcm9iZTsKLSAqIG1vZHBvc3Qgc3VwcHJlc3NlcyB3YXJuaW5n
cyBhYm91dCByZWZlcmVuY2luZyBpbml0IGRhdGEgZm9yIHN5bWJvbHMgbmFtZWQgaW4KLSAq
IHRoaXMgbWFubmVyLgorICogQWxzbywgZG8gbm90IG1hcmsgdGhlIHN1aXRlIG9yIHRlc3Qg
Y2FzZSBzdHJ1Y3RzIHdpdGggX19pbml0ZGF0YSBiZWNhdXNlCisgKiB0aGV5IHdpbGwgYmUg
dXNlZCBhZnRlciB0aGUgaW5pdCBwaGFzZSB3aXRoIGRlYnVnZnMuCiAgKi8KICNkZWZpbmUg
a3VuaXRfdGVzdF9pbml0X3NlY3Rpb25fc3VpdGVzKF9fc3VpdGVzLi4uKQkJCVwKLQlfX2t1
bml0X3Rlc3Rfc3VpdGVzKENPTkNBVEVOQVRFKF9fVU5JUVVFX0lEKGFycmF5KSwgX3Byb2Jl
KSwJXAorCV9fa3VuaXRfaW5pdF90ZXN0X3N1aXRlcyhDT05DQVRFTkFURShfX1VOSVFVRV9J
RChhcnJheSksIF9wcm9iZSksIFwKIAkJCSAgICAjI19fc3VpdGVzKQogCiAjZGVmaW5lIGt1
bml0X3Rlc3RfaW5pdF9zZWN0aW9uX3N1aXRlKHN1aXRlKQlcCkBAIC03NDksNyArNzU4LDcg
QEAgZG8gewkJCQkJCQkJCSAgICAgICBcCiAJCS5yaWdodF90ZXh0ID0gI3JpZ2h0LAkJCQkJ
ICAgICAgIFwKIAl9OwkJCQkJCQkJICAgICAgIFwKIAkJCQkJCQkJCSAgICAgICBcCi0JaWYg
KGxpa2VseShzdHJjbXAoX19sZWZ0LCBfX3JpZ2h0KSBvcCAwKSkJCQkgICAgICAgXAorCWlm
IChsaWtlbHkoKF9fbGVmdCkgJiYgKF9fcmlnaHQpICYmIChzdHJjbXAoX19sZWZ0LCBfX3Jp
Z2h0KSBvcCAwKSkpICAgXAogCQlicmVhazsJCQkJCQkJICAgICAgIFwKIAkJCQkJCQkJCSAg
ICAgICBcCiAJCQkJCQkJCQkgICAgICAgXApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
b2R1bGUuaCBiL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKaW5kZXggYTk4ZTE4OGNmMzdiLi45
Y2QwMDA5YmQwNTAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKKysrIGIv
aW5jbHVkZS9saW51eC9tb2R1bGUuaApAQCAtNTQwLDYgKzU0MCw4IEBAIHN0cnVjdCBtb2R1
bGUgewogCXN0cnVjdCBzdGF0aWNfY2FsbF9zaXRlICpzdGF0aWNfY2FsbF9zaXRlczsKICNl
bmRpZgogI2lmIElTX0VOQUJMRUQoQ09ORklHX0tVTklUKQorCWludCBudW1fa3VuaXRfaW5p
dF9zdWl0ZXM7CisJc3RydWN0IGt1bml0X3N1aXRlICoqa3VuaXRfaW5pdF9zdWl0ZXM7CiAJ
aW50IG51bV9rdW5pdF9zdWl0ZXM7CiAJc3RydWN0IGt1bml0X3N1aXRlICoqa3VuaXRfc3Vp
dGVzOwogI2VuZGlmCmRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5l
bC9tb2R1bGUvbWFpbi5jCmluZGV4IDk4ZmVkZmRiOGRiNS4uMzY2ODE5MTFjMDVhIDEwMDY0
NAotLS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYworKysgYi9rZXJuZWwvbW9kdWxlL21haW4u
YwpAQCAtMjE5OSw2ICsyMTk5LDkgQEAgc3RhdGljIGludCBmaW5kX21vZHVsZV9zZWN0aW9u
cyhzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBsb2FkX2luZm8gKmluZm8pCiAJbW9kLT5r
dW5pdF9zdWl0ZXMgPSBzZWN0aW9uX29ianMoaW5mbywgIi5rdW5pdF90ZXN0X3N1aXRlcyIs
CiAJCQkJCSAgICAgIHNpemVvZigqbW9kLT5rdW5pdF9zdWl0ZXMpLAogCQkJCQkgICAgICAm
bW9kLT5udW1fa3VuaXRfc3VpdGVzKTsKKwltb2QtPmt1bml0X2luaXRfc3VpdGVzID0gc2Vj
dGlvbl9vYmpzKGluZm8sICIua3VuaXRfaW5pdF90ZXN0X3N1aXRlcyIsCisJCQkJCSAgICAg
IHNpemVvZigqbW9kLT5rdW5pdF9pbml0X3N1aXRlcyksCisJCQkJCSAgICAgICZtb2QtPm51
bV9rdW5pdF9pbml0X3N1aXRlcyk7CiAjZW5kaWYKIAogCW1vZC0+ZXh0YWJsZSA9IHNlY3Rp
b25fb2JqcyhpbmZvLCAiX19leF90YWJsZSIsCmRpZmYgLS1naXQgYS9saWIvZm9ydGlmeV9r
dW5pdC5jIGIvbGliL2ZvcnRpZnlfa3VuaXQuYwppbmRleCBjOGMzM2NiYWFlOWUuLjJlNGZl
ZGM4MTYyMSAxMDA2NDQKLS0tIGEvbGliL2ZvcnRpZnlfa3VuaXQuYworKysgYi9saWIvZm9y
dGlmeV9rdW5pdC5jCkBAIC0xNSw2ICsxNSw3IEBACiAgKi8KICNkZWZpbmUgcHJfZm10KGZt
dCkgS0JVSUxEX01PRE5BTUUgIjogIiBmbXQKIAorI2luY2x1ZGUgPGt1bml0L2RldmljZS5o
PgogI2luY2x1ZGUgPGt1bml0L3Rlc3QuaD4KICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4K
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CkBAIC0yNjksNyArMjcwLDcgQEAgREVGSU5FX0FM
TE9DX1NJWkVfVEVTVF9QQUlSKGt2bWFsbG9jKQogCXNpemVfdCBsZW47CQkJCQkJCVwKIAkJ
CQkJCQkJCVwKIAkvKiBDcmVhdGUgZHVtbXkgZGV2aWNlIGZvciBkZXZtX2ttYWxsb2MoKS1m
YW1pbHkgdGVzdHMuICovCVwKLQlkZXYgPSByb290X2RldmljZV9yZWdpc3RlcihkZXZfbmFt
ZSk7CQkJCVwKKwlkZXYgPSBrdW5pdF9kZXZpY2VfcmVnaXN0ZXIodGVzdCwgZGV2X25hbWUp
OwkJCVwKIAlLVU5JVF9BU1NFUlRfRkFMU0VfTVNHKHRlc3QsIElTX0VSUihkZXYpLAkJCVwK
IAkJCSAgICAgICAiQ2Fubm90IHJlZ2lzdGVyIHRlc3QgZGV2aWNlXG4iKTsJXAogCQkJCQkJ
CQkJXApAQCAtMzAzLDcgKzMwNCw3IEBAIERFRklORV9BTExPQ19TSVpFX1RFU1RfUEFJUihr
dm1hbGxvYykKIAljaGVja2VyKGxlbiwgZGV2bV9rbWVtZHVwKGRldiwgIk9oYWkiLCBsZW4s
IGdmcCksCQlcCiAJCWRldm1fa2ZyZWUoZGV2LCBwKSk7CQkJCQlcCiAJCQkJCQkJCQlcCi0J
ZGV2aWNlX3VucmVnaXN0ZXIoZGV2KTsJCQkJCQlcCisJa3VuaXRfZGV2aWNlX3VucmVnaXN0
ZXIodGVzdCwgZGV2KTsJCQkJXAogfSB3aGlsZSAoMCkKIERFRklORV9BTExPQ19TSVpFX1RF
U1RfUEFJUihkZXZtX2ttYWxsb2MpCiAKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9NYWtlZmls
ZSBiL2xpYi9rdW5pdC9NYWtlZmlsZQppbmRleCA0NmY3NWYyM2RmZTQuLjMwOTY1OWEzMmE3
OCAxMDA2NDQKLS0tIGEvbGliL2t1bml0L01ha2VmaWxlCisrKyBiL2xpYi9rdW5pdC9NYWtl
ZmlsZQpAQCAtNyw3ICs3LDggQEAga3VuaXQtb2JqcyArPQkJCQl0ZXN0Lm8gXAogCQkJCQlh
c3NlcnQubyBcCiAJCQkJCXRyeS1jYXRjaC5vIFwKIAkJCQkJZXhlY3V0b3IubyBcCi0JCQkJ
CWF0dHJpYnV0ZXMubworCQkJCQlhdHRyaWJ1dGVzLm8gXAorCQkJCQlkZXZpY2UubwogCiBp
ZmVxICgkKENPTkZJR19LVU5JVF9ERUJVR0ZTKSx5KQoga3VuaXQtb2JqcyArPQkJCQlkZWJ1
Z2ZzLm8KZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9hdHRyaWJ1dGVzLmMgYi9saWIva3VuaXQv
YXR0cmlidXRlcy5jCmluZGV4IDFiNTEyZjdlMTgzOC4uMmNmMDRjYzA5MzcyIDEwMDY0NAot
LS0gYS9saWIva3VuaXQvYXR0cmlidXRlcy5jCisrKyBiL2xpYi9rdW5pdC9hdHRyaWJ1dGVz
LmMKQEAgLTU4LDYgKzU4LDE2IEBAIHN0YXRpYyBjb25zdCBjaGFyICphdHRyX2VudW1fdG9f
c3RyaW5nKHZvaWQgKmF0dHIsIGNvbnN0IGNoYXIgKiBjb25zdCBzdHJfbGlzdFtdCiAJcmV0
dXJuIHN0cl9saXN0W3ZhbF07CiB9CiAKK3N0YXRpYyBjb25zdCBjaGFyICphdHRyX2Jvb2xf
dG9fc3RyaW5nKHZvaWQgKmF0dHIsIGJvb2wgKnRvX2ZyZWUpCit7CisJYm9vbCB2YWwgPSAo
Ym9vbClhdHRyOworCisJKnRvX2ZyZWUgPSBmYWxzZTsKKwlpZiAodmFsKQorCQlyZXR1cm4g
InRydWUiOworCXJldHVybiAiZmFsc2UiOworfQorCiBzdGF0aWMgY29uc3QgY2hhciAqYXR0
cl9zcGVlZF90b19zdHJpbmcodm9pZCAqYXR0ciwgYm9vbCAqdG9fZnJlZSkKIHsKIAlyZXR1
cm4gYXR0cl9lbnVtX3RvX3N0cmluZyhhdHRyLCBzcGVlZF9zdHJfbGlzdCwgdG9fZnJlZSk7
CkBAIC0xNjYsNiArMTc2LDM3IEBAIHN0YXRpYyBpbnQgYXR0cl9zdHJpbmdfZmlsdGVyKHZv
aWQgKmF0dHIsIGNvbnN0IGNoYXIgKmlucHV0LCBpbnQgKmVycikKIAlyZXR1cm4gZmFsc2U7
CiB9CiAKK3N0YXRpYyBpbnQgYXR0cl9ib29sX2ZpbHRlcih2b2lkICphdHRyLCBjb25zdCBj
aGFyICppbnB1dCwgaW50ICplcnIpCit7CisJaW50IGksIGlucHV0X2ludCA9IC0xOworCWxv
bmcgdmFsID0gKGxvbmcpYXR0cjsKKwljb25zdCBjaGFyICppbnB1dF9zdHIgPSBOVUxMOwor
CisJZm9yIChpID0gMDsgaW5wdXRbaV07IGkrKykgeworCQlpZiAoIXN0cmNocihvcF9saXN0
LCBpbnB1dFtpXSkpIHsKKwkJCWlucHV0X3N0ciA9IGlucHV0ICsgaTsKKwkJCWJyZWFrOwor
CQl9CisJfQorCisJaWYgKCFpbnB1dF9zdHIpIHsKKwkJKmVyciA9IC1FSU5WQUw7CisJCXBy
X2Vycigia3VuaXQgZXhlY3V0b3I6IGZpbHRlciB2YWx1ZSBub3QgZm91bmQ6ICVzXG4iLCBp
bnB1dCk7CisJCXJldHVybiBmYWxzZTsKKwl9CisKKwlpZiAoIXN0cmNtcChpbnB1dF9zdHIs
ICJ0cnVlIikpCisJCWlucHV0X2ludCA9IChpbnQpdHJ1ZTsKKwllbHNlIGlmICghc3RyY21w
KGlucHV0X3N0ciwgImZhbHNlIikpCisJCWlucHV0X2ludCA9IChpbnQpZmFsc2U7CisJZWxz
ZSB7CisJCSplcnIgPSAtRUlOVkFMOworCQlwcl9lcnIoImt1bml0IGV4ZWN1dG9yOiBpbnZh
bGlkIGZpbHRlciBpbnB1dDogJXNcbiIsIGlucHV0KTsKKwkJcmV0dXJuIGZhbHNlOworCX0K
KworCXJldHVybiBpbnRfZmlsdGVyKHZhbCwgaW5wdXQsIGlucHV0X2ludCwgZXJyKTsKK30K
IAogLyogR2V0IEF0dHJpYnV0ZSBNZXRob2RzICovCiAKQEAgLTE5NCw2ICsyMzUsMTcgQEAg
c3RhdGljIHZvaWQgKmF0dHJfbW9kdWxlX2dldCh2b2lkICp0ZXN0X29yX3N1aXRlLCBib29s
IGlzX3Rlc3QpCiAJCXJldHVybiAodm9pZCAqKSAiIjsKIH0KIAorc3RhdGljIHZvaWQgKmF0
dHJfaXNfaW5pdF9nZXQodm9pZCAqdGVzdF9vcl9zdWl0ZSwgYm9vbCBpc190ZXN0KQorewor
CXN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUgPSBpc190ZXN0ID8gTlVMTCA6IHRlc3Rfb3Jf
c3VpdGU7CisJc3RydWN0IGt1bml0X2Nhc2UgKnRlc3QgPSBpc190ZXN0ID8gdGVzdF9vcl9z
dWl0ZSA6IE5VTEw7CisKKwlpZiAodGVzdCkKKwkJcmV0dXJuICgodm9pZCAqKSBOVUxMKTsK
KwllbHNlCisJCXJldHVybiAoKHZvaWQgKikgc3VpdGUtPmlzX2luaXQpOworfQorCiAvKiBM
aXN0IG9mIGFsbCBUZXN0IEF0dHJpYnV0ZXMgKi8KIAogc3RhdGljIHN0cnVjdCBrdW5pdF9h
dHRyIGt1bml0X2F0dHJfbGlzdFtdID0gewpAQCAtMjEyLDYgKzI2NCwxNCBAQCBzdGF0aWMg
c3RydWN0IGt1bml0X2F0dHIga3VuaXRfYXR0cl9saXN0W10gPSB7CiAJCS5maWx0ZXIgPSBh
dHRyX3N0cmluZ19maWx0ZXIsCiAJCS5hdHRyX2RlZmF1bHQgPSAodm9pZCAqKSIiLAogCQku
cHJpbnQgPSBQUklOVF9TVUlURSwKKwl9LAorCXsKKwkJLm5hbWUgPSAiaXNfaW5pdCIsCisJ
CS5nZXRfYXR0ciA9IGF0dHJfaXNfaW5pdF9nZXQsCisJCS50b19zdHJpbmcgPSBhdHRyX2Jv
b2xfdG9fc3RyaW5nLAorCQkuZmlsdGVyID0gYXR0cl9ib29sX2ZpbHRlciwKKwkJLmF0dHJf
ZGVmYXVsdCA9ICh2b2lkICopZmFsc2UsCisJCS5wcmludCA9IFBSSU5UX1NVSVRFLAogCX0K
IH07CiAKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9kZWJ1Z2ZzLmMgYi9saWIva3VuaXQvZGVi
dWdmcy5jCmluZGV4IDI3MGQxODU3MzdlNi4uZDU0ODc1MGEzMjVhIDEwMDY0NAotLS0gYS9s
aWIva3VuaXQvZGVidWdmcy5jCisrKyBiL2xpYi9rdW5pdC9kZWJ1Z2ZzLmMKQEAgLTgsMTIg
KzgsMTQgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KIAogI2luY2x1ZGUgPGt1bml0
L3Rlc3QuaD4KKyNpbmNsdWRlIDxrdW5pdC90ZXN0LWJ1Zy5oPgogCiAjaW5jbHVkZSAic3Ry
aW5nLXN0cmVhbS5oIgogI2luY2x1ZGUgImRlYnVnZnMuaCIKIAogI2RlZmluZSBLVU5JVF9E
RUJVR0ZTX1JPT1QgICAgICAgICAgICAgImt1bml0IgogI2RlZmluZSBLVU5JVF9ERUJVR0ZT
X1JFU1VMVFMgICAgICAgICAgInJlc3VsdHMiCisjZGVmaW5lIEtVTklUX0RFQlVHRlNfUlVO
ICAgICAgICAgICAgICAicnVuIgogCiAvKgogICogQ3JlYXRlIGEgZGVidWdmcyByZXByZXNl
bnRhdGlvbiBvZiB0ZXN0IHN1aXRlczoKQEAgLTIxLDYgKzIzLDggQEAKICAqIFBhdGgJCQkJ
CQlTZW1hbnRpY3MKICAqIC9zeXMva2VybmVsL2RlYnVnL2t1bml0Lzx0ZXN0c3VpdGU+L3Jl
c3VsdHMJU2hvdyByZXN1bHRzIG9mIGxhc3QgcnVuIGZvcgogICoJCQkJCQl0ZXN0c3VpdGUK
KyAqIC9zeXMva2VybmVsL2RlYnVnL2t1bml0Lzx0ZXN0c3VpdGU+L3J1bglXcml0ZSB0byB0
aGlzIGZpbGUgdG8gdHJpZ2dlcgorICoJCQkJCQl0ZXN0c3VpdGUgdG8gcnVuCiAgKgogICov
CiAKQEAgLTYwLDEyICs2NCwxNCBAQCBzdGF0aWMgdm9pZCBkZWJ1Z2ZzX3ByaW50X3Jlc3Vs
dChzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgc3RydWN0IHN0cmluZ19zdHJlYW0gKmxvZwogc3Rh
dGljIGludCBkZWJ1Z2ZzX3ByaW50X3Jlc3VsdHMoc3RydWN0IHNlcV9maWxlICpzZXEsIHZv
aWQgKnYpCiB7CiAJc3RydWN0IGt1bml0X3N1aXRlICpzdWl0ZSA9IChzdHJ1Y3Qga3VuaXRf
c3VpdGUgKilzZXEtPnByaXZhdGU7Ci0JZW51bSBrdW5pdF9zdGF0dXMgc3VjY2VzcyA9IGt1
bml0X3N1aXRlX2hhc19zdWNjZWVkZWQoc3VpdGUpOworCWVudW0ga3VuaXRfc3RhdHVzIHN1
Y2Nlc3M7CiAJc3RydWN0IGt1bml0X2Nhc2UgKnRlc3RfY2FzZTsKIAogCWlmICghc3VpdGUp
CiAJCXJldHVybiAwOwogCisJc3VjY2VzcyA9IGt1bml0X3N1aXRlX2hhc19zdWNjZWVkZWQo
c3VpdGUpOworCiAJLyogUHJpbnQgS1RBUCBoZWFkZXIgc28gdGhlIGRlYnVnZnMgbG9nIGNh
biBiZSBwYXJzZWQgYXMgdmFsaWQgS1RBUC4gKi8KIAlzZXFfcHV0cyhzZXEsICJLVEFQIHZl
cnNpb24gMVxuIik7CiAJc2VxX3B1dHMoc2VxLCAiMS4uMVxuIik7CkBAIC05OSw2ICsxMDUs
NTEgQEAgc3RhdGljIGludCBkZWJ1Z2ZzX3Jlc3VsdHNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlyZXR1cm4gc2luZ2xlX29wZW4oZmlsZSwgZGVi
dWdmc19wcmludF9yZXN1bHRzLCBzdWl0ZSk7CiB9CiAKKy8qCisgKiBQcmludCBhIHVzYWdl
IG1lc3NhZ2UgdG8gdGhlIGRlYnVnZnMgInJ1biIgZmlsZQorICogKC9zeXMva2VybmVsL2Rl
YnVnL2t1bml0Lzx0ZXN0c3VpdGU+L3J1bikgaWYgb3BlbmVkLgorICovCitzdGF0aWMgaW50
IGRlYnVnZnNfcHJpbnRfcnVuKHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KQorewor
CXN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUgPSAoc3RydWN0IGt1bml0X3N1aXRlICopc2Vx
LT5wcml2YXRlOworCisJc2VxX3B1dHMoc2VxLCAiV3JpdGUgdG8gdGhpcyBmaWxlIHRvIHRy
aWdnZXIgdGhlIHRlc3Qgc3VpdGUgdG8gcnVuLlxuIik7CisJc2VxX3ByaW50ZihzZXEsICJ1
c2FnZTogZWNobyBcImFueSBzdHJpbmdcIiA+IC9zeXMva2VybmVsL2RlYnVnZnMva3VuaXQv
JXMvcnVuXG4iLAorCQkJc3VpdGUtPm5hbWUpOworCXJldHVybiAwOworfQorCisvKgorICog
VGhlIGRlYnVnZnMgInJ1biIgZmlsZSAoL3N5cy9rZXJuZWwvZGVidWcva3VuaXQvPHRlc3Rz
dWl0ZT4vcnVuKQorICogY29udGFpbnMgbm8gaW5mb3JtYXRpb24uIFdyaXRlIHRvIHRoZSBm
aWxlIHRvIHRyaWdnZXIgdGhlIHRlc3Qgc3VpdGUKKyAqIHRvIHJ1bi4KKyAqLworc3RhdGlj
IGludCBkZWJ1Z2ZzX3J1bl9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxl
ICpmaWxlKQoreworCXN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGU7CisKKwlzdWl0ZSA9IChz
dHJ1Y3Qga3VuaXRfc3VpdGUgKilpbm9kZS0+aV9wcml2YXRlOworCisJcmV0dXJuIHNpbmds
ZV9vcGVuKGZpbGUsIGRlYnVnZnNfcHJpbnRfcnVuLCBzdWl0ZSk7Cit9CisKKy8qCisgKiBU
cmlnZ2VyIGEgdGVzdCBzdWl0ZSB0byBydW4gYnkgd3JpdGluZyB0byB0aGUgc3VpdGUncyAi
cnVuIiBkZWJ1Z2ZzCisgKiBmaWxlIGZvdW5kIGF0OiAvc3lzL2tlcm5lbC9kZWJ1Zy9rdW5p
dC88dGVzdHN1aXRlPi9ydW4KKyAqCisgKiBOb3RlOiB3aGF0IGlzIHdyaXR0ZW4gdG8gdGhp
cyBmaWxlIHdpbGwgbm90IGJlIHNhdmVkLgorICovCitzdGF0aWMgc3NpemVfdCBkZWJ1Z2Zz
X3J1bihzdHJ1Y3QgZmlsZSAqZmlsZSwKKwkJY29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6
ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJc3RydWN0IGlub2RlICpmX2lub2RlID0g
ZmlsZS0+Zl9pbm9kZTsKKwlzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlID0gKHN0cnVjdCBr
dW5pdF9zdWl0ZSAqKSBmX2lub2RlLT5pX3ByaXZhdGU7CisKKwlfX2t1bml0X3Rlc3Rfc3Vp
dGVzX2luaXQoJnN1aXRlLCAxKTsKKworCXJldHVybiBjb3VudDsKK30KKwogc3RhdGljIGNv
bnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZGVidWdmc19yZXN1bHRzX2ZvcHMgPSB7CiAJ
Lm9wZW4gPSBkZWJ1Z2ZzX3Jlc3VsdHNfb3BlbiwKIAkucmVhZCA9IHNlcV9yZWFkLApAQCAt
MTA2LDE3ICsxNTcsNDMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMg
ZGVidWdmc19yZXN1bHRzX2ZvcHMgPSB7CiAJLnJlbGVhc2UgPSBkZWJ1Z2ZzX3JlbGVhc2Us
CiB9OwogCitzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBkZWJ1Z2ZzX3J1
bl9mb3BzID0geworCS5vcGVuID0gZGVidWdmc19ydW5fb3BlbiwKKwkucmVhZCA9IHNlcV9y
ZWFkLAorCS53cml0ZSA9IGRlYnVnZnNfcnVuLAorCS5sbHNlZWsgPSBzZXFfbHNlZWssCisJ
LnJlbGVhc2UgPSBkZWJ1Z2ZzX3JlbGVhc2UsCit9OworCiB2b2lkIGt1bml0X2RlYnVnZnNf
Y3JlYXRlX3N1aXRlKHN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUpCiB7CiAJc3RydWN0IGt1
bml0X2Nhc2UgKnRlc3RfY2FzZTsKKwlzdHJ1Y3Qgc3RyaW5nX3N0cmVhbSAqc3RyZWFtOwor
CisJLyogSWYgc3VpdGUgbG9nIGFscmVhZHkgYWxsb2NhdGVkLCBkbyBub3QgY3JlYXRlIG5l
dyBkZWJ1Z2ZzIGZpbGVzLiAqLworCWlmIChzdWl0ZS0+bG9nKQorCQlyZXR1cm47CiAKLQkv
KiBBbGxvY2F0ZSBsb2dzIGJlZm9yZSBjcmVhdGluZyBkZWJ1Z2ZzIHJlcHJlc2VudGF0aW9u
LiAqLwotCXN1aXRlLT5sb2cgPSBhbGxvY19zdHJpbmdfc3RyZWFtKEdGUF9LRVJORUwpOwot
CXN0cmluZ19zdHJlYW1fc2V0X2FwcGVuZF9uZXdsaW5lcyhzdWl0ZS0+bG9nLCB0cnVlKTsK
KwkvKgorCSAqIEFsbG9jYXRlIGxvZ3MgYmVmb3JlIGNyZWF0aW5nIGRlYnVnZnMgcmVwcmVz
ZW50YXRpb24uCisJICogVGhlIHN1aXRlLT5sb2cgYW5kIHRlc3RfY2FzZS0+bG9nIHBvaW50
ZXIgYXJlIGV4cGVjdGVkIHRvIGJlIE5VTEwKKwkgKiBpZiB0aGVyZSBpc24ndCBhIGxvZywg
c28gb25seSBzZXQgaXQgaWYgdGhlIGxvZyBzdHJlYW0gd2FzIGNyZWF0ZWQKKwkgKiBzdWNj
ZXNzZnVsbHkuCisJICovCisJc3RyZWFtID0gYWxsb2Nfc3RyaW5nX3N0cmVhbShHRlBfS0VS
TkVMKTsKKwlpZiAoSVNfRVJSX09SX05VTEwoc3RyZWFtKSkKKwkJcmV0dXJuOworCisJc3Ry
aW5nX3N0cmVhbV9zZXRfYXBwZW5kX25ld2xpbmVzKHN0cmVhbSwgdHJ1ZSk7CisJc3VpdGUt
PmxvZyA9IHN0cmVhbTsKIAogCWt1bml0X3N1aXRlX2Zvcl9lYWNoX3Rlc3RfY2FzZShzdWl0
ZSwgdGVzdF9jYXNlKSB7Ci0JCXRlc3RfY2FzZS0+bG9nID0gYWxsb2Nfc3RyaW5nX3N0cmVh
bShHRlBfS0VSTkVMKTsKLQkJc3RyaW5nX3N0cmVhbV9zZXRfYXBwZW5kX25ld2xpbmVzKHRl
c3RfY2FzZS0+bG9nLCB0cnVlKTsKKwkJc3RyZWFtID0gYWxsb2Nfc3RyaW5nX3N0cmVhbShH
RlBfS0VSTkVMKTsKKwkJaWYgKElTX0VSUl9PUl9OVUxMKHN0cmVhbSkpCisJCQlnb3RvIGVy
cjsKKworCQlzdHJpbmdfc3RyZWFtX3NldF9hcHBlbmRfbmV3bGluZXMoc3RyZWFtLCB0cnVl
KTsKKwkJdGVzdF9jYXNlLT5sb2cgPSBzdHJlYW07CiAJfQogCiAJc3VpdGUtPmRlYnVnZnMg
PSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoc3VpdGUtPm5hbWUsIGRlYnVnZnNfcm9vdGRpcik7CkBA
IC0xMjQsNiArMjAxLDE5IEBAIHZvaWQga3VuaXRfZGVidWdmc19jcmVhdGVfc3VpdGUoc3Ry
dWN0IGt1bml0X3N1aXRlICpzdWl0ZSkKIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKEtVTklUX0RF
QlVHRlNfUkVTVUxUUywgU19JRlJFRyB8IDA0NDQsCiAJCQkgICAgc3VpdGUtPmRlYnVnZnMs
CiAJCQkgICAgc3VpdGUsICZkZWJ1Z2ZzX3Jlc3VsdHNfZm9wcyk7CisKKwkvKiBEbyBub3Qg
Y3JlYXRlIGZpbGUgdG8gcmUtcnVuIHRlc3QgaWYgdGVzdCBydW5zIG9uIGluaXQgKi8KKwlp
ZiAoIXN1aXRlLT5pc19pbml0KSB7CisJCWRlYnVnZnNfY3JlYXRlX2ZpbGUoS1VOSVRfREVC
VUdGU19SVU4sIFNfSUZSRUcgfCAwNjQ0LAorCQkJCSAgICBzdWl0ZS0+ZGVidWdmcywKKwkJ
CQkgICAgc3VpdGUsICZkZWJ1Z2ZzX3J1bl9mb3BzKTsKKwl9CisJcmV0dXJuOworCitlcnI6
CisJc3RyaW5nX3N0cmVhbV9kZXN0cm95KHN1aXRlLT5sb2cpOworCWt1bml0X3N1aXRlX2Zv
cl9lYWNoX3Rlc3RfY2FzZShzdWl0ZSwgdGVzdF9jYXNlKQorCQlzdHJpbmdfc3RyZWFtX2Rl
c3Ryb3kodGVzdF9jYXNlLT5sb2cpOwogfQogCiB2b2lkIGt1bml0X2RlYnVnZnNfZGVzdHJv
eV9zdWl0ZShzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlKQpkaWZmIC0tZ2l0IGEvbGliL2t1
bml0L2RldmljZS1pbXBsLmggYi9saWIva3VuaXQvZGV2aWNlLWltcGwuaApuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjU0YmQ1NTgzNjQwNQotLS0gL2Rldi9u
dWxsCisrKyBiL2xpYi9rdW5pdC9kZXZpY2UtaW1wbC5oCkBAIC0wLDAgKzEsMTcgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCisvKgorICogS1VuaXQgaW50
ZXJuYWwgaGVhZGVyIGZvciBkZXZpY2UgaGVscGVycworICoKKyAqIEhlYWRlciBmb3IgS1Vu
aXQtaW50ZXJuYWwgZHJpdmVyIC8gYnVzIG1hbmFnZW1lbnQuCisgKgorICogQ29weXJpZ2h0
IChDKSAyMDIzLCBHb29nbGUgTExDLgorICogQXV0aG9yOiBEYXZpZCBHb3cgPGRhdmlkZ293
QGdvb2dsZS5jb20+CisgKi8KKworI2lmbmRlZiBfS1VOSVRfREVWSUNFX0lNUExfSAorI2Rl
ZmluZSBfS1VOSVRfREVWSUNFX0lNUExfSAorCisvLyBGb3IgaW50ZXJuYWwgdXNlIG9ubHkg
LS0gcmVnaXN0ZXJzIHRoZSBrdW5pdF9idXMuCitpbnQga3VuaXRfYnVzX2luaXQodm9pZCk7
CisKKyNlbmRpZiAvL19LVU5JVF9ERVZJQ0VfSU1QTF9ICmRpZmYgLS1naXQgYS9saWIva3Vu
aXQvZGV2aWNlLmMgYi9saWIva3VuaXQvZGV2aWNlLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi5mNTM3MTI4N2IzNzUKLS0tIC9kZXYvbnVsbAorKysgYi9s
aWIva3VuaXQvZGV2aWNlLmMKQEAgLTAsMCArMSwxODEgQEAKKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wCisvKgorICogS1VuaXQtbWFuYWdlZCBkZXZpY2UgaW1wbGVt
ZW50YXRpb24KKyAqCisgKiBJbXBsZW1lbnRhdGlvbiBvZiBzdHJ1Y3Qga3VuaXRfZGV2aWNl
IGhlbHBlcnMgZm9yIGZha2UgZGV2aWNlcyB3aG9zZQorICogbGlmZWN5Y2xlIGlzIG1hbmFn
ZWQgYnkgS1VuaXQuCisgKgorICogQ29weXJpZ2h0IChDKSAyMDIzLCBHb29nbGUgTExDLgor
ICogQXV0aG9yOiBEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+CisgKi8KKworI2lu
Y2x1ZGUgPGxpbnV4L2RldmljZS5oPgorCisjaW5jbHVkZSA8a3VuaXQvdGVzdC5oPgorI2lu
Y2x1ZGUgPGt1bml0L2RldmljZS5oPgorI2luY2x1ZGUgPGt1bml0L3Jlc291cmNlLmg+CisK
KyNpbmNsdWRlICJkZXZpY2UtaW1wbC5oIgorCisvKiBXcmFwcGVycyBmb3IgdXNlIHdpdGgg
a3VuaXRfYWRkX2FjdGlvbigpICovCitLVU5JVF9ERUZJTkVfQUNUSU9OX1dSQVBQRVIoZGV2
aWNlX3VucmVnaXN0ZXJfd3JhcHBlciwgZGV2aWNlX3VucmVnaXN0ZXIsIHN0cnVjdCBkZXZp
Y2UgKik7CitLVU5JVF9ERUZJTkVfQUNUSU9OX1dSQVBQRVIoZHJpdmVyX3VucmVnaXN0ZXJf
d3JhcHBlciwgZHJpdmVyX3VucmVnaXN0ZXIsIHN0cnVjdCBkZXZpY2VfZHJpdmVyICopOwor
CisvKiBUaGUgcm9vdCBkZXZpY2UgZm9yIHRoZSBLVW5pdCBidXMsIHBhcmVudCBvZiBhbGwg
a3VuaXRfZGV2aWNlcy4gKi8KK3N0YXRpYyBzdHJ1Y3QgZGV2aWNlICprdW5pdF9idXNfZGV2
aWNlOworCisvKiBBIGRldmljZSBvd25lZCBieSBhIEtVbml0IHRlc3QuICovCitzdHJ1Y3Qg
a3VuaXRfZGV2aWNlIHsKKwlzdHJ1Y3QgZGV2aWNlIGRldjsKKwkvKiBUaGUgS1VuaXQgdGVz
dCB3aGljaCBvd25zIHRoaXMgZGV2aWNlLiAqLworCXN0cnVjdCBrdW5pdCAqb3duZXI7CisJ
LyogSWYgdGhlIGRyaXZlciBpcyBtYW5hZ2VkIGJ5IEtVbml0IGFuZCB1bmlxdWUgdG8gdGhp
cyBkZXZpY2UuICovCisJY29uc3Qgc3RydWN0IGRldmljZV9kcml2ZXIgKmRyaXZlcjsKK307
CisKKyNkZWZpbmUgdG9fa3VuaXRfZGV2aWNlKGQpIGNvbnRhaW5lcl9vZl9jb25zdChkLCBz
dHJ1Y3Qga3VuaXRfZGV2aWNlLCBkZXYpCisKK3N0YXRpYyBzdHJ1Y3QgYnVzX3R5cGUga3Vu
aXRfYnVzX3R5cGUgPSB7CisJLm5hbWUJCT0gImt1bml0IiwKK307CisKKy8qIFJlZ2lzdGVy
IHRoZSAna3VuaXRfYnVzJyB1c2VkIGZvciBmYWtlIGRldmljZXMuICovCitpbnQga3VuaXRf
YnVzX2luaXQodm9pZCkKK3sKKwlpbnQgZXJyb3I7CisKKwlrdW5pdF9idXNfZGV2aWNlID0g
cm9vdF9kZXZpY2VfcmVnaXN0ZXIoImt1bml0Iik7CisJaWYgKCFrdW5pdF9idXNfZGV2aWNl
KQorCQlyZXR1cm4gLUVOT01FTTsKKworCWVycm9yID0gYnVzX3JlZ2lzdGVyKCZrdW5pdF9i
dXNfdHlwZSk7CisJaWYgKGVycm9yKQorCQlidXNfdW5yZWdpc3Rlcigma3VuaXRfYnVzX3R5
cGUpOworCXJldHVybiBlcnJvcjsKK30KKworLyogUmVsZWFzZSBhICdmYWtlJyBLVW5pdCBk
ZXZpY2UuICovCitzdGF0aWMgdm9pZCBrdW5pdF9kZXZpY2VfcmVsZWFzZShzdHJ1Y3QgZGV2
aWNlICpkKQoreworCWtmcmVlKHRvX2t1bml0X2RldmljZShkKSk7Cit9CisKKy8qCisgKiBD
cmVhdGUgYW5kIHJlZ2lzdGVyIGEgS1VuaXQtbWFuYWdlZCBzdHJ1Y3QgZGV2aWNlX2RyaXZl
ciBvbiB0aGUga3VuaXRfYnVzLgorICogUmV0dXJucyBhbiBlcnJvciBwb2ludGVyIG9uIGZh
aWx1cmUuCisgKi8KK3N0cnVjdCBkZXZpY2VfZHJpdmVyICprdW5pdF9kcml2ZXJfY3JlYXRl
KHN0cnVjdCBrdW5pdCAqdGVzdCwgY29uc3QgY2hhciAqbmFtZSkKK3sKKwlzdHJ1Y3QgZGV2
aWNlX2RyaXZlciAqZHJpdmVyOworCWludCBlcnIgPSAtRU5PTUVNOworCisJZHJpdmVyID0g
a3VuaXRfa3phbGxvYyh0ZXN0LCBzaXplb2YoKmRyaXZlciksIEdGUF9LRVJORUwpOworCisJ
aWYgKCFkcml2ZXIpCisJCXJldHVybiBFUlJfUFRSKGVycik7CisKKwlkcml2ZXItPm5hbWUg
PSBuYW1lOworCWRyaXZlci0+YnVzID0gJmt1bml0X2J1c190eXBlOworCWRyaXZlci0+b3du
ZXIgPSBUSElTX01PRFVMRTsKKworCWVyciA9IGRyaXZlcl9yZWdpc3Rlcihkcml2ZXIpOwor
CWlmIChlcnIpIHsKKwkJa3VuaXRfa2ZyZWUodGVzdCwgZHJpdmVyKTsKKwkJcmV0dXJuIEVS
Ul9QVFIoZXJyKTsKKwl9CisKKwlrdW5pdF9hZGRfYWN0aW9uKHRlc3QsIGRyaXZlcl91bnJl
Z2lzdGVyX3dyYXBwZXIsIGRyaXZlcik7CisJcmV0dXJuIGRyaXZlcjsKK30KK0VYUE9SVF9T
WU1CT0xfR1BMKGt1bml0X2RyaXZlcl9jcmVhdGUpOworCisvKiBIZWxwZXIgd2hpY2ggY3Jl
YXRlcyBhIGt1bml0X2RldmljZSwgYXR0YWNoZXMgaXQgdG8gdGhlIGt1bml0X2J1cyovCitz
dGF0aWMgc3RydWN0IGt1bml0X2RldmljZSAqa3VuaXRfZGV2aWNlX3JlZ2lzdGVyX2ludGVy
bmFsKHN0cnVjdCBrdW5pdCAqdGVzdCwKKwkJCQkJCQkgICBjb25zdCBjaGFyICpuYW1lLAor
CQkJCQkJCSAgIGNvbnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYpCit7CisJc3RydWN0
IGt1bml0X2RldmljZSAqa3VuaXRfZGV2OworCWludCBlcnIgPSAtRU5PTUVNOworCisJa3Vu
aXRfZGV2ID0ga3phbGxvYyhzaXplb2YoKmt1bml0X2RldiksIEdGUF9LRVJORUwpOworCWlm
ICgha3VuaXRfZGV2KQorCQlyZXR1cm4gRVJSX1BUUihlcnIpOworCisJa3VuaXRfZGV2LT5v
d25lciA9IHRlc3Q7CisKKwllcnIgPSBkZXZfc2V0X25hbWUoJmt1bml0X2Rldi0+ZGV2LCAi
JXMuJXMiLCB0ZXN0LT5uYW1lLCBuYW1lKTsKKwlpZiAoZXJyKSB7CisJCWtmcmVlKGt1bml0
X2Rldik7CisJCXJldHVybiBFUlJfUFRSKGVycik7CisJfQorCisJa3VuaXRfZGV2LT5kZXYu
cmVsZWFzZSA9IGt1bml0X2RldmljZV9yZWxlYXNlOworCWt1bml0X2Rldi0+ZGV2LmJ1cyA9
ICZrdW5pdF9idXNfdHlwZTsKKwlrdW5pdF9kZXYtPmRldi5wYXJlbnQgPSBrdW5pdF9idXNf
ZGV2aWNlOworCisJZXJyID0gZGV2aWNlX3JlZ2lzdGVyKCZrdW5pdF9kZXYtPmRldik7CisJ
aWYgKGVycikgeworCQlwdXRfZGV2aWNlKCZrdW5pdF9kZXYtPmRldik7CisJCXJldHVybiBF
UlJfUFRSKGVycik7CisJfQorCisJa3VuaXRfYWRkX2FjdGlvbih0ZXN0LCBkZXZpY2VfdW5y
ZWdpc3Rlcl93cmFwcGVyLCAma3VuaXRfZGV2LT5kZXYpOworCisJcmV0dXJuIGt1bml0X2Rl
djsKK30KKworLyoKKyAqIENyZWF0ZSBhbmQgcmVnaXN0ZXIgYSBuZXcgS1VuaXQtbWFuYWdl
ZCBkZXZpY2UsIHVzaW5nIHRoZSB1c2VyLXN1cHBsaWVkIGRldmljZV9kcml2ZXIuCisgKiBP
biBmYWlsdXJlLCByZXR1cm5zIGFuIGVycm9yIHBvaW50ZXIuCisgKi8KK3N0cnVjdCBkZXZp
Y2UgKmt1bml0X2RldmljZV9yZWdpc3Rlcl93aXRoX2RyaXZlcihzdHJ1Y3Qga3VuaXQgKnRl
c3QsCisJCQkJCQkgY29uc3QgY2hhciAqbmFtZSwKKwkJCQkJCSBjb25zdCBzdHJ1Y3QgZGV2
aWNlX2RyaXZlciAqZHJ2KQoreworCXN0cnVjdCBrdW5pdF9kZXZpY2UgKmt1bml0X2RldiA9
IGt1bml0X2RldmljZV9yZWdpc3Rlcl9pbnRlcm5hbCh0ZXN0LCBuYW1lLCBkcnYpOworCisJ
aWYgKElTX0VSUl9PUl9OVUxMKGt1bml0X2RldikpCisJCXJldHVybiBFUlJfQ0FTVChrdW5p
dF9kZXYpOworCisJcmV0dXJuICZrdW5pdF9kZXYtPmRldjsKK30KK0VYUE9SVF9TWU1CT0xf
R1BMKGt1bml0X2RldmljZV9yZWdpc3Rlcl93aXRoX2RyaXZlcik7CisKKy8qCisgKiBDcmVh
dGUgYW5kIHJlZ2lzdGVyIGEgbmV3IEtVbml0LW1hbmFnZWQgZGV2aWNlLCBpbmNsdWRpbmcg
YSBtYXRjaGluZyBkZXZpY2VfZHJpdmVyLgorICogT24gZmFpbHVyZSwgcmV0dXJucyBhbiBl
cnJvciBwb2ludGVyLgorICovCitzdHJ1Y3QgZGV2aWNlICprdW5pdF9kZXZpY2VfcmVnaXN0
ZXIoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCBjaGFyICpuYW1lKQoreworCXN0cnVjdCBk
ZXZpY2VfZHJpdmVyICpkcnY7CisJc3RydWN0IGt1bml0X2RldmljZSAqZGV2OworCisJZHJ2
ID0ga3VuaXRfZHJpdmVyX2NyZWF0ZSh0ZXN0LCBuYW1lKTsKKwlpZiAoSVNfRVJSKGRydikp
CisJCXJldHVybiBFUlJfQ0FTVChkcnYpOworCisJZGV2ID0ga3VuaXRfZGV2aWNlX3JlZ2lz
dGVyX2ludGVybmFsKHRlc3QsIG5hbWUsIGRydik7CisJaWYgKElTX0VSUihkZXYpKSB7CisJ
CWt1bml0X3JlbGVhc2VfYWN0aW9uKHRlc3QsIGRyaXZlcl91bnJlZ2lzdGVyX3dyYXBwZXIs
ICh2b2lkICopZHJ2KTsKKwkJcmV0dXJuIEVSUl9DQVNUKGRldik7CisJfQorCisJLyogUmVx
dWVzdCB0aGUgZHJpdmVyIGJlIGZyZWVkLiAqLworCWRldi0+ZHJpdmVyID0gZHJ2OworCisK
KwlyZXR1cm4gJmRldi0+ZGV2OworfQorRVhQT1JUX1NZTUJPTF9HUEwoa3VuaXRfZGV2aWNl
X3JlZ2lzdGVyKTsKKworLyogVW5yZWdpc3RlcnMgYSBLVW5pdC1tYW5hZ2VkIGRldmljZSBl
YXJseSAoaW5jbHVkaW5nIHRoZSBkcml2ZXIsIGlmIGF1dG9tYXRpY2FsbHkgY3JlYXRlZCku
ICovCit2b2lkIGt1bml0X2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdCBrdW5pdCAqdGVzdCwg
c3RydWN0IGRldmljZSAqZGV2KQoreworCWNvbnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpk
cml2ZXIgPSB0b19rdW5pdF9kZXZpY2UoZGV2KS0+ZHJpdmVyOworCisJa3VuaXRfcmVsZWFz
ZV9hY3Rpb24odGVzdCwgZGV2aWNlX3VucmVnaXN0ZXJfd3JhcHBlciwgZGV2KTsKKwlpZiAo
ZHJpdmVyKQorCQlrdW5pdF9yZWxlYXNlX2FjdGlvbih0ZXN0LCBkcml2ZXJfdW5yZWdpc3Rl
cl93cmFwcGVyLCAodm9pZCAqKWRyaXZlcik7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChrdW5p
dF9kZXZpY2VfdW5yZWdpc3Rlcik7CisKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9leGVjdXRv
ci5jIGIvbGliL2t1bml0L2V4ZWN1dG9yLmMKaW5kZXggMTIzNmIzY2QyZmJiLi43MTdiOTU5
OTAzNmIgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9leGVjdXRvci5jCisrKyBiL2xpYi9rdW5p
dC9leGVjdXRvci5jCkBAIC0xMiw2ICsxMiw4IEBACiAgKi8KIGV4dGVybiBzdHJ1Y3Qga3Vu
aXRfc3VpdGUgKiBjb25zdCBfX2t1bml0X3N1aXRlc19zdGFydFtdOwogZXh0ZXJuIHN0cnVj
dCBrdW5pdF9zdWl0ZSAqIGNvbnN0IF9fa3VuaXRfc3VpdGVzX2VuZFtdOworZXh0ZXJuIHN0
cnVjdCBrdW5pdF9zdWl0ZSAqIGNvbnN0IF9fa3VuaXRfaW5pdF9zdWl0ZXNfc3RhcnRbXTsK
K2V4dGVybiBzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBjb25zdCBfX2t1bml0X2luaXRfc3VpdGVz
X2VuZFtdOwogCiBzdGF0aWMgY2hhciAqYWN0aW9uX3BhcmFtOwogCkBAIC0yOTIsNiArMjk0
LDM3IEBAIHZvaWQga3VuaXRfZXhlY19saXN0X3Rlc3RzKHN0cnVjdCBrdW5pdF9zdWl0ZV9z
ZXQgKnN1aXRlX3NldCwgYm9vbCBpbmNsdWRlX2F0dHIpCiAJfQogfQogCitzdHJ1Y3Qga3Vu
aXRfc3VpdGVfc2V0IGt1bml0X21lcmdlX3N1aXRlX3NldHMoc3RydWN0IGt1bml0X3N1aXRl
X3NldCBpbml0X3N1aXRlX3NldCwKKwkJc3RydWN0IGt1bml0X3N1aXRlX3NldCBzdWl0ZV9z
ZXQpCit7CisJc3RydWN0IGt1bml0X3N1aXRlX3NldCB0b3RhbF9zdWl0ZV9zZXQgPSB7TlVM
TCwgTlVMTH07CisJc3RydWN0IGt1bml0X3N1aXRlICoqdG90YWxfc3VpdGVfc3RhcnQgPSBO
VUxMOworCXNpemVfdCBpbml0X251bV9zdWl0ZXMsIG51bV9zdWl0ZXMsIHN1aXRlX3NpemU7
CisJaW50IGkgPSAwOworCisJaW5pdF9udW1fc3VpdGVzID0gaW5pdF9zdWl0ZV9zZXQuZW5k
IC0gaW5pdF9zdWl0ZV9zZXQuc3RhcnQ7CisJbnVtX3N1aXRlcyA9IHN1aXRlX3NldC5lbmQg
LSBzdWl0ZV9zZXQuc3RhcnQ7CisJc3VpdGVfc2l6ZSA9IHNpemVvZihzdWl0ZV9zZXQuc3Rh
cnQpOworCisJLyogQWxsb2NhdGUgbWVtb3J5IGZvciBhcnJheSBvZiBhbGwga3VuaXQgc3Vp
dGVzICovCisJdG90YWxfc3VpdGVfc3RhcnQgPSBrbWFsbG9jX2FycmF5KGluaXRfbnVtX3N1
aXRlcyArIG51bV9zdWl0ZXMsIHN1aXRlX3NpemUsIEdGUF9LRVJORUwpOworCWlmICghdG90
YWxfc3VpdGVfc3RhcnQpCisJCXJldHVybiB0b3RhbF9zdWl0ZV9zZXQ7CisKKwkvKiBBcHBl
bmQgYW5kIG1hcmsgaW5pdCBzdWl0ZXMgYW5kIHRoZW4gYXBwZW5kIGFsbCBvdGhlciBrdW5p
dCBzdWl0ZXMgKi8KKwltZW1jcHkodG90YWxfc3VpdGVfc3RhcnQsIGluaXRfc3VpdGVfc2V0
LnN0YXJ0LCBpbml0X251bV9zdWl0ZXMgKiBzdWl0ZV9zaXplKTsKKwlmb3IgKGkgPSAwOyBp
IDwgaW5pdF9udW1fc3VpdGVzOyBpKyspCisJCXRvdGFsX3N1aXRlX3N0YXJ0W2ldLT5pc19p
bml0ID0gdHJ1ZTsKKworCW1lbWNweSh0b3RhbF9zdWl0ZV9zdGFydCArIGluaXRfbnVtX3N1
aXRlcywgc3VpdGVfc2V0LnN0YXJ0LCBudW1fc3VpdGVzICogc3VpdGVfc2l6ZSk7CisKKwkv
KiBTZXQga3VuaXQgc3VpdGUgc2V0IHN0YXJ0IGFuZCBlbmQgKi8KKwl0b3RhbF9zdWl0ZV9z
ZXQuc3RhcnQgPSB0b3RhbF9zdWl0ZV9zdGFydDsKKwl0b3RhbF9zdWl0ZV9zZXQuZW5kID0g
dG90YWxfc3VpdGVfc3RhcnQgKyAoaW5pdF9udW1fc3VpdGVzICsgbnVtX3N1aXRlcyk7CisK
KwlyZXR1cm4gdG90YWxfc3VpdGVfc2V0OworfQorCiAjaWYgSVNfQlVJTFRJTihDT05GSUdf
S1VOSVQpCiAKIHN0YXRpYyBjaGFyICprdW5pdF9zaHV0ZG93bjsKQEAgLTMxMywyMSArMzQ2
LDQxIEBAIHN0YXRpYyB2b2lkIGt1bml0X2hhbmRsZV9zaHV0ZG93bih2b2lkKQogCiBpbnQg
a3VuaXRfcnVuX2FsbF90ZXN0cyh2b2lkKQogewotCXN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQg
c3VpdGVfc2V0ID0geworCXN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgc3VpdGVfc2V0ID0ge05V
TEwsIE5VTEx9OworCXN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgZmlsdGVyZWRfc3VpdGVfc2V0
ID0ge05VTEwsIE5VTEx9OworCXN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgaW5pdF9zdWl0ZV9z
ZXQgPSB7CisJCV9fa3VuaXRfaW5pdF9zdWl0ZXNfc3RhcnQsIF9fa3VuaXRfaW5pdF9zdWl0
ZXNfZW5kLAorCX07CisJc3RydWN0IGt1bml0X3N1aXRlX3NldCBub3JtYWxfc3VpdGVfc2V0
ID0gewogCQlfX2t1bml0X3N1aXRlc19zdGFydCwgX19rdW5pdF9zdWl0ZXNfZW5kLAogCX07
CisJc2l6ZV90IGluaXRfbnVtX3N1aXRlcyA9IGluaXRfc3VpdGVfc2V0LmVuZCAtIGluaXRf
c3VpdGVfc2V0LnN0YXJ0OwogCWludCBlcnIgPSAwOworCisJaWYgKGluaXRfbnVtX3N1aXRl
cyA+IDApIHsKKwkJc3VpdGVfc2V0ID0ga3VuaXRfbWVyZ2Vfc3VpdGVfc2V0cyhpbml0X3N1
aXRlX3NldCwgbm9ybWFsX3N1aXRlX3NldCk7CisJCWlmICghc3VpdGVfc2V0LnN0YXJ0KQor
CQkJZ290byBvdXQ7CisJfSBlbHNlCisJCXN1aXRlX3NldCA9IG5vcm1hbF9zdWl0ZV9zZXQ7
CisKIAlpZiAoIWt1bml0X2VuYWJsZWQoKSkgewogCQlwcl9pbmZvKCJrdW5pdDogZGlzYWJs
ZWRcbiIpOwotCQlnb3RvIG91dDsKKwkJZ290byBmcmVlX291dDsKIAl9CiAKIAlpZiAoZmls
dGVyX2dsb2JfcGFyYW0gfHwgZmlsdGVyX3BhcmFtKSB7Ci0JCXN1aXRlX3NldCA9IGt1bml0
X2ZpbHRlcl9zdWl0ZXMoJnN1aXRlX3NldCwgZmlsdGVyX2dsb2JfcGFyYW0sCisJCWZpbHRl
cmVkX3N1aXRlX3NldCA9IGt1bml0X2ZpbHRlcl9zdWl0ZXMoJnN1aXRlX3NldCwgZmlsdGVy
X2dsb2JfcGFyYW0sCiAJCQkJZmlsdGVyX3BhcmFtLCBmaWx0ZXJfYWN0aW9uX3BhcmFtLCAm
ZXJyKTsKKworCQkvKiBGcmVlIG9yaWdpbmFsIHN1aXRlIHNldCBiZWZvcmUgdXNpbmcgZmls
dGVyZWQgc3VpdGUgc2V0ICovCisJCWlmIChpbml0X251bV9zdWl0ZXMgPiAwKQorCQkJa2Zy
ZWUoc3VpdGVfc2V0LnN0YXJ0KTsKKwkJc3VpdGVfc2V0ID0gZmlsdGVyZWRfc3VpdGVfc2V0
OworCiAJCWlmIChlcnIpIHsKIAkJCXByX2Vycigia3VuaXQgZXhlY3V0b3I6IGVycm9yIGZp
bHRlcmluZyBzdWl0ZXM6ICVkXG4iLCBlcnIpOwotCQkJZ290byBvdXQ7CisJCQlnb3RvIGZy
ZWVfb3V0OwogCQl9CiAJfQogCkBAIC0zNDAsOSArMzkzLDEyIEBAIGludCBrdW5pdF9ydW5f
YWxsX3Rlc3RzKHZvaWQpCiAJZWxzZQogCQlwcl9lcnIoImt1bml0IGV4ZWN1dG9yOiB1bmtu
b3duIGFjdGlvbiAnJXMnXG4iLCBhY3Rpb25fcGFyYW0pOwogCi0JaWYgKGZpbHRlcl9nbG9i
X3BhcmFtIHx8IGZpbHRlcl9wYXJhbSkgeyAvKiBhIGNvcHkgd2FzIG1hZGUgb2YgZWFjaCBz
dWl0ZSAqLworZnJlZV9vdXQ6CisJaWYgKGZpbHRlcl9nbG9iX3BhcmFtIHx8IGZpbHRlcl9w
YXJhbSkKIAkJa3VuaXRfZnJlZV9zdWl0ZV9zZXQoc3VpdGVfc2V0KTsKLQl9CisJZWxzZSBp
ZiAoaW5pdF9udW1fc3VpdGVzID4gMCkKKwkJLyogRG9uJ3QgdXNlIGt1bml0X2ZyZWVfc3Vp
dGVfc2V0IGJlY2F1c2Ugc3VpdGVzIGFyZW4ndCBpbmRpdmlkdWFsbHkgYWxsb2NhdGVkICov
CisJCWtmcmVlKHN1aXRlX3NldC5zdGFydCk7CiAKIG91dDoKIAlrdW5pdF9oYW5kbGVfc2h1
dGRvd24oKTsKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9rdW5pdC1leGFtcGxlLXRlc3QuYyBi
L2xpYi9rdW5pdC9rdW5pdC1leGFtcGxlLXRlc3QuYwppbmRleCA2YmI1YzJlZjY2OTYuLjc5
ODkyNGY3Y2M4NiAxMDA2NDQKLS0tIGEvbGliL2t1bml0L2t1bml0LWV4YW1wbGUtdGVzdC5j
CisrKyBiL2xpYi9rdW5pdC9rdW5pdC1leGFtcGxlLXRlc3QuYwpAQCAtMTY4LDYgKzE2OCwx
NiBAQCBzdGF0aWMgaW50IHN1YnRyYWN0X29uZShpbnQgaSkKIAlyZXR1cm4gaSAtIDE7CiB9
CiAKKy8qCisgKiBJZiB0aGUgZnVuY3Rpb24gdG8gYmUgcmVwbGFjZWQgaXMgc3RhdGljIHdp
dGhpbiBhIG1vZHVsZSBpdCBpcworICogdXNlZnVsIHRvIGV4cG9ydCBhIHBvaW50ZXIgdG8g
dGhhdCBmdW5jdGlvbiBpbnN0ZWFkIG9mIGhhdmluZworICogdG8gY2hhbmdlIHRoZSBzdGF0
aWMgZnVuY3Rpb24gdG8gYSBub24tc3RhdGljIGV4cG9ydGVkIGZ1bmN0aW9uLgorICoKKyAq
IFRoaXMgcG9pbnRlciBzaW11bGF0ZXMgYSBtb2R1bGUgZXhwb3J0aW5nIGEgcG9pbnRlciB0
byBhIHN0YXRpYworICogZnVuY3Rpb24uCisgKi8KK3N0YXRpYyBpbnQgKCogY29uc3QgYWRk
X29uZV9mbl9wdHIpKGludCBpKSA9IGFkZF9vbmU7CisKIC8qCiAgKiBUaGlzIHRlc3Qgc2hv
d3MgdGhlIHVzZSBvZiBzdGF0aWMgc3R1YnMuCiAgKi8KQEAgLTE4Nyw2ICsxOTcsMzAgQEAg
c3RhdGljIHZvaWQgZXhhbXBsZV9zdGF0aWNfc3R1Yl90ZXN0KHN0cnVjdCBrdW5pdCAqdGVz
dCkKIAlLVU5JVF9FWFBFQ1RfRVEodGVzdCwgYWRkX29uZSgxKSwgMik7CiB9CiAKKy8qCisg
KiBUaGlzIHRlc3Qgc2hvd3MgdGhlIHVzZSBvZiBzdGF0aWMgc3R1YnMgd2hlbiB0aGUgZnVu
Y3Rpb24gYmVpbmcKKyAqIHJlcGxhY2VkIGlzIHByb3ZpZGVkIGFzIGEgcG9pbnRlci10by1m
dW5jdGlvbiBpbnN0ZWFkIG9mIHRoZQorICogYWN0dWFsIGZ1bmN0aW9uLiBUaGlzIGlzIHVz
ZWZ1bCBmb3IgcHJvdmlkaW5nIGFjY2VzcyB0byBzdGF0aWMKKyAqIGZ1bmN0aW9ucyBpbiBh
IG1vZHVsZSBieSBleHBvcnRpbmcgYSBwb2ludGVyIHRvIHRoYXQgZnVuY3Rpb24KKyAqIGlu
c3RlYWQgb2YgaGF2aW5nIHRvIGNoYW5nZSB0aGUgc3RhdGljIGZ1bmN0aW9uIHRvIGEgbm9u
LXN0YXRpYworICogZXhwb3J0ZWQgZnVuY3Rpb24uCisgKi8KK3N0YXRpYyB2b2lkIGV4YW1w
bGVfc3RhdGljX3N0dWJfdXNpbmdfZm5fcHRyX3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQor
eworCS8qIEJ5IGRlZmF1bHQsIGZ1bmN0aW9uIGlzIG5vdCBzdHViYmVkLiAqLworCUtVTklU
X0VYUEVDVF9FUSh0ZXN0LCBhZGRfb25lKDEpLCAyKTsKKworCS8qIFJlcGxhY2UgYWRkX29u
ZSgpIHdpdGggc3VidHJhY3Rfb25lKCkuICovCisJa3VuaXRfYWN0aXZhdGVfc3RhdGljX3N0
dWIodGVzdCwgYWRkX29uZV9mbl9wdHIsIHN1YnRyYWN0X29uZSk7CisKKwkvKiBhZGRfb25l
KCkgaXMgbm93IHJlcGxhY2VkLiAqLworCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBhZGRfb25l
KDEpLCAwKTsKKworCS8qIFJldHVybiBhZGRfb25lKCkgdG8gbm9ybWFsLiAqLworCWt1bml0
X2RlYWN0aXZhdGVfc3RhdGljX3N0dWIodGVzdCwgYWRkX29uZV9mbl9wdHIpOworCUtVTklU
X0VYUEVDVF9FUSh0ZXN0LCBhZGRfb25lKDEpLCAyKTsKK30KKwogc3RhdGljIGNvbnN0IHN0
cnVjdCBleGFtcGxlX3BhcmFtIHsKIAlpbnQgdmFsdWU7CiB9IGV4YW1wbGVfcGFyYW1zX2Fy
cmF5W10gPSB7CkBAIC0yMjEsNiArMjU1LDIwIEBAIHN0YXRpYyB2b2lkIGV4YW1wbGVfcGFy
YW1zX3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQogCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBw
YXJhbS0+dmFsdWUgJSBwYXJhbS0+dmFsdWUsIDApOwogfQogCisvKgorICogVGhpcyB0ZXN0
IHNob3dzIHRoZSB1c2Ugb2YgdGVzdC0+cHJpdi4KKyAqLworc3RhdGljIHZvaWQgZXhhbXBs
ZV9wcml2X3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQoreworCS8qIHVubGVzcyBzZXR1cCBp
biBzdWl0ZS0+aW5pdCgpLCB0ZXN0LT5wcml2IGlzIE5VTEwgKi8KKwlLVU5JVF9BU1NFUlRf
TlVMTCh0ZXN0LCB0ZXN0LT5wcml2KTsKKworCS8qIGJ1dCBjYW4gYmUgdXNlZCB0byBwYXNz
IGFyYml0cmFyeSBkYXRhIHRvIG90aGVyIGZ1bmN0aW9ucyAqLworCXRlc3QtPnByaXYgPSBr
dW5pdF9remFsbG9jKHRlc3QsIDEsIEdGUF9LRVJORUwpOworCUtVTklUX0VYUEVDVF9OT1Rf
TlVMTCh0ZXN0LCB0ZXN0LT5wcml2KTsKKwlLVU5JVF9BU1NFUlRfUFRSX0VRKHRlc3QsIHRl
c3QtPnByaXYsIGt1bml0X2dldF9jdXJyZW50X3Rlc3QoKS0+cHJpdik7Cit9CisKIC8qCiAg
KiBUaGlzIHRlc3Qgc2hvdWxkIGFsd2F5cyBwYXNzLiBDYW4gYmUgdXNlZCB0byBwcmFjdGlj
ZSBmaWx0ZXJpbmcgYXR0cmlidXRlcy4KICAqLwpAQCAtMjQ1LDYgKzI5Myw4IEBAIHN0YXRp
YyBzdHJ1Y3Qga3VuaXRfY2FzZSBleGFtcGxlX3Rlc3RfY2FzZXNbXSA9IHsKIAlLVU5JVF9D
QVNFKGV4YW1wbGVfbWFya19za2lwcGVkX3Rlc3QpLAogCUtVTklUX0NBU0UoZXhhbXBsZV9h
bGxfZXhwZWN0X21hY3Jvc190ZXN0KSwKIAlLVU5JVF9DQVNFKGV4YW1wbGVfc3RhdGljX3N0
dWJfdGVzdCksCisJS1VOSVRfQ0FTRShleGFtcGxlX3N0YXRpY19zdHViX3VzaW5nX2ZuX3B0
cl90ZXN0KSwKKwlLVU5JVF9DQVNFKGV4YW1wbGVfcHJpdl90ZXN0KSwKIAlLVU5JVF9DQVNF
X1BBUkFNKGV4YW1wbGVfcGFyYW1zX3Rlc3QsIGV4YW1wbGVfZ2VuX3BhcmFtcyksCiAJS1VO
SVRfQ0FTRV9TTE9XKGV4YW1wbGVfc2xvd190ZXN0KSwKIAl7fQpAQCAtMjg3LDQgKzMzNyw0
MSBAQCBzdGF0aWMgc3RydWN0IGt1bml0X3N1aXRlIGV4YW1wbGVfdGVzdF9zdWl0ZSA9IHsK
ICAqLwoga3VuaXRfdGVzdF9zdWl0ZXMoJmV4YW1wbGVfdGVzdF9zdWl0ZSk7CiAKK3N0YXRp
YyBpbnQgX19pbml0IGluaXRfYWRkKGludCB4LCBpbnQgeSkKK3sKKwlyZXR1cm4gKHggKyB5
KTsKK30KKworLyoKKyAqIFRoaXMgdGVzdCBzaG91bGQgYWx3YXlzIHBhc3MuIENhbiBiZSB1
c2VkIHRvIHRlc3QgaW5pdCBzdWl0ZXMuCisgKi8KK3N0YXRpYyB2b2lkIF9faW5pdCBleGFt
cGxlX2luaXRfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCit7CisJS1VOSVRfRVhQRUNUX0VR
KHRlc3QsIGluaXRfYWRkKDEsIDEpLCAyKTsKK30KKworLyoKKyAqIFRoZSBrdW5pdF9jYXNl
IHN0cnVjdCBjYW5ub3QgYmUgbWFya2VkIGFzIF9faW5pdGRhdGEgYXMgdGhpcyB3aWxsIGJl
CisgKiB1c2VkIGluIGRlYnVnZnMgdG8gcmV0cmlldmUgcmVzdWx0cyBhZnRlciB0ZXN0IGhh
cyBydW4KKyAqLworc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNlIF9fcmVmZGF0YSBleGFtcGxl
X2luaXRfdGVzdF9jYXNlc1tdID0geworCUtVTklUX0NBU0UoZXhhbXBsZV9pbml0X3Rlc3Qp
LAorCXt9Cit9OworCisvKgorICogVGhlIGt1bml0X3N1aXRlIHN0cnVjdCBjYW5ub3QgYmUg
bWFya2VkIGFzIF9faW5pdGRhdGEgYXMgdGhpcyB3aWxsIGJlCisgKiB1c2VkIGluIGRlYnVn
ZnMgdG8gcmV0cmlldmUgcmVzdWx0cyBhZnRlciB0ZXN0IGhhcyBydW4KKyAqLworc3RhdGlj
IHN0cnVjdCBrdW5pdF9zdWl0ZSBleGFtcGxlX2luaXRfdGVzdF9zdWl0ZSA9IHsKKwkubmFt
ZSA9ICJleGFtcGxlX2luaXQiLAorCS50ZXN0X2Nhc2VzID0gZXhhbXBsZV9pbml0X3Rlc3Rf
Y2FzZXMsCit9OworCisvKgorICogVGhpcyByZWdpc3RlcnMgdGhlIHRlc3Qgc3VpdGUgYW5k
IG1hcmtzIHRoZSBzdWl0ZSBhcyB1c2luZyBpbml0IGRhdGEKKyAqIGFuZC9vciBmdW5jdGlv
bnMuCisgKi8KK2t1bml0X3Rlc3RfaW5pdF9zZWN0aW9uX3N1aXRlcygmZXhhbXBsZV9pbml0
X3Rlc3Rfc3VpdGUpOworCiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CmRpZmYgLS1naXQg
YS9saWIva3VuaXQva3VuaXQtdGVzdC5jIGIvbGliL2t1bml0L2t1bml0LXRlc3QuYwppbmRl
eCBkZTIxMTNhNThmYTAuLmM0MjU5ZDkxMDM1NiAxMDA2NDQKLS0tIGEvbGliL2t1bml0L2t1
bml0LXRlc3QuYworKysgYi9saWIva3VuaXQva3VuaXQtdGVzdC5jCkBAIC01LDkgKzUsMTMg
QEAKICAqIENvcHlyaWdodCAoQykgMjAxOSwgR29vZ2xlIExMQy4KICAqIEF1dGhvcjogQnJl
bmRhbiBIaWdnaW5zIDxicmVuZGFuaGlnZ2luc0Bnb29nbGUuY29tPgogICovCisjaW5jbHVk
ZSAibGludXgvZ2ZwX3R5cGVzLmgiCiAjaW5jbHVkZSA8a3VuaXQvdGVzdC5oPgogI2luY2x1
ZGUgPGt1bml0L3Rlc3QtYnVnLmg+CiAKKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNp
bmNsdWRlIDxrdW5pdC9kZXZpY2UuaD4KKwogI2luY2x1ZGUgInN0cmluZy1zdHJlYW0uaCIK
ICNpbmNsdWRlICJ0cnktY2F0Y2gtaW1wbC5oIgogCkBAIC01MzgsMTAgKzU0Miw3IEBAIHN0
YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUga3VuaXRfcmVzb3VyY2VfdGVzdF9zdWl0ZSA9IHsK
ICNpZiBJU19CVUlMVElOKENPTkZJR19LVU5JVF9URVNUKQogCiAvKiBUaGlzIGF2b2lkcyBh
IGNhc3Qgd2FybmluZyBpZiBrZnJlZSgpIGlzIHBhc3NlZCBkaXJlY3QgdG8ga3VuaXRfYWRk
X2FjdGlvbigpLiAqLwotc3RhdGljIHZvaWQga2ZyZWVfd3JhcHBlcih2b2lkICpwKQotewot
CWtmcmVlKHApOwotfQorS1VOSVRfREVGSU5FX0FDVElPTl9XUkFQUEVSKGtmcmVlX3dyYXBw
ZXIsIGtmcmVlLCBjb25zdCB2b2lkICopOwogCiBzdGF0aWMgdm9pZCBrdW5pdF9sb2dfdGVz
dChzdHJ1Y3Qga3VuaXQgKnRlc3QpCiB7CkBAIC02OTAsNiArNjkxLDEzNCBAQCBzdGF0aWMg
c3RydWN0IGt1bml0X2Nhc2Uga3VuaXRfY3VycmVudF90ZXN0X2Nhc2VzW10gPSB7CiAJe30K
IH07CiAKK3N0YXRpYyB2b2lkIHRlc3RfZGV2X2FjdGlvbih2b2lkICpwcml2KQoreworCSoo
dm9pZCAqKilwcml2ID0gKHZvaWQgKikxOworfQorCitzdGF0aWMgdm9pZCBrdW5pdF9kZXZp
Y2VfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCit7CisJc3RydWN0IGRldmljZSAqdGVzdF9k
ZXZpY2U7CisJbG9uZyBhY3Rpb25fd2FzX3J1biA9IDA7CisKKwl0ZXN0X2RldmljZSA9IGt1
bml0X2RldmljZV9yZWdpc3Rlcih0ZXN0LCAibXlfZGV2aWNlIik7CisJS1VOSVRfQVNTRVJU
X05PVF9FUlJfT1JfTlVMTCh0ZXN0LCB0ZXN0X2RldmljZSk7CisKKwkvLyBBZGQgYW4gYWN0
aW9uIHRvIHZlcmlmeSBjbGVhbnVwLgorCWRldm1fYWRkX2FjdGlvbih0ZXN0X2RldmljZSwg
dGVzdF9kZXZfYWN0aW9uLCAmYWN0aW9uX3dhc19ydW4pOworCisJS1VOSVRfRVhQRUNUX0VR
KHRlc3QsIGFjdGlvbl93YXNfcnVuLCAwKTsKKworCWt1bml0X2RldmljZV91bnJlZ2lzdGVy
KHRlc3QsIHRlc3RfZGV2aWNlKTsKKworCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBhY3Rpb25f
d2FzX3J1biwgMSk7Cit9CisKK3N0YXRpYyB2b2lkIGt1bml0X2RldmljZV9jbGVhbnVwX3Rl
c3Qoc3RydWN0IGt1bml0ICp0ZXN0KQoreworCXN0cnVjdCBkZXZpY2UgKnRlc3RfZGV2aWNl
OworCWxvbmcgYWN0aW9uX3dhc19ydW4gPSAwOworCisJdGVzdF9kZXZpY2UgPSBrdW5pdF9k
ZXZpY2VfcmVnaXN0ZXIodGVzdCwgIm15X2RldmljZSIpOworCUtVTklUX0FTU0VSVF9OT1Rf
TlVMTCh0ZXN0LCB0ZXN0X2RldmljZSk7CisKKwkvKiBBZGQgYW4gYWN0aW9uIHRvIHZlcmlm
eSBjbGVhbnVwLiAqLworCWRldm1fYWRkX2FjdGlvbih0ZXN0X2RldmljZSwgdGVzdF9kZXZf
YWN0aW9uLCAmYWN0aW9uX3dhc19ydW4pOworCisJS1VOSVRfRVhQRUNUX0VRKHRlc3QsIGFj
dGlvbl93YXNfcnVuLCAwKTsKKworCS8qIEZvcmNlIEtVbml0IHRvIHJ1biBjbGVhbnVwIGVh
cmx5LiAqLworCWt1bml0X2NsZWFudXAodGVzdCk7CisKKwlLVU5JVF9FWFBFQ1RfRVEodGVz
dCwgYWN0aW9uX3dhc19ydW4sIDEpOworfQorCitzdHJ1Y3QgZHJpdmVyX3Rlc3Rfc3RhdGUg
eworCWJvb2wgZHJpdmVyX2RldmljZV9wcm9iZWQ7CisJYm9vbCBkcml2ZXJfZGV2aWNlX3Jl
bW92ZWQ7CisJbG9uZyBhY3Rpb25fd2FzX3J1bjsKK307CisKK3N0YXRpYyBpbnQgZHJpdmVy
X3Byb2JlX2hvb2soc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBrdW5pdCAqdGVz
dCA9IGt1bml0X2dldF9jdXJyZW50X3Rlc3QoKTsKKwlzdHJ1Y3QgZHJpdmVyX3Rlc3Rfc3Rh
dGUgKnN0YXRlID0gKHN0cnVjdCBkcml2ZXJfdGVzdF9zdGF0ZSAqKXRlc3QtPnByaXY7CisK
KwlzdGF0ZS0+ZHJpdmVyX2RldmljZV9wcm9iZWQgPSB0cnVlOworCXJldHVybiAwOworfQor
CitzdGF0aWMgaW50IGRyaXZlcl9yZW1vdmVfaG9vayhzdHJ1Y3QgZGV2aWNlICpkZXYpCit7
CisJc3RydWN0IGt1bml0ICp0ZXN0ID0ga3VuaXRfZ2V0X2N1cnJlbnRfdGVzdCgpOworCXN0
cnVjdCBkcml2ZXJfdGVzdF9zdGF0ZSAqc3RhdGUgPSAoc3RydWN0IGRyaXZlcl90ZXN0X3N0
YXRlICopdGVzdC0+cHJpdjsKKworCXN0YXRlLT5kcml2ZXJfZGV2aWNlX3JlbW92ZWQgPSB0
cnVlOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBrdW5pdF9kZXZpY2VfZHJpdmVy
X3Rlc3Qoc3RydWN0IGt1bml0ICp0ZXN0KQoreworCXN0cnVjdCBkZXZpY2VfZHJpdmVyICp0
ZXN0X2RyaXZlcjsKKwlzdHJ1Y3QgZGV2aWNlICp0ZXN0X2RldmljZTsKKwlzdHJ1Y3QgZHJp
dmVyX3Rlc3Rfc3RhdGUgKnRlc3Rfc3RhdGUgPSBrdW5pdF9remFsbG9jKHRlc3QsIHNpemVv
ZigqdGVzdF9zdGF0ZSksIEdGUF9LRVJORUwpOworCisJdGVzdC0+cHJpdiA9IHRlc3Rfc3Rh
dGU7CisJdGVzdF9kcml2ZXIgPSBrdW5pdF9kcml2ZXJfY3JlYXRlKHRlc3QsICJteV9kcml2
ZXIiKTsKKworCS8vIFRoaXMgY2FuIGZhaWwgd2l0aCBhbiBlcnJvciBwb2ludGVyLgorCUtV
TklUX0FTU0VSVF9OT1RfRVJSX09SX05VTEwodGVzdCwgdGVzdF9kcml2ZXIpOworCisJdGVz
dF9kcml2ZXItPnByb2JlID0gZHJpdmVyX3Byb2JlX2hvb2s7CisJdGVzdF9kcml2ZXItPnJl
bW92ZSA9IGRyaXZlcl9yZW1vdmVfaG9vazsKKworCXRlc3RfZGV2aWNlID0ga3VuaXRfZGV2
aWNlX3JlZ2lzdGVyX3dpdGhfZHJpdmVyKHRlc3QsICJteV9kZXZpY2UiLCB0ZXN0X2RyaXZl
cik7CisKKwkvLyBUaGlzIGNhbiBmYWlsIHdpdGggYW4gZXJyb3IgcG9pbnRlci4KKwlLVU5J
VF9BU1NFUlRfTk9UX0VSUl9PUl9OVUxMKHRlc3QsIHRlc3RfZGV2aWNlKTsKKworCS8vIE1h
a2Ugc3VyZSB0aGUgcHJvYmUgZnVuY3Rpb24gd2FzIGNhbGxlZC4KKwlLVU5JVF9BU1NFUlRf
VFJVRSh0ZXN0LCB0ZXN0X3N0YXRlLT5kcml2ZXJfZGV2aWNlX3Byb2JlZCk7CisKKwkvLyBB
ZGQgYW4gYWN0aW9uIHRvIHZlcmlmeSBjbGVhbnVwLgorCWRldm1fYWRkX2FjdGlvbih0ZXN0
X2RldmljZSwgdGVzdF9kZXZfYWN0aW9uLCAmdGVzdF9zdGF0ZS0+YWN0aW9uX3dhc19ydW4p
OworCisJS1VOSVRfRVhQRUNUX0VRKHRlc3QsIHRlc3Rfc3RhdGUtPmFjdGlvbl93YXNfcnVu
LCAwKTsKKworCWt1bml0X2RldmljZV91bnJlZ2lzdGVyKHRlc3QsIHRlc3RfZGV2aWNlKTsK
Kwl0ZXN0X2RldmljZSA9IE5VTEw7CisKKwkvLyBNYWtlIHN1cmUgdGhlIHJlbW92ZSBob29r
IHdhcyBjYWxsZWQuCisJS1VOSVRfQVNTRVJUX1RSVUUodGVzdCwgdGVzdF9zdGF0ZS0+ZHJp
dmVyX2RldmljZV9yZW1vdmVkKTsKKworCS8vIFdlJ3JlIGdvaW5nIHRvIHRlc3QgdGhpcyBh
Z2Fpbi4KKwl0ZXN0X3N0YXRlLT5kcml2ZXJfZGV2aWNlX3Byb2JlZCA9IGZhbHNlOworCisJ
Ly8gVGhlIGRyaXZlciBzaG91bGQgbm90IGF1dG9tYXRpY2FsbHkgYmUgZGVzdHJveWVkIGJ5
CisJLy8ga3VuaXRfZGV2aWNlX3VucmVnaXN0ZXIsIHNvIHdlIGNhbiByZS11c2UgaXQuCisJ
dGVzdF9kZXZpY2UgPSBrdW5pdF9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9kcml2ZXIodGVzdCwg
Im15X2RldmljZSIsIHRlc3RfZHJpdmVyKTsKKworCS8vIFRoaXMgY2FuIGZhaWwgd2l0aCBh
biBlcnJvciBwb2ludGVyLgorCUtVTklUX0FTU0VSVF9OT1RfRVJSX09SX05VTEwodGVzdCwg
dGVzdF9kZXZpY2UpOworCisJLy8gUHJvYmUgd2FzIGNhbGxlZCBhZ2Fpbi4KKwlLVU5JVF9B
U1NFUlRfVFJVRSh0ZXN0LCB0ZXN0X3N0YXRlLT5kcml2ZXJfZGV2aWNlX3Byb2JlZCk7CisK
KwkvLyBFdmVyeXRoaW5nIGlzIGF1dG9tYXRpY2FsbHkgZnJlZWQgaGVyZS4KK30KKworc3Rh
dGljIHN0cnVjdCBrdW5pdF9jYXNlIGt1bml0X2RldmljZV90ZXN0X2Nhc2VzW10gPSB7CisJ
S1VOSVRfQ0FTRShrdW5pdF9kZXZpY2VfdGVzdCksCisJS1VOSVRfQ0FTRShrdW5pdF9kZXZp
Y2VfY2xlYW51cF90ZXN0KSwKKwlLVU5JVF9DQVNFKGt1bml0X2RldmljZV9kcml2ZXJfdGVz
dCksCisJe30KK307CisKK3N0YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUga3VuaXRfZGV2aWNl
X3Rlc3Rfc3VpdGUgPSB7CisJLm5hbWUgPSAia3VuaXRfZGV2aWNlIiwKKwkudGVzdF9jYXNl
cyA9IGt1bml0X2RldmljZV90ZXN0X2Nhc2VzLAorfTsKKwogc3RhdGljIHN0cnVjdCBrdW5p
dF9zdWl0ZSBrdW5pdF9jdXJyZW50X3Rlc3Rfc3VpdGUgPSB7CiAJLm5hbWUgPSAia3VuaXRf
Y3VycmVudCIsCiAJLnRlc3RfY2FzZXMgPSBrdW5pdF9jdXJyZW50X3Rlc3RfY2FzZXMsCkBA
IC02OTcsNiArODI2LDYgQEAgc3RhdGljIHN0cnVjdCBrdW5pdF9zdWl0ZSBrdW5pdF9jdXJy
ZW50X3Rlc3Rfc3VpdGUgPSB7CiAKIGt1bml0X3Rlc3Rfc3VpdGVzKCZrdW5pdF90cnlfY2F0
Y2hfdGVzdF9zdWl0ZSwgJmt1bml0X3Jlc291cmNlX3Rlc3Rfc3VpdGUsCiAJCSAgJmt1bml0
X2xvZ190ZXN0X3N1aXRlLCAma3VuaXRfc3RhdHVzX3Rlc3Rfc3VpdGUsCi0JCSAgJmt1bml0
X2N1cnJlbnRfdGVzdF9zdWl0ZSk7CisJCSAgJmt1bml0X2N1cnJlbnRfdGVzdF9zdWl0ZSwg
Jmt1bml0X2RldmljZV90ZXN0X3N1aXRlKTsKIAogTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIp
OwpkaWZmIC0tZ2l0IGEvbGliL2t1bml0L3N0cmluZy1zdHJlYW0tdGVzdC5jIGIvbGliL2t1
bml0L3N0cmluZy1zdHJlYW0tdGVzdC5jCmluZGV4IDA2ODIyNzY2ZjI5YS4uMDNmYjUxMTgy
NmY3IDEwMDY0NAotLS0gYS9saWIva3VuaXQvc3RyaW5nLXN0cmVhbS10ZXN0LmMKKysrIGIv
bGliL2t1bml0L3N0cmluZy1zdHJlYW0tdGVzdC5jCkBAIC03Miw3ICs3Miw3IEBAIHN0YXRp
YyB2b2lkIHN0cmluZ19zdHJlYW1fdW5tYW5hZ2VkX2luaXRfdGVzdChzdHJ1Y3Qga3VuaXQg
KnRlc3QpCiAKIAlLVU5JVF9FWFBFQ1RfRVEodGVzdCwgc3RyZWFtLT5sZW5ndGgsIDApOwog
CUtVTklUX0VYUEVDVF9UUlVFKHRlc3QsIGxpc3RfZW1wdHkoJnN0cmVhbS0+ZnJhZ21lbnRz
KSk7Ci0JS1VOSVRfRVhQRUNUX0VRKHRlc3QsIHN0cmVhbS0+Z2ZwLCBHRlBfS0VSTkVMKTsK
KwlLVU5JVF9FWFBFQ1RfVFJVRSh0ZXN0LCAoc3RyZWFtLT5nZnAgPT0gR0ZQX0tFUk5FTCkp
OwogCUtVTklUX0VYUEVDVF9GQUxTRSh0ZXN0LCBzdHJlYW0tPmFwcGVuZF9uZXdsaW5lcyk7
CiAKIAlLVU5JVF9FWFBFQ1RfVFJVRSh0ZXN0LCBzdHJpbmdfc3RyZWFtX2lzX2VtcHR5KHN0
cmVhbSkpOwpkaWZmIC0tZ2l0IGEvbGliL2t1bml0L3N0cmluZy1zdHJlYW0uYyBiL2xpYi9r
dW5pdC9zdHJpbmctc3RyZWFtLmMKaW5kZXggYTZmMzYxNmMyMDQ4Li41NGY0ZmRjYmZhYzgg
MTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9zdHJpbmctc3RyZWFtLmMKKysrIGIvbGliL2t1bml0
L3N0cmluZy1zdHJlYW0uYwpAQCAtMTczLDcgKzE3Myw3IEBAIHZvaWQgc3RyaW5nX3N0cmVh
bV9kZXN0cm95KHN0cnVjdCBzdHJpbmdfc3RyZWFtICpzdHJlYW0pCiB7CiAJS1VOSVRfU1RB
VElDX1NUVUJfUkVESVJFQ1Qoc3RyaW5nX3N0cmVhbV9kZXN0cm95LCBzdHJlYW0pOwogCi0J
aWYgKCFzdHJlYW0pCisJaWYgKElTX0VSUl9PUl9OVUxMKHN0cmVhbSkpCiAJCXJldHVybjsK
IAogCXN0cmluZ19zdHJlYW1fY2xlYXIoc3RyZWFtKTsKZGlmZiAtLWdpdCBhL2xpYi9rdW5p
dC90ZXN0LmMgYi9saWIva3VuaXQvdGVzdC5jCmluZGV4IDdhY2ViMDdhMWFmOS4uZjk1ZDIw
OTNhMGFhIDEwMDY0NAotLS0gYS9saWIva3VuaXQvdGVzdC5jCisrKyBiL2xpYi9rdW5pdC90
ZXN0LmMKQEAgLTEzLDE1ICsxMywxOSBAQAogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgog
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZXBhcmFt
Lmg+CisjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KICNpbmNsdWRlIDxsaW51eC9wYW5pYy5o
PgogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2RlYnVnLmg+CiAjaW5jbHVkZSA8bGludXgvc2No
ZWQuaD4KIAogI2luY2x1ZGUgImRlYnVnZnMuaCIKKyNpbmNsdWRlICJkZXZpY2UtaW1wbC5o
IgogI2luY2x1ZGUgImhvb2tzLWltcGwuaCIKICNpbmNsdWRlICJzdHJpbmctc3RyZWFtLmgi
CiAjaW5jbHVkZSAidHJ5LWNhdGNoLWltcGwuaCIKIAorc3RhdGljIERFRklORV9NVVRFWChr
dW5pdF9ydW5fbG9jayk7CisKIC8qCiAgKiBIb29rIHRvIGZhaWwgdGhlIGN1cnJlbnQgdGVz
dCBhbmQgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZSB0byB0aGUgbG9nLgogICovCkBAIC02NjAs
NiArNjY0LDcgQEAgaW50IGt1bml0X3J1bl90ZXN0cyhzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1
aXRlKQogCQkJCXRlc3QucGFyYW1faW5kZXgrKzsKIAkJCQl0ZXN0LnN0YXR1cyA9IEtVTklU
X1NVQ0NFU1M7CiAJCQkJdGVzdC5zdGF0dXNfY29tbWVudFswXSA9ICdcMCc7CisJCQkJdGVz
dC5wcml2ID0gTlVMTDsKIAkJCX0KIAkJfQogCkBAIC02OTIsNiArNjk3LDkgQEAgc3RhdGlj
IHZvaWQga3VuaXRfaW5pdF9zdWl0ZShzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlKQogCWt1
bml0X2RlYnVnZnNfY3JlYXRlX3N1aXRlKHN1aXRlKTsKIAlzdWl0ZS0+c3RhdHVzX2NvbW1l
bnRbMF0gPSAnXDAnOwogCXN1aXRlLT5zdWl0ZV9pbml0X2VyciA9IDA7CisKKwlpZiAoc3Vp
dGUtPmxvZykKKwkJc3RyaW5nX3N0cmVhbV9jbGVhcihzdWl0ZS0+bG9nKTsKIH0KIAogYm9v
bCBrdW5pdF9lbmFibGVkKHZvaWQpCkBAIC03MTAsNiArNzE4LDExIEBAIGludCBfX2t1bml0
X3Rlc3Rfc3VpdGVzX2luaXQoc3RydWN0IGt1bml0X3N1aXRlICogY29uc3QgKiBjb25zdCBz
dWl0ZXMsIGludCBudW1fCiAKIAlrdW5pdF9zdWl0ZV9jb3VudGVyID0gMTsKIAorCS8qIFVz
ZSBtdXRleCBsb2NrIHRvIGd1YXJkIGFnYWluc3QgcnVubmluZyB0ZXN0cyBjb25jdXJyZW50
bHkuICovCisJaWYgKG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgma3VuaXRfcnVuX2xvY2sp
KSB7CisJCXByX2Vycigia3VuaXQ6IHRlc3QgaW50ZXJydXB0ZWRcbiIpOworCQlyZXR1cm4g
LUVJTlRSOworCX0KIAlzdGF0aWNfYnJhbmNoX2luYygma3VuaXRfcnVubmluZyk7CiAKIAlm
b3IgKGkgPSAwOyBpIDwgbnVtX3N1aXRlczsgaSsrKSB7CkBAIC03MTgsNiArNzMxLDcgQEAg
aW50IF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBjb25z
dCAqIGNvbnN0IHN1aXRlcywgaW50IG51bV8KIAl9CiAKIAlzdGF0aWNfYnJhbmNoX2RlYygm
a3VuaXRfcnVubmluZyk7CisJbXV0ZXhfdW5sb2NrKCZrdW5pdF9ydW5fbG9jayk7CiAJcmV0
dXJuIDA7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChfX2t1bml0X3Rlc3Rfc3VpdGVzX2luaXQp
OwpAQCAtNzQyLDI4ICs3NTYsNDAgQEAgRVhQT1JUX1NZTUJPTF9HUEwoX19rdW5pdF90ZXN0
X3N1aXRlc19leGl0KTsKICNpZmRlZiBDT05GSUdfTU9EVUxFUwogc3RhdGljIHZvaWQga3Vu
aXRfbW9kdWxlX2luaXQoc3RydWN0IG1vZHVsZSAqbW9kKQogewotCXN0cnVjdCBrdW5pdF9z
dWl0ZV9zZXQgc3VpdGVfc2V0ID0geworCXN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgc3VpdGVf
c2V0LCBmaWx0ZXJlZF9zZXQ7CisJc3RydWN0IGt1bml0X3N1aXRlX3NldCBub3JtYWxfc3Vp
dGVfc2V0ID0gewogCQltb2QtPmt1bml0X3N1aXRlcywgbW9kLT5rdW5pdF9zdWl0ZXMgKyBt
b2QtPm51bV9rdW5pdF9zdWl0ZXMsCiAJfTsKKwlzdHJ1Y3Qga3VuaXRfc3VpdGVfc2V0IGlu
aXRfc3VpdGVfc2V0ID0geworCQltb2QtPmt1bml0X2luaXRfc3VpdGVzLCBtb2QtPmt1bml0
X2luaXRfc3VpdGVzICsgbW9kLT5udW1fa3VuaXRfaW5pdF9zdWl0ZXMsCisJfTsKIAljb25z
dCBjaGFyICphY3Rpb24gPSBrdW5pdF9hY3Rpb24oKTsKIAlpbnQgZXJyID0gMDsKIAotCXN1
aXRlX3NldCA9IGt1bml0X2ZpbHRlcl9zdWl0ZXMoJnN1aXRlX3NldCwKKwlpZiAobW9kLT5u
dW1fa3VuaXRfaW5pdF9zdWl0ZXMgPiAwKQorCQlzdWl0ZV9zZXQgPSBrdW5pdF9tZXJnZV9z
dWl0ZV9zZXRzKGluaXRfc3VpdGVfc2V0LCBub3JtYWxfc3VpdGVfc2V0KTsKKwllbHNlCisJ
CXN1aXRlX3NldCA9IG5vcm1hbF9zdWl0ZV9zZXQ7CisKKwlmaWx0ZXJlZF9zZXQgPSBrdW5p
dF9maWx0ZXJfc3VpdGVzKCZzdWl0ZV9zZXQsCiAJCQkJCWt1bml0X2ZpbHRlcl9nbG9iKCkg
PzogIiouKiIsCiAJCQkJCWt1bml0X2ZpbHRlcigpLCBrdW5pdF9maWx0ZXJfYWN0aW9uKCks
CiAJCQkJCSZlcnIpOwogCWlmIChlcnIpCiAJCXByX2Vycigia3VuaXQgbW9kdWxlOiBlcnJv
ciBmaWx0ZXJpbmcgc3VpdGVzOiAlZFxuIiwgZXJyKTsKIAotCW1vZC0+a3VuaXRfc3VpdGVz
ID0gKHN0cnVjdCBrdW5pdF9zdWl0ZSAqKilzdWl0ZV9zZXQuc3RhcnQ7Ci0JbW9kLT5udW1f
a3VuaXRfc3VpdGVzID0gc3VpdGVfc2V0LmVuZCAtIHN1aXRlX3NldC5zdGFydDsKKwltb2Qt
Pmt1bml0X3N1aXRlcyA9IChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiopZmlsdGVyZWRfc2V0LnN0
YXJ0OworCW1vZC0+bnVtX2t1bml0X3N1aXRlcyA9IGZpbHRlcmVkX3NldC5lbmQgLSBmaWx0
ZXJlZF9zZXQuc3RhcnQ7CisKKwlpZiAobW9kLT5udW1fa3VuaXRfaW5pdF9zdWl0ZXMgPiAw
KQorCQlrZnJlZShzdWl0ZV9zZXQuc3RhcnQpOwogCiAJaWYgKCFhY3Rpb24pCi0JCWt1bml0
X2V4ZWNfcnVuX3Rlc3RzKCZzdWl0ZV9zZXQsIGZhbHNlKTsKKwkJa3VuaXRfZXhlY19ydW5f
dGVzdHMoJmZpbHRlcmVkX3NldCwgZmFsc2UpOwogCWVsc2UgaWYgKCFzdHJjbXAoYWN0aW9u
LCAibGlzdCIpKQotCQlrdW5pdF9leGVjX2xpc3RfdGVzdHMoJnN1aXRlX3NldCwgZmFsc2Up
OworCQlrdW5pdF9leGVjX2xpc3RfdGVzdHMoJmZpbHRlcmVkX3NldCwgZmFsc2UpOwogCWVs
c2UgaWYgKCFzdHJjbXAoYWN0aW9uLCAibGlzdF9hdHRyIikpCi0JCWt1bml0X2V4ZWNfbGlz
dF90ZXN0cygmc3VpdGVfc2V0LCB0cnVlKTsKKwkJa3VuaXRfZXhlY19saXN0X3Rlc3RzKCZm
aWx0ZXJlZF9zZXQsIHRydWUpOwogCWVsc2UKIAkJcHJfZXJyKCJrdW5pdDogdW5rbm93biBh
Y3Rpb24gJyVzJ1xuIiwgYWN0aW9uKTsKIH0KQEAgLTgxMCw2ICs4MzYsOCBAQCBzdGF0aWMg
c3RydWN0IG5vdGlmaWVyX2Jsb2NrIGt1bml0X21vZF9uYiA9IHsKIH07CiAjZW5kaWYKIAor
S1VOSVRfREVGSU5FX0FDVElPTl9XUkFQUEVSKGtmcmVlX2FjdGlvbl93cmFwcGVyLCBrZnJl
ZSwgY29uc3Qgdm9pZCAqKQorCiB2b2lkICprdW5pdF9rbWFsbG9jX2FycmF5KHN0cnVjdCBr
dW5pdCAqdGVzdCwgc2l6ZV90IG4sIHNpemVfdCBzaXplLCBnZnBfdCBnZnApCiB7CiAJdm9p
ZCAqZGF0YTsKQEAgLTgxOSw3ICs4NDcsNyBAQCB2b2lkICprdW5pdF9rbWFsbG9jX2FycmF5
KHN0cnVjdCBrdW5pdCAqdGVzdCwgc2l6ZV90IG4sIHNpemVfdCBzaXplLCBnZnBfdCBnZnAp
CiAJaWYgKCFkYXRhKQogCQlyZXR1cm4gTlVMTDsKIAotCWlmIChrdW5pdF9hZGRfYWN0aW9u
X29yX3Jlc2V0KHRlc3QsIChrdW5pdF9hY3Rpb25fdCAqKWtmcmVlLCBkYXRhKSAhPSAwKQor
CWlmIChrdW5pdF9hZGRfYWN0aW9uX29yX3Jlc2V0KHRlc3QsIGtmcmVlX2FjdGlvbl93cmFw
cGVyLCBkYXRhKSAhPSAwKQogCQlyZXR1cm4gTlVMTDsKIAogCXJldHVybiBkYXRhOwpAQCAt
ODMxLDcgKzg1OSw3IEBAIHZvaWQga3VuaXRfa2ZyZWUoc3RydWN0IGt1bml0ICp0ZXN0LCBj
b25zdCB2b2lkICpwdHIpCiAJaWYgKCFwdHIpCiAJCXJldHVybjsKIAotCWt1bml0X3JlbGVh
c2VfYWN0aW9uKHRlc3QsIChrdW5pdF9hY3Rpb25fdCAqKWtmcmVlLCAodm9pZCAqKXB0cik7
CisJa3VuaXRfcmVsZWFzZV9hY3Rpb24odGVzdCwga2ZyZWVfYWN0aW9uX3dyYXBwZXIsICh2
b2lkICopcHRyKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGt1bml0X2tmcmVlKTsKIApAQCAt
ODc2LDYgKzkwNCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGt1bml0X2luaXQodm9pZCkKIAlr
dW5pdF9pbnN0YWxsX2hvb2tzKCk7CiAKIAlrdW5pdF9kZWJ1Z2ZzX2luaXQoKTsKKworCWt1
bml0X2J1c19pbml0KCk7CiAjaWZkZWYgQ09ORklHX01PRFVMRVMKIAlyZXR1cm4gcmVnaXN0
ZXJfbW9kdWxlX25vdGlmaWVyKCZrdW5pdF9tb2RfbmIpOwogI2Vsc2UKZGlmZiAtLWdpdCBh
L2xpYi9vdmVyZmxvd19rdW5pdC5jIGIvbGliL292ZXJmbG93X2t1bml0LmMKaW5kZXggMzRk
YjBiM2FhNTAyLi5jNTI3ZjZiNzU3ODkgMTAwNjQ0Ci0tLSBhL2xpYi9vdmVyZmxvd19rdW5p
dC5jCisrKyBiL2xpYi9vdmVyZmxvd19rdW5pdC5jCkBAIC02LDYgKzYsNyBAQAogICovCiAj
ZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10CiAKKyNpbmNsdWRl
IDxrdW5pdC9kZXZpY2UuaD4KICNpbmNsdWRlIDxrdW5pdC90ZXN0Lmg+CiAjaW5jbHVkZSA8
bGludXgvZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CkBAIC02MTgsNyAr
NjE5LDcgQEAgc3RhdGljIHZvaWQgb3ZlcmZsb3dfYWxsb2NhdGlvbl90ZXN0KHN0cnVjdCBr
dW5pdCAqdGVzdCkKIH0gd2hpbGUgKDApCiAKIAkvKiBDcmVhdGUgZHVtbXkgZGV2aWNlIGZv
ciBkZXZtX2ttYWxsb2MoKS1mYW1pbHkgdGVzdHMuICovCi0JZGV2ID0gcm9vdF9kZXZpY2Vf
cmVnaXN0ZXIoZGV2aWNlX25hbWUpOworCWRldiA9IGt1bml0X2RldmljZV9yZWdpc3Rlcih0
ZXN0LCBkZXZpY2VfbmFtZSk7CiAJS1VOSVRfQVNTRVJUX0ZBTFNFX01TRyh0ZXN0LCBJU19F
UlIoZGV2KSwKIAkJCSAgICAgICAiQ2Fubm90IHJlZ2lzdGVyIHRlc3QgZGV2aWNlXG4iKTsK
IApAQCAtNjM0LDggKzYzNSw2IEBAIHN0YXRpYyB2b2lkIG92ZXJmbG93X2FsbG9jYXRpb25f
dGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJY2hlY2tfYWxsb2NhdGlvbl9vdmVyZmxvdyhk
ZXZtX2ttYWxsb2MpOwogCWNoZWNrX2FsbG9jYXRpb25fb3ZlcmZsb3coZGV2bV9remFsbG9j
KTsKIAotCWRldmljZV91bnJlZ2lzdGVyKGRldik7Ci0KIAlrdW5pdF9pbmZvKHRlc3QsICIl
ZCBhbGxvY2F0aW9uIG92ZXJmbG93IHRlc3RzIGZpbmlzaGVkXG4iLCBjb3VudCk7CiAjdW5k
ZWYgY2hlY2tfYWxsb2NhdGlvbl9vdmVyZmxvdwogfQpkaWZmIC0tZ2l0IGEvc291bmQvc29j
L3NvYy10b3BvbG9neS10ZXN0LmMgYi9zb3VuZC9zb2Mvc29jLXRvcG9sb2d5LXRlc3QuYwpp
bmRleCAyY2QzNTQwY2VjMDQuLjcwY2JjY2M0MmE0MiAxMDA2NDQKLS0tIGEvc291bmQvc29j
L3NvYy10b3BvbG9neS10ZXN0LmMKKysrIGIvc291bmQvc29jL3NvYy10b3BvbG9neS10ZXN0
LmMKQEAgLTksNiArOSw3IEBACiAjaW5jbHVkZSA8c291bmQvY29yZS5oPgogI2luY2x1ZGUg
PHNvdW5kL3NvYy5oPgogI2luY2x1ZGUgPHNvdW5kL3NvYy10b3BvbG9neS5oPgorI2luY2x1
ZGUgPGt1bml0L2RldmljZS5oPgogI2luY2x1ZGUgPGt1bml0L3Rlc3QuaD4KIAogLyogPT09
PT0gSEVMUEVSIEZVTkNUSU9OUyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0gKi8KQEAgLTIxLDI2ICsyMiwxOSBAQAogICovCiBzdGF0aWMg
c3RydWN0IGRldmljZSAqdGVzdF9kZXY7CiAKLXN0YXRpYyBzdHJ1Y3QgZGV2aWNlX2RyaXZl
ciB0ZXN0X2RydiA9IHsKLQkubmFtZSA9ICJzb3VuZC1zb2MtdG9wb2xvZ3ktdGVzdC1kcml2
ZXIiLAotfTsKLQogc3RhdGljIGludCBzbmRfc29jX3RwbGdfdGVzdF9pbml0KHN0cnVjdCBr
dW5pdCAqdGVzdCkKIHsKLQl0ZXN0X2RldiA9IHJvb3RfZGV2aWNlX3JlZ2lzdGVyKCJzb3Vu
ZC1zb2MtdG9wb2xvZ3ktdGVzdCIpOworCXRlc3RfZGV2ID0ga3VuaXRfZGV2aWNlX3JlZ2lz
dGVyKHRlc3QsICJzb3VuZC1zb2MtdG9wb2xvZ3ktdGVzdCIpOwogCXRlc3RfZGV2ID0gZ2V0
X2RldmljZSh0ZXN0X2Rldik7CiAJaWYgKCF0ZXN0X2RldikKIAkJcmV0dXJuIC1FTk9ERVY7
CiAKLQl0ZXN0X2Rldi0+ZHJpdmVyID0gJnRlc3RfZHJ2OwotCiAJcmV0dXJuIDA7CiB9CiAK
IHN0YXRpYyB2b2lkIHNuZF9zb2NfdHBsZ190ZXN0X2V4aXQoc3RydWN0IGt1bml0ICp0ZXN0
KQogewogCXB1dF9kZXZpY2UodGVzdF9kZXYpOwotCXJvb3RfZGV2aWNlX3VucmVnaXN0ZXIo
dGVzdF9kZXYpOwogfQogCiAvKgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9wYXJzZXIucHkgYi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0X3BhcnNlci5weQpp
bmRleCA3OWQ4ODMyYzg2MmEuLmNlMzRiZTE1YzkyOSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9rdW5pdC9rdW5pdF9wYXJzZXIucHkKKysrIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9wYXJzZXIucHkKQEAgLTQ1MCw3ICs0NTAsNyBAQCBkZWYgcGFyc2VfZGlhZ25vc3Rp
YyhsaW5lczogTGluZVN0cmVhbSkgLT4gTGlzdFtzdHJdOgogCUxvZyBvZiBkaWFnbm9zdGlj
IGxpbmVzCiAJIiIiCiAJbG9nID0gW10gICMgdHlwZTogTGlzdFtzdHJdCi0Jbm9uX2RpYWdu
b3N0aWNfbGluZXMgPSBbVEVTVF9SRVNVTFQsIFRFU1RfSEVBREVSLCBLVEFQX1NUQVJULCBU
QVBfU1RBUlRdCisJbm9uX2RpYWdub3N0aWNfbGluZXMgPSBbVEVTVF9SRVNVTFQsIFRFU1Rf
SEVBREVSLCBLVEFQX1NUQVJULCBUQVBfU1RBUlQsIFRFU1RfUExBTl0KIAl3aGlsZSBsaW5l
cyBhbmQgbm90IGFueShyZS5tYXRjaChsaW5lcy5wZWVrKCkpCiAJCQlmb3IgcmUgaW4gbm9u
X2RpYWdub3N0aWNfbGluZXMpOgogCQlsb2cuYXBwZW5kKGxpbmVzLnBvcCgpKQpAQCAtNzI2
LDYgKzcyNiw3IEBAIGRlZiBwYXJzZV90ZXN0KGxpbmVzOiBMaW5lU3RyZWFtLCBleHBlY3Rl
ZF9udW06IGludCwgbG9nOiBMaXN0W3N0cl0sIGlzX3N1YnRlc3Q6CiAJCSMgdGVzdCBwbGFu
CiAJCXRlc3QubmFtZSA9ICJtYWluIgogCQlrdGFwX2xpbmUgPSBwYXJzZV9rdGFwX2hlYWRl
cihsaW5lcywgdGVzdCkKKwkJdGVzdC5sb2cuZXh0ZW5kKHBhcnNlX2RpYWdub3N0aWMobGlu
ZXMpKQogCQlwYXJzZV90ZXN0X3BsYW4obGluZXMsIHRlc3QpCiAJCXBhcmVudF90ZXN0ID0g
VHJ1ZQogCWVsc2U6CkBAIC03MzcsNiArNzM4LDcgQEAgZGVmIHBhcnNlX3Rlc3QobGluZXM6
IExpbmVTdHJlYW0sIGV4cGVjdGVkX251bTogaW50LCBsb2c6IExpc3Rbc3RyXSwgaXNfc3Vi
dGVzdDoKIAkJaWYgcGFyZW50X3Rlc3Q6CiAJCQkjIElmIEtUQVAgdmVyc2lvbiBsaW5lIGFu
ZC9vciBzdWJ0ZXN0IGhlYWRlciBpcyBmb3VuZCwgYXR0ZW1wdAogCQkJIyB0byBwYXJzZSB0
ZXN0IHBsYW4gYW5kIHByaW50IHRlc3QgaGVhZGVyCisJCQl0ZXN0LmxvZy5leHRlbmQocGFy
c2VfZGlhZ25vc3RpYyhsaW5lcykpCiAJCQlwYXJzZV90ZXN0X3BsYW4obGluZXMsIHRlc3Qp
CiAJCQlwcmludF90ZXN0X2hlYWRlcih0ZXN0KQogCWV4cGVjdGVkX2NvdW50ID0gdGVzdC5l
eHBlY3RlZF9jb3VudApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF90
b29sX3Rlc3QucHkgYi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0X3Rvb2xfdGVzdC5weQpp
bmRleCBiMjhjMTUxMGJlMmUuLjJiZWI3MzI3ZTUzZiAxMDA3NTUKLS0tIGEvdG9vbHMvdGVz
dGluZy9rdW5pdC9rdW5pdF90b29sX3Rlc3QucHkKKysrIGIvdG9vbHMvdGVzdGluZy9rdW5p
dC9rdW5pdF90b29sX3Rlc3QucHkKQEAgLTMzMSw2ICszMzEsMjIgQEAgY2xhc3MgS1VuaXRQ
YXJzZXJUZXN0KHVuaXR0ZXN0LlRlc3RDYXNlKToKIAkJCWt1bml0X3BhcnNlci5wYXJzZV9y
dW5fdGVzdHMoZmlsZS5yZWFkbGluZXMoKSkKIAkJc2VsZi5wcmludF9tb2NrLmFzc2VydF9h
bnlfY2FsbChTdHJDb250YWlucygnc3VpdGUgKDEgc3VidGVzdCknKSkKIAorCWRlZiB0ZXN0
X3BhcnNlX2F0dHJpYnV0ZXMoc2VsZik6CisJCWt0YXBfbG9nID0gdGVzdF9kYXRhX3BhdGgo
J3Rlc3RfcGFyc2VfYXR0cmlidXRlcy5sb2cnKQorCQl3aXRoIG9wZW4oa3RhcF9sb2cpIGFz
IGZpbGU6CisJCQlyZXN1bHQgPSBrdW5pdF9wYXJzZXIucGFyc2VfcnVuX3Rlc3RzKGZpbGUu
cmVhZGxpbmVzKCkpCisKKwkJIyBUZXN0IHNob3VsZCBwYXNzIHdpdGggbm8gZXJyb3JzCisJ
CXNlbGYuYXNzZXJ0RXF1YWwocmVzdWx0LmNvdW50cywga3VuaXRfcGFyc2VyLlRlc3RDb3Vu
dHMocGFzc2VkPTEsIGVycm9ycz0wKSkKKwkJc2VsZi5hc3NlcnRFcXVhbChrdW5pdF9wYXJz
ZXIuVGVzdFN0YXR1cy5TVUNDRVNTLCByZXN1bHQuc3RhdHVzKQorCisJCSMgRW5zdXJlIHN1
aXRlIGhlYWRlciBpcyBwYXJzZWQgY29ycmVjdGx5CisJCXNlbGYucHJpbnRfbW9jay5hc3Nl
cnRfYW55X2NhbGwoU3RyQ29udGFpbnMoJ3N1aXRlICgxIHN1YnRlc3QpJykpCisKKwkJIyBF
bnN1cmUgYXR0cmlidXRlcyBpbiBjb3JyZWN0IHRlc3QgbG9nCisJCXNlbGYuYXNzZXJ0Q29u
dGFpbnMoJyMgbW9kdWxlOiBleGFtcGxlJywgcmVzdWx0LnN1YnRlc3RzWzBdLmxvZykKKwkJ
c2VsZi5hc3NlcnRDb250YWlucygnIyB0ZXN0LnNwZWVkOiBzbG93JywgcmVzdWx0LnN1YnRl
c3RzWzBdLnN1YnRlc3RzWzBdLmxvZykKKwogCWRlZiB0ZXN0X3Nob3dfdGVzdF9vdXRwdXRf
b25fZmFpbHVyZShzZWxmKToKIAkJb3V0cHV0ID0gIiIiCiAJCUtUQVAgdmVyc2lvbiAxCmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0L3Rlc3RfZGF0YS90ZXN0X3BhcnNlX2F0
dHJpYnV0ZXMubG9nIGIvdG9vbHMvdGVzdGluZy9rdW5pdC90ZXN0X2RhdGEvdGVzdF9wYXJz
ZV9hdHRyaWJ1dGVzLmxvZwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAw
MDAuLjFhMTNjMzcxZmU5ZAotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3Vu
aXQvdGVzdF9kYXRhL3Rlc3RfcGFyc2VfYXR0cmlidXRlcy5sb2cKQEAgLTAsMCArMSw5IEBA
CitLVEFQIHZlcnNpb24gMQorMS4uMQorICBLVEFQIHZlcnNpb24gMQorICAjIFN1YnRlc3Q6
IHN1aXRlCisgICMgbW9kdWxlOiBleGFtcGxlCisgIDEuLjEKKyAgIyB0ZXN0LnNwZWVkOiBz
bG93CisgIG9rIDEgdGVzdAorb2sgMSBzdWl0ZQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZp
bGUK

--------------iq8LG0chExFtyjSpGrBvnQOH--

