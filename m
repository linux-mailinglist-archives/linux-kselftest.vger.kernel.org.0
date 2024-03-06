Return-Path: <linux-kselftest+bounces-6030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933F8744CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28681B20A07
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA21CAA1;
	Wed,  6 Mar 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8Tq1lsZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5431AAA5
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769294; cv=none; b=cDrvRuvrJFITYxfXLH6nw+Vv4nLqbBv9Vof+FaJjhf3gitiEf3okMr5UUO8iCqnY/MrGPJEVzCLvGPZx3raW83zkgFYP3OioZlwfWwLk1yRZHZpNS7ltqCA/nieP8vWem4DfjEdd0ji9WBj4P+xF8z+10TXdl6hLbboqXwtwXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769294; c=relaxed/simple;
	bh=P70jv25G6urN60VzEF22tJxWKSvpGtY25H4SB8nJpL4=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=E2iUwU9DB0q88emvC+S8xNUE2pP5kQcWjQ6t24+UilmETS85DvtKRze11Y4RAH67jDlQss8jZvgScEWZf+sMSXyB5FZRKp2wZajzfhCmOZsvG5cCBkL+3wS503n+NuvbV5qd4f5X5CAyLDHo9Sz//dAQrArkmT9gs4PXDrcqc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8Tq1lsZ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365b5050622so292175ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Mar 2024 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709769285; x=1710374085; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4hVsE3AmtVoTBRqGhaa1+ab0XtX57b1bG37fIJD2Sd4=;
        b=a8Tq1lsZxG/35ikJ9tzKl5IHYe5rvxdBfVURaEO06HJh0wyQprIv04OEQu40lJheZ6
         jzw+QlNJpro1Ea21AhIfLFKGOf1ERyIVxE+Ys3rNmD6bcLm5G92sCdD2XLCBh4yIFboo
         VPnjy8upHdzqJwMtsIrQ/2nVCnT3W2OvAQYio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769285; x=1710374085;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hVsE3AmtVoTBRqGhaa1+ab0XtX57b1bG37fIJD2Sd4=;
        b=RhYefOdFjSly9Ek3cgsYKHZaUperGkZhZ9OVlEHHG1jpfAO3fY789zDmY+Mpw8gjHt
         qFDE+8rYJkQ7UfES60ywc48xcUGSYuaNQAGqgH7NiA9W7UsRGozszfhMgRULCl/Jbd1I
         rN7qiwm7hoWu164deUzyjHrtCgbsqxjz3hIDQHJusLIlgaXmzu3YielUghokbLDxoWgq
         DP7BE8Gq0bOOXKQ6q6JDmZ0zl0ExDRq1JptW2V6s4Pm1q3lcvvW71LFFrzfXT9+bsfVK
         g/tkE0lhp0wTDeH9e7mO4XSzcE3dEHHOsQd8nR7DWTBSefdHLOBW40IP397yMIw0HhRT
         WGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVu40MZMmT3ui83gt5ODElSTkKQMAd6bzpK9YvqNgrB2kAWUfz2nYMZh3f48PstzQwJJBxo8aKKs5T2oscBMAR7rjmi/TtVubL2oHpOZ/Us
X-Gm-Message-State: AOJu0YzEWLdNyKRl9QD2Ewj83+4ZdkTPvZFObZRGKZ1VEfIQirgOvPUB
	/BGwRSe9S+ec2sAaOY/6GFXJTcto3SFzcsXRKPDK2H5x9MP40tO815H7QaPVMdU=
X-Google-Smtp-Source: AGHT+IH5xQ1XyKLCZIVvEhOhDlAPH4jibXcSiVrgauurrjSCP6lm5OL8xAXIaSO8A5FQC1VJTLLKKQ==
X-Received: by 2002:a6b:dd11:0:b0:7c8:718b:cff5 with SMTP id f17-20020a6bdd11000000b007c8718bcff5mr629428ioc.2.1709769285114;
        Wed, 06 Mar 2024 15:54:45 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n3-20020a02a903000000b00474895385c0sm3676311jam.109.2024.03.06.15.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:54:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------E7QNSKNSmRgns5vdBSp8FJ3q"
Message-ID: <fc9ccbf3-6b7d-46d3-a8da-54d5dc78a81c@linuxfoundation.org>
Date: Wed, 6 Mar 2024 16:54:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest next update for Linux 6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7QNSKNSmRgns5vdBSp8FJ3q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for Linux 6.9-rc1.

This kselftest next update for Linux 6.9-rc1 consists of:
     
     -- livepatch restructuring to move the module out of lib to be
        built as a out-of-tree modules during kselftest build. This
        change makes it easier change, debug and rebuild the tests by
        running make on the selftests/livepatch directory, which is not
        currently possible since the modules on lib/livepatch are build
        and installed using the main makefile modules target.
     
     -- livepatch restructuring fixes for problems found by kernel test
        robot. The change skips the test if kernel-devel isn't installed
        (default value of KDIR), or if KDIR variable passed doesn't exists.
     
     -- resctrl test restructuring and new non-contiguous CBMs CAT test
     
     -- new ktap_helpers to print diagnostic messages, pass/fail tests
        based on exit code, abort test, and finish the test.
     
     -- a new test verify power supply properties.
     
     -- a new ftrace to exercise function tracer across cpu hotplug.
     
     -- timeout increase for mqueue test to allow the test to run on
        i3.metal AWS instances.
     
     -- minor spelling corrections in several tests.
     
     -- missing gitignore files and changes to existing gitignore files.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.9-rc1

for you to fetch changes up to 5d94da7ff00ef45737a64d947e7ff45aca972782:

   kselftest: Add basic test for probing the rust sample modules (2024-03-04 13:13:04 -0700)

----------------------------------------------------------------
linux_kselftest-next-6.9-rc1

This kselftest next update for Linux 6.9-rc1 consists of:

-- livepatch restructuring to move the module out of lib to be
    built as a out-of-tree modules during kselftest build. This
    change makes it easier change, debug and rebuild the tests by
    running make on the selftests/livepatch directory, which is not
    currently possible since the modules on lib/livepatch are build
    and installed using the main makefile modules target.

-- livepatch restructuring fixes for problems found by kernel test
    robot. The change skips the test if kernel-devel isn't installed
    (default value of KDIR), or if KDIR variable passed doesn't exists.

-- resctrl test restructuring and new non-contiguous CBMs CAT test

-- new ktap_helpers to print diagnostic messages, pass/fail tests
    based on exit code, abort test, and finish the test.

-- a new test verify power supply properties.

-- a new ftrace to exercise function tracer across cpu hotplug.

-- timeout increase for mqueue test to allow the test to run on
    i3.metal AWS instances.

-- minor spelling corrections in several tests.

-- missing gitignore files and changes to existing gitignore files.

----------------------------------------------------------------
Ali Zahraee (1):
       selftests: ftrace: fix typo in test description

Colin Ian King (1):
       selftests: sched: Fix spelling mistake "hiearchy" -> "hierarchy"

Ilpo Järvinen (30):
       selftests/resctrl: Convert perror() to ksft_perror() or ksft_print_msg()
       selftests/resctrl: Return -1 instead of errno on error
       selftests/resctrl: Don't use ctrlc_handler() outside signal handling
       selftests/resctrl: Change function comments to say < 0 on error
       selftests/resctrl: Split fill_buf to allow tests finer-grained control
       selftests/resctrl: Refactor fill_buf functions
       selftests/resctrl: Refactor get_cbm_mask() and rename to get_full_cbm()
       selftests/resctrl: Mark get_cache_size() cache_type const
       selftests/resctrl: Create cache_portion_size() helper
       selftests/resctrl: Exclude shareable bits from schemata in CAT test
       selftests/resctrl: Split measure_cache_vals()
       selftests/resctrl: Split show_cache_info() to test specific and generic parts
       selftests/resctrl: Remove unnecessary __u64 -> unsigned long conversion
       selftests/resctrl: Remove nested calls in perf event handling
       selftests/resctrl: Consolidate naming of perf event related things
       selftests/resctrl: Improve perf init
       selftests/resctrl: Convert perf related globals to locals
       selftests/resctrl: Move cat_val() to cat_test.c and rename to cat_test()
       selftests/resctrl: Open perf fd before start & add error handling
       selftests/resctrl: Replace file write with volatile variable
       selftests/resctrl: Read in less obvious order to defeat prefetch optimizations
       selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test
       selftests/resctrl: Restore the CPU affinity after CAT test
       selftests/resctrl: Create struct for input parameters
       selftests/resctrl: Introduce generalized test framework
       selftests/resctrl: Pass write_schemata() resource instead of test name
       selftests/resctrl: Add helper to convert L2/3 to integer
       selftests/resctrl: Rename resource ID to domain ID
       selftests/resctrl: Get domain id from cache id
       selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Javier Carrasco (3):
       selftests: uevent: add missing gitignore
       selftests: thermal: intel: power_floor: add missing gitignore
       selftests: thermal: intel: workload_hint: add missing gitignore

Kousik Sanagavarapu (1):
       selftest/ftrace: fix typo in ftracetest script

Laura Nao (2):
       selftests: Move KTAP bash helpers to selftests common folder
       kselftest: Add basic test for probing the rust sample modules

Maciej Wieczor-Retman (4):
       selftests/resctrl: Add a helper for the non-contiguous test
       selftests/resctrl: Split validate_resctrl_feature_request()
       selftests/resctrl: Add resource_info_file_exists()
       selftests/resctrl: Add non-contiguous CBMs CAT test

Marcos Paulo de Souza (6):
       kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
       livepatch: Move tests from lib/livepatch to selftests/livepatch
       selftests: livepatch: Test livepatching a heavily called syscall
       selftests: livepatch: Add initial .gitignore
       selftests: livepatch: Avoid running the tests if kernel-devel is missing
       selftests: lib.mk: Do not process TEST_GEN_MODS_DIR

Mark Brown (1):
       selftests: fuxex: Report a unique test name per run of futex_requeue_pi

Naveen N Rao (1):
       selftests/ftrace: Add test to exercize function tracer across cpu hotplug

Nícolas F. R. A. Prado (5):
       selftests: ktap_helpers: Add helper to print diagnostic messages
       selftests: ktap_helpers: Add helper to pass/fail test based on exit code
       selftests: ktap_helpers: Add a helper to abort the test
       selftests: ktap_helpers: Add a helper to finish the test
       selftests: Add test to verify power supply properties

SeongJae Park (1):
       selftests/mqueue: Set timeout to 180 seconds

Vincenzo Mezzela (1):
       selftest: ftrace: fix minor typo in log

  Documentation/dev-tools/kselftest.rst              |   4 +
  MAINTAINERS                                        |   3 +-
  arch/s390/configs/debug_defconfig                  |   1 -
  arch/s390/configs/defconfig                        |   1 -
  lib/Kconfig.debug                                  |  22 --
  lib/Makefile                                       |   2 -
  lib/livepatch/Makefile                             |  14 -
  tools/testing/selftests/Makefile                   |   3 +
  tools/testing/selftests/dt/Makefile                |   2 +-
  .../testing/selftests/dt/test_unprobed_devices.sh  |   6 +-
  tools/testing/selftests/ftrace/ftracetest          |   2 +-
  .../ftrace/test.d/00basic/test_ownership.tc        |   2 +-
  .../selftests/ftrace/test.d/ftrace/func_hotplug.tc |  42 ++
  .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   2 +-
  .../selftests/futex/functional/futex_requeue_pi.c  |  13 +-
  .../selftests/{dt => kselftest}/ktap_helpers.sh    |  45 ++-
  tools/testing/selftests/lib.mk                     |  23 +-
  tools/testing/selftests/livepatch/.gitignore       |   1 +
  tools/testing/selftests/livepatch/Makefile         |   5 +-
  tools/testing/selftests/livepatch/README           |  25 +-
  tools/testing/selftests/livepatch/config           |   1 -
  tools/testing/selftests/livepatch/functions.sh     |  47 ++-
  .../testing/selftests/livepatch/test-callbacks.sh  |  50 +--
  tools/testing/selftests/livepatch/test-ftrace.sh   |   6 +-
  .../testing/selftests/livepatch/test-livepatch.sh  |  10 +-
  .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
  tools/testing/selftests/livepatch/test-state.sh    |  18 +-
  tools/testing/selftests/livepatch/test-syscall.sh  |  53 +++
  tools/testing/selftests/livepatch/test-sysfs.sh    |   6 +-
  .../selftests/livepatch/test_klp-call_getpid.c     |  44 +++
  .../selftests/livepatch/test_modules/Makefile      |  26 ++
  .../test_modules}/test_klp_atomic_replace.c        |   0
  .../test_modules}/test_klp_callbacks_busy.c        |   0
  .../test_modules}/test_klp_callbacks_demo.c        |   0
  .../test_modules}/test_klp_callbacks_demo2.c       |   0
  .../test_modules}/test_klp_callbacks_mod.c         |   0
  .../livepatch/test_modules}/test_klp_livepatch.c   |   0
  .../livepatch/test_modules}/test_klp_shadow_vars.c |   0
  .../livepatch/test_modules}/test_klp_state.c       |   0
  .../livepatch/test_modules}/test_klp_state2.c      |   0
  .../livepatch/test_modules}/test_klp_state3.c      |   0
  .../livepatch/test_modules/test_klp_syscall.c      | 116 ++++++
  tools/testing/selftests/mqueue/setting             |   1 +
  tools/testing/selftests/power_supply/Makefile      |   4 +
  tools/testing/selftests/power_supply/helpers.sh    | 178 +++++++++
  .../power_supply/test_power_supply_properties.sh   | 114 ++++++
  tools/testing/selftests/resctrl/cache.c            | 287 ++++----------
  tools/testing/selftests/resctrl/cat_test.c         | 421 +++++++++++++++------
  tools/testing/selftests/resctrl/cmt_test.c         |  80 +++-
  tools/testing/selftests/resctrl/fill_buf.c         | 132 +++----
  tools/testing/selftests/resctrl/mba_test.c         |  30 +-
  tools/testing/selftests/resctrl/mbm_test.c         |  34 +-
  tools/testing/selftests/resctrl/resctrl.h          | 145 +++++--
  tools/testing/selftests/resctrl/resctrl_tests.c    | 207 +++++-----
  tools/testing/selftests/resctrl/resctrl_val.c      | 138 ++++---
  tools/testing/selftests/resctrl/resctrlfs.c        | 405 ++++++++++++++------
  tools/testing/selftests/rust/Makefile              |   4 +
  tools/testing/selftests/rust/config                |   5 +
  tools/testing/selftests/rust/test_probe_samples.sh |  41 ++
  tools/testing/selftests/sched/cs_prctl_test.c      |   2 +-
  .../selftests/thermal/intel/power_floor/.gitignore |   1 +
  .../thermal/intel/workload_hint/.gitignore         |   1 +
  tools/testing/selftests/uevent/.gitignore          |   1 +
  63 files changed, 1945 insertions(+), 883 deletions(-)
  delete mode 100644 lib/livepatch/Makefile
  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
  rename tools/testing/selftests/{dt => kselftest}/ktap_helpers.sh (66%)
  create mode 100644 tools/testing/selftests/livepatch/.gitignore
  create mode 100755 tools/testing/selftests/livepatch/test-syscall.sh
  create mode 100644 tools/testing/selftests/livepatch/test_klp-call_getpid.c
  create mode 100644 tools/testing/selftests/livepatch/test_modules/Makefile
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_atomic_replace.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_busy.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo2.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_mod.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_livepatch.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_shadow_vars.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state2.c (100%)
  rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state3.c (100%)
  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
  create mode 100644 tools/testing/selftests/mqueue/setting
  create mode 100644 tools/testing/selftests/power_supply/Makefile
  create mode 100644 tools/testing/selftests/power_supply/helpers.sh
  create mode 100755 tools/testing/selftests/power_supply/test_power_supply_properties.sh
  create mode 100644 tools/testing/selftests/rust/Makefile
  create mode 100644 tools/testing/selftests/rust/config
  create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
  create mode 100644 tools/testing/selftests/thermal/intel/power_floor/.gitignore
  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/.gitignore
  create mode 100644 tools/testing/selftests/uevent/.gitignore
----------------------------------------------------------------
--------------E7QNSKNSmRgns5vdBSp8FJ3q
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.9-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.9-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5yc3QgYi9E
b2N1bWVudGF0aW9uL2Rldi10b29scy9rc2VsZnRlc3QucnN0CmluZGV4IGFiMzc2YjMxNmMz
Ni4uN2YzNTgyYTY3MzE4IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
c2VsZnRlc3QucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5y
c3QKQEAgLTI0NSw2ICsyNDUsMTAgQEAgQ29udHJpYnV0aW5nIG5ldyB0ZXN0cyAoZGV0YWls
cykKICAgIFRFU1RfUFJPR1MsIFRFU1RfR0VOX1BST0dTIG1lYW4gaXQgaXMgdGhlIGV4ZWN1
dGFibGUgdGVzdGVkIGJ5CiAgICBkZWZhdWx0LgogCisgICBURVNUX0dFTl9NT0RTX0RJUiBz
aG91bGQgYmUgdXNlZCBieSB0ZXN0cyB0aGF0IHJlcXVpcmUgbW9kdWxlcyB0byBiZSBidWls
dAorICAgYmVmb3JlIHRoZSB0ZXN0IHN0YXJ0cy4gVGhlIHZhcmlhYmxlIHdpbGwgY29udGFp
biB0aGUgbmFtZSBvZiB0aGUgZGlyZWN0b3J5CisgICBjb250YWluaW5nIHRoZSBtb2R1bGVz
LgorCiAgICBURVNUX0NVU1RPTV9QUk9HUyBzaG91bGQgYmUgdXNlZCBieSB0ZXN0cyB0aGF0
IHJlcXVpcmUgY3VzdG9tIGJ1aWxkCiAgICBydWxlcyBhbmQgcHJldmVudCBjb21tb24gYnVp
bGQgcnVsZSB1c2UuCiAKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMK
aW5kZXggOGQxMDUyZmE2YTY5Li40ZWRhMjJlYzc0ZGQgMTAwNjQ0Ci0tLSBhL01BSU5UQUlO
RVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMjUxMCw3ICsxMjUxMCw2IEBAIEY6CWFyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9saXZlcGF0Y2guaAogRjoJaW5jbHVkZS9saW51eC9saXZl
cGF0Y2guaAogRjoJa2VybmVsL2xpdmVwYXRjaC8KIEY6CWtlcm5lbC9tb2R1bGUvbGl2ZXBh
dGNoLmMKLUY6CWxpYi9saXZlcGF0Y2gvCiBGOglzYW1wbGVzL2xpdmVwYXRjaC8KIEY6CXRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC8KIApAQCAtMTc1MjUsNiArMTc1MjQs
NyBAQCBGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5
LwogRjoJZHJpdmVycy9wb3dlci9zdXBwbHkvCiBGOglpbmNsdWRlL2xpbnV4L3Bvd2VyLwog
RjoJaW5jbHVkZS9saW51eC9wb3dlcl9zdXBwbHkuaAorRjoJdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcG93ZXJfc3VwcGx5LwogCiBQT1dFUk5WIE9QRVJBVE9SIFBBTkVMIExDRCBESVNQ
TEFZIERSSVZFUgogTToJU3VyYWogSml0aW5kYXIgU2luZ2ggPHNqaXRpbmRhcnNpbmdoQGdt
YWlsLmNvbT4KQEAgLTE5MDk1LDYgKzE5MDk1LDcgQEAgRjoJRG9jdW1lbnRhdGlvbi9ydXN0
LwogRjoJcnVzdC8KIEY6CXNhbXBsZXMvcnVzdC8KIEY6CXNjcmlwdHMvKnJ1c3QqCitGOgl0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydXN0LwogSzoJXGIoP2k6cnVzdClcYgogCiBSWFJQ
QyBTT0NLRVRTIChBRl9SWFJQQykKZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9jb25maWdzL2Rl
YnVnX2RlZmNvbmZpZyBiL2FyY2gvczM5MC9jb25maWdzL2RlYnVnX2RlZmNvbmZpZwppbmRl
eCBjYWUyZGQzNGZiYjQuLmY5YzQ0ZDM5MjEyNSAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL2Nv
bmZpZ3MvZGVidWdfZGVmY29uZmlnCisrKyBiL2FyY2gvczM5MC9jb25maWdzL2RlYnVnX2Rl
ZmNvbmZpZwpAQCAtODg2LDQgKzg4NiwzIEBAIENPTkZJR19BVE9NSUM2NF9TRUxGVEVTVD15
CiBDT05GSUdfU1RSSU5HX1NFTEZURVNUPXkKIENPTkZJR19URVNUX0JJVE9QUz1tCiBDT05G
SUdfVEVTVF9CUEY9bQotQ09ORklHX1RFU1RfTElWRVBBVENIPW0KZGlmZiAtLWdpdCBhL2Fy
Y2gvczM5MC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvczM5MC9jb25maWdzL2RlZmNvbmZp
ZwppbmRleCA0MmI5ODg4NzNlNTQuLmVmNzg3MzRiMjM1YyAxMDA2NDQKLS0tIGEvYXJjaC9z
MzkwL2NvbmZpZ3MvZGVmY29uZmlnCisrKyBiL2FyY2gvczM5MC9jb25maWdzL2RlZmNvbmZp
ZwpAQCAtODE1LDQgKzgxNSwzIEBAIENPTkZJR19LUFJPQkVTX1NBTklUWV9URVNUPW0KIENP
TkZJR19QRVJDUFVfVEVTVD1tCiBDT05GSUdfQVRPTUlDNjRfU0VMRlRFU1Q9eQogQ09ORklH
X1RFU1RfQlBGPW0KLUNPTkZJR19URVNUX0xJVkVQQVRDSD1tCmRpZmYgLS1naXQgYS9saWIv
S2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRlYnVnCmluZGV4IDk3NWEwN2Y5ZjFjYy4u
Yzk1ZDUyODUzYmY5IDEwMDY0NAotLS0gYS9saWIvS2NvbmZpZy5kZWJ1ZworKysgYi9saWIv
S2NvbmZpZy5kZWJ1ZwpAQCAtMjg1NywyOCArMjg1Nyw2IEBAIGNvbmZpZyBURVNUX01FTUNB
VF9QCiAKIAkgIElmIHVuc3VyZSwgc2F5IE4uCiAKLWNvbmZpZyBURVNUX0xJVkVQQVRDSAot
CXRyaXN0YXRlICJUZXN0IGxpdmVwYXRjaGluZyIKLQlkZWZhdWx0IG4KLQlkZXBlbmRzIG9u
IERZTkFNSUNfREVCVUcKLQlkZXBlbmRzIG9uIExJVkVQQVRDSAotCWRlcGVuZHMgb24gbQot
CWhlbHAKLQkgIFRlc3Qga2VybmVsIGxpdmVwYXRjaGluZyBmZWF0dXJlcyBmb3IgY29ycmVj
dG5lc3MuICBUaGUgdGVzdHMgd2lsbAotCSAgbG9hZCB0ZXN0IG1vZHVsZXMgdGhhdCB3aWxs
IGJlIGxpdmVwYXRjaGVkIGluIHZhcmlvdXMgc2NlbmFyaW9zLgotCi0JICBUbyBydW4gYWxs
IHRoZSBsaXZlcGF0Y2hpbmcgdGVzdHM6Ci0KLQkgIG1ha2UgLUMgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMgVEFSR0VUUz1saXZlcGF0Y2ggcnVuX3Rlc3RzCi0KLQkgIEFsdGVybmF0aXZl
bHksIGluZGl2aWR1YWwgdGVzdHMgbWF5IGJlIGludm9rZWQ6Ci0KLQkgIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0LWNhbGxiYWNrcy5zaAotCSAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3QtbGl2ZXBhdGNoLnNoCi0JICB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zaGFkb3ctdmFycy5zaAotCi0JICBJ
ZiB1bnN1cmUsIHNheSBOLgotCiBjb25maWcgVEVTVF9PQkpBR0cKIAl0cmlzdGF0ZSAiUGVy
Zm9ybSBzZWxmdGVzdCBvbiBvYmplY3QgYWdncmVyYXRpb24gbWFuYWdlciIKIAlkZWZhdWx0
IG4KZGlmZiAtLWdpdCBhL2xpYi9NYWtlZmlsZSBiL2xpYi9NYWtlZmlsZQppbmRleCA2YjA5
NzMxZDhlNjEuLjk1ZWQ1N2YzNzdmZCAxMDA2NDQKLS0tIGEvbGliL01ha2VmaWxlCisrKyBi
L2xpYi9NYWtlZmlsZQpAQCAtMTM0LDggKzEzNCw2IEBAIGVuZGlmCiBvYmotJChDT05GSUdf
VEVTVF9GUFUpICs9IHRlc3RfZnB1Lm8KIENGTEFHU190ZXN0X2ZwdS5vICs9ICQoRlBVX0NG
TEFHUykKIAotb2JqLSQoQ09ORklHX1RFU1RfTElWRVBBVENIKSArPSBsaXZlcGF0Y2gvCi0K
ICMgU29tZSBLVW5pdCBmaWxlcyAoaG9va3MubykgbmVlZCB0byBiZSBidWlsdC1pbiBldmVu
IHdoZW4gS1VuaXQgaXMgYSBtb2R1bGUsCiAjIHNvIHdlIGNhbid0IGp1c3QgdXNlIG9iai0k
KENPTkZJR19LVU5JVCkuCiBpZmRlZiBDT05GSUdfS1VOSVQKZGlmZiAtLWdpdCBhL2xpYi9s
aXZlcGF0Y2gvTWFrZWZpbGUgYi9saWIvbGl2ZXBhdGNoL01ha2VmaWxlCmRlbGV0ZWQgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCBkY2M5MTJiMzQ3OGYuLjAwMDAwMDAwMDAwMAotLS0gYS9s
aWIvbGl2ZXBhdGNoL01ha2VmaWxlCisrKyAvZGV2L251bGwKQEAgLTEsMTQgKzAsMCBAQAot
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAotIwotIyBNYWtlZmlsZSBmb3Ig
bGl2ZXBhdGNoIHRlc3QgY29kZS4KLQotb2JqLSQoQ09ORklHX1RFU1RfTElWRVBBVENIKSAr
PSB0ZXN0X2tscF9hdG9taWNfcmVwbGFjZS5vIFwKLQkJCQl0ZXN0X2tscF9jYWxsYmFja3Nf
ZGVtby5vIFwKLQkJCQl0ZXN0X2tscF9jYWxsYmFja3NfZGVtbzIubyBcCi0JCQkJdGVzdF9r
bHBfY2FsbGJhY2tzX2J1c3kubyBcCi0JCQkJdGVzdF9rbHBfY2FsbGJhY2tzX21vZC5vIFwK
LQkJCQl0ZXN0X2tscF9saXZlcGF0Y2gubyBcCi0JCQkJdGVzdF9rbHBfc2hhZG93X3ZhcnMu
byBcCi0JCQkJdGVzdF9rbHBfc3RhdGUubyBcCi0JCQkJdGVzdF9rbHBfc3RhdGUyLm8gXAot
CQkJCXRlc3Rfa2xwX3N0YXRlMy5vCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCmluZGV4
IDE1YjZhMTExYzNiZS4uY2Q5YWU1NzZiZmRlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9NYWtlZmlsZQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtl
ZmlsZQpAQCAtNjcsNiArNjcsNyBAQCBUQVJHRVRTICs9IG5zZnMKIFRBUkdFVFMgKz0gcGVy
Zl9ldmVudHMKIFRBUkdFVFMgKz0gcGlkZmQKIFRBUkdFVFMgKz0gcGlkX25hbWVzcGFjZQor
VEFSR0VUUyArPSBwb3dlcl9zdXBwbHkKIFRBUkdFVFMgKz0gcG93ZXJwYwogVEFSR0VUUyAr
PSBwcmN0bAogVEFSR0VUUyArPSBwcm9jCkBAIC03OCw2ICs3OSw3IEBAIFRBUkdFVFMgKz0g
cmlzY3YKIFRBUkdFVFMgKz0gcmxpbWl0cwogVEFSR0VUUyArPSByc2VxCiBUQVJHRVRTICs9
IHJ0YworVEFSR0VUUyArPSBydXN0CiBUQVJHRVRTICs9IHNlY2NvbXAKIFRBUkdFVFMgKz0g
c2d4CiBUQVJHRVRTICs9IHNpZ2FsdHN0YWNrCkBAIC0yMzYsNiArMjM4LDcgQEAgaWZkZWYg
SU5TVEFMTF9QQVRICiAJaW5zdGFsbCAtbSA3NDQga3NlbGZ0ZXN0L21vZHVsZS5zaCAkKElO
U1RBTExfUEFUSCkva3NlbGZ0ZXN0LwogCWluc3RhbGwgLW0gNzQ0IGtzZWxmdGVzdC9ydW5u
ZXIuc2ggJChJTlNUQUxMX1BBVEgpL2tzZWxmdGVzdC8KIAlpbnN0YWxsIC1tIDc0NCBrc2Vs
ZnRlc3QvcHJlZml4LnBsICQoSU5TVEFMTF9QQVRIKS9rc2VsZnRlc3QvCisJaW5zdGFsbCAt
bSA3NDQga3NlbGZ0ZXN0L2t0YXBfaGVscGVycy5zaCAkKElOU1RBTExfUEFUSCkva3NlbGZ0
ZXN0LwogCWluc3RhbGwgLW0gNzQ0IHJ1bl9rc2VsZnRlc3Quc2ggJChJTlNUQUxMX1BBVEgp
LwogCXJtIC1mICQoVEVTVF9MSVNUKQogCUByZXQ9MTsJXApkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZHQvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9kdC9NYWtlZmlsZQppbmRleCA2MmRjMDBlZTQ5NzguLjJkMzNlZTllOWI3MSAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHQvTWFrZWZpbGUKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZHQvTWFrZWZpbGUKQEAgLTQsNyArNCw3IEBAIGlmbmVxICgk
KFBZMyksKQogCiBURVNUX1BST0dTIDo9IHRlc3RfdW5wcm9iZWRfZGV2aWNlcy5zaAogVEVT
VF9HRU5fRklMRVMgOj0gY29tcGF0aWJsZV9saXN0Ci1URVNUX0ZJTEVTIDo9IGNvbXBhdGli
bGVfaWdub3JlX2xpc3Qga3RhcF9oZWxwZXJzLnNoCitURVNUX0ZJTEVTIDo9IGNvbXBhdGli
bGVfaWdub3JlX2xpc3QKIAogaW5jbHVkZSAuLi9saWIubWsKIApkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZHQvdGVzdF91bnByb2JlZF9kZXZpY2VzLnNoIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZHQvdGVzdF91bnByb2JlZF9kZXZpY2VzLnNoCmluZGV4
IGIwN2FmMmE0YzRkZS4uZjIzMDdlZTQ0M2E2IDEwMDc1NQotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9kdC90ZXN0X3VucHJvYmVkX2RldmljZXMuc2gKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZHQvdGVzdF91bnByb2JlZF9kZXZpY2VzLnNoCkBAIC0xNSwxNiAr
MTUsMTIgQEAKIAogRElSPSIkKGRpcm5hbWUgJChyZWFkbGluayAtZiAiJDAiKSkiCiAKLXNv
dXJjZSAiJHtESVJ9Ii9rdGFwX2hlbHBlcnMuc2gKK3NvdXJjZSAiJHtESVJ9Ii8uLi9rc2Vs
ZnRlc3Qva3RhcF9oZWxwZXJzLnNoCiAKIFBEVD0vcHJvYy9kZXZpY2UtdHJlZS8KIENPTVBB
VF9MSVNUPSIke0RJUn0iL2NvbXBhdGlibGVfbGlzdAogSUdOT1JFX0xJU1Q9IiR7RElSfSIv
Y29tcGF0aWJsZV9pZ25vcmVfbGlzdAogCi1LU0ZUX1BBU1M9MAotS1NGVF9GQUlMPTEKLUtT
RlRfU0tJUD00Ci0KIGt0YXBfcHJpbnRfaGVhZGVyCiAKIGlmIFtbICEgLWQgIiR7UERUfSIg
XV07IHRoZW4KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9m
dHJhY2V0ZXN0IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL2Z0cmFjZXRlc3QK
aW5kZXggYzc3OGQ0ZGNjMTdlLi4yNWQ0ZTBmY2EzODUgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0CisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0CkBAIC01MDQsNyArNTA0LDcgQEAgcHJsb2cg
IiMgb2YgdW5kZWZpbmVkKHRlc3QgYnVnKTogIiBgZWNobyAkVU5ERUZJTkVEX0NBU0VTIHwg
d2MgLXdgCiBpZiBbICIkS1RBUCIgPSAiMSIgXTsgdGhlbgogICBlY2hvIC1uICIjIFRvdGFs
czoiCiAgIGVjaG8gLW4gIiBwYXNzOiJgZWNobyAkUEFTU0VEX0NBU0VTIHwgd2MgLXdgCi0g
IGVjaG8gLW4gIiBmYWlpOiJgZWNobyAkRkFJTEVEX0NBU0VTIHwgd2MgLXdgCisgIGVjaG8g
LW4gIiBmYWlsOiJgZWNobyAkRkFJTEVEX0NBU0VTIHwgd2MgLXdgCiAgIGVjaG8gLW4gIiB4
ZmFpbDoiYGVjaG8gJFhGQUlMRURfQ0FTRVMgfCB3YyAtd2AKICAgZWNobyAtbiAiIHhwYXNz
OjAiCiAgIGVjaG8gLW4gIiBza2lwOiJgZWNobyAkVU5URVNURURfQ0FTRVMgJFVOU1VQUE9S
VEVEX0NBU0VTIHwgd2MgLXdgCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvdGVzdC5kLzAwYmFzaWMvdGVzdF9vd25lcnNoaXAudGMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kLzAwYmFzaWMvdGVzdF9vd25lcnNoaXAudGMK
aW5kZXggYWRkN2Q1YmY1ODVkLi5jNDUwOTRkMWUxZDIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvMDBiYXNpYy90ZXN0X293bmVyc2hpcC50
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kLzAwYmFzaWMv
dGVzdF9vd25lcnNoaXAudGMKQEAgLTEsNiArMSw2IEBACiAjIS9iaW4vc2gKICMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLSMgZGVzY3JpcHRpb246IFRlc3QgZmlsZSBh
bmQgZGlyZWN0b3J5IG93ZXJzaGlwIGNoYW5nZXMgZm9yIGV2ZW50ZnMKKyMgZGVzY3JpcHRp
b246IFRlc3QgZmlsZSBhbmQgZGlyZWN0b3J5IG93bmVyc2hpcCBjaGFuZ2VzIGZvciBldmVu
dGZzCiAKIG9yaWdpbmFsX2dyb3VwPWBzdGF0IC1jICIlZyIgLmAKIG9yaWdpbmFsX293bmVy
PWBzdGF0IC1jICIldSIgLmAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS90ZXN0LmQvZnRyYWNlL2Z1bmNfaG90cGx1Zy50YyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnRyYWNlL2Z1bmNfaG90cGx1Zy50YwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmNjZmJmZGUzZDk0MgotLS0gL2Rl
di9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnRy
YWNlL2Z1bmNfaG90cGx1Zy50YwpAQCAtMCwwICsxLDQyIEBACisjIS9iaW4vc2gKKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyMgZGVzY3JpcHRpb246
IGZ0cmFjZSAtIGZ1bmN0aW9uIHRyYWNlIGFjcm9zcyBjcHUgaG90cGx1ZworIyByZXF1aXJl
czogZnVuY3Rpb246dHJhY2VyCisKK2lmICEgd2hpY2ggbnByb2MgOyB0aGVuCisgIG5wcm9j
KCkgeworICAgIGxzIC1kIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdVswLTldKiB8IHdj
IC1sCisgIH0KK2ZpCisKK05QPWBucHJvY2AKKworaWYgWyAkTlAgLWVxIDEgXSA7dGhlbgor
ICBlY2hvICJXZSBjYW5ub3QgdGVzdCBjcHUgaG90cGx1ZyBpbiBVUCBlbnZpcm9ubWVudCIK
KyAgZXhpdF91bnJlc29sdmVkCitmaQorCisjIEZpbmQgb25saW5lIGNwdQorZm9yIGkgaW4g
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1WzEtOV0qOyBkbworCWlmIFsgLWYgJGkvb25s
aW5lIF0gJiYgWyAiJChjYXQgJGkvb25saW5lKSIgPSAiMSIgXTsgdGhlbgorCQljcHU9JGkK
KwkJYnJlYWsKKwlmaQorZG9uZQorCitpZiBbIC16ICIkY3B1IiBdOyB0aGVuCisJZWNobyAi
V2UgY2Fubm90IHRlc3QgY3B1IGhvdHBsdWcgd2l0aCBhIHNpbmdsZSBjcHUgb25saW5lIgor
CWV4aXRfdW5yZXNvbHZlZAorZmkKKworZWNobyAwID4gdHJhY2luZ19vbgorZWNobyA+IHRy
YWNlCisKKzogIlNldCAkKGJhc2VuYW1lICRjcHUpIG9mZmxpbmUvb25saW5lIHdpdGggZnVu
Y3Rpb24gdHJhY2VyIGVuYWJsZWQiCitlY2hvIGZ1bmN0aW9uID4gY3VycmVudF90cmFjZXIK
K2VjaG8gMSA+IHRyYWNpbmdfb24KKyhlY2hvIDAgPiAkY3B1L29ubGluZSkKKyhlY2hvICJm
b3JrZWQiOyBzbGVlcCAxKQorKGVjaG8gMSA+ICRjcHUvb25saW5lKQorZWNobyAwID4gdHJh
Y2luZ19vbgorZWNobyBub3AgPiBjdXJyZW50X3RyYWNlcgpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL3RyaWdnZXItaGlzdC1t
b2QudGMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL3RyaWdnZXIv
dHJpZ2dlci1oaXN0LW1vZC50YwppbmRleCA0NTYyZTEzY2IyNmIuLjcxNzg5ODg5NGVmNyAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmln
Z2VyL3RyaWdnZXItaGlzdC1tb2QudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL3RyaWdnZXItaGlzdC1tb2QudGMKQEAgLTQwLDcgKzQw
LDcgQEAgZ3JlcCAiaWQ6IFwodW5rbm93bl9cfHN5c19cKSIgZXZlbnRzL3Jhd19zeXNjYWxs
cy9zeXNfZXhpdC9oaXN0ID4gL2Rldi9udWxsIHx8IFwKIAogcmVzZXRfdHJpZ2dlcgogCi1l
Y2hvICJUZXN0IGhpc3RncmFtIHdpdGggbG9nMiBtb2RpZmllciIKK2VjaG8gIlRlc3QgaGlz
dG9ncmFtIHdpdGggbG9nMiBtb2RpZmllciIKIAogZWNobyAnaGlzdDprZXlzPWJ5dGVzX3Jl
cS5sb2cyJyA+IGV2ZW50cy9rbWVtL2ttYWxsb2MvdHJpZ2dlcgogZm9yIGkgaW4gYHNlcSAx
IDEwYCA7IGRvICggZWNobyAiZm9ya2VkIiA+IC9kZXYvbnVsbCk7IGRvbmUKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0ZXhfcmVx
dWV1ZV9waS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rpb25hbC9m
dXRleF9yZXF1ZXVlX3BpLmMKaW5kZXggMWVlNTUxOGVlNmI3Li43ZjNjYTVjNzhkZjEgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0
ZXhfcmVxdWV1ZV9waS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1
bmN0aW9uYWwvZnV0ZXhfcmVxdWV1ZV9waS5jCkBAIC0xNyw2ICsxNyw4IEBACiAgKgogICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqLwogCisjZGVmaW5lIF9HTlVfU09VUkNFCisKICNpbmNs
dWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPGxpbWl0cy5oPgogI2luY2x1ZGUgPHB0aHJlYWQu
aD4KQEAgLTM1OCw2ICszNjAsNyBAQCBpbnQgdW5pdF90ZXN0KGludCBicm9hZGNhc3QsIGxv
bmcgbG9jaywgaW50IHRoaXJkX3BhcnR5X293bmVyLCBsb25nIHRpbWVvdXRfbnMpCiAKIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CisJY29uc3QgY2hhciAqdGVzdF9u
YW1lOwogCWludCBjLCByZXQ7CiAKIAl3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwg
ImJjaGxvdDp2OiIpKSAhPSAtMSkgewpAQCAtMzk3LDYgKzQwMCwxNCBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQogCQkiXHRBcmd1bWVudHM6IGJyb2FkY2FzdD0lZCBs
b2NrZWQ9JWQgb3duZXI9JWQgdGltZW91dD0lbGRuc1xuIiwKIAkJYnJvYWRjYXN0LCBsb2Nr
ZWQsIG93bmVyLCB0aW1lb3V0X25zKTsKIAorCXJldCA9IGFzcHJpbnRmKCZ0ZXN0X25hbWUs
CisJCSAgICAgICAiJXMgYnJvYWRjYXN0PSVkIGxvY2tlZD0lZCBvd25lcj0lZCB0aW1lb3V0
PSVsZG5zIiwKKwkJICAgICAgIFRFU1RfTkFNRSwgYnJvYWRjYXN0LCBsb2NrZWQsIG93bmVy
LCB0aW1lb3V0X25zKTsKKwlpZiAocmV0IDwgMCkgeworCQlrc2Z0X3ByaW50X21zZygiRmFp
bGVkIHRvIGdlbmVyYXRlIHRlc3QgbmFtZVxuIik7CisJCXRlc3RfbmFtZSA9IFRFU1RfTkFN
RTsKKwl9CisKIAkvKgogCSAqIEZJWE1FOiB1bml0X3Rlc3QgaXMgb2Jzb2xldGUgbm93IHRo
YXQgd2UgcGFyc2Ugb3B0aW9ucyBhbmQgdGhlCiAJICogdmFyaW91cyBzdHlsZSBvZiBydW5z
IGFyZSBkb25lIGJ5IHJ1bi5zaCAtIHNpbXBsaWZ5IHRoZSBjb2RlIGFuZCBtb3ZlCkBAIC00
MDQsNiArNDE1LDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkgKi8K
IAlyZXQgPSB1bml0X3Rlc3QoYnJvYWRjYXN0LCBsb2NrZWQsIG93bmVyLCB0aW1lb3V0X25z
KTsKIAotCXByaW50X3Jlc3VsdChURVNUX05BTUUsIHJldCk7CisJcHJpbnRfcmVzdWx0KHRl
c3RfbmFtZSwgcmV0KTsKIAlyZXR1cm4gcmV0OwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZHQva3RhcF9oZWxwZXJzLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3NlbGZ0ZXN0L2t0YXBfaGVscGVycy5zaApzaW1pbGFyaXR5IGluZGV4IDY2JQpy
ZW5hbWUgZnJvbSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kdC9rdGFwX2hlbHBlcnMuc2gK
cmVuYW1lIHRvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9rdGFwX2hlbHBl
cnMuc2gKaW5kZXggOGRmYWU1MWJiNGUyLi5mMmZiYjkxNGUwNTggMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2R0L2t0YXBfaGVscGVycy5zaAorKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3Qva3RhcF9oZWxwZXJzLnNoCkBAIC05LDE0ICs5
LDI3IEBAIEtUQVBfQ05UX1BBU1M9MAogS1RBUF9DTlRfRkFJTD0wCiBLVEFQX0NOVF9TS0lQ
PTAKIAorS1NGVF9QQVNTPTAKK0tTRlRfRkFJTD0xCitLU0ZUX1hGQUlMPTIKK0tTRlRfWFBB
U1M9MworS1NGVF9TS0lQPTQKKworS1NGVF9OVU1fVEVTVFM9MAorCiBrdGFwX3ByaW50X2hl
YWRlcigpIHsKIAllY2hvICJUQVAgdmVyc2lvbiAxMyIKIH0KIAora3RhcF9wcmludF9tc2co
KQoreworCWVjaG8gIiMiICRACit9CisKIGt0YXBfc2V0X3BsYW4oKSB7Ci0JbnVtX3Rlc3Rz
PSIkMSIKKwlLU0ZUX05VTV9URVNUUz0iJDEiCiAKLQllY2hvICIxLi4kbnVtX3Rlc3RzIgor
CWVjaG8gIjEuLiRLU0ZUX05VTV9URVNUUyIKIH0KIAoga3RhcF9za2lwX2FsbCgpIHsKQEAg
LTY1LDYgKzc4LDM0IEBAIGt0YXBfdGVzdF9mYWlsKCkgewogCUtUQVBfQ05UX0ZBSUw9JCgo
S1RBUF9DTlRfRkFJTCsxKSkKIH0KIAora3RhcF90ZXN0X3Jlc3VsdCgpIHsKKwlkZXNjcmlw
dGlvbj0iJDEiCisJc2hpZnQKKworCWlmICRAOyB0aGVuCisJCWt0YXBfdGVzdF9wYXNzICIk
ZGVzY3JpcHRpb24iCisJZWxzZQorCQlrdGFwX3Rlc3RfZmFpbCAiJGRlc2NyaXB0aW9uIgor
CWZpCit9CisKK2t0YXBfZXhpdF9mYWlsX21zZygpIHsKKwllY2hvICJCYWlsIG91dCEgIiAk
QAorCWt0YXBfcHJpbnRfdG90YWxzCisKKwlleGl0ICIkS1NGVF9GQUlMIgorfQorCitrdGFw
X2ZpbmlzaGVkKCkgeworCWt0YXBfcHJpbnRfdG90YWxzCisKKwlpZiBbICQoKCIkS1RBUF9D
TlRfUEFTUyIgKyAiJEtUQVBfQ05UX1NLSVAiKSkgLWVxICIkS1NGVF9OVU1fVEVTVFMiIF07
IHRoZW4KKwkJZXhpdCAiJEtTRlRfUEFTUyIKKwllbHNlCisJCWV4aXQgIiRLU0ZUX0ZBSUwi
CisJZmkKK30KKwoga3RhcF9wcmludF90b3RhbHMoKSB7CiAJZWNobyAiIyBUb3RhbHM6IHBh
c3M6JEtUQVBfQ05UX1BBU1MgZmFpbDokS1RBUF9DTlRfRkFJTCB4ZmFpbDowIHhwYXNzOjAg
c2tpcDokS1RBUF9DTlRfU0tJUCBlcnJvcjowIgogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbGliLm1rIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1r
CmluZGV4IGFhNjQ2ZTA2NjFmMy4uMjg2Y2UwZWUxMDJiIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9saWIubWsKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bGliLm1rCkBAIC01OCw3ICs1OCw4IEBAIFRFU1RfR0VOX1BST0dTIDo9ICQocGF0c3Vic3Qg
JSwkKE9VVFBVVCkvJSwkKFRFU1RfR0VOX1BST0dTKSkKIFRFU1RfR0VOX1BST0dTX0VYVEVO
REVEIDo9ICQocGF0c3Vic3QgJSwkKE9VVFBVVCkvJSwkKFRFU1RfR0VOX1BST0dTX0VYVEVO
REVEKSkKIFRFU1RfR0VOX0ZJTEVTIDo9ICQocGF0c3Vic3QgJSwkKE9VVFBVVCkvJSwkKFRF
U1RfR0VOX0ZJTEVTKSkKIAotYWxsOiAkKFRFU1RfR0VOX1BST0dTKSAkKFRFU1RfR0VOX1BS
T0dTX0VYVEVOREVEKSAkKFRFU1RfR0VOX0ZJTEVTKQorYWxsOiAkKFRFU1RfR0VOX1BST0dT
KSAkKFRFU1RfR0VOX1BST0dTX0VYVEVOREVEKSAkKFRFU1RfR0VOX0ZJTEVTKSBcCisJJChp
ZiAkKFRFU1RfR0VOX01PRFNfRElSKSxnZW5fbW9kc19kaXIpCiAKIGRlZmluZSBSVU5fVEVT
VFMKIAlCQVNFX0RJUj0iJChzZWxmZGlyKSI7CQkJXApAQCAtNzEsOCArNzIsOCBAQCBlbmRl
ZgogCiBydW5fdGVzdHM6IGFsbAogaWZkZWYgYnVpbGRpbmdfb3V0X29mX3NyY3RyZWUKLQlA
aWYgWyAiWCQoVEVTVF9QUk9HUykkKFRFU1RfUFJPR1NfRVhURU5ERUQpJChURVNUX0ZJTEVT
KSIgIT0gIlgiIF07IHRoZW4gXAotCQlyc3luYyAtYXEgLS1jb3B5LXVuc2FmZS1saW5rcyAk
KFRFU1RfUFJPR1MpICQoVEVTVF9QUk9HU19FWFRFTkRFRCkgJChURVNUX0ZJTEVTKSAkKE9V
VFBVVCk7IFwKKwlAaWYgWyAiWCQoVEVTVF9QUk9HUykkKFRFU1RfUFJPR1NfRVhURU5ERUQp
JChURVNUX0ZJTEVTKSQoVEVTVF9HRU5fTU9EU19ESVIpIiAhPSAiWCIgXTsgdGhlbiBcCisJ
CXJzeW5jIC1hcSAtLWNvcHktdW5zYWZlLWxpbmtzICQoVEVTVF9QUk9HUykgJChURVNUX1BS
T0dTX0VYVEVOREVEKSAkKFRFU1RfRklMRVMpICQoVEVTVF9HRU5fTU9EU19ESVIpICQoT1VU
UFVUKTsgXAogCWZpCiAJQGlmIFsgIlgkKFRFU1RfUFJPR1MpIiAhPSAiWCIgXTsgdGhlbiBc
CiAJCSQoY2FsbCBSVU5fVEVTVFMsICQoVEVTVF9HRU5fUFJPR1MpICQoVEVTVF9DVVNUT01f
UFJPR1MpIFwKQEAgLTg0LDExICs4NSwyMiBAQCBlbHNlCiAJQCQoY2FsbCBSVU5fVEVTVFMs
ICQoVEVTVF9HRU5fUFJPR1MpICQoVEVTVF9DVVNUT01fUFJPR1MpICQoVEVTVF9QUk9HUykp
CiBlbmRpZgogCitnZW5fbW9kc19kaXI6CisJJChRKSQoTUFLRSkgLUMgJChURVNUX0dFTl9N
T0RTX0RJUikKKworY2xlYW5fbW9kc19kaXI6CisJJChRKSQoTUFLRSkgLUMgJChURVNUX0dF
Tl9NT0RTX0RJUikgY2xlYW4KKwogZGVmaW5lIElOU1RBTExfU0lOR0xFX1JVTEUKIAkkKGlm
ICQoSU5TVEFMTF9MSVNUKSxAbWtkaXIgLXAgJChJTlNUQUxMX1BBVEgpKQogCSQoaWYgJChJ
TlNUQUxMX0xJU1QpLHJzeW5jIC1hIC0tY29weS11bnNhZmUtbGlua3MgJChJTlNUQUxMX0xJ
U1QpICQoSU5TVEFMTF9QQVRIKS8pCiBlbmRlZgogCitkZWZpbmUgSU5TVEFMTF9NT0RTX1JV
TEUKKwkkKGlmICQoSU5TVEFMTF9MSVNUKSxAbWtkaXIgLXAgJChJTlNUQUxMX1BBVEgpLyQo
SU5TVEFMTF9MSVNUKSkKKwkkKGlmICQoSU5TVEFMTF9MSVNUKSxyc3luYyAtYSAtLWNvcHkt
dW5zYWZlLWxpbmtzICQoSU5TVEFMTF9MSVNUKS8qLmtvICQoSU5TVEFMTF9QQVRIKS8kKElO
U1RBTExfTElTVCkpCitlbmRlZgorCiBkZWZpbmUgSU5TVEFMTF9SVUxFCiAJJChldmFsIElO
U1RBTExfTElTVCA9ICQoVEVTVF9QUk9HUykpICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKIAkk
KGV2YWwgSU5TVEFMTF9MSVNUID0gJChURVNUX1BST0dTX0VYVEVOREVEKSkgJChJTlNUQUxM
X1NJTkdMRV9SVUxFKQpAQCAtOTcsNiArMTA5LDcgQEAgZGVmaW5lIElOU1RBTExfUlVMRQog
CSQoZXZhbCBJTlNUQUxMX0xJU1QgPSAkKFRFU1RfQ1VTVE9NX1BST0dTKSkgJChJTlNUQUxM
X1NJTkdMRV9SVUxFKQogCSQoZXZhbCBJTlNUQUxMX0xJU1QgPSAkKFRFU1RfR0VOX1BST0dT
X0VYVEVOREVEKSkgJChJTlNUQUxMX1NJTkdMRV9SVUxFKQogCSQoZXZhbCBJTlNUQUxMX0xJ
U1QgPSAkKFRFU1RfR0VOX0ZJTEVTKSkgJChJTlNUQUxMX1NJTkdMRV9SVUxFKQorCSQoZXZh
bCBJTlNUQUxMX0xJU1QgPSAkKG5vdGRpciAkKFRFU1RfR0VOX01PRFNfRElSKSkpICQoSU5T
VEFMTF9NT0RTX1JVTEUpCiAJJChldmFsIElOU1RBTExfTElTVCA9ICQod2lsZGNhcmQgY29u
ZmlnIHNldHRpbmdzKSkgJChJTlNUQUxMX1NJTkdMRV9SVUxFKQogZW5kZWYKIApAQCAtMTIy
LDcgKzEzNSw3IEBAIGRlZmluZSBDTEVBTgogCSQoUk0pIC1yICQoVEVTVF9HRU5fUFJPR1Mp
ICQoVEVTVF9HRU5fUFJPR1NfRVhURU5ERUQpICQoVEVTVF9HRU5fRklMRVMpICQoRVhUUkFf
Q0xFQU4pCiBlbmRlZgogCi1jbGVhbjoKK2NsZWFuOiAkKGlmICQoVEVTVF9HRU5fTU9EU19E
SVIpLGNsZWFuX21vZHNfZGlyKQogCSQoQ0xFQU4pCiAKICMgRW5hYmxlcyB0byBleHRlbmQg
Q0ZMQUdTIGFuZCBMREZMQUdTIGZyb20gY29tbWFuZCBsaW5lLCBlLmcuCkBAIC0xNTMsNCAr
MTY2LDQgQEAgJChPVVRQVVQpLyU6JS5TCiAJJChMSU5LLlMpICReICQoTERMSUJTKSAtbyAk
QAogZW5kaWYKIAotLlBIT05ZOiBydW5fdGVzdHMgYWxsIGNsZWFuIGluc3RhbGwgZW1pdF90
ZXN0cworLlBIT05ZOiBydW5fdGVzdHMgYWxsIGNsZWFuIGluc3RhbGwgZW1pdF90ZXN0cyBn
ZW5fbW9kc19kaXIgY2xlYW5fbW9kc19kaXIKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xpdmVwYXRjaC8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbGl2ZXBhdGNoLy5naXRpZ25vcmUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwLi5mMWU5YzJhMjBlOTkKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvLmdpdGlnbm9yZQpAQCAtMCwwICsxIEBACit0ZXN0
X2tscC1jYWxsX2dldHBpZApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bGl2ZXBhdGNoL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNo
L01ha2VmaWxlCmluZGV4IDAyZmFkYzlkNTVlMC4uMzU0MThhNDc5MGJlIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvTWFrZWZpbGUKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL01ha2VmaWxlCkBAIC0xLDUgKzEsNyBA
QAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAogCitURVNUX0dFTl9GSUxF
UyA6PSB0ZXN0X2tscC1jYWxsX2dldHBpZAorVEVTVF9HRU5fTU9EU19ESVIgOj0gdGVzdF9t
b2R1bGVzCiBURVNUX1BST0dTX0VYVEVOREVEIDo9IGZ1bmN0aW9ucy5zaAogVEVTVF9QUk9H
UyA6PSBcCiAJdGVzdC1saXZlcGF0Y2guc2ggXApAQCAtNyw3ICs5LDggQEAgVEVTVF9QUk9H
UyA6PSBcCiAJdGVzdC1zaGFkb3ctdmFycy5zaCBcCiAJdGVzdC1zdGF0ZS5zaCBcCiAJdGVz
dC1mdHJhY2Uuc2ggXAotCXRlc3Qtc3lzZnMuc2gKKwl0ZXN0LXN5c2ZzLnNoIFwKKwl0ZXN0
LXN5c2NhbGwuc2gKIAogVEVTVF9GSUxFUyA6PSBzZXR0aW5ncwogCmRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvUkVBRE1FIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGl2ZXBhdGNoL1JFQURNRQppbmRleCAwOTQyZGQ1ODI2ZjguLmQyMDM1
ZGQ2NGEyYiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNo
L1JFQURNRQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvUkVBRE1F
CkBAIC0xMywyMyArMTMsMzYgQEAgdGhlIG1lc3NhZ2UgYnVmZmVyIGZvciBvbmx5IHRoZSBk
dXJhdGlvbiBvZiBlYWNoIGluZGl2aWR1YWwgdGVzdC4pCiBDb25maWcKIC0tLS0tLQogCi1T
ZXQgdGhlc2UgY29uZmlnIG9wdGlvbnMgYW5kIHRoZWlyIHByZXJlcXVpc2l0ZXM6CitTZXQg
Q09ORklHX0xJVkVQQVRDSD15IG9wdGlvbiBhbmQgaXQncyBwcmVyZXF1aXNpdGVzLgogCi1D
T05GSUdfTElWRVBBVENIPXkKLUNPTkZJR19URVNUX0xJVkVQQVRDSD1tCiAKK0J1aWxkaW5n
IHRoZSB0ZXN0cworLS0tLS0tLS0tLS0tLS0tLS0tCisKK1RvIG9ubHkgYnVpbGQgdGhlIHRl
c3RzIHdpdGhvdXQgcnVubmluZyB0aGVtLCBydW46CisKKyAgJSBtYWtlIC1DIHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaAorCitUaGUgY29tbWFuZCBhYm92ZSB3aWxsIGNv
bXBpbGUgYWxsIHRlc3QgbW9kdWxlcyBhbmQgdGVzdCBwcm9ncmFtcywgbWFraW5nIHRoZW0K
K3JlYWR5IHRvIGJlIHBhY2thZ2VkIGlmIHNvIGRlc2lyZWQuCiAKIFJ1bm5pbmcgdGhlIHRl
c3RzCiAtLS0tLS0tLS0tLS0tLS0tLQogCi1UZXN0IGtlcm5lbCBtb2R1bGVzIGFyZSBidWls
dCBhcyBwYXJ0IG9mIGxpYi8gKG1ha2UgbW9kdWxlcykgYW5kIG5lZWQgdG8KLWJlIGluc3Rh
bGxlZCAobWFrZSBtb2R1bGVzX2luc3RhbGwpIGFzIHRoZSB0ZXN0IHNjcmlwdHMgd2lsbCBt
b2Rwcm9iZQotdGhlbS4KK1Rlc3Qga2VybmVsIG1vZHVsZXMgYXJlIGJ1aWx0IGJlZm9yZSBy
dW5uaW5nIHRoZSBsaXZlcGF0Y2ggc2VsZnRlc3RzLiAgVGhlCittb2R1bGVzIGFyZSBsb2Nh
dGVkIHVuZGVyIHRlc3RfbW9kdWxlcyBkaXJlY3RvcnksIGFuZCBhcmUgYnVpbHQgYXMgb3V0
LW9mLXRyZWUKK21vZHVsZXMuICBUaGlzIGlzIHNwZWNpYWxseSB1c2VmdWwgc2luY2UgdGhl
IHNhbWUgc291cmNlcyBjYW4gYmUgYnVpbHQgYW5kCit0ZXN0ZWQgb24gc3lzdGVtcyB3aXRo
IGRpZmZlcmVudCBrQUJJLCBlbnN1cmluZyB0aGV5IHRoZSB0ZXN0cyBhcmUgYmFja3dhcmRz
Citjb21wYXRpYmxlLiAgVGhlIG1vZHVsZXMgd2lsbCBiZSBsb2FkZWQgYnkgdGhlIHRlc3Qg
c2NyaXB0cyB1c2luZyBpbnNtb2QuCiAKIFRvIHJ1biB0aGUgbGl2ZXBhdGNoIHNlbGZ0ZXN0
cywgZnJvbSB0aGUgdG9wIG9mIHRoZSBrZXJuZWwgc291cmNlIHRyZWU6CiAKICAgJSBtYWtl
IC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzIFRBUkdFVFM9bGl2ZXBhdGNoIHJ1bl90ZXN0
cwogCitvcgorCisgICUgbWFrZSBrc2VsZnRlc3QgVEFSR0VUUz1saXZlcGF0Y2gKKwogCiBB
ZGRpbmcgdGVzdHMKIC0tLS0tLS0tLS0tLQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbGl2ZXBhdGNoL2NvbmZpZyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xp
dmVwYXRjaC9jb25maWcKaW5kZXggYWQyMzEwMGNiMjdjLi5lODhiZjUxOGEyM2EgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC9jb25maWcKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL2NvbmZpZwpAQCAtMSwzICsxLDIg
QEAKIENPTkZJR19MSVZFUEFUQ0g9eQogQ09ORklHX0RZTkFNSUNfREVCVUc9eQotQ09ORklH
X1RFU1RfTElWRVBBVENIPW0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2xpdmVwYXRjaC9mdW5jdGlvbnMuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZl
cGF0Y2gvZnVuY3Rpb25zLnNoCmluZGV4IGM4NDE2YzU0YjQ2My4uZjBlZDE0OGQzYzUxIDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvZnVuY3Rpb25z
LnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC9mdW5jdGlvbnMu
c2gKQEAgLTM0LDYgKzM0LDE4IEBAIGZ1bmN0aW9uIGlzX3Jvb3QoKSB7CiAJZmkKIH0KIAor
IyBDaGVjayBpZiB3ZSBjYW4gY29tcGlsZSB0aGUgbW9kdWxlcyBiZWZvcmUgbG9hZGluZyB0
aGVtCitmdW5jdGlvbiBoYXNfa2RpcigpIHsKKwlpZiBbIC16ICIkS0RJUiIgXTsgdGhlbgor
CQlLRElSPSIvbGliL21vZHVsZXMvJCh1bmFtZSAtcikvYnVpbGQiCisJZmkKKworCWlmIFsg
ISAtZCAiJEtESVIiIF07IHRoZW4KKwkJZWNobyAic2tpcCBhbGwgdGVzdHM6IEtESVIgKCRL
RElSKSBub3QgYXZhaWxhYmxlIHRvIGNvbXBpbGUgbW9kdWxlcy4iCisJCWV4aXQgJGtzZnRf
c2tpcAorCWZpCit9CisKICMgZGllKG1zZykgLSBnYW1lIG92ZXIsIG1hbgogIwltc2cgLSBk
eWluZyB3b3JkcwogZnVuY3Rpb24gZGllKCkgewpAQCAtMTA4LDYgKzEyMCw3IEBAIGZ1bmN0
aW9uIGNsZWFudXAoKSB7CiAjCQkgdGhlIGZ0cmFjZV9lbmFibGVkIHN5c2N0bC4KIGZ1bmN0
aW9uIHNldHVwX2NvbmZpZygpIHsKIAlpc19yb290CisJaGFzX2tkaXIKIAlwdXNoX2NvbmZp
ZwogCXNldF9keW5hbWljX2RlYnVnCiAJc2V0X2Z0cmFjZV9lbmFibGVkIDEKQEAgLTEyNywx
NiArMTQwLDE0IEBAIGZ1bmN0aW9uIGxvb3BfdW50aWwoKSB7CiAJZG9uZQogfQogCi1mdW5j
dGlvbiBhc3NlcnRfbW9kKCkgewotCWxvY2FsIG1vZD0iJDEiCi0KLQltb2Rwcm9iZSAtLWRy
eS1ydW4gIiRtb2QiICY+L2Rldi9udWxsCi19Ci0KIGZ1bmN0aW9uIGlzX2xpdmVwYXRjaF9t
b2QoKSB7CiAJbG9jYWwgbW9kPSIkMSIKIAotCWlmIFtbICQobW9kaW5mbyAiJG1vZCIgfCBh
d2sgJy9ebGl2ZXBhdGNoOi97cHJpbnQgJE5GfScpID09ICJZIiBdXTsgdGhlbgorCWlmIFtb
ICEgLWYgInRlc3RfbW9kdWxlcy8kbW9kLmtvIiBdXTsgdGhlbgorCQlkaWUgIkNhbid0IGZp
bmQgXCJ0ZXN0X21vZHVsZXMvJG1vZC5rb1wiLCB0cnkgXCJtYWtlXCIiCisJZmkKKworCWlm
IFtbICQobW9kaW5mbyAidGVzdF9tb2R1bGVzLyRtb2Qua28iIHwgYXdrICcvXmxpdmVwYXRj
aDove3ByaW50ICRORn0nKSA9PSAiWSIgXV07IHRoZW4KIAkJcmV0dXJuIDAKIAlmaQogCkBA
IC0xNDYsOSArMTU3LDkgQEAgZnVuY3Rpb24gaXNfbGl2ZXBhdGNoX21vZCgpIHsKIGZ1bmN0
aW9uIF9fbG9hZF9tb2QoKSB7CiAJbG9jYWwgbW9kPSIkMSI7IHNoaWZ0CiAKLQlsb2NhbCBt
c2c9IiUgbW9kcHJvYmUgJG1vZCAkKiIKKwlsb2NhbCBtc2c9IiUgaW5zbW9kIHRlc3RfbW9k
dWxlcy8kbW9kLmtvICQqIgogCWxvZyAiJHttc2clJSB9IgotCXJldD0kKG1vZHByb2JlICIk
bW9kIiAiJEAiIDI+JjEpCisJcmV0PSQoaW5zbW9kICJ0ZXN0X21vZHVsZXMvJG1vZC5rbyIg
IiRAIiAyPiYxKQogCWlmIFtbICIkcmV0IiAhPSAiIiBdXTsgdGhlbgogCQlkaWUgIiRyZXQi
CiAJZmkKQEAgLTE2MSwxMyArMTcyLDEwIEBAIGZ1bmN0aW9uIF9fbG9hZF9tb2QoKSB7CiAK
ICMgbG9hZF9tb2QobW9kbmFtZSwgcGFyYW1zKSAtIGxvYWQgYSBrZXJuZWwgbW9kdWxlCiAj
CW1vZG5hbWUgLSBtb2R1bGUgbmFtZSB0byBsb2FkCi0jCXBhcmFtcyAgLSBtb2R1bGUgcGFy
YW1ldGVycyB0byBwYXNzIHRvIG1vZHByb2JlCisjCXBhcmFtcyAgLSBtb2R1bGUgcGFyYW1l
dGVycyB0byBwYXNzIHRvIGluc21vZAogZnVuY3Rpb24gbG9hZF9tb2QoKSB7CiAJbG9jYWwg
bW9kPSIkMSI7IHNoaWZ0CiAKLQlhc3NlcnRfbW9kICIkbW9kIiB8fAotCQlza2lwICJ1bmFi
bGUgdG8gbG9hZCBtb2R1bGUgJHttb2R9LCB2ZXJpZnkgQ09ORklHX1RFU1RfTElWRVBBVENI
PW0gYW5kIHJ1biBzZWxmLXRlc3RzIGFzIHJvb3QiCi0KIAlpc19saXZlcGF0Y2hfbW9kICIk
bW9kIiAmJgogCQlkaWUgInVzZSBsb2FkX2xwKCkgdG8gbG9hZCB0aGUgbGl2ZXBhdGNoIG1v
ZHVsZSAkbW9kIgogCkBAIC0xNzcsMTMgKzE4NSwxMCBAQCBmdW5jdGlvbiBsb2FkX21vZCgp
IHsKICMgbG9hZF9scF9ub3dhaXQobW9kbmFtZSwgcGFyYW1zKSAtIGxvYWQgYSBrZXJuZWwg
bW9kdWxlIHdpdGggYSBsaXZlcGF0Y2gKICMJCQlidXQgZG8gbm90IHdhaXQgb24gdW50aWwg
dGhlIHRyYW5zaXRpb24gZmluaXNoZXMKICMJbW9kbmFtZSAtIG1vZHVsZSBuYW1lIHRvIGxv
YWQKLSMJcGFyYW1zICAtIG1vZHVsZSBwYXJhbWV0ZXJzIHRvIHBhc3MgdG8gbW9kcHJvYmUK
KyMJcGFyYW1zICAtIG1vZHVsZSBwYXJhbWV0ZXJzIHRvIHBhc3MgdG8gaW5zbW9kCiBmdW5j
dGlvbiBsb2FkX2xwX25vd2FpdCgpIHsKIAlsb2NhbCBtb2Q9IiQxIjsgc2hpZnQKIAotCWFz
c2VydF9tb2QgIiRtb2QiIHx8Ci0JCXNraXAgInVuYWJsZSB0byBsb2FkIG1vZHVsZSAke21v
ZH0sIHZlcmlmeSBDT05GSUdfVEVTVF9MSVZFUEFUQ0g9bSBhbmQgcnVuIHNlbGYtdGVzdHMg
YXMgcm9vdCIKLQogCWlzX2xpdmVwYXRjaF9tb2QgIiRtb2QiIHx8CiAJCWRpZSAibW9kdWxl
ICRtb2QgaXMgbm90IGEgbGl2ZXBhdGNoIgogCkBAIC0xOTYsNyArMjAxLDcgQEAgZnVuY3Rp
b24gbG9hZF9scF9ub3dhaXQoKSB7CiAKICMgbG9hZF9scChtb2RuYW1lLCBwYXJhbXMpIC0g
bG9hZCBhIGtlcm5lbCBtb2R1bGUgd2l0aCBhIGxpdmVwYXRjaAogIwltb2RuYW1lIC0gbW9k
dWxlIG5hbWUgdG8gbG9hZAotIwlwYXJhbXMgIC0gbW9kdWxlIHBhcmFtZXRlcnMgdG8gcGFz
cyB0byBtb2Rwcm9iZQorIwlwYXJhbXMgIC0gbW9kdWxlIHBhcmFtZXRlcnMgdG8gcGFzcyB0
byBpbnNtb2QKIGZ1bmN0aW9uIGxvYWRfbHAoKSB7CiAJbG9jYWwgbW9kPSIkMSI7IHNoaWZ0
CiAKQEAgLTIwOSwxMyArMjE0LDEzIEBAIGZ1bmN0aW9uIGxvYWRfbHAoKSB7CiAKICMgbG9h
ZF9mYWlsaW5nX21vZChtb2RuYW1lLCBwYXJhbXMpIC0gbG9hZCBhIGtlcm5lbCBtb2R1bGUs
IGV4cGVjdCB0byBmYWlsCiAjCW1vZG5hbWUgLSBtb2R1bGUgbmFtZSB0byBsb2FkCi0jCXBh
cmFtcyAgLSBtb2R1bGUgcGFyYW1ldGVycyB0byBwYXNzIHRvIG1vZHByb2JlCisjCXBhcmFt
cyAgLSBtb2R1bGUgcGFyYW1ldGVycyB0byBwYXNzIHRvIGluc21vZAogZnVuY3Rpb24gbG9h
ZF9mYWlsaW5nX21vZCgpIHsKIAlsb2NhbCBtb2Q9IiQxIjsgc2hpZnQKIAotCWxvY2FsIG1z
Zz0iJSBtb2Rwcm9iZSAkbW9kICQqIgorCWxvY2FsIG1zZz0iJSBpbnNtb2QgdGVzdF9tb2R1
bGVzLyRtb2Qua28gJCoiCiAJbG9nICIke21zZyUlIH0iCi0JcmV0PSQobW9kcHJvYmUgIiRt
b2QiICIkQCIgMj4mMSkKKwlyZXQ9JChpbnNtb2QgInRlc3RfbW9kdWxlcy8kbW9kLmtvIiAi
JEAiIDI+JjEpCiAJaWYgW1sgIiRyZXQiID09ICIiIF1dOyB0aGVuCiAJCWRpZSAiJG1vZCB1
bmV4cGVjdGVkbHkgbG9hZGVkIgogCWZpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1jYWxsYmFja3Muc2ggYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1jYWxsYmFja3Muc2gKaW5kZXggOTBiMjZkYmIyNjI2
Li4zMmIxNTBlMjViMTAgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xp
dmVwYXRjaC90ZXN0LWNhbGxiYWNrcy5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9saXZlcGF0Y2gvdGVzdC1jYWxsYmFja3Muc2gKQEAgLTM0LDkgKzM0LDkgQEAgZGlzYWJs
ZV9scCAkTU9EX0xJVkVQQVRDSAogdW5sb2FkX2xwICRNT0RfTElWRVBBVENICiB1bmxvYWRf
bW9kICRNT0RfVEFSR0VUCiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9iZSAkTU9EX1RBUkdF
VAorY2hlY2tfcmVzdWx0ICIlIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9UQVJHRVQua28K
ICRNT0RfVEFSR0VUOiAke01PRF9UQVJHRVR9X2luaXQKLSUgbW9kcHJvYmUgJE1PRF9MSVZF
UEFUQ0gKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQQVRDSC5rbwogbGl2ZXBh
dGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gnCiBsaXZlcGF0Y2g6ICckTU9E
X0xJVkVQQVRDSCc6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiAkTU9EX0xJ
VkVQQVRDSDogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CkBAIC04MSw3ICs4MSw3IEBA
IGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAog
dW5sb2FkX21vZCAkTU9EX1RBUkdFVAogCi1jaGVja19yZXN1bHQgIiUgbW9kcHJvYmUgJE1P
RF9MSVZFUEFUQ0gKK2NoZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0Rf
TElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IGVuYWJsaW5nIHBhdGNoICckTU9EX0xJVkVQQVRD
SCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5n
IHRyYW5zaXRpb24KICRNT0RfTElWRVBBVENIOiBwcmVfcGF0Y2hfY2FsbGJhY2s6IHZtbGlu
dXgKQEAgLTg5LDcgKzg5LDcgQEAgbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBzdGFy
dGluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6
IGNvbXBsZXRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHBvc3Rf
cGF0Y2hfY2FsbGJhY2s6IHZtbGludXgKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzog
cGF0Y2hpbmcgY29tcGxldGUKLSUgbW9kcHJvYmUgJE1PRF9UQVJHRVQKKyUgaW5zbW9kIHRl
c3RfbW9kdWxlcy8kTU9EX1RBUkdFVC5rbwogbGl2ZXBhdGNoOiBhcHBseWluZyBwYXRjaCAn
JE1PRF9MSVZFUEFUQ0gnIHRvIGxvYWRpbmcgbW9kdWxlICckTU9EX1RBUkdFVCcKICRNT0Rf
TElWRVBBVENIOiBwcmVfcGF0Y2hfY2FsbGJhY2s6ICRNT0RfVEFSR0VUIC0+IFtNT0RVTEVf
U1RBVEVfQ09NSU5HXSBGdWxsIGZvcm1lZCwgcnVubmluZyBtb2R1bGVfaW5pdAogJE1PRF9M
SVZFUEFUQ0g6IHBvc3RfcGF0Y2hfY2FsbGJhY2s6ICRNT0RfVEFSR0VUIC0+IFtNT0RVTEVf
U1RBVEVfQ09NSU5HXSBGdWxsIGZvcm1lZCwgcnVubmluZyBtb2R1bGVfaW5pdApAQCAtMTI5
LDkgKzEyOSw5IEBAIHVubG9hZF9tb2QgJE1PRF9UQVJHRVQKIGRpc2FibGVfbHAgJE1PRF9M
SVZFUEFUQ0gKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAogCi1jaGVja19yZXN1bHQgIiUg
bW9kcHJvYmUgJE1PRF9UQVJHRVQKK2NoZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1
bGVzLyRNT0RfVEFSR0VULmtvCiAkTU9EX1RBUkdFVDogJHtNT0RfVEFSR0VUfV9pbml0Ci0l
IG1vZHByb2JlICRNT0RfTElWRVBBVENICislIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9M
SVZFUEFUQ0gua28KIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENI
JwogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBpbml0aWFsaXppbmcgcGF0Y2hpbmcg
dHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazogdm1saW51
eApAQCAtMTc3LDcgKzE3Nyw3IEBAIHVubG9hZF9tb2QgJE1PRF9UQVJHRVQKIGRpc2FibGVf
bHAgJE1PRF9MSVZFUEFUQ0gKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAogCi1jaGVja19y
ZXN1bHQgIiUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKK2NoZWNrX3Jlc3VsdCAiJSBpbnNt
b2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IGVuYWJsaW5n
IHBhdGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzog
aW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRNT0RfTElWRVBBVENIOiBwcmVf
cGF0Y2hfY2FsbGJhY2s6IHZtbGludXgKQEAgLTE4NSw3ICsxODUsNyBAQCBsaXZlcGF0Y2g6
ICckTU9EX0xJVkVQQVRDSCc6IHN0YXJ0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxpdmVw
YXRjaDogJyRNT0RfTElWRVBBVENIJzogY29tcGxldGluZyBwYXRjaGluZyB0cmFuc2l0aW9u
CiAkTU9EX0xJVkVQQVRDSDogcG9zdF9wYXRjaF9jYWxsYmFjazogdm1saW51eAogbGl2ZXBh
dGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBwYXRjaGluZyBjb21wbGV0ZQotJSBtb2Rwcm9iZSAk
TU9EX1RBUkdFVAorJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfVEFSR0VULmtvCiBsaXZl
cGF0Y2g6IGFwcGx5aW5nIHBhdGNoICckTU9EX0xJVkVQQVRDSCcgdG8gbG9hZGluZyBtb2R1
bGUgJyRNT0RfVEFSR0VUJwogJE1PRF9MSVZFUEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazog
JE1PRF9UQVJHRVQgLT4gW01PRFVMRV9TVEFURV9DT01JTkddIEZ1bGwgZm9ybWVkLCBydW5u
aW5nIG1vZHVsZV9pbml0CiAkTU9EX0xJVkVQQVRDSDogcG9zdF9wYXRjaF9jYWxsYmFjazog
JE1PRF9UQVJHRVQgLT4gW01PRFVMRV9TVEFURV9DT01JTkddIEZ1bGwgZm9ybWVkLCBydW5u
aW5nIG1vZHVsZV9pbml0CkBAIC0yMTksNyArMjE5LDcgQEAgbG9hZF9scCAkTU9EX0xJVkVQ
QVRDSAogZGlzYWJsZV9scCAkTU9EX0xJVkVQQVRDSAogdW5sb2FkX2xwICRNT0RfTElWRVBB
VENICiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSAorY2hlY2tf
cmVzdWx0ICIlIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9MSVZFUEFUQ0gua28KIGxpdmVw
YXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENIJwogbGl2ZXBhdGNoOiAnJE1P
RF9MSVZFUEFUQ0gnOiBpbml0aWFsaXppbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9M
SVZFUEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazogdm1saW51eApAQCAtMjU0LDkgKzI1NCw5
IEBAIGxvYWRfbW9kICRNT0RfVEFSR0VUCiBsb2FkX2ZhaWxpbmdfbW9kICRNT0RfTElWRVBB
VENIIHByZV9wYXRjaF9yZXQ9LTE5CiB1bmxvYWRfbW9kICRNT0RfVEFSR0VUCiAKLWNoZWNr
X3Jlc3VsdCAiJSBtb2Rwcm9iZSAkTU9EX1RBUkdFVAorY2hlY2tfcmVzdWx0ICIlIGluc21v
ZCB0ZXN0X21vZHVsZXMvJE1PRF9UQVJHRVQua28KICRNT0RfVEFSR0VUOiAke01PRF9UQVJH
RVR9X2luaXQKLSUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0ggcHJlX3BhdGNoX3JldD0tMTkK
KyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQQVRDSC5rbyBwcmVfcGF0Y2hfcmV0
PS0xOQogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gnCiBsaXZl
cGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFuc2l0
aW9uCiB0ZXN0X2tscF9jYWxsYmFja3NfZGVtbzogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxp
bnV4CkBAIC0yNjUsNyArMjY1LDcgQEAgbGl2ZXBhdGNoOiBmYWlsZWQgdG8gZW5hYmxlIHBh
dGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogY2Fu
Y2VsaW5nIHBhdGNoaW5nIHRyYW5zaXRpb24sIGdvaW5nIHRvIHVucGF0Y2gKIGxpdmVwYXRj
aDogJyRNT0RfTElWRVBBVENIJzogY29tcGxldGluZyB1bnBhdGNoaW5nIHRyYW5zaXRpb24K
IGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogdW5wYXRjaGluZyBjb21wbGV0ZQotbW9k
cHJvYmU6IEVSUk9SOiBjb3VsZCBub3QgaW5zZXJ0ICckTU9EX0xJVkVQQVRDSCc6IE5vIHN1
Y2ggZGV2aWNlCitpbnNtb2Q6IEVSUk9SOiBjb3VsZCBub3QgaW5zZXJ0IG1vZHVsZSB0ZXN0
X21vZHVsZXMvJE1PRF9MSVZFUEFUQ0gua286IE5vIHN1Y2ggZGV2aWNlCiAlIHJtbW9kICRN
T0RfVEFSR0VUCiAkTU9EX1RBUkdFVDogJHtNT0RfVEFSR0VUfV9leGl0IgogCkBAIC0yOTUs
NyArMjk1LDcgQEAgbG9hZF9mYWlsaW5nX21vZCAkTU9EX1RBUkdFVAogZGlzYWJsZV9scCAk
TU9EX0xJVkVQQVRDSAogdW5sb2FkX2xwICRNT0RfTElWRVBBVENICiAKLWNoZWNrX3Jlc3Vs
dCAiJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSAorY2hlY2tfcmVzdWx0ICIlIGluc21vZCB0
ZXN0X21vZHVsZXMvJE1PRF9MSVZFUEFUQ0gua28KIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0
Y2ggJyRNT0RfTElWRVBBVENIJwogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBpbml0
aWFsaXppbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHByZV9wYXRj
aF9jYWxsYmFjazogdm1saW51eApAQCAtMzA0LDEyICszMDQsMTIgQEAgbGl2ZXBhdGNoOiAn
JE1PRF9MSVZFUEFUQ0gnOiBjb21wbGV0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRNT0Rf
TElWRVBBVENIOiBwb3N0X3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CiBsaXZlcGF0Y2g6ICck
TU9EX0xJVkVQQVRDSCc6IHBhdGNoaW5nIGNvbXBsZXRlCiAlIGVjaG8gLTE5ID4gL3N5cy9t
b2R1bGUvJE1PRF9MSVZFUEFUQ0gvcGFyYW1ldGVycy9wcmVfcGF0Y2hfcmV0Ci0lIG1vZHBy
b2JlICRNT0RfVEFSR0VUCislIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9UQVJHRVQua28K
IGxpdmVwYXRjaDogYXBwbHlpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENIJyB0byBsb2FkaW5n
IG1vZHVsZSAnJE1PRF9UQVJHRVQnCiAkTU9EX0xJVkVQQVRDSDogcHJlX3BhdGNoX2NhbGxi
YWNrOiAkTU9EX1RBUkdFVCAtPiBbTU9EVUxFX1NUQVRFX0NPTUlOR10gRnVsbCBmb3JtZWQs
IHJ1bm5pbmcgbW9kdWxlX2luaXQKIGxpdmVwYXRjaDogcHJlLXBhdGNoIGNhbGxiYWNrIGZh
aWxlZCBmb3Igb2JqZWN0ICckTU9EX1RBUkdFVCcKIGxpdmVwYXRjaDogcGF0Y2ggJyRNT0Rf
TElWRVBBVENIJyBmYWlsZWQgZm9yIG1vZHVsZSAnJE1PRF9UQVJHRVQnLCByZWZ1c2luZyB0
byBsb2FkIG1vZHVsZSAnJE1PRF9UQVJHRVQnCi1tb2Rwcm9iZTogRVJST1I6IGNvdWxkIG5v
dCBpbnNlcnQgJyRNT0RfVEFSR0VUJzogTm8gc3VjaCBkZXZpY2UKK2luc21vZDogRVJST1I6
IGNvdWxkIG5vdCBpbnNlcnQgbW9kdWxlIHRlc3RfbW9kdWxlcy8kTU9EX1RBUkdFVC5rbzog
Tm8gc3VjaCBkZXZpY2UKICUgZWNobyAwID4gL3N5cy9rZXJuZWwvbGl2ZXBhdGNoLyRNT0Rf
TElWRVBBVENIL2VuYWJsZWQKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogaW5pdGlh
bGl6aW5nIHVucGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHByZV91bnBh
dGNoX2NhbGxiYWNrOiB2bWxpbnV4CkBAIC0zNDAsMTEgKzM0MCwxMSBAQCBkaXNhYmxlX2xw
ICRNT0RfTElWRVBBVENICiB1bmxvYWRfbHAgJE1PRF9MSVZFUEFUQ0gKIHVubG9hZF9tb2Qg
JE1PRF9UQVJHRVRfQlVTWQogCi1jaGVja19yZXN1bHQgIiUgbW9kcHJvYmUgJE1PRF9UQVJH
RVRfQlVTWSBibG9ja190cmFuc2l0aW9uPU4KK2NoZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVz
dF9tb2R1bGVzLyRNT0RfVEFSR0VUX0JVU1kua28gYmxvY2tfdHJhbnNpdGlvbj1OCiAkTU9E
X1RBUkdFVF9CVVNZOiAke01PRF9UQVJHRVRfQlVTWX1faW5pdAogJE1PRF9UQVJHRVRfQlVT
WTogYnVzeW1vZF93b3JrX2Z1bmMgZW50ZXIKICRNT0RfVEFSR0VUX0JVU1k6IGJ1c3ltb2Rf
d29ya19mdW5jIGV4aXQKLSUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKKyUgaW5zbW9kIHRl
c3RfbW9kdWxlcy8kTU9EX0xJVkVQQVRDSC5rbwogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRj
aCAnJE1PRF9MSVZFUEFUQ0gnCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGluaXRp
YWxpemluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiAkTU9EX0xJVkVQQVRDSDogcHJlX3BhdGNo
X2NhbGxiYWNrOiB2bWxpbnV4CkBAIC0zNTQsNyArMzU0LDcgQEAgbGl2ZXBhdGNoOiAnJE1P
RF9MSVZFUEFUQ0gnOiBjb21wbGV0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRNT0RfTElW
RVBBVENIOiBwb3N0X3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CiAkTU9EX0xJVkVQQVRDSDog
cG9zdF9wYXRjaF9jYWxsYmFjazogJE1PRF9UQVJHRVRfQlVTWSAtPiBbTU9EVUxFX1NUQVRF
X0xJVkVdIE5vcm1hbCBzdGF0ZQogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBwYXRj
aGluZyBjb21wbGV0ZQotJSBtb2Rwcm9iZSAkTU9EX1RBUkdFVAorJSBpbnNtb2QgdGVzdF9t
b2R1bGVzLyRNT0RfVEFSR0VULmtvCiBsaXZlcGF0Y2g6IGFwcGx5aW5nIHBhdGNoICckTU9E
X0xJVkVQQVRDSCcgdG8gbG9hZGluZyBtb2R1bGUgJyRNT0RfVEFSR0VUJwogJE1PRF9MSVZF
UEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazogJE1PRF9UQVJHRVQgLT4gW01PRFVMRV9TVEFU
RV9DT01JTkddIEZ1bGwgZm9ybWVkLCBydW5uaW5nIG1vZHVsZV9pbml0CiAkTU9EX0xJVkVQ
QVRDSDogcG9zdF9wYXRjaF9jYWxsYmFjazogJE1PRF9UQVJHRVQgLT4gW01PRFVMRV9TVEFU
RV9DT01JTkddIEZ1bGwgZm9ybWVkLCBydW5uaW5nIG1vZHVsZV9pbml0CkBAIC00MjEsMTYg
KzQyMSwxNiBAQCBkaXNhYmxlX2xwICRNT0RfTElWRVBBVENICiB1bmxvYWRfbHAgJE1PRF9M
SVZFUEFUQ0gKIHVubG9hZF9tb2QgJE1PRF9UQVJHRVRfQlVTWQogCi1jaGVja19yZXN1bHQg
IiUgbW9kcHJvYmUgJE1PRF9UQVJHRVRfQlVTWSBibG9ja190cmFuc2l0aW9uPVkKK2NoZWNr
X3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfVEFSR0VUX0JVU1kua28gYmxv
Y2tfdHJhbnNpdGlvbj1ZCiAkTU9EX1RBUkdFVF9CVVNZOiAke01PRF9UQVJHRVRfQlVTWX1f
aW5pdAogJE1PRF9UQVJHRVRfQlVTWTogYnVzeW1vZF93b3JrX2Z1bmMgZW50ZXIKLSUgbW9k
cHJvYmUgJE1PRF9MSVZFUEFUQ0gKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQ
QVRDSC5rbwogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gnCiBs
aXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFu
c2l0aW9uCiAkTU9EX0xJVkVQQVRDSDogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CiAk
TU9EX0xJVkVQQVRDSDogcHJlX3BhdGNoX2NhbGxiYWNrOiAkTU9EX1RBUkdFVF9CVVNZIC0+
IFtNT0RVTEVfU1RBVEVfTElWRV0gTm9ybWFsIHN0YXRlCiBsaXZlcGF0Y2g6ICckTU9EX0xJ
VkVQQVRDSCc6IHN0YXJ0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KLSUgbW9kcHJvYmUgJE1P
RF9UQVJHRVQKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX1RBUkdFVC5rbwogbGl2ZXBh
dGNoOiBhcHBseWluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gnIHRvIGxvYWRpbmcgbW9kdWxl
ICckTU9EX1RBUkdFVCcKICRNT0RfTElWRVBBVENIOiBwcmVfcGF0Y2hfY2FsbGJhY2s6ICRN
T0RfVEFSR0VUIC0+IFtNT0RVTEVfU1RBVEVfQ09NSU5HXSBGdWxsIGZvcm1lZCwgcnVubmlu
ZyBtb2R1bGVfaW5pdAogJE1PRF9UQVJHRVQ6ICR7TU9EX1RBUkdFVH1faW5pdApAQCAtNDY3
LDcgKzQ2Nyw3IEBAIGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gKIHVubG9hZF9scCAkTU9E
X0xJVkVQQVRDSDIKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAogCi1jaGVja19yZXN1bHQg
IiUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKK2NoZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVz
dF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IGVuYWJsaW5nIHBhdGNo
ICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogaW5pdGlh
bGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRNT0RfTElWRVBBVENIOiBwcmVfcGF0Y2hf
Y2FsbGJhY2s6IHZtbGludXgKQEAgLTQ3NSw3ICs0NzUsNyBAQCBsaXZlcGF0Y2g6ICckTU9E
X0xJVkVQQVRDSCc6IHN0YXJ0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxpdmVwYXRjaDog
JyRNT0RfTElWRVBBVENIJzogY29tcGxldGluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiAkTU9E
X0xJVkVQQVRDSDogcG9zdF9wYXRjaF9jYWxsYmFjazogdm1saW51eAogbGl2ZXBhdGNoOiAn
JE1PRF9MSVZFUEFUQ0gnOiBwYXRjaGluZyBjb21wbGV0ZQotJSBtb2Rwcm9iZSAkTU9EX0xJ
VkVQQVRDSDIKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQQVRDSDIua28KIGxp
dmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENIMicKIGxpdmVwYXRjaDog
JyRNT0RfTElWRVBBVENIMic6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiAk
TU9EX0xJVkVQQVRDSDI6IHByZV9wYXRjaF9jYWxsYmFjazogdm1saW51eApAQCAtNTIzLDcg
KzUyMyw3IEBAIGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gyCiB1bmxvYWRfbHAgJE1PRF9M
SVZFUEFUQ0gyCiB1bmxvYWRfbHAgJE1PRF9MSVZFUEFUQ0gKIAotY2hlY2tfcmVzdWx0ICIl
IG1vZHByb2JlICRNT0RfTElWRVBBVENICitjaGVja19yZXN1bHQgIiUgaW5zbW9kIHRlc3Rf
bW9kdWxlcy8kTU9EX0xJVkVQQVRDSC5rbwogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAn
JE1PRF9MSVZFUEFUQ0gnCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGluaXRpYWxp
emluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiAkTU9EX0xJVkVQQVRDSDogcHJlX3BhdGNoX2Nh
bGxiYWNrOiB2bWxpbnV4CkBAIC01MzEsNyArNTMxLDcgQEAgbGl2ZXBhdGNoOiAnJE1PRF9M
SVZFUEFUQ0gnOiBzdGFydGluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiBsaXZlcGF0Y2g6ICck
TU9EX0xJVkVQQVRDSCc6IGNvbXBsZXRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9M
SVZFUEFUQ0g6IHBvc3RfcGF0Y2hfY2FsbGJhY2s6IHZtbGludXgKIGxpdmVwYXRjaDogJyRN
T0RfTElWRVBBVENIJzogcGF0Y2hpbmcgY29tcGxldGUKLSUgbW9kcHJvYmUgJE1PRF9MSVZF
UEFUQ0gyIHJlcGxhY2U9MQorJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENI
Mi5rbyByZXBsYWNlPTEKIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBB
VENIMicKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIMic6IGluaXRpYWxpemluZyBwYXRj
aGluZyB0cmFuc2l0aW9uCiAkTU9EX0xJVkVQQVRDSDI6IHByZV9wYXRjaF9jYWxsYmFjazog
dm1saW51eApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNo
L3Rlc3QtZnRyYWNlLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rl
c3QtZnRyYWNlLnNoCmluZGV4IDgyNTU0MGE1MTk0ZC4uNzMwMjE4YmNlOTljIDEwMDc1NQot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1mdHJhY2Uuc2gK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3QtZnRyYWNlLnNo
CkBAIC0zNSw3ICszNSw3IEBAIGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gKIHVubG9hZF9s
cCAkTU9EX0xJVkVQQVRDSAogCiBjaGVja19yZXN1bHQgImxpdmVwYXRjaDoga2VybmVsLmZ0
cmFjZV9lbmFibGVkID0gMAotJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSAorJSBpbnNtb2Qg
dGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IGVuYWJsaW5nIHBh
dGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogaW5p
dGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxpdmVwYXRjaDogZmFpbGVkIHRvIHJl
Z2lzdGVyIGZ0cmFjZSBoYW5kbGVyIGZvciBmdW5jdGlvbiAnY21kbGluZV9wcm9jX3Nob3cn
ICgtMTYpCkBAIC00NCw5ICs0NCw5IEBAIGxpdmVwYXRjaDogZmFpbGVkIHRvIGVuYWJsZSBw
YXRjaCAnJE1PRF9MSVZFUEFUQ0gnCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGNh
bmNlbGluZyBwYXRjaGluZyB0cmFuc2l0aW9uLCBnb2luZyB0byB1bnBhdGNoCiBsaXZlcGF0
Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGNvbXBsZXRpbmcgdW5wYXRjaGluZyB0cmFuc2l0aW9u
CiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IHVucGF0Y2hpbmcgY29tcGxldGUKLW1v
ZHByb2JlOiBFUlJPUjogY291bGQgbm90IGluc2VydCAnJE1PRF9MSVZFUEFUQ0gnOiBEZXZp
Y2Ugb3IgcmVzb3VyY2UgYnVzeQoraW5zbW9kOiBFUlJPUjogY291bGQgbm90IGluc2VydCBt
b2R1bGUgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvOiBEZXZpY2Ugb3IgcmVzb3Vy
Y2UgYnVzeQogbGl2ZXBhdGNoOiBrZXJuZWwuZnRyYWNlX2VuYWJsZWQgPSAxCi0lIG1vZHBy
b2JlICRNT0RfTElWRVBBVENICislIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9MSVZFUEFU
Q0gua28KIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENIJwogbGl2
ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBpbml0aWFsaXppbmcgcGF0Y2hpbmcgdHJhbnNp
dGlvbgogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBzdGFydGluZyBwYXRjaGluZyB0
cmFuc2l0aW9uCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0
Y2gvdGVzdC1saXZlcGF0Y2guc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0
Y2gvdGVzdC1saXZlcGF0Y2guc2gKaW5kZXggNWZlNzlhYzM0YmUxLi5lMzQ1NWE2YjExNTgg
MTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0LWxp
dmVwYXRjaC5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVz
dC1saXZlcGF0Y2guc2gKQEAgLTMxLDcgKzMxLDcgQEAgaWYgW1sgIiQoY2F0IC9wcm9jL2Nt
ZGxpbmUpIiA9PSAiJE1PRF9MSVZFUEFUQ0g6IHRoaXMgaGFzIGJlZW4gbGl2ZSBwYXRjaGVk
IiBdXQogCWRpZSAibGl2ZXBhdGNoIGtzZWxmdGVzdChzKSBmYWlsZWQiCiBmaQogCi1jaGVj
a19yZXN1bHQgIiUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKK2NoZWNrX3Jlc3VsdCAiJSBp
bnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IGVuYWJs
aW5nIHBhdGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENI
JzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxpdmVwYXRjaDogJyRNT0Rf
TElWRVBBVENIJzogc3RhcnRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgpAQCAtNzUsMTQgKzc1
LDE0IEBAIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAogZ3JlcCAnbGl2ZSBwYXRjaGVkJyAv
cHJvYy9jbWRsaW5lID4gL2Rldi9rbXNnCiBncmVwICdsaXZlIHBhdGNoZWQnIC9wcm9jL21l
bWluZm8gPiAvZGV2L2ttc2cKIAotY2hlY2tfcmVzdWx0ICIlIG1vZHByb2JlICRNT0RfTElW
RVBBVENICitjaGVja19yZXN1bHQgIiUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQ
QVRDSC5rbwogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gnCiBs
aXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFu
c2l0aW9uCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IHN0YXJ0aW5nIHBhdGNoaW5n
IHRyYW5zaXRpb24KIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogY29tcGxldGluZyBw
YXRjaGluZyB0cmFuc2l0aW9uCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6IHBhdGNo
aW5nIGNvbXBsZXRlCiAkTU9EX0xJVkVQQVRDSDogdGhpcyBoYXMgYmVlbiBsaXZlIHBhdGNo
ZWQKLSUgbW9kcHJvYmUgJE1PRF9SRVBMQUNFIHJlcGxhY2U9MAorJSBpbnNtb2QgdGVzdF9t
b2R1bGVzLyRNT0RfUkVQTEFDRS5rbyByZXBsYWNlPTAKIGxpdmVwYXRjaDogZW5hYmxpbmcg
cGF0Y2ggJyRNT0RfUkVQTEFDRScKIGxpdmVwYXRjaDogJyRNT0RfUkVQTEFDRSc6IGluaXRp
YWxpemluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiBsaXZlcGF0Y2g6ICckTU9EX1JFUExBQ0Un
OiBzdGFydGluZyBwYXRjaGluZyB0cmFuc2l0aW9uCkBAIC0xMzUsMTQgKzEzNSwxNCBAQCB1
bmxvYWRfbHAgJE1PRF9SRVBMQUNFCiBncmVwICdsaXZlIHBhdGNoZWQnIC9wcm9jL2NtZGxp
bmUgPiAvZGV2L2ttc2cKIGdyZXAgJ2xpdmUgcGF0Y2hlZCcgL3Byb2MvbWVtaW5mbyA+IC9k
ZXYva21zZwogCi1jaGVja19yZXN1bHQgIiUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKK2No
ZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBs
aXZlcGF0Y2g6IGVuYWJsaW5nIHBhdGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDog
JyRNT0RfTElWRVBBVENIJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxp
dmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogc3RhcnRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlv
bgogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBjb21wbGV0aW5nIHBhdGNoaW5nIHRy
YW5zaXRpb24KIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIJzogcGF0Y2hpbmcgY29tcGxl
dGUKICRNT0RfTElWRVBBVENIOiB0aGlzIGhhcyBiZWVuIGxpdmUgcGF0Y2hlZAotJSBtb2Rw
cm9iZSAkTU9EX1JFUExBQ0UgcmVwbGFjZT0xCislIGluc21vZCB0ZXN0X21vZHVsZXMvJE1P
RF9SRVBMQUNFLmtvIHJlcGxhY2U9MQogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1P
RF9SRVBMQUNFJwogbGl2ZXBhdGNoOiAnJE1PRF9SRVBMQUNFJzogaW5pdGlhbGl6aW5nIHBh
dGNoaW5nIHRyYW5zaXRpb24KIGxpdmVwYXRjaDogJyRNT0RfUkVQTEFDRSc6IHN0YXJ0aW5n
IHBhdGNoaW5nIHRyYW5zaXRpb24KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2xpdmVwYXRjaC90ZXN0LXNoYWRvdy12YXJzLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbGl2ZXBhdGNoL3Rlc3Qtc2hhZG93LXZhcnMuc2gKaW5kZXggZTA0Y2IzNTRmNTZi
Li4xMjE4YzE1NWJmZmUgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xp
dmVwYXRjaC90ZXN0LXNoYWRvdy12YXJzLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2xpdmVwYXRjaC90ZXN0LXNoYWRvdy12YXJzLnNoCkBAIC0xNiw3ICsxNiw3IEBAIHN0
YXJ0X3Rlc3QgImJhc2ljIHNoYWRvdyB2YXJpYWJsZSBBUEkiCiBsb2FkX21vZCAkTU9EX1RF
U1QKIHVubG9hZF9tb2QgJE1PRF9URVNUCiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9iZSAk
TU9EX1RFU1QKK2NoZWNrX3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfVEVT
VC5rbwogJE1PRF9URVNUOiBrbHBfc2hhZG93X2dldChvYmo9UFRSMSwgaWQ9MHgxMjM0KSA9
IFBUUjAKICRNT0RfVEVTVDogICBnb3QgZXhwZWN0ZWQgTlVMTCByZXN1bHQKICRNT0RfVEVT
VDogc2hhZG93X2N0b3I6IFBUUjMgLT4gUFRSMgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3Qtc3RhdGUuc2ggYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zdGF0ZS5zaAppbmRleCAzODY1NjcyMWM5NTguLjEw
YTUyYWMwNjE4NSAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBh
dGNoL3Rlc3Qtc3RhdGUuc2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBh
dGNoL3Rlc3Qtc3RhdGUuc2gKQEAgLTE5LDcgKzE5LDcgQEAgbG9hZF9scCAkTU9EX0xJVkVQ
QVRDSAogZGlzYWJsZV9scCAkTU9EX0xJVkVQQVRDSAogdW5sb2FkX2xwICRNT0RfTElWRVBB
VENICiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSAorY2hlY2tf
cmVzdWx0ICIlIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9MSVZFUEFUQ0gua28KIGxpdmVw
YXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENIJwogbGl2ZXBhdGNoOiAnJE1P
RF9MSVZFUEFUQ0gnOiBpbml0aWFsaXppbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9M
SVZFUEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazogdm1saW51eApAQCAtNTEsNyArNTEsNyBA
QCB1bmxvYWRfbHAgJE1PRF9MSVZFUEFUQ0gKIGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gy
CiB1bmxvYWRfbHAgJE1PRF9MSVZFUEFUQ0gyCiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9i
ZSAkTU9EX0xJVkVQQVRDSAorY2hlY2tfcmVzdWx0ICIlIGluc21vZCB0ZXN0X21vZHVsZXMv
JE1PRF9MSVZFUEFUQ0gua28KIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElW
RVBBVENIJwogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gnOiBpbml0aWFsaXppbmcgcGF0
Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHByZV9wYXRjaF9jYWxsYmFjazog
dm1saW51eApAQCAtNjEsNyArNjEsNyBAQCBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSCc6
IGNvbXBsZXRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0g6IHBvc3Rf
cGF0Y2hfY2FsbGJhY2s6IHZtbGludXgKICRNT0RfTElWRVBBVENIOiBmaXhfY29uc29sZV9s
b2dsZXZlbDogZml4aW5nIGNvbnNvbGVfbG9nbGV2ZWwKIGxpdmVwYXRjaDogJyRNT0RfTElW
RVBBVENIJzogcGF0Y2hpbmcgY29tcGxldGUKLSUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gy
CislIGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9MSVZFUEFUQ0gyLmtvCiBsaXZlcGF0Y2g6
IGVuYWJsaW5nIHBhdGNoICckTU9EX0xJVkVQQVRDSDInCiBsaXZlcGF0Y2g6ICckTU9EX0xJ
VkVQQVRDSDInOiBpbml0aWFsaXppbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZF
UEFUQ0gyOiBwcmVfcGF0Y2hfY2FsbGJhY2s6IHZtbGludXgKQEAgLTk2LDcgKzk2LDcgQEAg
ZGlzYWJsZV9scCAkTU9EX0xJVkVQQVRDSDIKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSDIK
IHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSDMKIAotY2hlY2tfcmVzdWx0ICIlIG1vZHByb2Jl
ICRNT0RfTElWRVBBVENIMgorY2hlY2tfcmVzdWx0ICIlIGluc21vZCB0ZXN0X21vZHVsZXMv
JE1PRF9MSVZFUEFUQ0gyLmtvCiBsaXZlcGF0Y2g6IGVuYWJsaW5nIHBhdGNoICckTU9EX0xJ
VkVQQVRDSDInCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSDInOiBpbml0aWFsaXppbmcg
cGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0gyOiBwcmVfcGF0Y2hfY2FsbGJh
Y2s6IHZtbGludXgKQEAgLTEwNiw3ICsxMDYsNyBAQCBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQ
QVRDSDInOiBjb21wbGV0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRNT0RfTElWRVBBVENI
MjogcG9zdF9wYXRjaF9jYWxsYmFjazogdm1saW51eAogJE1PRF9MSVZFUEFUQ0gyOiBmaXhf
Y29uc29sZV9sb2dsZXZlbDogZml4aW5nIGNvbnNvbGVfbG9nbGV2ZWwKIGxpdmVwYXRjaDog
JyRNT0RfTElWRVBBVENIMic6IHBhdGNoaW5nIGNvbXBsZXRlCi0lIG1vZHByb2JlICRNT0Rf
TElWRVBBVENIMworJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENIMy5rbwog
bGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gzJwogbGl2ZXBhdGNo
OiAnJE1PRF9MSVZFUEFUQ0gzJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24K
ICRNT0RfTElWRVBBVENIMzogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CkBAIC0xMTcs
NyArMTE3LDcgQEAgJE1PRF9MSVZFUEFUQ0gzOiBwb3N0X3BhdGNoX2NhbGxiYWNrOiB2bWxp
bnV4CiAkTU9EX0xJVkVQQVRDSDM6IGZpeF9jb25zb2xlX2xvZ2xldmVsOiB0YWtpbmcgb3Zl
ciB0aGUgY29uc29sZV9sb2dsZXZlbCBjaGFuZ2UKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBB
VENIMyc6IHBhdGNoaW5nIGNvbXBsZXRlCiAlIHJtbW9kICRNT0RfTElWRVBBVENIMgotJSBt
b2Rwcm9iZSAkTU9EX0xJVkVQQVRDSDIKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy8kTU9EX0xJ
VkVQQVRDSDIua28KIGxpdmVwYXRjaDogZW5hYmxpbmcgcGF0Y2ggJyRNT0RfTElWRVBBVENI
MicKIGxpdmVwYXRjaDogJyRNT0RfTElWRVBBVENIMic6IGluaXRpYWxpemluZyBwYXRjaGlu
ZyB0cmFuc2l0aW9uCiAkTU9EX0xJVkVQQVRDSDI6IHByZV9wYXRjaF9jYWxsYmFjazogdm1s
aW51eApAQCAtMTQ5LDcgKzE0OSw3IEBAIGxvYWRfZmFpbGluZ19tb2QgJE1PRF9MSVZFUEFU
Q0gKIGRpc2FibGVfbHAgJE1PRF9MSVZFUEFUQ0gyCiB1bmxvYWRfbHAgJE1PRF9MSVZFUEFU
Q0gyCiAKLWNoZWNrX3Jlc3VsdCAiJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSDIKK2NoZWNr
X3Jlc3VsdCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENIMi5rbwogbGl2
ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9MSVZFUEFUQ0gyJwogbGl2ZXBhdGNoOiAn
JE1PRF9MSVZFUEFUQ0gyJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KICRN
T0RfTElWRVBBVENIMjogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CkBAIC0xNTksOSAr
MTU5LDkgQEAgbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gyJzogY29tcGxldGluZyBwYXRj
aGluZyB0cmFuc2l0aW9uCiAkTU9EX0xJVkVQQVRDSDI6IHBvc3RfcGF0Y2hfY2FsbGJhY2s6
IHZtbGludXgKICRNT0RfTElWRVBBVENIMjogZml4X2NvbnNvbGVfbG9nbGV2ZWw6IGZpeGlu
ZyBjb25zb2xlX2xvZ2xldmVsCiBsaXZlcGF0Y2g6ICckTU9EX0xJVkVQQVRDSDInOiBwYXRj
aGluZyBjb21wbGV0ZQotJSBtb2Rwcm9iZSAkTU9EX0xJVkVQQVRDSAorJSBpbnNtb2QgdGVz
dF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6IExpdmVwYXRjaCBwYXRj
aCAoJE1PRF9MSVZFUEFUQ0gpIGlzIG5vdCBjb21wYXRpYmxlIHdpdGggdGhlIGFscmVhZHkg
aW5zdGFsbGVkIGxpdmVwYXRjaGVzLgotbW9kcHJvYmU6IEVSUk9SOiBjb3VsZCBub3QgaW5z
ZXJ0ICckTU9EX0xJVkVQQVRDSCc6IEludmFsaWQgYXJndW1lbnQKK2luc21vZDogRVJST1I6
IGNvdWxkIG5vdCBpbnNlcnQgbW9kdWxlIHRlc3RfbW9kdWxlcy8kTU9EX0xJVkVQQVRDSC5r
bzogSW52YWxpZCBwYXJhbWV0ZXJzCiAlIGVjaG8gMCA+IC9zeXMva2VybmVsL2xpdmVwYXRj
aC8kTU9EX0xJVkVQQVRDSDIvZW5hYmxlZAogbGl2ZXBhdGNoOiAnJE1PRF9MSVZFUEFUQ0gy
JzogaW5pdGlhbGl6aW5nIHVucGF0Y2hpbmcgdHJhbnNpdGlvbgogJE1PRF9MSVZFUEFUQ0gy
OiBwcmVfdW5wYXRjaF9jYWxsYmFjazogdm1saW51eApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3Qtc3lzY2FsbC5zaCBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0LXN5c2NhbGwuc2gKbmV3IGZpbGUgbW9kZSAx
MDA3NTUKaW5kZXggMDAwMDAwMDAwMDAwLi5iNzZhODgxZDQwMTMKLS0tIC9kZXYvbnVsbAor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zeXNjYWxsLnNo
CkBAIC0wLDAgKzEsNTMgQEAKKyMhL2Jpbi9iYXNoCisjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wCisjIENvcHlyaWdodCAoQykgMjAyMyBTVVNFCisjIEF1dGhvcjogTWFy
Y29zIFBhdWxvIGRlIFNvdXphIDxtcGRlc291emFAc3VzZS5jb20+CisKKy4gJChkaXJuYW1l
ICQwKS9mdW5jdGlvbnMuc2gKKworTU9EX1NZU0NBTEw9dGVzdF9rbHBfc3lzY2FsbAorCitz
ZXR1cF9jb25maWcKKworIyAtIFN0YXJ0IF9OUlBST0MgcHJvY2Vzc2VzIGNhbGxpbmcgZ2V0
cGlkIGFuZCBsb2FkIGEgbGl2ZXBhdGNoIHRvIHBhdGNoIHRoZQorIyAgIGdldHBpZCBzeXNj
YWxsLiBDaGVjayBpZiBhbGwgdGhlIHByb2Nlc3NlcyB0cmFuc2l0aW9uZWQgdG8gdGhlIGxp
dmVwYXRjaGVkCisjICAgc3RhdGUuCisKK3N0YXJ0X3Rlc3QgInBhdGNoIGdldHBpZCBzeXNj
YWxsIHdoaWxlIGJlaW5nIGhlYXZpbHkgaGFtbWVyZWQiCisKK2ZvciBpIGluICQoc2VxIDEg
JChnZXRjb25mIF9OUFJPQ0VTU09SU19PTkxOKSk7IGRvCisJLi90ZXN0X2tscC1jYWxsX2dl
dHBpZCAmCisJcGlkc1skaV09IiQhIgorZG9uZQorCitwaWRfbGlzdD0kKGVjaG8gJHtwaWRz
W0BdfSB8IHRyICcgJyAnLCcpCitsb2FkX2xwICRNT0RfU1lTQ0FMTCBrbHBfcGlkcz0kcGlk
X2xpc3QKKworIyB3YWl0IGZvciBhbGwgdGFza3MgdG8gdHJhbnNpdGlvbiB0byBwYXRjaGVk
IHN0YXRlCitsb29wX3VudGlsICdncmVwIC1xICdeMCQnIC9zeXMva2VybmVsL3Rlc3Rfa2xw
X3N5c2NhbGwvbnBpZHMnCisKK3BlbmRpbmdfcGlkcz0kKGNhdCAvc3lzL2tlcm5lbC90ZXN0
X2tscF9zeXNjYWxsL25waWRzKQorbG9nICIkTU9EX1NZU0NBTEw6IFJlbWFpbmluZyBub3Qg
bGl2ZXBhdGNoZWQgcHJvY2Vzc2VzOiAkcGVuZGluZ19waWRzIgorCitmb3IgcGlkIGluICR7
cGlkc1tAXX07IGRvCisJa2lsbCAkcGlkIHx8IHRydWUKK2RvbmUKKworZGlzYWJsZV9scCAk
TU9EX1NZU0NBTEwKK3VubG9hZF9scCAkTU9EX1NZU0NBTEwKKworY2hlY2tfcmVzdWx0ICIl
IGluc21vZCB0ZXN0X21vZHVsZXMvJE1PRF9TWVNDQUxMLmtvIGtscF9waWRzPSRwaWRfbGlz
dAorbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAnJE1PRF9TWVNDQUxMJworbGl2ZXBhdGNo
OiAnJE1PRF9TWVNDQUxMJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KK2xp
dmVwYXRjaDogJyRNT0RfU1lTQ0FMTCc6IHN0YXJ0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24K
K2xpdmVwYXRjaDogJyRNT0RfU1lTQ0FMTCc6IGNvbXBsZXRpbmcgcGF0Y2hpbmcgdHJhbnNp
dGlvbgorbGl2ZXBhdGNoOiAnJE1PRF9TWVNDQUxMJzogcGF0Y2hpbmcgY29tcGxldGUKKyRN
T0RfU1lTQ0FMTDogUmVtYWluaW5nIG5vdCBsaXZlcGF0Y2hlZCBwcm9jZXNzZXM6IDAKKyUg
ZWNobyAwID4gL3N5cy9rZXJuZWwvbGl2ZXBhdGNoLyRNT0RfU1lTQ0FMTC9lbmFibGVkCits
aXZlcGF0Y2g6ICckTU9EX1NZU0NBTEwnOiBpbml0aWFsaXppbmcgdW5wYXRjaGluZyB0cmFu
c2l0aW9uCitsaXZlcGF0Y2g6ICckTU9EX1NZU0NBTEwnOiBzdGFydGluZyB1bnBhdGNoaW5n
IHRyYW5zaXRpb24KK2xpdmVwYXRjaDogJyRNT0RfU1lTQ0FMTCc6IGNvbXBsZXRpbmcgdW5w
YXRjaGluZyB0cmFuc2l0aW9uCitsaXZlcGF0Y2g6ICckTU9EX1NZU0NBTEwnOiB1bnBhdGNo
aW5nIGNvbXBsZXRlCislIHJtbW9kICRNT0RfU1lTQ0FMTCIKKworZXhpdCAwCmRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zeXNmcy5zaCBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0LXN5c2ZzLnNoCmluZGV4
IDdmNzZmMjgwMTg5YS4uNmM2NDZhZmE3Mzk1IDEwMDc1NQotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zeXNmcy5zaAorKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdC1zeXNmcy5zaApAQCAtMjcsNyArMjcsNyBAQCBk
aXNhYmxlX2xwICRNT0RfTElWRVBBVENICiAKIHVubG9hZF9scCAkTU9EX0xJVkVQQVRDSAog
Ci1jaGVja19yZXN1bHQgIiUgbW9kcHJvYmUgJE1PRF9MSVZFUEFUQ0gKK2NoZWNrX3Jlc3Vs
dCAiJSBpbnNtb2QgdGVzdF9tb2R1bGVzLyRNT0RfTElWRVBBVENILmtvCiBsaXZlcGF0Y2g6
IGVuYWJsaW5nIHBhdGNoICckTU9EX0xJVkVQQVRDSCcKIGxpdmVwYXRjaDogJyRNT0RfTElW
RVBBVENIJzogaW5pdGlhbGl6aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIGxpdmVwYXRjaDog
JyRNT0RfTElWRVBBVENIJzogc3RhcnRpbmcgcGF0Y2hpbmcgdHJhbnNpdGlvbgpAQCAtNTYs
NyArNTYsNyBAQCBjaGVja19zeXNmc192YWx1ZSAgIiRNT0RfTElWRVBBVENIIiAiJE1PRF9U
QVJHRVQvcGF0Y2hlZCIgIjAiCiBkaXNhYmxlX2xwICRNT0RfTElWRVBBVENICiB1bmxvYWRf
bHAgJE1PRF9MSVZFUEFUQ0gKIAotY2hlY2tfcmVzdWx0ICIlIG1vZHByb2JlIHRlc3Rfa2xw
X2NhbGxiYWNrc19kZW1vCitjaGVja19yZXN1bHQgIiUgaW5zbW9kIHRlc3RfbW9kdWxlcy90
ZXN0X2tscF9jYWxsYmFja3NfZGVtby5rbwogbGl2ZXBhdGNoOiBlbmFibGluZyBwYXRjaCAn
dGVzdF9rbHBfY2FsbGJhY2tzX2RlbW8nCiBsaXZlcGF0Y2g6ICd0ZXN0X2tscF9jYWxsYmFj
a3NfZGVtbyc6IGluaXRpYWxpemluZyBwYXRjaGluZyB0cmFuc2l0aW9uCiB0ZXN0X2tscF9j
YWxsYmFja3NfZGVtbzogcHJlX3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CkBAIC02NCw3ICs2
NCw3IEBAIGxpdmVwYXRjaDogJ3Rlc3Rfa2xwX2NhbGxiYWNrc19kZW1vJzogc3RhcnRpbmcg
cGF0Y2hpbmcgdHJhbnNpdGlvbgogbGl2ZXBhdGNoOiAndGVzdF9rbHBfY2FsbGJhY2tzX2Rl
bW8nOiBjb21wbGV0aW5nIHBhdGNoaW5nIHRyYW5zaXRpb24KIHRlc3Rfa2xwX2NhbGxiYWNr
c19kZW1vOiBwb3N0X3BhdGNoX2NhbGxiYWNrOiB2bWxpbnV4CiBsaXZlcGF0Y2g6ICd0ZXN0
X2tscF9jYWxsYmFja3NfZGVtbyc6IHBhdGNoaW5nIGNvbXBsZXRlCi0lIG1vZHByb2JlIHRl
c3Rfa2xwX2NhbGxiYWNrc19tb2QKKyUgaW5zbW9kIHRlc3RfbW9kdWxlcy90ZXN0X2tscF9j
YWxsYmFja3NfbW9kLmtvCiBsaXZlcGF0Y2g6IGFwcGx5aW5nIHBhdGNoICd0ZXN0X2tscF9j
YWxsYmFja3NfZGVtbycgdG8gbG9hZGluZyBtb2R1bGUgJ3Rlc3Rfa2xwX2NhbGxiYWNrc19t
b2QnCiB0ZXN0X2tscF9jYWxsYmFja3NfZGVtbzogcHJlX3BhdGNoX2NhbGxiYWNrOiB0ZXN0
X2tscF9jYWxsYmFja3NfbW9kIC0+IFtNT0RVTEVfU1RBVEVfQ09NSU5HXSBGdWxsIGZvcm1l
ZCwgcnVubmluZyBtb2R1bGVfaW5pdAogdGVzdF9rbHBfY2FsbGJhY2tzX2RlbW86IHBvc3Rf
cGF0Y2hfY2FsbGJhY2s6IHRlc3Rfa2xwX2NhbGxiYWNrc19tb2QgLT4gW01PRFVMRV9TVEFU
RV9DT01JTkddIEZ1bGwgZm9ybWVkLCBydW5uaW5nIG1vZHVsZV9pbml0CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9rbHAtY2FsbF9nZXRw
aWQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0X2tscC1jYWxs
X2dldHBpZC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uY2Uz
MjFhMmQ3MzA4Ci0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bGl2ZXBhdGNoL3Rlc3Rfa2xwLWNhbGxfZ2V0cGlkLmMKQEAgLTAsMCArMSw0NCBAQAorLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKy8qCisgKiBDb3B5cmlnaHQgKEMp
IDIwMjMgU1VTRQorICogQXV0aG9yczogTGlib3IgUGVjaGFjZWsgPGxwZWNoYWNla0BzdXNl
LmN6PgorICogICAgICAgICAgTWFyY29zIFBhdWxvIGRlIFNvdXphIDxtcGRlc291emFAc3Vz
ZS5jb20+CisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+
CisjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNp
bmNsdWRlIDxzaWduYWwuaD4KKworc3RhdGljIGludCBzdG9wOworc3RhdGljIGludCBzaWdf
aW50OworCit2b2lkIGh1cF9oYW5kbGVyKGludCBzaWdudW0pCit7CisJc3RvcCA9IDE7Cit9
CisKK3ZvaWQgaW50X2hhbmRsZXIoaW50IHNpZ251bSkKK3sKKwlzdG9wID0gMTsKKwlzaWdf
aW50ID0gMTsKK30KKworaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKK3sKKwls
b25nIGNvdW50ID0gMDsKKworCXNpZ25hbChTSUdIVVAsICZodXBfaGFuZGxlcik7CisJc2ln
bmFsKFNJR0lOVCwgJmludF9oYW5kbGVyKTsKKworCXdoaWxlICghc3RvcCkgeworCQkodm9p
ZClzeXNjYWxsKFNZU19nZXRwaWQpOworCQljb3VudCsrOworCX0KKworCWlmIChzaWdfaW50
KQorCQlwcmludGYoIiVsZCBpdGVyYXRpb25zIGRvbmVcbiIsIGNvdW50KTsKKworCXJldHVy
biAwOworfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNo
L3Rlc3RfbW9kdWxlcy9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVw
YXRjaC90ZXN0X21vZHVsZXMvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwMDAwLi5lNmU2MzhjNGJjYmEKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL01ha2VmaWxlCkBAIC0w
LDAgKzEsMjYgQEAKK1RFU1RNT0RTX0RJUiA6PSAkKHJlYWxwYXRoICQoZGlyICQoYWJzcGF0
aCAkKGxhc3R3b3JkICQoTUFLRUZJTEVfTElTVCkpKSkpCitLRElSID89IC9saWIvbW9kdWxl
cy8kKHNoZWxsIHVuYW1lIC1yKS9idWlsZAorCitvYmotbSArPSB0ZXN0X2tscF9hdG9taWNf
cmVwbGFjZS5vIFwKKwl0ZXN0X2tscF9jYWxsYmFja3NfYnVzeS5vIFwKKwl0ZXN0X2tscF9j
YWxsYmFja3NfZGVtby5vIFwKKwl0ZXN0X2tscF9jYWxsYmFja3NfZGVtbzIubyBcCisJdGVz
dF9rbHBfY2FsbGJhY2tzX21vZC5vIFwKKwl0ZXN0X2tscF9saXZlcGF0Y2gubyBcCisJdGVz
dF9rbHBfc3RhdGUubyBcCisJdGVzdF9rbHBfc3RhdGUyLm8gXAorCXRlc3Rfa2xwX3N0YXRl
My5vIFwKKwl0ZXN0X2tscF9zaGFkb3dfdmFycy5vIFwKKwl0ZXN0X2tscF9zeXNjYWxsLm8K
KworIyBFbnN1cmUgdGhhdCBLRElSIGV4aXN0cywgb3RoZXJ3aXNlIHNraXAgdGhlIGNvbXBp
bGF0aW9uCittb2R1bGVzOgoraWZuZXEgKCIkKHdpbGRjYXJkICQoS0RJUikpIiwgIiIpCisJ
JChRKSQoTUFLRSkgLUMgJChLRElSKSBtb2R1bGVzIEtCVUlMRF9FWFRNT0Q9JChURVNUTU9E
U19ESVIpCitlbmRpZgorCisjIEVuc3VyZSB0aGF0IEtESVIgZXhpc3RzLCBvdGhlcndpc2Ug
c2tpcCB0aGUgY2xlYW4gdGFyZ2V0CitjbGVhbjoKK2lmbmVxICgiJCh3aWxkY2FyZCAkKEtE
SVIpKSIsICIiKQorCSQoUSkkKE1BS0UpIC1DICQoS0RJUikgY2xlYW4gS0JVSUxEX0VYVE1P
RD0kKFRFU1RNT0RTX0RJUikKK2VuZGlmCmRpZmYgLS1naXQgYS9saWIvbGl2ZXBhdGNoL3Rl
c3Rfa2xwX2F0b21pY19yZXBsYWNlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZl
cGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rfa2xwX2F0b21pY19yZXBsYWNlLmMKc2ltaWxhcml0
eSBpbmRleCAxMDAlCnJlbmFtZSBmcm9tIGxpYi9saXZlcGF0Y2gvdGVzdF9rbHBfYXRvbWlj
X3JlcGxhY2UuYwpyZW5hbWUgdG8gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNo
L3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9hdG9taWNfcmVwbGFjZS5jCmRpZmYgLS1naXQgYS9s
aWIvbGl2ZXBhdGNoL3Rlc3Rfa2xwX2NhbGxiYWNrc19idXN5LmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rfa2xwX2NhbGxiYWNrc19i
dXN5LmMKc2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFtZSBmcm9tIGxpYi9saXZlcGF0Y2gv
dGVzdF9rbHBfY2FsbGJhY2tzX2J1c3kuYwpyZW5hbWUgdG8gdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9jYWxsYmFja3NfYnVzeS5j
CmRpZmYgLS1naXQgYS9saWIvbGl2ZXBhdGNoL3Rlc3Rfa2xwX2NhbGxiYWNrc19kZW1vLmMg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rf
a2xwX2NhbGxiYWNrc19kZW1vLmMKc2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFtZSBmcm9t
IGxpYi9saXZlcGF0Y2gvdGVzdF9rbHBfY2FsbGJhY2tzX2RlbW8uYwpyZW5hbWUgdG8gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9j
YWxsYmFja3NfZGVtby5jCmRpZmYgLS1naXQgYS9saWIvbGl2ZXBhdGNoL3Rlc3Rfa2xwX2Nh
bGxiYWNrc19kZW1vMi5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rl
c3RfbW9kdWxlcy90ZXN0X2tscF9jYWxsYmFja3NfZGVtbzIuYwpzaW1pbGFyaXR5IGluZGV4
IDEwMCUKcmVuYW1lIGZyb20gbGliL2xpdmVwYXRjaC90ZXN0X2tscF9jYWxsYmFja3NfZGVt
bzIuYwpyZW5hbWUgdG8gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3Rf
bW9kdWxlcy90ZXN0X2tscF9jYWxsYmFja3NfZGVtbzIuYwpkaWZmIC0tZ2l0IGEvbGliL2xp
dmVwYXRjaC90ZXN0X2tscF9jYWxsYmFja3NfbW9kLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rfa2xwX2NhbGxiYWNrc19tb2QuYwpz
aW1pbGFyaXR5IGluZGV4IDEwMCUKcmVuYW1lIGZyb20gbGliL2xpdmVwYXRjaC90ZXN0X2ts
cF9jYWxsYmFja3NfbW9kLmMKcmVuYW1lIHRvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xp
dmVwYXRjaC90ZXN0X21vZHVsZXMvdGVzdF9rbHBfY2FsbGJhY2tzX21vZC5jCmRpZmYgLS1n
aXQgYS9saWIvbGl2ZXBhdGNoL3Rlc3Rfa2xwX2xpdmVwYXRjaC5jIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9saXZlcGF0Y2gu
YwpzaW1pbGFyaXR5IGluZGV4IDEwMCUKcmVuYW1lIGZyb20gbGliL2xpdmVwYXRjaC90ZXN0
X2tscF9saXZlcGF0Y2guYwpyZW5hbWUgdG8gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGl2
ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9saXZlcGF0Y2guYwpkaWZmIC0tZ2l0IGEv
bGliL2xpdmVwYXRjaC90ZXN0X2tscF9zaGFkb3dfdmFycy5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9zaGFkb3dfdmFycy5j
CnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSBsaWIvbGl2ZXBhdGNoL3Rlc3Rf
a2xwX3NoYWRvd192YXJzLmMKcmVuYW1lIHRvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xp
dmVwYXRjaC90ZXN0X21vZHVsZXMvdGVzdF9rbHBfc2hhZG93X3ZhcnMuYwpkaWZmIC0tZ2l0
IGEvbGliL2xpdmVwYXRjaC90ZXN0X2tscF9zdGF0ZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9zdGF0ZS5jCnNpbWlsYXJp
dHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSBsaWIvbGl2ZXBhdGNoL3Rlc3Rfa2xwX3N0YXRl
LmMKcmVuYW1lIHRvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0X21v
ZHVsZXMvdGVzdF9rbHBfc3RhdGUuYwpkaWZmIC0tZ2l0IGEvbGliL2xpdmVwYXRjaC90ZXN0
X2tscF9zdGF0ZTIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0
X21vZHVsZXMvdGVzdF9rbHBfc3RhdGUyLmMKc2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFt
ZSBmcm9tIGxpYi9saXZlcGF0Y2gvdGVzdF9rbHBfc3RhdGUyLmMKcmVuYW1lIHRvIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0X21vZHVsZXMvdGVzdF9rbHBfc3Rh
dGUyLmMKZGlmZiAtLWdpdCBhL2xpYi9saXZlcGF0Y2gvdGVzdF9rbHBfc3RhdGUzLmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rfa2xw
X3N0YXRlMy5jCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpyZW5hbWUgZnJvbSBsaWIvbGl2ZXBh
dGNoL3Rlc3Rfa2xwX3N0YXRlMy5jCnJlbmFtZSB0byB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rfa2xwX3N0YXRlMy5jCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvdGVzdF9tb2R1bGVzL3Rlc3Rf
a2xwX3N5c2NhbGwuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpdmVwYXRjaC90ZXN0
X21vZHVsZXMvdGVzdF9rbHBfc3lzY2FsbC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAwMDAwMC4uZGQ4MDI3ODNlYTg0Ci0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbGl2ZXBhdGNoL3Rlc3RfbW9kdWxlcy90ZXN0X2tscF9zeXNj
YWxsLmMKQEAgLTAsMCArMSwxMTYgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wCisvKgorICogQ29weXJpZ2h0IChDKSAyMDE3LTIwMjMgU1VTRQorICogQXV0aG9y
czogTGlib3IgUGVjaGFjZWsgPGxwZWNoYWNla0BzdXNlLmN6PgorICogICAgICAgICAgTmlj
b2xhaSBTdGFuZ2UgPG5zdGFuZ2VAc3VzZS5kZT4KKyAqICAgICAgICAgIE1hcmNvcyBQYXVs
byBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPgorICovCisKKyNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51
eC9zY2hlZC5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9s
aXZlcGF0Y2guaD4KKworI2lmIGRlZmluZWQoX194ODZfNjRfXykKKyNkZWZpbmUgRk5fUFJF
RklYIF9feDY0XworI2VsaWYgZGVmaW5lZChfX3MzOTB4X18pCisjZGVmaW5lIEZOX1BSRUZJ
WCBfX3MzOTB4XworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgRk5fUFJF
RklYIF9fYXJtNjRfCisjZWxzZQorLyogcG93ZXJwYyBkb2VzIG5vdCBzZWxlY3QgQVJDSF9I
QVNfU1lTQ0FMTF9XUkFQUEVSICovCisjZGVmaW5lIEZOX1BSRUZJWAorI2VuZGlmCisKKy8q
IFByb3RlY3RzIGtscF9waWRzICovCitzdGF0aWMgREVGSU5FX01VVEVYKGtwaWRfbXV0ZXgp
OworCitzdGF0aWMgdW5zaWduZWQgaW50IG5waWRzLCBucGlkc19wZW5kaW5nOworc3RhdGlj
IGludCBrbHBfcGlkc1tOUl9DUFVTXTsKK21vZHVsZV9wYXJhbV9hcnJheShrbHBfcGlkcywg
aW50LCAmbnBpZHNfcGVuZGluZywgMCk7CitNT0RVTEVfUEFSTV9ERVNDKGtscF9waWRzLCAi
QXJyYXkgb2YgcGlkcyB0byBiZSB0cmFuc2l0aW9uZWQgdG8gbGl2ZXBhdGNoZWQgc3RhdGUu
Iik7CisKK3N0YXRpYyBzc2l6ZV90IG5waWRzX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmos
IHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwKKwkJCSAgY2hhciAqYnVmKQoreworCXJl
dHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBucGlkc19wZW5kaW5nKTsKK30KKworc3RhdGlj
IHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSBrbHBfYXR0ciA9IF9fQVRUUl9STyhucGlkcyk7Citz
dGF0aWMgc3RydWN0IGtvYmplY3QgKmtscF9rb2JqOworCitzdGF0aWMgYXNtbGlua2FnZSBs
b25nIGxwX3N5c19nZXRwaWQodm9pZCkKK3sKKwlpbnQgaTsKKworCW11dGV4X2xvY2soJmtw
aWRfbXV0ZXgpOworCWlmIChucGlkc19wZW5kaW5nID4gMCkgeworCQlmb3IgKGkgPSAwOyBp
IDwgbnBpZHM7IGkrKykgeworCQkJaWYgKGN1cnJlbnQtPnBpZCA9PSBrbHBfcGlkc1tpXSkg
eworCQkJCWtscF9waWRzW2ldID0gMDsKKwkJCQlucGlkc19wZW5kaW5nLS07CisJCQkJYnJl
YWs7CisJCQl9CisJCX0KKwl9CisJbXV0ZXhfdW5sb2NrKCZrcGlkX211dGV4KTsKKworCXJl
dHVybiB0YXNrX3RnaWRfdm5yKGN1cnJlbnQpOworfQorCitzdGF0aWMgc3RydWN0IGtscF9m
dW5jIHZtbGludXhfZnVuY3NbXSA9IHsKKwl7CisJCS5vbGRfbmFtZSA9IF9fc3RyaW5naWZ5
KEZOX1BSRUZJWCkgInN5c19nZXRwaWQiLAorCQkubmV3X2Z1bmMgPSBscF9zeXNfZ2V0cGlk
LAorCX0sIHt9Cit9OworCitzdGF0aWMgc3RydWN0IGtscF9vYmplY3Qgb2Jqc1tdID0gewor
CXsKKwkJLyogbmFtZSBiZWluZyBOVUxMIG1lYW5zIHZtbGludXggKi8KKwkJLmZ1bmNzID0g
dm1saW51eF9mdW5jcywKKwl9LCB7fQorfTsKKworc3RhdGljIHN0cnVjdCBrbHBfcGF0Y2gg
cGF0Y2ggPSB7CisJLm1vZCA9IFRISVNfTU9EVUxFLAorCS5vYmpzID0gb2JqcywKK307CisK
K3N0YXRpYyBpbnQgbGl2ZXBhdGNoX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0OworCisJa2xw
X2tvYmogPSBrb2JqZWN0X2NyZWF0ZV9hbmRfYWRkKCJ0ZXN0X2tscF9zeXNjYWxsIiwga2Vy
bmVsX2tvYmopOworCWlmICgha2xwX2tvYmopCisJCXJldHVybiAtRU5PTUVNOworCisJcmV0
ID0gc3lzZnNfY3JlYXRlX2ZpbGUoa2xwX2tvYmosICZrbHBfYXR0ci5hdHRyKTsKKwlpZiAo
cmV0KSB7CisJCWtvYmplY3RfcHV0KGtscF9rb2JqKTsKKwkJcmV0dXJuIHJldDsKKwl9CisK
KwkvKgorCSAqIFNhdmUgdGhlIG51bWJlciBwaWRzIHRvIHRyYW5zaXRpb24gdG8gbGl2ZXBh
dGNoZWQgc3RhdGUgYmVmb3JlIHRoZQorCSAqIG51bWJlciBvZiBwZW5kaW5nIHBpZHMgaXMg
ZGVjcmVtZW50ZWQuCisJICovCisJbnBpZHMgPSBucGlkc19wZW5kaW5nOworCisJcmV0dXJu
IGtscF9lbmFibGVfcGF0Y2goJnBhdGNoKTsKK30KKworc3RhdGljIHZvaWQgbGl2ZXBhdGNo
X2V4aXQodm9pZCkKK3sKKwlrb2JqZWN0X3B1dChrbHBfa29iaik7Cit9CisKK21vZHVsZV9p
bml0KGxpdmVwYXRjaF9pbml0KTsKK21vZHVsZV9leGl0KGxpdmVwYXRjaF9leGl0KTsKK01P
RFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVMRV9JTkZPKGxpdmVwYXRjaCwgIlkiKTsKK01P
RFVMRV9BVVRIT1IoIkxpYm9yIFBlY2hhY2VrIDxscGVjaGFjZWtAc3VzZS5jej4iKTsKK01P
RFVMRV9BVVRIT1IoIk5pY29sYWkgU3RhbmdlIDxuc3RhbmdlQHN1c2UuZGU+Iik7CitNT0RV
TEVfQVVUSE9SKCJNYXJjb3MgUGF1bG8gZGUgU291emEgPG1wZGVzb3V6YUBzdXNlLmNvbT4i
KTsKK01PRFVMRV9ERVNDUklQVElPTigiTGl2ZXBhdGNoIHRlc3Q6IHN5c2NhbGwgdHJhbnNp
dGlvbiIpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbXF1ZXVlL3Nl
dHRpbmcgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tcXVldWUvc2V0dGluZwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmE5NTNjOTZhYTE2ZQotLS0gL2Rl
di9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21xdWV1ZS9zZXR0aW5nCkBA
IC0wLDAgKzEgQEAKK3RpbWVvdXQ9MTgwCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9wb3dlcl9zdXBwbHkvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9wb3dlcl9zdXBwbHkvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwLi40NGYwNjU4ZDNkMmUKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9wb3dlcl9zdXBwbHkvTWFrZWZpbGUKQEAgLTAsMCArMSw0IEBACitU
RVNUX1BST0dTIDo9IHRlc3RfcG93ZXJfc3VwcGx5X3Byb3BlcnRpZXMuc2gKK1RFU1RfRklM
RVMgOj0gaGVscGVycy5zaAorCitpbmNsdWRlIC4uL2xpYi5tawpkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcG93ZXJfc3VwcGx5L2hlbHBlcnMuc2ggYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9wb3dlcl9zdXBwbHkvaGVscGVycy5zaApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjFlYzkwZDdjOTEwOAotLS0gL2Rldi9udWxs
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bvd2VyX3N1cHBseS9oZWxwZXJzLnNo
CkBAIC0wLDAgKzEsMTc4IEBACisjIS9iaW4vc2gKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAKKyMKKyMgQ29weXJpZ2h0IChjKSAyMDIyLCAyMDI0IENvbGxhYm9yYSBM
dGQKK1NZU0ZTX1NVUFBMSUVTPS9zeXMvY2xhc3MvcG93ZXJfc3VwcGx5CisKK2NhbGMoKSB7
CisJYXdrICJCRUdJTiB7IHByaW50ICQqIH0iOworfQorCit0ZXN0X3N5c2ZzX3Byb3AoKSB7
CisJUFJPUD0iJDEiCisJVkFMVUU9IiQyIiAjIG9wdGlvbmFsCisKKwlQUk9QX1BBVEg9IiRT
WVNGU19TVVBQTElFUyIvIiRERVZOQU1FIi8iJFBST1AiCisJVEVTVF9OQU1FPSIkREVWTkFN
RSIuc3lzZnMuIiRQUk9QIgorCisJaWYgWyAteiAiJFZBTFVFIiBdOyB0aGVuCisJCWt0YXBf
dGVzdF9yZXN1bHQgIiRURVNUX05BTUUiIFsgLWYgIiRQUk9QX1BBVEgiIF0KKwllbHNlCisJ
CWt0YXBfdGVzdF9yZXN1bHQgIiRURVNUX05BTUUiIGdyZXAgLXEgIiRWQUxVRSIgIiRQUk9Q
X1BBVEgiCisJZmkKK30KKwordG9faHVtYW5fcmVhZGFibGVfdW5pdCgpIHsKKwlWQUxVRT0i
JDEiCisJVU5JVD0iJDIiCisKKwljYXNlICIkVkFMVUUiIGluCisJCSpbITAtOV0qICkgcmV0
dXJuIDs7ICMgTm90IGEgbnVtYmVyCisJZXNhYworCisJaWYgWyAiJFVOSVQiID0gInVBIiBd
OyB0aGVuCisJCW5ld191bml0PSJtQSIKKwkJZGl2PTEwMDAKKwllbGlmIFsgIiRVTklUIiA9
ICJ1ViIgXTsgdGhlbgorCQluZXdfdW5pdD0iViIKKwkJZGl2PTEwMDAwMDAKKwllbGlmIFsg
IiRVTklUIiA9ICJ1QWgiIF07IHRoZW4KKwkJbmV3X3VuaXQ9IkFoIgorCQlkaXY9MTAwMDAw
MAorCWVsaWYgWyAiJFVOSVQiID0gInVXIiBdOyB0aGVuCisJCW5ld191bml0PSJtVyIKKwkJ
ZGl2PTEwMDAKKwllbGlmIFsgIiRVTklUIiA9ICJ1V2giIF07IHRoZW4KKwkJbmV3X3VuaXQ9
IldoIgorCQlkaXY9MTAwMDAwMAorCWVsc2UKKwkJcmV0dXJuCisJZmkKKworCXZhbHVlX2Nv
bnZlcnRlZD0kKGNhbGMgIiRWQUxVRSIvIiRkaXYiKQorCWVjaG8gIiR2YWx1ZV9jb252ZXJ0
ZWQiICIkbmV3X3VuaXQiCit9CisKK19jaGVja19zeXNmc19wcm9wX2F2YWlsYWJsZSgpIHsK
KwlQUk9QPSQxCisKKwlQUk9QX1BBVEg9IiRTWVNGU19TVVBQTElFUyIvIiRERVZOQU1FIi8i
JFBST1AiCisJVEVTVF9OQU1FPSIkREVWTkFNRSIuc3lzZnMuIiRQUk9QIgorCisJaWYgWyAh
IC1lICIkUFJPUF9QQVRIIiBdIDsgdGhlbgorCQlrdGFwX3Rlc3Rfc2tpcCAiJFRFU1RfTkFN
RSIKKwkJcmV0dXJuIDEKKwlmaQorCisJaWYgISBjYXQgIiRQUk9QX1BBVEgiID4vZGV2L251
bGw7IHRoZW4KKwkJa3RhcF9wcmludF9tc2cgIkZhaWxlZCB0byByZWFkIgorCQlrdGFwX3Rl
c3RfZmFpbCAiJFRFU1RfTkFNRSIKKwkJcmV0dXJuIDEKKwlmaQorCisJcmV0dXJuIDAKK30K
KwordGVzdF9zeXNmc19wcm9wX29wdGlvbmFsKCkgeworCVBST1A9JDEKKwlVTklUPSQyICMg
b3B0aW9uYWwKKworCVRFU1RfTkFNRT0iJERFVk5BTUUiLnN5c2ZzLiIkUFJPUCIKKworCV9j
aGVja19zeXNmc19wcm9wX2F2YWlsYWJsZSAiJFBST1AiIHx8IHJldHVybgorCURBVEE9JChj
YXQgIiRTWVNGU19TVVBQTElFUyIvIiRERVZOQU1FIi8iJFBST1AiKQorCisJa3RhcF9wcmlu
dF9tc2cgIlJlcG9ydGVkOiAnJERBVEEnICRVTklUICgkKHRvX2h1bWFuX3JlYWRhYmxlX3Vu
aXQgIiREQVRBIiAiJFVOSVQiKSkiCisJa3RhcF90ZXN0X3Bhc3MgIiRURVNUX05BTUUiCit9
CisKK3Rlc3Rfc3lzZnNfcHJvcF9vcHRpb25hbF9yYW5nZSgpIHsKKwlQUk9QPSQxCisJTUlO
PSQyCisJTUFYPSQzCisJVU5JVD0kNCAjIG9wdGlvbmFsCisKKwlURVNUX05BTUU9IiRERVZO
QU1FIi5zeXNmcy4iJFBST1AiCisKKwlfY2hlY2tfc3lzZnNfcHJvcF9hdmFpbGFibGUgIiRQ
Uk9QIiB8fCByZXR1cm4KKwlEQVRBPSQoY2F0ICIkU1lTRlNfU1VQUExJRVMiLyIkREVWTkFN
RSIvIiRQUk9QIikKKworCWlmIFsgIiREQVRBIiAtbHQgIiRNSU4iIF0gfHwgWyAiJERBVEEi
IC1ndCAiJE1BWCIgXTsgdGhlbgorCQlrdGFwX3ByaW50X21zZyAiJyREQVRBJyBpcyBvdXQg
b2YgcmFuZ2UgKG1pbj0kTUlOLCBtYXg9JE1BWCkiCisJCWt0YXBfdGVzdF9mYWlsICIkVEVT
VF9OQU1FIgorCWVsc2UKKwkJa3RhcF9wcmludF9tc2cgIlJlcG9ydGVkOiAnJERBVEEnICRV
TklUICgkKHRvX2h1bWFuX3JlYWRhYmxlX3VuaXQgIiREQVRBIiAiJFVOSVQiKSkiCisJCWt0
YXBfdGVzdF9wYXNzICIkVEVTVF9OQU1FIgorCWZpCit9CisKK3Rlc3Rfc3lzZnNfcHJvcF9v
cHRpb25hbF9saXN0KCkgeworCVBST1A9JDEKKwlMSVNUPSQyCisKKwlURVNUX05BTUU9IiRE
RVZOQU1FIi5zeXNmcy4iJFBST1AiCisKKwlfY2hlY2tfc3lzZnNfcHJvcF9hdmFpbGFibGUg
IiRQUk9QIiB8fCByZXR1cm4KKwlEQVRBPSQoY2F0ICIkU1lTRlNfU1VQUExJRVMiLyIkREVW
TkFNRSIvIiRQUk9QIikKKworCXZhbGlkPTAKKworCU9MRElGUz0kSUZTCisJSUZTPSIsIgor
CWZvciBpdGVtIGluICRMSVNUOyBkbworCQlpZiBbICIkREFUQSIgPSAiJGl0ZW0iIF07IHRo
ZW4KKwkJCXZhbGlkPTEKKwkJCWJyZWFrCisJCWZpCisJZG9uZQorCWlmIFsgIiR2YWxpZCIg
LWVxIDEgXTsgdGhlbgorCQlrdGFwX3ByaW50X21zZyAiUmVwb3J0ZWQ6ICckREFUQSciCisJ
CWt0YXBfdGVzdF9wYXNzICIkVEVTVF9OQU1FIgorCWVsc2UKKwkJa3RhcF9wcmludF9tc2cg
IickREFUQScgaXMgbm90IGEgdmFsaWQgdmFsdWUgZm9yIHRoaXMgcHJvcGVydHkiCisJCWt0
YXBfdGVzdF9mYWlsICIkVEVTVF9OQU1FIgorCWZpCisJSUZTPSRPTERJRlMKK30KKworZHVt
cF9maWxlKCkgeworCUZJTEU9IiQxIgorCXdoaWxlIHJlYWQgLXIgbGluZTsgZG8KKwkJa3Rh
cF9wcmludF9tc2cgIiRsaW5lIgorCWRvbmUgPCAiJEZJTEUiCit9CisKK19fdGVzdF91ZXZl
bnRfcHJvcCgpIHsKKwlQUk9QPSIkMSIKKwlPUFRJT05BTD0iJDIiCisJVkFMVUU9IiQzIiAj
IG9wdGlvbmFsCisKKwlVRVZFTlRfUEFUSD0iJFNZU0ZTX1NVUFBMSUVTIi8iJERFVk5BTUUi
L3VldmVudAorCVRFU1RfTkFNRT0iJERFVk5BTUUiLnVldmVudC4iJFBST1AiCisKKwlpZiAh
IGdyZXAgLXEgIlBPV0VSX1NVUFBMWV8kUFJPUD0iICIkVUVWRU5UX1BBVEgiOyB0aGVuCisJ
CWlmIFsgIiRPUFRJT05BTCIgLWVxIDEgXTsgdGhlbgorCQkJa3RhcF90ZXN0X3NraXAgIiRU
RVNUX05BTUUiCisJCWVsc2UKKwkJCWt0YXBfcHJpbnRfbXNnICJNaXNzaW5nIHByb3BlcnR5
IgorCQkJa3RhcF90ZXN0X2ZhaWwgIiRURVNUX05BTUUiCisJCWZpCisJCXJldHVybgorCWZp
CisKKwlpZiAhIGdyZXAgLXEgIlBPV0VSX1NVUFBMWV8kUFJPUD0kVkFMVUUiICIkVUVWRU5U
X1BBVEgiOyB0aGVuCisJCWt0YXBfcHJpbnRfbXNnICJJbnZhbGlkIHZhbHVlIGZvciB1ZXZl
bnQgcHJvcGVydHksIGR1bXBpbmcuLi4iCisJCWR1bXBfZmlsZSAiJFVFVkVOVF9QQVRIIgor
CQlrdGFwX3Rlc3RfZmFpbCAiJFRFU1RfTkFNRSIKKwllbHNlCisJCWt0YXBfdGVzdF9wYXNz
ICIkVEVTVF9OQU1FIgorCWZpCit9CisKK3Rlc3RfdWV2ZW50X3Byb3AoKSB7CisJX190ZXN0
X3VldmVudF9wcm9wICIkMSIgMCAiJDIiCit9CisKK3Rlc3RfdWV2ZW50X3Byb3Bfb3B0aW9u
YWwoKSB7CisJX190ZXN0X3VldmVudF9wcm9wICIkMSIgMSAiJDIiCit9CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9wb3dlcl9zdXBwbHkvdGVzdF9wb3dlcl9zdXBw
bHlfcHJvcGVydGllcy5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bvd2VyX3N1cHBs
eS90ZXN0X3Bvd2VyX3N1cHBseV9wcm9wZXJ0aWVzLnNoCm5ldyBmaWxlIG1vZGUgMTAwNzU1
CmluZGV4IDAwMDAwMDAwMDAwMC4uZGYyNzJkZmUxZDJhCi0tLSAvZGV2L251bGwKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcG93ZXJfc3VwcGx5L3Rlc3RfcG93ZXJfc3VwcGx5
X3Byb3BlcnRpZXMuc2gKQEAgLTAsMCArMSwxMTQgQEAKKyMhL2Jpbi9zaAorIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAorIworIyBDb3B5cmlnaHQgKGMpIDIwMjIsIDIw
MjQgQ29sbGFib3JhIEx0ZAorIworIyBUaGlzIHRlc3QgdmFsaWRhdGVzIHRoZSBwb3dlciBz
dXBwbHkgdUFQSTogbmFtZWx5LCB0aGUgZmlsZXMgaW4gc3lzZnMgYW5kCisjIGxpbmVzIGlu
IHVldmVudCB0aGF0IGV4cG9zZSB0aGUgcG93ZXIgc3VwcGx5IHByb3BlcnRpZXMuCisjCisj
IEJ5IGRlZmF1bHQgYWxsIHBvd2VyIHN1cHBsaWVzIGF2YWlsYWJsZSBhcmUgdGVzdGVkLiBP
cHRpb25hbGx5IHRoZSBuYW1lIG9mIGEKKyMgcG93ZXIgc3VwcGx5IGNhbiBiZSBwYXNzZWQg
YXMgYSBwYXJhbWV0ZXIgdG8gdGVzdCBvbmx5IHRoYXQgb25lIGluc3RlYWQuCitESVI9IiQo
ZGlybmFtZSAiJChyZWFkbGluayAtZiAiJDAiKSIpIgorCisuICIke0RJUn0iLy4uL2tzZWxm
dGVzdC9rdGFwX2hlbHBlcnMuc2gKKworLiAiJHtESVJ9Ii9oZWxwZXJzLnNoCisKK2NvdW50
X3Rlc3RzKCkgeworCVNVUFBMSUVTPSQxCisKKwkjIFRoaXMgbmVlZHMgdG8gYmUgdXBkYXRl
ZCBldmVyeSB0aW1lIGEgbmV3IHRlc3QgaXMgYWRkZWQuCisJTlVNX1RFU1RTPTMzCisKKwl0
b3RhbF90ZXN0cz0wCisKKwlmb3IgaSBpbiAkU1VQUExJRVM7IGRvCisJCXRvdGFsX3Rlc3Rz
PSQoKCIkdG90YWxfdGVzdHMiICsgIiROVU1fVEVTVFMiKSkKKwlkb25lCisKKwllY2hvICIk
dG90YWxfdGVzdHMiCit9CisKK2t0YXBfcHJpbnRfaGVhZGVyCisKK1NZU0ZTX1NVUFBMSUVT
PS9zeXMvY2xhc3MvcG93ZXJfc3VwcGx5LworCitpZiBbICQjIC1lcSAwIF07IHRoZW4KKwlz
dXBwbGllcz0kKGxzICIkU1lTRlNfU1VQUExJRVMiKQorZWxzZQorCXN1cHBsaWVzPSQxCitm
aQorCitrdGFwX3NldF9wbGFuICIkKGNvdW50X3Rlc3RzICIkc3VwcGxpZXMiKSIKKworZm9y
IERFVk5BTUUgaW4gJHN1cHBsaWVzOyBkbworCWt0YXBfcHJpbnRfbXNnIFRlc3RpbmcgZGV2
aWNlICIkREVWTkFNRSIKKworCWlmIFsgISAtZCAiJFNZU0ZTX1NVUFBMSUVTIi8iJERFVk5B
TUUiIF07IHRoZW4KKwkJa3RhcF90ZXN0X2ZhaWwgIiRERVZOQU1FIi5leGlzdHMKKwkJa3Rh
cF9leGl0X2ZhaWxfbXNnIERldmljZSBkb2VzIG5vdCBleGlzdAorCWZpCisKKwlrdGFwX3Rl
c3RfcGFzcyAiJERFVk5BTUUiLmV4aXN0cworCisJdGVzdF91ZXZlbnRfcHJvcCBOQU1FICIk
REVWTkFNRSIKKworCXRlc3Rfc3lzZnNfcHJvcCB0eXBlCisJU1VQUExZX1RZUEU9JChjYXQg
IiRTWVNGU19TVVBQTElFUyIvIiRERVZOQU1FIi90eXBlKQorCSMgVGhpcyBmYWlscyBvbiBr
ZXJuZWxzIDwgNS44IChuZWVkcyAyYWQzZDc0ZTNjNjlmKQorCXRlc3RfdWV2ZW50X3Byb3Ag
VFlQRSAiJFNVUFBMWV9UWVBFIgorCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIHVzYl90
eXBlCisKKwl0ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9uYWxfcmFuZ2Ugb25saW5lIDAgMgorCXRl
c3Rfc3lzZnNfcHJvcF9vcHRpb25hbF9yYW5nZSBwcmVzZW50IDAgMQorCisJdGVzdF9zeXNm
c19wcm9wX29wdGlvbmFsX2xpc3Qgc3RhdHVzICJVbmtub3duIiwiQ2hhcmdpbmciLCJEaXNj
aGFyZ2luZyIsIk5vdCBjaGFyZ2luZyIsIkZ1bGwiCisKKwkjIENhcGFjaXR5IGlzIHJlcG9y
dGVkIGFzIHBlcmNlbnRhZ2UsIHRodXMgYW55IHZhbHVlIGxlc3MgdGhhbiAwIGFuZAorCSMg
Z3JlYXRlciB0aGFuIDEwMCBhcmUgbm90IGFsbG93ZWQuCisJdGVzdF9zeXNmc19wcm9wX29w
dGlvbmFsX3JhbmdlIGNhcGFjaXR5IDAgMTAwICIlIgorCisJdGVzdF9zeXNmc19wcm9wX29w
dGlvbmFsX2xpc3QgY2FwYWNpdHlfbGV2ZWwgIlVua25vd24iLCJDcml0aWNhbCIsIkxvdyIs
Ik5vcm1hbCIsIkhpZ2giLCJGdWxsIgorCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIG1v
ZGVsX25hbWUKKwl0ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9uYWwgbWFudWZhY3R1cmVyCisJdGVz
dF9zeXNmc19wcm9wX29wdGlvbmFsIHNlcmlhbF9udW1iZXIKKwl0ZXN0X3N5c2ZzX3Byb3Bf
b3B0aW9uYWxfbGlzdCB0ZWNobm9sb2d5ICJVbmtub3duIiwiTmlNSCIsIkxpLWlvbiIsIkxp
LXBvbHkiLCJMaUZlIiwiTmlDZCIsIkxpTW4iCisKKwl0ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9u
YWwgY3ljbGVfY291bnQKKworCXRlc3Rfc3lzZnNfcHJvcF9vcHRpb25hbF9saXN0IHNjb3Bl
ICJVbmtub3duIiwiU3lzdGVtIiwiRGV2aWNlIgorCisJdGVzdF9zeXNmc19wcm9wX29wdGlv
bmFsIGlucHV0X2N1cnJlbnRfbGltaXQgInVBIgorCXRlc3Rfc3lzZnNfcHJvcF9vcHRpb25h
bCBpbnB1dF92b2x0YWdlX2xpbWl0ICJ1ViIKKworCSMgVGVjaG5pY2FsbHkgdGhlIHBvd2Vy
LXN1cHBseSBjbGFzcyBkb2VzIG5vdCBsaW1pdCByZXBvcnRlZCB2YWx1ZXMuCisJIyBFLmcu
IG9uZSBjb3VsZCBleHBvc2UgYW4gUlRDIGJhY2t1cC1iYXR0ZXJ5LCB3aGljaCBnb2VzIGJl
bG93IDEuNVYgb3IKKwkjIGFuIGVsZWN0cmljIHZlaGljbGUgYmF0dGVyeSB3aXRoIG92ZXIg
MzAwVi4gQnV0IG1vc3QgZGV2aWNlcyBkbyBub3QKKwkjIGhhdmUgYSBzdGVwLXVwIGNhcGFi
bGUgcmVndWxhdG9yIGJlaGluZCB0aGUgYmF0dGVyeSBhbmQgb3BlcmF0ZSB3aXRoCisJIyB2
b2x0YWdlcyBjb25zaWRlcmVkIHNhZmUgdG8gdG91Y2gsIHNvIHdlIGxpbWl0IHRoZSBhbGxv
d2VkIHJhbmdlIHRvCisJIyAxLjhWLTYwViB0byBjYXRjaCBkcml2ZXJzIHJlcG9ydGluZyBp
bmNvcnJlY3RseSBzY2FsZWQgdmFsdWVzLiBFLmcuIGEKKwkjIGNvbW1vbiBtaXN0YWtlIGlz
IHJlcG9ydGluZyBkYXRhIGluIG1WIGluc3RlYWQgb2YgwrVWLgorCXRlc3Rfc3lzZnNfcHJv
cF9vcHRpb25hbF9yYW5nZSB2b2x0YWdlX25vdyAxODAwMDAwIDYwMDAwMDAwICJ1ViIKKwl0
ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9uYWxfcmFuZ2Ugdm9sdGFnZV9taW4gMTgwMDAwMCA2MDAw
MDAwMCAidVYiCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsX3JhbmdlIHZvbHRhZ2VfbWF4
IDE4MDAwMDAgNjAwMDAwMDAgInVWIgorCXRlc3Rfc3lzZnNfcHJvcF9vcHRpb25hbF9yYW5n
ZSB2b2x0YWdlX21pbl9kZXNpZ24gMTgwMDAwMCA2MDAwMDAwMCAidVYiCisJdGVzdF9zeXNm
c19wcm9wX29wdGlvbmFsX3JhbmdlIHZvbHRhZ2VfbWF4X2Rlc2lnbiAxODAwMDAwIDYwMDAw
MDAwICJ1ViIKKworCSMgY3VycmVudCBiYXNlZCBzeXN0ZW1zCisJdGVzdF9zeXNmc19wcm9w
X29wdGlvbmFsIGN1cnJlbnRfbm93ICJ1QSIKKwl0ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9uYWwg
Y3VycmVudF9tYXggInVBIgorCXRlc3Rfc3lzZnNfcHJvcF9vcHRpb25hbCBjaGFyZ2Vfbm93
ICJ1QWgiCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIGNoYXJnZV9mdWxsICJ1QWgiCisJ
dGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIGNoYXJnZV9mdWxsX2Rlc2lnbiAidUFoIgorCisJ
IyBwb3dlciBiYXNlZCBzeXN0ZW1zCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIHBvd2Vy
X25vdyAidVciCisJdGVzdF9zeXNmc19wcm9wX29wdGlvbmFsIGVuZXJneV9ub3cgInVXaCIK
Kwl0ZXN0X3N5c2ZzX3Byb3Bfb3B0aW9uYWwgZW5lcmd5X2Z1bGwgInVXaCIKKwl0ZXN0X3N5
c2ZzX3Byb3Bfb3B0aW9uYWwgZW5lcmd5X2Z1bGxfZGVzaWduICJ1V2giCisJdGVzdF9zeXNm
c19wcm9wX29wdGlvbmFsIGVuZXJneV9mdWxsX2Rlc2lnbiAidVdoIgorZG9uZQorCitrdGFw
X2ZpbmlzaGVkCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L2NhY2hlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhY2hlLmMKaW5k
ZXggYmNiY2EzNTZkNTZhLi4xYjMzOWQ2YmJmZjEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2FjaGUuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL2NhY2hlLmMKQEAgLTMsMTA2ICszLDU5IEBACiAjaW5jbHVkZSA8c3Rk
aW50Lmg+CiAjaW5jbHVkZSAicmVzY3RybC5oIgogCi1zdHJ1Y3QgcmVhZF9mb3JtYXQgewot
CV9fdTY0IG5yOwkJCS8qIFRoZSBudW1iZXIgb2YgZXZlbnRzICovCi0Jc3RydWN0IHsKLQkJ
X191NjQgdmFsdWU7CQkvKiBUaGUgdmFsdWUgb2YgdGhlIGV2ZW50ICovCi0JfSB2YWx1ZXNb
Ml07Ci19OwotCi1zdGF0aWMgc3RydWN0IHBlcmZfZXZlbnRfYXR0ciBwZWFfbGxjX21pc3M7
Ci1zdGF0aWMgc3RydWN0IHJlYWRfZm9ybWF0IHJmX2NxbTsKLXN0YXRpYyBpbnQgZmRfbG07
CiBjaGFyIGxsY19vY2N1cF9wYXRoWzEwMjRdOwogCi1zdGF0aWMgdm9pZCBpbml0aWFsaXpl
X3BlcmZfZXZlbnRfYXR0cih2b2lkKQordm9pZCBwZXJmX2V2ZW50X2F0dHJfaW5pdGlhbGl6
ZShzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICpwZWEsIF9fdTY0IGNvbmZpZykKIHsKLQlwZWFf
bGxjX21pc3MudHlwZSA9IFBFUkZfVFlQRV9IQVJEV0FSRTsKLQlwZWFfbGxjX21pc3Muc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyKTsKLQlwZWFfbGxjX21pc3MucmVh
ZF9mb3JtYXQgPSBQRVJGX0ZPUk1BVF9HUk9VUDsKLQlwZWFfbGxjX21pc3MuZXhjbHVkZV9r
ZXJuZWwgPSAxOwotCXBlYV9sbGNfbWlzcy5leGNsdWRlX2h2ID0gMTsKLQlwZWFfbGxjX21p
c3MuZXhjbHVkZV9pZGxlID0gMTsKLQlwZWFfbGxjX21pc3MuZXhjbHVkZV9jYWxsY2hhaW5f
a2VybmVsID0gMTsKLQlwZWFfbGxjX21pc3MuaW5oZXJpdCA9IDE7Ci0JcGVhX2xsY19taXNz
LmV4Y2x1ZGVfZ3Vlc3QgPSAxOwotCXBlYV9sbGNfbWlzcy5kaXNhYmxlZCA9IDE7Ci19Ci0K
LXN0YXRpYyB2b2lkIGlvY3RsX3BlcmZfZXZlbnRfaW9jX3Jlc2V0X2VuYWJsZSh2b2lkKQot
ewotCWlvY3RsKGZkX2xtLCBQRVJGX0VWRU5UX0lPQ19SRVNFVCwgMCk7Ci0JaW9jdGwoZmRf
bG0sIFBFUkZfRVZFTlRfSU9DX0VOQUJMRSwgMCk7Ci19Ci0KLXN0YXRpYyBpbnQgcGVyZl9l
dmVudF9vcGVuX2xsY19taXNzKHBpZF90IHBpZCwgaW50IGNwdV9ubykKLXsKLQlmZF9sbSA9
IHBlcmZfZXZlbnRfb3BlbigmcGVhX2xsY19taXNzLCBwaWQsIGNwdV9ubywgLTEsCi0JCQkJ
UEVSRl9GTEFHX0ZEX0NMT0VYRUMpOwotCWlmIChmZF9sbSA9PSAtMSkgewotCQlwZXJyb3Io
IkVycm9yIG9wZW5pbmcgbGVhZGVyIik7Ci0JCWN0cmxjX2hhbmRsZXIoMCwgTlVMTCwgTlVM
TCk7Ci0JCXJldHVybiAtMTsKLQl9Ci0KLQlyZXR1cm4gMDsKLX0KLQotc3RhdGljIHZvaWQg
aW5pdGlhbGl6ZV9sbGNfcGVyZih2b2lkKQotewotCW1lbXNldCgmcGVhX2xsY19taXNzLCAw
LCBzaXplb2Yoc3RydWN0IHBlcmZfZXZlbnRfYXR0cikpOwotCW1lbXNldCgmcmZfY3FtLCAw
LCBzaXplb2Yoc3RydWN0IHJlYWRfZm9ybWF0KSk7Ci0KLQkvKiBJbml0aWFsaXplIHBlcmZf
ZXZlbnRfYXR0ciBzdHJ1Y3R1cmVzIGZvciBIV19DQUNIRV9NSVNTRVMgKi8KLQlpbml0aWFs
aXplX3BlcmZfZXZlbnRfYXR0cigpOwotCi0JcGVhX2xsY19taXNzLmNvbmZpZyA9IFBFUkZf
Q09VTlRfSFdfQ0FDSEVfTUlTU0VTOwotCi0JcmZfY3FtLm5yID0gMTsKKwltZW1zZXQocGVh
LCAwLCBzaXplb2YoKnBlYSkpOworCXBlYS0+dHlwZSA9IFBFUkZfVFlQRV9IQVJEV0FSRTsK
KwlwZWEtPnNpemUgPSBzaXplb2YoKnBlYSk7CisJcGVhLT5yZWFkX2Zvcm1hdCA9IFBFUkZf
Rk9STUFUX0dST1VQOworCXBlYS0+ZXhjbHVkZV9rZXJuZWwgPSAxOworCXBlYS0+ZXhjbHVk
ZV9odiA9IDE7CisJcGVhLT5leGNsdWRlX2lkbGUgPSAxOworCXBlYS0+ZXhjbHVkZV9jYWxs
Y2hhaW5fa2VybmVsID0gMTsKKwlwZWEtPmluaGVyaXQgPSAxOworCXBlYS0+ZXhjbHVkZV9n
dWVzdCA9IDE7CisJcGVhLT5kaXNhYmxlZCA9IDE7CisJcGVhLT5jb25maWcgPSBjb25maWc7
CiB9CiAKLXN0YXRpYyBpbnQgcmVzZXRfZW5hYmxlX2xsY19wZXJmKHBpZF90IHBpZCwgaW50
IGNwdV9ubykKKy8qIFN0YXJ0IGNvdW50ZXJzIHRvIGxvZyB2YWx1ZXMgKi8KK2ludCBwZXJm
X2V2ZW50X3Jlc2V0X2VuYWJsZShpbnQgcGVfZmQpCiB7Ci0JaW50IHJldCA9IDA7CisJaW50
IHJldDsKIAotCXJldCA9IHBlcmZfZXZlbnRfb3Blbl9sbGNfbWlzcyhwaWQsIGNwdV9ubyk7
CisJcmV0ID0gaW9jdGwocGVfZmQsIFBFUkZfRVZFTlRfSU9DX1JFU0VULCAwKTsKIAlpZiAo
cmV0IDwgMCkKIAkJcmV0dXJuIHJldDsKIAotCS8qIFN0YXJ0IGNvdW50ZXJzIHRvIGxvZyB2
YWx1ZXMgKi8KLQlpb2N0bF9wZXJmX2V2ZW50X2lvY19yZXNldF9lbmFibGUoKTsKKwlyZXQg
PSBpb2N0bChwZV9mZCwgUEVSRl9FVkVOVF9JT0NfRU5BQkxFLCAwKTsKKwlpZiAocmV0IDwg
MCkKKwkJcmV0dXJuIHJldDsKIAogCXJldHVybiAwOwogfQogCi0vKgotICogZ2V0X2xsY19w
ZXJmOglsbGMgY2FjaGUgbWlzcyB0aHJvdWdoIHBlcmYgZXZlbnRzCi0gKiBAbGxjX3BlcmZf
bWlzczoJTExDIG1pc3MgY291bnRlciB0aGF0IGlzIGZpbGxlZCBvbiBzdWNjZXNzCi0gKgot
ICogUGVyZiBldmVudHMgbGlrZSBIV19DQUNIRV9NSVNTRVMgY291bGQgYmUgdXNlZCB0byB2
YWxpZGF0ZSBudW1iZXIgb2YKLSAqIGNhY2hlIGxpbmVzIGFsbG9jYXRlZC4KLSAqCi0gKiBS
ZXR1cm46ID0wIG9uIHN1Y2Nlc3MuICA8MCBvbiBmYWlsdXJlLgotICovCi1zdGF0aWMgaW50
IGdldF9sbGNfcGVyZih1bnNpZ25lZCBsb25nICpsbGNfcGVyZl9taXNzKQordm9pZCBwZXJm
X2V2ZW50X2luaXRpYWxpemVfcmVhZF9mb3JtYXQoc3RydWN0IHBlcmZfZXZlbnRfcmVhZCAq
cGVfcmVhZCkKIHsKLQlfX3U2NCB0b3RhbF9taXNzZXM7Ci0JaW50IHJldDsKLQotCS8qIFN0
b3AgY291bnRlcnMgYWZ0ZXIgb25lIHNwYW4gdG8gZ2V0IG1pc3MgcmF0ZSAqLworCW1lbXNl
dChwZV9yZWFkLCAwLCBzaXplb2YoKnBlX3JlYWQpKTsKKwlwZV9yZWFkLT5uciA9IDE7Cit9
CiAKLQlpb2N0bChmZF9sbSwgUEVSRl9FVkVOVF9JT0NfRElTQUJMRSwgMCk7CitpbnQgcGVy
Zl9vcGVuKHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKnBlYSwgcGlkX3QgcGlkLCBpbnQgY3B1
X25vKQoreworCWludCBwZV9mZDsKIAotCXJldCA9IHJlYWQoZmRfbG0sICZyZl9jcW0sIHNp
emVvZihzdHJ1Y3QgcmVhZF9mb3JtYXQpKTsKLQlpZiAocmV0ID09IC0xKSB7Ci0JCXBlcnJv
cigiQ291bGQgbm90IGdldCBsbGMgbWlzc2VzIHRocm91Z2ggcGVyZiIpOworCXBlX2ZkID0g
cGVyZl9ldmVudF9vcGVuKHBlYSwgcGlkLCBjcHVfbm8sIC0xLCBQRVJGX0ZMQUdfRkRfQ0xP
RVhFQyk7CisJaWYgKHBlX2ZkID09IC0xKSB7CisJCWtzZnRfcGVycm9yKCJFcnJvciBvcGVu
aW5nIGxlYWRlciIpOwogCQlyZXR1cm4gLTE7CiAJfQogCi0JdG90YWxfbWlzc2VzID0gcmZf
Y3FtLnZhbHVlc1swXS52YWx1ZTsKLQkqbGxjX3BlcmZfbWlzcyA9IHRvdGFsX21pc3NlczsK
KwlwZXJmX2V2ZW50X3Jlc2V0X2VuYWJsZShwZV9mZCk7CiAKLQlyZXR1cm4gMDsKKwlyZXR1
cm4gcGVfZmQ7CiB9CiAKIC8qCkBAIC0xMjQsMTIgKzc3LDEyIEBAIHN0YXRpYyBpbnQgZ2V0
X2xsY19vY2N1X3Jlc2N0cmwodW5zaWduZWQgbG9uZyAqbGxjX29jY3VwYW5jeSkKIAogCWZw
ID0gZm9wZW4obGxjX29jY3VwX3BhdGgsICJyIik7CiAJaWYgKCFmcCkgewotCQlwZXJyb3Io
IkZhaWxlZCB0byBvcGVuIHJlc3VsdHMgZmlsZSIpOworCQlrc2Z0X3BlcnJvcigiRmFpbGVk
IHRvIG9wZW4gcmVzdWx0cyBmaWxlIik7CiAKLQkJcmV0dXJuIGVycm5vOworCQlyZXR1cm4g
LTE7CiAJfQogCWlmIChmc2NhbmYoZnAsICIlbHUiLCBsbGNfb2NjdXBhbmN5KSA8PSAwKSB7
Ci0JCXBlcnJvcigiQ291bGQgbm90IGdldCBsbGMgb2NjdXBhbmN5Iik7CisJCWtzZnRfcGVy
cm9yKCJDb3VsZCBub3QgZ2V0IGxsYyBvY2N1cGFuY3kiKTsKIAkJZmNsb3NlKGZwKTsKIAog
CQlyZXR1cm4gLTE7CkBAIC0xNDYsMTYzICs5OSw5MSBAQCBzdGF0aWMgaW50IGdldF9sbGNf
b2NjdV9yZXNjdHJsKHVuc2lnbmVkIGxvbmcgKmxsY19vY2N1cGFuY3kpCiAgKiBAbGxjX3Zh
bHVlOgkJcGVyZiBtaXNzIHZhbHVlIC8KICAqCQkJbGxjIG9jY3VwYW5jeSB2YWx1ZSByZXBv
cnRlZCBieSByZXNjdHJsIEZTCiAgKgotICogUmV0dXJuOgkJMCBvbiBzdWNjZXNzLiBub24t
emVybyBvbiBmYWlsdXJlLgorICogUmV0dXJuOgkJMCBvbiBzdWNjZXNzLCA8IDAgb24gZXJy
b3IuCiAgKi8KLXN0YXRpYyBpbnQgcHJpbnRfcmVzdWx0c19jYWNoZShjaGFyICpmaWxlbmFt
ZSwgaW50IGJtX3BpZCwKLQkJCSAgICAgICB1bnNpZ25lZCBsb25nIGxsY192YWx1ZSkKK3N0
YXRpYyBpbnQgcHJpbnRfcmVzdWx0c19jYWNoZShjb25zdCBjaGFyICpmaWxlbmFtZSwgaW50
IGJtX3BpZCwgX191NjQgbGxjX3ZhbHVlKQogewogCUZJTEUgKmZwOwogCiAJaWYgKHN0cmNt
cChmaWxlbmFtZSwgInN0ZGlvIikgPT0gMCB8fCBzdHJjbXAoZmlsZW5hbWUsICJzdGRlcnIi
KSA9PSAwKSB7Ci0JCXByaW50ZigiUGlkOiAlZCBcdCBMTENfdmFsdWU6ICVsdVxuIiwgYm1f
cGlkLAotCQkgICAgICAgbGxjX3ZhbHVlKTsKKwkJcHJpbnRmKCJQaWQ6ICVkIFx0IExMQ192
YWx1ZTogJWxsdVxuIiwgYm1fcGlkLCBsbGNfdmFsdWUpOwogCX0gZWxzZSB7CiAJCWZwID0g
Zm9wZW4oZmlsZW5hbWUsICJhIik7CiAJCWlmICghZnApIHsKLQkJCXBlcnJvcigiQ2Fubm90
IG9wZW4gcmVzdWx0cyBmaWxlIik7CisJCQlrc2Z0X3BlcnJvcigiQ2Fubm90IG9wZW4gcmVz
dWx0cyBmaWxlIik7CiAKLQkJCXJldHVybiBlcnJubzsKKwkJCXJldHVybiAtMTsKIAkJfQot
CQlmcHJpbnRmKGZwLCAiUGlkOiAlZCBcdCBsbGNfdmFsdWU6ICVsdVxuIiwgYm1fcGlkLCBs
bGNfdmFsdWUpOworCQlmcHJpbnRmKGZwLCAiUGlkOiAlZCBcdCBsbGNfdmFsdWU6ICVsbHVc
biIsIGJtX3BpZCwgbGxjX3ZhbHVlKTsKIAkJZmNsb3NlKGZwKTsKIAl9CiAKIAlyZXR1cm4g
MDsKIH0KIAotaW50IG1lYXN1cmVfY2FjaGVfdmFscyhzdHJ1Y3QgcmVzY3RybF92YWxfcGFy
YW0gKnBhcmFtLCBpbnQgYm1fcGlkKQorLyoKKyAqIHBlcmZfZXZlbnRfbWVhc3VyZSAtIE1l
YXN1cmUgcGVyZiBldmVudHMKKyAqIEBmaWxlbmFtZToJRmlsZW5hbWUgZm9yIHdyaXRpbmcg
dGhlIHJlc3VsdHMKKyAqIEBibV9waWQ6CVBJRCB0aGF0IHJ1bnMgdGhlIGJlbmNobWFyawor
ICoKKyAqIE1lYXN1cmVzIHBlcmYgZXZlbnRzIChlLmcuLCBjYWNoZSBtaXNzZXMpIGFuZCB3
cml0ZXMgdGhlIHJlc3VsdHMgaW50bworICogQGZpbGVuYW1lLiBAYm1fcGlkIGlzIHdyaXR0
ZW4gdG8gdGhlIHJlc3VsdHMgZmlsZSBhbG9uZyB3aXRoIHRoZSBtZWFzdXJlZAorICogdmFs
dWUuCisgKgorICogUmV0dXJuOiA9MCBvbiBzdWNjZXNzLiA8MCBvbiBmYWlsdXJlLgorICov
CitpbnQgcGVyZl9ldmVudF9tZWFzdXJlKGludCBwZV9mZCwgc3RydWN0IHBlcmZfZXZlbnRf
cmVhZCAqcGVfcmVhZCwKKwkJICAgICAgIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBpbnQgYm1f
cGlkKQogewotCXVuc2lnbmVkIGxvbmcgbGxjX3BlcmZfbWlzcyA9IDAsIGxsY19vY2N1X3Jl
c2MgPSAwLCBsbGNfdmFsdWUgPSAwOwogCWludCByZXQ7CiAKLQkvKgotCSAqIE1lYXN1cmUg
Y2FjaGUgbWlzcyBmcm9tIHBlcmYuCi0JICovCi0JaWYgKCFzdHJuY21wKHBhcmFtLT5yZXNj
dHJsX3ZhbCwgQ0FUX1NUUiwgc2l6ZW9mKENBVF9TVFIpKSkgewotCQlyZXQgPSBnZXRfbGxj
X3BlcmYoJmxsY19wZXJmX21pc3MpOwotCQlpZiAocmV0IDwgMCkKLQkJCXJldHVybiByZXQ7
Ci0JCWxsY192YWx1ZSA9IGxsY19wZXJmX21pc3M7Ci0JfQorCS8qIFN0b3AgY291bnRlcnMg
YWZ0ZXIgb25lIHNwYW4gdG8gZ2V0IG1pc3MgcmF0ZSAqLworCXJldCA9IGlvY3RsKHBlX2Zk
LCBQRVJGX0VWRU5UX0lPQ19ESVNBQkxFLCAwKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJu
IHJldDsKIAotCS8qCi0JICogTWVhc3VyZSBsbGMgb2NjdXBhbmN5IGZyb20gcmVzY3RybC4K
LQkgKi8KLQlpZiAoIXN0cm5jbXAocGFyYW0tPnJlc2N0cmxfdmFsLCBDTVRfU1RSLCBzaXpl
b2YoQ01UX1NUUikpKSB7Ci0JCXJldCA9IGdldF9sbGNfb2NjdV9yZXNjdHJsKCZsbGNfb2Nj
dV9yZXNjKTsKLQkJaWYgKHJldCA8IDApCi0JCQlyZXR1cm4gcmV0OwotCQlsbGNfdmFsdWUg
PSBsbGNfb2NjdV9yZXNjOworCXJldCA9IHJlYWQocGVfZmQsIHBlX3JlYWQsIHNpemVvZigq
cGVfcmVhZCkpOworCWlmIChyZXQgPT0gLTEpIHsKKwkJa3NmdF9wZXJyb3IoIkNvdWxkIG5v
dCBnZXQgcGVyZiB2YWx1ZSIpOworCQlyZXR1cm4gLTE7CiAJfQotCXJldCA9IHByaW50X3Jl
c3VsdHNfY2FjaGUocGFyYW0tPmZpbGVuYW1lLCBibV9waWQsIGxsY192YWx1ZSk7Ci0JaWYg
KHJldCkKLQkJcmV0dXJuIHJldDsKIAotCXJldHVybiAwOworCXJldHVybiBwcmludF9yZXN1
bHRzX2NhY2hlKGZpbGVuYW1lLCBibV9waWQsIHBlX3JlYWQtPnZhbHVlc1swXS52YWx1ZSk7
CiB9CiAKIC8qCi0gKiBjYWNoZV92YWw6CQlleGVjdXRlIGJlbmNobWFyayBhbmQgbWVhc3Vy
ZSBMTEMgb2NjdXBhbmN5IHJlc2N0cmwKLSAqIGFuZCBwZXJmIGNhY2hlIG1pc3MgZm9yIHRo
ZSBiZW5jaG1hcmsKLSAqIEBwYXJhbToJCXBhcmFtZXRlcnMgcGFzc2VkIHRvIGNhY2hlX3Zh
bCgpCi0gKiBAc3BhbjoJCWJ1ZmZlciBzaXplIGZvciB0aGUgYmVuY2htYXJrCisgKiBtZWFz
dXJlX2xsY19yZXNjdHJsIC0gTWVhc3VyZSByZXNjdHJsIExMQyB2YWx1ZSBmcm9tIHJlc2N0
cmwKKyAqIEBmaWxlbmFtZToJRmlsZW5hbWUgZm9yIHdyaXRpbmcgdGhlIHJlc3VsdHMKKyAq
IEBibV9waWQ6CVBJRCB0aGF0IHJ1bnMgdGhlIGJlbmNobWFyawogICoKLSAqIFJldHVybjoJ
CTAgb24gc3VjY2Vzcy4gbm9uLXplcm8gb24gZmFpbHVyZS4KKyAqIE1lYXN1cmVzIExMQyBv
Y2N1cGFuY3kgZnJvbSByZXNjdHJsIGFuZCB3cml0ZXMgdGhlIHJlc3VsdHMgaW50byBAZmls
ZW5hbWUuCisgKiBAYm1fcGlkIGlzIHdyaXR0ZW4gdG8gdGhlIHJlc3VsdHMgZmlsZSBhbG9u
ZyB3aXRoIHRoZSBtZWFzdXJlZCB2YWx1ZS4KKyAqCisgKiBSZXR1cm46ID0wIG9uIHN1Y2Nl
c3MuIDwwIG9uIGZhaWx1cmUuCiAgKi8KLWludCBjYXRfdmFsKHN0cnVjdCByZXNjdHJsX3Zh
bF9wYXJhbSAqcGFyYW0sIHNpemVfdCBzcGFuKQoraW50IG1lYXN1cmVfbGxjX3Jlc2N0cmwo
Y29uc3QgY2hhciAqZmlsZW5hbWUsIGludCBibV9waWQpCiB7Ci0JaW50IG1lbWZsdXNoID0g
MSwgb3BlcmF0aW9uID0gMCwgcmV0ID0gMDsKLQljaGFyICpyZXNjdHJsX3ZhbCA9IHBhcmFt
LT5yZXNjdHJsX3ZhbDsKLQlwaWRfdCBibV9waWQ7Ci0KLQlpZiAoc3RyY21wKHBhcmFtLT5m
aWxlbmFtZSwgIiIpID09IDApCi0JCXNwcmludGYocGFyYW0tPmZpbGVuYW1lLCAic3RkaW8i
KTsKLQotCWJtX3BpZCA9IGdldHBpZCgpOwotCi0JLyogVGFza3NldCBiZW5jaG1hcmsgdG8g
c3BlY2lmaWVkIGNwdSAqLwotCXJldCA9IHRhc2tzZXRfYmVuY2htYXJrKGJtX3BpZCwgcGFy
YW0tPmNwdV9ubyk7Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKKwl1bnNpZ25lZCBsb25n
IGxsY19vY2N1X3Jlc2MgPSAwOworCWludCByZXQ7CiAKLQkvKiBXcml0ZSBiZW5jaG1hcmsg
dG8gc3BlY2lmaWVkIGNvbl9tb24gZ3JwLCBtb25fZ3JwIGluIHJlc2N0cmwgRlMqLwotCXJl
dCA9IHdyaXRlX2JtX3BpZF90b19yZXNjdHJsKGJtX3BpZCwgcGFyYW0tPmN0cmxncnAsIHBh
cmFtLT5tb25ncnAsCi0JCQkJICAgICAgcmVzY3RybF92YWwpOwotCWlmIChyZXQpCisJcmV0
ID0gZ2V0X2xsY19vY2N1X3Jlc2N0cmwoJmxsY19vY2N1X3Jlc2MpOworCWlmIChyZXQgPCAw
KQogCQlyZXR1cm4gcmV0OwogCi0JaW5pdGlhbGl6ZV9sbGNfcGVyZigpOwotCi0JLyogVGVz
dCBydW5zIHVudGlsIHRoZSBjYWxsYmFjayBzZXR1cCgpIHRlbGxzIHRoZSB0ZXN0IHRvIHN0
b3AuICovCi0Jd2hpbGUgKDEpIHsKLQkJcmV0ID0gcGFyYW0tPnNldHVwKHBhcmFtKTsKLQkJ
aWYgKHJldCA9PSBFTkRfT0ZfVEVTVFMpIHsKLQkJCXJldCA9IDA7Ci0JCQlicmVhazsKLQkJ
fQotCQlpZiAocmV0IDwgMCkKLQkJCWJyZWFrOwotCQlyZXQgPSByZXNldF9lbmFibGVfbGxj
X3BlcmYoYm1fcGlkLCBwYXJhbS0+Y3B1X25vKTsKLQkJaWYgKHJldCkKLQkJCWJyZWFrOwot
Ci0JCWlmIChydW5fZmlsbF9idWYoc3BhbiwgbWVtZmx1c2gsIG9wZXJhdGlvbiwgdHJ1ZSkp
IHsKLQkJCWZwcmludGYoc3RkZXJyLCAiRXJyb3ItcnVubmluZyBmaWxsIGJ1ZmZlclxuIik7
Ci0JCQlyZXQgPSAtMTsKLQkJCWdvdG8gcGVfY2xvc2U7Ci0JCX0KLQotCQlzbGVlcCgxKTsK
LQkJcmV0ID0gbWVhc3VyZV9jYWNoZV92YWxzKHBhcmFtLCBibV9waWQpOwotCQlpZiAocmV0
KQotCQkJZ290byBwZV9jbG9zZTsKLQl9Ci0KLQlyZXR1cm4gcmV0OwotCi1wZV9jbG9zZToK
LQljbG9zZShmZF9sbSk7Ci0JcmV0dXJuIHJldDsKKwlyZXR1cm4gcHJpbnRfcmVzdWx0c19j
YWNoZShmaWxlbmFtZSwgYm1fcGlkLCBsbGNfb2NjdV9yZXNjKTsKIH0KIAogLyoKLSAqIHNo
b3dfY2FjaGVfaW5mbzoJc2hvdyBjYWNoZSB0ZXN0IHJlc3VsdCBpbmZvcm1hdGlvbgotICog
QHN1bV9sbGNfdmFsOglzdW0gb2YgTExDIGNhY2hlIHJlc3VsdCBkYXRhCi0gKiBAbm9fb2Zf
Yml0czoJCW51bWJlciBvZiBiaXRzCi0gKiBAY2FjaGVfc3BhbjoJCWNhY2hlIHNwYW4gaW4g
Ynl0ZXMgZm9yIENNVCBvciBpbiBsaW5lcyBmb3IgQ0FUCi0gKiBAbWF4X2RpZmY6CQltYXgg
ZGlmZmVyZW5jZQotICogQG1heF9kaWZmX3BlcmNlbnQ6CW1heCBkaWZmZXJlbmNlIHBlcmNl
bnRhZ2UKLSAqIEBudW1fb2ZfcnVuczoJbnVtYmVyIG9mIHJ1bnMKLSAqIEBwbGF0Zm9ybToJ
CXNob3cgdGVzdCBpbmZvcm1hdGlvbiBvbiB0aGlzIHBsYXRmb3JtCi0gKiBAY210OgkJQ01U
IHRlc3Qgb3IgQ0FUIHRlc3QKLSAqCi0gKiBSZXR1cm46CQkwIG9uIHN1Y2Nlc3MuIG5vbi16
ZXJvIG9uIGZhaWx1cmUuCisgKiBzaG93X2NhY2hlX2luZm8gLSBTaG93IGdlbmVyaWMgY2Fj
aGUgdGVzdCBpbmZvcm1hdGlvbgorICogQG5vX29mX2JpdHM6CQlOdW1iZXIgb2YgYml0cwor
ICogQGF2Z19sbGNfdmFsOglBdmVyYWdlIG9mIExMQyBjYWNoZSByZXN1bHQgZGF0YQorICog
QGNhY2hlX3NwYW46CQlDYWNoZSBzcGFuCisgKiBAbGluZXM6CQlAY2FjaGVfc3BhbiBpbiBs
aW5lcyBvciBieXRlcwogICovCi1pbnQgc2hvd19jYWNoZV9pbmZvKHVuc2lnbmVkIGxvbmcg
c3VtX2xsY192YWwsIGludCBub19vZl9iaXRzLAotCQkgICAgc2l6ZV90IGNhY2hlX3NwYW4s
IHVuc2lnbmVkIGxvbmcgbWF4X2RpZmYsCi0JCSAgICB1bnNpZ25lZCBsb25nIG1heF9kaWZm
X3BlcmNlbnQsIHVuc2lnbmVkIGxvbmcgbnVtX29mX3J1bnMsCi0JCSAgICBib29sIHBsYXRm
b3JtLCBib29sIGNtdCkKK3ZvaWQgc2hvd19jYWNoZV9pbmZvKGludCBub19vZl9iaXRzLCBf
X3U2NCBhdmdfbGxjX3ZhbCwgc2l6ZV90IGNhY2hlX3NwYW4sIGJvb2wgbGluZXMpCiB7Ci0J
dW5zaWduZWQgbG9uZyBhdmdfbGxjX3ZhbCA9IDA7Ci0JZmxvYXQgZGlmZl9wZXJjZW50Owot
CWxvbmcgYXZnX2RpZmYgPSAwOwotCWludCByZXQ7Ci0KLQlhdmdfbGxjX3ZhbCA9IHN1bV9s
bGNfdmFsIC8gbnVtX29mX3J1bnM7Ci0JYXZnX2RpZmYgPSAobG9uZylhYnMoY2FjaGVfc3Bh
biAtIGF2Z19sbGNfdmFsKTsKLQlkaWZmX3BlcmNlbnQgPSAoKGZsb2F0KWNhY2hlX3NwYW4g
LSBhdmdfbGxjX3ZhbCkgLyBjYWNoZV9zcGFuICogMTAwOwotCi0JcmV0ID0gcGxhdGZvcm0g
JiYgYWJzKChpbnQpZGlmZl9wZXJjZW50KSA+IG1heF9kaWZmX3BlcmNlbnQgJiYKLQkgICAg
ICAoY210ID8gKGFicyhhdmdfZGlmZikgPiBtYXhfZGlmZikgOiB0cnVlKTsKLQotCWtzZnRf
cHJpbnRfbXNnKCIlcyBDaGVjayBjYWNoZSBtaXNzIHJhdGUgd2l0aGluICVsdSUlXG4iLAot
CQkgICAgICAgcmV0ID8gIkZhaWw6IiA6ICJQYXNzOiIsIG1heF9kaWZmX3BlcmNlbnQpOwot
Ci0Ja3NmdF9wcmludF9tc2coIlBlcmNlbnQgZGlmZj0lZFxuIiwgYWJzKChpbnQpZGlmZl9w
ZXJjZW50KSk7CiAJa3NmdF9wcmludF9tc2coIk51bWJlciBvZiBiaXRzOiAlZFxuIiwgbm9f
b2ZfYml0cyk7Ci0Ja3NmdF9wcmludF9tc2coIkF2ZXJhZ2UgTExDIHZhbDogJWx1XG4iLCBh
dmdfbGxjX3ZhbCk7Ci0Ja3NmdF9wcmludF9tc2coIkNhY2hlIHNwYW4gKCVzKTogJXp1XG4i
LCBjbXQgPyAiYnl0ZXMiIDogImxpbmVzIiwKKwlrc2Z0X3ByaW50X21zZygiQXZlcmFnZSBM
TEMgdmFsOiAlbGx1XG4iLCBhdmdfbGxjX3ZhbCk7CisJa3NmdF9wcmludF9tc2coIkNhY2hl
IHNwYW4gKCVzKTogJXp1XG4iLCBsaW5lcyA/ICJsaW5lcyIgOiAiYnl0ZXMiLAogCQkgICAg
ICAgY2FjaGVfc3Bhbik7Ci0KLQlyZXR1cm4gcmV0OwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jCmluZGV4IDIyNGJhODU0NGQ4YS4uNGNiOTkx
YmU4ZTMxIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2Nh
dF90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVz
dC5jCkBAIC0xMSwxMDggKzExLDI1NCBAQAogI2luY2x1ZGUgInJlc2N0cmwuaCIKICNpbmNs
dWRlIDx1bmlzdGQuaD4KIAotI2RlZmluZSBSRVNVTFRfRklMRV9OQU1FMQkicmVzdWx0X2Nh
dDEiCi0jZGVmaW5lIFJFU1VMVF9GSUxFX05BTUUyCSJyZXN1bHRfY2F0MiIKKyNkZWZpbmUg
UkVTVUxUX0ZJTEVfTkFNRQkicmVzdWx0X2NhdCIKICNkZWZpbmUgTlVNX09GX1JVTlMJCTUK
LSNkZWZpbmUgTUFYX0RJRkZfUEVSQ0VOVAk0Ci0jZGVmaW5lIE1BWF9ESUZGCQkxMDAwMDAw
CiAKIC8qCi0gKiBDaGFuZ2Ugc2NoZW1hdGEuIFdyaXRlIHNjaGVtYXRhIHRvIHNwZWNpZmll
ZAotICogY29uX21vbiBncnAsIG1vbl9ncnAgaW4gcmVzY3RybCBGUy4KLSAqIFJ1biA1IHRp
bWVzIGluIG9yZGVyIHRvIGdldCBhdmVyYWdlIHZhbHVlcy4KKyAqIE1pbmltdW0gZGlmZmVy
ZW5jZSBpbiBMTEMgbWlzc2VzIGJldHdlZW4gYSB0ZXN0IHdpdGggbisxIGJpdHMgQ0JNIHRv
IHRoZQorICogdGVzdCB3aXRoIG4gYml0cyBpcyBNSU5fRElGRl9QRVJDRU5UX1BFUl9CSVQg
KiAobiAtIDEpLiBXaXRoIGUuZy4gNSB2cyA0CisgKiBiaXRzIGluIHRoZSBDQk0gbWFzaywg
dGhlIG1pbmltdW0gZGlmZmVyZW5jZSBtdXN0IGJlIGF0IGxlYXN0CisgKiBNSU5fRElGRl9Q
RVJDRU5UX1BFUl9CSVQgKiAoNCAtIDEpID0gMyBwZXJjZW50LgorICoKKyAqIFRoZSByZWxh
dGlvbnNoaXAgYmV0d2VlbiBudW1iZXIgb2YgdXNlZCBDQk0gYml0cyBhbmQgZGlmZmVyZW5j
ZSBpbiBMTEMKKyAqIG1pc3NlcyBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgbGluZWFyLiBXaXRo
IGEgc21hbGwgbnVtYmVyIG9mIGJpdHMsIHRoZQorICogbWFyZ2luIGlzIHNtYWxsZXIgdGhh
biB3aXRoIGxhcmdlciBudW1iZXIgb2YgYml0cy4gRm9yIHNlbGZ0ZXN0IHB1cnBvc2VzLAor
ICogaG93ZXZlciwgbGluZWFyIGFwcHJvYWNoIGlzIGVub3VnaCBiZWNhdXNlIHVsdGltYXRl
bHkgb25seSBwYXNzL2ZhaWwKKyAqIGRlY2lzaW9uIGhhcyB0byBiZSBtYWRlIGFuZCBkaXN0
aW5jdGlvbiBiZXR3ZWVuIHN0cm9uZyBhbmQgc3Ryb25nZXIKKyAqIHNpZ25hbCBpcyBpcnJl
bGV2YW50LgogICovCi1zdGF0aWMgaW50IGNhdF9zZXR1cChzdHJ1Y3QgcmVzY3RybF92YWxf
cGFyYW0gKnApCisjZGVmaW5lIE1JTl9ESUZGX1BFUkNFTlRfUEVSX0JJVAkxVUwKKworc3Rh
dGljIGludCBzaG93X3Jlc3VsdHNfaW5mbyhfX3U2NCBzdW1fbGxjX3ZhbCwgaW50IG5vX29m
X2JpdHMsCisJCQkgICAgIHVuc2lnbmVkIGxvbmcgY2FjaGVfc3BhbiwKKwkJCSAgICAgdW5z
aWduZWQgbG9uZyBtaW5fZGlmZl9wZXJjZW50LAorCQkJICAgICB1bnNpZ25lZCBsb25nIG51
bV9vZl9ydW5zLCBib29sIHBsYXRmb3JtLAorCQkJICAgICBfX3M2NCAqcHJldl9hdmdfbGxj
X3ZhbCkKIHsKLQljaGFyIHNjaGVtYXRhWzY0XTsKKwlfX3U2NCBhdmdfbGxjX3ZhbCA9IDA7
CisJZmxvYXQgYXZnX2RpZmY7CiAJaW50IHJldCA9IDA7CiAKLQkvKiBSdW4gTlVNX09GX1JV
TlMgdGltZXMgKi8KLQlpZiAocC0+bnVtX29mX3J1bnMgPj0gTlVNX09GX1JVTlMpCi0JCXJl
dHVybiBFTkRfT0ZfVEVTVFM7CisJYXZnX2xsY192YWwgPSBzdW1fbGxjX3ZhbCAvIG51bV9v
Zl9ydW5zOworCWlmICgqcHJldl9hdmdfbGxjX3ZhbCkgeworCQlmbG9hdCBkZWx0YSA9IChf
X3M2NCkoYXZnX2xsY192YWwgLSAqcHJldl9hdmdfbGxjX3ZhbCk7CisKKwkJYXZnX2RpZmYg
PSBkZWx0YSAvICpwcmV2X2F2Z19sbGNfdmFsOworCQlyZXQgPSBwbGF0Zm9ybSAmJiAoYXZn
X2RpZmYgKiAxMDApIDwgKGZsb2F0KW1pbl9kaWZmX3BlcmNlbnQ7CisKKwkJa3NmdF9wcmlu
dF9tc2coIiVzIENoZWNrIGNhY2hlIG1pc3MgcmF0ZSBjaGFuZ2VkIG1vcmUgdGhhbiAlLjFm
JSVcbiIsCisJCQkgICAgICAgcmV0ID8gIkZhaWw6IiA6ICJQYXNzOiIsIChmbG9hdCltaW5f
ZGlmZl9wZXJjZW50KTsKIAotCWlmIChwLT5udW1fb2ZfcnVucyA9PSAwKSB7Ci0JCXNwcmlu
dGYoc2NoZW1hdGEsICIlbHgiLCBwLT5tYXNrKTsKLQkJcmV0ID0gd3JpdGVfc2NoZW1hdGEo
cC0+Y3RybGdycCwgc2NoZW1hdGEsIHAtPmNwdV9ubywKLQkJCQkgICAgIHAtPnJlc2N0cmxf
dmFsKTsKKwkJa3NmdF9wcmludF9tc2coIlBlcmNlbnQgZGlmZj0lLjFmXG4iLCBhdmdfZGlm
ZiAqIDEwMCk7CiAJfQotCXAtPm51bV9vZl9ydW5zKys7CisJKnByZXZfYXZnX2xsY192YWwg
PSBhdmdfbGxjX3ZhbDsKKworCXNob3dfY2FjaGVfaW5mbyhub19vZl9iaXRzLCBhdmdfbGxj
X3ZhbCwgY2FjaGVfc3BhbiwgdHJ1ZSk7CiAKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMg
aW50IGNoZWNrX3Jlc3VsdHMoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSwgc2l6
ZV90IHNwYW4pCisvKiBSZW1vdmUgdGhlIGhpZ2hlc3QgYml0IGZyb20gQ0JNICovCitzdGF0
aWMgdW5zaWduZWQgbG9uZyBuZXh0X21hc2sodW5zaWduZWQgbG9uZyBjdXJyZW50X21hc2sp
Cit7CisJcmV0dXJuIGN1cnJlbnRfbWFzayAmIChjdXJyZW50X21hc2sgPj4gMSk7Cit9CisK
K3N0YXRpYyBpbnQgY2hlY2tfcmVzdWx0cyhzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBh
cmFtLCBjb25zdCBjaGFyICpjYWNoZV90eXBlLAorCQkJIHVuc2lnbmVkIGxvbmcgY2FjaGVf
dG90YWxfc2l6ZSwgdW5zaWduZWQgbG9uZyBmdWxsX2NhY2hlX21hc2ssCisJCQkgdW5zaWdu
ZWQgbG9uZyBjdXJyZW50X21hc2spCiB7CiAJY2hhciAqdG9rZW5fYXJyYXlbOF0sIHRlbXBb
NTEyXTsKLQl1bnNpZ25lZCBsb25nIHN1bV9sbGNfcGVyZl9taXNzID0gMDsKLQlpbnQgcnVu
cyA9IDAsIG5vX29mX2JpdHMgPSAwOworCV9fdTY0IHN1bV9sbGNfcGVyZl9taXNzID0gMDsK
KwlfX3M2NCBwcmV2X2F2Z19sbGNfdmFsID0gMDsKKwl1bnNpZ25lZCBsb25nIGFsbG9jX3Np
emU7CisJaW50IHJ1bnMgPSAwOworCWludCBmYWlsID0gMDsKKwlpbnQgcmV0OwogCUZJTEUg
KmZwOwogCiAJa3NmdF9wcmludF9tc2coIkNoZWNraW5nIGZvciBwYXNzL2ZhaWxcbiIpOwog
CWZwID0gZm9wZW4ocGFyYW0tPmZpbGVuYW1lLCAiciIpOwogCWlmICghZnApIHsKLQkJcGVy
cm9yKCIjIENhbm5vdCBvcGVuIGZpbGUiKTsKKwkJa3NmdF9wZXJyb3IoIkNhbm5vdCBvcGVu
IGZpbGUiKTsKIAotCQlyZXR1cm4gZXJybm87CisJCXJldHVybiAtMTsKIAl9CiAKIAl3aGls
ZSAoZmdldHModGVtcCwgc2l6ZW9mKHRlbXApLCBmcCkpIHsKIAkJY2hhciAqdG9rZW4gPSBz
dHJ0b2sodGVtcCwgIjpcdCIpOwogCQlpbnQgZmllbGRzID0gMDsKKwkJaW50IGJpdHM7CiAK
IAkJd2hpbGUgKHRva2VuKSB7CiAJCQl0b2tlbl9hcnJheVtmaWVsZHMrK10gPSB0b2tlbjsK
IAkJCXRva2VuID0gc3RydG9rKE5VTEwsICI6XHQiKTsKIAkJfQotCQkvKgotCQkgKiBEaXNj
YXJkIHRoZSBmaXJzdCB2YWx1ZSB3aGljaCBpcyBpbmFjY3VyYXRlIGR1ZSB0byBtb25pdG9y
aW5nCi0JCSAqIHNldHVwIHRyYW5zaXRpb24gcGhhc2UuCi0JCSAqLwotCQlpZiAocnVucyA+
IDApCi0JCQlzdW1fbGxjX3BlcmZfbWlzcyArPSBzdHJ0b3VsKHRva2VuX2FycmF5WzNdLCBO
VUxMLCAwKTsKKworCQlzdW1fbGxjX3BlcmZfbWlzcyArPSBzdHJ0b3VsbCh0b2tlbl9hcnJh
eVszXSwgTlVMTCwgMCk7CiAJCXJ1bnMrKzsKKworCQlpZiAocnVucyA8IE5VTV9PRl9SVU5T
KQorCQkJY29udGludWU7CisKKwkJaWYgKCFjdXJyZW50X21hc2spIHsKKwkJCWtzZnRfcHJp
bnRfbXNnKCJVbmV4cGVjdGVkIGVtcHR5IGNhY2hlIG1hc2tcbiIpOworCQkJYnJlYWs7CisJ
CX0KKworCQlhbGxvY19zaXplID0gY2FjaGVfcG9ydGlvbl9zaXplKGNhY2hlX3RvdGFsX3Np
emUsIGN1cnJlbnRfbWFzaywgZnVsbF9jYWNoZV9tYXNrKTsKKworCQliaXRzID0gY291bnRf
Yml0cyhjdXJyZW50X21hc2spOworCisJCXJldCA9IHNob3dfcmVzdWx0c19pbmZvKHN1bV9s
bGNfcGVyZl9taXNzLCBiaXRzLAorCQkJCQlhbGxvY19zaXplIC8gNjQsCisJCQkJCU1JTl9E
SUZGX1BFUkNFTlRfUEVSX0JJVCAqIChiaXRzIC0gMSksCisJCQkJCXJ1bnMsIGdldF92ZW5k
b3IoKSA9PSBBUkNIX0lOVEVMLAorCQkJCQkmcHJldl9hdmdfbGxjX3ZhbCk7CisJCWlmIChy
ZXQpCisJCQlmYWlsID0gMTsKKworCQlydW5zID0gMDsKKwkJc3VtX2xsY19wZXJmX21pc3Mg
PSAwOworCQljdXJyZW50X21hc2sgPSBuZXh0X21hc2soY3VycmVudF9tYXNrKTsKIAl9CiAK
IAlmY2xvc2UoZnApOwotCW5vX29mX2JpdHMgPSBjb3VudF9iaXRzKHBhcmFtLT5tYXNrKTsK
IAotCXJldHVybiBzaG93X2NhY2hlX2luZm8oc3VtX2xsY19wZXJmX21pc3MsIG5vX29mX2Jp
dHMsIHNwYW4gLyA2NCwKLQkJCSAgICAgICBNQVhfRElGRiwgTUFYX0RJRkZfUEVSQ0VOVCwg
cnVucyAtIDEsCi0JCQkgICAgICAgZ2V0X3ZlbmRvcigpID09IEFSQ0hfSU5URUwsIGZhbHNl
KTsKKwlyZXR1cm4gZmFpbDsKIH0KIAogdm9pZCBjYXRfdGVzdF9jbGVhbnVwKHZvaWQpCiB7
Ci0JcmVtb3ZlKFJFU1VMVF9GSUxFX05BTUUxKTsKLQlyZW1vdmUoUkVTVUxUX0ZJTEVfTkFN
RTIpOworCXJlbW92ZShSRVNVTFRfRklMRV9OQU1FKTsKIH0KIAotaW50IGNhdF9wZXJmX21p
c3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyICpjYWNoZV90eXBlKQorLyoKKyAqIGNh
dF90ZXN0IC0gRXhlY3V0ZSBDQVQgYmVuY2htYXJrIGFuZCBtZWFzdXJlIGNhY2hlIG1pc3Nl
cworICogQHRlc3Q6CQlUZXN0IGluZm9ybWF0aW9uIHN0cnVjdHVyZQorICogQHVwYXJhbXM6
CQlVc2VyIHN1cHBsaWVkIHBhcmFtZXRlcnMKKyAqIEBwYXJhbToJCVBhcmFtZXRlcnMgcGFz
c2VkIHRvIGNhdF90ZXN0KCkKKyAqIEBzcGFuOgkJQnVmZmVyIHNpemUgZm9yIHRoZSBiZW5j
aG1hcmsKKyAqIEBjdXJyZW50X21hc2sJU3RhcnQgbWFzayBmb3IgdGhlIGZpcnN0IGl0ZXJh
dGlvbgorICoKKyAqIFJ1biBDQVQgc2VsZnRlc3QgYnkgdmFyeWluZyB0aGUgYWxsb2NhdGVk
IGNhY2hlIHBvcnRpb24gYW5kIGNvbXBhcmluZyB0aGUKKyAqIGltcGFjdCBvbiBjYWNoZSBt
aXNzZXMgKHRoZSByZXN1bHQgYW5hbHlzaXMgaXMgZG9uZSBpbiBjaGVja19yZXN1bHRzKCkK
KyAqIGFuZCBzaG93X3Jlc3VsdHNfaW5mbygpLCBub3QgaW4gdGhpcyBmdW5jdGlvbikuCisg
KgorICogT25lIGJpdCBpcyByZW1vdmVkIGZyb20gdGhlIENBVCBhbGxvY2F0aW9uIGJpdCBt
YXNrIChpbiBjdXJyZW50X21hc2spIGZvcgorICogZWFjaCBzdWJzZXF1ZW50IHRlc3Qgd2hp
Y2gga2VlcHMgcmVkdWNpbmcgdGhlIHNpemUgb2YgdGhlIGFsbG9jYXRlZCBjYWNoZQorICog
cG9ydGlvbi4gQSBzaW5nbGUgdGVzdCBmbHVzaGVzIHRoZSBidWZmZXIsIHJlYWRzIGl0IHRv
IHdhcm0gdXAgdGhlIGNhY2hlLAorICogYW5kIHJlYWRzIHRoZSBidWZmZXIgYWdhaW4uIFRo
ZSBjYWNoZSBtaXNzZXMgYXJlIG1lYXN1cmVkIGR1cmluZyB0aGUgbGFzdAorICogcmVhZCBw
YXNzLgorICoKKyAqIFJldHVybjoJCTAgd2hlbiB0aGUgdGVzdCB3YXMgcnVuLCA8IDAgb24g
ZXJyb3IuCisgKi8KK3N0YXRpYyBpbnQgY2F0X3Rlc3QoY29uc3Qgc3RydWN0IHJlc2N0cmxf
dGVzdCAqdGVzdCwKKwkJICAgIGNvbnN0IHN0cnVjdCB1c2VyX3BhcmFtcyAqdXBhcmFtcywK
KwkJICAgIHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0sCisJCSAgICBzaXplX3Qg
c3BhbiwgdW5zaWduZWQgbG9uZyBjdXJyZW50X21hc2spCiB7Ci0JdW5zaWduZWQgbG9uZyBs
X21hc2ssIGxfbWFza18xOwotCWludCByZXQsIHBpcGVmZFsyXSwgc2libGluZ19jcHVfbm87
Ci0JdW5zaWduZWQgbG9uZyBjYWNoZV9zaXplID0gMDsKLQl1bnNpZ25lZCBsb25nIGxvbmdf
bWFzazsKLQljaGFyIGNibV9tYXNrWzI1Nl07CisJY2hhciAqcmVzY3RybF92YWwgPSBwYXJh
bS0+cmVzY3RybF92YWw7CisJc3RydWN0IHBlcmZfZXZlbnRfcmVhZCBwZV9yZWFkOworCXN0
cnVjdCBwZXJmX2V2ZW50X2F0dHIgcGVhOworCWNwdV9zZXRfdCBvbGRfYWZmaW5pdHk7CisJ
dW5zaWduZWQgY2hhciAqYnVmOworCWNoYXIgc2NoZW1hdGFbNjRdOworCWludCByZXQsIGks
IHBlX2ZkOworCXBpZF90IGJtX3BpZDsKKworCWlmIChzdHJjbXAocGFyYW0tPmZpbGVuYW1l
LCAiIikgPT0gMCkKKwkJc3ByaW50ZihwYXJhbS0+ZmlsZW5hbWUsICJzdGRpbyIpOworCisJ
Ym1fcGlkID0gZ2V0cGlkKCk7CisKKwkvKiBUYXNrc2V0IGJlbmNobWFyayB0byBzcGVjaWZp
ZWQgY3B1ICovCisJcmV0ID0gdGFza3NldF9iZW5jaG1hcmsoYm1fcGlkLCB1cGFyYW1zLT5j
cHUsICZvbGRfYWZmaW5pdHkpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwkvKiBX
cml0ZSBiZW5jaG1hcmsgdG8gc3BlY2lmaWVkIGNvbl9tb24gZ3JwLCBtb25fZ3JwIGluIHJl
c2N0cmwgRlMqLworCXJldCA9IHdyaXRlX2JtX3BpZF90b19yZXNjdHJsKGJtX3BpZCwgcGFy
YW0tPmN0cmxncnAsIHBhcmFtLT5tb25ncnAsCisJCQkJICAgICAgcmVzY3RybF92YWwpOwor
CWlmIChyZXQpCisJCWdvdG8gcmVzZXRfYWZmaW5pdHk7CisKKwlwZXJmX2V2ZW50X2F0dHJf
aW5pdGlhbGl6ZSgmcGVhLCBQRVJGX0NPVU5UX0hXX0NBQ0hFX01JU1NFUyk7CisJcGVyZl9l
dmVudF9pbml0aWFsaXplX3JlYWRfZm9ybWF0KCZwZV9yZWFkKTsKKwlwZV9mZCA9IHBlcmZf
b3BlbigmcGVhLCBibV9waWQsIHVwYXJhbXMtPmNwdSk7CisJaWYgKHBlX2ZkIDwgMCkgewor
CQlyZXQgPSAtMTsKKwkJZ290byByZXNldF9hZmZpbml0eTsKKwl9CisKKwlidWYgPSBhbGxv
Y19idWZmZXIoc3BhbiwgMSk7CisJaWYgKCFidWYpIHsKKwkJcmV0ID0gLTE7CisJCWdvdG8g
cGVfY2xvc2U7CisJfQorCisJd2hpbGUgKGN1cnJlbnRfbWFzaykgeworCQlzbnByaW50Zihz
Y2hlbWF0YSwgc2l6ZW9mKHNjaGVtYXRhKSwgIiVseCIsIHBhcmFtLT5tYXNrICYgfmN1cnJl
bnRfbWFzayk7CisJCXJldCA9IHdyaXRlX3NjaGVtYXRhKCIiLCBzY2hlbWF0YSwgdXBhcmFt
cy0+Y3B1LCB0ZXN0LT5yZXNvdXJjZSk7CisJCWlmIChyZXQpCisJCQlnb3RvIGZyZWVfYnVm
OworCQlzbnByaW50ZihzY2hlbWF0YSwgc2l6ZW9mKHNjaGVtYXRhKSwgIiVseCIsIGN1cnJl
bnRfbWFzayk7CisJCXJldCA9IHdyaXRlX3NjaGVtYXRhKHBhcmFtLT5jdHJsZ3JwLCBzY2hl
bWF0YSwgdXBhcmFtcy0+Y3B1LCB0ZXN0LT5yZXNvdXJjZSk7CisJCWlmIChyZXQpCisJCQln
b3RvIGZyZWVfYnVmOworCisJCWZvciAoaSA9IDA7IGkgPCBOVU1fT0ZfUlVOUzsgaSsrKSB7
CisJCQltZW1fZmx1c2goYnVmLCBzcGFuKTsKKwkJCWZpbGxfY2FjaGVfcmVhZChidWYsIHNw
YW4sIHRydWUpOworCisJCQlyZXQgPSBwZXJmX2V2ZW50X3Jlc2V0X2VuYWJsZShwZV9mZCk7
CisJCQlpZiAocmV0KQorCQkJCWdvdG8gZnJlZV9idWY7CisKKwkJCWZpbGxfY2FjaGVfcmVh
ZChidWYsIHNwYW4sIHRydWUpOworCisJCQlyZXQgPSBwZXJmX2V2ZW50X21lYXN1cmUocGVf
ZmQsICZwZV9yZWFkLCBwYXJhbS0+ZmlsZW5hbWUsIGJtX3BpZCk7CisJCQlpZiAocmV0KQor
CQkJCWdvdG8gZnJlZV9idWY7CisJCX0KKwkJY3VycmVudF9tYXNrID0gbmV4dF9tYXNrKGN1
cnJlbnRfbWFzayk7CisJfQorCitmcmVlX2J1ZjoKKwlmcmVlKGJ1Zik7CitwZV9jbG9zZToK
KwljbG9zZShwZV9mZCk7CityZXNldF9hZmZpbml0eToKKwl0YXNrc2V0X3Jlc3RvcmUoYm1f
cGlkLCAmb2xkX2FmZmluaXR5KTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQg
Y2F0X3J1bl90ZXN0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QsIGNvbnN0IHN0
cnVjdCB1c2VyX3BhcmFtcyAqdXBhcmFtcykKK3sKKwl1bnNpZ25lZCBsb25nIGxvbmdfbWFz
aywgc3RhcnRfbWFzaywgZnVsbF9jYWNoZV9tYXNrOworCXVuc2lnbmVkIGxvbmcgY2FjaGVf
dG90YWxfc2l6ZSA9IDA7CisJaW50IG4gPSB1cGFyYW1zLT5iaXRzOworCXVuc2lnbmVkIGlu
dCBzdGFydDsKIAlpbnQgY291bnRfb2ZfYml0czsKLQljaGFyIHBpcGVfbWVzc2FnZTsKIAlz
aXplX3Qgc3BhbjsKKwlpbnQgcmV0OwogCi0JLyogR2V0IGRlZmF1bHQgY2JtIG1hc2sgZm9y
IEwzL0wyIGNhY2hlICovCi0JcmV0ID0gZ2V0X2NibV9tYXNrKGNhY2hlX3R5cGUsIGNibV9t
YXNrKTsKKwlyZXQgPSBnZXRfZnVsbF9jYm0odGVzdC0+cmVzb3VyY2UsICZmdWxsX2NhY2hl
X21hc2spOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisJLyogR2V0IHRoZSBsYXJnZXN0
IGNvbnRpZ3VvdXMgZXhjbHVzaXZlIHBvcnRpb24gb2YgdGhlIGNhY2hlICovCisJcmV0ID0g
Z2V0X21hc2tfbm9fc2hhcmVhYmxlKHRlc3QtPnJlc291cmNlLCAmbG9uZ19tYXNrKTsKIAlp
ZiAocmV0KQogCQlyZXR1cm4gcmV0OwotCi0JbG9uZ19tYXNrID0gc3RydG91bChjYm1fbWFz
aywgTlVMTCwgMTYpOwogCiAJLyogR2V0IEwzL0wyIGNhY2hlIHNpemUgKi8KLQlyZXQgPSBn
ZXRfY2FjaGVfc2l6ZShjcHVfbm8sIGNhY2hlX3R5cGUsICZjYWNoZV9zaXplKTsKKwlyZXQg
PSBnZXRfY2FjaGVfc2l6ZSh1cGFyYW1zLT5jcHUsIHRlc3QtPnJlc291cmNlLCAmY2FjaGVf
dG90YWxfc2l6ZSk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKLQlrc2Z0X3ByaW50X21z
ZygiQ2FjaGUgc2l6ZSA6JWx1XG4iLCBjYWNoZV9zaXplKTsKKwlrc2Z0X3ByaW50X21zZygi
Q2FjaGUgc2l6ZSA6JWx1XG4iLCBjYWNoZV90b3RhbF9zaXplKTsKIAotCS8qIEdldCBtYXgg
bnVtYmVyIG9mIGJpdHMgZnJvbSBkZWZhdWx0LWNhYm0gbWFzayAqLwotCWNvdW50X29mX2Jp
dHMgPSBjb3VudF9iaXRzKGxvbmdfbWFzayk7CisJY291bnRfb2ZfYml0cyA9IGNvdW50X2Nv
bnRpZ3VvdXNfYml0cyhsb25nX21hc2ssICZzdGFydCk7CiAKIAlpZiAoIW4pCiAJCW4gPSBj
b3VudF9vZl9iaXRzIC8gMjsKQEAgLTEyMyw4OSArMjY5LDEyNCBAQCBpbnQgY2F0X3BlcmZf
bWlzc192YWwoaW50IGNwdV9ubywgaW50IG4sIGNoYXIgKmNhY2hlX3R5cGUpCiAJCQkgICAg
ICAgY291bnRfb2ZfYml0cyAtIDEpOwogCQlyZXR1cm4gLTE7CiAJfQotCi0JLyogR2V0IGNv
cmUgaWQgZnJvbSBzYW1lIHNvY2tldCBmb3IgcnVubmluZyBhbm90aGVyIHRocmVhZCAqLwot
CXNpYmxpbmdfY3B1X25vID0gZ2V0X2NvcmVfc2libGluZyhjcHVfbm8pOwotCWlmIChzaWJs
aW5nX2NwdV9ubyA8IDApCi0JCXJldHVybiAtMTsKKwlzdGFydF9tYXNrID0gY3JlYXRlX2Jp
dF9tYXNrKHN0YXJ0LCBuKTsKIAogCXN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSBwYXJhbSA9
IHsKIAkJLnJlc2N0cmxfdmFsCT0gQ0FUX1NUUiwKLQkJLmNwdV9ubwkJPSBjcHVfbm8sCi0J
CS5zZXR1cAkJPSBjYXRfc2V0dXAsCisJCS5jdHJsZ3JwCT0gImMxIiwKKwkJLmZpbGVuYW1l
CT0gUkVTVUxUX0ZJTEVfTkFNRSwKKwkJLm51bV9vZl9ydW5zCT0gMCwKIAl9OworCXBhcmFt
Lm1hc2sgPSBsb25nX21hc2s7CisJc3BhbiA9IGNhY2hlX3BvcnRpb25fc2l6ZShjYWNoZV90
b3RhbF9zaXplLCBzdGFydF9tYXNrLCBmdWxsX2NhY2hlX21hc2spOwogCi0JbF9tYXNrID0g
bG9uZ19tYXNrID4+IG47Ci0JbF9tYXNrXzEgPSB+bF9tYXNrICYgbG9uZ19tYXNrOworCXJl
bW92ZShwYXJhbS5maWxlbmFtZSk7CiAKLQkvKiBTZXQgcGFyYW0gdmFsdWVzIGZvciBwYXJl
bnQgdGhyZWFkIHdoaWNoIHdpbGwgYmUgYWxsb2NhdGVkIGJpdG1hc2sKLQkgKiB3aXRoICht
YXhfYml0cyAtIG4pIGJpdHMKLQkgKi8KLQlzcGFuID0gY2FjaGVfc2l6ZSAqIChjb3VudF9v
Zl9iaXRzIC0gbikgLyBjb3VudF9vZl9iaXRzOwotCXN0cmNweShwYXJhbS5jdHJsZ3JwLCAi
YzIiKTsKLQlzdHJjcHkocGFyYW0ubW9uZ3JwLCAibTIiKTsKLQlzdHJjcHkocGFyYW0uZmls
ZW5hbWUsIFJFU1VMVF9GSUxFX05BTUUyKTsKLQlwYXJhbS5tYXNrID0gbF9tYXNrOwotCXBh
cmFtLm51bV9vZl9ydW5zID0gMDsKLQotCWlmIChwaXBlKHBpcGVmZCkpIHsKLQkJcGVycm9y
KCIjIFVuYWJsZSB0byBjcmVhdGUgcGlwZSIpOwotCQlyZXR1cm4gZXJybm87Ci0JfQorCXJl
dCA9IGNhdF90ZXN0KHRlc3QsIHVwYXJhbXMsICZwYXJhbSwgc3Bhbiwgc3RhcnRfbWFzayk7
CisJaWYgKHJldCkKKwkJZ290byBvdXQ7CiAKLQlmZmx1c2goc3Rkb3V0KTsKLQlibV9waWQg
PSBmb3JrKCk7CisJcmV0ID0gY2hlY2tfcmVzdWx0cygmcGFyYW0sIHRlc3QtPnJlc291cmNl
LAorCQkJICAgIGNhY2hlX3RvdGFsX3NpemUsIGZ1bGxfY2FjaGVfbWFzaywgc3RhcnRfbWFz
ayk7CitvdXQ6CisJY2F0X3Rlc3RfY2xlYW51cCgpOwogCi0JLyogU2V0IHBhcmFtIHZhbHVl
cyBmb3IgY2hpbGQgdGhyZWFkIHdoaWNoIHdpbGwgYmUgYWxsb2NhdGVkIGJpdG1hc2sKLQkg
KiB3aXRoIG4gYml0cwotCSAqLwotCWlmIChibV9waWQgPT0gMCkgewotCQlwYXJhbS5tYXNr
ID0gbF9tYXNrXzE7Ci0JCXN0cmNweShwYXJhbS5jdHJsZ3JwLCAiYzEiKTsKLQkJc3RyY3B5
KHBhcmFtLm1vbmdycCwgIm0xIik7Ci0JCXNwYW4gPSBjYWNoZV9zaXplICogbiAvIGNvdW50
X29mX2JpdHM7Ci0JCXN0cmNweShwYXJhbS5maWxlbmFtZSwgUkVTVUxUX0ZJTEVfTkFNRTEp
OwotCQlwYXJhbS5udW1fb2ZfcnVucyA9IDA7Ci0JCXBhcmFtLmNwdV9ubyA9IHNpYmxpbmdf
Y3B1X25vOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgbm9uY29udF9jYXRfcnVu
X3Rlc3QoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwKKwkJCQljb25zdCBzdHJ1
Y3QgdXNlcl9wYXJhbXMgKnVwYXJhbXMpCit7CisJdW5zaWduZWQgbG9uZyBmdWxsX2NhY2hl
X21hc2ssIGNvbnRfbWFzaywgbm9uY29udF9tYXNrOworCXVuc2lnbmVkIGludCBlYXgsIGVi
eCwgZWN4LCBlZHgsIHNwYXJzZV9tYXNrczsKKwlpbnQgYml0X2NlbnRlciwgcmV0OworCWNo
YXIgc2NoZW1hdGFbNjRdOworCisJLyogQ2hlY2sgdG8gY29tcGFyZSBzcGFyc2VfbWFza3Mg
Y29udGVudCB0byBDUFVJRCBvdXRwdXQuICovCisJcmV0ID0gcmVzb3VyY2VfaW5mb191bnNp
Z25lZF9nZXQodGVzdC0+cmVzb3VyY2UsICJzcGFyc2VfbWFza3MiLCAmc3BhcnNlX21hc2tz
KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJaWYgKCFzdHJjbXAodGVzdC0+cmVz
b3VyY2UsICJMMyIpKQorCQlfX2NwdWlkX2NvdW50KDB4MTAsIDEsIGVheCwgZWJ4LCBlY3gs
IGVkeCk7CisJZWxzZSBpZiAoIXN0cmNtcCh0ZXN0LT5yZXNvdXJjZSwgIkwyIikpCisJCV9f
Y3B1aWRfY291bnQoMHgxMCwgMiwgZWF4LCBlYngsIGVjeCwgZWR4KTsKKwllbHNlCisJCXJl
dHVybiAtRUlOVkFMOworCisJaWYgKHNwYXJzZV9tYXNrcyAhPSAoKGVjeCA+PiAzKSAmIDEp
KSB7CisJCWtzZnRfcHJpbnRfbXNnKCJDUFVJRCBvdXRwdXQgZG9lc24ndCBtYXRjaCAnc3Bh
cnNlX21hc2tzJyBmaWxlIGNvbnRlbnQhXG4iKTsKKwkJcmV0dXJuIDE7CiAJfQogCi0JcmVt
b3ZlKHBhcmFtLmZpbGVuYW1lKTsKKwkvKiBXcml0ZSBjaGVja3MgaW5pdGlhbGl6YXRpb24u
ICovCisJcmV0ID0gZ2V0X2Z1bGxfY2JtKHRlc3QtPnJlc291cmNlLCAmZnVsbF9jYWNoZV9t
YXNrKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIHJldDsKKwliaXRfY2VudGVyID0gY291
bnRfYml0cyhmdWxsX2NhY2hlX21hc2spIC8gMjsKIAotCXJldCA9IGNhdF92YWwoJnBhcmFt
LCBzcGFuKTsKLQlpZiAocmV0ID09IDApCi0JCXJldCA9IGNoZWNrX3Jlc3VsdHMoJnBhcmFt
LCBzcGFuKTsKLQotCWlmIChibV9waWQgPT0gMCkgewotCQkvKiBUZWxsIHBhcmVudCB0aGF0
IGNoaWxkIGlzIHJlYWR5ICovCi0JCWNsb3NlKHBpcGVmZFswXSk7Ci0JCXBpcGVfbWVzc2Fn
ZSA9IDE7Ci0JCWlmICh3cml0ZShwaXBlZmRbMV0sICZwaXBlX21lc3NhZ2UsIHNpemVvZihw
aXBlX21lc3NhZ2UpKSA8Ci0JCSAgICBzaXplb2YocGlwZV9tZXNzYWdlKSkKLQkJCS8qCi0J
CQkgKiBKdXN0IHByaW50IHRoZSBlcnJvciBtZXNzYWdlLgotCQkJICogTGV0IHdoaWxlKDEp
IHJ1biBhbmQgd2FpdCBmb3IgaXRzZWxmIHRvIGJlIGtpbGxlZC4KLQkJCSAqLwotCQkJcGVy
cm9yKCIjIGZhaWxlZCBzaWduYWxpbmcgcGFyZW50IHByb2Nlc3MiKTsKLQotCQljbG9zZShw
aXBlZmRbMV0pOwotCQl3aGlsZSAoMSkKLQkJCTsKLQl9IGVsc2UgewotCQkvKiBQYXJlbnQg
d2FpdHMgZm9yIGNoaWxkIHRvIGJlIHJlYWR5LiAqLwotCQljbG9zZShwaXBlZmRbMV0pOwot
CQlwaXBlX21lc3NhZ2UgPSAwOwotCQl3aGlsZSAocGlwZV9tZXNzYWdlICE9IDEpIHsKLQkJ
CWlmIChyZWFkKHBpcGVmZFswXSwgJnBpcGVfbWVzc2FnZSwKLQkJCQkgc2l6ZW9mKHBpcGVf
bWVzc2FnZSkpIDwgc2l6ZW9mKHBpcGVfbWVzc2FnZSkpIHsKLQkJCQlwZXJyb3IoIiMgZmFp
bGVkIHJlYWRpbmcgZnJvbSBjaGlsZCBwcm9jZXNzIik7Ci0JCQkJYnJlYWs7Ci0JCQl9Ci0J
CX0KLQkJY2xvc2UocGlwZWZkWzBdKTsKLQkJa2lsbChibV9waWQsIFNJR0tJTEwpOworCS8q
CisJICogVGhlIGJpdF9jZW50ZXIgbmVlZHMgdG8gYmUgYXQgbGVhc3QgMyB0byBwcm9wZXJs
eSBjYWxjdWxhdGUgdGhlIENCTQorCSAqIGhvbGUgaW4gdGhlIG5vbmNvbnRfbWFzay4gSWYg
aXQncyBzbWFsbGVyIHJldHVybiBhbiBlcnJvciBzaW5jZSB0aGUKKwkgKiBjYWNoZSBtYXNr
IGlzIHRvbyBzaG9ydCBhbmQgdGhhdCBzaG91bGRuJ3QgaGFwcGVuLgorCSAqLworCWlmIChi
aXRfY2VudGVyIDwgMykKKwkJcmV0dXJuIC1FSU5WQUw7CisJY29udF9tYXNrID0gZnVsbF9j
YWNoZV9tYXNrID4+IGJpdF9jZW50ZXI7CisKKwkvKiBDb250aWd1b3VzIG1hc2sgd3JpdGUg
Y2hlY2suICovCisJc25wcmludGYoc2NoZW1hdGEsIHNpemVvZihzY2hlbWF0YSksICIlbHgi
LCBjb250X21hc2spOworCXJldCA9IHdyaXRlX3NjaGVtYXRhKCIiLCBzY2hlbWF0YSwgdXBh
cmFtcy0+Y3B1LCB0ZXN0LT5yZXNvdXJjZSk7CisJaWYgKHJldCkgeworCQlrc2Z0X3ByaW50
X21zZygiV3JpdGUgb2YgY29udGlndW91cyBDQk0gZmFpbGVkXG4iKTsKKwkJcmV0dXJuIDE7
CiAJfQogCi0JY2F0X3Rlc3RfY2xlYW51cCgpOworCS8qCisJICogTm9uLWNvbnRpZ3VvdXMg
bWFzayB3cml0ZSBjaGVjay4gQ0JNIGhhcyBhIDB4ZiBob2xlIGFwcHJveGltYXRlbHkgaW4g
dGhlIG1pZGRsZS4KKwkgKiBPdXRwdXQgaXMgY29tcGFyZWQgd2l0aCBzdXBwb3J0IGluZm9y
bWF0aW9uIHRvIGNhdGNoIGFueSBlZGdlIGNhc2UgZXJyb3JzLgorCSAqLworCW5vbmNvbnRf
bWFzayA9IH4oMHhmVUwgPDwgKGJpdF9jZW50ZXIgLSAyKSkgJiBmdWxsX2NhY2hlX21hc2s7
CisJc25wcmludGYoc2NoZW1hdGEsIHNpemVvZihzY2hlbWF0YSksICIlbHgiLCBub25jb250
X21hc2spOworCXJldCA9IHdyaXRlX3NjaGVtYXRhKCIiLCBzY2hlbWF0YSwgdXBhcmFtcy0+
Y3B1LCB0ZXN0LT5yZXNvdXJjZSk7CisJaWYgKHJldCAmJiBzcGFyc2VfbWFza3MpCisJCWtz
ZnRfcHJpbnRfbXNnKCJOb24tY29udGlndW91cyBDQk1zIHN1cHBvcnRlZCBidXQgd3JpdGUg
b2Ygbm9uLWNvbnRpZ3VvdXMgQ0JNIGZhaWxlZFxuIik7CisJZWxzZSBpZiAocmV0ICYmICFz
cGFyc2VfbWFza3MpCisJCWtzZnRfcHJpbnRfbXNnKCJOb24tY29udGlndW91cyBDQk1zIG5v
dCBzdXBwb3J0ZWQgYW5kIHdyaXRlIG9mIG5vbi1jb250aWd1b3VzIENCTSBmYWlsZWQgYXMg
ZXhwZWN0ZWRcbiIpOworCWVsc2UgaWYgKCFyZXQgJiYgIXNwYXJzZV9tYXNrcykKKwkJa3Nm
dF9wcmludF9tc2coIk5vbi1jb250aWd1b3VzIENCTXMgbm90IHN1cHBvcnRlZCBidXQgd3Jp
dGUgb2Ygbm9uLWNvbnRpZ3VvdXMgQ0JNIHN1Y2NlZWRlZFxuIik7CisKKwlyZXR1cm4gIXJl
dCA9PSAhc3BhcnNlX21hc2tzOworfQogCi0JcmV0dXJuIHJldDsKK3N0YXRpYyBib29sIG5v
bmNvbnRfY2F0X2ZlYXR1cmVfY2hlY2soY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVz
dCkKK3sKKwlpZiAoIXJlc2N0cmxfcmVzb3VyY2VfZXhpc3RzKHRlc3QtPnJlc291cmNlKSkK
KwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJuIHJlc291cmNlX2luZm9fZmlsZV9leGlzdHMo
dGVzdC0+cmVzb3VyY2UsICJzcGFyc2VfbWFza3MiKTsKIH0KKworc3RydWN0IHJlc2N0cmxf
dGVzdCBsM19jYXRfdGVzdCA9IHsKKwkubmFtZSA9ICJMM19DQVQiLAorCS5ncm91cCA9ICJD
QVQiLAorCS5yZXNvdXJjZSA9ICJMMyIsCisJLmZlYXR1cmVfY2hlY2sgPSB0ZXN0X3Jlc291
cmNlX2ZlYXR1cmVfY2hlY2ssCisJLnJ1bl90ZXN0ID0gY2F0X3J1bl90ZXN0LAorfTsKKwor
c3RydWN0IHJlc2N0cmxfdGVzdCBsM19ub25jb250X2NhdF90ZXN0ID0geworCS5uYW1lID0g
IkwzX05PTkNPTlRfQ0FUIiwKKwkuZ3JvdXAgPSAiQ0FUIiwKKwkucmVzb3VyY2UgPSAiTDMi
LAorCS5mZWF0dXJlX2NoZWNrID0gbm9uY29udF9jYXRfZmVhdHVyZV9jaGVjaywKKwkucnVu
X3Rlc3QgPSBub25jb250X2NhdF9ydW5fdGVzdCwKK307CisKK3N0cnVjdCByZXNjdHJsX3Rl
c3QgbDJfbm9uY29udF9jYXRfdGVzdCA9IHsKKwkubmFtZSA9ICJMMl9OT05DT05UX0NBVCIs
CisJLmdyb3VwID0gIkNBVCIsCisJLnJlc291cmNlID0gIkwyIiwKKwkuZmVhdHVyZV9jaGVj
ayA9IG5vbmNvbnRfY2F0X2ZlYXR1cmVfY2hlY2ssCisJLnJ1bl90ZXN0ID0gbm9uY29udF9j
YXRfcnVuX3Rlc3QsCit9OwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9jbXRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9j
bXRfdGVzdC5jCmluZGV4IDUwYmRiY2U5ZmJhOS4uYTgxZjkxMjIyYTg5IDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jCkBAIC0xNiw3ICsxNiw5
IEBACiAjZGVmaW5lIE1BWF9ESUZGCQkyMDAwMDAwCiAjZGVmaW5lIE1BWF9ESUZGX1BFUkNF
TlQJMTUKIAotc3RhdGljIGludCBjbXRfc2V0dXAoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFt
ICpwKQorc3RhdGljIGludCBjbXRfc2V0dXAoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAq
dGVzdCwKKwkJICAgICBjb25zdCBzdHJ1Y3QgdXNlcl9wYXJhbXMgKnVwYXJhbXMsCisJCSAg
ICAgc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwKQogewogCS8qIFJ1biBOVU1fT0ZfUlVO
UyB0aW1lcyAqLwogCWlmIChwLT5udW1fb2ZfcnVucyA+PSBOVU1fT0ZfUlVOUykKQEAgLTI3
LDYgKzI5LDMzIEBAIHN0YXRpYyBpbnQgY210X3NldHVwKHN0cnVjdCByZXNjdHJsX3ZhbF9w
YXJhbSAqcCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCBzaG93X3Jlc3VsdHNfaW5m
byh1bnNpZ25lZCBsb25nIHN1bV9sbGNfdmFsLCBpbnQgbm9fb2ZfYml0cywKKwkJCSAgICAg
dW5zaWduZWQgbG9uZyBjYWNoZV9zcGFuLCB1bnNpZ25lZCBsb25nIG1heF9kaWZmLAorCQkJ
ICAgICB1bnNpZ25lZCBsb25nIG1heF9kaWZmX3BlcmNlbnQsIHVuc2lnbmVkIGxvbmcgbnVt
X29mX3J1bnMsCisJCQkgICAgIGJvb2wgcGxhdGZvcm0pCit7CisJdW5zaWduZWQgbG9uZyBh
dmdfbGxjX3ZhbCA9IDA7CisJZmxvYXQgZGlmZl9wZXJjZW50OworCWxvbmcgYXZnX2RpZmYg
PSAwOworCWludCByZXQ7CisKKwlhdmdfbGxjX3ZhbCA9IHN1bV9sbGNfdmFsIC8gbnVtX29m
X3J1bnM7CisJYXZnX2RpZmYgPSAobG9uZylhYnMoY2FjaGVfc3BhbiAtIGF2Z19sbGNfdmFs
KTsKKwlkaWZmX3BlcmNlbnQgPSAoKGZsb2F0KWNhY2hlX3NwYW4gLSBhdmdfbGxjX3ZhbCkg
LyBjYWNoZV9zcGFuICogMTAwOworCisJcmV0ID0gcGxhdGZvcm0gJiYgYWJzKChpbnQpZGlm
Zl9wZXJjZW50KSA+IG1heF9kaWZmX3BlcmNlbnQgJiYKKwkgICAgICBhYnMoYXZnX2RpZmYp
ID4gbWF4X2RpZmY7CisKKwlrc2Z0X3ByaW50X21zZygiJXMgQ2hlY2sgY2FjaGUgbWlzcyBy
YXRlIHdpdGhpbiAlbHUlJVxuIiwKKwkJICAgICAgIHJldCA/ICJGYWlsOiIgOiAiUGFzczoi
LCBtYXhfZGlmZl9wZXJjZW50KTsKKworCWtzZnRfcHJpbnRfbXNnKCJQZXJjZW50IGRpZmY9
JWRcbiIsIGFicygoaW50KWRpZmZfcGVyY2VudCkpOworCisJc2hvd19jYWNoZV9pbmZvKG5v
X29mX2JpdHMsIGF2Z19sbGNfdmFsLCBjYWNoZV9zcGFuLCBmYWxzZSk7CisKKwlyZXR1cm4g
cmV0OworfQorCiBzdGF0aWMgaW50IGNoZWNrX3Jlc3VsdHMoc3RydWN0IHJlc2N0cmxfdmFs
X3BhcmFtICpwYXJhbSwgc2l6ZV90IHNwYW4sIGludCBub19vZl9iaXRzKQogewogCWNoYXIg
KnRva2VuX2FycmF5WzhdLCB0ZW1wWzUxMl07CkBAIC0zNyw5ICs2Niw5IEBAIHN0YXRpYyBp
bnQgY2hlY2tfcmVzdWx0cyhzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtLCBzaXpl
X3Qgc3BhbiwgaW50IG5vX29mCiAJa3NmdF9wcmludF9tc2coIkNoZWNraW5nIGZvciBwYXNz
L2ZhaWxcbiIpOwogCWZwID0gZm9wZW4ocGFyYW0tPmZpbGVuYW1lLCAiciIpOwogCWlmICgh
ZnApIHsKLQkJcGVycm9yKCIjIEVycm9yIGluIG9wZW5pbmcgZmlsZVxuIik7CisJCWtzZnRf
cGVycm9yKCJFcnJvciBpbiBvcGVuaW5nIGZpbGUiKTsKIAotCQlyZXR1cm4gZXJybm87CisJ
CXJldHVybiAtMTsKIAl9CiAKIAl3aGlsZSAoZmdldHModGVtcCwgc2l6ZW9mKHRlbXApLCBm
cCkpIHsKQEAgLTU4LDkgKzg3LDggQEAgc3RhdGljIGludCBjaGVja19yZXN1bHRzKHN0cnVj
dCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0sIHNpemVfdCBzcGFuLCBpbnQgbm9fb2YKIAl9
CiAJZmNsb3NlKGZwKTsKIAotCXJldHVybiBzaG93X2NhY2hlX2luZm8oc3VtX2xsY19vY2N1
X3Jlc2MsIG5vX29mX2JpdHMsIHNwYW4sCi0JCQkgICAgICAgTUFYX0RJRkYsIE1BWF9ESUZG
X1BFUkNFTlQsIHJ1bnMgLSAxLAotCQkJICAgICAgIHRydWUsIHRydWUpOworCXJldHVybiBz
aG93X3Jlc3VsdHNfaW5mbyhzdW1fbGxjX29jY3VfcmVzYywgbm9fb2ZfYml0cywgc3BhbiwK
KwkJCQkgTUFYX0RJRkYsIE1BWF9ESUZGX1BFUkNFTlQsIHJ1bnMgLSAxLCB0cnVlKTsKIH0K
IAogdm9pZCBjbXRfdGVzdF9jbGVhbnVwKHZvaWQpCkBAIC02OCwyOCArOTYsMjYgQEAgdm9p
ZCBjbXRfdGVzdF9jbGVhbnVwKHZvaWQpCiAJcmVtb3ZlKFJFU1VMVF9GSUxFX05BTUUpOwog
fQogCi1pbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGludCBuLCBjb25zdCBjaGFy
ICogY29uc3QgKmJlbmNobWFya19jbWQpCitzdGF0aWMgaW50IGNtdF9ydW5fdGVzdChjb25z
dCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LCBjb25zdCBzdHJ1Y3QgdXNlcl9wYXJhbXMg
KnVwYXJhbXMpCiB7Ci0JY29uc3QgY2hhciAqIGNvbnN0ICpjbWQgPSBiZW5jaG1hcmtfY21k
OworCWNvbnN0IGNoYXIgKiBjb25zdCAqY21kID0gdXBhcmFtcy0+YmVuY2htYXJrX2NtZDsK
IAljb25zdCBjaGFyICpuZXdfY21kW0JFTkNITUFSS19BUkdTXTsKLQl1bnNpZ25lZCBsb25n
IGNhY2hlX3NpemUgPSAwOworCXVuc2lnbmVkIGxvbmcgY2FjaGVfdG90YWxfc2l6ZSA9IDA7
CisJaW50IG4gPSB1cGFyYW1zLT5iaXRzID8gOiA1OwogCXVuc2lnbmVkIGxvbmcgbG9uZ19t
YXNrOwogCWNoYXIgKnNwYW5fc3RyID0gTlVMTDsKLQljaGFyIGNibV9tYXNrWzI1Nl07CiAJ
aW50IGNvdW50X29mX2JpdHM7CiAJc2l6ZV90IHNwYW47CiAJaW50IHJldCwgaTsKIAotCXJl
dCA9IGdldF9jYm1fbWFzaygiTDMiLCBjYm1fbWFzayk7CisJcmV0ID0gZ2V0X2Z1bGxfY2Jt
KCJMMyIsICZsb25nX21hc2spOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLQlsb25n
X21hc2sgPSBzdHJ0b3VsKGNibV9tYXNrLCBOVUxMLCAxNik7Ci0KLQlyZXQgPSBnZXRfY2Fj
aGVfc2l6ZShjcHVfbm8sICJMMyIsICZjYWNoZV9zaXplKTsKKwlyZXQgPSBnZXRfY2FjaGVf
c2l6ZSh1cGFyYW1zLT5jcHUsICJMMyIsICZjYWNoZV90b3RhbF9zaXplKTsKIAlpZiAocmV0
KQogCQlyZXR1cm4gcmV0OwotCWtzZnRfcHJpbnRfbXNnKCJDYWNoZSBzaXplIDolbHVcbiIs
IGNhY2hlX3NpemUpOworCWtzZnRfcHJpbnRfbXNnKCJDYWNoZSBzaXplIDolbHVcbiIsIGNh
Y2hlX3RvdGFsX3NpemUpOwogCiAJY291bnRfb2ZfYml0cyA9IGNvdW50X2JpdHMobG9uZ19t
YXNrKTsKIApAQCAtMTAzLDE5ICsxMjksMTggQEAgaW50IGNtdF9yZXNjdHJsX3ZhbChpbnQg
Y3B1X25vLCBpbnQgbiwgY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kKQogCQku
cmVzY3RybF92YWwJPSBDTVRfU1RSLAogCQkuY3RybGdycAk9ICJjMSIsCiAJCS5tb25ncnAJ
CT0gIm0xIiwKLQkJLmNwdV9ubwkJPSBjcHVfbm8sCiAJCS5maWxlbmFtZQk9IFJFU1VMVF9G
SUxFX05BTUUsCiAJCS5tYXNrCQk9IH4obG9uZ19tYXNrIDw8IG4pICYgbG9uZ19tYXNrLAog
CQkubnVtX29mX3J1bnMJPSAwLAogCQkuc2V0dXAJCT0gY210X3NldHVwLAogCX07CiAKLQlz
cGFuID0gY2FjaGVfc2l6ZSAqIG4gLyBjb3VudF9vZl9iaXRzOworCXNwYW4gPSBjYWNoZV9w
b3J0aW9uX3NpemUoY2FjaGVfdG90YWxfc2l6ZSwgcGFyYW0ubWFzaywgbG9uZ19tYXNrKTsK
IAogCWlmIChzdHJjbXAoY21kWzBdLCAiZmlsbF9idWYiKSA9PSAwKSB7CiAJCS8qIER1cGxp
Y2F0ZSB0aGUgY29tbWFuZCB0byBiZSBhYmxlIHRvIHJlcGxhY2Ugc3BhbiBpbiBpdCAqLwot
CQlmb3IgKGkgPSAwOyBiZW5jaG1hcmtfY21kW2ldOyBpKyspCi0JCQluZXdfY21kW2ldID0g
YmVuY2htYXJrX2NtZFtpXTsKKwkJZm9yIChpID0gMDsgdXBhcmFtcy0+YmVuY2htYXJrX2Nt
ZFtpXTsgaSsrKQorCQkJbmV3X2NtZFtpXSA9IHVwYXJhbXMtPmJlbmNobWFya19jbWRbaV07
CiAJCW5ld19jbWRbaV0gPSBOVUxMOwogCiAJCXJldCA9IGFzcHJpbnRmKCZzcGFuX3N0ciwg
IiV6dSIsIHNwYW4pOwpAQCAtMTI3LDExICsxNTIsMTMgQEAgaW50IGNtdF9yZXNjdHJsX3Zh
bChpbnQgY3B1X25vLCBpbnQgbiwgY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21k
KQogCiAJcmVtb3ZlKFJFU1VMVF9GSUxFX05BTUUpOwogCi0JcmV0ID0gcmVzY3RybF92YWwo
Y21kLCAmcGFyYW0pOworCXJldCA9IHJlc2N0cmxfdmFsKHRlc3QsIHVwYXJhbXMsIGNtZCwg
JnBhcmFtKTsKIAlpZiAocmV0KQogCQlnb3RvIG91dDsKIAogCXJldCA9IGNoZWNrX3Jlc3Vs
dHMoJnBhcmFtLCBzcGFuLCBuKTsKKwlpZiAocmV0ICYmIChnZXRfdmVuZG9yKCkgPT0gQVJD
SF9JTlRFTCkpCisJCWtzZnRfcHJpbnRfbXNnKCJJbnRlbCBDTVQgbWF5IGJlIGluYWNjdXJh
dGUgd2hlbiBTdWItTlVNQSBDbHVzdGVyaW5nIGlzIGVuYWJsZWQuIENoZWNrIEJJT1MgY29u
ZmlndXJhdGlvbi5cbiIpOwogCiBvdXQ6CiAJY210X3Rlc3RfY2xlYW51cCgpOwpAQCAtMTM5
LDMgKzE2NiwxNiBAQCBpbnQgY210X3Jlc2N0cmxfdmFsKGludCBjcHVfbm8sIGludCBuLCBj
b25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQpCiAKIAlyZXR1cm4gcmV0OwogfQor
CitzdGF0aWMgYm9vbCBjbXRfZmVhdHVyZV9jaGVjayhjb25zdCBzdHJ1Y3QgcmVzY3RybF90
ZXN0ICp0ZXN0KQoreworCXJldHVybiB0ZXN0X3Jlc291cmNlX2ZlYXR1cmVfY2hlY2sodGVz
dCkgJiYKKwkgICAgICAgcmVzY3RybF9tb25fZmVhdHVyZV9leGlzdHMoIkwzX01PTiIsICJs
bGNfb2NjdXBhbmN5Iik7Cit9CisKK3N0cnVjdCByZXNjdHJsX3Rlc3QgY210X3Rlc3QgPSB7
CisJLm5hbWUgPSAiQ01UIiwKKwkucmVzb3VyY2UgPSAiTDMiLAorCS5mZWF0dXJlX2NoZWNr
ID0gY210X2ZlYXR1cmVfY2hlY2ssCisJLnJ1bl90ZXN0ID0gY210X3J1bl90ZXN0LAorfTsK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvZmlsbF9idWYuYwppbmRleCAw
ZDQyNWYyNjU4M2EuLmFlMTIwZjE3MzVjMCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9maWxsX2J1Zi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwvZmlsbF9idWYuYwpAQCAtMzgsNyArMzgsNyBAQCBzdGF0aWMgdm9pZCBj
bF9mbHVzaCh2b2lkICpwKQogI2VuZGlmCiB9CiAKLXN0YXRpYyB2b2lkIG1lbV9mbHVzaCh1
bnNpZ25lZCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6ZSkKK3ZvaWQgbWVtX2ZsdXNoKHVu
c2lnbmVkIGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9zaXplKQogewogCXVuc2lnbmVkIGNoYXIg
KmNwID0gYnVmOwogCXNpemVfdCBpID0gMDsKQEAgLTUxLDM5ICs1MSwzOCBAQCBzdGF0aWMg
dm9pZCBtZW1fZmx1c2godW5zaWduZWQgY2hhciAqYnVmLCBzaXplX3QgYnVmX3NpemUpCiAJ
c2IoKTsKIH0KIAotc3RhdGljIHZvaWQgKm1hbGxvY19hbmRfaW5pdF9tZW1vcnkoc2l6ZV90
IGJ1Zl9zaXplKQotewotCXZvaWQgKnAgPSBOVUxMOwotCXVpbnQ2NF90ICpwNjQ7Ci0Jc2l6
ZV90IHM2NDsKLQlpbnQgcmV0OwotCi0JcmV0ID0gcG9zaXhfbWVtYWxpZ24oJnAsIFBBR0Vf
U0laRSwgYnVmX3NpemUpOwotCWlmIChyZXQgPCAwKQotCQlyZXR1cm4gTlVMTDsKLQotCXA2
NCA9ICh1aW50NjRfdCAqKXA7Ci0JczY0ID0gYnVmX3NpemUgLyBzaXplb2YodWludDY0X3Qp
OwotCi0Jd2hpbGUgKHM2NCA+IDApIHsKLQkJKnA2NCA9ICh1aW50NjRfdClyYW5kKCk7Ci0J
CXA2NCArPSAoQ0xfU0laRSAvIHNpemVvZih1aW50NjRfdCkpOwotCQlzNjQgLT0gKENMX1NJ
WkUgLyBzaXplb2YodWludDY0X3QpKTsKLQl9Ci0KLQlyZXR1cm4gcDsKLX0KKy8qCisgKiBC
dWZmZXIgaW5kZXggc3RlcCBhZHZhbmNlIHRvIHdvcmthcm91bmQgSFcgcHJlZmV0Y2hpbmcg
aW50ZXJmZXJpbmcgd2l0aAorICogdGhlIG1lYXN1cmVtZW50cy4KKyAqCisgKiBNdXN0IGJl
IGEgcHJpbWUgdG8gc3RlcCB0aHJvdWdoIGFsbCBpbmRleGVzIG9mIHRoZSBidWZmZXIuCisg
KgorICogU29tZSBwcmltZXMgd29yayBiZXR0ZXIgdGhhbiBvdGhlcnMgb24gc29tZSBhcmNo
aXRlY3R1cmVzIChmcm9tIE1CQS9NQk0KKyAqIHJlc3VsdCBzdGFiaWxpdHkgcG9pbnQgb2Yg
dmlldykuCisgKi8KKyNkZWZpbmUgRklMTF9JRFhfTVVMVAkyMwogCiBzdGF0aWMgaW50IGZp
bGxfb25lX3NwYW5fcmVhZCh1bnNpZ25lZCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6ZSkK
IHsKLQl1bnNpZ25lZCBjaGFyICplbmRfcHRyID0gYnVmICsgYnVmX3NpemU7Ci0JdW5zaWdu
ZWQgY2hhciBzdW0sICpwOwotCi0Jc3VtID0gMDsKLQlwID0gYnVmOwotCXdoaWxlIChwIDwg
ZW5kX3B0cikgewotCQlzdW0gKz0gKnA7Ci0JCXAgKz0gKENMX1NJWkUgLyAyKTsKKwl1bnNp
Z25lZCBpbnQgc2l6ZSA9IGJ1Zl9zaXplIC8gKENMX1NJWkUgLyAyKTsKKwl1bnNpZ25lZCBp
bnQgaSwgaWR4ID0gMDsKKwl1bnNpZ25lZCBjaGFyIHN1bSA9IDA7CisKKwkvKgorCSAqIFJl
YWQgdGhlIGJ1ZmZlciBpbiBhbiBvcmRlciB0aGF0IGlzIHVuZXhwZWN0ZWQgYnkgSFcgcHJl
ZmV0Y2hpbmcKKwkgKiBvcHRpbWl6YXRpb25zIHRvIHByZXZlbnQgdGhlbSBpbnRlcmZlcmlu
ZyB3aXRoIHRoZSBjYWNoaW5nIHBhdHRlcm4uCisJICoKKwkgKiBUaGUgcmVhZCBvcmRlciBp
cyAoaW4gdGVybXMgb2YgaGFsdmVzIG9mIGNhY2hlbGluZXMpOgorCSAqCWkgKiBGSUxMX0lE
WF9NVUxUICUgc2l6ZQorCSAqIFRoZSBmb3JtdWxhIGlzIG9wZW4tY29kZWQgYmVsb3cgdG8g
YXZvaWRpbmcgbW9kdWxvIGluc2lkZSB0aGUgbG9vcAorCSAqIGFzIGl0IGltcHJvdmVzIE1C
QS9NQk0gcmVzdWx0IHN0YWJpbGl0eSBvbiBzb21lIGFyY2hpdGVjdHVyZXMuCisJICovCisJ
Zm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgeworCQlzdW0gKz0gYnVmW2lkeCAqIChDTF9T
SVpFIC8gMildOworCisJCWlkeCArPSBGSUxMX0lEWF9NVUxUOworCQl3aGlsZSAoaWR4ID49
IHNpemUpCisJCQlpZHggLT0gc2l6ZTsKIAl9CiAKIAlyZXR1cm4gc3VtOwpAQCAtMTAxLDEw
ICsxMDAsOSBAQCBzdGF0aWMgdm9pZCBmaWxsX29uZV9zcGFuX3dyaXRlKHVuc2lnbmVkIGNo
YXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9zaXplKQogCX0KIH0KIAotc3RhdGljIGludCBmaWxsX2Nh
Y2hlX3JlYWQodW5zaWduZWQgY2hhciAqYnVmLCBzaXplX3QgYnVmX3NpemUsIGJvb2wgb25j
ZSkKK3ZvaWQgZmlsbF9jYWNoZV9yZWFkKHVuc2lnbmVkIGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1
Zl9zaXplLCBib29sIG9uY2UpCiB7CiAJaW50IHJldCA9IDA7Ci0JRklMRSAqZnA7CiAKIAl3
aGlsZSAoMSkgewogCQlyZXQgPSBmaWxsX29uZV9zcGFuX3JlYWQoYnVmLCBidWZfc2l6ZSk7
CkBAIC0xMTMsNjcgKzExMSw1OSBAQCBzdGF0aWMgaW50IGZpbGxfY2FjaGVfcmVhZCh1bnNp
Z25lZCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6ZSwgYm9vbCBvbmNlKQogCX0KIAogCS8q
IENvbnN1bWUgcmVhZCByZXN1bHQgc28gdGhhdCByZWFkaW5nIG1lbW9yeSBpcyBub3Qgb3B0
aW1pemVkIG91dC4gKi8KLQlmcCA9IGZvcGVuKCIvZGV2L251bGwiLCAidyIpOwotCWlmICgh
ZnApIHsKLQkJcGVycm9yKCJVbmFibGUgdG8gd3JpdGUgdG8gL2Rldi9udWxsIik7Ci0JCXJl
dHVybiAtMTsKLQl9Ci0JZnByaW50ZihmcCwgIlN1bTogJWQgIiwgcmV0KTsKLQlmY2xvc2Uo
ZnApOwotCi0JcmV0dXJuIDA7CisJKnZhbHVlX3NpbmsgPSByZXQ7CiB9CiAKLXN0YXRpYyBp
bnQgZmlsbF9jYWNoZV93cml0ZSh1bnNpZ25lZCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6
ZSwgYm9vbCBvbmNlKQorc3RhdGljIHZvaWQgZmlsbF9jYWNoZV93cml0ZSh1bnNpZ25lZCBj
aGFyICpidWYsIHNpemVfdCBidWZfc2l6ZSwgYm9vbCBvbmNlKQogewogCXdoaWxlICgxKSB7
CiAJCWZpbGxfb25lX3NwYW5fd3JpdGUoYnVmLCBidWZfc2l6ZSk7CiAJCWlmIChvbmNlKQog
CQkJYnJlYWs7CiAJfQotCi0JcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgZmlsbF9jYWNo
ZShzaXplX3QgYnVmX3NpemUsIGludCBtZW1mbHVzaCwgaW50IG9wLCBib29sIG9uY2UpCit1
bnNpZ25lZCBjaGFyICphbGxvY19idWZmZXIoc2l6ZV90IGJ1Zl9zaXplLCBpbnQgbWVtZmx1
c2gpCiB7Ci0JdW5zaWduZWQgY2hhciAqYnVmOworCXZvaWQgKmJ1ZiA9IE5VTEw7CisJdWlu
dDY0X3QgKnA2NDsKKwlzaXplX3QgczY0OwogCWludCByZXQ7CiAKLQlidWYgPSBtYWxsb2Nf
YW5kX2luaXRfbWVtb3J5KGJ1Zl9zaXplKTsKLQlpZiAoIWJ1ZikKLQkJcmV0dXJuIC0xOwot
Ci0JLyogRmx1c2ggdGhlIG1lbW9yeSBiZWZvcmUgdXNpbmcgdG8gYXZvaWQgImNhY2hlIGhv
dCBwYWdlcyIgZWZmZWN0ICovCi0JaWYgKG1lbWZsdXNoKQotCQltZW1fZmx1c2goYnVmLCBi
dWZfc2l6ZSk7Ci0KLQlpZiAob3AgPT0gMCkKLQkJcmV0ID0gZmlsbF9jYWNoZV9yZWFkKGJ1
ZiwgYnVmX3NpemUsIG9uY2UpOwotCWVsc2UKLQkJcmV0ID0gZmlsbF9jYWNoZV93cml0ZShi
dWYsIGJ1Zl9zaXplLCBvbmNlKTsKKwlyZXQgPSBwb3NpeF9tZW1hbGlnbigmYnVmLCBQQUdF
X1NJWkUsIGJ1Zl9zaXplKTsKKwlpZiAocmV0IDwgMCkKKwkJcmV0dXJuIE5VTEw7CiAKLQlm
cmVlKGJ1Zik7CisJLyogSW5pdGlhbGl6ZSB0aGUgYnVmZmVyICovCisJcDY0ID0gYnVmOwor
CXM2NCA9IGJ1Zl9zaXplIC8gc2l6ZW9mKHVpbnQ2NF90KTsKIAotCWlmIChyZXQpIHsKLQkJ
cHJpbnRmKCJcbiBFcnJvciBpbiBmaWxsIGNhY2hlIHJlYWQvd3JpdGUuLi5cbiIpOwotCQly
ZXR1cm4gLTE7CisJd2hpbGUgKHM2NCA+IDApIHsKKwkJKnA2NCA9ICh1aW50NjRfdClyYW5k
KCk7CisJCXA2NCArPSAoQ0xfU0laRSAvIHNpemVvZih1aW50NjRfdCkpOworCQlzNjQgLT0g
KENMX1NJWkUgLyBzaXplb2YodWludDY0X3QpKTsKIAl9CiAKKwkvKiBGbHVzaCB0aGUgbWVt
b3J5IGJlZm9yZSB1c2luZyB0byBhdm9pZCAiY2FjaGUgaG90IHBhZ2VzIiBlZmZlY3QgKi8K
KwlpZiAobWVtZmx1c2gpCisJCW1lbV9mbHVzaChidWYsIGJ1Zl9zaXplKTsKIAotCXJldHVy
biAwOworCXJldHVybiBidWY7CiB9CiAKLWludCBydW5fZmlsbF9idWYoc2l6ZV90IHNwYW4s
IGludCBtZW1mbHVzaCwgaW50IG9wLCBib29sIG9uY2UpCitpbnQgcnVuX2ZpbGxfYnVmKHNp
emVfdCBidWZfc2l6ZSwgaW50IG1lbWZsdXNoLCBpbnQgb3AsIGJvb2wgb25jZSkKIHsKLQlz
aXplX3QgY2FjaGVfc2l6ZSA9IHNwYW47Ci0JaW50IHJldDsKKwl1bnNpZ25lZCBjaGFyICpi
dWY7CiAKLQlyZXQgPSBmaWxsX2NhY2hlKGNhY2hlX3NpemUsIG1lbWZsdXNoLCBvcCwgb25j
ZSk7Ci0JaWYgKHJldCkgewotCQlwcmludGYoIlxuIEVycm9yIGluIGZpbGwgY2FjaGVcbiIp
OworCWJ1ZiA9IGFsbG9jX2J1ZmZlcihidWZfc2l6ZSwgbWVtZmx1c2gpOworCWlmICghYnVm
KQogCQlyZXR1cm4gLTE7Ci0JfQorCisJaWYgKG9wID09IDApCisJCWZpbGxfY2FjaGVfcmVh
ZChidWYsIGJ1Zl9zaXplLCBvbmNlKTsKKwllbHNlCisJCWZpbGxfY2FjaGVfd3JpdGUoYnVm
LCBidWZfc2l6ZSwgb25jZSk7CisJZnJlZShidWYpOwogCiAJcmV0dXJuIDA7CiB9CmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21iYV90ZXN0LmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21iYV90ZXN0LmMKaW5kZXggZDNiZjQz
NjgzNDFlLi43OTQ2ZTMyZTg1YzggMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwvbWJhX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL21iYV90ZXN0LmMKQEAgLTIyLDcgKzIyLDkgQEAKICAqIGNvbl9tb24gZ3JwLCBt
b25fZ3JwIGluIHJlc2N0cmwgRlMuCiAgKiBGb3IgZWFjaCBhbGxvY2F0aW9uLCBydW4gNSB0
aW1lcyBpbiBvcmRlciB0byBnZXQgYXZlcmFnZSB2YWx1ZXMuCiAgKi8KLXN0YXRpYyBpbnQg
bWJhX3NldHVwKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcCkKK3N0YXRpYyBpbnQgbWJh
X3NldHVwKGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QsCisJCSAgICAgY29uc3Qg
c3RydWN0IHVzZXJfcGFyYW1zICp1cGFyYW1zLAorCQkgICAgIHN0cnVjdCByZXNjdHJsX3Zh
bF9wYXJhbSAqcCkKIHsKIAlzdGF0aWMgaW50IHJ1bnNfcGVyX2FsbG9jYXRpb24sIGFsbG9j
YXRpb24gPSAxMDA7CiAJY2hhciBhbGxvY2F0aW9uX3N0cls2NF07CkBAIC00MCw4ICs0Miw3
IEBAIHN0YXRpYyBpbnQgbWJhX3NldHVwKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcCkK
IAogCXNwcmludGYoYWxsb2NhdGlvbl9zdHIsICIlZCIsIGFsbG9jYXRpb24pOwogCi0JcmV0
ID0gd3JpdGVfc2NoZW1hdGEocC0+Y3RybGdycCwgYWxsb2NhdGlvbl9zdHIsIHAtPmNwdV9u
bywKLQkJCSAgICAgcC0+cmVzY3RybF92YWwpOworCXJldCA9IHdyaXRlX3NjaGVtYXRhKHAt
PmN0cmxncnAsIGFsbG9jYXRpb25fc3RyLCB1cGFyYW1zLT5jcHUsIHRlc3QtPnJlc291cmNl
KTsKIAlpZiAocmV0IDwgMCkKIAkJcmV0dXJuIHJldDsKIApAQCAtMTA5LDkgKzExMCw5IEBA
IHN0YXRpYyBpbnQgY2hlY2tfcmVzdWx0cyh2b2lkKQogCiAJZnAgPSBmb3BlbihvdXRwdXQs
ICJyIik7CiAJaWYgKCFmcCkgewotCQlwZXJyb3Iob3V0cHV0KTsKKwkJa3NmdF9wZXJyb3Io
b3V0cHV0KTsKIAotCQlyZXR1cm4gZXJybm87CisJCXJldHVybiAtMTsKIAl9CiAKIAlydW5z
ID0gMDsKQEAgLTE0MSwxMyArMTQyLDEyIEBAIHZvaWQgbWJhX3Rlc3RfY2xlYW51cCh2b2lk
KQogCXJlbW92ZShSRVNVTFRfRklMRV9OQU1FKTsKIH0KIAotaW50IG1iYV9zY2hlbWF0YV9j
aGFuZ2UoaW50IGNwdV9ubywgY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kKQor
c3RhdGljIGludCBtYmFfcnVuX3Rlc3QoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVz
dCwgY29uc3Qgc3RydWN0IHVzZXJfcGFyYW1zICp1cGFyYW1zKQogewogCXN0cnVjdCByZXNj
dHJsX3ZhbF9wYXJhbSBwYXJhbSA9IHsKIAkJLnJlc2N0cmxfdmFsCT0gTUJBX1NUUiwKIAkJ
LmN0cmxncnAJPSAiYzEiLAogCQkubW9uZ3JwCQk9ICJtMSIsCi0JCS5jcHVfbm8JCT0gY3B1
X25vLAogCQkuZmlsZW5hbWUJPSBSRVNVTFRfRklMRV9OQU1FLAogCQkuYndfcmVwb3J0CT0g
InJlYWRzIiwKIAkJLnNldHVwCQk9IG1iYV9zZXR1cApAQCAtMTU2LDcgKzE1Niw3IEBAIGlu
dCBtYmFfc2NoZW1hdGFfY2hhbmdlKGludCBjcHVfbm8sIGNvbnN0IGNoYXIgKiBjb25zdCAq
YmVuY2htYXJrX2NtZCkKIAogCXJlbW92ZShSRVNVTFRfRklMRV9OQU1FKTsKIAotCXJldCA9
IHJlc2N0cmxfdmFsKGJlbmNobWFya19jbWQsICZwYXJhbSk7CisJcmV0ID0gcmVzY3RybF92
YWwodGVzdCwgdXBhcmFtcywgdXBhcmFtcy0+YmVuY2htYXJrX2NtZCwgJnBhcmFtKTsKIAlp
ZiAocmV0KQogCQlnb3RvIG91dDsKIApAQCAtMTY3LDMgKzE2NywxNyBAQCBpbnQgbWJhX3Nj
aGVtYXRhX2NoYW5nZShpbnQgY3B1X25vLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFy
a19jbWQpCiAKIAlyZXR1cm4gcmV0OwogfQorCitzdGF0aWMgYm9vbCBtYmFfZmVhdHVyZV9j
aGVjayhjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0KQoreworCXJldHVybiB0ZXN0
X3Jlc291cmNlX2ZlYXR1cmVfY2hlY2sodGVzdCkgJiYKKwkgICAgICAgcmVzY3RybF9tb25f
ZmVhdHVyZV9leGlzdHMoIkwzX01PTiIsICJtYm1fbG9jYWxfYnl0ZXMiKTsKK30KKworc3Ry
dWN0IHJlc2N0cmxfdGVzdCBtYmFfdGVzdCA9IHsKKwkubmFtZSA9ICJNQkEiLAorCS5yZXNv
dXJjZSA9ICJNQiIsCisJLnZlbmRvcl9zcGVjaWZpYyA9IEFSQ0hfSU5URUwsCisJLmZlYXR1
cmVfY2hlY2sgPSBtYmFfZmVhdHVyZV9jaGVjaywKKwkucnVuX3Rlc3QgPSBtYmFfcnVuX3Rl
c3QsCit9OwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9t
Ym1fdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYm1fdGVzdC5j
CmluZGV4IDc0MTUzM2YyYjA3NS4uZDY3ZmZhM2VjNjNhIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9tYm1fdGVzdC5jCkBAIC01OSw5ICs1OSw5IEBAIHN0YXRp
YyBpbnQgY2hlY2tfcmVzdWx0cyhzaXplX3Qgc3BhbikKIAogCWZwID0gZm9wZW4ob3V0cHV0
LCAiciIpOwogCWlmICghZnApIHsKLQkJcGVycm9yKG91dHB1dCk7CisJCWtzZnRfcGVycm9y
KG91dHB1dCk7CiAKLQkJcmV0dXJuIGVycm5vOworCQlyZXR1cm4gLTE7CiAJfQogCiAJcnVu
cyA9IDA7CkBAIC04Niw3ICs4Niw5IEBAIHN0YXRpYyBpbnQgY2hlY2tfcmVzdWx0cyhzaXpl
X3Qgc3BhbikKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgaW50IG1ibV9zZXR1cChzdHJ1
Y3QgcmVzY3RybF92YWxfcGFyYW0gKnApCitzdGF0aWMgaW50IG1ibV9zZXR1cChjb25zdCBz
dHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LAorCQkgICAgIGNvbnN0IHN0cnVjdCB1c2VyX3Bh
cmFtcyAqdXBhcmFtcywKKwkJICAgICBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnApCiB7
CiAJaW50IHJldCA9IDA7CiAKQEAgLTk1LDkgKzk3LDggQEAgc3RhdGljIGludCBtYm1fc2V0
dXAoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwKQogCQlyZXR1cm4gRU5EX09GX1RFU1RT
OwogCiAJLyogU2V0IHVwIHNoZW1hdGEgd2l0aCAxMDAlIGFsbG9jYXRpb24gb24gdGhlIGZp
cnN0IHJ1bi4gKi8KLQlpZiAocC0+bnVtX29mX3J1bnMgPT0gMCAmJiB2YWxpZGF0ZV9yZXNj
dHJsX2ZlYXR1cmVfcmVxdWVzdCgiTUIiLCBOVUxMKSkKLQkJcmV0ID0gd3JpdGVfc2NoZW1h
dGEocC0+Y3RybGdycCwgIjEwMCIsIHAtPmNwdV9ubywKLQkJCQkgICAgIHAtPnJlc2N0cmxf
dmFsKTsKKwlpZiAocC0+bnVtX29mX3J1bnMgPT0gMCAmJiByZXNjdHJsX3Jlc291cmNlX2V4
aXN0cygiTUIiKSkKKwkJcmV0ID0gd3JpdGVfc2NoZW1hdGEocC0+Y3RybGdycCwgIjEwMCIs
IHVwYXJhbXMtPmNwdSwgdGVzdC0+cmVzb3VyY2UpOwogCiAJcC0+bnVtX29mX3J1bnMrKzsK
IApAQCAtMTA5LDEzICsxMTAsMTIgQEAgdm9pZCBtYm1fdGVzdF9jbGVhbnVwKHZvaWQpCiAJ
cmVtb3ZlKFJFU1VMVF9GSUxFX05BTUUpOwogfQogCi1pbnQgbWJtX2J3X2NoYW5nZShpbnQg
Y3B1X25vLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQpCitzdGF0aWMgaW50
IG1ibV9ydW5fdGVzdChjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LCBjb25zdCBz
dHJ1Y3QgdXNlcl9wYXJhbXMgKnVwYXJhbXMpCiB7CiAJc3RydWN0IHJlc2N0cmxfdmFsX3Bh
cmFtIHBhcmFtID0gewogCQkucmVzY3RybF92YWwJPSBNQk1fU1RSLAogCQkuY3RybGdycAk9
ICJjMSIsCiAJCS5tb25ncnAJCT0gIm0xIiwKLQkJLmNwdV9ubwkJPSBjcHVfbm8sCiAJCS5m
aWxlbmFtZQk9IFJFU1VMVF9GSUxFX05BTUUsCiAJCS5id19yZXBvcnQJPSAicmVhZHMiLAog
CQkuc2V0dXAJCT0gbWJtX3NldHVwCkBAIC0xMjQsMTQgKzEyNCwzMCBAQCBpbnQgbWJtX2J3
X2NoYW5nZShpbnQgY3B1X25vLCBjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQp
CiAKIAlyZW1vdmUoUkVTVUxUX0ZJTEVfTkFNRSk7CiAKLQlyZXQgPSByZXNjdHJsX3ZhbChi
ZW5jaG1hcmtfY21kLCAmcGFyYW0pOworCXJldCA9IHJlc2N0cmxfdmFsKHRlc3QsIHVwYXJh
bXMsIHVwYXJhbXMtPmJlbmNobWFya19jbWQsICZwYXJhbSk7CiAJaWYgKHJldCkKIAkJZ290
byBvdXQ7CiAKIAlyZXQgPSBjaGVja19yZXN1bHRzKERFRkFVTFRfU1BBTik7CisJaWYgKHJl
dCAmJiAoZ2V0X3ZlbmRvcigpID09IEFSQ0hfSU5URUwpKQorCQlrc2Z0X3ByaW50X21zZygi
SW50ZWwgTUJNIG1heSBiZSBpbmFjY3VyYXRlIHdoZW4gU3ViLU5VTUEgQ2x1c3RlcmluZyBp
cyBlbmFibGVkLiBDaGVjayBCSU9TIGNvbmZpZ3VyYXRpb24uXG4iKTsKIAogb3V0OgogCW1i
bV90ZXN0X2NsZWFudXAoKTsKIAogCXJldHVybiByZXQ7CiB9CisKK3N0YXRpYyBib29sIG1i
bV9mZWF0dXJlX2NoZWNrKGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QpCit7CisJ
cmV0dXJuIHJlc2N0cmxfbW9uX2ZlYXR1cmVfZXhpc3RzKCJMM19NT04iLCAibWJtX3RvdGFs
X2J5dGVzIikgJiYKKwkgICAgICAgcmVzY3RybF9tb25fZmVhdHVyZV9leGlzdHMoIkwzX01P
TiIsICJtYm1fbG9jYWxfYnl0ZXMiKTsKK30KKworc3RydWN0IHJlc2N0cmxfdGVzdCBtYm1f
dGVzdCA9IHsKKwkubmFtZSA9ICJNQk0iLAorCS5yZXNvdXJjZSA9ICJNQiIsCisJLnZlbmRv
cl9zcGVjaWZpYyA9IEFSQ0hfSU5URUwsCisJLmZlYXR1cmVfY2hlY2sgPSBtYm1fZmVhdHVy
ZV9jaGVjaywKKwkucnVuX3Rlc3QgPSBtYm1fcnVuX3Rlc3QsCit9OwpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmggYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwuaAppbmRleCBhMzNmNDE0ZjYwMTkuLjIw
NTFiZDEzNWUwZCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsLmgKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNj
dHJsLmgKQEAgLTI4LDYgKzI4LDEyIEBACiAjZGVmaW5lIFBIWVNfSURfUEFUSAkJIi9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSIKICNkZWZpbmUgSU5GT19QQVRICQkiL3N5cy9mcy9y
ZXNjdHJsL2luZm8iCiAKKy8qCisgKiBDUFUgdmVuZG9yIElEcworICoKKyAqIERlZmluZSBh
cyBiaXRzIGJlY2F1c2UgdGhleSdyZSB1c2VkIGZvciB2ZW5kb3Jfc3BlY2lmaWMgYml0bWFz
ayBpbgorICogdGhlIHN0cnVjdCByZXNjdHJsX3Rlc3QuCisgKi8KICNkZWZpbmUgQVJDSF9J
TlRFTCAgICAgMQogI2RlZmluZSBBUkNIX0FNRCAgICAgICAyCiAKQEAgLTM3LDIwICs0Myw1
MiBAQAogCiAjZGVmaW5lIERFRkFVTFRfU1BBTgkJKDI1MCAqIE1CKQogCi0jZGVmaW5lIFBB
UkVOVF9FWElUKGVycl9tc2cpCQkJXAorI2RlZmluZSBQQVJFTlRfRVhJVCgpCQkJCVwKIAlk
byB7CQkJCQlcCi0JCXBlcnJvcihlcnJfbXNnKTsJCVwKIAkJa2lsbChwcGlkLCBTSUdLSUxM
KTsJCVwKIAkJdW1vdW50X3Jlc2N0cmxmcygpOwkJXAogCQlleGl0KEVYSVRfRkFJTFVSRSk7
CQlcCiAJfSB3aGlsZSAoMCkKIAorLyoKKyAqIHVzZXJfcGFyYW1zOgkJVXNlciBzdXBwbGll
ZCBwYXJhbWV0ZXJzCisgKiBAY3B1OgkJQ1BVIG51bWJlciB0byB3aGljaCB0aGUgYmVuY2ht
YXJrIHdpbGwgYmUgYm91bmQgdG8KKyAqIEBiaXRzOgkJTnVtYmVyIG9mIGJpdHMgdXNlZCBm
b3IgY2FjaGUgYWxsb2NhdGlvbiBzaXplCisgKiBAYmVuY2htYXJrX2NtZDoJQmVuY2htYXJr
IGNvbW1hbmQgdG8gcnVuIGR1cmluZyAoc29tZSBvZiB0aGUpIHRlc3RzCisgKi8KK3N0cnVj
dCB1c2VyX3BhcmFtcyB7CisJaW50IGNwdTsKKwlpbnQgYml0czsKKwljb25zdCBjaGFyICpi
ZW5jaG1hcmtfY21kW0JFTkNITUFSS19BUkdTXTsKK307CisKKy8qCisgKiByZXNjdHJsX3Rl
c3Q6CXJlc2N0cmwgdGVzdCBkZWZpbml0aW9uCisgKiBAbmFtZToJCVRlc3QgbmFtZQorICog
QGdyb3VwOgkJVGVzdCBncm91cCAtIGEgY29tbW9uIG5hbWUgZm9yIHRlc3RzIHRoYXQgc2hh
cmUgc29tZSBjaGFyYWN0ZXJpc3RpYworICoJCQkoZS5nLiwgTDMgQ0FUIHRlc3QgYmVsb25n
cyB0byB0aGUgQ0FUIGdyb3VwKS4gQ2FuIGJlIE5VTEwKKyAqIEByZXNvdXJjZToJCVJlc291
cmNlIHRvIHRlc3QgKGUuZy4sIE1CLCBMMywgTDIsIGV0Yy4pCisgKiBAdmVuZG9yX3NwZWNp
ZmljOglCaXRtYXNrIGZvciB2ZW5kb3Itc3BlY2lmaWMgdGVzdHMgKGNhbiBiZSAwIGZvciB1
bml2ZXJzYWwgdGVzdHMpCisgKiBAZGlzYWJsZWQ6CQlUZXN0IGlzIGRpc2FibGVkCisgKiBA
ZmVhdHVyZV9jaGVjazoJQ2FsbGJhY2sgdG8gY2hlY2sgcmVxdWlyZWQgcmVzY3RybCBmZWF0
dXJlcworICogQHJ1bl90ZXN0OgkJQ2FsbGJhY2sgdG8gcnVuIHRoZSB0ZXN0CisgKi8KK3N0
cnVjdCByZXNjdHJsX3Rlc3QgeworCWNvbnN0IGNoYXIJKm5hbWU7CisJY29uc3QgY2hhcgkq
Z3JvdXA7CisJY29uc3QgY2hhcgkqcmVzb3VyY2U7CisJdW5zaWduZWQgaW50CXZlbmRvcl9z
cGVjaWZpYzsKKwlib29sCQlkaXNhYmxlZDsKKwlib29sCQkoKmZlYXR1cmVfY2hlY2spKGNv
bnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QpOworCWludAkJKCpydW5fdGVzdCkoY29u
c3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwKKwkJCQkgICAgY29uc3Qgc3RydWN0IHVz
ZXJfcGFyYW1zICp1cGFyYW1zKTsKK307CisKIC8qCiAgKiByZXNjdHJsX3ZhbF9wYXJhbToJ
cmVzY3RybCB0ZXN0IHBhcmFtZXRlcnMKICAqIEByZXNjdHJsX3ZhbDoJUmVzY3RybCBmZWF0
dXJlIChFZzogbWJtLCBtYmEuLiBldGMpCiAgKiBAY3RybGdycDoJCU5hbWUgb2YgdGhlIGNv
bnRyb2wgbW9uaXRvciBncm91cCAoY29uX21vbiBncnApCiAgKiBAbW9uZ3JwOgkJTmFtZSBv
ZiB0aGUgbW9uaXRvciBncm91cCAobW9uIGdycCkKLSAqIEBjcHVfbm86CQlDUFUgbnVtYmVy
IHRvIHdoaWNoIHRoZSBiZW5jaG1hcmsgd291bGQgYmUgYmluZGVkCiAgKiBAZmlsZW5hbWU6
CQlOYW1lIG9mIGZpbGUgdG8gd2hpY2ggdGhlIG8vcCBzaG91bGQgYmUgd3JpdHRlbgogICog
QGJ3X3JlcG9ydDoJCUJhbmR3aWR0aCByZXBvcnQgdHlwZSAocmVhZHMgdnMgd3JpdGVzKQog
ICogQHNldHVwOgkJQ2FsbCBiYWNrIGZ1bmN0aW9uIHRvIHNldHVwIHRlc3QgZW52aXJvbm1l
bnQKQEAgLTU5LDEyICs5NywyMCBAQCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gewogCWNo
YXIJCSpyZXNjdHJsX3ZhbDsKIAljaGFyCQljdHJsZ3JwWzY0XTsKIAljaGFyCQltb25ncnBb
NjRdOwotCWludAkJY3B1X25vOwogCWNoYXIJCWZpbGVuYW1lWzY0XTsKIAljaGFyCQkqYndf
cmVwb3J0OwogCXVuc2lnbmVkIGxvbmcJbWFzazsKIAlpbnQJCW51bV9vZl9ydW5zOwotCWlu
dAkJKCpzZXR1cCkoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSk7CisJaW50CQko
KnNldHVwKShjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LAorCQkJCSBjb25zdCBz
dHJ1Y3QgdXNlcl9wYXJhbXMgKnVwYXJhbXMsCisJCQkJIHN0cnVjdCByZXNjdHJsX3ZhbF9w
YXJhbSAqcGFyYW0pOworfTsKKworc3RydWN0IHBlcmZfZXZlbnRfcmVhZCB7CisJX191NjQg
bnI7CQkJLyogVGhlIG51bWJlciBvZiBldmVudHMgKi8KKwlzdHJ1Y3QgeworCQlfX3U2NCB2
YWx1ZTsJCS8qIFRoZSB2YWx1ZSBvZiB0aGUgZXZlbnQgKi8KKwl9IHZhbHVlc1syXTsKIH07
CiAKICNkZWZpbmUgTUJNX1NUUgkJCSJtYm0iCkBAIC03Miw2ICsxMTgsMTMgQEAgc3RydWN0
IHJlc2N0cmxfdmFsX3BhcmFtIHsKICNkZWZpbmUgQ01UX1NUUgkJCSJjbXQiCiAjZGVmaW5l
IENBVF9TVFIJCQkiY2F0IgogCisvKgorICogTWVtb3J5IGxvY2F0aW9uIHRoYXQgY29uc3Vt
ZXMgdmFsdWVzIGNvbXBpbGVyIG11c3Qgbm90IG9wdGltaXplIGF3YXkuCisgKiBWb2xhdGls
ZSBlbnN1cmVzIHdyaXRlcyB0byB0aGlzIGxvY2F0aW9uIGNhbm5vdCBiZSBvcHRpbWl6ZWQg
YXdheSBieQorICogY29tcGlsZXIuCisgKi8KK2V4dGVybiB2b2xhdGlsZSBpbnQgKnZhbHVl
X3Npbms7CisKIGV4dGVybiBwaWRfdCBibV9waWQsIHBwaWQ7CiAKIGV4dGVybiBjaGFyIGxs
Y19vY2N1cF9wYXRoWzEwMjRdOwpAQCAtNzksNDIgKzEzMiw4NCBAQCBleHRlcm4gY2hhciBs
bGNfb2NjdXBfcGF0aFsxMDI0XTsKIGludCBnZXRfdmVuZG9yKHZvaWQpOwogYm9vbCBjaGVj
a19yZXNjdHJsZnNfc3VwcG9ydCh2b2lkKTsKIGludCBmaWx0ZXJfZG1lc2codm9pZCk7Ci1p
bnQgZ2V0X3Jlc291cmNlX2lkKGludCBjcHVfbm8sIGludCAqcmVzb3VyY2VfaWQpOworaW50
IGdldF9kb21haW5faWQoY29uc3QgY2hhciAqcmVzb3VyY2UsIGludCBjcHVfbm8sIGludCAq
ZG9tYWluX2lkKTsKIGludCBtb3VudF9yZXNjdHJsZnModm9pZCk7CiBpbnQgdW1vdW50X3Jl
c2N0cmxmcyh2b2lkKTsKIGludCB2YWxpZGF0ZV9id19yZXBvcnRfcmVxdWVzdChjaGFyICpi
d19yZXBvcnQpOwotYm9vbCB2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChjb25z
dCBjaGFyICpyZXNvdXJjZSwgY29uc3QgY2hhciAqZmVhdHVyZSk7Citib29sIHJlc2N0cmxf
cmVzb3VyY2VfZXhpc3RzKGNvbnN0IGNoYXIgKnJlc291cmNlKTsKK2Jvb2wgcmVzY3RybF9t
b25fZmVhdHVyZV9leGlzdHMoY29uc3QgY2hhciAqcmVzb3VyY2UsIGNvbnN0IGNoYXIgKmZl
YXR1cmUpOworYm9vbCByZXNvdXJjZV9pbmZvX2ZpbGVfZXhpc3RzKGNvbnN0IGNoYXIgKnJl
c291cmNlLCBjb25zdCBjaGFyICpmaWxlKTsKK2Jvb2wgdGVzdF9yZXNvdXJjZV9mZWF0dXJl
X2NoZWNrKGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QpOwogY2hhciAqZmdyZXAo
RklMRSAqaW5mLCBjb25zdCBjaGFyICpzdHIpOwotaW50IHRhc2tzZXRfYmVuY2htYXJrKHBp
ZF90IGJtX3BpZCwgaW50IGNwdV9ubyk7Ci1pbnQgd3JpdGVfc2NoZW1hdGEoY2hhciAqY3Ry
bGdycCwgY2hhciAqc2NoZW1hdGEsIGludCBjcHVfbm8sCi0JCSAgIGNoYXIgKnJlc2N0cmxf
dmFsKTsKK2ludCB0YXNrc2V0X2JlbmNobWFyayhwaWRfdCBibV9waWQsIGludCBjcHVfbm8s
IGNwdV9zZXRfdCAqb2xkX2FmZmluaXR5KTsKK2ludCB0YXNrc2V0X3Jlc3RvcmUocGlkX3Qg
Ym1fcGlkLCBjcHVfc2V0X3QgKm9sZF9hZmZpbml0eSk7CitpbnQgd3JpdGVfc2NoZW1hdGEo
Y2hhciAqY3RybGdycCwgY2hhciAqc2NoZW1hdGEsIGludCBjcHVfbm8sIGNvbnN0IGNoYXIg
KnJlc291cmNlKTsKIGludCB3cml0ZV9ibV9waWRfdG9fcmVzY3RybChwaWRfdCBibV9waWQs
IGNoYXIgKmN0cmxncnAsIGNoYXIgKm1vbmdycCwKIAkJCSAgICBjaGFyICpyZXNjdHJsX3Zh
bCk7CiBpbnQgcGVyZl9ldmVudF9vcGVuKHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKmh3X2V2
ZW50LCBwaWRfdCBwaWQsIGludCBjcHUsCiAJCSAgICBpbnQgZ3JvdXBfZmQsIHVuc2lnbmVk
IGxvbmcgZmxhZ3MpOwotaW50IHJ1bl9maWxsX2J1ZihzaXplX3Qgc3BhbiwgaW50IG1lbWZs
dXNoLCBpbnQgb3AsIGJvb2wgb25jZSk7Ci1pbnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAq
IGNvbnN0ICpiZW5jaG1hcmtfY21kLCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFt
KTsKLWludCBtYm1fYndfY2hhbmdlKGludCBjcHVfbm8sIGNvbnN0IGNoYXIgKiBjb25zdCAq
YmVuY2htYXJrX2NtZCk7Cit1bnNpZ25lZCBjaGFyICphbGxvY19idWZmZXIoc2l6ZV90IGJ1
Zl9zaXplLCBpbnQgbWVtZmx1c2gpOwordm9pZCBtZW1fZmx1c2godW5zaWduZWQgY2hhciAq
YnVmLCBzaXplX3QgYnVmX3NpemUpOwordm9pZCBmaWxsX2NhY2hlX3JlYWQodW5zaWduZWQg
Y2hhciAqYnVmLCBzaXplX3QgYnVmX3NpemUsIGJvb2wgb25jZSk7CitpbnQgcnVuX2ZpbGxf
YnVmKHNpemVfdCBidWZfc2l6ZSwgaW50IG1lbWZsdXNoLCBpbnQgb3AsIGJvb2wgb25jZSk7
CitpbnQgcmVzY3RybF92YWwoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwKKwkJ
Y29uc3Qgc3RydWN0IHVzZXJfcGFyYW1zICp1cGFyYW1zLAorCQljb25zdCBjaGFyICogY29u
c3QgKmJlbmNobWFya19jbWQsCisJCXN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0p
Owogdm9pZCB0ZXN0c19jbGVhbnVwKHZvaWQpOwogdm9pZCBtYm1fdGVzdF9jbGVhbnVwKHZv
aWQpOwotaW50IG1iYV9zY2hlbWF0YV9jaGFuZ2UoaW50IGNwdV9ubywgY29uc3QgY2hhciAq
IGNvbnN0ICpiZW5jaG1hcmtfY21kKTsKIHZvaWQgbWJhX3Rlc3RfY2xlYW51cCh2b2lkKTsK
LWludCBnZXRfY2JtX21hc2soY2hhciAqY2FjaGVfdHlwZSwgY2hhciAqY2JtX21hc2spOwot
aW50IGdldF9jYWNoZV9zaXplKGludCBjcHVfbm8sIGNoYXIgKmNhY2hlX3R5cGUsIHVuc2ln
bmVkIGxvbmcgKmNhY2hlX3NpemUpOwordW5zaWduZWQgbG9uZyBjcmVhdGVfYml0X21hc2so
dW5zaWduZWQgaW50IHN0YXJ0LCB1bnNpZ25lZCBpbnQgbGVuKTsKK3Vuc2lnbmVkIGludCBj
b3VudF9jb250aWd1b3VzX2JpdHModW5zaWduZWQgbG9uZyB2YWwsIHVuc2lnbmVkIGludCAq
c3RhcnQpOworaW50IGdldF9mdWxsX2NibShjb25zdCBjaGFyICpjYWNoZV90eXBlLCB1bnNp
Z25lZCBsb25nICptYXNrKTsKK2ludCBnZXRfbWFza19ub19zaGFyZWFibGUoY29uc3QgY2hh
ciAqY2FjaGVfdHlwZSwgdW5zaWduZWQgbG9uZyAqbWFzayk7CitpbnQgZ2V0X2NhY2hlX3Np
emUoaW50IGNwdV9ubywgY29uc3QgY2hhciAqY2FjaGVfdHlwZSwgdW5zaWduZWQgbG9uZyAq
Y2FjaGVfc2l6ZSk7CitpbnQgcmVzb3VyY2VfaW5mb191bnNpZ25lZF9nZXQoY29uc3QgY2hh
ciAqcmVzb3VyY2UsIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCB1bnNpZ25lZCBpbnQgKnZhbCk7
CiB2b2lkIGN0cmxjX2hhbmRsZXIoaW50IHNpZ251bSwgc2lnaW5mb190ICppbmZvLCB2b2lk
ICpwdHIpOwogaW50IHNpZ25hbF9oYW5kbGVyX3JlZ2lzdGVyKHZvaWQpOwogdm9pZCBzaWdu
YWxfaGFuZGxlcl91bnJlZ2lzdGVyKHZvaWQpOwotaW50IGNhdF92YWwoc3RydWN0IHJlc2N0
cmxfdmFsX3BhcmFtICpwYXJhbSwgc2l6ZV90IHNwYW4pOwogdm9pZCBjYXRfdGVzdF9jbGVh
bnVwKHZvaWQpOwotaW50IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBub19v
Zl9iaXRzLCBjaGFyICpjYWNoZV90eXBlKTsKLWludCBjbXRfcmVzY3RybF92YWwoaW50IGNw
dV9ubywgaW50IG4sIGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCk7CiB1bnNp
Z25lZCBpbnQgY291bnRfYml0cyh1bnNpZ25lZCBsb25nIG4pOwogdm9pZCBjbXRfdGVzdF9j
bGVhbnVwKHZvaWQpOwotaW50IGdldF9jb3JlX3NpYmxpbmcoaW50IGNwdV9ubyk7Ci1pbnQg
bWVhc3VyZV9jYWNoZV92YWxzKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0sIGlu
dCBibV9waWQpOwotaW50IHNob3dfY2FjaGVfaW5mbyh1bnNpZ25lZCBsb25nIHN1bV9sbGNf
dmFsLCBpbnQgbm9fb2ZfYml0cywKLQkJICAgIHNpemVfdCBjYWNoZV9zcGFuLCB1bnNpZ25l
ZCBsb25nIG1heF9kaWZmLAotCQkgICAgdW5zaWduZWQgbG9uZyBtYXhfZGlmZl9wZXJjZW50
LCB1bnNpZ25lZCBsb25nIG51bV9vZl9ydW5zLAotCQkgICAgYm9vbCBwbGF0Zm9ybSwgYm9v
bCBjbXQpOworCit2b2lkIHBlcmZfZXZlbnRfYXR0cl9pbml0aWFsaXplKHN0cnVjdCBwZXJm
X2V2ZW50X2F0dHIgKnBlYSwgX191NjQgY29uZmlnKTsKK3ZvaWQgcGVyZl9ldmVudF9pbml0
aWFsaXplX3JlYWRfZm9ybWF0KHN0cnVjdCBwZXJmX2V2ZW50X3JlYWQgKnBlX3JlYWQpOwor
aW50IHBlcmZfb3BlbihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICpwZWEsIHBpZF90IHBpZCwg
aW50IGNwdV9ubyk7CitpbnQgcGVyZl9ldmVudF9yZXNldF9lbmFibGUoaW50IHBlX2ZkKTsK
K2ludCBwZXJmX2V2ZW50X21lYXN1cmUoaW50IHBlX2ZkLCBzdHJ1Y3QgcGVyZl9ldmVudF9y
ZWFkICpwZV9yZWFkLAorCQkgICAgICAgY29uc3QgY2hhciAqZmlsZW5hbWUsIGludCBibV9w
aWQpOworaW50IG1lYXN1cmVfbGxjX3Jlc2N0cmwoY29uc3QgY2hhciAqZmlsZW5hbWUsIGlu
dCBibV9waWQpOwordm9pZCBzaG93X2NhY2hlX2luZm8oaW50IG5vX29mX2JpdHMsIF9fdTY0
IGF2Z19sbGNfdmFsLCBzaXplX3QgY2FjaGVfc3BhbiwgYm9vbCBsaW5lcyk7CisKKy8qCisg
KiBjYWNoZV9wb3J0aW9uX3NpemUgLSBDYWxjdWxhdGUgdGhlIHNpemUgb2YgYSBjYWNoZSBw
b3J0aW9uCisgKiBAY2FjaGVfc2l6ZToJCVRvdGFsIGNhY2hlIHNpemUgaW4gYnl0ZXMKKyAq
IEBwb3J0aW9uX21hc2s6CUNhY2hlIHBvcnRpb24gbWFzaworICogQGZ1bGxfY2FjaGVfbWFz
azoJRnVsbCBDYWNoZSBCaXQgTWFzayAoQ0JNKSBmb3IgdGhlIGNhY2hlCisgKgorICogUmV0
dXJuOiBUaGUgc2l6ZSBvZiB0aGUgY2FjaGUgcG9ydGlvbiBpbiBieXRlcy4KKyAqLworc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBsb25nIGNhY2hlX3BvcnRpb25fc2l6ZSh1bnNpZ25lZCBs
b25nIGNhY2hlX3NpemUsCisJCQkJCSAgICAgICB1bnNpZ25lZCBsb25nIHBvcnRpb25fbWFz
aywKKwkJCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgZnVsbF9jYWNoZV9tYXNrKQoreworCXVu
c2lnbmVkIGludCBiaXRzID0gY291bnRfYml0cyhmdWxsX2NhY2hlX21hc2spOworCisJLyoK
KwkgKiBXaXRoIG5vIGJpdHMgdGhlIGZ1bGwgQ0JNLCBhc3N1bWUgY2FjaGUgY2Fubm90IGJl
IHNwbGl0IGludG8KKwkgKiBzbWFsbGVyIHBvcnRpb25zLiBUbyBhdm9pZCBkaXZpZGUgYnkg
emVybywgcmV0dXJuIGNhY2hlX3NpemUuCisJICovCisJaWYgKCFiaXRzKQorCQlyZXR1cm4g
Y2FjaGVfc2l6ZTsKKworCXJldHVybiBjYWNoZV9zaXplICogY291bnRfYml0cyhwb3J0aW9u
X21hc2spIC8gYml0czsKK30KKworZXh0ZXJuIHN0cnVjdCByZXNjdHJsX3Rlc3QgbWJtX3Rl
c3Q7CitleHRlcm4gc3RydWN0IHJlc2N0cmxfdGVzdCBtYmFfdGVzdDsKK2V4dGVybiBzdHJ1
Y3QgcmVzY3RybF90ZXN0IGNtdF90ZXN0OworZXh0ZXJuIHN0cnVjdCByZXNjdHJsX3Rlc3Qg
bDNfY2F0X3Rlc3Q7CitleHRlcm4gc3RydWN0IHJlc2N0cmxfdGVzdCBsM19ub25jb250X2Nh
dF90ZXN0OworZXh0ZXJuIHN0cnVjdCByZXNjdHJsX3Rlc3QgbDJfbm9uY29udF9jYXRfdGVz
dDsKIAogI2VuZGlmIC8qIFJFU0NUUkxfSCAqLwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYwppbmRleCAyYmJlMzA0NWEwMTguLmYz
ZGMxYjk2OTZlNyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsX3Rlc3RzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsX3Rlc3RzLmMKQEAgLTEwLDYgKzEwLDE5IEBACiAgKi8KICNpbmNsdWRlICJy
ZXNjdHJsLmgiCiAKKy8qIFZvbGF0aWxlIG1lbW9yeSBzaW5rIHRvIHByZXZlbnQgY29tcGls
ZXIgb3B0aW1pemF0aW9ucyAqLworc3RhdGljIHZvbGF0aWxlIGludCBzaW5rX3RhcmdldDsK
K3ZvbGF0aWxlIGludCAqdmFsdWVfc2luayA9ICZzaW5rX3RhcmdldDsKKworc3RhdGljIHN0
cnVjdCByZXNjdHJsX3Rlc3QgKnJlc2N0cmxfdGVzdHNbXSA9IHsKKwkmbWJtX3Rlc3QsCisJ
Jm1iYV90ZXN0LAorCSZjbXRfdGVzdCwKKwkmbDNfY2F0X3Rlc3QsCisJJmwzX25vbmNvbnRf
Y2F0X3Rlc3QsCisJJmwyX25vbmNvbnRfY2F0X3Rlc3QsCit9OworCiBzdGF0aWMgaW50IGRl
dGVjdF92ZW5kb3Iodm9pZCkKIHsKIAlGSUxFICppbmYgPSBmb3BlbigiL3Byb2MvY3B1aW5m
byIsICJyIik7CkBAIC00OSwxMSArNjIsMjAgQEAgaW50IGdldF92ZW5kb3Iodm9pZCkKIAog
c3RhdGljIHZvaWQgY21kX2hlbHAodm9pZCkKIHsKKwlpbnQgaTsKKwogCXByaW50ZigidXNh
Z2U6IHJlc2N0cmxfdGVzdHMgWy1oXSBbLXQgdGVzdCBsaXN0XSBbLW4gbm9fb2ZfYml0c10g
Wy1iIGJlbmNobWFya19jbWQgW29wdGlvbl0uLi5dXG4iKTsKIAlwcmludGYoIlx0LWIgYmVu
Y2htYXJrX2NtZCBbb3B0aW9uXS4uLjogcnVuIHNwZWNpZmllZCBiZW5jaG1hcmsgZm9yIE1C
TSwgTUJBIGFuZCBDTVRcbiIpOwogCXByaW50ZigiXHQgICBkZWZhdWx0IGJlbmNobWFyayBp
cyBidWlsdGluIGZpbGxfYnVmXG4iKTsKLQlwcmludGYoIlx0LXQgdGVzdCBsaXN0OiBydW4g
dGVzdHMgc3BlY2lmaWVkIGluIHRoZSB0ZXN0IGxpc3QsICIpOworCXByaW50ZigiXHQtdCB0
ZXN0IGxpc3Q6IHJ1biB0ZXN0cy9ncm91cHMgc3BlY2lmaWVkIGJ5IHRoZSBsaXN0LCAiKTsK
IAlwcmludGYoImUuZy4gLXQgbWJtLG1iYSxjbXQsY2F0XG4iKTsKKwlwcmludGYoIlx0XHRT
dXBwb3J0ZWQgdGVzdHMgKGdyb3VwKTpcbiIpOworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKHJlc2N0cmxfdGVzdHMpOyBpKyspIHsKKwkJaWYgKHJlc2N0cmxfdGVzdHNbaV0tPmdy
b3VwKQorCQkJcHJpbnRmKCJcdFx0XHQlcyAoJXMpXG4iLCByZXNjdHJsX3Rlc3RzW2ldLT5u
YW1lLCByZXNjdHJsX3Rlc3RzW2ldLT5ncm91cCk7CisJCWVsc2UKKwkJCXByaW50ZigiXHRc
dFx0JXNcbiIsIHJlc2N0cmxfdGVzdHNbaV0tPm5hbWUpOworCX0KIAlwcmludGYoIlx0LW4g
bm9fb2ZfYml0czogcnVuIGNhY2hlIHRlc3RzIHVzaW5nIHNwZWNpZmllZCBubyBvZiBiaXRz
IGluIGNhY2hlIGJpdCBtYXNrXG4iKTsKIAlwcmludGYoIlx0LXAgY3B1X25vOiBzcGVjaWZ5
IENQVSBudW1iZXIgdG8gcnVuIHRoZSB0ZXN0LiAxIGlzIGRlZmF1bHRcbiIpOwogCXByaW50
ZigiXHQtaDogaGVscFxuIik7CkBAIC05MiwxMTYgKzExNCw2MyBAQCBzdGF0aWMgdm9pZCB0
ZXN0X2NsZWFudXAodm9pZCkKIAlzaWduYWxfaGFuZGxlcl91bnJlZ2lzdGVyKCk7CiB9CiAK
LXN0YXRpYyB2b2lkIHJ1bl9tYm1fdGVzdChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFy
a19jbWQsIGludCBjcHVfbm8pCitzdGF0aWMgYm9vbCB0ZXN0X3ZlbmRvcl9zcGVjaWZpY19j
aGVjayhjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0KQogewotCWludCByZXM7Ci0K
LQlrc2Z0X3ByaW50X21zZygiU3RhcnRpbmcgTUJNIEJXIGNoYW5nZSAuLi5cbiIpOwotCi0J
aWYgKHRlc3RfcHJlcGFyZSgpKSB7Ci0JCWtzZnRfZXhpdF9mYWlsX21zZygiQWJub3JtYWwg
ZmFpbHVyZSB3aGVuIHByZXBhcmluZyBmb3IgdGhlIHRlc3RcbiIpOwotCQlyZXR1cm47Ci0J
fQotCi0JaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdCgiTDNfTU9OIiwg
Im1ibV90b3RhbF9ieXRlcyIpIHx8Ci0JICAgICF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVf
cmVxdWVzdCgiTDNfTU9OIiwgIm1ibV9sb2NhbF9ieXRlcyIpIHx8Ci0JICAgIChnZXRfdmVu
ZG9yKCkgIT0gQVJDSF9JTlRFTCkpIHsKLQkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJIYXJk
d2FyZSBkb2VzIG5vdCBzdXBwb3J0IE1CTSBvciBNQk0gaXMgZGlzYWJsZWRcbiIpOwotCQln
b3RvIGNsZWFudXA7Ci0JfQotCi0JcmVzID0gbWJtX2J3X2NoYW5nZShjcHVfbm8sIGJlbmNo
bWFya19jbWQpOwotCWtzZnRfdGVzdF9yZXN1bHQoIXJlcywgIk1CTTogYncgY2hhbmdlXG4i
KTsKLQlpZiAoKGdldF92ZW5kb3IoKSA9PSBBUkNIX0lOVEVMKSAmJiByZXMpCi0JCWtzZnRf
cHJpbnRfbXNnKCJJbnRlbCBNQk0gbWF5IGJlIGluYWNjdXJhdGUgd2hlbiBTdWItTlVNQSBD
bHVzdGVyaW5nIGlzIGVuYWJsZWQuIENoZWNrIEJJT1MgY29uZmlndXJhdGlvbi5cbiIpOwor
CWlmICghdGVzdC0+dmVuZG9yX3NwZWNpZmljKQorCQlyZXR1cm4gdHJ1ZTsKIAotY2xlYW51
cDoKLQl0ZXN0X2NsZWFudXAoKTsKKwlyZXR1cm4gZ2V0X3ZlbmRvcigpICYgdGVzdC0+dmVu
ZG9yX3NwZWNpZmljOwogfQogCi1zdGF0aWMgdm9pZCBydW5fbWJhX3Rlc3QoY29uc3QgY2hh
ciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kLCBpbnQgY3B1X25vKQorc3RhdGljIHZvaWQgcnVu
X3NpbmdsZV90ZXN0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QsIGNvbnN0IHN0
cnVjdCB1c2VyX3BhcmFtcyAqdXBhcmFtcykKIHsKLQlpbnQgcmVzOwotCi0Ja3NmdF9wcmlu
dF9tc2coIlN0YXJ0aW5nIE1CQSBTY2hlbWF0YSBjaGFuZ2UgLi4uXG4iKTsKKwlpbnQgcmV0
OwogCi0JaWYgKHRlc3RfcHJlcGFyZSgpKSB7Ci0JCWtzZnRfZXhpdF9mYWlsX21zZygiQWJu
b3JtYWwgZmFpbHVyZSB3aGVuIHByZXBhcmluZyBmb3IgdGhlIHRlc3RcbiIpOworCWlmICh0
ZXN0LT5kaXNhYmxlZCkKIAkJcmV0dXJuOwotCX0KIAotCWlmICghdmFsaWRhdGVfcmVzY3Ry
bF9mZWF0dXJlX3JlcXVlc3QoIk1CIiwgTlVMTCkgfHwKLQkgICAgIXZhbGlkYXRlX3Jlc2N0
cmxfZmVhdHVyZV9yZXF1ZXN0KCJMM19NT04iLCAibWJtX2xvY2FsX2J5dGVzIikgfHwKLQkg
ICAgKGdldF92ZW5kb3IoKSAhPSBBUkNIX0lOVEVMKSkgewotCQlrc2Z0X3Rlc3RfcmVzdWx0
X3NraXAoIkhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgTUJBIG9yIE1CQSBpcyBkaXNhYmxl
ZFxuIik7Ci0JCWdvdG8gY2xlYW51cDsKKwlpZiAoIXRlc3RfdmVuZG9yX3NwZWNpZmljX2No
ZWNrKHRlc3QpKSB7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiSGFyZHdhcmUgZG9lcyBu
b3Qgc3VwcG9ydCAlc1xuIiwgdGVzdC0+bmFtZSk7CisJCXJldHVybjsKIAl9CiAKLQlyZXMg
PSBtYmFfc2NoZW1hdGFfY2hhbmdlKGNwdV9ubywgYmVuY2htYXJrX2NtZCk7Ci0Ja3NmdF90
ZXN0X3Jlc3VsdCghcmVzLCAiTUJBOiBzY2hlbWF0YSBjaGFuZ2VcbiIpOwotCi1jbGVhbnVw
OgotCXRlc3RfY2xlYW51cCgpOwotfQotCi1zdGF0aWMgdm9pZCBydW5fY210X3Rlc3QoY29u
c3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kLCBpbnQgY3B1X25vKQotewotCWludCBy
ZXM7Ci0KLQlrc2Z0X3ByaW50X21zZygiU3RhcnRpbmcgQ01UIHRlc3QgLi4uXG4iKTsKKwlr
c2Z0X3ByaW50X21zZygiU3RhcnRpbmcgJXMgdGVzdCAuLi5cbiIsIHRlc3QtPm5hbWUpOwog
CiAJaWYgKHRlc3RfcHJlcGFyZSgpKSB7CiAJCWtzZnRfZXhpdF9mYWlsX21zZygiQWJub3Jt
YWwgZmFpbHVyZSB3aGVuIHByZXBhcmluZyBmb3IgdGhlIHRlc3RcbiIpOwogCQlyZXR1cm47
CiAJfQogCi0JaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdCgiTDNfTU9O
IiwgImxsY19vY2N1cGFuY3kiKSB8fAotCSAgICAhdmFsaWRhdGVfcmVzY3RybF9mZWF0dXJl
X3JlcXVlc3QoIkwzIiwgTlVMTCkpIHsKLQkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJIYXJk
d2FyZSBkb2VzIG5vdCBzdXBwb3J0IENNVCBvciBDTVQgaXMgZGlzYWJsZWRcbiIpOworCWlm
ICghdGVzdC0+ZmVhdHVyZV9jaGVjayh0ZXN0KSkgeworCQlrc2Z0X3Rlc3RfcmVzdWx0X3Nr
aXAoIkhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgJXMgb3IgJXMgaXMgZGlzYWJsZWRcbiIs
CisJCQkJICAgICAgdGVzdC0+bmFtZSwgdGVzdC0+bmFtZSk7CiAJCWdvdG8gY2xlYW51cDsK
IAl9CiAKLQlyZXMgPSBjbXRfcmVzY3RybF92YWwoY3B1X25vLCA1LCBiZW5jaG1hcmtfY21k
KTsKLQlrc2Z0X3Rlc3RfcmVzdWx0KCFyZXMsICJDTVQ6IHRlc3RcbiIpOwotCWlmICgoZ2V0
X3ZlbmRvcigpID09IEFSQ0hfSU5URUwpICYmIHJlcykKLQkJa3NmdF9wcmludF9tc2coIklu
dGVsIENNVCBtYXkgYmUgaW5hY2N1cmF0ZSB3aGVuIFN1Yi1OVU1BIENsdXN0ZXJpbmcgaXMg
ZW5hYmxlZC4gQ2hlY2sgQklPUyBjb25maWd1cmF0aW9uLlxuIik7CisJcmV0ID0gdGVzdC0+
cnVuX3Rlc3QodGVzdCwgdXBhcmFtcyk7CisJa3NmdF90ZXN0X3Jlc3VsdCghcmV0LCAiJXM6
IHRlc3RcbiIsIHRlc3QtPm5hbWUpOwogCiBjbGVhbnVwOgogCXRlc3RfY2xlYW51cCgpOwog
fQogCi1zdGF0aWMgdm9pZCBydW5fY2F0X3Rlc3QoaW50IGNwdV9ubywgaW50IG5vX29mX2Jp
dHMpCitzdGF0aWMgdm9pZCBpbml0X3VzZXJfcGFyYW1zKHN0cnVjdCB1c2VyX3BhcmFtcyAq
dXBhcmFtcykKIHsKLQlpbnQgcmVzOwotCi0Ja3NmdF9wcmludF9tc2coIlN0YXJ0aW5nIENB
VCB0ZXN0IC4uLlxuIik7Ci0KLQlpZiAodGVzdF9wcmVwYXJlKCkpIHsKLQkJa3NmdF9leGl0
X2ZhaWxfbXNnKCJBYm5vcm1hbCBmYWlsdXJlIHdoZW4gcHJlcGFyaW5nIGZvciB0aGUgdGVz
dFxuIik7Ci0JCXJldHVybjsKLQl9Ci0KLQlpZiAoIXZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVy
ZV9yZXF1ZXN0KCJMMyIsIE5VTEwpKSB7Ci0JCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiSGFy
ZHdhcmUgZG9lcyBub3Qgc3VwcG9ydCBDQVQgb3IgQ0FUIGlzIGRpc2FibGVkXG4iKTsKLQkJ
Z290byBjbGVhbnVwOwotCX0KKwltZW1zZXQodXBhcmFtcywgMCwgc2l6ZW9mKCp1cGFyYW1z
KSk7CiAKLQlyZXMgPSBjYXRfcGVyZl9taXNzX3ZhbChjcHVfbm8sIG5vX29mX2JpdHMsICJM
MyIpOwotCWtzZnRfdGVzdF9yZXN1bHQoIXJlcywgIkNBVDogdGVzdFxuIik7Ci0KLWNsZWFu
dXA6Ci0JdGVzdF9jbGVhbnVwKCk7CisJdXBhcmFtcy0+Y3B1ID0gMTsKKwl1cGFyYW1zLT5i
aXRzID0gMDsKIH0KIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewotCWJv
b2wgbWJtX3Rlc3QgPSB0cnVlLCBtYmFfdGVzdCA9IHRydWUsIGNtdF90ZXN0ID0gdHJ1ZTsK
LQljb25zdCBjaGFyICpiZW5jaG1hcmtfY21kW0JFTkNITUFSS19BUkdTXSA9IHt9OwotCWlu
dCBjLCBjcHVfbm8gPSAxLCBpLCBub19vZl9iaXRzID0gMDsKKwlpbnQgdGVzdHMgPSBBUlJB
WV9TSVpFKHJlc2N0cmxfdGVzdHMpOworCWJvb2wgdGVzdF9wYXJhbV9zZWVuID0gZmFsc2U7
CisJc3RydWN0IHVzZXJfcGFyYW1zIHVwYXJhbXM7CiAJY2hhciAqc3Bhbl9zdHIgPSBOVUxM
OwotCWJvb2wgY2F0X3Rlc3QgPSB0cnVlOwotCWludCB0ZXN0cyA9IDA7Ci0JaW50IHJldDsK
KwlpbnQgcmV0LCBjLCBpOworCisJaW5pdF91c2VyX3BhcmFtcygmdXBhcmFtcyk7CiAKIAl3
aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImh0OmI6bjpwOiIpKSAhPSAtMSkgewog
CQljaGFyICp0b2tlbjsKQEAgLTIxOSwzMiArMTg4LDM1IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICoqYXJndikKIAogCQkJLyogRXh0cmFjdCBiZW5jaG1hcmsgY29tbWFuZCBmcm9t
IGNvbW1hbmQgbGluZS4gKi8KIAkJCWZvciAoaSA9IDA7IGkgPCBhcmdjIC0gb3B0aW5kOyBp
KyspCi0JCQkJYmVuY2htYXJrX2NtZFtpXSA9IGFyZ3ZbaSArIG9wdGluZF07Ci0JCQliZW5j
aG1hcmtfY21kW2ldID0gTlVMTDsKKwkJCQl1cGFyYW1zLmJlbmNobWFya19jbWRbaV0gPSBh
cmd2W2kgKyBvcHRpbmRdOworCQkJdXBhcmFtcy5iZW5jaG1hcmtfY21kW2ldID0gTlVMTDsK
IAogCQkJZ290byBsYXN0X2FyZzsKIAkJY2FzZSAndCc6CiAJCQl0b2tlbiA9IHN0cnRvayhv
cHRhcmcsICIsIik7CiAKLQkJCW1ibV90ZXN0ID0gZmFsc2U7Ci0JCQltYmFfdGVzdCA9IGZh
bHNlOwotCQkJY210X3Rlc3QgPSBmYWxzZTsKLQkJCWNhdF90ZXN0ID0gZmFsc2U7CisJCQlp
ZiAoIXRlc3RfcGFyYW1fc2VlbikgeworCQkJCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KHJlc2N0cmxfdGVzdHMpOyBpKyspCisJCQkJCXJlc2N0cmxfdGVzdHNbaV0tPmRpc2FibGVk
ID0gdHJ1ZTsKKwkJCQl0ZXN0cyA9IDA7CisJCQkJdGVzdF9wYXJhbV9zZWVuID0gdHJ1ZTsK
KwkJCX0KIAkJCXdoaWxlICh0b2tlbikgewotCQkJCWlmICghc3RybmNtcCh0b2tlbiwgTUJN
X1NUUiwgc2l6ZW9mKE1CTV9TVFIpKSkgewotCQkJCQltYm1fdGVzdCA9IHRydWU7Ci0JCQkJ
CXRlc3RzKys7Ci0JCQkJfSBlbHNlIGlmICghc3RybmNtcCh0b2tlbiwgTUJBX1NUUiwgc2l6
ZW9mKE1CQV9TVFIpKSkgewotCQkJCQltYmFfdGVzdCA9IHRydWU7Ci0JCQkJCXRlc3RzKys7
Ci0JCQkJfSBlbHNlIGlmICghc3RybmNtcCh0b2tlbiwgQ01UX1NUUiwgc2l6ZW9mKENNVF9T
VFIpKSkgewotCQkJCQljbXRfdGVzdCA9IHRydWU7Ci0JCQkJCXRlc3RzKys7Ci0JCQkJfSBl
bHNlIGlmICghc3RybmNtcCh0b2tlbiwgQ0FUX1NUUiwgc2l6ZW9mKENBVF9TVFIpKSkgewot
CQkJCQljYXRfdGVzdCA9IHRydWU7Ci0JCQkJCXRlc3RzKys7Ci0JCQkJfSBlbHNlIHsKLQkJ
CQkJcHJpbnRmKCJpbnZhbGlkIGFyZ3VtZW50XG4iKTsKKwkJCQlib29sIGZvdW5kID0gZmFs
c2U7CisKKwkJCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShyZXNjdHJsX3Rlc3RzKTsg
aSsrKSB7CisJCQkJCWlmICghc3RyY2FzZWNtcCh0b2tlbiwgcmVzY3RybF90ZXN0c1tpXS0+
bmFtZSkgfHwKKwkJCQkJICAgIChyZXNjdHJsX3Rlc3RzW2ldLT5ncm91cCAmJgorCQkJCQkg
ICAgICFzdHJjYXNlY21wKHRva2VuLCByZXNjdHJsX3Rlc3RzW2ldLT5ncm91cCkpKSB7CisJ
CQkJCQlpZiAocmVzY3RybF90ZXN0c1tpXS0+ZGlzYWJsZWQpCisJCQkJCQkJdGVzdHMrKzsK
KwkJCQkJCXJlc2N0cmxfdGVzdHNbaV0tPmRpc2FibGVkID0gZmFsc2U7CisJCQkJCQlmb3Vu
ZCA9IHRydWU7CisJCQkJCX0KKwkJCQl9CisKKwkJCQlpZiAoIWZvdW5kKSB7CisJCQkJCXBy
aW50ZigiaW52YWxpZCB0ZXN0OiAlc1xuIiwgdG9rZW4pOwogCiAJCQkJCXJldHVybiAtMTsK
IAkJCQl9CkBAIC0yNTIsMTEgKzIyNCwxMSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiAJCQl9CiAJCQlicmVhazsKIAkJY2FzZSAncCc6Ci0JCQljcHVfbm8gPSBhdG9p
KG9wdGFyZyk7CisJCQl1cGFyYW1zLmNwdSA9IGF0b2kob3B0YXJnKTsKIAkJCWJyZWFrOwog
CQljYXNlICduJzoKLQkJCW5vX29mX2JpdHMgPSBhdG9pKG9wdGFyZyk7Ci0JCQlpZiAobm9f
b2ZfYml0cyA8PSAwKSB7CisJCQl1cGFyYW1zLmJpdHMgPSBhdG9pKG9wdGFyZyk7CisJCQlp
ZiAodXBhcmFtcy5iaXRzIDw9IDApIHsKIAkJCQlwcmludGYoIkJhaWwgb3V0ISBpbnZhbGlk
IGFyZ3VtZW50IGZvciBub19vZl9iaXRzXG4iKTsKIAkJCQlyZXR1cm4gLTE7CiAJCQl9CkBA
IC0yOTEsMzIgKzI2MywyMyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAK
IAlmaWx0ZXJfZG1lc2coKTsKIAotCWlmICghYmVuY2htYXJrX2NtZFswXSkgeworCWlmICgh
dXBhcmFtcy5iZW5jaG1hcmtfY21kWzBdKSB7CiAJCS8qIElmIG5vIGJlbmNobWFyayBpcyBn
aXZlbiBieSAiLWIiIGFyZ3VtZW50LCB1c2UgZmlsbF9idWYuICovCi0JCWJlbmNobWFya19j
bWRbMF0gPSAiZmlsbF9idWYiOworCQl1cGFyYW1zLmJlbmNobWFya19jbWRbMF0gPSAiZmls
bF9idWYiOwogCQlyZXQgPSBhc3ByaW50Zigmc3Bhbl9zdHIsICIldSIsIERFRkFVTFRfU1BB
Tik7CiAJCWlmIChyZXQgPCAwKQogCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJPdXQgb2YgbWVt
b3J5IVxuIik7Ci0JCWJlbmNobWFya19jbWRbMV0gPSBzcGFuX3N0cjsKLQkJYmVuY2htYXJr
X2NtZFsyXSA9ICIxIjsKLQkJYmVuY2htYXJrX2NtZFszXSA9ICIwIjsKLQkJYmVuY2htYXJr
X2NtZFs0XSA9ICJmYWxzZSI7Ci0JCWJlbmNobWFya19jbWRbNV0gPSBOVUxMOworCQl1cGFy
YW1zLmJlbmNobWFya19jbWRbMV0gPSBzcGFuX3N0cjsKKwkJdXBhcmFtcy5iZW5jaG1hcmtf
Y21kWzJdID0gIjEiOworCQl1cGFyYW1zLmJlbmNobWFya19jbWRbM10gPSAiMCI7CisJCXVw
YXJhbXMuYmVuY2htYXJrX2NtZFs0XSA9ICJmYWxzZSI7CisJCXVwYXJhbXMuYmVuY2htYXJr
X2NtZFs1XSA9IE5VTEw7CiAJfQogCi0Ja3NmdF9zZXRfcGxhbih0ZXN0cyA/IDogNCk7Ci0K
LQlpZiAobWJtX3Rlc3QpCi0JCXJ1bl9tYm1fdGVzdChiZW5jaG1hcmtfY21kLCBjcHVfbm8p
OwotCi0JaWYgKG1iYV90ZXN0KQotCQlydW5fbWJhX3Rlc3QoYmVuY2htYXJrX2NtZCwgY3B1
X25vKTsKLQotCWlmIChjbXRfdGVzdCkKLQkJcnVuX2NtdF90ZXN0KGJlbmNobWFya19jbWQs
IGNwdV9ubyk7CisJa3NmdF9zZXRfcGxhbih0ZXN0cyk7CiAKLQlpZiAoY2F0X3Rlc3QpCi0J
CXJ1bl9jYXRfdGVzdChjcHVfbm8sIG5vX29mX2JpdHMpOworCWZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKHJlc2N0cmxfdGVzdHMpOyBpKyspCisJCXJ1bl9zaW5nbGVfdGVzdChyZXNj
dHJsX3Rlc3RzW2ldLCAmdXBhcmFtcyk7CiAKIAlmcmVlKHNwYW5fc3RyKTsKIAlrc2Z0X2Zp
bmlzaGVkKCk7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L3Jlc2N0cmxfdmFsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0
cmxfdmFsLmMKaW5kZXggODg3ODk2Nzg5MTdiLi41YTQ5ZjA3YTZjODUgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybF92YWwuYworKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdmFsLmMKQEAgLTE1Niwx
MiArMTU2LDEyIEBAIHN0YXRpYyBpbnQgcmVhZF9mcm9tX2ltY19kaXIoY2hhciAqaW1jX2Rp
ciwgaW50IGNvdW50KQogCXNwcmludGYoaW1jX2NvdW50ZXJfdHlwZSwgIiVzJXMiLCBpbWNf
ZGlyLCAidHlwZSIpOwogCWZwID0gZm9wZW4oaW1jX2NvdW50ZXJfdHlwZSwgInIiKTsKIAlp
ZiAoIWZwKSB7Ci0JCXBlcnJvcigiRmFpbGVkIHRvIG9wZW4gaW1jIGNvdW50ZXIgdHlwZSBm
aWxlIik7CisJCWtzZnRfcGVycm9yKCJGYWlsZWQgdG8gb3BlbiBpTUMgY291bnRlciB0eXBl
IGZpbGUiKTsKIAogCQlyZXR1cm4gLTE7CiAJfQogCWlmIChmc2NhbmYoZnAsICIldSIsICZp
bWNfY291bnRlcnNfY29uZmlnW2NvdW50XVtSRUFEXS50eXBlKSA8PSAwKSB7Ci0JCXBlcnJv
cigiQ291bGQgbm90IGdldCBpbWMgdHlwZSIpOworCQlrc2Z0X3BlcnJvcigiQ291bGQgbm90
IGdldCBpTUMgdHlwZSIpOwogCQlmY2xvc2UoZnApOwogCiAJCXJldHVybiAtMTsKQEAgLTE3
NSwxMiArMTc1LDEyIEBAIHN0YXRpYyBpbnQgcmVhZF9mcm9tX2ltY19kaXIoY2hhciAqaW1j
X2RpciwgaW50IGNvdW50KQogCXNwcmludGYoaW1jX2NvdW50ZXJfY2ZnLCAiJXMlcyIsIGlt
Y19kaXIsIFJFQURfRklMRV9OQU1FKTsKIAlmcCA9IGZvcGVuKGltY19jb3VudGVyX2NmZywg
InIiKTsKIAlpZiAoIWZwKSB7Ci0JCXBlcnJvcigiRmFpbGVkIHRvIG9wZW4gaW1jIGNvbmZp
ZyBmaWxlIik7CisJCWtzZnRfcGVycm9yKCJGYWlsZWQgdG8gb3BlbiBpTUMgY29uZmlnIGZp
bGUiKTsKIAogCQlyZXR1cm4gLTE7CiAJfQogCWlmIChmc2NhbmYoZnAsICIlcyIsIGNhc19j
b3VudF9jZmcpIDw9IDApIHsKLQkJcGVycm9yKCJDb3VsZCBub3QgZ2V0IGltYyBjYXMgY291
bnQgcmVhZCIpOworCQlrc2Z0X3BlcnJvcigiQ291bGQgbm90IGdldCBpTUMgY2FzIGNvdW50
IHJlYWQiKTsKIAkJZmNsb3NlKGZwKTsKIAogCQlyZXR1cm4gLTE7CkBAIC0xOTMsMTIgKzE5
MywxMiBAQCBzdGF0aWMgaW50IHJlYWRfZnJvbV9pbWNfZGlyKGNoYXIgKmltY19kaXIsIGlu
dCBjb3VudCkKIAlzcHJpbnRmKGltY19jb3VudGVyX2NmZywgIiVzJXMiLCBpbWNfZGlyLCBX
UklURV9GSUxFX05BTUUpOwogCWZwID0gZm9wZW4oaW1jX2NvdW50ZXJfY2ZnLCAiciIpOwog
CWlmICghZnApIHsKLQkJcGVycm9yKCJGYWlsZWQgdG8gb3BlbiBpbWMgY29uZmlnIGZpbGUi
KTsKKwkJa3NmdF9wZXJyb3IoIkZhaWxlZCB0byBvcGVuIGlNQyBjb25maWcgZmlsZSIpOwog
CiAJCXJldHVybiAtMTsKIAl9CiAJaWYgIChmc2NhbmYoZnAsICIlcyIsIGNhc19jb3VudF9j
ZmcpIDw9IDApIHsKLQkJcGVycm9yKCJDb3VsZCBub3QgZ2V0IGltYyBjYXMgY291bnQgd3Jp
dGUiKTsKKwkJa3NmdF9wZXJyb3IoIkNvdWxkIG5vdCBnZXQgaU1DIGNhcyBjb3VudCB3cml0
ZSIpOwogCQlmY2xvc2UoZnApOwogCiAJCXJldHVybiAtMTsKQEAgLTI2MiwxMiArMjYyLDEy
IEBAIHN0YXRpYyBpbnQgbnVtX29mX2ltY3Modm9pZCkKIAkJfQogCQljbG9zZWRpcihkcCk7
CiAJCWlmIChjb3VudCA9PSAwKSB7Ci0JCQlwZXJyb3IoIlVuYWJsZSBmaW5kIGlNQyBjb3Vu
dGVycyFcbiIpOworCQkJa3NmdF9wcmludF9tc2coIlVuYWJsZSB0byBmaW5kIGlNQyBjb3Vu
dGVyc1xuIik7CiAKIAkJCXJldHVybiAtMTsKIAkJfQogCX0gZWxzZSB7Ci0JCXBlcnJvcigi
VW5hYmxlIHRvIG9wZW4gUE1VIGRpcmVjdG9yeSFcbiIpOworCQlrc2Z0X3BlcnJvcigiVW5h
YmxlIHRvIG9wZW4gUE1VIGRpcmVjdG9yeSIpOwogCiAJCXJldHVybiAtMTsKIAl9CkBAIC0z
MzksMTQgKzMzOSwxNCBAQCBzdGF0aWMgaW50IGdldF9tZW1fYndfaW1jKGludCBjcHVfbm8s
IGNoYXIgKmJ3X3JlcG9ydCwgZmxvYXQgKmJ3X2ltYykKIAogCQlpZiAocmVhZChyLT5mZCwg
JnItPnJldHVybl92YWx1ZSwKIAkJCSBzaXplb2Yoc3RydWN0IG1lbWJ3X3JlYWRfZm9ybWF0
KSkgPT0gLTEpIHsKLQkJCXBlcnJvcigiQ291bGRuJ3QgZ2V0IHJlYWQgYi93IHRocm91Z2gg
aU1DIik7CisJCQlrc2Z0X3BlcnJvcigiQ291bGRuJ3QgZ2V0IHJlYWQgYi93IHRocm91Z2gg
aU1DIik7CiAKIAkJCXJldHVybiAtMTsKIAkJfQogCiAJCWlmIChyZWFkKHctPmZkLCAmdy0+
cmV0dXJuX3ZhbHVlLAogCQkJIHNpemVvZihzdHJ1Y3QgbWVtYndfcmVhZF9mb3JtYXQpKSA9
PSAtMSkgewotCQkJcGVycm9yKCJDb3VsZG4ndCBnZXQgd3JpdGUgYncgdGhyb3VnaCBpTUMi
KTsKKwkJCWtzZnRfcGVycm9yKCJDb3VsZG4ndCBnZXQgd3JpdGUgYncgdGhyb3VnaCBpTUMi
KTsKIAogCQkJcmV0dXJuIC0xOwogCQl9CkBAIC0zODcsMjAgKzM4NywyMCBAQCBzdGF0aWMg
aW50IGdldF9tZW1fYndfaW1jKGludCBjcHVfbm8sIGNoYXIgKmJ3X3JlcG9ydCwgZmxvYXQg
KmJ3X2ltYykKIAlyZXR1cm4gMDsKIH0KIAotdm9pZCBzZXRfbWJtX3BhdGgoY29uc3QgY2hh
ciAqY3RybGdycCwgY29uc3QgY2hhciAqbW9uZ3JwLCBpbnQgcmVzb3VyY2VfaWQpCit2b2lk
IHNldF9tYm1fcGF0aChjb25zdCBjaGFyICpjdHJsZ3JwLCBjb25zdCBjaGFyICptb25ncnAs
IGludCBkb21haW5faWQpCiB7CiAJaWYgKGN0cmxncnAgJiYgbW9uZ3JwKQogCQlzcHJpbnRm
KG1ibV90b3RhbF9wYXRoLCBDT05fTU9OX01CTV9MT0NBTF9CWVRFU19QQVRILAotCQkJUkVT
Q1RSTF9QQVRILCBjdHJsZ3JwLCBtb25ncnAsIHJlc291cmNlX2lkKTsKKwkJCVJFU0NUUkxf
UEFUSCwgY3RybGdycCwgbW9uZ3JwLCBkb21haW5faWQpOwogCWVsc2UgaWYgKCFjdHJsZ3Jw
ICYmIG1vbmdycCkKIAkJc3ByaW50ZihtYm1fdG90YWxfcGF0aCwgTU9OX01CTV9MT0NBTF9C
WVRFU19QQVRILCBSRVNDVFJMX1BBVEgsCi0JCQltb25ncnAsIHJlc291cmNlX2lkKTsKKwkJ
CW1vbmdycCwgZG9tYWluX2lkKTsKIAllbHNlIGlmIChjdHJsZ3JwICYmICFtb25ncnApCiAJ
CXNwcmludGYobWJtX3RvdGFsX3BhdGgsIENPTl9NQk1fTE9DQUxfQllURVNfUEFUSCwgUkVT
Q1RSTF9QQVRILAotCQkJY3RybGdycCwgcmVzb3VyY2VfaWQpOworCQkJY3RybGdycCwgZG9t
YWluX2lkKTsKIAllbHNlIGlmICghY3RybGdycCAmJiAhbW9uZ3JwKQogCQlzcHJpbnRmKG1i
bV90b3RhbF9wYXRoLCBNQk1fTE9DQUxfQllURVNfUEFUSCwgUkVTQ1RSTF9QQVRILAotCQkJ
cmVzb3VyY2VfaWQpOworCQkJZG9tYWluX2lkKTsKIH0KIAogLyoKQEAgLTQxMywyMyArNDEz
LDIzIEBAIHZvaWQgc2V0X21ibV9wYXRoKGNvbnN0IGNoYXIgKmN0cmxncnAsIGNvbnN0IGNo
YXIgKm1vbmdycCwgaW50IHJlc291cmNlX2lkKQogc3RhdGljIHZvaWQgaW5pdGlhbGl6ZV9t
ZW1fYndfcmVzY3RybChjb25zdCBjaGFyICpjdHJsZ3JwLCBjb25zdCBjaGFyICptb25ncnAs
CiAJCQkJICAgICAgaW50IGNwdV9ubywgY2hhciAqcmVzY3RybF92YWwpCiB7Ci0JaW50IHJl
c291cmNlX2lkOworCWludCBkb21haW5faWQ7CiAKLQlpZiAoZ2V0X3Jlc291cmNlX2lkKGNw
dV9ubywgJnJlc291cmNlX2lkKSA8IDApIHsKLQkJcGVycm9yKCJDb3VsZCBub3QgZ2V0IHJl
c291cmNlX2lkIik7CisJaWYgKGdldF9kb21haW5faWQoIk1CIiwgY3B1X25vLCAmZG9tYWlu
X2lkKSA8IDApIHsKKwkJa3NmdF9wcmludF9tc2coIkNvdWxkIG5vdCBnZXQgZG9tYWluIElE
XG4iKTsKIAkJcmV0dXJuOwogCX0KIAogCWlmICghc3RybmNtcChyZXNjdHJsX3ZhbCwgTUJN
X1NUUiwgc2l6ZW9mKE1CTV9TVFIpKSkKLQkJc2V0X21ibV9wYXRoKGN0cmxncnAsIG1vbmdy
cCwgcmVzb3VyY2VfaWQpOworCQlzZXRfbWJtX3BhdGgoY3RybGdycCwgbW9uZ3JwLCBkb21h
aW5faWQpOwogCiAJaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBNQkFfU1RSLCBzaXplb2Yo
TUJBX1NUUikpKSB7CiAJCWlmIChjdHJsZ3JwKQogCQkJc3ByaW50ZihtYm1fdG90YWxfcGF0
aCwgQ09OX01CTV9MT0NBTF9CWVRFU19QQVRILAotCQkJCVJFU0NUUkxfUEFUSCwgY3RybGdy
cCwgcmVzb3VyY2VfaWQpOworCQkJCVJFU0NUUkxfUEFUSCwgY3RybGdycCwgZG9tYWluX2lk
KTsKIAkJZWxzZQogCQkJc3ByaW50ZihtYm1fdG90YWxfcGF0aCwgTUJNX0xPQ0FMX0JZVEVT
X1BBVEgsCi0JCQkJUkVTQ1RSTF9QQVRILCByZXNvdXJjZV9pZCk7CisJCQkJUkVTQ1RSTF9Q
QVRILCBkb21haW5faWQpOwogCX0KIH0KIApAQCAtNDQ5LDEyICs0NDksMTIgQEAgc3RhdGlj
IGludCBnZXRfbWVtX2J3X3Jlc2N0cmwodW5zaWduZWQgbG9uZyAqbWJtX3RvdGFsKQogCiAJ
ZnAgPSBmb3BlbihtYm1fdG90YWxfcGF0aCwgInIiKTsKIAlpZiAoIWZwKSB7Ci0JCXBlcnJv
cigiRmFpbGVkIHRvIG9wZW4gdG90YWwgYncgZmlsZSIpOworCQlrc2Z0X3BlcnJvcigiRmFp
bGVkIHRvIG9wZW4gdG90YWwgYncgZmlsZSIpOwogCiAJCXJldHVybiAtMTsKIAl9CiAJaWYg
KGZzY2FuZihmcCwgIiVsdSIsIG1ibV90b3RhbCkgPD0gMCkgewotCQlwZXJyb3IoIkNvdWxk
IG5vdCBnZXQgbWJtIGxvY2FsIGJ5dGVzIik7CisJCWtzZnRfcGVycm9yKCJDb3VsZCBub3Qg
Z2V0IG1ibSBsb2NhbCBieXRlcyIpOwogCQlmY2xvc2UoZnApOwogCiAJCXJldHVybiAtMTsK
QEAgLTQ5NSw3ICs0OTUsNyBAQCBpbnQgc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIodm9pZCkK
IAlpZiAoc2lnYWN0aW9uKFNJR0lOVCwgJnNpZ2FjdCwgTlVMTCkgfHwKIAkgICAgc2lnYWN0
aW9uKFNJR1RFUk0sICZzaWdhY3QsIE5VTEwpIHx8CiAJICAgIHNpZ2FjdGlvbihTSUdIVVAs
ICZzaWdhY3QsIE5VTEwpKSB7Ci0JCXBlcnJvcigiIyBzaWdhY3Rpb24iKTsKKwkJa3NmdF9w
ZXJyb3IoInNpZ2FjdGlvbiIpOwogCQlyZXQgPSAtMTsKIAl9CiAJcmV0dXJuIHJldDsKQEAg
LTUxNSw3ICs1MTUsNyBAQCB2b2lkIHNpZ25hbF9oYW5kbGVyX3VucmVnaXN0ZXIodm9pZCkK
IAlpZiAoc2lnYWN0aW9uKFNJR0lOVCwgJnNpZ2FjdCwgTlVMTCkgfHwKIAkgICAgc2lnYWN0
aW9uKFNJR1RFUk0sICZzaWdhY3QsIE5VTEwpIHx8CiAJICAgIHNpZ2FjdGlvbihTSUdIVVAs
ICZzaWdhY3QsIE5VTEwpKSB7Ci0JCXBlcnJvcigiIyBzaWdhY3Rpb24iKTsKKwkJa3NmdF9w
ZXJyb3IoInNpZ2FjdGlvbiIpOwogCX0KIH0KIApAQCAtNTI2LDcgKzUyNiw3IEBAIHZvaWQg
c2lnbmFsX2hhbmRsZXJfdW5yZWdpc3Rlcih2b2lkKQogICogQGJ3X2ltYzoJCXBlcmYgaW1j
IGNvdW50ZXIgdmFsdWUKICAqIEBid19yZXNjOgkJbWVtb3J5IGJhbmR3aWR0aCB2YWx1ZQog
ICoKLSAqIFJldHVybjoJCTAgb24gc3VjY2Vzcy4gbm9uLXplcm8gb24gZmFpbHVyZS4KKyAq
IFJldHVybjoJCTAgb24gc3VjY2VzcywgPCAwIG9uIGVycm9yLgogICovCiBzdGF0aWMgaW50
IHByaW50X3Jlc3VsdHNfYncoY2hhciAqZmlsZW5hbWUsICBpbnQgYm1fcGlkLCBmbG9hdCBi
d19pbWMsCiAJCQkgICAgdW5zaWduZWQgbG9uZyBid19yZXNjKQpAQCAtNTQwLDE2ICs1NDAs
MTYgQEAgc3RhdGljIGludCBwcmludF9yZXN1bHRzX2J3KGNoYXIgKmZpbGVuYW1lLCAgaW50
IGJtX3BpZCwgZmxvYXQgYndfaW1jLAogCX0gZWxzZSB7CiAJCWZwID0gZm9wZW4oZmlsZW5h
bWUsICJhIik7CiAJCWlmICghZnApIHsKLQkJCXBlcnJvcigiQ2Fubm90IG9wZW4gcmVzdWx0
cyBmaWxlIik7CisJCQlrc2Z0X3BlcnJvcigiQ2Fubm90IG9wZW4gcmVzdWx0cyBmaWxlIik7
CiAKLQkJCXJldHVybiBlcnJubzsKKwkJCXJldHVybiAtMTsKIAkJfQogCQlpZiAoZnByaW50
ZihmcCwgIlBpZDogJWQgXHQgTWVtX0JXX2lNQzogJWYgXHQgTWVtX0JXX3Jlc2M6ICVsdSBc
dCBEaWZmZXJlbmNlOiAlbHVcbiIsCiAJCQkgICAgYm1fcGlkLCBid19pbWMsIGJ3X3Jlc2Ms
IGRpZmYpIDw9IDApIHsKKwkJCWtzZnRfcHJpbnRfbXNnKCJDb3VsZCBub3QgbG9nIHJlc3Vs
dHNcbiIpOwogCQkJZmNsb3NlKGZwKTsKLQkJCXBlcnJvcigiQ291bGQgbm90IGxvZyByZXN1
bHRzLiIpOwogCi0JCQlyZXR1cm4gZXJybm87CisJCQlyZXR1cm4gLTE7CiAJCX0KIAkJZmNs
b3NlKGZwKTsKIAl9CkBAIC01ODIsMTkgKzU4MiwyMCBAQCBzdGF0aWMgdm9pZCBzZXRfY210
X3BhdGgoY29uc3QgY2hhciAqY3RybGdycCwgY29uc3QgY2hhciAqbW9uZ3JwLCBjaGFyIHNv
Y2tfbnVtKQogc3RhdGljIHZvaWQgaW5pdGlhbGl6ZV9sbGNfb2NjdV9yZXNjdHJsKGNvbnN0
IGNoYXIgKmN0cmxncnAsIGNvbnN0IGNoYXIgKm1vbmdycCwKIAkJCQkJaW50IGNwdV9ubywg
Y2hhciAqcmVzY3RybF92YWwpCiB7Ci0JaW50IHJlc291cmNlX2lkOworCWludCBkb21haW5f
aWQ7CiAKLQlpZiAoZ2V0X3Jlc291cmNlX2lkKGNwdV9ubywgJnJlc291cmNlX2lkKSA8IDAp
IHsKLQkJcGVycm9yKCIjIFVuYWJsZSB0byByZXNvdXJjZV9pZCIpOworCWlmIChnZXRfZG9t
YWluX2lkKCJMMyIsIGNwdV9ubywgJmRvbWFpbl9pZCkgPCAwKSB7CisJCWtzZnRfcHJpbnRf
bXNnKCJDb3VsZCBub3QgZ2V0IGRvbWFpbiBJRFxuIik7CiAJCXJldHVybjsKIAl9CiAKIAlp
ZiAoIXN0cm5jbXAocmVzY3RybF92YWwsIENNVF9TVFIsIHNpemVvZihDTVRfU1RSKSkpCi0J
CXNldF9jbXRfcGF0aChjdHJsZ3JwLCBtb25ncnAsIHJlc291cmNlX2lkKTsKKwkJc2V0X2Nt
dF9wYXRoKGN0cmxncnAsIG1vbmdycCwgZG9tYWluX2lkKTsKIH0KIAotc3RhdGljIGludAot
bWVhc3VyZV92YWxzKHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0sIHVuc2lnbmVk
IGxvbmcgKmJ3X3Jlc2Nfc3RhcnQpCitzdGF0aWMgaW50IG1lYXN1cmVfdmFscyhjb25zdCBz
dHJ1Y3QgdXNlcl9wYXJhbXMgKnVwYXJhbXMsCisJCQlzdHJ1Y3QgcmVzY3RybF92YWxfcGFy
YW0gKnBhcmFtLAorCQkJdW5zaWduZWQgbG9uZyAqYndfcmVzY19zdGFydCkKIHsKIAl1bnNp
Z25lZCBsb25nIGJ3X3Jlc2MsIGJ3X3Jlc2NfZW5kOwogCWZsb2F0IGJ3X2ltYzsKQEAgLTYw
Nyw3ICs2MDgsNyBAQCBtZWFzdXJlX3ZhbHMoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpw
YXJhbSwgdW5zaWduZWQgbG9uZyAqYndfcmVzY19zdGFydCkKIAkgKiBDb21wYXJlIHRoZSB0
d28gdmFsdWVzIHRvIHZhbGlkYXRlIHJlc2N0cmwgdmFsdWUuCiAJICogSXQgdGFrZXMgMXNl
YyB0byBtZWFzdXJlIHRoZSBkYXRhLgogCSAqLwotCXJldCA9IGdldF9tZW1fYndfaW1jKHBh
cmFtLT5jcHVfbm8sIHBhcmFtLT5id19yZXBvcnQsICZid19pbWMpOworCXJldCA9IGdldF9t
ZW1fYndfaW1jKHVwYXJhbXMtPmNwdSwgcGFyYW0tPmJ3X3JlcG9ydCwgJmJ3X2ltYyk7CiAJ
aWYgKHJldCA8IDApCiAJCXJldHVybiByZXQ7CiAKQEAgLTY0NywyMCArNjQ4LDI0IEBAIHN0
YXRpYyB2b2lkIHJ1bl9iZW5jaG1hcmsoaW50IHNpZ251bSwgc2lnaW5mb190ICppbmZvLCB2
b2lkICp1Y29udGV4dCkKIAkgKiBzdGRpbyAoY29uc29sZSkKIAkgKi8KIAlmcCA9IGZyZW9w
ZW4oIi9kZXYvbnVsbCIsICJ3Iiwgc3Rkb3V0KTsKLQlpZiAoIWZwKQotCQlQQVJFTlRfRVhJ
VCgiVW5hYmxlIHRvIGRpcmVjdCBiZW5jaG1hcmsgc3RhdHVzIHRvIC9kZXYvbnVsbCIpOwor
CWlmICghZnApIHsKKwkJa3NmdF9wZXJyb3IoIlVuYWJsZSB0byBkaXJlY3QgYmVuY2htYXJr
IHN0YXR1cyB0byAvZGV2L251bGwiKTsKKwkJUEFSRU5UX0VYSVQoKTsKKwl9CiAKIAlpZiAo
c3RyY21wKGJlbmNobWFya19jbWRbMF0sICJmaWxsX2J1ZiIpID09IDApIHsKIAkJLyogRXhl
Y3V0ZSBkZWZhdWx0IGZpbGxfYnVmIGJlbmNobWFyayAqLwogCQlzcGFuID0gc3RydG91bChi
ZW5jaG1hcmtfY21kWzFdLCBOVUxMLCAxMCk7CiAJCW1lbWZsdXNoID0gIGF0b2koYmVuY2ht
YXJrX2NtZFsyXSk7CiAJCW9wZXJhdGlvbiA9IGF0b2koYmVuY2htYXJrX2NtZFszXSk7Ci0J
CWlmICghc3RyY21wKGJlbmNobWFya19jbWRbNF0sICJ0cnVlIikpCisJCWlmICghc3RyY21w
KGJlbmNobWFya19jbWRbNF0sICJ0cnVlIikpIHsKIAkJCW9uY2UgPSB0cnVlOwotCQllbHNl
IGlmICghc3RyY21wKGJlbmNobWFya19jbWRbNF0sICJmYWxzZSIpKQorCQl9IGVsc2UgaWYg
KCFzdHJjbXAoYmVuY2htYXJrX2NtZFs0XSwgImZhbHNlIikpIHsKIAkJCW9uY2UgPSBmYWxz
ZTsKLQkJZWxzZQotCQkJUEFSRU5UX0VYSVQoIkludmFsaWQgb25jZSBwYXJhbWV0ZXIiKTsK
KwkJfSBlbHNlIHsKKwkJCWtzZnRfcHJpbnRfbXNnKCJJbnZhbGlkIG9uY2UgcGFyYW1ldGVy
XG4iKTsKKwkJCVBBUkVOVF9FWElUKCk7CisJCX0KIAogCQlpZiAocnVuX2ZpbGxfYnVmKHNw
YW4sIG1lbWZsdXNoLCBvcGVyYXRpb24sIG9uY2UpKQogCQkJZnByaW50ZihzdGRlcnIsICJF
cnJvciBpbiBydW5uaW5nIGZpbGwgYnVmZmVyXG4iKTsKQEAgLTY2OCwyMiArNjczLDI4IEBA
IHN0YXRpYyB2b2lkIHJ1bl9iZW5jaG1hcmsoaW50IHNpZ251bSwgc2lnaW5mb190ICppbmZv
LCB2b2lkICp1Y29udGV4dCkKIAkJLyogRXhlY3V0ZSBzcGVjaWZpZWQgYmVuY2htYXJrICov
CiAJCXJldCA9IGV4ZWN2cChiZW5jaG1hcmtfY21kWzBdLCBiZW5jaG1hcmtfY21kKTsKIAkJ
aWYgKHJldCkKLQkJCXBlcnJvcigid3JvbmdcbiIpOworCQkJa3NmdF9wZXJyb3IoImV4ZWN2
cCIpOwogCX0KIAogCWZjbG9zZShzdGRvdXQpOwotCVBBUkVOVF9FWElUKCJVbmFibGUgdG8g
cnVuIHNwZWNpZmllZCBiZW5jaG1hcmsiKTsKKwlrc2Z0X3ByaW50X21zZygiVW5hYmxlIHRv
IHJ1biBzcGVjaWZpZWQgYmVuY2htYXJrXG4iKTsKKwlQQVJFTlRfRVhJVCgpOwogfQogCiAv
KgogICogcmVzY3RybF92YWw6CWV4ZWN1dGUgYmVuY2htYXJrIGFuZCBtZWFzdXJlIG1lbW9y
eSBiYW5kd2lkdGggb24KICAqCQkJdGhlIGJlbmNobWFyaworICogQHRlc3Q6CQl0ZXN0IGlu
Zm9ybWF0aW9uIHN0cnVjdHVyZQorICogQHVwYXJhbXM6CQl1c2VyIHN1cHBsaWVkIHBhcmFt
ZXRlcnMKICAqIEBiZW5jaG1hcmtfY21kOgliZW5jaG1hcmsgY29tbWFuZCBhbmQgaXRzIGFy
Z3VtZW50cwogICogQHBhcmFtOgkJcGFyYW1ldGVycyBwYXNzZWQgdG8gcmVzY3RybF92YWwo
KQogICoKLSAqIFJldHVybjoJCTAgb24gc3VjY2Vzcy4gbm9uLXplcm8gb24gZmFpbHVyZS4K
KyAqIFJldHVybjoJCTAgd2hlbiB0aGUgdGVzdCB3YXMgcnVuLCA8IDAgb24gZXJyb3IuCiAg
Ki8KLWludCByZXNjdHJsX3ZhbChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQs
IHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0pCitpbnQgcmVzY3RybF92YWwoY29u
c3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwKKwkJY29uc3Qgc3RydWN0IHVzZXJfcGFy
YW1zICp1cGFyYW1zLAorCQljb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQsCisJ
CXN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyYW0pCiB7CiAJY2hhciAqcmVzY3RybF92
YWwgPSBwYXJhbS0+cmVzY3RybF92YWw7CiAJdW5zaWduZWQgbG9uZyBid19yZXNjX3N0YXJ0
ID0gMDsKQEAgLTcwOSw3ICs3MjAsNyBAQCBpbnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAq
IGNvbnN0ICpiZW5jaG1hcmtfY21kLCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcgog
CXBwaWQgPSBnZXRwaWQoKTsKIAogCWlmIChwaXBlKHBpcGVmZCkpIHsKLQkJcGVycm9yKCIj
IFVuYWJsZSB0byBjcmVhdGUgcGlwZSIpOworCQlrc2Z0X3BlcnJvcigiVW5hYmxlIHRvIGNy
ZWF0ZSBwaXBlIik7CiAKIAkJcmV0dXJuIC0xOwogCX0KQEAgLTcyMSw3ICs3MzIsNyBAQCBp
bnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kLCBzdHJ1
Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcgogCWZmbHVzaChzdGRvdXQpOwogCWJtX3BpZCA9
IGZvcmsoKTsKIAlpZiAoYm1fcGlkID09IC0xKSB7Ci0JCXBlcnJvcigiIyBVbmFibGUgdG8g
Zm9yayIpOworCQlrc2Z0X3BlcnJvcigiVW5hYmxlIHRvIGZvcmsiKTsKIAogCQlyZXR1cm4g
LTE7CiAJfQpAQCAtNzM4LDE1ICs3NDksMTcgQEAgaW50IHJlc2N0cmxfdmFsKGNvbnN0IGNo
YXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCwgc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpw
YXIKIAkJc2lnYWN0LnNhX2ZsYWdzID0gU0FfU0lHSU5GTzsKIAogCQkvKiBSZWdpc3RlciBm
b3IgIlNJR1VTUjEiIHNpZ25hbCBmcm9tIHBhcmVudCAqLwotCQlpZiAoc2lnYWN0aW9uKFNJ
R1VTUjEsICZzaWdhY3QsIE5VTEwpKQotCQkJUEFSRU5UX0VYSVQoIkNhbid0IHJlZ2lzdGVy
IGNoaWxkIGZvciBzaWduYWwiKTsKKwkJaWYgKHNpZ2FjdGlvbihTSUdVU1IxLCAmc2lnYWN0
LCBOVUxMKSkgeworCQkJa3NmdF9wZXJyb3IoIkNhbid0IHJlZ2lzdGVyIGNoaWxkIGZvciBz
aWduYWwiKTsKKwkJCVBBUkVOVF9FWElUKCk7CisJCX0KIAogCQkvKiBUZWxsIHBhcmVudCB0
aGF0IGNoaWxkIGlzIHJlYWR5ICovCiAJCWNsb3NlKHBpcGVmZFswXSk7CiAJCXBpcGVfbWVz
c2FnZSA9IDE7CiAJCWlmICh3cml0ZShwaXBlZmRbMV0sICZwaXBlX21lc3NhZ2UsIHNpemVv
ZihwaXBlX21lc3NhZ2UpKSA8CiAJCSAgICBzaXplb2YocGlwZV9tZXNzYWdlKSkgewotCQkJ
cGVycm9yKCIjIGZhaWxlZCBzaWduYWxpbmcgcGFyZW50IHByb2Nlc3MiKTsKKwkJCWtzZnRf
cGVycm9yKCJGYWlsZWQgc2lnbmFsaW5nIHBhcmVudCBwcm9jZXNzIik7CiAJCQljbG9zZShw
aXBlZmRbMV0pOwogCQkJcmV0dXJuIC0xOwogCQl9CkBAIC03NTUsNyArNzY4LDggQEAgaW50
IHJlc2N0cmxfdmFsKGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCwgc3RydWN0
IHJlc2N0cmxfdmFsX3BhcmFtICpwYXIKIAkJLyogU3VzcGVuZCBjaGlsZCB1bnRpbCBkZWxp
dmVyeSBvZiAiU0lHVVNSMSIgZnJvbSBwYXJlbnQgKi8KIAkJc2lnc3VzcGVuZCgmc2lnYWN0
LnNhX21hc2spOwogCi0JCVBBUkVOVF9FWElUKCJDaGlsZCBpcyBkb25lIik7CisJCWtzZnRf
cGVycm9yKCJDaGlsZCBpcyBkb25lIik7CisJCVBBUkVOVF9FWElUKCk7CiAJfQogCiAJa3Nm
dF9wcmludF9tc2coIkJlbmNobWFyayBQSUQ6ICVkXG4iLCBibV9waWQpOwpAQCAtNzY5LDcg
Kzc4Myw3IEBAIGludCByZXNjdHJsX3ZhbChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFy
a19jbWQsIHN0cnVjdCByZXNjdHJsX3ZhbF9wYXJhbSAqcGFyCiAJdmFsdWUuc2l2YWxfcHRy
ID0gKHZvaWQgKiliZW5jaG1hcmtfY21kOwogCiAJLyogVGFza3NldCBiZW5jaG1hcmsgdG8g
c3BlY2lmaWVkIGNwdSAqLwotCXJldCA9IHRhc2tzZXRfYmVuY2htYXJrKGJtX3BpZCwgcGFy
YW0tPmNwdV9ubyk7CisJcmV0ID0gdGFza3NldF9iZW5jaG1hcmsoYm1fcGlkLCB1cGFyYW1z
LT5jcHUsIE5VTEwpOwogCWlmIChyZXQpCiAJCWdvdG8gb3V0OwogCkBAIC03ODYsMTcgKzgw
MCwxNyBAQCBpbnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtf
Y21kLCBzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcgogCQkJZ290byBvdXQ7CiAKIAkJ
aW5pdGlhbGl6ZV9tZW1fYndfcmVzY3RybChwYXJhbS0+Y3RybGdycCwgcGFyYW0tPm1vbmdy
cCwKLQkJCQkJICBwYXJhbS0+Y3B1X25vLCByZXNjdHJsX3ZhbCk7CisJCQkJCSAgdXBhcmFt
cy0+Y3B1LCByZXNjdHJsX3ZhbCk7CiAJfSBlbHNlIGlmICghc3RybmNtcChyZXNjdHJsX3Zh
bCwgQ01UX1NUUiwgc2l6ZW9mKENNVF9TVFIpKSkKIAkJaW5pdGlhbGl6ZV9sbGNfb2NjdV9y
ZXNjdHJsKHBhcmFtLT5jdHJsZ3JwLCBwYXJhbS0+bW9uZ3JwLAotCQkJCQkgICAgcGFyYW0t
PmNwdV9ubywgcmVzY3RybF92YWwpOworCQkJCQkgICAgdXBhcmFtcy0+Y3B1LCByZXNjdHJs
X3ZhbCk7CiAKIAkvKiBQYXJlbnQgd2FpdHMgZm9yIGNoaWxkIHRvIGJlIHJlYWR5LiAqLwog
CWNsb3NlKHBpcGVmZFsxXSk7CiAJd2hpbGUgKHBpcGVfbWVzc2FnZSAhPSAxKSB7CiAJCWlm
IChyZWFkKHBpcGVmZFswXSwgJnBpcGVfbWVzc2FnZSwgc2l6ZW9mKHBpcGVfbWVzc2FnZSkp
IDwKIAkJICAgIHNpemVvZihwaXBlX21lc3NhZ2UpKSB7Ci0JCQlwZXJyb3IoIiMgZmFpbGVk
IHJlYWRpbmcgbWVzc2FnZSBmcm9tIGNoaWxkIHByb2Nlc3MiKTsKKwkJCWtzZnRfcGVycm9y
KCJGYWlsZWQgcmVhZGluZyBtZXNzYWdlIGZyb20gY2hpbGQgcHJvY2VzcyIpOwogCQkJY2xv
c2UocGlwZWZkWzBdKTsKIAkJCWdvdG8gb3V0OwogCQl9CkBAIC04MDUsOCArODE5LDggQEAg
aW50IHJlc2N0cmxfdmFsKGNvbnN0IGNoYXIgKiBjb25zdCAqYmVuY2htYXJrX2NtZCwgc3Ry
dWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXIKIAogCS8qIFNpZ25hbCBjaGlsZCB0byBzdGFy
dCBiZW5jaG1hcmsgKi8KIAlpZiAoc2lncXVldWUoYm1fcGlkLCBTSUdVU1IxLCB2YWx1ZSkg
PT0gLTEpIHsKLQkJcGVycm9yKCIjIHNpZ3F1ZXVlIFNJR1VTUjEgdG8gY2hpbGQiKTsKLQkJ
cmV0ID0gZXJybm87CisJCWtzZnRfcGVycm9yKCJzaWdxdWV1ZSBTSUdVU1IxIHRvIGNoaWxk
Iik7CisJCXJldCA9IC0xOwogCQlnb3RvIG91dDsKIAl9CiAKQEAgLTgxNSw3ICs4MjksNyBA
QCBpbnQgcmVzY3RybF92YWwoY29uc3QgY2hhciAqIGNvbnN0ICpiZW5jaG1hcmtfY21kLCBz
dHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcgogCiAJLyogVGVzdCBydW5zIHVudGlsIHRo
ZSBjYWxsYmFjayBzZXR1cCgpIHRlbGxzIHRoZSB0ZXN0IHRvIHN0b3AuICovCiAJd2hpbGUg
KDEpIHsKLQkJcmV0ID0gcGFyYW0tPnNldHVwKHBhcmFtKTsKKwkJcmV0ID0gcGFyYW0tPnNl
dHVwKHRlc3QsIHVwYXJhbXMsIHBhcmFtKTsKIAkJaWYgKHJldCA9PSBFTkRfT0ZfVEVTVFMp
IHsKIAkJCXJldCA9IDA7CiAJCQlicmVhazsKQEAgLTgyNSwxMiArODM5LDEyIEBAIGludCBy
ZXNjdHJsX3ZhbChjb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQsIHN0cnVjdCBy
ZXNjdHJsX3ZhbF9wYXJhbSAqcGFyCiAKIAkJaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBN
Qk1fU1RSLCBzaXplb2YoTUJNX1NUUikpIHx8CiAJCSAgICAhc3RybmNtcChyZXNjdHJsX3Zh
bCwgTUJBX1NUUiwgc2l6ZW9mKE1CQV9TVFIpKSkgewotCQkJcmV0ID0gbWVhc3VyZV92YWxz
KHBhcmFtLCAmYndfcmVzY19zdGFydCk7CisJCQlyZXQgPSBtZWFzdXJlX3ZhbHModXBhcmFt
cywgcGFyYW0sICZid19yZXNjX3N0YXJ0KTsKIAkJCWlmIChyZXQpCiAJCQkJYnJlYWs7CiAJ
CX0gZWxzZSBpZiAoIXN0cm5jbXAocmVzY3RybF92YWwsIENNVF9TVFIsIHNpemVvZihDTVRf
U1RSKSkpIHsKIAkJCXNsZWVwKDEpOwotCQkJcmV0ID0gbWVhc3VyZV9jYWNoZV92YWxzKHBh
cmFtLCBibV9waWQpOworCQkJcmV0ID0gbWVhc3VyZV9sbGNfcmVzY3RybChwYXJhbS0+Zmls
ZW5hbWUsIGJtX3BpZCk7CiAJCQlpZiAocmV0KQogCQkJCWJyZWFrOwogCQl9CmRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxmcy5jIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsZnMuYwppbmRleCA1ZWJkNDM2
ODM4NzYuLjFjYWRlNzUxNzZlYiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmVzY3RybC9yZXNjdHJsZnMuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL3Jlc2N0cmxmcy5jCkBAIC0yMCw3ICsyMCw3IEBAIHN0YXRpYyBpbnQgZmluZF9y
ZXNjdHJsX21vdW50KGNoYXIgKmJ1ZmZlcikKIAogCW1vdW50cyA9IGZvcGVuKCIvcHJvYy9t
b3VudHMiLCAiciIpOwogCWlmICghbW91bnRzKSB7Ci0JCXBlcnJvcigiL3Byb2MvbW91bnRz
Iik7CisJCWtzZnRfcGVycm9yKCIvcHJvYy9tb3VudHMiKTsKIAkJcmV0dXJuIC1FTlhJTzsK
IAl9CiAJd2hpbGUgKCFmZW9mKG1vdW50cykpIHsKQEAgLTU2LDcgKzU2LDcgQEAgc3RhdGlj
IGludCBmaW5kX3Jlc2N0cmxfbW91bnQoY2hhciAqYnVmZmVyKQogICogTW91bnRzIHJlc2N0
cmwgRlMuIEZhaWxzIGlmIHJlc2N0cmwgRlMgaXMgYWxyZWFkeSBtb3VudGVkIHRvIGF2b2lk
CiAgKiBwcmUtZXhpc3Rpbmcgc2V0dGluZ3MgaW50ZXJmZXJpbmcgd2l0aCB0aGUgdGVzdCBy
ZXN1bHRzLgogICoKLSAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBub24temVybyBvbiBmYWls
dXJlCisgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgPCAwIG9uIGVycm9yLgogICovCiBpbnQg
bW91bnRfcmVzY3RybGZzKHZvaWQpCiB7CkBAIC02OSw3ICs2OSw3IEBAIGludCBtb3VudF9y
ZXNjdHJsZnModm9pZCkKIAlrc2Z0X3ByaW50X21zZygiTW91bnRpbmcgcmVzY3RybCB0byBc
IiVzXCJcbiIsIFJFU0NUUkxfUEFUSCk7CiAJcmV0ID0gbW91bnQoInJlc2N0cmwiLCBSRVND
VFJMX1BBVEgsICJyZXNjdHJsIiwgMCwgTlVMTCk7CiAJaWYgKHJldCkKLQkJcGVycm9yKCIj
IG1vdW50Iik7CisJCWtzZnRfcGVycm9yKCJtb3VudCIpOwogCiAJcmV0dXJuIHJldDsKIH0K
QEAgLTg2LDQxICs4Niw2NyBAQCBpbnQgdW1vdW50X3Jlc2N0cmxmcyh2b2lkKQogCQlyZXR1
cm4gcmV0OwogCiAJaWYgKHVtb3VudChtb3VudHBvaW50KSkgewotCQlwZXJyb3IoIiMgVW5h
YmxlIHRvIHVtb3VudCByZXNjdHJsIik7CisJCWtzZnRfcGVycm9yKCJVbmFibGUgdG8gdW1v
dW50IHJlc2N0cmwiKTsKIAotCQlyZXR1cm4gZXJybm87CisJCXJldHVybiAtMTsKIAl9CiAK
IAlyZXR1cm4gMDsKIH0KIAogLyoKLSAqIGdldF9yZXNvdXJjZV9pZCAtIEdldCBzb2NrZXQg
bnVtYmVyL2wzIGlkIGZvciBhIHNwZWNpZmllZCBDUFUKKyAqIGdldF9jYWNoZV9sZXZlbCAt
IENvbnZlcnQgY2FjaGUgbGV2ZWwgZnJvbSBzdHJpbmcgdG8gaW50ZWdlcgorICogQGNhY2hl
X3R5cGU6CQlDYWNoZSBsZXZlbCBhcyBzdHJpbmcKKyAqCisgKiBSZXR1cm46IGNhY2hlIGxl
dmVsIGFzIGludGVnZXIgb3IgLTEgaWYgQGNhY2hlX3R5cGUgaXMgaW52YWxpZC4KKyAqLwor
c3RhdGljIGludCBnZXRfY2FjaGVfbGV2ZWwoY29uc3QgY2hhciAqY2FjaGVfdHlwZSkKK3sK
KwlpZiAoIXN0cmNtcChjYWNoZV90eXBlLCAiTDMiKSkKKwkJcmV0dXJuIDM7CisJaWYgKCFz
dHJjbXAoY2FjaGVfdHlwZSwgIkwyIikpCisJCXJldHVybiAyOworCisJa3NmdF9wcmludF9t
c2coIkludmFsaWQgY2FjaGUgbGV2ZWxcbiIpOworCXJldHVybiAtMTsKK30KKworc3RhdGlj
IGludCBnZXRfcmVzb3VyY2VfY2FjaGVfbGV2ZWwoY29uc3QgY2hhciAqcmVzb3VyY2UpCit7
CisJLyogIk1CIiB1c2UgTDMgKExMQykgYXMgcmVzb3VyY2UgKi8KKwlpZiAoIXN0cmNtcChy
ZXNvdXJjZSwgIk1CIikpCisJCXJldHVybiAzOworCXJldHVybiBnZXRfY2FjaGVfbGV2ZWwo
cmVzb3VyY2UpOworfQorCisvKgorICogZ2V0X2RvbWFpbl9pZCAtIEdldCByZXNjdHJsIGRv
bWFpbiBJRCBmb3IgYSBzcGVjaWZpZWQgQ1BVCisgKiBAcmVzb3VyY2U6CXJlc291cmNlIG5h
bWUKICAqIEBjcHVfbm86CUNQVSBudW1iZXIKLSAqIEByZXNvdXJjZV9pZDogU29ja2V0IG51
bWJlciBvciBsM19pZAorICogQGRvbWFpbl9pZDoJZG9tYWluIElEIChjYWNoZSBJRDsgZm9y
IE1CLCBMMyBjYWNoZSBJRCkKICAqCiAgKiBSZXR1cm46ID49IDAgb24gc3VjY2VzcywgPCAw
IG9uIGZhaWx1cmUuCiAgKi8KLWludCBnZXRfcmVzb3VyY2VfaWQoaW50IGNwdV9ubywgaW50
ICpyZXNvdXJjZV9pZCkKK2ludCBnZXRfZG9tYWluX2lkKGNvbnN0IGNoYXIgKnJlc291cmNl
LCBpbnQgY3B1X25vLCBpbnQgKmRvbWFpbl9pZCkKIHsKIAljaGFyIHBoeXNfcGtnX3BhdGhb
MTAyNF07CisJaW50IGNhY2hlX251bTsKIAlGSUxFICpmcDsKIAotCWlmIChnZXRfdmVuZG9y
KCkgPT0gQVJDSF9BTUQpCi0JCXNwcmludGYocGh5c19wa2dfcGF0aCwgIiVzJWQvY2FjaGUv
aW5kZXgzL2lkIiwKLQkJCVBIWVNfSURfUEFUSCwgY3B1X25vKTsKLQllbHNlCi0JCXNwcmlu
dGYocGh5c19wa2dfcGF0aCwgIiVzJWQvdG9wb2xvZ3kvcGh5c2ljYWxfcGFja2FnZV9pZCIs
Ci0JCQlQSFlTX0lEX1BBVEgsIGNwdV9ubyk7CisJY2FjaGVfbnVtID0gZ2V0X3Jlc291cmNl
X2NhY2hlX2xldmVsKHJlc291cmNlKTsKKwlpZiAoY2FjaGVfbnVtIDwgMCkKKwkJcmV0dXJu
IGNhY2hlX251bTsKKworCXNwcmludGYocGh5c19wa2dfcGF0aCwgIiVzJWQvY2FjaGUvaW5k
ZXglZC9pZCIsIFBIWVNfSURfUEFUSCwgY3B1X25vLCBjYWNoZV9udW0pOwogCiAJZnAgPSBm
b3BlbihwaHlzX3BrZ19wYXRoLCAiciIpOwogCWlmICghZnApIHsKLQkJcGVycm9yKCJGYWls
ZWQgdG8gb3BlbiBwaHlzaWNhbF9wYWNrYWdlX2lkIik7CisJCWtzZnRfcGVycm9yKCJGYWls
ZWQgdG8gb3BlbiBjYWNoZSBpZCBmaWxlIik7CiAKIAkJcmV0dXJuIC0xOwogCX0KLQlpZiAo
ZnNjYW5mKGZwLCAiJWQiLCByZXNvdXJjZV9pZCkgPD0gMCkgewotCQlwZXJyb3IoIkNvdWxk
IG5vdCBnZXQgc29ja2V0IG51bWJlciBvciBsMyBpZCIpOworCWlmIChmc2NhbmYoZnAsICIl
ZCIsIGRvbWFpbl9pZCkgPD0gMCkgeworCQlrc2Z0X3BlcnJvcigiQ291bGQgbm90IGdldCBk
b21haW4gSUQiKTsKIAkJZmNsb3NlKGZwKTsKIAogCQlyZXR1cm4gLTE7CkBAIC0xMzgsMzEg
KzE2NCwyNiBAQCBpbnQgZ2V0X3Jlc291cmNlX2lkKGludCBjcHVfbm8sIGludCAqcmVzb3Vy
Y2VfaWQpCiAgKgogICogUmV0dXJuOiA9IDAgb24gc3VjY2VzcywgPCAwIG9uIGZhaWx1cmUu
CiAgKi8KLWludCBnZXRfY2FjaGVfc2l6ZShpbnQgY3B1X25vLCBjaGFyICpjYWNoZV90eXBl
LCB1bnNpZ25lZCBsb25nICpjYWNoZV9zaXplKQoraW50IGdldF9jYWNoZV9zaXplKGludCBj
cHVfbm8sIGNvbnN0IGNoYXIgKmNhY2hlX3R5cGUsIHVuc2lnbmVkIGxvbmcgKmNhY2hlX3Np
emUpCiB7CiAJY2hhciBjYWNoZV9wYXRoWzEwMjRdLCBjYWNoZV9zdHJbNjRdOwogCWludCBs
ZW5ndGgsIGksIGNhY2hlX251bTsKIAlGSUxFICpmcDsKIAotCWlmICghc3RyY21wKGNhY2hl
X3R5cGUsICJMMyIpKSB7Ci0JCWNhY2hlX251bSA9IDM7Ci0JfSBlbHNlIGlmICghc3RyY21w
KGNhY2hlX3R5cGUsICJMMiIpKSB7Ci0JCWNhY2hlX251bSA9IDI7Ci0JfSBlbHNlIHsKLQkJ
cGVycm9yKCJJbnZhbGlkIGNhY2hlIGxldmVsIik7Ci0JCXJldHVybiAtMTsKLQl9CisJY2Fj
aGVfbnVtID0gZ2V0X2NhY2hlX2xldmVsKGNhY2hlX3R5cGUpOworCWlmIChjYWNoZV9udW0g
PCAwKQorCQlyZXR1cm4gY2FjaGVfbnVtOwogCiAJc3ByaW50ZihjYWNoZV9wYXRoLCAiL3N5
cy9idXMvY3B1L2RldmljZXMvY3B1JWQvY2FjaGUvaW5kZXglZC9zaXplIiwKIAkJY3B1X25v
LCBjYWNoZV9udW0pOwogCWZwID0gZm9wZW4oY2FjaGVfcGF0aCwgInIiKTsKIAlpZiAoIWZw
KSB7Ci0JCXBlcnJvcigiRmFpbGVkIHRvIG9wZW4gY2FjaGUgc2l6ZSIpOworCQlrc2Z0X3Bl
cnJvcigiRmFpbGVkIHRvIG9wZW4gY2FjaGUgc2l6ZSIpOwogCiAJCXJldHVybiAtMTsKIAl9
CiAJaWYgKGZzY2FuZihmcCwgIiVzIiwgY2FjaGVfc3RyKSA8PSAwKSB7Ci0JCXBlcnJvcigi
Q291bGQgbm90IGdldCBjYWNoZV9zaXplIik7CisJCWtzZnRfcGVycm9yKCJDb3VsZCBub3Qg
Z2V0IGNhY2hlX3NpemUiKTsKIAkJZmNsb3NlKGZwKTsKIAogCQlyZXR1cm4gLTE7CkBAIC0x
OTYsMzAgKzIxNywyOSBAQCBpbnQgZ2V0X2NhY2hlX3NpemUoaW50IGNwdV9ubywgY2hhciAq
Y2FjaGVfdHlwZSwgdW5zaWduZWQgbG9uZyAqY2FjaGVfc2l6ZSkKICNkZWZpbmUgQ09SRV9T
SUJMSU5HU19QQVRICSIvc3lzL2J1cy9jcHUvZGV2aWNlcy9jcHUiCiAKIC8qCi0gKiBnZXRf
Y2JtX21hc2sgLSBHZXQgY2JtIG1hc2sgZm9yIGdpdmVuIGNhY2hlCi0gKiBAY2FjaGVfdHlw
ZToJQ2FjaGUgbGV2ZWwgTDIvTDMKLSAqIEBjYm1fbWFzazoJY2JtX21hc2sgcmV0dXJuZWQg
YXMgYSBzdHJpbmcKKyAqIGdldF9iaXRfbWFzayAtIEdldCBiaXQgbWFzayBmcm9tIGdpdmVu
IGZpbGUKKyAqIEBmaWxlbmFtZToJRmlsZSBjb250YWluaW5nIHRoZSBtYXNrCisgKiBAbWFz
azoJVGhlIGJpdCBtYXNrIHJldHVybmVkIGFzIHVuc2lnbmVkIGxvbmcKICAqCiAgKiBSZXR1
cm46ID0gMCBvbiBzdWNjZXNzLCA8IDAgb24gZmFpbHVyZS4KICAqLwotaW50IGdldF9jYm1f
bWFzayhjaGFyICpjYWNoZV90eXBlLCBjaGFyICpjYm1fbWFzaykKK3N0YXRpYyBpbnQgZ2V0
X2JpdF9tYXNrKGNvbnN0IGNoYXIgKmZpbGVuYW1lLCB1bnNpZ25lZCBsb25nICptYXNrKQog
ewotCWNoYXIgY2JtX21hc2tfcGF0aFsxMDI0XTsKIAlGSUxFICpmcDsKIAotCWlmICghY2Jt
X21hc2spCisJaWYgKCFmaWxlbmFtZSB8fCAhbWFzaykKIAkJcmV0dXJuIC0xOwogCi0Jc3By
aW50ZihjYm1fbWFza19wYXRoLCAiJXMvJXMvY2JtX21hc2siLCBJTkZPX1BBVEgsIGNhY2hl
X3R5cGUpOwotCi0JZnAgPSBmb3BlbihjYm1fbWFza19wYXRoLCAiciIpOworCWZwID0gZm9w
ZW4oZmlsZW5hbWUsICJyIik7CiAJaWYgKCFmcCkgewotCQlwZXJyb3IoIkZhaWxlZCB0byBv
cGVuIGNhY2hlIGxldmVsIik7Ci0KKwkJa3NmdF9wcmludF9tc2coIkZhaWxlZCB0byBvcGVu
IGJpdCBtYXNrIGZpbGUgJyVzJzogJXNcbiIsCisJCQkgICAgICAgZmlsZW5hbWUsIHN0cmVy
cm9yKGVycm5vKSk7CiAJCXJldHVybiAtMTsKIAl9Ci0JaWYgKGZzY2FuZihmcCwgIiVzIiwg
Y2JtX21hc2spIDw9IDApIHsKLQkJcGVycm9yKCJDb3VsZCBub3QgZ2V0IG1heCBjYm1fbWFz
ayIpOworCisJaWYgKGZzY2FuZihmcCwgIiVseCIsIG1hc2spIDw9IDApIHsKKwkJa3NmdF9w
cmludF9tc2coIkNvdWxkIG5vdCByZWFkIGJpdCBtYXNrIGZpbGUgJyVzJzogJXNcbiIsCisJ
CQkgICAgICAgZmlsZW5hbWUsIHN0cmVycm9yKGVycm5vKSk7CiAJCWZjbG9zZShmcCk7CiAK
IAkJcmV0dXJuIC0xOwpAQCAtMjMwLDY0ICsyNTAsMjAwIEBAIGludCBnZXRfY2JtX21hc2so
Y2hhciAqY2FjaGVfdHlwZSwgY2hhciAqY2JtX21hc2spCiB9CiAKIC8qCi0gKiBnZXRfY29y
ZV9zaWJsaW5nIC0gR2V0IHNpYmxpbmcgY29yZSBpZCBmcm9tIHRoZSBzYW1lIHNvY2tldCBm
b3IgZ2l2ZW4gQ1BVCi0gKiBAY3B1X25vOglDUFUgbnVtYmVyCisgKiByZXNvdXJjZV9pbmZv
X3Vuc2lnbmVkX2dldCAtIFJlYWQgYW4gdW5zaWduZWQgdmFsdWUgZnJvbQorICogL3N5cy9m
cy9yZXNjdHJsL2luZm8vQHJlc291cmNlL0BmaWxlbmFtZQorICogQHJlc291cmNlOglSZXNv
dXJjZSBuYW1lIHRoYXQgbWF0Y2hlcyBkaXJlY3RvcnkgbmFtZSBpbgorICoJCS9zeXMvZnMv
cmVzY3RybC9pbmZvCisgKiBAZmlsZW5hbWU6CUZpbGUgaW4gL3N5cy9mcy9yZXNjdHJsL2lu
Zm8vQHJlc291cmNlCisgKiBAdmFsOglDb250YWlucyByZWFkIHZhbHVlIG9uIHN1Y2Nlc3Mu
CiAgKgotICogUmV0dXJuOgk+IDAgb24gc3VjY2VzcywgPCAwIG9uIGZhaWx1cmUuCisgKiBS
ZXR1cm46ID0gMCBvbiBzdWNjZXNzLCA8IDAgb24gZmFpbHVyZS4gT24gc3VjY2VzcyB0aGUg
cmVhZAorICogdmFsdWUgaXMgc2F2ZWQgaW50byBAdmFsLgogICovCi1pbnQgZ2V0X2NvcmVf
c2libGluZyhpbnQgY3B1X25vKQoraW50IHJlc291cmNlX2luZm9fdW5zaWduZWRfZ2V0KGNv
bnN0IGNoYXIgKnJlc291cmNlLCBjb25zdCBjaGFyICpmaWxlbmFtZSwKKwkJCSAgICAgICB1
bnNpZ25lZCBpbnQgKnZhbCkKIHsKLQljaGFyIGNvcmVfc2libGluZ3NfcGF0aFsxMDI0XSwg
Y3B1X2xpc3Rfc3RyWzY0XTsKLQlpbnQgc2libGluZ19jcHVfbm8gPSAtMTsKKwljaGFyIGZp
bGVfcGF0aFtQQVRIX01BWF07CiAJRklMRSAqZnA7CiAKLQlzcHJpbnRmKGNvcmVfc2libGlu
Z3NfcGF0aCwgIiVzJWQvdG9wb2xvZ3kvY29yZV9zaWJsaW5nc19saXN0IiwKLQkJQ09SRV9T
SUJMSU5HU19QQVRILCBjcHVfbm8pOworCXNucHJpbnRmKGZpbGVfcGF0aCwgc2l6ZW9mKGZp
bGVfcGF0aCksICIlcy8lcy8lcyIsIElORk9fUEFUSCwgcmVzb3VyY2UsCisJCSBmaWxlbmFt
ZSk7CiAKLQlmcCA9IGZvcGVuKGNvcmVfc2libGluZ3NfcGF0aCwgInIiKTsKKwlmcCA9IGZv
cGVuKGZpbGVfcGF0aCwgInIiKTsKIAlpZiAoIWZwKSB7Ci0JCXBlcnJvcigiRmFpbGVkIHRv
IG9wZW4gY29yZSBzaWJsaW5ncyBwYXRoIik7Ci0KKwkJa3NmdF9wcmludF9tc2coIkVycm9y
IG9wZW5pbmcgJXM6ICVtXG4iLCBmaWxlX3BhdGgpOwogCQlyZXR1cm4gLTE7CiAJfQotCWlm
IChmc2NhbmYoZnAsICIlcyIsIGNwdV9saXN0X3N0cikgPD0gMCkgewotCQlwZXJyb3IoIkNv
dWxkIG5vdCBnZXQgY29yZV9zaWJsaW5ncyBsaXN0Iik7Ci0JCWZjbG9zZShmcCk7CiAKKwlp
ZiAoZnNjYW5mKGZwLCAiJXUiLCB2YWwpIDw9IDApIHsKKwkJa3NmdF9wcmludF9tc2coIkNv
dWxkIG5vdCBnZXQgY29udGVudHMgb2YgJXM6ICVtXG4iLCBmaWxlX3BhdGgpOworCQlmY2xv
c2UoZnApOwogCQlyZXR1cm4gLTE7CiAJfQorCiAJZmNsb3NlKGZwKTsKKwlyZXR1cm4gMDsK
K30KIAotCWNoYXIgKnRva2VuID0gc3RydG9rKGNwdV9saXN0X3N0ciwgIi0sIik7CisvKgor
ICogY3JlYXRlX2JpdF9tYXNrLSBDcmVhdGUgYml0IG1hc2sgZnJvbSBzdGFydCwgbGVuIHBh
aXIKKyAqIEBzdGFydDoJTFNCIG9mIHRoZSBtYXNrCisgKiBAbGVuCQlOdW1iZXIgb2YgYml0
cyBpbiB0aGUgbWFzaworICovCit1bnNpZ25lZCBsb25nIGNyZWF0ZV9iaXRfbWFzayh1bnNp
Z25lZCBpbnQgc3RhcnQsIHVuc2lnbmVkIGludCBsZW4pCit7CisJcmV0dXJuICgoMVVMIDw8
IGxlbikgLSAxVUwpIDw8IHN0YXJ0OworfQogCi0Jd2hpbGUgKHRva2VuKSB7Ci0JCXNpYmxp
bmdfY3B1X25vID0gYXRvaSh0b2tlbik7Ci0JCS8qIFNraXBwaW5nIGNvcmUgMCBhcyB3ZSBk
b24ndCB3YW50IHRvIHJ1biB0ZXN0IG9uIGNvcmUgMCAqLwotCQlpZiAoc2libGluZ19jcHVf
bm8gIT0gMCAmJiBzaWJsaW5nX2NwdV9ubyAhPSBjcHVfbm8pCi0JCQlicmVhazsKLQkJdG9r
ZW4gPSBzdHJ0b2soTlVMTCwgIi0sIik7CisvKgorICogY291bnRfY29udGlndW91c19iaXRz
IC0gUmV0dXJucyB0aGUgbG9uZ2VzdCB0cmFpbiBvZiBiaXRzIGluIGEgYml0IG1hc2sKKyAq
IEB2YWwJCUEgYml0IG1hc2sKKyAqIEBzdGFydAlUaGUgbG9jYXRpb24gb2YgdGhlIGxlYXN0
LXNpZ25pZmljYW50IGJpdCBvZiB0aGUgbG9uZ2VzdCB0cmFpbgorICoKKyAqIFJldHVybjoJ
VGhlIGxlbmd0aCBvZiB0aGUgY29udGlndW91cyBiaXRzIGluIHRoZSBsb25nZXN0IHRyYWlu
IG9mIGJpdHMKKyAqLwordW5zaWduZWQgaW50IGNvdW50X2NvbnRpZ3VvdXNfYml0cyh1bnNp
Z25lZCBsb25nIHZhbCwgdW5zaWduZWQgaW50ICpzdGFydCkKK3sKKwl1bnNpZ25lZCBsb25n
IGxhc3RfdmFsOworCXVuc2lnbmVkIGludCBjb3VudCA9IDA7CisKKwl3aGlsZSAodmFsKSB7
CisJCWxhc3RfdmFsID0gdmFsOworCQl2YWwgJj0gKHZhbCA+PiAxKTsKKwkJY291bnQrKzsK
Kwl9CisKKwlpZiAoc3RhcnQpIHsKKwkJaWYgKGNvdW50KQorCQkJKnN0YXJ0ID0gZmZzbChs
YXN0X3ZhbCkgLSAxOworCQllbHNlCisJCQkqc3RhcnQgPSAwOwogCX0KIAotCXJldHVybiBz
aWJsaW5nX2NwdV9ubzsKKwlyZXR1cm4gY291bnQ7Cit9CisKKy8qCisgKiBnZXRfZnVsbF9j
Ym0gLSBHZXQgZnVsbCBDYWNoZSBCaXQgTWFzayAoQ0JNKQorICogQGNhY2hlX3R5cGU6CUNh
Y2hlIHR5cGUgYXMgIkwyIiBvciAiTDMiCisgKiBAbWFzazoJRnVsbCBjYWNoZSBiaXQgbWFz
ayByZXByZXNlbnRpbmcgdGhlIG1heGltYWwgcG9ydGlvbiBvZiBjYWNoZQorICoJCWF2YWls
YWJsZSBmb3IgYWxsb2NhdGlvbiwgcmV0dXJuZWQgYXMgdW5zaWduZWQgbG9uZy4KKyAqCisg
KiBSZXR1cm46ID0gMCBvbiBzdWNjZXNzLCA8IDAgb24gZmFpbHVyZS4KKyAqLworaW50IGdl
dF9mdWxsX2NibShjb25zdCBjaGFyICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICptYXNr
KQoreworCWNoYXIgY2JtX3BhdGhbUEFUSF9NQVhdOworCWludCByZXQ7CisKKwlpZiAoIWNh
Y2hlX3R5cGUpCisJCXJldHVybiAtMTsKKworCXNucHJpbnRmKGNibV9wYXRoLCBzaXplb2Yo
Y2JtX3BhdGgpLCAiJXMvJXMvY2JtX21hc2siLAorCQkgSU5GT19QQVRILCBjYWNoZV90eXBl
KTsKKworCXJldCA9IGdldF9iaXRfbWFzayhjYm1fcGF0aCwgbWFzayk7CisJaWYgKHJldCB8
fCAhKm1hc2spCisJCXJldHVybiAtMTsKKworCXJldHVybiAwOworfQorCisvKgorICogZ2V0
X3NoYXJlYWJsZV9tYXNrIC0gR2V0IHNoYXJlYWJsZSBtYXNrIGZyb20gc2hhcmVhYmxlX2Jp
dHMKKyAqIEBjYWNoZV90eXBlOgkJQ2FjaGUgdHlwZSBhcyAiTDIiIG9yICJMMyIKKyAqIEBz
aGFyZWFibGVfbWFzazoJU2hhcmVhYmxlIG1hc2sgcmV0dXJuZWQgYXMgdW5zaWduZWQgbG9u
ZworICoKKyAqIFJldHVybjogPSAwIG9uIHN1Y2Nlc3MsIDwgMCBvbiBmYWlsdXJlLgorICov
CitzdGF0aWMgaW50IGdldF9zaGFyZWFibGVfbWFzayhjb25zdCBjaGFyICpjYWNoZV90eXBl
LCB1bnNpZ25lZCBsb25nICpzaGFyZWFibGVfbWFzaykKK3sKKwljaGFyIG1hc2tfcGF0aFtQ
QVRIX01BWF07CisKKwlpZiAoIWNhY2hlX3R5cGUpCisJCXJldHVybiAtMTsKKworCXNucHJp
bnRmKG1hc2tfcGF0aCwgc2l6ZW9mKG1hc2tfcGF0aCksICIlcy8lcy9zaGFyZWFibGVfYml0
cyIsCisJCSBJTkZPX1BBVEgsIGNhY2hlX3R5cGUpOworCisJcmV0dXJuIGdldF9iaXRfbWFz
ayhtYXNrX3BhdGgsIHNoYXJlYWJsZV9tYXNrKTsKK30KKworLyoKKyAqIGdldF9tYXNrX25v
X3NoYXJlYWJsZSAtIEdldCBDYWNoZSBCaXQgTWFzayAoQ0JNKSB3aXRob3V0IHNoYXJlYWJs
ZSBiaXRzCisgKiBAY2FjaGVfdHlwZToJCUNhY2hlIHR5cGUgYXMgIkwyIiBvciAiTDMiCisg
KiBAbWFzazoJCVRoZSBsYXJnZXN0IGV4Y2x1c2l2ZSBwb3J0aW9uIG9mIHRoZSBjYWNoZSBv
dXQgb2YgdGhlCisgKgkJCWZ1bGwgQ0JNLCByZXR1cm5lZCBhcyB1bnNpZ25lZCBsb25nCisg
KgorICogUGFydHMgb2YgYSBjYWNoZSBtYXkgYmUgc2hhcmVkIHdpdGggb3RoZXIgZGV2aWNl
cyBzdWNoIGFzIEdQVS4gVGhpcyBmdW5jdGlvbgorICogY2FsY3VsYXRlcyB0aGUgbGFyZ2Vz
dCBleGNsdXNpdmUgcG9ydGlvbiBvZiB0aGUgY2FjaGUgd2hlcmUgbm8gb3RoZXIgZGV2aWNl
cworICogYmVzaWRlcyBDUFUgaGF2ZSBhY2Nlc3MgdG8gdGhlIGNhY2hlIHBvcnRpb24uCisg
KgorICogUmV0dXJuOiA9IDAgb24gc3VjY2VzcywgPCAwIG9uIGZhaWx1cmUuCisgKi8KK2lu
dCBnZXRfbWFza19ub19zaGFyZWFibGUoY29uc3QgY2hhciAqY2FjaGVfdHlwZSwgdW5zaWdu
ZWQgbG9uZyAqbWFzaykKK3sKKwl1bnNpZ25lZCBsb25nIGZ1bGxfbWFzaywgc2hhcmVhYmxl
X21hc2s7CisJdW5zaWduZWQgaW50IHN0YXJ0LCBsZW47CisKKwlpZiAoZ2V0X2Z1bGxfY2Jt
KGNhY2hlX3R5cGUsICZmdWxsX21hc2spIDwgMCkKKwkJcmV0dXJuIC0xOworCWlmIChnZXRf
c2hhcmVhYmxlX21hc2soY2FjaGVfdHlwZSwgJnNoYXJlYWJsZV9tYXNrKSA8IDApCisJCXJl
dHVybiAtMTsKKworCWxlbiA9IGNvdW50X2NvbnRpZ3VvdXNfYml0cyhmdWxsX21hc2sgJiB+
c2hhcmVhYmxlX21hc2ssICZzdGFydCk7CisJaWYgKCFsZW4pCisJCXJldHVybiAtMTsKKwor
CSptYXNrID0gY3JlYXRlX2JpdF9tYXNrKHN0YXJ0LCBsZW4pOworCisJcmV0dXJuIDA7CiB9
CiAKIC8qCiAgKiB0YXNrc2V0X2JlbmNobWFyayAtIFRhc2tzZXQgUElEIChpLmUuIGJlbmNo
bWFyaykgdG8gYSBzcGVjaWZpZWQgY3B1Ci0gKiBAYm1fcGlkOglQSUQgdGhhdCBzaG91bGQg
YmUgYmluZGVkCi0gKiBAY3B1X25vOglDUFUgbnVtYmVyIGF0IHdoaWNoIHRoZSBQSUQgd291
bGQgYmUgYmluZGVkCisgKiBAYm1fcGlkOgkJUElEIHRoYXQgc2hvdWxkIGJlIGJpbmRlZAor
ICogQGNwdV9ubzoJCUNQVSBudW1iZXIgYXQgd2hpY2ggdGhlIFBJRCB3b3VsZCBiZSBiaW5k
ZWQKKyAqIEBvbGRfYWZmaW5pdHk6CVdoZW4gbm90IE5VTEwsIHNldCB0byBvbGQgQ1BVIGFm
ZmluaXR5CiAgKgotICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIG5vbi16ZXJvIG9uIGZhaWx1
cmUKKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCA8IDAgb24gZXJyb3IuCiAgKi8KLWludCB0
YXNrc2V0X2JlbmNobWFyayhwaWRfdCBibV9waWQsIGludCBjcHVfbm8pCitpbnQgdGFza3Nl
dF9iZW5jaG1hcmsocGlkX3QgYm1fcGlkLCBpbnQgY3B1X25vLCBjcHVfc2V0X3QgKm9sZF9h
ZmZpbml0eSkKIHsKIAljcHVfc2V0X3QgbXlfc2V0OwogCisJaWYgKG9sZF9hZmZpbml0eSkg
eworCQlDUFVfWkVSTyhvbGRfYWZmaW5pdHkpOworCQlpZiAoc2NoZWRfZ2V0YWZmaW5pdHko
Ym1fcGlkLCBzaXplb2YoKm9sZF9hZmZpbml0eSksCisJCQkJICAgICAgb2xkX2FmZmluaXR5
KSkgeworCQkJa3NmdF9wZXJyb3IoIlVuYWJsZSB0byByZWFkIENQVSBhZmZpbml0eSIpOwor
CQkJcmV0dXJuIC0xOworCQl9CisJfQorCiAJQ1BVX1pFUk8oJm15X3NldCk7CiAJQ1BVX1NF
VChjcHVfbm8sICZteV9zZXQpOwogCiAJaWYgKHNjaGVkX3NldGFmZmluaXR5KGJtX3BpZCwg
c2l6ZW9mKGNwdV9zZXRfdCksICZteV9zZXQpKSB7Ci0JCXBlcnJvcigiVW5hYmxlIHRvIHRh
c2tzZXQgYmVuY2htYXJrIik7CisJCWtzZnRfcGVycm9yKCJVbmFibGUgdG8gdGFza3NldCBi
ZW5jaG1hcmsiKTsKKworCQlyZXR1cm4gLTE7CisJfQorCisJcmV0dXJuIDA7Cit9CiAKKy8q
CisgKiB0YXNrc2V0X3Jlc3RvcmUgLSBUYXNrc2V0IFBJRCB0byB0aGUgZWFybGllciBDUFUg
YWZmaW5pdHkKKyAqIEBibV9waWQ6CQlQSUQgdGhhdCBzaG91bGQgYmUgcmVzZXQKKyAqIEBv
bGRfYWZmaW5pdHk6CVRoZSBvbGQgQ1BVIGFmZmluaXR5IHRvIHJlc3RvcmUKKyAqCisgKiBS
ZXR1cm46IDAgb24gc3VjY2VzcywgPCAwIG9uIGVycm9yLgorICovCitpbnQgdGFza3NldF9y
ZXN0b3JlKHBpZF90IGJtX3BpZCwgY3B1X3NldF90ICpvbGRfYWZmaW5pdHkpCit7CisJaWYg
KHNjaGVkX3NldGFmZmluaXR5KGJtX3BpZCwgc2l6ZW9mKCpvbGRfYWZmaW5pdHkpLCBvbGRf
YWZmaW5pdHkpKSB7CisJCWtzZnRfcGVycm9yKCJVbmFibGUgdG8gcmVzdG9yZSBDUFUgYWZm
aW5pdHkiKTsKIAkJcmV0dXJuIC0xOwogCX0KIApAQCAtMzAwLDcgKzQ1Niw3IEBAIGludCB0
YXNrc2V0X2JlbmNobWFyayhwaWRfdCBibV9waWQsIGludCBjcHVfbm8pCiAgKiBAZ3JwOglG
dWxsIHBhdGggYW5kIG5hbWUgb2YgdGhlIGdyb3VwCiAgKiBAcGFyZW50X2dycDoJRnVsbCBw
YXRoIGFuZCBuYW1lIG9mIHRoZSBwYXJlbnQgZ3JvdXAKICAqCi0gKiBSZXR1cm46IDAgb24g
c3VjY2Vzcywgbm9uLXplcm8gb24gZmFpbHVyZQorICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3Ms
IDwgMCBvbiBlcnJvci4KICAqLwogc3RhdGljIGludCBjcmVhdGVfZ3JwKGNvbnN0IGNoYXIg
KmdycF9uYW1lLCBjaGFyICpncnAsIGNvbnN0IGNoYXIgKnBhcmVudF9ncnApCiB7CkBAIC0z
MjUsNyArNDgxLDcgQEAgc3RhdGljIGludCBjcmVhdGVfZ3JwKGNvbnN0IGNoYXIgKmdycF9u
YW1lLCBjaGFyICpncnAsIGNvbnN0IGNoYXIgKnBhcmVudF9ncnApCiAJCX0KIAkJY2xvc2Vk
aXIoZHApOwogCX0gZWxzZSB7Ci0JCXBlcnJvcigiVW5hYmxlIHRvIG9wZW4gcmVzY3RybCBm
b3IgZ3JvdXAiKTsKKwkJa3NmdF9wZXJyb3IoIlVuYWJsZSB0byBvcGVuIHJlc2N0cmwgZm9y
IGdyb3VwIik7CiAKIAkJcmV0dXJuIC0xOwogCX0KQEAgLTMzMyw3ICs0ODksNyBAQCBzdGF0
aWMgaW50IGNyZWF0ZV9ncnAoY29uc3QgY2hhciAqZ3JwX25hbWUsIGNoYXIgKmdycCwgY29u
c3QgY2hhciAqcGFyZW50X2dycCkKIAkvKiBSZXF1ZXN0ZWQgZ3JwIGRvZXNuJ3QgZXhpc3Qs
IGhlbmNlIGNyZWF0ZSBpdCAqLwogCWlmIChmb3VuZF9ncnAgPT0gMCkgewogCQlpZiAobWtk
aXIoZ3JwLCAwKSA9PSAtMSkgewotCQkJcGVycm9yKCJVbmFibGUgdG8gY3JlYXRlIGdyb3Vw
Iik7CisJCQlrc2Z0X3BlcnJvcigiVW5hYmxlIHRvIGNyZWF0ZSBncm91cCIpOwogCiAJCQly
ZXR1cm4gLTE7CiAJCX0KQEAgLTM0OCwxMiArNTA0LDEyIEBAIHN0YXRpYyBpbnQgd3JpdGVf
cGlkX3RvX3Rhc2tzKGNoYXIgKnRhc2tzLCBwaWRfdCBwaWQpCiAKIAlmcCA9IGZvcGVuKHRh
c2tzLCAidyIpOwogCWlmICghZnApIHsKLQkJcGVycm9yKCJGYWlsZWQgdG8gb3BlbiB0YXNr
cyBmaWxlIik7CisJCWtzZnRfcGVycm9yKCJGYWlsZWQgdG8gb3BlbiB0YXNrcyBmaWxlIik7
CiAKIAkJcmV0dXJuIC0xOwogCX0KIAlpZiAoZnByaW50ZihmcCwgIiVkXG4iLCBwaWQpIDwg
MCkgewotCQlwZXJyb3IoIkZhaWxlZCB0byB3ciBwaWQgdG8gdGFza3MgZmlsZSIpOworCQlr
c2Z0X3ByaW50X21zZygiRmFpbGVkIHRvIHdyaXRlIHBpZCB0byB0YXNrcyBmaWxlXG4iKTsK
IAkJZmNsb3NlKGZwKTsKIAogCQlyZXR1cm4gLTE7CkBAIC0zNzYsNyArNTMyLDcgQEAgc3Rh
dGljIGludCB3cml0ZV9waWRfdG9fdGFza3MoY2hhciAqdGFza3MsIHBpZF90IHBpZCkKICAq
IHBpZCBpcyBub3Qgd3JpdHRlbiwgdGhpcyBtZWFucyB0aGF0IHBpZCBpcyBpbiBjb25fbW9u
IGdycCBhbmQgaGVuY2UKICAqIHNob3VsZCBjb25zdWx0IGNvbl9tb24gZ3JwJ3MgbW9uX2Rh
dGEgZGlyZWN0b3J5IGZvciByZXN1bHRzLgogICoKLSAqIFJldHVybjogMCBvbiBzdWNjZXNz
LCBub24temVybyBvbiBmYWlsdXJlCisgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgPCAwIG9u
IGVycm9yLgogICovCiBpbnQgd3JpdGVfYm1fcGlkX3RvX3Jlc2N0cmwocGlkX3QgYm1fcGlk
LCBjaGFyICpjdHJsZ3JwLCBjaGFyICptb25ncnAsCiAJCQkgICAgY2hhciAqcmVzY3RybF92
YWwpCkBAIC00MjAsNyArNTc2LDcgQEAgaW50IHdyaXRlX2JtX3BpZF90b19yZXNjdHJsKHBp
ZF90IGJtX3BpZCwgY2hhciAqY3RybGdycCwgY2hhciAqbW9uZ3JwLAogb3V0OgogCWtzZnRf
cHJpbnRfbXNnKCJXcml0aW5nIGJlbmNobWFyayBwYXJhbWV0ZXJzIHRvIHJlc2N0cmwgRlNc
biIpOwogCWlmIChyZXQpCi0JCXBlcnJvcigiIyB3cml0aW5nIHRvIHJlc2N0cmxmcyIpOwor
CQlrc2Z0X3ByaW50X21zZygiRmFpbGVkIHdyaXRpbmcgdG8gcmVzY3RybGZzXG4iKTsKIAog
CXJldHVybiByZXQ7CiB9CkBAIC00MzAsMjMgKzU4NiwxNyBAQCBpbnQgd3JpdGVfYm1fcGlk
X3RvX3Jlc2N0cmwocGlkX3QgYm1fcGlkLCBjaGFyICpjdHJsZ3JwLCBjaGFyICptb25ncnAs
CiAgKiBAY3RybGdycDoJCU5hbWUgb2YgdGhlIGNvbl9tb24gZ3JwCiAgKiBAc2NoZW1hdGE6
CQlTY2hlbWF0YSB0aGF0IHNob3VsZCBiZSB1cGRhdGVkIHRvCiAgKiBAY3B1X25vOgkJQ1BV
IG51bWJlciB0aGF0IHRoZSBiZW5jaG1hcmsgUElEIGlzIGJpbmRlZCB0bwotICogQHJlc2N0
cmxfdmFsOglSZXNjdHJsIGZlYXR1cmUgKEVnOiBtYm0sIG1iYS4uIGV0YykKKyAqIEByZXNv
dXJjZToJCVJlc2N0cmwgcmVzb3VyY2UgKEVnOiBNQiwgTDMsIEwyLCBldGMuKQogICoKLSAq
IFVwZGF0ZSBzY2hlbWF0YSBvZiBhIGNvbl9tb24gZ3JwICpvbmx5KiBpZiByZXF1ZXN0ZWQg
cmVzY3RybCBmZWF0dXJlIGlzCisgKiBVcGRhdGUgc2NoZW1hdGEgb2YgYSBjb25fbW9uIGdy
cCAqb25seSogaWYgcmVxdWVzdGVkIHJlc2N0cmwgcmVzb3VyY2UgaXMKICAqIGFsbG9jYXRp
b24gdHlwZQogICoKLSAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBub24temVybyBvbiBmYWls
dXJlCisgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgPCAwIG9uIGVycm9yLgogICovCi1pbnQg
d3JpdGVfc2NoZW1hdGEoY2hhciAqY3RybGdycCwgY2hhciAqc2NoZW1hdGEsIGludCBjcHVf
bm8sIGNoYXIgKnJlc2N0cmxfdmFsKQoraW50IHdyaXRlX3NjaGVtYXRhKGNoYXIgKmN0cmxn
cnAsIGNoYXIgKnNjaGVtYXRhLCBpbnQgY3B1X25vLCBjb25zdCBjaGFyICpyZXNvdXJjZSkK
IHsKIAljaGFyIGNvbnRyb2xncm91cFsxMDI0XSwgcmVhc29uWzEyOF0sIHNjaGVtYVsxMDI0
XSA9IHt9OwotCWludCByZXNvdXJjZV9pZCwgZmQsIHNjaGVtYV9sZW4gPSAtMSwgcmV0ID0g
MDsKLQotCWlmIChzdHJuY21wKHJlc2N0cmxfdmFsLCBNQkFfU1RSLCBzaXplb2YoTUJBX1NU
UikpICYmCi0JICAgIHN0cm5jbXAocmVzY3RybF92YWwsIE1CTV9TVFIsIHNpemVvZihNQk1f
U1RSKSkgJiYKLQkgICAgc3RybmNtcChyZXNjdHJsX3ZhbCwgQ0FUX1NUUiwgc2l6ZW9mKENB
VF9TVFIpKSAmJgotCSAgICBzdHJuY21wKHJlc2N0cmxfdmFsLCBDTVRfU1RSLCBzaXplb2Yo
Q01UX1NUUikpKQotCQlyZXR1cm4gLUVOT0VOVDsKKwlpbnQgZG9tYWluX2lkLCBmZCwgc2No
ZW1hX2xlbiwgcmV0ID0gMDsKIAogCWlmICghc2NoZW1hdGEpIHsKIAkJa3NmdF9wcmludF9t
c2coIlNraXBwaW5nIGVtcHR5IHNjaGVtYXRhIHVwZGF0ZVxuIik7CkBAIC00NTQsOCArNjA0
LDggQEAgaW50IHdyaXRlX3NjaGVtYXRhKGNoYXIgKmN0cmxncnAsIGNoYXIgKnNjaGVtYXRh
LCBpbnQgY3B1X25vLCBjaGFyICpyZXNjdHJsX3ZhbCkKIAkJcmV0dXJuIC0xOwogCX0KIAot
CWlmIChnZXRfcmVzb3VyY2VfaWQoY3B1X25vLCAmcmVzb3VyY2VfaWQpIDwgMCkgewotCQlz
cHJpbnRmKHJlYXNvbiwgIkZhaWxlZCB0byBnZXQgcmVzb3VyY2UgaWQiKTsKKwlpZiAoZ2V0
X2RvbWFpbl9pZChyZXNvdXJjZSwgY3B1X25vLCAmZG9tYWluX2lkKSA8IDApIHsKKwkJc3By
aW50ZihyZWFzb24sICJGYWlsZWQgdG8gZ2V0IGRvbWFpbiBJRCIpOwogCQlyZXQgPSAtMTsK
IAogCQlnb3RvIG91dDsKQEAgLTQ2NiwxNCArNjE2LDggQEAgaW50IHdyaXRlX3NjaGVtYXRh
KGNoYXIgKmN0cmxncnAsIGNoYXIgKnNjaGVtYXRhLCBpbnQgY3B1X25vLCBjaGFyICpyZXNj
dHJsX3ZhbCkKIAllbHNlCiAJCXNwcmludGYoY29udHJvbGdyb3VwLCAiJXMvc2NoZW1hdGEi
LCBSRVNDVFJMX1BBVEgpOwogCi0JaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBDQVRfU1RS
LCBzaXplb2YoQ0FUX1NUUikpIHx8Ci0JICAgICFzdHJuY21wKHJlc2N0cmxfdmFsLCBDTVRf
U1RSLCBzaXplb2YoQ01UX1NUUikpKQotCQlzY2hlbWFfbGVuID0gc25wcmludGYoc2NoZW1h
LCBzaXplb2Yoc2NoZW1hKSwgIiVzJWQlYyVzXG4iLAotCQkJCSAgICAgICJMMzoiLCByZXNv
dXJjZV9pZCwgJz0nLCBzY2hlbWF0YSk7Ci0JaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBN
QkFfU1RSLCBzaXplb2YoTUJBX1NUUikpIHx8Ci0JICAgICFzdHJuY21wKHJlc2N0cmxfdmFs
LCBNQk1fU1RSLCBzaXplb2YoTUJNX1NUUikpKQotCQlzY2hlbWFfbGVuID0gc25wcmludGYo
c2NoZW1hLCBzaXplb2Yoc2NoZW1hKSwgIiVzJWQlYyVzXG4iLAotCQkJCSAgICAgICJNQjoi
LCByZXNvdXJjZV9pZCwgJz0nLCBzY2hlbWF0YSk7CisJc2NoZW1hX2xlbiA9IHNucHJpbnRm
KHNjaGVtYSwgc2l6ZW9mKHNjaGVtYSksICIlczolZD0lc1xuIiwKKwkJCSAgICAgIHJlc291
cmNlLCBkb21haW5faWQsIHNjaGVtYXRhKTsKIAlpZiAoc2NoZW1hX2xlbiA8IDAgfHwgc2No
ZW1hX2xlbiA+PSBzaXplb2Yoc2NoZW1hKSkgewogCQlzbnByaW50ZihyZWFzb24sIHNpemVv
ZihyZWFzb24pLAogCQkJICJzbnByaW50ZigpIGZhaWxlZCB3aXRoIHJldHVybiB2YWx1ZSA6
ICVkIiwgc2NoZW1hX2xlbik7CkBAIC01NjQsMjAgKzcwOCwxNiBAQCBjaGFyICpmZ3JlcChG
SUxFICppbmYsIGNvbnN0IGNoYXIgKnN0cikKIH0KIAogLyoKLSAqIHZhbGlkYXRlX3Jlc2N0
cmxfZmVhdHVyZV9yZXF1ZXN0IC0gQ2hlY2sgaWYgcmVxdWVzdGVkIGZlYXR1cmUgaXMgdmFs
aWQuCi0gKiBAcmVzb3VyY2U6CVJlcXVpcmVkIHJlc291cmNlIChlLmcuLCBNQiwgTDMsIEwy
LCBMM19NT04sIGV0Yy4pCi0gKiBAZmVhdHVyZToJUmVxdWlyZWQgbW9uaXRvciBmZWF0dXJl
IChpbiBtb25fZmVhdHVyZXMgZmlsZSkuIENhbiBvbmx5IGJlCi0gKgkJc2V0IGZvciBMM19N
T04uIE11c3QgYmUgTlVMTCBmb3IgYWxsIG90aGVyIHJlc291cmNlcy4KKyAqIHJlc2N0cmxf
cmVzb3VyY2VfZXhpc3RzIC0gQ2hlY2sgaWYgYSByZXNvdXJjZSBpcyBzdXBwb3J0ZWQuCisg
KiBAcmVzb3VyY2U6CVJlc2N0cmwgcmVzb3VyY2UgKGUuZy4sIE1CLCBMMywgTDIsIEwzX01P
TiwgZXRjLikKICAqCi0gKiBSZXR1cm46IFRydWUgaWYgdGhlIHJlc291cmNlL2ZlYXR1cmUg
aXMgc3VwcG9ydGVkLCBlbHNlIGZhbHNlLiBGYWxzZSBpcworICogUmV0dXJuOiBUcnVlIGlm
IHRoZSByZXNvdXJjZSBpcyBzdXBwb3J0ZWQsIGVsc2UgZmFsc2UuIEZhbHNlIGlzCiAgKiAg
ICAgICAgIGFsc28gcmV0dXJuZWQgaWYgcmVzY3RybCBGUyBpcyBub3QgbW91bnRlZC4KICAq
LwotYm9vbCB2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChjb25zdCBjaGFyICpy
ZXNvdXJjZSwgY29uc3QgY2hhciAqZmVhdHVyZSkKK2Jvb2wgcmVzY3RybF9yZXNvdXJjZV9l
eGlzdHMoY29uc3QgY2hhciAqcmVzb3VyY2UpCiB7CiAJY2hhciByZXNfcGF0aFtQQVRIX01B
WF07CiAJc3RydWN0IHN0YXQgc3RhdGJ1ZjsKLQljaGFyICpyZXM7Ci0JRklMRSAqaW5mOwog
CWludCByZXQ7CiAKIAlpZiAoIXJlc291cmNlKQpAQCAtNTkyLDggKzczMiwyNSBAQCBib29s
IHZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KGNvbnN0IGNoYXIgKnJlc291cmNl
LCBjb25zdCBjaGFyICpmZWF0dXJlKQogCWlmIChzdGF0KHJlc19wYXRoLCAmc3RhdGJ1Zikp
CiAJCXJldHVybiBmYWxzZTsKIAotCWlmICghZmVhdHVyZSkKLQkJcmV0dXJuIHRydWU7CisJ
cmV0dXJuIHRydWU7Cit9CisKKy8qCisgKiByZXNjdHJsX21vbl9mZWF0dXJlX2V4aXN0cyAt
IENoZWNrIGlmIHJlcXVlc3RlZCBtb25pdG9yaW5nIGZlYXR1cmUgaXMgdmFsaWQuCisgKiBA
cmVzb3VyY2U6CVJlc291cmNlIHRoYXQgdXNlcyB0aGUgbW9uX2ZlYXR1cmVzIGZpbGUuIEN1
cnJlbnRseSBvbmx5IEwzX01PTgorICoJCWlzIHZhbGlkLgorICogQGZlYXR1cmU6CVJlcXVp
cmVkIG1vbml0b3IgZmVhdHVyZSAoaW4gbW9uX2ZlYXR1cmVzIGZpbGUpLgorICoKKyAqIFJl
dHVybjogVHJ1ZSBpZiB0aGUgZmVhdHVyZSBpcyBzdXBwb3J0ZWQsIGVsc2UgZmFsc2UuCisg
Ki8KK2Jvb2wgcmVzY3RybF9tb25fZmVhdHVyZV9leGlzdHMoY29uc3QgY2hhciAqcmVzb3Vy
Y2UsIGNvbnN0IGNoYXIgKmZlYXR1cmUpCit7CisJY2hhciByZXNfcGF0aFtQQVRIX01BWF07
CisJY2hhciAqcmVzOworCUZJTEUgKmluZjsKKworCWlmICghZmVhdHVyZSB8fCAhcmVzb3Vy
Y2UpCisJCXJldHVybiBmYWxzZTsKIAogCXNucHJpbnRmKHJlc19wYXRoLCBzaXplb2YocmVz
X3BhdGgpLCAiJXMvJXMvbW9uX2ZlYXR1cmVzIiwgSU5GT19QQVRILCByZXNvdXJjZSk7CiAJ
aW5mID0gZm9wZW4ocmVzX3BhdGgsICJyIik7CkBAIC02MDcsNiArNzY0LDM2IEBAIGJvb2wg
dmFsaWRhdGVfcmVzY3RybF9mZWF0dXJlX3JlcXVlc3QoY29uc3QgY2hhciAqcmVzb3VyY2Us
IGNvbnN0IGNoYXIgKmZlYXR1cmUpCiAJcmV0dXJuICEhcmVzOwogfQogCisvKgorICogcmVz
b3VyY2VfaW5mb19maWxlX2V4aXN0cyAtIENoZWNrIGlmIGEgZmlsZSBpcyBwcmVzZW50IGlu
c2lkZQorICogL3N5cy9mcy9yZXNjdHJsL2luZm8vQHJlc291cmNlLgorICogQHJlc291cmNl
OglSZXF1aXJlZCByZXNvdXJjZSAoRWc6IE1CLCBMMywgTDIsIGV0Yy4pCisgKiBAZmlsZToJ
UmVxdWlyZWQgZmlsZS4KKyAqCisgKiBSZXR1cm46IFRydWUgaWYgdGhlIC9zeXMvZnMvcmVz
Y3RybC9pbmZvL0ByZXNvdXJjZS9AZmlsZSBleGlzdHMsIGVsc2UgZmFsc2UuCisgKi8KK2Jv
b2wgcmVzb3VyY2VfaW5mb19maWxlX2V4aXN0cyhjb25zdCBjaGFyICpyZXNvdXJjZSwgY29u
c3QgY2hhciAqZmlsZSkKK3sKKwljaGFyIHJlc19wYXRoW1BBVEhfTUFYXTsKKwlzdHJ1Y3Qg
c3RhdCBzdGF0YnVmOworCisJaWYgKCFmaWxlIHx8ICFyZXNvdXJjZSkKKwkJcmV0dXJuIGZh
bHNlOworCisJc25wcmludGYocmVzX3BhdGgsIHNpemVvZihyZXNfcGF0aCksICIlcy8lcy8l
cyIsIElORk9fUEFUSCwgcmVzb3VyY2UsCisJCSBmaWxlKTsKKworCWlmIChzdGF0KHJlc19w
YXRoLCAmc3RhdGJ1ZikpCisJCXJldHVybiBmYWxzZTsKKworCXJldHVybiB0cnVlOworfQor
Citib29sIHRlc3RfcmVzb3VyY2VfZmVhdHVyZV9jaGVjayhjb25zdCBzdHJ1Y3QgcmVzY3Ry
bF90ZXN0ICp0ZXN0KQoreworCXJldHVybiByZXNjdHJsX3Jlc291cmNlX2V4aXN0cyh0ZXN0
LT5yZXNvdXJjZSk7Cit9CisKIGludCBmaWx0ZXJfZG1lc2codm9pZCkKIHsKIAljaGFyIGxp
bmVbMTAyNF07CkBAIC02MTcsNyArODA0LDcgQEAgaW50IGZpbHRlcl9kbWVzZyh2b2lkKQog
CiAJcmV0ID0gcGlwZShwaXBlZmRzKTsKIAlpZiAocmV0KSB7Ci0JCXBlcnJvcigicGlwZSIp
OworCQlrc2Z0X3BlcnJvcigicGlwZSIpOwogCQlyZXR1cm4gcmV0OwogCX0KIAlmZmx1c2go
c3Rkb3V0KTsKQEAgLTYyNiwxMyArODEzLDEzIEBAIGludCBmaWx0ZXJfZG1lc2codm9pZCkK
IAkJY2xvc2UocGlwZWZkc1swXSk7CiAJCWR1cDIocGlwZWZkc1sxXSwgU1RET1VUX0ZJTEVO
Tyk7CiAJCWV4ZWNscCgiZG1lc2ciLCAiZG1lc2ciLCBOVUxMKTsKLQkJcGVycm9yKCJleGVj
dXRpbmcgZG1lc2ciKTsKKwkJa3NmdF9wZXJyb3IoIkV4ZWN1dGluZyBkbWVzZyIpOwogCQll
eGl0KDEpOwogCX0KIAljbG9zZShwaXBlZmRzWzFdKTsKIAlmcCA9IGZkb3BlbihwaXBlZmRz
WzBdLCAiciIpOwogCWlmICghZnApIHsKLQkJcGVycm9yKCJmZG9wZW4ocGlwZSkiKTsKKwkJ
a3NmdF9wZXJyb3IoImZkb3BlbihwaXBlKSIpOwogCQlraWxsKHBpZCwgU0lHVEVSTSk7CiAK
IAkJcmV0dXJuIC0xOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnVz
dC9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3J1c3QvTWFrZWZpbGUKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5mY2UxNTg0ZDNiYzAKLS0t
IC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydXN0L01ha2VmaWxl
CkBAIC0wLDAgKzEsNCBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAor
VEVTVF9QUk9HUyArPSB0ZXN0X3Byb2JlX3NhbXBsZXMuc2gKKworaW5jbHVkZSAuLi9saWIu
bWsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3J1c3QvY29uZmlnIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnVzdC9jb25maWcKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5iNDAwMmFjZDQwYmMKLS0tIC9kZXYvbnVsbAorKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydXN0L2NvbmZpZwpAQCAtMCwwICsxLDUgQEAK
K0NPTkZJR19SVVNUPXkKK0NPTkZJR19TQU1QTEVTPXkKK0NPTkZJR19TQU1QTEVTX1JVU1Q9
eQorQ09ORklHX1NBTVBMRV9SVVNUX01JTklNQUw9bQorQ09ORklHX1NBTVBMRV9SVVNUX1BS
SU5UPW0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9ydXN0L3Rlc3RfcHJvYmVfc2FtcGxlcy5zaCBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3J1c3QvdGVzdF9wcm9iZV9zYW1wbGVzLnNoCm5ldyBmaWxlIG1v
ZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAwMDAwMC4uYWQwMzk3ZTQ5ODZmCi0tLSAvZGV2L251
bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnVzdC90ZXN0X3Byb2JlX3NhbXBs
ZXMuc2gKQEAgLTAsMCArMSw0MSBAQAorIyEvYmluL2Jhc2gKKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKKyMKKyMgQ29weXJpZ2h0IChjKSAyMDIzIENvbGxhYm9yYSBM
dGQKKyMKKyMgVGhpcyBzY3JpcHQgdGVzdHMgd2hldGhlciB0aGUgcnVzdCBzYW1wbGUgbW9k
dWxlcyBjYW4KKyMgYmUgYWRkZWQgYW5kIHJlbW92ZWQgY29ycmVjdGx5LgorIworRElSPSIk
KGRpcm5hbWUgIiQocmVhZGxpbmsgLWYgIiQwIikiKSIKKworS1RBUF9IRUxQRVJTPSIke0RJ
Un0vLi4va3NlbGZ0ZXN0L2t0YXBfaGVscGVycy5zaCIKK2lmIFsgLWUgIiRLVEFQX0hFTFBF
UlMiIF07IHRoZW4KKyAgICBzb3VyY2UgIiRLVEFQX0hFTFBFUlMiCitlbHNlCisgICAgZWNo
byAiJEtUQVBfSEVMUEVSUyBmaWxlIG5vdCBmb3VuZCBbU0tJUF0iCisgICAgZXhpdCA0Citm
aQorCitydXN0X3NhbXBsZV9tb2R1bGVzPSgicnVzdF9taW5pbWFsIiAicnVzdF9wcmludCIp
CisKK2t0YXBfcHJpbnRfaGVhZGVyCisKK2ZvciBzYW1wbGUgaW4gIiR7cnVzdF9zYW1wbGVf
bW9kdWxlc1tAXX0iOyBkbworICAgIGlmICEgL3NiaW4vbW9kcHJvYmUgLW4gLXEgIiRzYW1w
bGUiOyB0aGVuCisgICAgICAgIGt0YXBfc2tpcF9hbGwgIm1vZHVsZSAkc2FtcGxlIGlzIG5v
dCBmb3VuZCBpbiAvbGliL21vZHVsZXMvJCh1bmFtZSAtcikiCisgICAgICAgIGV4aXQgIiRL
U0ZUX1NLSVAiCisgICAgZmkKK2RvbmUKKwora3RhcF9zZXRfcGxhbiAiJHsjcnVzdF9zYW1w
bGVfbW9kdWxlc1tAXX0iCisKK2ZvciBzYW1wbGUgaW4gIiR7cnVzdF9zYW1wbGVfbW9kdWxl
c1tAXX0iOyBkbworICAgIGlmIC9zYmluL21vZHByb2JlIC1xICIkc2FtcGxlIjsgdGhlbgor
ICAgICAgICAvc2Jpbi9tb2Rwcm9iZSAtcSAtciAiJHNhbXBsZSIKKyAgICAgICAga3RhcF90
ZXN0X3Bhc3MgIiRzYW1wbGUiCisgICAgZWxzZQorICAgICAgICBrdGFwX3Rlc3RfZmFpbCAi
JHNhbXBsZSIKKyAgICBmaQorZG9uZQorCitrdGFwX2ZpbmlzaGVkCmRpZmYgLS1naXQgYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zY2hlZC9jc19wcmN0bF90ZXN0LmMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zY2hlZC9jc19wcmN0bF90ZXN0LmMKaW5kZXggN2JhMDU3MTU0
MzQzLi42MmZiYTczNTZhZjIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NjaGVkL2NzX3ByY3RsX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9z
Y2hlZC9jc19wcmN0bF90ZXN0LmMKQEAgLTI3Niw3ICsyNzYsNyBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogCWlmIChzZXRwZ2lkKDAsIDApICE9IDApCiAJCWhhbmRs
ZV9lcnJvcigicHJvY2VzcyBncm91cCIpOwogCi0JcHJpbnRmKCJcbiMjIENyZWF0ZSBhIHRo
cmVhZC9wcm9jZXNzL3Byb2Nlc3MgZ3JvdXAgaGllYXJjaHlcbiIpOworCXByaW50ZigiXG4j
IyBDcmVhdGUgYSB0aHJlYWQvcHJvY2Vzcy9wcm9jZXNzIGdyb3VwIGhpZXJhcmNoeVxuIik7
CiAJY3JlYXRlX3Byb2Nlc3NlcyhudW1fcHJvY2Vzc2VzLCBudW1fdGhyZWFkcywgcHJvY3Mp
OwogCW5lZWRfY2xlYW51cCA9IDE7CiAJZGlzcF9wcm9jZXNzZXMobnVtX3Byb2Nlc3Nlcywg
cHJvY3MpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGhlcm1hbC9p
bnRlbC9wb3dlcl9mbG9vci8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
dGhlcm1hbC9pbnRlbC9wb3dlcl9mbG9vci8uZ2l0aWdub3JlCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uMWI5YTc2NDA2ZjE4Ci0tLSAvZGV2L251bGwKKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGhlcm1hbC9pbnRlbC9wb3dlcl9mbG9vci8u
Z2l0aWdub3JlCkBAIC0wLDAgKzEgQEAKK3Bvd2VyX2Zsb29yX3Rlc3QKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50ZWwvd29ya2xvYWRfaGludC8u
Z2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGhlcm1hbC9pbnRlbC93b3Jr
bG9hZF9oaW50Ly5naXRpZ25vcmUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwLi5kNjk3YjAzNGEzYTgKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnQvLmdpdGlnbm9yZQpAQCAt
MCwwICsxIEBACit3b3JrbG9hZF9oaW50X3Rlc3QKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3VldmVudC8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdWV2ZW50Ly5naXRpZ25vcmUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwLi4zODJhZmI3NGNkNDAKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy91ZXZlbnQvLmdpdGlnbm9yZQpAQCAtMCwwICsxIEBACit1ZXZlbnRfZmls
dGVyaW5nCg==

--------------E7QNSKNSmRgns5vdBSp8FJ3q--

