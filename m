Return-Path: <linux-kselftest+bounces-10149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898518C4648
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907AE1C2328A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43CD2940B;
	Mon, 13 May 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZsBdz0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76E20332
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621938; cv=none; b=Y+JO4AMfOdEH+TGlPIeJ0mrqa0B8u7J04VKIrSP/BH04lhnVq4SPYHUoCXA90HcZmWGBViMAxeIwkKpxHorIjlRBIbF2nALo46LjpBglgCsDWQ10SmcxUxX3/YFWWiTOaF6G4L5h2vDrDcJ7yHGVTWM5I2FiSw2STvVa0sYpot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621938; c=relaxed/simple;
	bh=4eDkUJtfJqnZQDhXud2XUPf8gIERYhZeF0vls8f1Mk8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject:Cc; b=jJmF9OnohKpth1XxLRAiggnOp0oB5NK8hni5XNTewrSWlstZ44TUpxB74m9qN3fRd5BwFJJWaiZEI25bl93W04EJZraoolWGhGwDnzfPMtwpaGbAOp47MieP7bjBWi9ScRjtLLXx7EsTw2evYDBxMnQCbbS47MBYGT89KPpMn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZsBdz0/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c86ad15caso3641555ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715621932; x=1716226732; darn=vger.kernel.org;
        h=cc:subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82vJ+FPZQCkmf85FHk4hnYhyaOSlNO8/MrGCT5GbLKM=;
        b=RZsBdz0/AqHgNayDdT2zoPrcvbaLJNhyCA/5521SHW22Ov275qveq0qKs7xO9QiG6W
         J5ufDt949GMfE3DREIyVuosWjRwenEQM9z0ReIu6svgSTIFeA98vFnkCtyj8Vp9indBb
         RZACJUE3JaALe4hK8kBjGSv/Q/Y+hIfNCYV+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621932; x=1716226732;
        h=cc:subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82vJ+FPZQCkmf85FHk4hnYhyaOSlNO8/MrGCT5GbLKM=;
        b=UPSUkjwSh9ylbe76/uJxxapfqN7CsKNuGl3fVRhJbt8lkEhtRRvgCIN56Eefn47N01
         bQYlEQ44yTct191qwhgZsM4hUdwFALt2/85dNKhCPsneII54+1sy4jjN5Hs7/RKjwF6z
         fLuPMd58iWMHFax+t8bbnAYLWktxYPWMWZSZWsBvHSkDfQTnU8TaGYA9/QZ9GWRW1mVF
         KZtWc0KhxQAQKfz05SyI6tGNJTRzxxv+hv4bR+LzEAdORGyUBEi++hvAyenKjpIbTJjH
         bDY99qxQEpRI0pZu7QBYIuee9ac5EFWSS9G/h8MTZF+up8KJliEGjmj8/rRUZAS+IUVx
         w0zg==
X-Forwarded-Encrypted: i=1; AJvYcCXSnYMlcMMIKGvbTi2ptipLZqFBufcTpjoc9AFBUBL2qsJfSaNPnmmSx+81Hwxj05A36thi4kXqVQUwvwnA3U13vS0ORLJ2GYcqId+zJOic
X-Gm-Message-State: AOJu0YwmIGMJAET+qu9M5ObT64WEnRV0Zc0i6QnZBIkLA/DvKSCmYGiU
	dZ60qn4rZ+YTzrfEFo6K5gH82jK5I9VrhQZE0MZZPfHW+oay0OqkLFiroef31Tc=
X-Google-Smtp-Source: AGHT+IGpAqiGS3a6UQGU9C/Bf7PsOopa3ihA0PcWqfz1r6u9rgrDTdg+/sgeo5bgdC8NNbP0N6zU5g==
X-Received: by 2002:a92:6e11:0:b0:36d:9ec4:54fb with SMTP id e9e14a558f8ab-36d9ec4574cmr20623355ab.0.1715621932280;
        Mon, 13 May 2024 10:38:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d3f20bsm22862405ab.2.2024.05.13.10.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 10:38:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------PYPiMvyQ0bQx0s17qCPHNZP3"
Message-ID: <2312d569-3c4b-4685-9678-746ae811c38b@linuxfoundation.org>
Date: Mon, 13 May 2024 11:38:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 6.10-rc1
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.
--------------PYPiMvyQ0bQx0s17qCPHNZP3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the kselftest update for Linux 6.10-rc1.

This kselftest update for Linux 6.10-rc1 consists of:

- changes to make framework and tests reporting KTAP compliant
- changes to make ktap_helpers and power_supply test POSIX compliant
- adds ksft_exit_fail_perror() to include errono in string form
- fixes to avoid clang reporting false positive static analysis errors
   about functions that exit and never return. ksft_exit* functions
   are marked __noreturn to address this problem
- adds mechanism for reporting a KSFT_ result code
- fixes to build warnings related missing headers and unused variables
- fixes to clang build failures
- cleanups to resctrl test
- adds host arch for LLVM builds

Please note that Stepen found the following conflict in
tools/testing/selftests/mm/soft-dirty.c in next and fixed it up.

between commit:

   258ff696db6b ("selftests/mm: soft-dirty should fail if a testcase fails")

from the mm-unstable branch of the mm tree and commit:

   e6162a96c81d ("selftests/mm: ksft_exit functions do not return")

from the kselftest tree.

Stepehen's fix taking the 258ff696db6b change to use ksft_finished()
looks good to me.

diff for pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

   Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1

for you to fetch changes up to 2c3b8f8f37c6c0c926d584cf4158db95e62b960c:

   selftests/sgx: Include KHDR_INCLUDES in Makefile (2024-05-08 17:08:46 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.10-rc1

This kselftest update for Linux 6.10-rc1 consists of:

- changes to make framework and tests reporting KTAP compliant
- changes to make ktap_helpers and power_supply test POSIX compliant
- adds ksft_exit_fail_perror() to include errono in string form
- fixes to avoid clang reporting false positive static analysis errors
   about functions that exit and never return. ksft_exit* functions
   are marked __noreturn to address this problem
- adds mechanism for reporting a KSFT_ result code
- fixes to build warnings related missing headers and unused variables
- fixes to clang build failures
- cleanups to resctrl test
- adds host arch for LLVM builds

----------------------------------------------------------------
Amer Al Shanawany (2):
       selftests: filesystems: add missing stddef header
       selftests/capabilities: fix warn_unused_result build warnings

Edward Liaw (2):
       selftests: Compile kselftest headers with -D_GNU_SOURCE
       selftests/sgx: Include KHDR_INCLUDES in Makefile

John Hubbard (3):
       selftests/binderfs: use the Makefile's rules, not Make's implicit rules
       selftests/resctrl: fix clang build failure: use LOCAL_HDRS
       selftests/resctrl: fix clang build warnings related to abs(), labs() calls

Lu Dai (1):
       selftests: kselftest_deps: fix l5_test() empty variable

Maciej Wieczor-Retman (3):
       selftests/resctrl: Add cleanup function to test framework
       selftests/resctrl: Simplify cleanup in ctrl-c handler
       selftests/resctrl: Move cleanups out of individual tests

Mark Brown (8):
       kselftest: Add mechanism for reporting a KSFT_ result code
       kselftest/tty: Report a consistent test name for the one test we run
       kselftest/clone3: Make test names for set_tid test stable
       tracing/selftests: Support log output when generating KTAP output
       tracing/selftests: Default to verbose mode when running in kselftest
       selftests/clone3: Fix compiler warning
       selftests/clone3: Check that the child exited cleanly
       selftests/clone3: Correct log message for waitpid() failures


Masami Hiramatsu (Google) (2):
       selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly
       selftests/ftrace: Fix checkbashisms errors

Muhammad Usama Anjum (9):
       selftests: x86: test_vsyscall: reorder code to reduce #ifdef blocks
       selftests: x86: test_vsyscall: conform test to TAP format output
       selftests: x86: test_mremap_vdso: conform test to TAP format output
       selftests/dmabuf-heap: conform test to TAP format output
       kselftest: Add missing signature to the comments
       selftests: add ksft_exit_fail_perror()
       selftests: exec: Use new ksft_exit_fail_perror() helper
       selftests: Mark ksft_exit_fail_perror() as __noreturn
       selftests: cpufreq: conform test to TAP

Nathan Chancellor (10):
       selftests/clone3: ksft_exit functions do not return
       selftests/ipc: ksft_exit functions do not return
       selftests: membarrier: ksft_exit_pass() does not return
       selftests/mm: ksft_exit functions do not return
       selftests: pidfd: ksft_exit functions do not return
       selftests/resctrl: ksft_exit_skip() does not return
       selftests: sync: ksft_exit_pass() does not return
       selftests: timers: ksft_exit functions do not return
       selftests: x86: ksft_exit_pass() does not return
       selftests: kselftest: Make ksft_exit functions return void instead of int

Nícolas F. R. A. Prado (2):
       selftests: ktap_helpers: Make it POSIX-compliant
       selftests: power_supply: Make it POSIX-compliant

Valentin Obst (1):
       selftests: default to host arch for LLVM builds

Yo-Jung (Leo) Lin (1):
       Documentation: kselftest: fix codeblock

Documentation/dev-tools/kselftest.rst              |   2 +-
  tools/testing/selftests/Makefile                   |   4 +-
  tools/testing/selftests/capabilities/test_execve.c |  12 +-
  .../testing/selftests/capabilities/validate_cap.c  |   7 +-
  tools/testing/selftests/clone3/clone3.c            |   7 +-
  .../selftests/clone3/clone3_clear_sighand.c        |   2 +-
  tools/testing/selftests/clone3/clone3_set_tid.c    | 121 +++--
  tools/testing/selftests/cpufreq/cpufreq.sh         |   3 +-
  tools/testing/selftests/cpufreq/main.sh            |  47 +-
  tools/testing/selftests/cpufreq/module.sh          |   6 +-
  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 247 ++++------
  tools/testing/selftests/exec/recursion-depth.c     |  10 +-
  .../selftests/filesystems/binderfs/Makefile        |   2 -
  .../filesystems/statmount/statmount_test.c         |   1 +
  tools/testing/selftests/ftrace/ftracetest          |   8 +-
  tools/testing/selftests/ftrace/ftracetest-ktap     |   2 +-
  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   2 +-
  .../ftrace/test.d/dynevent/fprobe_entry_arg.tc     |   2 +-
  .../ftrace/test.d/kprobe/kretprobe_entry_arg.tc    |   2 +-
  tools/testing/selftests/ipc/msgque.c               |  11 +-
  tools/testing/selftests/kselftest.h                |  49 +-
  tools/testing/selftests/kselftest/ktap_helpers.sh  |   4 +-
  tools/testing/selftests/kselftest_deps.sh          |   1 +
  tools/testing/selftests/kselftest_harness.h        |   2 +-
  tools/testing/selftests/lib.mk                     |  14 +-
  .../membarrier/membarrier_test_multi_thread.c      |   2 +-
  .../membarrier/membarrier_test_single_thread.c     |   2 +-
  tools/testing/selftests/mm/compaction_test.c       |   6 +-
  tools/testing/selftests/mm/cow.c                   |   2 +-
  tools/testing/selftests/mm/gup_longterm.c          |   2 +-
  tools/testing/selftests/mm/gup_test.c              |   4 +-
  tools/testing/selftests/mm/ksm_functional_tests.c  |   2 +-
  tools/testing/selftests/mm/madv_populate.c         |   2 +-
  tools/testing/selftests/mm/mkdirty.c               |   2 +-
  tools/testing/selftests/mm/pagemap_ioctl.c         |   4 +-
  tools/testing/selftests/mm/soft-dirty.c            |   2 +-
  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  |   2 +-
  tools/testing/selftests/pidfd/pidfd_open_test.c    |   4 +-
  tools/testing/selftests/pidfd/pidfd_poll_test.c    |   2 +-
  tools/testing/selftests/pidfd/pidfd_test.c         |   2 +-
  .../power_supply/test_power_supply_properties.sh   |   2 +-
  tools/testing/selftests/resctrl/Makefile           |   4 +-
  tools/testing/selftests/resctrl/cat_test.c         |   8 +-
  tools/testing/selftests/resctrl/cmt_test.c         |   8 +-
  tools/testing/selftests/resctrl/mba_test.c         |  10 +-
  tools/testing/selftests/resctrl/mbm_test.c         |  10 +-
  tools/testing/selftests/resctrl/resctrl.h          |   9 +-
  tools/testing/selftests/resctrl/resctrl_tests.c    |  26 +-
  tools/testing/selftests/resctrl/resctrl_val.c      |   8 +-
  tools/testing/selftests/sgx/Makefile               |   2 +-
  tools/testing/selftests/sgx/sigstruct.c            |   1 -
  tools/testing/selftests/sync/sync_test.c           |   3 +-
  tools/testing/selftests/timers/adjtick.c           |   4 +-
  .../testing/selftests/timers/alarmtimer-suspend.c  |   4 +-
  tools/testing/selftests/timers/change_skew.c       |   4 +-
  tools/testing/selftests/timers/freq-step.c         |   4 +-
  tools/testing/selftests/timers/leap-a-day.c        |  10 +-
  tools/testing/selftests/timers/leapcrash.c         |   4 +-
  tools/testing/selftests/timers/mqueue-lat.c        |   4 +-
  tools/testing/selftests/timers/posix_timers.c      |  12 +-
  tools/testing/selftests/timers/raw_skew.c          |   6 +-
  tools/testing/selftests/timers/set-2038.c          |   4 +-
  tools/testing/selftests/timers/set-tai.c           |   4 +-
  tools/testing/selftests/timers/set-timer-lat.c     |   4 +-
  tools/testing/selftests/timers/set-tz.c            |   4 +-
  tools/testing/selftests/timers/skew_consistency.c  |   4 +-
  tools/testing/selftests/timers/threadtest.c        |   2 +-
  tools/testing/selftests/timers/valid-adjtimex.c    |   6 +-
  tools/testing/selftests/tty/tty_tstamp_update.c    |  48 +-
  tools/testing/selftests/x86/lam.c                  |   2 +-
  tools/testing/selftests/x86/test_mremap_vdso.c     |  43 +-
  tools/testing/selftests/x86/test_vsyscall.c        | 506 ++++++++++-----------
  72 files changed, 703 insertions(+), 675 deletions(-)
----------------------------------------------------------------
--------------PYPiMvyQ0bQx0s17qCPHNZP3
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.10-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.10-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5yc3QgYi9E
b2N1bWVudGF0aW9uL2Rldi10b29scy9rc2VsZnRlc3QucnN0CmluZGV4IGZmMTBkYzZlZWY1
ZC4uZGNmNjM0ZTQxMWJkIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9r
c2VsZnRlc3QucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5y
c3QKQEAgLTE4Myw3ICsxODMsNyBAQCBleHBlY3RlZCB0aW1lIGl0IHRha2VzIHRvIHJ1biBh
IHRlc3QuIElmIHlvdSBoYXZlIGNvbnRyb2wgb3ZlciB0aGUgc3lzdGVtcwogd2hpY2ggd2ls
bCBydW4gdGhlIHRlc3RzIHlvdSBjYW4gY29uZmlndXJlIGEgdGVzdCBydW5uZXIgb24gdGhv
c2Ugc3lzdGVtcyB0bwogdXNlIGEgZ3JlYXRlciBvciBsb3dlciB0aW1lb3V0IG9uIHRoZSBj
b21tYW5kIGxpbmUgYXMgd2l0aCB0aGUgYC1vYCBvcgogdGhlIGAtLW92ZXJyaWRlLXRpbWVv
dXRgIGFyZ3VtZW50LiBGb3IgZXhhbXBsZSB0byB1c2UgMTY1IHNlY29uZHMgaW5zdGVhZAot
b25lIHdvdWxkIHVzZToKK29uZSB3b3VsZCB1c2U6OgogCiAgICAkIC4vcnVuX2tzZWxmdGVz
dC5zaCAtLW92ZXJyaWRlLXRpbWVvdXQgMTY1CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZp
bGUKaW5kZXggZTE1MDQ4MzM2NTRkLi5lZDAxMmE3ZjA3ODYgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL01ha2VmaWxlCkBAIC0xNjEsMTEgKzE2MSwxMSBAQCBpZm5lcSAoJChLQlVJTERfT1VU
UFVUKSwpCiAgICMgJChyZWFscGF0aCAuLi4pIHJlc29sdmVzIHN5bWxpbmtzCiAgIGFic19v
Ymp0cmVlIDo9ICQocmVhbHBhdGggJChhYnNfb2JqdHJlZSkpCiAgIEJVSUxEIDo9ICQoYWJz
X29ianRyZWUpL2tzZWxmdGVzdAotICBLSERSX0lOQ0xVREVTIDo9IC1pc3lzdGVtICR7YWJz
X29ianRyZWV9L3Vzci9pbmNsdWRlCisgIEtIRFJfSU5DTFVERVMgOj0gLURfR05VX1NPVVJD
RSAtaXN5c3RlbSAke2Fic19vYmp0cmVlfS91c3IvaW5jbHVkZQogZWxzZQogICBCVUlMRCA6
PSAkKENVUkRJUikKICAgYWJzX3NyY3RyZWUgOj0gJChzaGVsbCBjZCAkKHRvcF9zcmNkaXIp
ICYmIHB3ZCkKLSAgS0hEUl9JTkNMVURFUyA6PSAtaXN5c3RlbSAke2Fic19zcmN0cmVlfS91
c3IvaW5jbHVkZQorICBLSERSX0lOQ0xVREVTIDo9IC1EX0dOVV9TT1VSQ0UgLWlzeXN0ZW0g
JHthYnNfc3JjdHJlZX0vdXNyL2luY2x1ZGUKICAgREVGQVVMVF9JTlNUQUxMX0hEUl9QQVRI
IDo9IDEKIGVuZGlmCiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nh
cGFiaWxpdGllcy90ZXN0X2V4ZWN2ZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2Fw
YWJpbGl0aWVzL3Rlc3RfZXhlY3ZlLmMKaW5kZXggN2NkZTA3YTVkZjc4Li40N2JhZDdkZGM1
YmMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGllcy90
ZXN0X2V4ZWN2ZS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NhcGFiaWxpdGll
cy90ZXN0X2V4ZWN2ZS5jCkBAIC04Miw3ICs4Miw3IEBAIHN0YXRpYyBib29sIGNyZWF0ZV9h
bmRfZW50ZXJfbnModWlkX3QgaW5uZXJfdWlkKQogewogCXVpZF90IG91dGVyX3VpZDsKIAln
aWRfdCBvdXRlcl9naWQ7Ci0JaW50IGk7CisJaW50IGksIHJldDsKIAlib29sIGhhdmVfb3V0
ZXJfcHJpdmlsZWdlOwogCiAJb3V0ZXJfdWlkID0gZ2V0dWlkKCk7CkBAIC05Nyw3ICs5Nywx
MCBAQCBzdGF0aWMgYm9vbCBjcmVhdGVfYW5kX2VudGVyX25zKHVpZF90IGlubmVyX3VpZCkK
IAkJCWtzZnRfZXhpdF9mYWlsX21zZygic2V0cmVzdWlkIC0gJXNcbiIsIHN0cmVycm9yKGVy
cm5vKSk7CiAKIAkJLy8gUmUtZW5hYmxlIGVmZmVjdGl2ZSBjYXBzCi0JCWNhcG5nX2dldF9j
YXBzX3Byb2Nlc3MoKTsKKwkJcmV0ID0gY2FwbmdfZ2V0X2NhcHNfcHJvY2VzcygpOworCQlp
ZiAocmV0ID09IC0xKQorCQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJjYXBuZ19nZXRfY2Fwc19w
cm9jZXNzIGZhaWxlZFxuIik7CisKIAkJZm9yIChpID0gMDsgaSA8IENBUF9MQVNUX0NBUDsg
aSsrKQogCQkJaWYgKGNhcG5nX2hhdmVfY2FwYWJpbGl0eShDQVBOR19QRVJNSVRURUQsIGkp
KQogCQkJCWNhcG5nX3VwZGF0ZShDQVBOR19BREQsIENBUE5HX0VGRkVDVElWRSwgaSk7CkBA
IC0yMDcsNiArMjEwLDcgQEAgc3RhdGljIHZvaWQgZXhlY192YWxpZGF0ZV9jYXAoYm9vbCBl
ZmYsIGJvb2wgcGVybSwgYm9vbCBpbmgsIGJvb2wgYW1iaWVudCkKIAogc3RhdGljIGludCBk
b190ZXN0cyhpbnQgdWlkLCBjb25zdCBjaGFyICpvdXJfcGF0aCkKIHsKKwlpbnQgcmV0Owog
CWJvb2wgaGF2ZV9vdXRlcl9wcml2aWxlZ2UgPSBjcmVhdGVfYW5kX2VudGVyX25zKHVpZCk7
CiAKIAlpbnQgb3VycGF0aF9mZCA9IG9wZW4ob3VyX3BhdGgsIE9fUkRPTkxZIHwgT19ESVJF
Q1RPUlkpOwpAQCAtMjUwLDcgKzI1NCw5IEBAIHN0YXRpYyBpbnQgZG9fdGVzdHMoaW50IHVp
ZCwgY29uc3QgY2hhciAqb3VyX3BhdGgpCiAJCQlrc2Z0X2V4aXRfZmFpbF9tc2coImNobW9k
IC0gJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAJfQogCi0JY2FwbmdfZ2V0X2NhcHNfcHJv
Y2VzcygpOworCXJldCA9IGNhcG5nX2dldF9jYXBzX3Byb2Nlc3MoKTsKKwlpZiAocmV0ID09
IC0xKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coImNhcG5nX2dldF9jYXBzX3Byb2Nlc3MgZmFp
bGVkXG4iKTsKIAogCS8qIE1ha2Ugc3VyZSB0aGF0IGkgc3RhcnRzIG91dCBjbGVhciAqLwog
CWNhcG5nX3VwZGF0ZShDQVBOR19EUk9QLCBDQVBOR19JTkhFUklUQUJMRSwgQ0FQX05FVF9C
SU5EX1NFUlZJQ0UpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2Fw
YWJpbGl0aWVzL3ZhbGlkYXRlX2NhcC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2Fw
YWJpbGl0aWVzL3ZhbGlkYXRlX2NhcC5jCmluZGV4IDYwYjRlN2I3MTZhNy4uNjVmMmExYzg5
MjM5IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jYXBhYmlsaXRpZXMv
dmFsaWRhdGVfY2FwLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2FwYWJpbGl0
aWVzL3ZhbGlkYXRlX2NhcC5jCkBAIC0yOCw2ICsyOCw3IEBAIHN0YXRpYyBib29sIGJvb2xf
YXJnKGNoYXIgKiphcmd2LCBpbnQgaSkKIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIHsKIAljb25zdCBjaGFyICphdHNlYyA9ICIiOworCWludCByZXQ7CiAKIAkvKgogCSAq
IEJlIGNhcmVmdWwganVzdCBpbiBjYXNlIGEgc2V0Z2lkIG9yIHNldGNhcHBlZCBjb3B5IG9m
IHRoaXMKQEAgLTQ0LDcgKzQ1LDExIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAkJYXRzZWMgPSAiIChBVF9TRUNVUkUgaXMgbm90IHNldCkiOwogI2VuZGlmCiAKLQlj
YXBuZ19nZXRfY2Fwc19wcm9jZXNzKCk7CisJcmV0ID0gY2FwbmdfZ2V0X2NhcHNfcHJvY2Vz
cygpOworCWlmIChyZXQgPT0gLTEpIHsKKwkJa3NmdF9wcmludF9tc2coImNhcG5nX2dldF9j
YXBzX3Byb2Nlc3MgZmFpbGVkXG4iKTsKKwkJcmV0dXJuIDE7CisJfQogCiAJaWYgKGNhcG5n
X2hhdmVfY2FwYWJpbGl0eShDQVBOR19FRkZFQ1RJVkUsIENBUF9ORVRfQklORF9TRVJWSUNF
KSAhPSBib29sX2FyZyhhcmd2LCAxKSkgewogCQlrc2Z0X3ByaW50X21zZygiV3JvbmcgZWZm
ZWN0aXZlIHN0YXRlJXNcbiIsIGF0c2VjKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Nsb25lMy9jbG9uZTMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Ns
b25lMy9jbG9uZTMuYwppbmRleCAzYzliZjBjZDgyYTguLmU2MWYwNzk3M2NlNSAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lMy5jCisrKyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTMuYwpAQCAtOTUsOSArOTUsMTQg
QEAgc3RhdGljIGludCBjYWxsX2Nsb25lMyh1aW50NjRfdCBmbGFncywgc2l6ZV90IHNpemUs
IGVudW0gdGVzdF9tb2RlIHRlc3RfbW9kZSkKIAkJCWdldHBpZCgpLCBwaWQpOwogCiAJaWYg
KHdhaXRwaWQoLTEsICZzdGF0dXMsIF9fV0FMTCkgPCAwKSB7Ci0JCWtzZnRfcHJpbnRfbXNn
KCJDaGlsZCByZXR1cm5lZCAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKKwkJa3NmdF9wcmlu
dF9tc2coIndhaXRwaWQoKSByZXR1cm5lZCAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKIAkJ
cmV0dXJuIC1lcnJubzsKIAl9CisJaWYgKCFXSUZFWElURUQoc3RhdHVzKSkgeworCQlrc2Z0
X3ByaW50X21zZygiQ2hpbGQgZGlkIG5vdCBleGl0IG5vcm1hbGx5LCBzdGF0dXMgMHgleFxu
IiwKKwkJCSAgICAgICBzdGF0dXMpOworCQlyZXR1cm4gRVhJVF9GQUlMVVJFOworCX0KIAlp
ZiAoV0VYSVRTVEFUVVMoc3RhdHVzKSkKIAkJcmV0dXJuIFdFWElUU1RBVFVTKHN0YXR1cyk7
CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNf
Y2xlYXJfc2lnaGFuZC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25l
M19jbGVhcl9zaWdoYW5kLmMKaW5kZXggNTRhOGIyNDQ1YmU5Li5jZTA0MjY3ODY4MjggMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfY2xlYXJf
c2lnaGFuZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNf
Y2xlYXJfc2lnaGFuZC5jCkBAIC0xMjAsNSArMTIwLDUgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQogCiAJdGVzdF9jbG9uZTNfY2xlYXJfc2lnaGFuZCgpOwogCi0JcmV0
dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfc2V0X3RpZC5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lM19zZXRfdGlkLmMKaW5kZXgg
ZWQ3ODVhZmI2MDc3Li5iZmIwZGEyYjRmZGQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfc2V0X3RpZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfc2V0X3RpZC5jCkBAIC0xMTQsNyArMTE0LDggQEAg
c3RhdGljIGludCBjYWxsX2Nsb25lM19zZXRfdGlkKHBpZF90ICpzZXRfdGlkLAogCXJldHVy
biBXRVhJVFNUQVRVUyhzdGF0dXMpOwogfQogCi1zdGF0aWMgdm9pZCB0ZXN0X2Nsb25lM19z
ZXRfdGlkKHBpZF90ICpzZXRfdGlkLAorc3RhdGljIHZvaWQgdGVzdF9jbG9uZTNfc2V0X3Rp
ZChjb25zdCBjaGFyICpkZXNjLAorCQkJCXBpZF90ICpzZXRfdGlkLAogCQkJCXNpemVfdCBz
ZXRfdGlkX3NpemUsCiAJCQkJaW50IGZsYWdzLAogCQkJCWludCBleHBlY3RlZCwKQEAgLTEy
OSwxNyArMTMwLDEzIEBAIHN0YXRpYyB2b2lkIHRlc3RfY2xvbmUzX3NldF90aWQocGlkX3Qg
KnNldF90aWQsCiAJcmV0ID0gY2FsbF9jbG9uZTNfc2V0X3RpZChzZXRfdGlkLCBzZXRfdGlk
X3NpemUsIGZsYWdzLCBleHBlY3RlZF9waWQsCiAJCQkJICB3YWl0X2Zvcl9pdCk7CiAJa3Nm
dF9wcmludF9tc2coCi0JCSJbJWRdIGNsb25lMygpIHdpdGggQ0xPTkVfU0VUX1RJRCAlZCBz
YXlzIDolZCAtIGV4cGVjdGVkICVkXG4iLAorCQkiWyVkXSBjbG9uZTMoKSB3aXRoIENMT05F
X1NFVF9USUQgJWQgc2F5czogJWQgLSBleHBlY3RlZCAlZFxuIiwKIAkJZ2V0cGlkKCksIHNl
dF90aWRbMF0sIHJldCwgZXhwZWN0ZWQpOwotCWlmIChyZXQgIT0gZXhwZWN0ZWQpCi0JCWtz
ZnRfdGVzdF9yZXN1bHRfZmFpbCgKLQkJCSJbJWRdIFJlc3VsdCAoJWQpIGlzIGRpZmZlcmVu
dCB0aGFuIGV4cGVjdGVkICglZClcbiIsCi0JCQlnZXRwaWQoKSwgcmV0LCBleHBlY3RlZCk7
Ci0JZWxzZQotCQlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoCi0JCQkiWyVkXSBSZXN1bHQgKCVk
KSBtYXRjaGVzIGV4cGVjdGF0aW9uICglZClcbiIsCi0JCQlnZXRwaWQoKSwgcmV0LCBleHBl
Y3RlZCk7CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCA9PSBleHBlY3RlZCwgIiVzIHdpdGgg
JXp1IFRJRHMgYW5kIGZsYWdzIDB4JXhcbiIsCisJCQkgZGVzYywgc2V0X3RpZF9zaXplLCBm
bGFncyk7CiB9CisKIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CiAJRklM
RSAqZjsKQEAgLTE3Miw3MyArMTY5LDkxIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAKIAkvKiBUcnkgaW52YWxpZCBzZXR0aW5ncyAqLwogCW1lbXNldCgmc2V0X3Rp
ZCwgMCwgc2l6ZW9mKHNldF90aWQpKTsKLQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQs
IE1BWF9QSURfTlNfTEVWRUwgKyAxLCAwLCAtRUlOVkFMLCAwLCAwKTsKKwl0ZXN0X2Nsb25l
M19zZXRfdGlkKCJpbnZhbGlkIHNpemUsIDAgVElEIiwKKwkJCSAgICBzZXRfdGlkLCBNQVhf
UElEX05TX0xFVkVMICsgMSwgMCwgLUVJTlZBTCwgMCwgMCk7CiAKLQl0ZXN0X2Nsb25lM19z
ZXRfdGlkKHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwgKiAyLCAwLCAtRUlOVkFMLCAwLCAw
KTsKKwl0ZXN0X2Nsb25lM19zZXRfdGlkKCJpbnZhbGlkIHNpemUsIDAgVElEIiwKKwkJCSAg
ICBzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVMICogMiwgMCwgLUVJTlZBTCwgMCwgMCk7CiAK
LQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwgKiAyICsg
MSwgMCwKLQkJCS1FSU5WQUwsIDAsIDApOworCXRlc3RfY2xvbmUzX3NldF90aWQoImludmFs
aWQgc2l6ZSwgMCBUSUQiLAorCQkJICAgIHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwgKiAy
ICsgMSwgMCwKKwkJCSAgICAtRUlOVkFMLCAwLCAwKTsKIAotCXRlc3RfY2xvbmUzX3NldF90
aWQoc2V0X3RpZCwgTUFYX1BJRF9OU19MRVZFTCAqIDQyLCAwLCAtRUlOVkFMLCAwLCAwKTsK
Kwl0ZXN0X2Nsb25lM19zZXRfdGlkKCJpbnZhbGlkIHNpemUsIDAgVElEIiwKKwkJCSAgICBz
ZXRfdGlkLCBNQVhfUElEX05TX0xFVkVMICogNDIsIDAsIC1FSU5WQUwsIDAsIDApOwogCiAJ
LyoKIAkgKiBUaGlzIGNhbiBhY3R1YWxseSB3b3JrIGlmIHRoaXMgdGVzdCBydW5uaW5nIGlu
IGEgTUFYX1BJRF9OU19MRVZFTCAtIDEKIAkgKiBuZXN0ZWQgUElEIG5hbWVzcGFjZS4KIAkg
Ki8KLQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwgLSAx
LCAwLCAtRUlOVkFMLCAwLCAwKTsKKwl0ZXN0X2Nsb25lM19zZXRfdGlkKCJpbnZhbGlkIHNp
emUsIDAgVElEIiwKKwkJCSAgICBzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVMIC0gMSwgMCwg
LUVJTlZBTCwgMCwgMCk7CiAKIAltZW1zZXQoJnNldF90aWQsIDB4ZmYsIHNpemVvZihzZXRf
dGlkKSk7Ci0JdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVM
ICsgMSwgMCwgLUVJTlZBTCwgMCwgMCk7CisJdGVzdF9jbG9uZTNfc2V0X3RpZCgiaW52YWxp
ZCBzaXplLCBUSUQgYWxsIDFzIiwKKwkJCSAgICBzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVM
ICsgMSwgMCwgLUVJTlZBTCwgMCwgMCk7CiAKLQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90
aWQsIE1BWF9QSURfTlNfTEVWRUwgKiAyLCAwLCAtRUlOVkFMLCAwLCAwKTsKKwl0ZXN0X2Ns
b25lM19zZXRfdGlkKCJpbnZhbGlkIHNpemUsIFRJRCBhbGwgMXMiLAorCQkJICAgIHNldF90
aWQsIE1BWF9QSURfTlNfTEVWRUwgKiAyLCAwLCAtRUlOVkFMLCAwLCAwKTsKIAotCXRlc3Rf
Y2xvbmUzX3NldF90aWQoc2V0X3RpZCwgTUFYX1BJRF9OU19MRVZFTCAqIDIgKyAxLCAwLAot
CQkJLUVJTlZBTCwgMCwgMCk7CisJdGVzdF9jbG9uZTNfc2V0X3RpZCgiaW52YWxpZCBzaXpl
LCBUSUQgYWxsIDFzIiwKKwkJCSAgICBzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVMICogMiAr
IDEsIDAsCisJCQkgICAgLUVJTlZBTCwgMCwgMCk7CiAKLQl0ZXN0X2Nsb25lM19zZXRfdGlk
KHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwgKiA0MiwgMCwgLUVJTlZBTCwgMCwgMCk7CisJ
dGVzdF9jbG9uZTNfc2V0X3RpZCgiaW52YWxpZCBzaXplLCBUSUQgYWxsIDFzIiwKKwkJCSAg
ICBzZXRfdGlkLCBNQVhfUElEX05TX0xFVkVMICogNDIsIDAsIC1FSU5WQUwsIDAsIDApOwog
CiAJLyoKIAkgKiBUaGlzIGNhbiBhY3R1YWxseSB3b3JrIGlmIHRoaXMgdGVzdCBydW5uaW5n
IGluIGEgTUFYX1BJRF9OU19MRVZFTCAtIDEKIAkgKiBuZXN0ZWQgUElEIG5hbWVzcGFjZS4K
IAkgKi8KLQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwg
LSAxLCAwLCAtRUlOVkFMLCAwLCAwKTsKKwl0ZXN0X2Nsb25lM19zZXRfdGlkKCJpbnZhbGlk
IHNpemUsIFRJRCBhbGwgMXMiLAorCQkJICAgIHNldF90aWQsIE1BWF9QSURfTlNfTEVWRUwg
LSAxLCAwLCAtRUlOVkFMLCAwLCAwKTsKIAogCW1lbXNldCgmc2V0X3RpZCwgMCwgc2l6ZW9m
KHNldF90aWQpKTsKIAkvKiBUcnkgd2l0aCBhbiBpbnZhbGlkIFBJRCAqLwogCXNldF90aWRb
MF0gPSAwOwotCXRlc3RfY2xvbmUzX3NldF90aWQoc2V0X3RpZCwgMSwgMCwgLUVJTlZBTCwg
MCwgMCk7CisJdGVzdF9jbG9uZTNfc2V0X3RpZCgidmFsaWQgc2l6ZSwgMCBUSUQiLAorCQkJ
ICAgIHNldF90aWQsIDEsIDAsIC1FSU5WQUwsIDAsIDApOwogCiAJc2V0X3RpZFswXSA9IC0x
OwotCXRlc3RfY2xvbmUzX3NldF90aWQoc2V0X3RpZCwgMSwgMCwgLUVJTlZBTCwgMCwgMCk7
CisJdGVzdF9jbG9uZTNfc2V0X3RpZCgidmFsaWQgc2l6ZSwgLTEgVElEIiwKKwkJCSAgICBz
ZXRfdGlkLCAxLCAwLCAtRUlOVkFMLCAwLCAwKTsKIAogCS8qIENsYWltIHRoYXQgdGhlIHNl
dF90aWQgYXJyYXkgYWN0dWFsbHkgY29udGFpbnMgMiBlbGVtZW50cy4gKi8KLQl0ZXN0X2Ns
b25lM19zZXRfdGlkKHNldF90aWQsIDIsIDAsIC1FSU5WQUwsIDAsIDApOworCXRlc3RfY2xv
bmUzX3NldF90aWQoIjIgVElEcywgLTEgYW5kIDAiLAorCQkJICAgIHNldF90aWQsIDIsIDAs
IC1FSU5WQUwsIDAsIDApOwogCiAJLyogVHJ5IGl0IGluIGEgbmV3IFBJRCBuYW1lc3BhY2Ug
Ki8KIAlpZiAodWlkID09IDApCi0JCXRlc3RfY2xvbmUzX3NldF90aWQoc2V0X3RpZCwgMSwg
Q0xPTkVfTkVXUElELCAtRUlOVkFMLCAwLCAwKTsKKwkJdGVzdF9jbG9uZTNfc2V0X3RpZCgi
dmFsaWQgc2l6ZSwgLTEgVElEIiwKKwkJCQkgICAgc2V0X3RpZCwgMSwgQ0xPTkVfTkVXUElE
LCAtRUlOVkFMLCAwLCAwKTsKIAllbHNlCiAJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiQ2xv
bmUzKCkgd2l0aCBzZXRfdGlkIHJlcXVpcmVzIHJvb3RcbiIpOwogCiAJLyogVHJ5IHdpdGgg
YSB2YWxpZCBQSUQgKDEpIHRoaXMgc2hvdWxkIHJldHVybiAtRUVYSVNULiAqLwogCXNldF90
aWRbMF0gPSAxOwogCWlmICh1aWQgPT0gMCkKLQkJdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRf
dGlkLCAxLCAwLCAtRUVYSVNULCAwLCAwKTsKKwkJdGVzdF9jbG9uZTNfc2V0X3RpZCgiZHVw
bGljYXRlIFBJRCAxIiwKKwkJCQkgICAgc2V0X3RpZCwgMSwgMCwgLUVFWElTVCwgMCwgMCk7
CiAJZWxzZQogCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIkNsb25lMygpIHdpdGggc2V0X3Rp
ZCByZXF1aXJlcyByb290XG4iKTsKIAogCS8qIFRyeSBpdCBpbiBhIG5ldyBQSUQgbmFtZXNw
YWNlICovCiAJaWYgKHVpZCA9PSAwKQotCQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQs
IDEsIENMT05FX05FV1BJRCwgMCwgMCwgMCk7CisJCXRlc3RfY2xvbmUzX3NldF90aWQoImR1
cGxpY2F0ZSBQSUQgMSIsCisJCQkJICAgIHNldF90aWQsIDEsIENMT05FX05FV1BJRCwgMCwg
MCwgMCk7CiAJZWxzZQogCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIkNsb25lMygpIHdpdGgg
c2V0X3RpZCByZXF1aXJlcyByb290XG4iKTsKIAogCS8qIHBpZF9tYXggc2hvdWxkIGZhaWwg
ZXZlcnl3aGVyZSAqLwogCXNldF90aWRbMF0gPSBwaWRfbWF4OwotCXRlc3RfY2xvbmUzX3Nl
dF90aWQoc2V0X3RpZCwgMSwgMCwgLUVJTlZBTCwgMCwgMCk7CisJdGVzdF9jbG9uZTNfc2V0
X3RpZCgic2V0IFRJRCB0byBtYXhpbXVtIiwKKwkJCSAgICBzZXRfdGlkLCAxLCAwLCAtRUlO
VkFMLCAwLCAwKTsKIAogCWlmICh1aWQgPT0gMCkKLQkJdGVzdF9jbG9uZTNfc2V0X3RpZChz
ZXRfdGlkLCAxLCBDTE9ORV9ORVdQSUQsIC1FSU5WQUwsIDAsIDApOworCQl0ZXN0X2Nsb25l
M19zZXRfdGlkKCJzZXQgVElEIHRvIG1heGltdW0iLAorCQkJCSAgICBzZXRfdGlkLCAxLCBD
TE9ORV9ORVdQSUQsIC1FSU5WQUwsIDAsIDApOwogCWVsc2UKIAkJa3NmdF90ZXN0X3Jlc3Vs
dF9za2lwKCJDbG9uZTMoKSB3aXRoIHNldF90aWQgcmVxdWlyZXMgcm9vdFxuIik7CiAKQEAg
LTI2MiwxMCArMjc3LDEyIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAK
IAkvKiBBZnRlciB0aGUgY2hpbGQgaGFzIGZpbmlzaGVkLCBpdHMgUElEIHNob3VsZCBiZSBm
cmVlLiAqLwogCXNldF90aWRbMF0gPSBwaWQ7Ci0JdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRf
dGlkLCAxLCAwLCAwLCAwLCAwKTsKKwl0ZXN0X2Nsb25lM19zZXRfdGlkKCJyZWFsbG9jYXRl
IGNoaWxkIFRJRCIsCisJCQkgICAgc2V0X3RpZCwgMSwgMCwgMCwgMCwgMCk7CiAKIAkvKiBU
aGlzIHNob3VsZCBmYWlsIGFzIHRoZXJlIGlzIG5vIFBJRCAxIGluIHRoYXQgbmFtZXNwYWNl
ICovCi0JdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRfdGlkLCAxLCBDTE9ORV9ORVdQSUQsIC1F
SU5WQUwsIDAsIDApOworCXRlc3RfY2xvbmUzX3NldF90aWQoImR1cGxpY2F0ZSBjaGlsZCBU
SUQiLAorCQkJICAgIHNldF90aWQsIDEsIENMT05FX05FV1BJRCwgLUVJTlZBTCwgMCwgMCk7
CiAKIAkvKgogCSAqIENyZWF0aW5nIGEgcHJvY2VzcyB3aXRoIFBJRCAxIGluIHRoZSBuZXds
eSBjcmVhdGVkIG1vc3QgbmVzdGVkCkBAIC0yNzQsNyArMjkxLDggQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkgKi8KIAlzZXRfdGlkWzBdID0gMTsKIAlzZXRfdGlk
WzFdID0gcGlkOwotCXRlc3RfY2xvbmUzX3NldF90aWQoc2V0X3RpZCwgMiwgQ0xPTkVfTkVX
UElELCAwLCBwaWQsIDApOworCXRlc3RfY2xvbmUzX3NldF90aWQoImNyZWF0ZSBQSUQgMSBp
biBuZXcgTlMiLAorCQkJICAgIHNldF90aWQsIDIsIENMT05FX05FV1BJRCwgMCwgcGlkLCAw
KTsKIAogCWtzZnRfcHJpbnRfbXNnKCJ1bnNoYXJlIFBJRCBuYW1lc3BhY2VcbiIpOwogCWlm
ICh1bnNoYXJlKENMT05FX05FV1BJRCkgPT0gLTEpCkBAIC0yODQsNyArMzAyLDggQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlzZXRfdGlkWzBdID0gcGlkOwogCiAJ
LyogVGhpcyBzaG91bGQgZmFpbCBhcyB0aGVyZSBpcyBubyBQSUQgMSBpbiB0aGF0IG5hbWVz
cGFjZSAqLwotCXRlc3RfY2xvbmUzX3NldF90aWQoc2V0X3RpZCwgMSwgMCwgLUVJTlZBTCwg
MCwgMCk7CisJdGVzdF9jbG9uZTNfc2V0X3RpZCgiZHVwbGljYXRlIFBJRCAxIiwKKwkJCSAg
ICBzZXRfdGlkLCAxLCAwLCAtRUlOVkFMLCAwLCAwKTsKIAogCS8qIExldCdzIGNyZWF0ZSBh
IFBJRCAxICovCiAJbnNfcGlkID0gZm9yaygpOwpAQCAtMjk1LDIxICszMTQsMjUgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJICovCiAJCXNldF90aWRbMF0gPSA0
MzsKIAkJc2V0X3RpZFsxXSA9IC0xOwotCQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQs
IDIsIDAsIC1FSU5WQUwsIDAsIDApOworCQl0ZXN0X2Nsb25lM19zZXRfdGlkKCJjaGVjayBs
ZWFrIG9uIGludmFsaWQgVElEIC0xIiwKKwkJCQkgICAgc2V0X3RpZCwgMiwgMCwgLUVJTlZB
TCwgMCwgMCk7CiAKIAkJc2V0X3RpZFswXSA9IDQzOwogCQlzZXRfdGlkWzFdID0gcGlkOwot
CQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIDIsIDAsIDAsIDQzLCAwKTsKKwkJdGVz
dF9jbG9uZTNfc2V0X3RpZCgiY2hlY2sgbGVhayBvbiBpbnZhbGlkIHNwZWNpZmljIFRJRCIs
CisJCQkJICAgIHNldF90aWQsIDIsIDAsIDAsIDQzLCAwKTsKIAogCQlrc2Z0X3ByaW50X21z
ZygiQ2hpbGQgaW4gUElEIG5hbWVzcGFjZSBoYXMgUElEICVkXG4iLCBnZXRwaWQoKSk7CiAJ
CXNldF90aWRbMF0gPSAyOwotCQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIDEsIDAs
IDAsIDIsIDApOworCQl0ZXN0X2Nsb25lM19zZXRfdGlkKCJjcmVhdGUgUElEIDIgaW4gY2hp
bGQgTlMiLAorCQkJCSAgICBzZXRfdGlkLCAxLCAwLCAwLCAyLCAwKTsKIAogCQlzZXRfdGlk
WzBdID0gMTsKIAkJc2V0X3RpZFsxXSA9IC0xOwogCQlzZXRfdGlkWzJdID0gcGlkOwogCQkv
KiBUaGlzIHNob3VsZCBmYWlsIGFzIHRoZXJlIGlzIGludmFsaWQgUElEIGF0IGxldmVsICcx
Jy4gKi8KLQkJdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRfdGlkLCAzLCBDTE9ORV9ORVdQSUQs
IC1FSU5WQUwsIDAsIDApOworCQl0ZXN0X2Nsb25lM19zZXRfdGlkKCJmYWlsIGR1ZSB0byBp
bnZhbGlkIFRJRCBhdCBsZXZlbCAxIiwKKwkJCQkgICAgc2V0X3RpZCwgMywgQ0xPTkVfTkVX
UElELCAtRUlOVkFMLCAwLCAwKTsKIAogCQlzZXRfdGlkWzBdID0gMTsKIAkJc2V0X3RpZFsx
XSA9IDQyOwpAQCAtMzE5LDEzICszNDIsMTUgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkKIAkJICogbmFtZXNwYWNlcy4gQWdhaW4gYXNzdW1pbmcgdGhpcyBpcyBydW5u
aW5nIGluIHRoZSBob3N0J3MKIAkJICogUElEIG5hbWVzcGFjZS4gTm90IHlldCBuZXN0ZWQu
CiAJCSAqLwotCQl0ZXN0X2Nsb25lM19zZXRfdGlkKHNldF90aWQsIDQsIENMT05FX05FV1BJ
RCwgLUVJTlZBTCwgMCwgMCk7CisJCXRlc3RfY2xvbmUzX3NldF90aWQoImZhaWwgZHVlIHRv
IHRvbyBmZXcgYWN0aXZlIFBJRCBOU3MiLAorCQkJCSAgICBzZXRfdGlkLCA0LCBDTE9ORV9O
RVdQSUQsIC1FSU5WQUwsIDAsIDApOwogCiAJCS8qCiAJCSAqIFRoaXMgc2hvdWxkIHdvcmsg
YW5kIGZyb20gdGhlIHBhcmVudCB3ZSBzaG91bGQgc2VlCiAJCSAqIHNvbWV0aGluZyBsaWtl
ICdOU3BpZDoJcGlkCTQyCTEnLgogCQkgKi8KLQkJdGVzdF9jbG9uZTNfc2V0X3RpZChzZXRf
dGlkLCAzLCBDTE9ORV9ORVdQSUQsIDAsIDQyLCB0cnVlKTsKKwkJdGVzdF9jbG9uZTNfc2V0
X3RpZCgidmVyaWZ5IHRoYXQgd2UgaGF2ZSAzIFBJRCBOU3MiLAorCQkJCSAgICBzZXRfdGlk
LCAzLCBDTE9ORV9ORVdQSUQsIDAsIDQyLCB0cnVlKTsKIAogCQljaGlsZF9leGl0KGtzZnRf
Y250LmtzZnRfZmFpbCk7CiAJfQpAQCAtMzgwLDE2ICs0MDUsMTQgQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlrc2Z0X2NudC5rc2Z0X3Bhc3MgKz0gNiAtIChrc2Z0
X2NudC5rc2Z0X2ZhaWwgLSBXRVhJVFNUQVRVUyhzdGF0dXMpKTsKIAlrc2Z0X2NudC5rc2Z0
X2ZhaWwgPSBXRVhJVFNUQVRVUyhzdGF0dXMpOwogCi0JaWYgKG5zMyA9PSBwaWQgJiYgbnMy
ID09IDQyICYmIG5zMSA9PSAxKQotCQlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoCi0JCQkiUElE
cyBpbiBhbGwgbmFtZXNwYWNlcyBhcyBleHBlY3RlZCAoJWQsJWQsJWQpXG4iLAotCQkJbnMz
LCBuczIsIG5zMSk7Ci0JZWxzZQotCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoCi0JCQkiUElE
cyBpbiBhbGwgbmFtZXNwYWNlcyBub3QgYXMgZXhwZWN0ZWQgKCVkLCVkLCVkKVxuIiwKLQkJ
CW5zMywgbnMyLCBuczEpOworCWtzZnRfcHJpbnRfbXNnKCJFeHBlY3RpbmcgUElEcyAlZCwg
NDIsIDFcbiIsIHBpZCk7CisJa3NmdF9wcmludF9tc2coIkhhdmUgUElEcyBpbiBuYW1lc3Bh
Y2VzOiAlZCwgJWQsICVkXG4iLCBuczMsIG5zMiwgbnMxKTsKKwlrc2Z0X3Rlc3RfcmVzdWx0
KG5zMyA9PSBwaWQgJiYgbnMyID09IDQyICYmIG5zMSA9PSAxLAorCQkJICJQSURzIGluIGFs
bCBuYW1lc3BhY2VzIGFzIGV4cGVjdGVkXG4iKTsKIG91dDoKIAlyZXQgPSAwOwogCi0JcmV0
dXJuICFyZXQgPyBrc2Z0X2V4aXRfcGFzcygpIDoga3NmdF9leGl0X2ZhaWwoKTsKKwlpZiAo
cmV0KQorCQlrc2Z0X2V4aXRfZmFpbCgpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jcHVmcmVxL2NwdWZyZXEuc2ggYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jcHVmcmVxL2NwdWZyZXEuc2gKaW5kZXggYjU4M2Ey
ZmI0NTA0Li5hOGIxZGJjMGEzYTUgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2NwdWZyZXEvY3B1ZnJlcS5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9j
cHVmcmVxL2NwdWZyZXEuc2gKQEAgLTE3OCw4ICsxNzgsNyBAQCBjcHVmcmVxX2Jhc2ljX3Rl
c3RzKCkKIAogCWNvdW50PSQoY291bnRfY3B1ZnJlcV9tYW5hZ2VkX2NwdXMpCiAJaWYgWyAk
Y291bnQgPSAwIF07IHRoZW4KLQkJcHJpbnRmICJObyBjcHUgaXMgbWFuYWdlZCBieSBjcHVm
cmVxIGNvcmUsIGV4aXRpbmdcbiIKLQkJZXhpdDsKKwkJa3RhcF9leGl0X2ZhaWxfbXNnICJO
byBjcHUgaXMgbWFuYWdlZCBieSBjcHVmcmVxIGNvcmUsIGV4aXRpbmdcbiIKIAllbHNlCiAJ
CXByaW50ZiAiQ1BVRnJlcSBtYW5hZ2VzOiAkY291bnQgQ1BVc1xuXG4iCiAJZmkKZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbWFpbi5zaCBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbWFpbi5zaAppbmRleCA2MGNlMThlZDA2NjYu
LmEwZWI4NGNmNzE2NyAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY3B1
ZnJlcS9tYWluLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbWFp
bi5zaApAQCAtNywxNSArNywxNSBAQCBzb3VyY2UgZ292ZXJub3Iuc2gKIHNvdXJjZSBtb2R1
bGUuc2gKIHNvdXJjZSBzcGVjaWFsLXRlc3RzLnNoCiAKK0RJUj0iJChkaXJuYW1lICQocmVh
ZGxpbmsgLWYgIiQwIikpIgorc291cmNlICIke0RJUn0iLy4uL2tzZWxmdGVzdC9rdGFwX2hl
bHBlcnMuc2gKKwogRlVOQz1iYXNpYwkjIGRvIGJhc2ljIHRlc3RzIGJ5IGRlZmF1bHQKIE9V
VEZJTEU9Y3B1ZnJlcV9zZWxmdGVzdAogU1lTRlM9CiBDUFVST09UPQogQ1BVRlJFUVJPT1Q9
CiAKLSMgS3NlbGZ0ZXN0IGZyYW1ld29yayByZXF1aXJlbWVudCAtIFNLSVAgY29kZSBpcyA0
Lgota3NmdF9za2lwPTQKLQogaGVscG1lKCkKIHsKIAlwcmludGYgIlVzYWdlOiAkMCBbLWhd
IFstdG9kZyBhcmdzXQpAQCAtMzIsNyArMzIsNyBAQCBoZWxwbWUoKQogCVstZCA8ZHJpdmVy
J3MgbW9kdWxlIG5hbWU6IG9ubHkgd2l0aCBcIi10IG1vZHRlc3Q+XCJdCiAJWy1nIDxnb3Zl
cm5vcidzIG1vZHVsZSBuYW1lOiBvbmx5IHdpdGggXCItdCBtb2R0ZXN0PlwiXQogCVxuIgot
CWV4aXQgMgorCWV4aXQgIiR7S1NGVF9GQUlMfSIKIH0KIAogcHJlcmVxdWlzaXRlKCkKQEAg
LTQwLDggKzQwLDggQEAgcHJlcmVxdWlzaXRlKCkKIAltc2c9InNraXAgYWxsIHRlc3RzOiIK
IAogCWlmIFsgJFVJRCAhPSAwIF07IHRoZW4KLQkJZWNobyAkbXNnIG11c3QgYmUgcnVuIGFz
IHJvb3QgPiYyCi0JCWV4aXQgJGtzZnRfc2tpcAorCQlrdGFwX3NraXBfYWxsICIkbXNnIG11
c3QgYmUgcnVuIGFzIHJvb3QiCisJCWV4aXQgIiR7S1NGVF9TS0lQfSIKIAlmaQogCiAJdGFz
a3NldCAtcCAwMSAkJApAQCAtNDksMjEgKzQ5LDIxIEBAIHByZXJlcXVpc2l0ZSgpCiAJU1lT
RlM9YG1vdW50IC10IHN5c2ZzIHwgaGVhZCAtMSB8IGF3ayAneyBwcmludCAkMyB9J2AKIAog
CWlmIFsgISAtZCAiJFNZU0ZTIiBdOyB0aGVuCi0JCWVjaG8gJG1zZyBzeXNmcyBpcyBub3Qg
bW91bnRlZCA+JjIKLQkJZXhpdCAyCisJCWt0YXBfc2tpcF9hbGwgIiRtc2cgc3lzZnMgaXMg
bm90IG1vdW50ZWQiCisJCWV4aXQgIiR7S1NGVF9TS0lQfSIKIAlmaQogCiAJQ1BVUk9PVD0k
U1lTRlMvZGV2aWNlcy9zeXN0ZW0vY3B1CiAJQ1BVRlJFUVJPT1Q9IiRDUFVST09UL2NwdWZy
ZXEiCiAKIAlpZiAhIGxzICRDUFVST09UL2NwdSogPiAvZGV2L251bGwgMj4mMTsgdGhlbgot
CQllY2hvICRtc2cgY3B1cyBub3QgYXZhaWxhYmxlIGluIHN5c2ZzID4mMgotCQlleGl0IDIK
KwkJa3RhcF9za2lwX2FsbCAiJG1zZyBjcHVzIG5vdCBhdmFpbGFibGUgaW4gc3lzZnMiCisJ
CWV4aXQgIiR7S1NGVF9TS0lQfSIKIAlmaQogCiAJaWYgISBscyAkQ1BVUk9PVC9jcHVmcmVx
ID4gL2Rldi9udWxsIDI+JjE7IHRoZW4KLQkJZWNobyAkbXNnIGNwdWZyZXEgZGlyZWN0b3J5
IG5vdCBhdmFpbGFibGUgaW4gc3lzZnMgPiYyCi0JCWV4aXQgMgorCQlrdGFwX3NraXBfYWxs
ICIkbXNnIGNwdWZyZXEgZGlyZWN0b3J5IG5vdCBhdmFpbGFibGUgaW4gc3lzZnMiCisJCWV4
aXQgIiR7S1NGVF9TS0lQfSIKIAlmaQogfQogCkBAIC0xMDUsOCArMTA1LDcgQEAgZG9fdGVz
dCgpCiAJY291bnQ9JChjb3VudF9jcHVmcmVxX21hbmFnZWRfY3B1cykKIAogCWlmIFsgJGNv
dW50ID0gMCAtYSAkRlVOQyAhPSAibW9kdGVzdCIgXTsgdGhlbgotCQllY2hvICJObyBjcHUg
aXMgbWFuYWdlZCBieSBjcHVmcmVxIGNvcmUsIGV4aXRpbmciCi0JCWV4aXQgMjsKKwkJa3Rh
cF9leGl0X2ZhaWxfbXNnICJObyBjcHUgaXMgbWFuYWdlZCBieSBjcHVmcmVxIGNvcmUsIGV4
aXRpbmciCiAJZmkKIAogCWNhc2UgIiRGVU5DIiBpbgpAQCAtMTI1LDggKzEyNCw3IEBAIGRv
X3Rlc3QoKQogCQkibW9kdGVzdCIpCiAJCSMgRG8gd2UgaGF2ZSBtb2R1bGVzIGluIHBsYWNl
PwogCQlpZiBbIC16ICREUklWRVJfTU9EIF0gJiYgWyAteiAkR09WRVJOT1JfTU9EIF07IHRo
ZW4KLQkJCWVjaG8gIk5vIGRyaXZlciBvciBnb3Zlcm5vciBtb2R1bGUgcGFzc2VkIHdpdGgg
LWQgb3IgLWciCi0JCQlleGl0IDI7CisJCQlrdGFwX2V4aXRfZmFpbF9tc2cgIk5vIGRyaXZl
ciBvciBnb3Zlcm5vciBtb2R1bGUgcGFzc2VkIHdpdGggLWQgb3IgLWciCiAJCWZpCiAKIAkJ
aWYgWyAkRFJJVkVSX01PRCBdOyB0aGVuCkBAIC0xMzcsOCArMTM1LDcgQEAgZG9fdGVzdCgp
CiAJCQlmaQogCQllbHNlCiAJCQlpZiBbICRjb3VudCA9IDAgXTsgdGhlbgotCQkJCWVjaG8g
Ik5vIGNwdSBpcyBtYW5hZ2VkIGJ5IGNwdWZyZXEgY29yZSwgZXhpdGluZyIKLQkJCQlleGl0
IDI7CisJCQkJa3RhcF9leGl0X2ZhaWxfbXNnICJObyBjcHUgaXMgbWFuYWdlZCBieSBjcHVm
cmVxIGNvcmUsIGV4aXRpbmciCiAJCQlmaQogCiAJCQltb2R1bGVfZ292ZXJub3JfdGVzdCAk
R09WRVJOT1JfTU9ECkBAIC0xNjIsNyArMTU5LDcgQEAgZG9fdGVzdCgpCiAJCTs7CiAKIAkJ
KikKLQkJZWNobyAiSW52YWxpZCBbLWZdIGZ1bmN0aW9uIHR5cGUiCisJCWt0YXBfcHJpbnRf
bXNnICJJbnZhbGlkIFstZl0gZnVuY3Rpb24gdHlwZSIKIAkJaGVscG1lCiAJCTs7CiAJZXNh
YwpAQCAtMTg2LDEzICsxODMsMjUgQEAgZG1lc2dfZHVtcHMoKQogCWRtZXNnID4+ICQxLmRt
ZXNnX2Z1bGwudHh0CiB9CiAKK2t0YXBfcHJpbnRfaGVhZGVyCisKICMgUGFyc2UgYXJndW1l
bnRzCiBwYXJzZV9hcmd1bWVudHMgJEAKIAora3RhcF9zZXRfcGxhbiAxCisKICMgTWFrZSBz
dXJlIGFsbCByZXF1aXJlbWVudHMgYXJlIG1ldAogcHJlcmVxdWlzaXRlCiAKICMgUnVuIHJl
cXVlc3RlZCBmdW5jdGlvbnMKIGNsZWFyX2R1bXBzICRPVVRGSUxFCiBkb190ZXN0IHwgdGVl
IC1hICRPVVRGSUxFLnR4dAoraWYgWyAiJHtQSVBFU1RBVFVTWzBdfSIgLW5lIDAgXTsgdGhl
bgorICAgIGV4aXQgJHtQSVBFU1RBVFVTWzBdfTsKK2ZpCiBkbWVzZ19kdW1wcyAkT1VURklM
RQorCitrdGFwX3Rlc3RfcGFzcyAiQ29tcGxldGVkIHN1Y2Nlc3NmdWxseSIKKwora3RhcF9w
cmludF90b3RhbHMKK2V4aXQgIiR7S1NGVF9QQVNTfSIKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbW9kdWxlLnNoIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvY3B1ZnJlcS9tb2R1bGUuc2gKaW5kZXggMjI1NjNjZDEyMmU3Li43ZjI2NjdlMGFl
MmQgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbW9kdWxl
LnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvbW9kdWxlLnNoCkBA
IC0yNCwxNiArMjQsMTQgQEAgdGVzdF9iYXNpY19pbnNtb2Rfcm1tb2QoKQogCSMgaW5zZXJ0
IG1vZHVsZQogCWluc21vZCAkMQogCWlmIFsgJD8gIT0gMCBdOyB0aGVuCi0JCXByaW50ZiAi
SW5zbW9kICQxIGZhaWxlZFxuIgotCQlleGl0OworCQlrdGFwX2V4aXRfZmFpbF9tc2cgIklu
c21vZCAkMSBmYWlsZWRcbiIKIAlmaQogCiAJcHJpbnRmICJSZW1vdmluZyAkMSBtb2R1bGVc
biIKIAkjIHJlbW92ZSBtb2R1bGUKIAlybW1vZCAkMQogCWlmIFsgJD8gIT0gMCBdOyB0aGVu
Ci0JCXByaW50ZiAicm1tb2QgJDEgZmFpbGVkXG4iCi0JCWV4aXQ7CisJCWt0YXBfZXhpdF9m
YWlsX21zZyAicm1tb2QgJDEgZmFpbGVkXG4iCiAJZmkKIAogCXByaW50ZiAiXG4iCmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFidWYtaGVhcHMvZG1hYnVmLWhl
YXAuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYWJ1Zi1oZWFwcy9kbWFidWYtaGVh
cC5jCmluZGV4IDg5MGE4MjM2YThiYS4uNWY1NDE1MjIzNjRmIDEwMDY0NAotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFidWYtaGVhcHMvZG1hYnVmLWhlYXAuYworKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFidWYtaGVhcHMvZG1hYnVmLWhlYXAuYwpAQCAt
MTUsNiArMTUsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4KICNpbmNsdWRlIDxs
aW51eC9kbWEtaGVhcC5oPgogI2luY2x1ZGUgPGRybS9kcm0uaD4KKyNpbmNsdWRlICIuLi9r
c2VsZnRlc3QuaCIKIAogI2RlZmluZSBERVZQQVRIICIvZGV2L2RtYV9oZWFwIgogCkBAIC05
MCwxNCArOTEsMTMgQEAgc3RhdGljIGludCBkbWFidWZfaGVhcF9vcGVuKGNoYXIgKm5hbWUp
CiAJY2hhciBidWZbMjU2XTsKIAogCXJldCA9IHNucHJpbnRmKGJ1ZiwgMjU2LCAiJXMvJXMi
LCBERVZQQVRILCBuYW1lKTsKLQlpZiAocmV0IDwgMCkgewotCQlwcmludGYoInNucHJpbnRm
IGZhaWxlZCFcbiIpOwotCQlyZXR1cm4gcmV0OwotCX0KKwlpZiAocmV0IDwgMCkKKwkJa3Nm
dF9leGl0X2ZhaWxfbXNnKCJzbnByaW50ZiBmYWlsZWQhICVkXG4iLCByZXQpOwogCiAJZmQg
PSBvcGVuKGJ1ZiwgT19SRFdSKTsKIAlpZiAoZmQgPCAwKQotCQlwcmludGYoIm9wZW4gJXMg
ZmFpbGVkIVxuIiwgYnVmKTsKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJvcGVuICVzIGZhaWxl
ZDogJXNcbiIsIGJ1Ziwgc3RyZXJyb3IoZXJybm8pKTsKKwogCXJldHVybiBmZDsKIH0KIApA
QCAtMTQwLDcgKzE0MCw3IEBAIHN0YXRpYyBpbnQgZG1hYnVmX3N5bmMoaW50IGZkLCBpbnQg
c3RhcnRfc3RvcCkKIAogI2RlZmluZSBPTkVfTUVHICgxMDI0ICogMTAyNCkKIAotc3RhdGlj
IGludCB0ZXN0X2FsbG9jX2FuZF9pbXBvcnQoY2hhciAqaGVhcF9uYW1lKQorc3RhdGljIHZv
aWQgdGVzdF9hbGxvY19hbmRfaW1wb3J0KGNoYXIgKmhlYXBfbmFtZSkKIHsKIAlpbnQgaGVh
cF9mZCA9IC0xLCBkbWFidWZfZmQgPSAtMSwgaW1wb3J0ZXJfZmQgPSAtMTsKIAl1aW50MzJf
dCBoYW5kbGUgPSAwOwpAQCAtMTQ4LDI3ICsxNDgsMTkgQEAgc3RhdGljIGludCB0ZXN0X2Fs
bG9jX2FuZF9pbXBvcnQoY2hhciAqaGVhcF9uYW1lKQogCWludCByZXQ7CiAKIAloZWFwX2Zk
ID0gZG1hYnVmX2hlYXBfb3BlbihoZWFwX25hbWUpOwotCWlmIChoZWFwX2ZkIDwgMCkKLQkJ
cmV0dXJuIC0xOwogCi0JcHJpbnRmKCIgIFRlc3RpbmcgYWxsb2NhdGlvbiBhbmQgaW1wb3J0
aW5nOiAgIik7CisJa3NmdF9wcmludF9tc2coIlRlc3RpbmcgYWxsb2NhdGlvbiBhbmQgaW1w
b3J0aW5nOlxuIik7CiAJcmV0ID0gZG1hYnVmX2hlYXBfYWxsb2MoaGVhcF9mZCwgT05FX01F
RywgMCwgJmRtYWJ1Zl9mZCk7CiAJaWYgKHJldCkgewotCQlwcmludGYoIkZBSUwgKEFsbG9j
YXRpb24gRmFpbGVkISlcbiIpOwotCQlyZXQgPSAtMTsKLQkJZ290byBvdXQ7CisJCWtzZnRf
dGVzdF9yZXN1bHRfZmFpbCgiRkFJTCAoQWxsb2NhdGlvbiBGYWlsZWQhKSAlZFxuIiwgcmV0
KTsKKwkJcmV0dXJuOwogCX0KKwogCS8qIG1tYXAgYW5kIHdyaXRlIGEgc2ltcGxlIHBhdHRl
cm4gKi8KLQlwID0gbW1hcChOVUxMLAotCQkgT05FX01FRywKLQkJIFBST1RfUkVBRCB8IFBS
T1RfV1JJVEUsCi0JCSBNQVBfU0hBUkVELAotCQkgZG1hYnVmX2ZkLAotCQkgMCk7CisJcCA9
IG1tYXAoTlVMTCwgT05FX01FRywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJF
RCwgZG1hYnVmX2ZkLCAwKTsKIAlpZiAocCA9PSBNQVBfRkFJTEVEKSB7Ci0JCXByaW50Zigi
RkFJTCAobW1hcCgpIGZhaWxlZClcbiIpOwotCQlyZXQgPSAtMTsKLQkJZ290byBvdXQ7CisJ
CWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiRkFJTCAobW1hcCgpIGZhaWxlZCk6ICVzXG4iLCBz
dHJlcnJvcihlcnJubykpOworCQlnb3RvIGNsb3NlX2FuZF9yZXR1cm47CiAJfQogCiAJZG1h
YnVmX3N5bmMoZG1hYnVmX2ZkLCBETUFfQlVGX1NZTkNfU1RBUlQpOwpAQCAtMTc4LDcxICsx
NzAsNjQgQEAgc3RhdGljIGludCB0ZXN0X2FsbG9jX2FuZF9pbXBvcnQoY2hhciAqaGVhcF9u
YW1lKQogCiAJaW1wb3J0ZXJfZmQgPSBvcGVuX3ZnZW0oKTsKIAlpZiAoaW1wb3J0ZXJfZmQg
PCAwKSB7Ci0JCXJldCA9IGltcG9ydGVyX2ZkOwotCQlwcmludGYoIihDb3VsZCBub3Qgb3Bl
biB2Z2VtIC0gc2tpcHBpbmcpOiAgIik7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgiQ291
bGQgbm90IG9wZW4gdmdlbSAlZFxuIiwgaW1wb3J0ZXJfZmQpOwogCX0gZWxzZSB7CiAJCXJl
dCA9IGltcG9ydF92Z2VtX2ZkKGltcG9ydGVyX2ZkLCBkbWFidWZfZmQsICZoYW5kbGUpOwot
CQlpZiAocmV0IDwgMCkgewotCQkJcHJpbnRmKCJGQUlMIChGYWlsZWQgdG8gaW1wb3J0IGJ1
ZmZlcilcbiIpOwotCQkJZ290byBvdXQ7Ci0JCX0KKwkJa3NmdF90ZXN0X3Jlc3VsdChyZXQg
Pj0gMCwgIkltcG9ydCBidWZmZXIgJWRcbiIsIHJldCk7CiAJfQogCiAJcmV0ID0gZG1hYnVm
X3N5bmMoZG1hYnVmX2ZkLCBETUFfQlVGX1NZTkNfU1RBUlQpOwogCWlmIChyZXQgPCAwKSB7
Ci0JCXByaW50ZigiRkFJTCAoRE1BX0JVRl9TWU5DX1NUQVJUIGZhaWxlZCEpXG4iKTsKKwkJ
a3NmdF9wcmludF9tc2coIkZBSUwgKERNQV9CVUZfU1lOQ19TVEFSVCBmYWlsZWQhKSAlZFxu
IiwgcmV0KTsKIAkJZ290byBvdXQ7CiAJfQogCiAJbWVtc2V0KHAsIDB4ZmYsIE9ORV9NRUcp
OwogCXJldCA9IGRtYWJ1Zl9zeW5jKGRtYWJ1Zl9mZCwgRE1BX0JVRl9TWU5DX0VORCk7CiAJ
aWYgKHJldCA8IDApIHsKLQkJcHJpbnRmKCJGQUlMIChETUFfQlVGX1NZTkNfRU5EIGZhaWxl
ZCEpXG4iKTsKKwkJa3NmdF9wcmludF9tc2coIkZBSUwgKERNQV9CVUZfU1lOQ19FTkQgZmFp
bGVkISkgJWRcbiIsIHJldCk7CiAJCWdvdG8gb3V0OwogCX0KIAogCWNsb3NlX2hhbmRsZShp
bXBvcnRlcl9mZCwgaGFuZGxlKTsKLQlyZXQgPSAwOwotCXByaW50ZigiIE9LXG4iKTsKKwlr
c2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoIiVzIGRtYWJ1ZiBzeW5jIHN1Y2NlZWRlZFxuIiwgX19m
dW5jX18pOworCXJldHVybjsKKwogb3V0OgotCWlmIChwKQotCQltdW5tYXAocCwgT05FX01F
Ryk7Ci0JaWYgKGltcG9ydGVyX2ZkID49IDApCi0JCWNsb3NlKGltcG9ydGVyX2ZkKTsKLQlp
ZiAoZG1hYnVmX2ZkID49IDApCi0JCWNsb3NlKGRtYWJ1Zl9mZCk7Ci0JaWYgKGhlYXBfZmQg
Pj0gMCkKLQkJY2xvc2UoaGVhcF9mZCk7CisJa3NmdF90ZXN0X3Jlc3VsdF9mYWlsKCIlcyBk
bWFidWYgc3luYyBmYWlsZWRcbiIsIF9fZnVuY19fKTsKKwltdW5tYXAocCwgT05FX01FRyk7
CisJY2xvc2UoaW1wb3J0ZXJfZmQpOwogCi0JcmV0dXJuIHJldDsKK2Nsb3NlX2FuZF9yZXR1
cm46CisJY2xvc2UoZG1hYnVmX2ZkKTsKKwljbG9zZShoZWFwX2ZkKTsKIH0KIAotc3RhdGlj
IGludCB0ZXN0X2FsbG9jX3plcm9lZChjaGFyICpoZWFwX25hbWUsIHNpemVfdCBzaXplKQor
c3RhdGljIHZvaWQgdGVzdF9hbGxvY196ZXJvZWQoY2hhciAqaGVhcF9uYW1lLCBzaXplX3Qg
c2l6ZSkKIHsKIAlpbnQgaGVhcF9mZCA9IC0xLCBkbWFidWZfZmRbMzJdOwotCWludCBpLCBq
LCByZXQ7CisJaW50IGksIGosIGssIHJldDsKIAl2b2lkICpwID0gTlVMTDsKIAljaGFyICpj
OwogCi0JcHJpbnRmKCIgIFRlc3RpbmcgYWxsb2NlZCAlbGRrIGJ1ZmZlcnMgYXJlIHplcm9l
ZDogICIsIHNpemUgLyAxMDI0KTsKKwlrc2Z0X3ByaW50X21zZygiVGVzdGluZyBhbGxvY2Vk
ICVsZGsgYnVmZmVycyBhcmUgemVyb2VkOlxuIiwgc2l6ZSAvIDEwMjQpOwogCWhlYXBfZmQg
PSBkbWFidWZfaGVhcF9vcGVuKGhlYXBfbmFtZSk7Ci0JaWYgKGhlYXBfZmQgPCAwKQotCQly
ZXR1cm4gLTE7CiAKIAkvKiBBbGxvY2F0ZSBhbmQgZmlsbCBhIGJ1bmNoIG9mIGJ1ZmZlcnMg
Ki8KIAlmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgewogCQlyZXQgPSBkbWFidWZfaGVhcF9h
bGxvYyhoZWFwX2ZkLCBzaXplLCAwLCAmZG1hYnVmX2ZkW2ldKTsKLQkJaWYgKHJldCA8IDAp
IHsKLQkJCXByaW50ZigiRkFJTCAoQWxsb2NhdGlvbiAoJWkpIGZhaWxlZClcbiIsIGkpOwot
CQkJZ290byBvdXQ7CisJCWlmIChyZXQpIHsKKwkJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgi
RkFJTCAoQWxsb2NhdGlvbiAoJWkpIGZhaWxlZCkgJWRcbiIsIGksIHJldCk7CisJCQlnb3Rv
IGNsb3NlX2FuZF9yZXR1cm47CiAJCX0KKwogCQkvKiBtbWFwIGFuZCBmaWxsIHdpdGggc2lt
cGxlIHBhdHRlcm4gKi8KIAkJcCA9IG1tYXAoTlVMTCwgc2l6ZSwgUFJPVF9SRUFEIHwgUFJP
VF9XUklURSwgTUFQX1NIQVJFRCwgZG1hYnVmX2ZkW2ldLCAwKTsKIAkJaWYgKHAgPT0gTUFQ
X0ZBSUxFRCkgewotCQkJcHJpbnRmKCJGQUlMIChtbWFwKCkgZmFpbGVkISlcbiIpOwotCQkJ
cmV0ID0gLTE7Ci0JCQlnb3RvIG91dDsKKwkJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiRkFJ
TCAobW1hcCgpIGZhaWxlZCEpOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKKwkJCWdvdG8g
Y2xvc2VfYW5kX3JldHVybjsKIAkJfQorCiAJCWRtYWJ1Zl9zeW5jKGRtYWJ1Zl9mZFtpXSwg
RE1BX0JVRl9TWU5DX1NUQVJUKTsKIAkJbWVtc2V0KHAsIDB4ZmYsIHNpemUpOwogCQlkbWFi
dWZfc3luYyhkbWFidWZfZmRbaV0sIERNQV9CVUZfU1lOQ19FTkQpOwpAQCAtMjUxLDQ4ICsy
MzYsNDcgQEAgc3RhdGljIGludCB0ZXN0X2FsbG9jX3plcm9lZChjaGFyICpoZWFwX25hbWUs
IHNpemVfdCBzaXplKQogCS8qIGNsb3NlIHRoZW0gYWxsICovCiAJZm9yIChpID0gMDsgaSA8
IDMyOyBpKyspCiAJCWNsb3NlKGRtYWJ1Zl9mZFtpXSk7CisJa3NmdF90ZXN0X3Jlc3VsdF9w
YXNzKCJBbGxvY2F0ZSBhbmQgZmlsbCBhIGJ1bmNoIG9mIGJ1ZmZlcnNcbiIpOwogCiAJLyog
QWxsb2NhdGUgYW5kIHZhbGlkYXRlIGFsbCBidWZmZXJzIGFyZSB6ZXJvZWQgKi8KIAlmb3Ig
KGkgPSAwOyBpIDwgMzI7IGkrKykgewogCQlyZXQgPSBkbWFidWZfaGVhcF9hbGxvYyhoZWFw
X2ZkLCBzaXplLCAwLCAmZG1hYnVmX2ZkW2ldKTsKIAkJaWYgKHJldCA8IDApIHsKLQkJCXBy
aW50ZigiRkFJTCAoQWxsb2NhdGlvbiAoJWkpIGZhaWxlZClcbiIsIGkpOwotCQkJZ290byBv
dXQ7CisJCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoIkZBSUwgKEFsbG9jYXRpb24gKCVpKSBm
YWlsZWQpICVkXG4iLCBpLCByZXQpOworCQkJZ290byBjbG9zZV9hbmRfcmV0dXJuOwogCQl9
CiAKIAkJLyogbW1hcCBhbmQgdmFsaWRhdGUgZXZlcnl0aGluZyBpcyB6ZXJvICovCiAJCXAg
PSBtbWFwKE5VTEwsIHNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQs
IGRtYWJ1Zl9mZFtpXSwgMCk7CiAJCWlmIChwID09IE1BUF9GQUlMRUQpIHsKLQkJCXByaW50
ZigiRkFJTCAobW1hcCgpIGZhaWxlZCEpXG4iKTsKLQkJCXJldCA9IC0xOwotCQkJZ290byBv
dXQ7CisJCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoIkZBSUwgKG1tYXAoKSBmYWlsZWQhKTog
JXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CisJCQlnb3RvIGNsb3NlX2FuZF9yZXR1cm47CiAJ
CX0KKwogCQlkbWFidWZfc3luYyhkbWFidWZfZmRbaV0sIERNQV9CVUZfU1lOQ19TVEFSVCk7
CiAJCWMgPSAoY2hhciAqKXA7CiAJCWZvciAoaiA9IDA7IGogPCBzaXplOyBqKyspIHsKIAkJ
CWlmIChjW2pdICE9IDApIHsKLQkJCQlwcmludGYoIkZBSUwgKEFsbG9jYXRlZCBidWZmZXIg
bm90IHplcm9lZCBAICVpKVxuIiwgaik7Ci0JCQkJYnJlYWs7CisJCQkJa3NmdF9wcmludF9t
c2coIkZBSUwgKEFsbG9jYXRlZCBidWZmZXIgbm90IHplcm9lZCBAICVpKVxuIiwgaik7CisJ
CQkJZG1hYnVmX3N5bmMoZG1hYnVmX2ZkW2ldLCBETUFfQlVGX1NZTkNfRU5EKTsKKwkJCQlt
dW5tYXAocCwgc2l6ZSk7CisJCQkJZ290byBvdXQ7CiAJCQl9CiAJCX0KIAkJZG1hYnVmX3N5
bmMoZG1hYnVmX2ZkW2ldLCBETUFfQlVGX1NZTkNfRU5EKTsKIAkJbXVubWFwKHAsIHNpemUp
OwogCX0KLQkvKiBjbG9zZSB0aGVtIGFsbCAqLwotCWZvciAoaSA9IDA7IGkgPCAzMjsgaSsr
KQotCQljbG9zZShkbWFidWZfZmRbaV0pOwotCi0JY2xvc2UoaGVhcF9mZCk7Ci0JcHJpbnRm
KCJPS1xuIik7Ci0JcmV0dXJuIDA7CiAKIG91dDoKLQl3aGlsZSAoaSA+IDApIHsKLQkJY2xv
c2UoZG1hYnVmX2ZkW2ldKTsKLQkJaS0tOwotCX0KKwlrc2Z0X3Rlc3RfcmVzdWx0KGkgPT0g
MzIsICJBbGxvY2F0ZSBhbmQgdmFsaWRhdGUgYWxsIGJ1ZmZlcnMgYXJlIHplcm9lZFxuIik7
CisKK2Nsb3NlX2FuZF9yZXR1cm46CisJLyogY2xvc2UgdGhlbSBhbGwgKi8KKwlmb3IgKGsg
PSAwOyBrIDwgaTsgaysrKQorCQljbG9zZShkbWFidWZfZmRba10pOworCiAJY2xvc2UoaGVh
cF9mZCk7Ci0JcmV0dXJuIHJldDsKKwlyZXR1cm47CiB9CiAKIC8qIFRlc3QgdGhlIGlvY3Rs
IHZlcnNpb24gY29tcGF0aWJpbGl0eSB3LyBhIHNtYWxsZXIgc3RydWN0dXJlIHRoZW4gZXhw
ZWN0ZWQgKi8KQEAgLTM2MCwxMjYgKzM0NCw5NyBAQCBzdGF0aWMgaW50IGRtYWJ1Zl9oZWFw
X2FsbG9jX25ld2VyKGludCBmZCwgc2l6ZV90IGxlbiwgdW5zaWduZWQgaW50IGZsYWdzLAog
CXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgdGVzdF9hbGxvY19jb21wYXQoY2hhciAq
aGVhcF9uYW1lKQorc3RhdGljIHZvaWQgdGVzdF9hbGxvY19jb21wYXQoY2hhciAqaGVhcF9u
YW1lKQogewotCWludCBoZWFwX2ZkID0gLTEsIGRtYWJ1Zl9mZCA9IC0xOwotCWludCByZXQ7
CisJaW50IHJldCwgaGVhcF9mZCA9IC0xLCBkbWFidWZfZmQgPSAtMTsKIAogCWhlYXBfZmQg
PSBkbWFidWZfaGVhcF9vcGVuKGhlYXBfbmFtZSk7Ci0JaWYgKGhlYXBfZmQgPCAwKQotCQly
ZXR1cm4gLTE7CiAKLQlwcmludGYoIiAgVGVzdGluZyAodGhlb3JldGljYWwpb2xkZXIgYWxs
b2MgY29tcGF0OiAgIik7CisJa3NmdF9wcmludF9tc2coIlRlc3RpbmcgKHRoZW9yZXRpY2Fs
KSBvbGRlciBhbGxvYyBjb21wYXQ6XG4iKTsKIAlyZXQgPSBkbWFidWZfaGVhcF9hbGxvY19v
bGRlcihoZWFwX2ZkLCBPTkVfTUVHLCAwLCAmZG1hYnVmX2ZkKTsKLQlpZiAocmV0KSB7Ci0J
CXByaW50ZigiRkFJTCAoT2xkZXIgY29tcGF0IGFsbG9jYXRpb24gZmFpbGVkISlcbiIpOwot
CQlyZXQgPSAtMTsKLQkJZ290byBvdXQ7Ci0JfQotCWNsb3NlKGRtYWJ1Zl9mZCk7Ci0JcHJp
bnRmKCJPS1xuIik7CisJaWYgKGRtYWJ1Zl9mZCA+PSAwKQorCQljbG9zZShkbWFidWZfZmQp
OworCWtzZnRfdGVzdF9yZXN1bHQoIXJldCwgImRtYWJ1Zl9oZWFwX2FsbG9jX29sZGVyXG4i
KTsKIAotCXByaW50ZigiICBUZXN0aW5nICh0aGVvcmV0aWNhbCluZXdlciBhbGxvYyBjb21w
YXQ6ICAiKTsKKwlrc2Z0X3ByaW50X21zZygiVGVzdGluZyAodGhlb3JldGljYWwpIG5ld2Vy
IGFsbG9jIGNvbXBhdDpcbiIpOwogCXJldCA9IGRtYWJ1Zl9oZWFwX2FsbG9jX25ld2VyKGhl
YXBfZmQsIE9ORV9NRUcsIDAsICZkbWFidWZfZmQpOwotCWlmIChyZXQpIHsKLQkJcHJpbnRm
KCJGQUlMIChOZXdlciBjb21wYXQgYWxsb2NhdGlvbiBmYWlsZWQhKVxuIik7Ci0JCXJldCA9
IC0xOwotCQlnb3RvIG91dDsKLQl9Ci0JcHJpbnRmKCJPS1xuIik7Ci1vdXQ6CiAJaWYgKGRt
YWJ1Zl9mZCA+PSAwKQogCQljbG9zZShkbWFidWZfZmQpOwotCWlmIChoZWFwX2ZkID49IDAp
Ci0JCWNsb3NlKGhlYXBfZmQpOworCWtzZnRfdGVzdF9yZXN1bHQoIXJldCwgImRtYWJ1Zl9o
ZWFwX2FsbG9jX25ld2VyXG4iKTsKIAotCXJldHVybiByZXQ7CisJY2xvc2UoaGVhcF9mZCk7
CiB9CiAKLXN0YXRpYyBpbnQgdGVzdF9hbGxvY19lcnJvcnMoY2hhciAqaGVhcF9uYW1lKQor
c3RhdGljIHZvaWQgdGVzdF9hbGxvY19lcnJvcnMoY2hhciAqaGVhcF9uYW1lKQogewogCWlu
dCBoZWFwX2ZkID0gLTEsIGRtYWJ1Zl9mZCA9IC0xOwogCWludCByZXQ7CiAKIAloZWFwX2Zk
ID0gZG1hYnVmX2hlYXBfb3BlbihoZWFwX25hbWUpOwotCWlmIChoZWFwX2ZkIDwgMCkKLQkJ
cmV0dXJuIC0xOwogCi0JcHJpbnRmKCIgIFRlc3RpbmcgZXhwZWN0ZWQgZXJyb3IgY2FzZXM6
ICAiKTsKKwlrc2Z0X3ByaW50X21zZygiVGVzdGluZyBleHBlY3RlZCBlcnJvciBjYXNlczpc
biIpOwogCXJldCA9IGRtYWJ1Zl9oZWFwX2FsbG9jKDAsIE9ORV9NRUcsIDB4MTExMTExLCAm
ZG1hYnVmX2ZkKTsKLQlpZiAoIXJldCkgewotCQlwcmludGYoIkZBSUwgKERpZCBub3Qgc2Vl
IGV4cGVjdGVkIGVycm9yIChpbnZhbGlkIGZkKSEpXG4iKTsKLQkJcmV0ID0gLTE7Ci0JCWdv
dG8gb3V0OwotCX0KKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCwgIkVycm9yIGV4cGVjdGVkIG9u
IGludmFsaWQgZmQgJWRcbiIsIHJldCk7CiAKIAlyZXQgPSBkbWFidWZfaGVhcF9hbGxvYyho
ZWFwX2ZkLCBPTkVfTUVHLCAweDExMTExMSwgJmRtYWJ1Zl9mZCk7Ci0JaWYgKCFyZXQpIHsK
LQkJcHJpbnRmKCJGQUlMIChEaWQgbm90IHNlZSBleHBlY3RlZCBlcnJvciAoaW52YWxpZCBo
ZWFwIGZsYWdzKSEpXG4iKTsKLQkJcmV0ID0gLTE7Ci0JCWdvdG8gb3V0OwotCX0KKwlrc2Z0
X3Rlc3RfcmVzdWx0KHJldCwgIkVycm9yIGV4cGVjdGVkIG9uIGludmFsaWQgaGVhcCBmbGFn
cyAlZFxuIiwgcmV0KTsKIAogCXJldCA9IGRtYWJ1Zl9oZWFwX2FsbG9jX2ZkZmxhZ3MoaGVh
cF9mZCwgT05FX01FRywKIAkJCQkJfihPX1JEV1IgfCBPX0NMT0VYRUMpLCAwLCAmZG1hYnVm
X2ZkKTsKLQlpZiAoIXJldCkgewotCQlwcmludGYoIkZBSUwgKERpZCBub3Qgc2VlIGV4cGVj
dGVkIGVycm9yIChpbnZhbGlkIGZkIGZsYWdzKSEpXG4iKTsKLQkJcmV0ID0gLTE7Ci0JCWdv
dG8gb3V0OwotCX0KKwlrc2Z0X3Rlc3RfcmVzdWx0KHJldCwgIkVycm9yIGV4cGVjdGVkIG9u
IGludmFsaWQgaGVhcCBmbGFncyAlZFxuIiwgcmV0KTsKIAotCXByaW50ZigiT0tcbiIpOwot
CXJldCA9IDA7Ci1vdXQ6CiAJaWYgKGRtYWJ1Zl9mZCA+PSAwKQogCQljbG9zZShkbWFidWZf
ZmQpOwotCWlmIChoZWFwX2ZkID49IDApCi0JCWNsb3NlKGhlYXBfZmQpOworCWNsb3NlKGhl
YXBfZmQpOworfQogCi0JcmV0dXJuIHJldDsKK3N0YXRpYyBpbnQgbnVtZXJfb2ZfaGVhcHMo
dm9pZCkKK3sKKwlESVIgKmQgPSBvcGVuZGlyKERFVlBBVEgpOworCXN0cnVjdCBkaXJlbnQg
KmRpcjsKKwlpbnQgaGVhcHMgPSAwOworCisJd2hpbGUgKChkaXIgPSByZWFkZGlyKGQpKSkg
eworCQlpZiAoIXN0cm5jbXAoZGlyLT5kX25hbWUsICIuIiwgMikpCisJCQljb250aW51ZTsK
KwkJaWYgKCFzdHJuY21wKGRpci0+ZF9uYW1lLCAiLi4iLCAzKSkKKwkJCWNvbnRpbnVlOwor
CQloZWFwcysrOworCX0KKworCXJldHVybiBoZWFwczsKIH0KIAogaW50IG1haW4odm9pZCkK
IHsKLQlESVIgKmQ7CiAJc3RydWN0IGRpcmVudCAqZGlyOwotCWludCByZXQgPSAtMTsKKwlE
SVIgKmQ7CisKKwlrc2Z0X3ByaW50X2hlYWRlcigpOwogCiAJZCA9IG9wZW5kaXIoREVWUEFU
SCk7CiAJaWYgKCFkKSB7Ci0JCXByaW50ZigiTm8gJXMgZGlyZWN0b3J5P1xuIiwgREVWUEFU
SCk7Ci0JCXJldHVybiAtMTsKKwkJa3NmdF9wcmludF9tc2coIk5vICVzIGRpcmVjdG9yeT9c
biIsIERFVlBBVEgpOworCQlyZXR1cm4gS1NGVF9TS0lQOwogCX0KIAotCXdoaWxlICgoZGly
ID0gcmVhZGRpcihkKSkgIT0gTlVMTCkgeworCWtzZnRfc2V0X3BsYW4oMTEgKiBudW1lcl9v
Zl9oZWFwcygpKTsKKworCXdoaWxlICgoZGlyID0gcmVhZGRpcihkKSkpIHsKIAkJaWYgKCFz
dHJuY21wKGRpci0+ZF9uYW1lLCAiLiIsIDIpKQogCQkJY29udGludWU7CiAJCWlmICghc3Ry
bmNtcChkaXItPmRfbmFtZSwgIi4uIiwgMykpCiAJCQljb250aW51ZTsKIAotCQlwcmludGYo
IlRlc3RpbmcgaGVhcDogJXNcbiIsIGRpci0+ZF9uYW1lKTsKLQkJcHJpbnRmKCI9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT1cbiIpOwotCQlyZXQgPSB0ZXN0X2Fs
bG9jX2FuZF9pbXBvcnQoZGlyLT5kX25hbWUpOwotCQlpZiAocmV0KQotCQkJYnJlYWs7Ci0K
LQkJcmV0ID0gdGVzdF9hbGxvY196ZXJvZWQoZGlyLT5kX25hbWUsIDQgKiAxMDI0KTsKLQkJ
aWYgKHJldCkKLQkJCWJyZWFrOwotCi0JCXJldCA9IHRlc3RfYWxsb2NfemVyb2VkKGRpci0+
ZF9uYW1lLCBPTkVfTUVHKTsKLQkJaWYgKHJldCkKLQkJCWJyZWFrOwotCi0JCXJldCA9IHRl
c3RfYWxsb2NfY29tcGF0KGRpci0+ZF9uYW1lKTsKLQkJaWYgKHJldCkKLQkJCWJyZWFrOwot
Ci0JCXJldCA9IHRlc3RfYWxsb2NfZXJyb3JzKGRpci0+ZF9uYW1lKTsKLQkJaWYgKHJldCkK
LQkJCWJyZWFrOworCQlrc2Z0X3ByaW50X21zZygiVGVzdGluZyBoZWFwOiAlc1xuIiwgZGly
LT5kX25hbWUpOworCQlrc2Z0X3ByaW50X21zZygiPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09XG4iKTsKKwkJdGVzdF9hbGxvY19hbmRfaW1wb3J0KGRpci0+ZF9u
YW1lKTsKKwkJdGVzdF9hbGxvY196ZXJvZWQoZGlyLT5kX25hbWUsIDQgKiAxMDI0KTsKKwkJ
dGVzdF9hbGxvY196ZXJvZWQoZGlyLT5kX25hbWUsIE9ORV9NRUcpOworCQl0ZXN0X2FsbG9j
X2NvbXBhdChkaXItPmRfbmFtZSk7CisJCXRlc3RfYWxsb2NfZXJyb3JzKGRpci0+ZF9uYW1l
KTsKIAl9CiAJY2xvc2VkaXIoZCk7CiAKLQlyZXR1cm4gcmV0OworCWtzZnRfZmluaXNoZWQo
KTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2V4ZWMvcmVjdXJz
aW9uLWRlcHRoLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9leGVjL3JlY3Vyc2lvbi1k
ZXB0aC5jCmluZGV4IGIyZjM3ZDg2YTVmNi4uNDM4YzhmZjJmZDI2IDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9leGVjL3JlY3Vyc2lvbi1kZXB0aC5jCisrKyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2V4ZWMvcmVjdXJzaW9uLWRlcHRoLmMKQEAgLTM3LDI1
ICszNywyNSBAQCBpbnQgbWFpbih2b2lkKQogCQkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJl
cnJvcjogdW5zaGFyZSwgZXJybm8gJWRcbiIsIGVycm5vKTsKIAkJCWtzZnRfZmluaXNoZWQo
KTsKIAkJfQotCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yOiB1bnNoYXJlLCBlcnJubyAl
ZFxuIiwgZXJybm8pOworCQlrc2Z0X2V4aXRfZmFpbF9wZXJyb3IoImVycm9yOiB1bnNoYXJl
Iik7CiAJfQogCiAJaWYgKG1vdW50KE5VTEwsICIvIiwgTlVMTCwgTVNfUFJJVkFURSB8IE1T
X1JFQywgTlVMTCkgPT0gLTEpCi0JCWtzZnRfZXhpdF9mYWlsX21zZygiZXJyb3I6IG1vdW50
ICcvJywgZXJybm8gJWRcbiIsIGVycm5vKTsKKwkJa3NmdF9leGl0X2ZhaWxfcGVycm9yKCJl
cnJvcjogbW91bnQgJy8nIik7CiAKIAkvKiBSZXF1aXJlICJleGVjIiBmaWxlc3lzdGVtLiAq
LwogCWlmIChtb3VudChOVUxMLCAiL3RtcCIsICJyYW1mcyIsIDAsIE5VTEwpID09IC0xKQot
CQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9yOiBtb3VudCByYW1mcywgZXJybm8gJWRcbiIs
IGVycm5vKTsKKwkJa3NmdF9leGl0X2ZhaWxfcGVycm9yKCJlcnJvcjogbW91bnQgcmFtZnMi
KTsKIAogI2RlZmluZSBGSUxFTkFNRSAiL3RtcC8xIgogCiAJZmQgPSBjcmVhdChGSUxFTkFN
RSwgMDcwMCk7CiAJaWYgKGZkID09IC0xKQotCQlrc2Z0X2V4aXRfZmFpbF9tc2coImVycm9y
OiBjcmVhdCwgZXJybm8gJWRcbiIsIGVycm5vKTsKKwkJa3NmdF9leGl0X2ZhaWxfcGVycm9y
KCJlcnJvcjogY3JlYXQiKTsKIAogI2RlZmluZSBTICIjISIgRklMRU5BTUUgIlxuIgogCWlm
ICh3cml0ZShmZCwgUywgc3RybGVuKFMpKSAhPSBzdHJsZW4oUykpCi0JCWtzZnRfZXhpdF9m
YWlsX21zZygiZXJyb3I6IHdyaXRlLCBlcnJubyAlZFxuIiwgZXJybm8pOworCQlrc2Z0X2V4
aXRfZmFpbF9wZXJyb3IoImVycm9yOiB3cml0ZSIpOwogCiAJY2xvc2UoZmQpOwogCmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9iaW5kZXJmcy9N
YWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL2JpbmRlcmZz
L01ha2VmaWxlCmluZGV4IGMyZjdjZWY5MTljMC4uZWI0YzNiNDExOTM0IDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9iaW5kZXJmcy9NYWtlZmls
ZQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9iaW5kZXJmcy9N
YWtlZmlsZQpAQCAtMyw2ICszLDQgQEAKIENGTEFHUyArPSAkKEtIRFJfSU5DTFVERVMpIC1w
dGhyZWFkCiBURVNUX0dFTl9QUk9HUyA6PSBiaW5kZXJmc190ZXN0CiAKLWJpbmRlcmZzX3Rl
c3Q6IGJpbmRlcmZzX3Rlc3QuYyAuLi8uLi9rc2VsZnRlc3QuaCAuLi8uLi9rc2VsZnRlc3Rf
aGFybmVzcy5oCi0KIGluY2x1ZGUgLi4vLi4vbGliLm1rCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9zdGF0bW91bnQvc3RhdG1vdW50X3Rlc3Qu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL3N0YXRtb3VudC9zdGF0
bW91bnRfdGVzdC5jCmluZGV4IDNlYWZkN2RhNThlMi4uZTZkN2M0ZjFjODViIDEwMDY0NAot
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9zdGF0bW91bnQvc3Rh
dG1vdW50X3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVt
cy9zdGF0bW91bnQvc3RhdG1vdW50X3Rlc3QuYwpAQCAtMyw2ICszLDcgQEAKICNkZWZpbmUg
X0dOVV9TT1VSQ0UKIAogI2luY2x1ZGUgPGFzc2VydC5oPgorI2luY2x1ZGUgPHN0ZGRlZi5o
PgogI2luY2x1ZGUgPHN0ZGludC5oPgogI2luY2x1ZGUgPHNjaGVkLmg+CiAjaW5jbHVkZSA8
ZmNudGwuaD4KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9m
dHJhY2V0ZXN0IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL2Z0cmFjZXRlc3QK
aW5kZXggMjVkNGUwZmNhMzg1Li5jY2U3MmY4YjAzZGMgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0CisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS9mdHJhY2V0ZXN0CkBAIC0yNTUsNyArMjU1LDEzIEBAIHBybG9n
KCkgeyAjIG1lc3NhZ2VzCiAgIFsgIiRMT0dfRklMRSIgXSAmJiBwcmludGYgIiQqJG5ld2xp
bmUiIHwgc3RyaXBfZXNjID4+ICRMT0dfRklMRQogfQogY2F0bG9nKCkgeyAjZmlsZQotICBj
YXQgJDEKKyAgaWYgWyAiJHtLVEFQfSIgPSAiMSIgXTsgdGhlbgorICAgIGNhdCAkMSB8IHdo
aWxlIHJlYWQgbGluZSA7IGRvCisgICAgICBlY2hvICIjICRsaW5lIgorICAgIGRvbmUKKyAg
ZWxzZQorICAgIGNhdCAkMQorICBmaQogICBbICIkTE9HX0ZJTEUiIF0gJiYgY2F0ICQxIHwg
c3RyaXBfZXNjID4+ICRMT0dfRklMRQogfQogcHJsb2cgIj09PSBGdHJhY2UgdW5pdCB0ZXN0
cyA9PT0iCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRy
YWNldGVzdC1rdGFwIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL2Z0cmFjZXRl
c3Qta3RhcAppbmRleCBiMzI4NDY3OWVmM2EuLjE0ZTYyZWYzZjNiOSAxMDA3NTUKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL2Z0cmFjZXRlc3Qta3RhcAorKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvZnRyYWNldGVzdC1rdGFwCkBAIC01LDQg
KzUsNCBAQAogIwogIyBDb3B5cmlnaHQgKEMpIEFybSBMdGQuLCAyMDIzCiAKLS4vZnRyYWNl
dGVzdCAtSworLi9mdHJhY2V0ZXN0IC1LIC12CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2R5bmV2ZW50L2FkZF9yZW1vdmVfYnRmYXJnLnRj
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVudC9hZGRf
cmVtb3ZlX2J0ZmFyZy50YwppbmRleCBiOWMyMWE4MWQyNDguLmMwY2RhZDRjNDAwZSAxMDA2
NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVu
dC9hZGRfcmVtb3ZlX2J0ZmFyZy50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9m
dHJhY2UvdGVzdC5kL2R5bmV2ZW50L2FkZF9yZW1vdmVfYnRmYXJnLnRjCkBAIC01Myw3ICs1
Myw3IEBAIGZpCiAKIGVjaG8gPiBkeW5hbWljX2V2ZW50cwogCi1pZiBbICIkRklFTERTIiBd
IDsgdGhlbgoraWYgWyAiJEZJRUxEUyIgLWEgIiRGUFJPQkVTIiBdIDsgdGhlbgogZWNobyAi
dDp0cGV2ZW50ICR7VFAyfSBvYmpfc2l6ZT1zLT5vYmplY3Rfc2l6ZSIgPj4gZHluYW1pY19l
dmVudHMKIGVjaG8gImY6ZnBldmVudCAke1RQM30lcmV0dXJuIHBhdGg9XCRyZXR2YWwtPm5h
bWU6c3RyaW5nIiA+PiBkeW5hbWljX2V2ZW50cwogZWNobyAidDp0cGV2ZW50MiAke1RQNH0g
cC0+c2UuZ3JvdXBfbm9kZS5uZXh0LT5wcmV2IiA+PiBkeW5hbWljX2V2ZW50cwpkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVudC9m
cHJvYmVfZW50cnlfYXJnLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rl
c3QuZC9keW5ldmVudC9mcHJvYmVfZW50cnlfYXJnLnRjCmluZGV4IGQxODNiOGE4ZWNmOC4u
MWUyNTFjZTI5OThlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJh
Y2UvdGVzdC5kL2R5bmV2ZW50L2Zwcm9iZV9lbnRyeV9hcmcudGMKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVudC9mcHJvYmVfZW50cnlfYXJn
LnRjCkBAIC0xMSw3ICsxMSw3IEBAIGVjaG8gMSA+IGV2ZW50cy90ZXN0cy9lbmFibGUKIGVj
aG8gPiB0cmFjZQogY2F0IHRyYWNlID4gL2Rldi9udWxsCiAKLWZ1bmN0aW9uIHN0cmVxKCkg
eworc3RyZXEoKSB7CiAJdGVzdCAkMSA9ICQyCiB9CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2tyZXRwcm9iZV9lbnRyeV9h
cmcudGMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9r
cmV0cHJvYmVfZW50cnlfYXJnLnRjCmluZGV4IDUzYjgyZjM2YTFkMC4uZTUwNDcwYjUzMTY0
IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2tw
cm9iZS9rcmV0cHJvYmVfZW50cnlfYXJnLnRjCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Z0cmFjZS90ZXN0LmQva3Byb2JlL2tyZXRwcm9iZV9lbnRyeV9hcmcudGMKQEAgLTEx
LDcgKzExLDcgQEAgZWNobyAxID4gZXZlbnRzL2twcm9iZXMvZW5hYmxlCiBlY2hvID4gdHJh
Y2UKIGNhdCB0cmFjZSA+IC9kZXYvbnVsbAogCi1mdW5jdGlvbiBzdHJlcSgpIHsKK3N0cmVx
KCkgewogCXRlc3QgJDEgPSAkMgogfQogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9pcGMvbXNncXVlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9pcGMvbXNn
cXVlLmMKaW5kZXggNjU2YzQzYzI0MDQ0Li5jNzVlYTQwOTQ4NzAgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2lwYy9tc2dxdWUuYworKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9pcGMvbXNncXVlLmMKQEAgLTE5OCwxMyArMTk4LDEyIEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIAlzdHJ1Y3QgbXNncXVlX2RhdGEgbXNncXVlOwog
CiAJaWYgKGdldHVpZCgpICE9IDApCi0JCXJldHVybiBrc2Z0X2V4aXRfc2tpcCgKLQkJCQki
UGxlYXNlIHJ1biB0aGUgdGVzdCBhcyByb290IC0gRXhpdGluZy5cbiIpOworCQlrc2Z0X2V4
aXRfc2tpcCgiUGxlYXNlIHJ1biB0aGUgdGVzdCBhcyByb290IC0gRXhpdGluZy5cbiIpOwog
CiAJbXNncXVlLmtleSA9IGZ0b2soYXJndlswXSwgODIyMTU1NjUwKTsKIAlpZiAobXNncXVl
LmtleSA9PSAtMSkgewogCQlwcmludGYoIkNhbid0IG1ha2Uga2V5OiAlZFxuIiwgLWVycm5v
KTsKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWlsKCk7CisJCWtzZnRfZXhpdF9mYWlsKCk7CiAJ
fQogCiAJbXNncXVlLm1zcV9pZCA9IG1zZ2dldChtc2dxdWUua2V5LCBJUENfQ1JFQVQgfCBJ
UENfRVhDTCB8IDA2NjYpOwpAQCAtMjQzLDEzICsyNDIsMTMgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQogCQlwcmludGYoIkZhaWxlZCB0byB0ZXN0IHF1ZXVlOiAlZFxu
IiwgZXJyKTsKIAkJZ290byBlcnJfb3V0OwogCX0KLQlyZXR1cm4ga3NmdF9leGl0X3Bhc3Mo
KTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogCiBlcnJfZGVzdHJveToKIAlpZiAobXNnY3RsKG1z
Z3F1ZS5tc3FfaWQsIElQQ19STUlELCBOVUxMKSkgewogCQlwcmludGYoIkZhaWxlZCB0byBk
ZXN0cm95IHF1ZXVlOiAlZFxuIiwgLWVycm5vKTsKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWls
KCk7CisJCWtzZnRfZXhpdF9mYWlsKCk7CiAJfQogZXJyX291dDoKLQlyZXR1cm4ga3NmdF9l
eGl0X2ZhaWwoKTsKKwlrc2Z0X2V4aXRfZmFpbCgpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0LmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rc2VsZnRlc3QuaAppbmRleCAxNGJiYWIwY2NlMTMuLjc2YzJhNjk0NWQzZSAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0LmgKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0LmgKQEAgLTE2LDEwICsxNiwxMiBAQAogICog
Rm9yIGVhY2ggdGVzdCwgcmVwb3J0IGFueSBwcm9ncmVzcywgZGVidWdnaW5nLCBldGMgd2l0
aDoKICAqCiAgKiAgICAga3NmdF9wcmludF9tc2coZm10LCAuLi4pOworICogICAgIGtzZnRf
cGVycm9yKG1zZyk7CiAgKgogICogYW5kIGZpbmFsbHkgcmVwb3J0IHRoZSBwYXNzL2ZhaWwv
c2tpcC94ZmFpbCBzdGF0ZSBvZiB0aGUgdGVzdCB3aXRoIG9uZSBvZjoKICAqCiAgKiAgICAg
a3NmdF90ZXN0X3Jlc3VsdChjb25kaXRpb24sIGZtdCwgLi4uKTsKKyAqICAgICBrc2Z0X3Rl
c3RfcmVzdWx0X3JlcG9ydChyZXN1bHQsIGZtdCwgLi4uKTsKICAqICAgICBrc2Z0X3Rlc3Rf
cmVzdWx0X3Bhc3MoZm10LCAuLi4pOwogICogICAgIGtzZnRfdGVzdF9yZXN1bHRfZmFpbChm
bXQsIC4uLik7CiAgKiAgICAga3NmdF90ZXN0X3Jlc3VsdF9za2lwKGZtdCwgLi4uKTsKQEAg
LTM5LDYgKzQxLDcgQEAKICAqIHRoZSBwcm9ncmFtIGlzIGFib3J0aW5nIGJlZm9yZSBmaW5p
c2hpbmcgYWxsIHRlc3RzKToKICAqCiAgKiAgICBrc2Z0X2V4aXRfZmFpbF9tc2coZm10LCAu
Li4pOworICogICAga3NmdF9leGl0X2ZhaWxfcGVycm9yKG1zZyk7CiAgKgogICovCiAjaWZu
ZGVmIF9fS1NFTEZURVNUX0gKQEAgLTMwNSwxMyArMzA4LDM0IEBAIHZvaWQga3NmdF90ZXN0
X3Jlc3VsdF9jb2RlKGludCBleGl0X2NvZGUsIGNvbnN0IGNoYXIgKnRlc3RfbmFtZSwKIAlw
cmludGYoIlxuIik7CiB9CiAKLXN0YXRpYyBpbmxpbmUgX19ub3JldHVybiBpbnQga3NmdF9l
eGl0X3Bhc3Modm9pZCkKKy8qKgorICoga3NmdF90ZXN0X3Jlc3VsdCgpIC0gUmVwb3J0IHRl
c3Qgc3VjY2VzcyBiYXNlZCBvbiB0cnV0aCBvZiBjb25kaXRpb24KKyAqCisgKiBAY29uZGl0
aW9uOiBpZiB0cnVlLCByZXBvcnQgdGVzdCBzdWNjZXNzLCBvdGhlcndpc2UgZmFpbHVyZS4K
KyAqLworI2RlZmluZSBrc2Z0X3Rlc3RfcmVzdWx0X3JlcG9ydChyZXN1bHQsIGZtdCwgLi4u
KSBkbyB7CQlcCisJc3dpdGNoIChyZXN1bHQpIHsJCQkJCVwKKwljYXNlIEtTRlRfUEFTUzoJ
CQkJCQlcCisJCWtzZnRfdGVzdF9yZXN1bHRfcGFzcyhmbXQsICMjX19WQV9BUkdTX18pOwlc
CisJCWJyZWFrOwkJCQkJCVwKKwljYXNlIEtTRlRfRkFJTDoJCQkJCQlcCisJCWtzZnRfdGVz
dF9yZXN1bHRfZmFpbChmbXQsICMjX19WQV9BUkdTX18pOwlcCisJCWJyZWFrOwkJCQkJCVwK
KwljYXNlIEtTRlRfWEZBSUw6CQkJCQlcCisJCWtzZnRfdGVzdF9yZXN1bHRfeGZhaWwoZm10
LCAjI19fVkFfQVJHU19fKTsJXAorCQlicmVhazsJCQkJCQlcCisJY2FzZSBLU0ZUX1NLSVA6
CQkJCQkJXAorCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoZm10LCAjI19fVkFfQVJHU19fKTsJ
XAorCQlicmVhazsJCQkJCQlcCisJfSB9IHdoaWxlICgwKQorCitzdGF0aWMgaW5saW5lIF9f
bm9yZXR1cm4gdm9pZCBrc2Z0X2V4aXRfcGFzcyh2b2lkKQogewogCWtzZnRfcHJpbnRfY250
cygpOwogCWV4aXQoS1NGVF9QQVNTKTsKIH0KIAotc3RhdGljIGlubGluZSBfX25vcmV0dXJu
IGludCBrc2Z0X2V4aXRfZmFpbCh2b2lkKQorc3RhdGljIGlubGluZSBfX25vcmV0dXJuIHZv
aWQga3NmdF9leGl0X2ZhaWwodm9pZCkKIHsKIAlrc2Z0X3ByaW50X2NudHMoKTsKIAlleGl0
KEtTRlRfRkFJTCk7CkBAIC0zMzgsNyArMzYyLDcgQEAgc3RhdGljIGlubGluZSBfX25vcmV0
dXJuIGludCBrc2Z0X2V4aXRfZmFpbCh2b2lkKQogCQkgIGtzZnRfY250LmtzZnRfeGZhaWwg
KwlcCiAJCSAga3NmdF9jbnQua3NmdF94c2tpcCkKIAotc3RhdGljIGlubGluZSBfX25vcmV0
dXJuIF9fcHJpbnRmKDEsIDIpIGludCBrc2Z0X2V4aXRfZmFpbF9tc2coY29uc3QgY2hhciAq
bXNnLCAuLi4pCitzdGF0aWMgaW5saW5lIF9fbm9yZXR1cm4gX19wcmludGYoMSwgMikgdm9p
ZCBrc2Z0X2V4aXRfZmFpbF9tc2coY29uc3QgY2hhciAqbXNnLCAuLi4pCiB7CiAJaW50IHNh
dmVkX2Vycm5vID0gZXJybm87CiAJdmFfbGlzdCBhcmdzOwpAQCAtMzUzLDE5ICszNzcsMzIg
QEAgc3RhdGljIGlubGluZSBfX25vcmV0dXJuIF9fcHJpbnRmKDEsIDIpIGludCBrc2Z0X2V4
aXRfZmFpbF9tc2coY29uc3QgY2hhciAqbXNnLAogCWV4aXQoS1NGVF9GQUlMKTsKIH0KIAot
c3RhdGljIGlubGluZSBfX25vcmV0dXJuIGludCBrc2Z0X2V4aXRfeGZhaWwodm9pZCkKK3N0
YXRpYyBpbmxpbmUgX19ub3JldHVybiB2b2lkIGtzZnRfZXhpdF9mYWlsX3BlcnJvcihjb25z
dCBjaGFyICptc2cpCit7CisjaWZuZGVmIE5PTElCQworCWtzZnRfZXhpdF9mYWlsX21zZygi
JXM6ICVzICglZClcbiIsIG1zZywgc3RyZXJyb3IoZXJybm8pLCBlcnJubyk7CisjZWxzZQor
CS8qCisJICogbm9saWJjIGRvZXNuJ3QgcHJvdmlkZSBzdHJlcnJvcigpIGFuZCBpdCBzZWVt
cworCSAqIGluYXBwcm9wcmlhdGUgdG8gYWRkIG9uZSwganVzdCBwcmludCB0aGUgZXJybm8u
CisJICovCisJa3NmdF9leGl0X2ZhaWxfbXNnKCIlczogJWQpXG4iLCBtc2csIGVycm5vKTsK
KyNlbmRpZgorfQorCitzdGF0aWMgaW5saW5lIF9fbm9yZXR1cm4gdm9pZCBrc2Z0X2V4aXRf
eGZhaWwodm9pZCkKIHsKIAlrc2Z0X3ByaW50X2NudHMoKTsKIAlleGl0KEtTRlRfWEZBSUwp
OwogfQogCi1zdGF0aWMgaW5saW5lIF9fbm9yZXR1cm4gaW50IGtzZnRfZXhpdF94cGFzcyh2
b2lkKQorc3RhdGljIGlubGluZSBfX25vcmV0dXJuIHZvaWQga3NmdF9leGl0X3hwYXNzKHZv
aWQpCiB7CiAJa3NmdF9wcmludF9jbnRzKCk7CiAJZXhpdChLU0ZUX1hQQVNTKTsKIH0KIAot
c3RhdGljIGlubGluZSBfX25vcmV0dXJuIF9fcHJpbnRmKDEsIDIpIGludCBrc2Z0X2V4aXRf
c2tpcChjb25zdCBjaGFyICptc2csIC4uLikKK3N0YXRpYyBpbmxpbmUgX19ub3JldHVybiBf
X3ByaW50ZigxLCAyKSB2b2lkIGtzZnRfZXhpdF9za2lwKGNvbnN0IGNoYXIgKm1zZywgLi4u
KQogewogCWludCBzYXZlZF9lcnJubyA9IGVycm5vOwogCXZhX2xpc3QgYXJnczsKZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9rdGFwX2hlbHBlcnMu
c2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3Qva3RhcF9oZWxwZXJzLnNo
CmluZGV4IGYyZmJiOTE0ZTA1OC4uNzlhMTI1ZWIyNGMyIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3Qva3RhcF9oZWxwZXJzLnNoCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9rdGFwX2hlbHBlcnMuc2gKQEAgLTQzLDcg
KzQzLDcgQEAgX19rdGFwX3Rlc3QoKSB7CiAJZGlyZWN0aXZlPSIkMyIgIyBvcHRpb25hbAog
CiAJbG9jYWwgZGlyZWN0aXZlX3N0cj0KLQlbWyAhIC16ICIkZGlyZWN0aXZlIiBdXSAmJiBk
aXJlY3RpdmVfc3RyPSIjICRkaXJlY3RpdmUiCisJWyAhIC16ICIkZGlyZWN0aXZlIiBdICYm
IGRpcmVjdGl2ZV9zdHI9IiMgJGRpcmVjdGl2ZSIKIAogCWVjaG8gJHJlc3VsdCAkS1RBUF9U
RVNUTk8gJGRlc2NyaXB0aW9uICRkaXJlY3RpdmVfc3RyCiAKQEAgLTk5LDcgKzk5LDcgQEAg
a3RhcF9leGl0X2ZhaWxfbXNnKCkgewoga3RhcF9maW5pc2hlZCgpIHsKIAlrdGFwX3ByaW50
X3RvdGFscwogCi0JaWYgWyAkKCgiJEtUQVBfQ05UX1BBU1MiICsgIiRLVEFQX0NOVF9TS0lQ
IikpIC1lcSAiJEtTRlRfTlVNX1RFU1RTIiBdOyB0aGVuCisJaWYgWyAkKChLVEFQX0NOVF9Q
QVNTICsgS1RBUF9DTlRfU0tJUCkpIC1lcSAiJEtTRlRfTlVNX1RFU1RTIiBdOyB0aGVuCiAJ
CWV4aXQgIiRLU0ZUX1BBU1MiCiAJZWxzZQogCQlleGl0ICIkS1NGVF9GQUlMIgpkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2RlcHMuc2ggYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3RfZGVwcy5zaAppbmRleCBkZTU5Y2M4ZjAz
YzMuLjQ4N2U0OWZkZjJhNiAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
a3NlbGZ0ZXN0X2RlcHMuc2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0
ZXN0X2RlcHMuc2gKQEAgLTI0NCw2ICsyNDQsNyBAQCBsNF90ZXN0KCkKIGw1X3Rlc3QoKQog
ewogCXRlc3RzPSQoZmluZCAkKGRpcm5hbWUgIiR0ZXN0IikgLXR5cGUgZiAtbmFtZSAiKi5t
ayIpCisJW1sgLXogIiR7dGVzdHMvLyB9IiBdXSAmJiByZXR1cm4KIAl0ZXN0X2xpYnM9JChn
cmVwICJeSU9VUklOR19FWFRSQV9MSUJTICtcPz0iICR0ZXN0cyB8IFwKIAkJCWN1dCAtZCAi
PSIgLWYgMikKIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0
ZXN0X2hhcm5lc3MuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJu
ZXNzLmgKaW5kZXggZDk4NzAyYjY5NTVkLi5iMmExYjYzNDM4OTYgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzLmgKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2hhcm5lc3MuaApAQCAtNTEsNyArNTEsNyBA
QAogI2RlZmluZSBfX0tTRUxGVEVTVF9IQVJORVNTX0gKIAogI2lmbmRlZiBfR05VX1NPVVJD
RQotI2RlZmluZSBfR05VX1NPVVJDRQorc3RhdGljX2Fzc2VydCgwLCAia3NlbGZ0ZXN0IGhh
cm5lc3MgcmVxdWlyZXMgX0dOVV9TT1VSQ0UgdG8gYmUgZGVmaW5lZCIpOwogI2VuZGlmCiAj
aW5jbHVkZSA8YXNtL3R5cGVzLmg+CiAjaW5jbHVkZSA8Y3R5cGUuaD4KZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5tayBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2xpYi5tawppbmRleCBkYTJjYWRlM2JhYjAuLjdmYTRhOTZlMjZlZCAxMDA2NDQKLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1rCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xpYi5tawpAQCAtNyw2ICs3LDggQEAgZWxzZSBpZm5lcSAoJChmaWx0ZXIg
LSUsJChMTFZNKSksKQogTExWTV9TVUZGSVggOj0gJChMTFZNKQogZW5kaWYKIAorQ0xBTkcg
Oj0gJChMTFZNX1BSRUZJWCljbGFuZyQoTExWTV9TVUZGSVgpCisKIENMQU5HX1RBUkdFVF9G
TEFHU19hcm0gICAgICAgICAgOj0gYXJtLWxpbnV4LWdudWVhYmkKIENMQU5HX1RBUkdFVF9G
TEFHU19hcm02NCAgICAgICAgOj0gYWFyY2g2NC1saW51eC1nbnUKIENMQU5HX1RBUkdFVF9G
TEFHU19oZXhhZ29uICAgICAgOj0gaGV4YWdvbi1saW51eC1tdXNsCkBAIC0xOCw3ICsyMCwx
MyBAQCBDTEFOR19UQVJHRVRfRkxBR1NfcmlzY3YgICAgICAgIDo9IHJpc2N2NjQtbGludXgt
Z251CiBDTEFOR19UQVJHRVRfRkxBR1NfczM5MCAgICAgICAgIDo9IHMzOTB4LWxpbnV4LWdu
dQogQ0xBTkdfVEFSR0VUX0ZMQUdTX3g4NiAgICAgICAgICA6PSB4ODZfNjQtbGludXgtZ251
CiBDTEFOR19UQVJHRVRfRkxBR1NfeDg2XzY0ICAgICAgIDo9IHg4Nl82NC1saW51eC1nbnUK
LUNMQU5HX1RBUkdFVF9GTEFHUyAgICAgICAgICAgICAgOj0gJChDTEFOR19UQVJHRVRfRkxB
R1NfJChBUkNIKSkKKworIyBEZWZhdWx0IHRvIGhvc3QgYXJjaGl0ZWN0dXJlIGlmIEFSQ0gg
aXMgbm90IGV4cGxpY2l0bHkgZ2l2ZW4uCitpZmVxICgkKEFSQ0gpLCkKK0NMQU5HX1RBUkdF
VF9GTEFHUyA6PSAkKHNoZWxsICQoQ0xBTkcpIC1wcmludC10YXJnZXQtdHJpcGxlKQorZWxz
ZQorQ0xBTkdfVEFSR0VUX0ZMQUdTIDo9ICQoQ0xBTkdfVEFSR0VUX0ZMQUdTXyQoQVJDSCkp
CitlbmRpZgogCiBpZmVxICgkKENST1NTX0NPTVBJTEUpLCkKIGlmZXEgKCQoQ0xBTkdfVEFS
R0VUX0ZMQUdTKSwpCkBAIC0zMCw3ICszOCw3IEBAIGVsc2UKIENMQU5HX0ZMQUdTICAgICAr
PSAtLXRhcmdldD0kKG5vdGRpciAkKENST1NTX0NPTVBJTEU6JS09JSkpCiBlbmRpZiAjIENS
T1NTX0NPTVBJTEUKIAotQ0MgOj0gJChMTFZNX1BSRUZJWCljbGFuZyQoTExWTV9TVUZGSVgp
ICQoQ0xBTkdfRkxBR1MpIC1maW50ZWdyYXRlZC1hcworQ0MgOj0gJChDTEFORykgJChDTEFO
R19GTEFHUykgLWZpbnRlZ3JhdGVkLWFzCiBlbHNlCiBDQyA6PSAkKENST1NTX0NPTVBJTEUp
Z2NjCiBlbmRpZiAjIExMVk0KQEAgLTQ1LDcgKzUzLDcgQEAgc2VsZmRpciA9ICQocmVhbHBh
dGggJChkaXIgJChmaWx0ZXIgJS9saWIubWssJChNQUtFRklMRV9MSVNUKSkpKQogdG9wX3Ny
Y2RpciA9ICQoc2VsZmRpcikvLi4vLi4vLi4KIAogaWZlcSAoJChLSERSX0lOQ0xVREVTKSwp
Ci1LSERSX0lOQ0xVREVTIDo9IC1pc3lzdGVtICQodG9wX3NyY2RpcikvdXNyL2luY2x1ZGUK
K0tIRFJfSU5DTFVERVMgOj0gLURfR05VX1NPVVJDRSAtaXN5c3RlbSAkKHRvcF9zcmNkaXIp
L3Vzci9pbmNsdWRlCiBlbmRpZgogCiAjIFRoZSBmb2xsb3dpbmcgYXJlIGJ1aWx0IGJ5IGxp
Yi5tayBjb21tb24gY29tcGlsZSBydWxlcy4KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21lbWJhcnJpZXIvbWVtYmFycmllcl90ZXN0X211bHRpX3RocmVhZC5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtYmFycmllci9tZW1iYXJyaWVyX3Rlc3RfbXVs
dGlfdGhyZWFkLmMKaW5kZXggYTljYzE3ZmFjZmIzLi40ZTE0ZGJhODEyMzQgMTAwNjQ0Ci0t
LSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbWJhcnJpZXIvbWVtYmFycmllcl90ZXN0
X211bHRpX3RocmVhZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbWJhcnJp
ZXIvbWVtYmFycmllcl90ZXN0X211bHRpX3RocmVhZC5jCkBAIC02OSw1ICs2OSw1IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkvKiBNdWx0aS10aHJlYWRlZCAqLwog
CXRlc3RfbXRfbWVtYmFycmllcigpOwogCi0JcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJ
a3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21lbWJhcnJpZXIvbWVtYmFycmllcl90ZXN0X3NpbmdsZV90aHJlYWQuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL21lbWJhcnJpZXIvbWVtYmFycmllcl90ZXN0X3NpbmdsZV90
aHJlYWQuYwppbmRleCA0Y2RjOGIxZDEyNGMuLmZhM2YxZDZjMzdhMCAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtYmFycmllci9tZW1iYXJyaWVyX3Rlc3Rfc2lu
Z2xlX3RocmVhZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbWJhcnJpZXIv
bWVtYmFycmllcl90ZXN0X3NpbmdsZV90aHJlYWQuYwpAQCAtMjQsNSArMjQsNSBAQCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAKIAl0ZXN0X21lbWJhcnJpZXJfZ2V0X3Jl
Z2lzdHJhdGlvbnMoLypjbWQ9Ki8wKTsKIAotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOwor
CWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9tbS9jb21wYWN0aW9uX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21t
L2NvbXBhY3Rpb25fdGVzdC5jCmluZGV4IDUzMzk5OWI2YzI4NC4uNGY0MmViN2Q3NjM2IDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9jb21wYWN0aW9uX3Rlc3Qu
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9jb21wYWN0aW9uX3Rlc3QuYwpA
QCAtMTc3LDcgKzE3Nyw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlr
c2Z0X3ByaW50X2hlYWRlcigpOwogCiAJaWYgKHByZXJlcSgpIHx8IGdldGV1aWQoKSkKLQkJ
cmV0dXJuIGtzZnRfZXhpdF9za2lwKCJQcmVyZXF1aXNpdGVzIHVuc2F0aXNmaWVkXG4iKTsK
KwkJa3NmdF9leGl0X3NraXAoIlByZXJlcXVpc2l0ZXMgdW5zYXRpc2ZpZWRcbiIpOwogCiAJ
a3NmdF9zZXRfcGxhbigxKTsKIApAQCAtMjI1LDcgKzIyNSw3IEBAIGludCBtYWluKGludCBh
cmdjLCBjaGFyICoqYXJndikKIAl9CiAKIAlpZiAoY2hlY2tfY29tcGFjdGlvbihtZW1fZnJl
ZSwgaHVnZXBhZ2Vfc2l6ZSkgPT0gMCkKLQkJcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJ
CWtzZnRfZXhpdF9wYXNzKCk7CiAKLQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwoKTsKKwlrc2Z0
X2V4aXRfZmFpbCgpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bW0vY293LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9jb3cuYwppbmRleCAzNjNi
ZjVmODAxYmUuLmZlMDc4ZDZlMTgwNiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbW0vY293LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vY293LmMK
QEAgLTE3NzksNSArMTc3OSw1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAlpZiAoZXJyKQogCQlrc2Z0X2V4aXRfZmFpbF9tc2coIiVkIG91dCBvZiAlZCB0ZXN0cyBm
YWlsZWRcbiIsCiAJCQkJICAgZXJyLCBrc2Z0X3Rlc3RfbnVtKCkpOwotCXJldHVybiBrc2Z0
X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ndXBfbG9uZ3Rlcm0uYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21tL2d1cF9sb25ndGVybS5jCmluZGV4IGFkMTY4ZDM1YjIzYi4uZDdlYWNh
NWJiZTliIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ndXBfbG9u
Z3Rlcm0uYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ndXBfbG9uZ3Rlcm0u
YwpAQCAtNDU2LDUgKzQ1Niw1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAlpZiAoZXJyKQogCQlrc2Z0X2V4aXRfZmFpbF9tc2coIiVkIG91dCBvZiAlZCB0ZXN0cyBm
YWlsZWRcbiIsCiAJCQkJICAgZXJyLCBrc2Z0X3Rlc3RfbnVtKCkpOwotCXJldHVybiBrc2Z0
X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ndXBfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbW0vZ3VwX3Rlc3QuYwppbmRleCAxOGE0OWM3MGQ0YzYuLmJkMzM1Y2Y5YmMwZSAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vZ3VwX3Rlc3QuYworKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ndXBfdGVzdC5jCkBAIC0yMjgsNyArMjI4
LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJYnJlYWs7CiAJCX0K
IAkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJQbGVhc2UgcnVuIHRoaXMgdGVzdCBhcyByb290
XG4iKTsKLQkJcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJCWtzZnRfZXhpdF9wYXNzKCk7
CiAJfQogCiAJcCA9IG1tYXAoTlVMTCwgc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwg
ZmxhZ3MsIGZpbGVkLCAwKTsKQEAgLTI2Nyw1ICsyNjcsNSBAQCBpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqKmFyZ3YpCiAKIAlmcmVlKHRpZCk7CiAKLQlyZXR1cm4ga3NmdF9leGl0X3Bh
c3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbW0va3NtX2Z1bmN0aW9uYWxfdGVzdHMuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21tL2tzbV9mdW5jdGlvbmFsX3Rlc3RzLmMKaW5kZXggZDYxNTc2N2UzOTZi
Li41MDgyODc1NjBjNDUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21t
L2tzbV9mdW5jdGlvbmFsX3Rlc3RzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bW0va3NtX2Z1bmN0aW9uYWxfdGVzdHMuYwpAQCAtNjQ2LDUgKzY0Niw1IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIAlpZiAoZXJyKQogCQlrc2Z0X2V4aXRfZmFpbF9t
c2coIiVkIG91dCBvZiAlZCB0ZXN0cyBmYWlsZWRcbiIsCiAJCQkJICAgZXJyLCBrc2Z0X3Rl
c3RfbnVtKCkpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNz
KCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tYWR2X3Bv
cHVsYXRlLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tYWR2X3BvcHVsYXRlLmMK
aW5kZXggMTdiY2IwN2YxOWYzLi5lZjdkOTExZGExM2UgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL21tL21hZHZfcG9wdWxhdGUuYworKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9tbS9tYWR2X3BvcHVsYXRlLmMKQEAgLTMwNyw1ICszMDcsNSBAQCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJaWYgKGVycikKIAkJa3NmdF9leGl0X2Zh
aWxfbXNnKCIlZCBvdXQgb2YgJWQgdGVzdHMgZmFpbGVkXG4iLAogCQkJCSAgIGVyciwga3Nm
dF90ZXN0X251bSgpKTsKLQlyZXR1cm4ga3NmdF9leGl0X3Bhc3MoKTsKKwlrc2Z0X2V4aXRf
cGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vbWtk
aXJ0eS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vbWtkaXJ0eS5jCmluZGV4IDMw
MWFiYjk5ZTAyNy4uYjhhN2VmZTkyMDRlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9tbS9ta2RpcnR5LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0v
bWtkaXJ0eS5jCkBAIC0zNzUsNSArMzc1LDUgQEAgaW50IG1haW4odm9pZCkKIAlpZiAoZXJy
KQogCQlrc2Z0X2V4aXRfZmFpbF9tc2coIiVkIG91dCBvZiAlZCB0ZXN0cyBmYWlsZWRcbiIs
CiAJCQkJICAgZXJyLCBrc2Z0X3Rlc3RfbnVtKCkpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFz
cygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9tbS9wYWdlbWFwX2lvY3RsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9tbS9wYWdlbWFwX2lvY3RsLmMKaW5kZXggZDU5NTE3ZWQzZDQ4Li4yZDc4NWFjYTcyYTUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3BhZ2VtYXBfaW9jdGwu
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9wYWdlbWFwX2lvY3RsLmMKQEAg
LTE0ODQsNyArMTQ4NCw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJ
a3NmdF9wcmludF9oZWFkZXIoKTsKIAogCWlmIChpbml0X3VmZmQoKSkKLQkJcmV0dXJuIGtz
ZnRfZXhpdF9wYXNzKCk7CisJCWtzZnRfZXhpdF9wYXNzKCk7CiAKIAlrc2Z0X3NldF9wbGFu
KDExNSk7CiAKQEAgLTE2NjAsNSArMTY2MCw1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
ICphcmd2W10pCiAJdXNlcmZhdWx0ZmRfdGVzdHMoKTsKIAogCWNsb3NlKHBhZ2VtYXBfZmQp
OwotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9zb2Z0LWRpcnR5LmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9zb2Z0LWRpcnR5LmMKaW5kZXggN2RiZmE1M2Q5
M2EwLi5kOWRiZjg3OTc0OGIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21tL3NvZnQtZGlydHkuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9zb2Z0
LWRpcnR5LmMKQEAgLTIwOSw1ICsyMDksNSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiAKIAljbG9zZShwYWdlbWFwX2ZkKTsKIAotCXJldHVybiBrc2Z0X2V4aXRfcGFz
cygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGluZm9fdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcGlkZmQvcGlkZmRfZmRpbmZvX3Rlc3QuYwppbmRleCAwMWNjMzdiZjYxMWMu
LmYwNjJhOTg2ZTM4MiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlk
ZmQvcGlkZmRfZmRpbmZvX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9w
aWRmZC9waWRmZF9mZGluZm9fdGVzdC5jCkBAIC0zMDcsNSArMzA3LDUgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCXRlc3RfcGlkZmRfZmRpbmZvX25zcGlkKCk7CiAJ
dGVzdF9waWRmZF9kZWFkX2ZkaW5mbygpOwogCi0JcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7
CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3BpZGZkL3BpZGZkX29wZW5fdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcGlkZmQvcGlkZmRfb3Blbl90ZXN0LmMKaW5kZXggOGE1OTQzOGNjYzc4Li5jNjI1NjRj
MjY0YjEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZk
X29wZW5fdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZk
X29wZW5fdGVzdC5jCkBAIC0xNTksNSArMTU5LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCWlmIChwaWRmZCA+PSAwKQogCQljbG9zZShwaWRmZCk7CiAKLQlyZXR1
cm4gIXJldCA/IGtzZnRfZXhpdF9wYXNzKCkgOiBrc2Z0X2V4aXRfZmFpbCgpOworCWlmIChy
ZXQpCisJCWtzZnRfZXhpdF9mYWlsKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3BvbGxfdGVzdC5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfcG9sbF90ZXN0LmMKaW5k
ZXggNjEwODExMjc1MzU3Li41NWQ3NGE1MDM1OGYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3BvbGxfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3BvbGxfdGVzdC5jCkBAIC0xMTIsNSArMTEyLDUg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCX0KIAogCWtzZnRfdGVzdF9y
ZXN1bHRfcGFzcygicGlkZmQgcG9sbCB0ZXN0OiBwYXNzXG4iKTsKLQlyZXR1cm4ga3NmdF9l
eGl0X3Bhc3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcGlkZmQvcGlkZmRfdGVzdC5jCmluZGV4IGMwODFhZTkxMzEzYS4uOWZhYTY4
NmY5MGU0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRm
ZF90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfdGVz
dC5jCkBAIC01NzIsNSArNTcyLDUgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQogCXRlc3RfcGlkZmRfc2VuZF9zaWduYWxfZXhpdGVkX2ZhaWwoKTsKIAl0ZXN0X3BpZGZk
X3NlbmRfc2lnbmFsX3JlY3ljbGVkX3BpZF9mYWlsKCk7CiAKLQlyZXR1cm4ga3NmdF9leGl0
X3Bhc3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcG93ZXJfc3VwcGx5L3Rlc3RfcG93ZXJfc3VwcGx5X3Byb3BlcnRp
ZXMuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9wb3dlcl9zdXBwbHkvdGVzdF9wb3dl
cl9zdXBwbHlfcHJvcGVydGllcy5zaAppbmRleCBkZjI3MmRmZTFkMmEuLmE2NmIxMzEzZWQ4
OCAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcG93ZXJfc3VwcGx5L3Rl
c3RfcG93ZXJfc3VwcGx5X3Byb3BlcnRpZXMuc2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcG93ZXJfc3VwcGx5L3Rlc3RfcG93ZXJfc3VwcGx5X3Byb3BlcnRpZXMuc2gKQEAg
LTIzLDcgKzIzLDcgQEAgY291bnRfdGVzdHMoKSB7CiAJdG90YWxfdGVzdHM9MAogCiAJZm9y
IGkgaW4gJFNVUFBMSUVTOyBkbwotCQl0b3RhbF90ZXN0cz0kKCgiJHRvdGFsX3Rlc3RzIiAr
ICIkTlVNX1RFU1RTIikpCisJCXRvdGFsX3Rlc3RzPSQoKHRvdGFsX3Rlc3RzICsgTlVNX1RF
U1RTKSkKIAlkb25lCiAKIAllY2hvICIkdG90YWxfdGVzdHMiCmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9NYWtlZmlsZQppbmRleCAyZGVhYzIwMzFkZTkuLjAyMTg2M2Y4
NjA1MyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9NYWtl
ZmlsZQorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL01ha2VmaWxlCkBA
IC01LDYgKzUsOCBAQCBDRkxBR1MgKz0gJChLSERSX0lOQ0xVREVTKQogCiBURVNUX0dFTl9Q
Uk9HUyA6PSByZXNjdHJsX3Rlc3RzCiAKK0xPQ0FMX0hEUlMgKz0gJCh3aWxkY2FyZCAqLmgp
CisKIGluY2x1ZGUgLi4vbGliLm1rCiAKLSQoT1VUUFVUKS9yZXNjdHJsX3Rlc3RzOiAkKHdp
bGRjYXJkICouW2NoXSkKKyQoT1VUUFVUKS9yZXNjdHJsX3Rlc3RzOiAkKHdpbGRjYXJkICou
YykKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rl
c3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYwppbmRl
eCA0Y2I5OTFiZThlMzEuLmM3Njg2ZmI2NjQxYSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9jYXRfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYwpAQCAtMTI4LDcgKzEyOCw3IEBAIHN0YXRpYyBp
bnQgY2hlY2tfcmVzdWx0cyhzdHJ1Y3QgcmVzY3RybF92YWxfcGFyYW0gKnBhcmFtLCBjb25z
dCBjaGFyICpjYWNoZV90eXBlCiAJcmV0dXJuIGZhaWw7CiB9CiAKLXZvaWQgY2F0X3Rlc3Rf
Y2xlYW51cCh2b2lkKQorc3RhdGljIHZvaWQgY2F0X3Rlc3RfY2xlYW51cCh2b2lkKQogewog
CXJlbW92ZShSRVNVTFRfRklMRV9OQU1FKTsKIH0KQEAgLTI4NCwxMyArMjg0LDEwIEBAIHN0
YXRpYyBpbnQgY2F0X3J1bl90ZXN0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3Qs
IGNvbnN0IHN0cnVjdCB1c2VyX3BhcmFtCiAKIAlyZXQgPSBjYXRfdGVzdCh0ZXN0LCB1cGFy
YW1zLCAmcGFyYW0sIHNwYW4sIHN0YXJ0X21hc2spOwogCWlmIChyZXQpCi0JCWdvdG8gb3V0
OworCQlyZXR1cm4gcmV0OwogCiAJcmV0ID0gY2hlY2tfcmVzdWx0cygmcGFyYW0sIHRlc3Qt
PnJlc291cmNlLAogCQkJICAgIGNhY2hlX3RvdGFsX3NpemUsIGZ1bGxfY2FjaGVfbWFzaywg
c3RhcnRfbWFzayk7Ci1vdXQ6Ci0JY2F0X3Rlc3RfY2xlYW51cCgpOwotCiAJcmV0dXJuIHJl
dDsKIH0KIApAQCAtMzczLDYgKzM3MCw3IEBAIHN0cnVjdCByZXNjdHJsX3Rlc3QgbDNfY2F0
X3Rlc3QgPSB7CiAJLnJlc291cmNlID0gIkwzIiwKIAkuZmVhdHVyZV9jaGVjayA9IHRlc3Rf
cmVzb3VyY2VfZmVhdHVyZV9jaGVjaywKIAkucnVuX3Rlc3QgPSBjYXRfcnVuX3Rlc3QsCisJ
LmNsZWFudXAgPSBjYXRfdGVzdF9jbGVhbnVwLAogfTsKIAogc3RydWN0IHJlc2N0cmxfdGVz
dCBsM19ub25jb250X2NhdF90ZXN0ID0gewpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9jbXRfdGVzdC5jCmluZGV4IGE4MWY5MTIyMmE4OS4uMDEwNWFmZWM2MTg4IDEw
MDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NtdF90ZXN0LmMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jCkBAIC00
MCwxMSArNDAsMTEgQEAgc3RhdGljIGludCBzaG93X3Jlc3VsdHNfaW5mbyh1bnNpZ25lZCBs
b25nIHN1bV9sbGNfdmFsLCBpbnQgbm9fb2ZfYml0cywKIAlpbnQgcmV0OwogCiAJYXZnX2xs
Y192YWwgPSBzdW1fbGxjX3ZhbCAvIG51bV9vZl9ydW5zOwotCWF2Z19kaWZmID0gKGxvbmcp
YWJzKGNhY2hlX3NwYW4gLSBhdmdfbGxjX3ZhbCk7CisJYXZnX2RpZmYgPSAobG9uZykoY2Fj
aGVfc3BhbiAtIGF2Z19sbGNfdmFsKTsKIAlkaWZmX3BlcmNlbnQgPSAoKGZsb2F0KWNhY2hl
X3NwYW4gLSBhdmdfbGxjX3ZhbCkgLyBjYWNoZV9zcGFuICogMTAwOwogCiAJcmV0ID0gcGxh
dGZvcm0gJiYgYWJzKChpbnQpZGlmZl9wZXJjZW50KSA+IG1heF9kaWZmX3BlcmNlbnQgJiYK
LQkgICAgICBhYnMoYXZnX2RpZmYpID4gbWF4X2RpZmY7CisJICAgICAgbGFicyhhdmdfZGlm
ZikgPiBtYXhfZGlmZjsKIAogCWtzZnRfcHJpbnRfbXNnKCIlcyBDaGVjayBjYWNoZSBtaXNz
IHJhdGUgd2l0aGluICVsdSUlXG4iLAogCQkgICAgICAgcmV0ID8gIkZhaWw6IiA6ICJQYXNz
OiIsIG1heF9kaWZmX3BlcmNlbnQpOwpAQCAtOTEsNyArOTEsNyBAQCBzdGF0aWMgaW50IGNo
ZWNrX3Jlc3VsdHMoc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtICpwYXJhbSwgc2l6ZV90IHNw
YW4sIGludCBub19vZgogCQkJCSBNQVhfRElGRiwgTUFYX0RJRkZfUEVSQ0VOVCwgcnVucyAt
IDEsIHRydWUpOwogfQogCi12b2lkIGNtdF90ZXN0X2NsZWFudXAodm9pZCkKK3N0YXRpYyB2
b2lkIGNtdF90ZXN0X2NsZWFudXAodm9pZCkKIHsKIAlyZW1vdmUoUkVTVUxUX0ZJTEVfTkFN
RSk7CiB9CkBAIC0xNjEsNyArMTYxLDYgQEAgc3RhdGljIGludCBjbXRfcnVuX3Rlc3QoY29u
c3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwgY29uc3Qgc3RydWN0IHVzZXJfcGFyYW0K
IAkJa3NmdF9wcmludF9tc2coIkludGVsIENNVCBtYXkgYmUgaW5hY2N1cmF0ZSB3aGVuIFN1
Yi1OVU1BIENsdXN0ZXJpbmcgaXMgZW5hYmxlZC4gQ2hlY2sgQklPUyBjb25maWd1cmF0aW9u
LlxuIik7CiAKIG91dDoKLQljbXRfdGVzdF9jbGVhbnVwKCk7CiAJZnJlZShzcGFuX3N0cik7
CiAKIAlyZXR1cm4gcmV0OwpAQCAtMTc4LDQgKzE3Nyw1IEBAIHN0cnVjdCByZXNjdHJsX3Rl
c3QgY210X3Rlc3QgPSB7CiAJLnJlc291cmNlID0gIkwzIiwKIAkuZmVhdHVyZV9jaGVjayA9
IGNtdF9mZWF0dXJlX2NoZWNrLAogCS5ydW5fdGVzdCA9IGNtdF9ydW5fdGVzdCwKKwkuY2xl
YW51cCA9IGNtdF90ZXN0X2NsZWFudXAsCiB9OwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmVzY3RybC9tYmFfdGVzdC5jCmluZGV4IDc5NDZlMzJlODVjOC4uYTZhZDM5YWFlMTYy
IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21iYV90ZXN0
LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9tYmFfdGVzdC5jCkBA
IC02MCw4ICs2MCw4IEBAIHN0YXRpYyBib29sIHNob3dfbWJhX2luZm8odW5zaWduZWQgbG9u
ZyAqYndfaW1jLCB1bnNpZ25lZCBsb25nICpid19yZXNjKQogCS8qIE1lbW9yeSBiYW5kd2lk
dGggZnJvbSAxMDAlIGRvd24gdG8gMTAlICovCiAJZm9yIChhbGxvY2F0aW9uID0gMDsgYWxs
b2NhdGlvbiA8IEFMTE9DQVRJT05fTUFYIC8gQUxMT0NBVElPTl9TVEVQOwogCSAgICAgYWxs
b2NhdGlvbisrKSB7Ci0JCXVuc2lnbmVkIGxvbmcgYXZnX2J3X2ltYywgYXZnX2J3X3Jlc2M7
CiAJCXVuc2lnbmVkIGxvbmcgc3VtX2J3X2ltYyA9IDAsIHN1bV9id19yZXNjID0gMDsKKwkJ
bG9uZyBhdmdfYndfaW1jLCBhdmdfYndfcmVzYzsKIAkJaW50IGF2Z19kaWZmX3BlcjsKIAkJ
ZmxvYXQgYXZnX2RpZmY7CiAKQEAgLTEzNyw3ICsxMzcsNyBAQCBzdGF0aWMgaW50IGNoZWNr
X3Jlc3VsdHModm9pZCkKIAlyZXR1cm4gc2hvd19tYmFfaW5mbyhid19pbWMsIGJ3X3Jlc2Mp
OwogfQogCi12b2lkIG1iYV90ZXN0X2NsZWFudXAodm9pZCkKK3N0YXRpYyB2b2lkIG1iYV90
ZXN0X2NsZWFudXAodm9pZCkKIHsKIAlyZW1vdmUoUkVTVUxUX0ZJTEVfTkFNRSk7CiB9CkBA
IC0xNTgsMTMgKzE1OCwxMCBAQCBzdGF0aWMgaW50IG1iYV9ydW5fdGVzdChjb25zdCBzdHJ1
Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LCBjb25zdCBzdHJ1Y3QgdXNlcl9wYXJhbQogCiAJcmV0
ID0gcmVzY3RybF92YWwodGVzdCwgdXBhcmFtcywgdXBhcmFtcy0+YmVuY2htYXJrX2NtZCwg
JnBhcmFtKTsKIAlpZiAocmV0KQotCQlnb3RvIG91dDsKKwkJcmV0dXJuIHJldDsKIAogCXJl
dCA9IGNoZWNrX3Jlc3VsdHMoKTsKIAotb3V0OgotCW1iYV90ZXN0X2NsZWFudXAoKTsKLQog
CXJldHVybiByZXQ7CiB9CiAKQEAgLTE4MCw0ICsxNzcsNSBAQCBzdHJ1Y3QgcmVzY3RybF90
ZXN0IG1iYV90ZXN0ID0gewogCS52ZW5kb3Jfc3BlY2lmaWMgPSBBUkNIX0lOVEVMLAogCS5m
ZWF0dXJlX2NoZWNrID0gbWJhX2ZlYXR1cmVfY2hlY2ssCiAJLnJ1bl90ZXN0ID0gbWJhX3J1
bl90ZXN0LAorCS5jbGVhbnVwID0gbWJhX3Rlc3RfY2xlYW51cCwKIH07CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL21ibV90ZXN0LmMKaW5kZXggZDY3ZmZhM2VjNjNh
Li42ZmVjNTFlMWZmNDYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jl
c2N0cmwvbWJtX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L21ibV90ZXN0LmMKQEAgLTE3LDggKzE3LDggQEAKIHN0YXRpYyBpbnQKIHNob3dfYndfaW5m
byh1bnNpZ25lZCBsb25nICpid19pbWMsIHVuc2lnbmVkIGxvbmcgKmJ3X3Jlc2MsIHNpemVf
dCBzcGFuKQogewotCXVuc2lnbmVkIGxvbmcgYXZnX2J3X2ltYyA9IDAsIGF2Z19id19yZXNj
ID0gMDsKIAl1bnNpZ25lZCBsb25nIHN1bV9id19pbWMgPSAwLCBzdW1fYndfcmVzYyA9IDA7
CisJbG9uZyBhdmdfYndfaW1jID0gMCwgYXZnX2J3X3Jlc2MgPSAwOwogCWludCBydW5zLCBy
ZXQsIGF2Z19kaWZmX3BlcjsKIAlmbG9hdCBhdmdfZGlmZiA9IDA7CiAKQEAgLTEwNSw3ICsx
MDUsNyBAQCBzdGF0aWMgaW50IG1ibV9zZXR1cChjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0
ICp0ZXN0LAogCXJldHVybiByZXQ7CiB9CiAKLXZvaWQgbWJtX3Rlc3RfY2xlYW51cCh2b2lk
KQorc3RhdGljIHZvaWQgbWJtX3Rlc3RfY2xlYW51cCh2b2lkKQogewogCXJlbW92ZShSRVNV
TFRfRklMRV9OQU1FKTsKIH0KQEAgLTEyNiwxNSArMTI2LDEyIEBAIHN0YXRpYyBpbnQgbWJt
X3J1bl90ZXN0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QsIGNvbnN0IHN0cnVj
dCB1c2VyX3BhcmFtCiAKIAlyZXQgPSByZXNjdHJsX3ZhbCh0ZXN0LCB1cGFyYW1zLCB1cGFy
YW1zLT5iZW5jaG1hcmtfY21kLCAmcGFyYW0pOwogCWlmIChyZXQpCi0JCWdvdG8gb3V0Owor
CQlyZXR1cm4gcmV0OwogCiAJcmV0ID0gY2hlY2tfcmVzdWx0cyhERUZBVUxUX1NQQU4pOwog
CWlmIChyZXQgJiYgKGdldF92ZW5kb3IoKSA9PSBBUkNIX0lOVEVMKSkKIAkJa3NmdF9wcmlu
dF9tc2coIkludGVsIE1CTSBtYXkgYmUgaW5hY2N1cmF0ZSB3aGVuIFN1Yi1OVU1BIENsdXN0
ZXJpbmcgaXMgZW5hYmxlZC4gQ2hlY2sgQklPUyBjb25maWd1cmF0aW9uLlxuIik7CiAKLW91
dDoKLQltYm1fdGVzdF9jbGVhbnVwKCk7Ci0KIAlyZXR1cm4gcmV0OwogfQogCkBAIC0xNTAs
NCArMTQ3LDUgQEAgc3RydWN0IHJlc2N0cmxfdGVzdCBtYm1fdGVzdCA9IHsKIAkudmVuZG9y
X3NwZWNpZmljID0gQVJDSF9JTlRFTCwKIAkuZmVhdHVyZV9jaGVjayA9IG1ibV9mZWF0dXJl
X2NoZWNrLAogCS5ydW5fdGVzdCA9IG1ibV9ydW5fdGVzdCwKKwkuY2xlYW51cCA9IG1ibV90
ZXN0X2NsZWFudXAsCiB9OwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9yZXNjdHJsLmggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jl
c2N0cmwuaAppbmRleCAyMDUxYmQxMzVlMGQuLjAwZDUxZmE3NTMxYyAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmgKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmgKQEAgLTcyLDYgKzcyLDcgQEAg
c3RydWN0IHVzZXJfcGFyYW1zIHsKICAqIEBkaXNhYmxlZDoJCVRlc3QgaXMgZGlzYWJsZWQK
ICAqIEBmZWF0dXJlX2NoZWNrOglDYWxsYmFjayB0byBjaGVjayByZXF1aXJlZCByZXNjdHJs
IGZlYXR1cmVzCiAgKiBAcnVuX3Rlc3Q6CQlDYWxsYmFjayB0byBydW4gdGhlIHRlc3QKKyAq
IEBjbGVhbnVwOgkJQ2FsbGJhY2sgdG8gY2xlYW51cCBhZnRlciB0aGUgdGVzdAogICovCiBz
dHJ1Y3QgcmVzY3RybF90ZXN0IHsKIAljb25zdCBjaGFyCSpuYW1lOwpAQCAtODIsNiArODMs
NyBAQCBzdHJ1Y3QgcmVzY3RybF90ZXN0IHsKIAlib29sCQkoKmZlYXR1cmVfY2hlY2spKGNv
bnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QpOwogCWludAkJKCpydW5fdGVzdCkoY29u
c3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCwKIAkJCQkgICAgY29uc3Qgc3RydWN0IHVz
ZXJfcGFyYW1zICp1cGFyYW1zKTsKKwl2b2lkCQkoKmNsZWFudXApKHZvaWQpOwogfTsKIAog
LyoKQEAgLTE1Niw5ICsxNTgsNiBAQCBpbnQgcmVzY3RybF92YWwoY29uc3Qgc3RydWN0IHJl
c2N0cmxfdGVzdCAqdGVzdCwKIAkJY29uc3Qgc3RydWN0IHVzZXJfcGFyYW1zICp1cGFyYW1z
LAogCQljb25zdCBjaGFyICogY29uc3QgKmJlbmNobWFya19jbWQsCiAJCXN0cnVjdCByZXNj
dHJsX3ZhbF9wYXJhbSAqcGFyYW0pOwotdm9pZCB0ZXN0c19jbGVhbnVwKHZvaWQpOwotdm9p
ZCBtYm1fdGVzdF9jbGVhbnVwKHZvaWQpOwotdm9pZCBtYmFfdGVzdF9jbGVhbnVwKHZvaWQp
OwogdW5zaWduZWQgbG9uZyBjcmVhdGVfYml0X21hc2sodW5zaWduZWQgaW50IHN0YXJ0LCB1
bnNpZ25lZCBpbnQgbGVuKTsKIHVuc2lnbmVkIGludCBjb3VudF9jb250aWd1b3VzX2JpdHMo
dW5zaWduZWQgbG9uZyB2YWwsIHVuc2lnbmVkIGludCAqc3RhcnQpOwogaW50IGdldF9mdWxs
X2NibShjb25zdCBjaGFyICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICptYXNrKTsKQEAg
LTE2NiwxMSArMTY1LDkgQEAgaW50IGdldF9tYXNrX25vX3NoYXJlYWJsZShjb25zdCBjaGFy
ICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICptYXNrKTsKIGludCBnZXRfY2FjaGVfc2l6
ZShpbnQgY3B1X25vLCBjb25zdCBjaGFyICpjYWNoZV90eXBlLCB1bnNpZ25lZCBsb25nICpj
YWNoZV9zaXplKTsKIGludCByZXNvdXJjZV9pbmZvX3Vuc2lnbmVkX2dldChjb25zdCBjaGFy
ICpyZXNvdXJjZSwgY29uc3QgY2hhciAqZmlsZW5hbWUsIHVuc2lnbmVkIGludCAqdmFsKTsK
IHZvaWQgY3RybGNfaGFuZGxlcihpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQg
KnB0cik7Ci1pbnQgc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIodm9pZCk7CitpbnQgc2lnbmFs
X2hhbmRsZXJfcmVnaXN0ZXIoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCk7CiB2
b2lkIHNpZ25hbF9oYW5kbGVyX3VucmVnaXN0ZXIodm9pZCk7Ci12b2lkIGNhdF90ZXN0X2Ns
ZWFudXAodm9pZCk7CiB1bnNpZ25lZCBpbnQgY291bnRfYml0cyh1bnNpZ25lZCBsb25nIG4p
Owotdm9pZCBjbXRfdGVzdF9jbGVhbnVwKHZvaWQpOwogCiB2b2lkIHBlcmZfZXZlbnRfYXR0
cl9pbml0aWFsaXplKHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgKnBlYSwgX191NjQgY29uZmln
KTsKIHZvaWQgcGVyZl9ldmVudF9pbml0aWFsaXplX3JlYWRfZm9ybWF0KHN0cnVjdCBwZXJm
X2V2ZW50X3JlYWQgKnBlX3JlYWQpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYwppbmRleCBmM2RjMWI5Njk2ZTcuLmVjYmI3NjA1
YTk4MSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNj
dHJsX3Rlc3RzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNj
dHJsX3Rlc3RzLmMKQEAgLTgxLDE5ICs4MSwxMSBAQCBzdGF0aWMgdm9pZCBjbWRfaGVscCh2
b2lkKQogCXByaW50ZigiXHQtaDogaGVscFxuIik7CiB9CiAKLXZvaWQgdGVzdHNfY2xlYW51
cCh2b2lkKQotewotCW1ibV90ZXN0X2NsZWFudXAoKTsKLQltYmFfdGVzdF9jbGVhbnVwKCk7
Ci0JY210X3Rlc3RfY2xlYW51cCgpOwotCWNhdF90ZXN0X2NsZWFudXAoKTsKLX0KLQotc3Rh
dGljIGludCB0ZXN0X3ByZXBhcmUodm9pZCkKK3N0YXRpYyBpbnQgdGVzdF9wcmVwYXJlKGNv
bnN0IHN0cnVjdCByZXNjdHJsX3Rlc3QgKnRlc3QpCiB7CiAJaW50IHJlczsKIAotCXJlcyA9
IHNpZ25hbF9oYW5kbGVyX3JlZ2lzdGVyKCk7CisJcmVzID0gc2lnbmFsX2hhbmRsZXJfcmVn
aXN0ZXIodGVzdCk7CiAJaWYgKHJlcykgewogCQlrc2Z0X3ByaW50X21zZygiRmFpbGVkIHRv
IHJlZ2lzdGVyIHNpZ25hbCBoYW5kbGVyXG4iKTsKIAkJcmV0dXJuIHJlczsKQEAgLTEwOCw4
ICsxMDAsMTAgQEAgc3RhdGljIGludCB0ZXN0X3ByZXBhcmUodm9pZCkKIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIHZvaWQgdGVzdF9jbGVhbnVwKHZvaWQpCitzdGF0aWMgdm9pZCB0ZXN0
X2NsZWFudXAoY29uc3Qgc3RydWN0IHJlc2N0cmxfdGVzdCAqdGVzdCkKIHsKKwlpZiAodGVz
dC0+Y2xlYW51cCkKKwkJdGVzdC0+Y2xlYW51cCgpOwogCXVtb3VudF9yZXNjdHJsZnMoKTsK
IAlzaWduYWxfaGFuZGxlcl91bnJlZ2lzdGVyKCk7CiB9CkBAIC0xMzYsNyArMTMwLDcgQEAg
c3RhdGljIHZvaWQgcnVuX3NpbmdsZV90ZXN0KGNvbnN0IHN0cnVjdCByZXNjdHJsX3Rlc3Qg
KnRlc3QsIGNvbnN0IHN0cnVjdCB1c2VyX3AKIAogCWtzZnRfcHJpbnRfbXNnKCJTdGFydGlu
ZyAlcyB0ZXN0IC4uLlxuIiwgdGVzdC0+bmFtZSk7CiAKLQlpZiAodGVzdF9wcmVwYXJlKCkp
IHsKKwlpZiAodGVzdF9wcmVwYXJlKHRlc3QpKSB7CiAJCWtzZnRfZXhpdF9mYWlsX21zZygi
QWJub3JtYWwgZmFpbHVyZSB3aGVuIHByZXBhcmluZyBmb3IgdGhlIHRlc3RcbiIpOwogCQly
ZXR1cm47CiAJfQpAQCAtMTUxLDcgKzE0NSw3IEBAIHN0YXRpYyB2b2lkIHJ1bl9zaW5nbGVf
dGVzdChjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0LCBjb25zdCBzdHJ1Y3QgdXNl
cl9wCiAJa3NmdF90ZXN0X3Jlc3VsdCghcmV0LCAiJXM6IHRlc3RcbiIsIHRlc3QtPm5hbWUp
OwogCiBjbGVhbnVwOgotCXRlc3RfY2xlYW51cCgpOworCXRlc3RfY2xlYW51cCh0ZXN0KTsK
IH0KIAogc3RhdGljIHZvaWQgaW5pdF91c2VyX3BhcmFtcyhzdHJ1Y3QgdXNlcl9wYXJhbXMg
KnVwYXJhbXMpCkBAIC0yNTMsMTMgKzI0NywxMyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCiAJICogMi4gV2UgZXhlY3V0ZSBwZXJmIGNvbW1hbmRzCiAJICovCiAJaWYg
KGdldGV1aWQoKSAhPSAwKQotCQlyZXR1cm4ga3NmdF9leGl0X3NraXAoIk5vdCBydW5uaW5n
IGFzIHJvb3QuIFNraXBwaW5nLi4uXG4iKTsKKwkJa3NmdF9leGl0X3NraXAoIk5vdCBydW5u
aW5nIGFzIHJvb3QuIFNraXBwaW5nLi4uXG4iKTsKIAogCWlmICghY2hlY2tfcmVzY3RybGZz
X3N1cHBvcnQoKSkKLQkJcmV0dXJuIGtzZnRfZXhpdF9za2lwKCJyZXNjdHJsIEZTIGRvZXMg
bm90IGV4aXN0LiBFbmFibGUgWDg2X0NQVV9SRVNDVFJMIGNvbmZpZyBvcHRpb24uXG4iKTsK
KwkJa3NmdF9leGl0X3NraXAoInJlc2N0cmwgRlMgZG9lcyBub3QgZXhpc3QuIEVuYWJsZSBY
ODZfQ1BVX1JFU0NUUkwgY29uZmlnIG9wdGlvbi5cbiIpOwogCiAJaWYgKHVtb3VudF9yZXNj
dHJsZnMoKSkKLQkJcmV0dXJuIGtzZnRfZXhpdF9za2lwKCJyZXNjdHJsIEZTIHVubW91bnQg
ZmFpbGVkLlxuIik7CisJCWtzZnRfZXhpdF9za2lwKCJyZXNjdHJsIEZTIHVubW91bnQgZmFp
bGVkLlxuIik7CiAKIAlmaWx0ZXJfZG1lc2coKTsKIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3ZhbC5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3ZhbC5jCmluZGV4IDVhNDlmMDdhNmM4NS4uNDQ1
ZjMwNmQ0YzJmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
L3Jlc2N0cmxfdmFsLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9y
ZXNjdHJsX3ZhbC5jCkBAIC02Miw2ICs2Miw3IEBAIHN0cnVjdCBpbWNfY291bnRlcl9jb25m
aWcgewogc3RhdGljIGNoYXIgbWJtX3RvdGFsX3BhdGhbMTAyNF07CiBzdGF0aWMgaW50IGlt
Y3M7CiBzdGF0aWMgc3RydWN0IGltY19jb3VudGVyX2NvbmZpZyBpbWNfY291bnRlcnNfY29u
ZmlnW01BWF9JTUNTXVsyXTsKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICpj
dXJyZW50X3Rlc3Q7CiAKIHZvaWQgbWVtYndfaW5pdGlhbGl6ZV9wZXJmX2V2ZW50X2F0dHIo
aW50IGksIGludCBqKQogewpAQCAtNDcyLDcgKzQ3Myw4IEBAIHZvaWQgY3RybGNfaGFuZGxl
cihpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKnB0cikKIAlpZiAoYm1fcGlk
KQogCQlraWxsKGJtX3BpZCwgU0lHS0lMTCk7CiAJdW1vdW50X3Jlc2N0cmxmcygpOwotCXRl
c3RzX2NsZWFudXAoKTsKKwlpZiAoY3VycmVudF90ZXN0ICYmIGN1cnJlbnRfdGVzdC0+Y2xl
YW51cCkKKwkJY3VycmVudF90ZXN0LT5jbGVhbnVwKCk7CiAJa3NmdF9wcmludF9tc2coIkVu
ZGluZ1xuXG4iKTsKIAogCWV4aXQoRVhJVF9TVUNDRVNTKTsKQEAgLTQ4MiwxMyArNDg0LDE0
IEBAIHZvaWQgY3RybGNfaGFuZGxlcihpbnQgc2lnbnVtLCBzaWdpbmZvX3QgKmluZm8sIHZv
aWQgKnB0cikKICAqIFJlZ2lzdGVyIENUUkwtQyBoYW5kbGVyIGZvciBwYXJlbnQsIGFzIGl0
IGhhcyB0byBraWxsCiAgKiBjaGlsZCBwcm9jZXNzIGJlZm9yZSBleGl0aW5nLgogICovCi1p
bnQgc2lnbmFsX2hhbmRsZXJfcmVnaXN0ZXIodm9pZCkKK2ludCBzaWduYWxfaGFuZGxlcl9y
ZWdpc3Rlcihjb25zdCBzdHJ1Y3QgcmVzY3RybF90ZXN0ICp0ZXN0KQogewogCXN0cnVjdCBz
aWdhY3Rpb24gc2lnYWN0ID0ge307CiAJaW50IHJldCA9IDA7CiAKIAlibV9waWQgPSAwOwog
CisJY3VycmVudF90ZXN0ID0gdGVzdDsKIAlzaWdhY3Quc2Ffc2lnYWN0aW9uID0gY3RybGNf
aGFuZGxlcjsKIAlzaWdlbXB0eXNldCgmc2lnYWN0LnNhX21hc2spOwogCXNpZ2FjdC5zYV9m
bGFncyA9IFNBX1NJR0lORk87CkBAIC01MTAsNiArNTEzLDcgQEAgdm9pZCBzaWduYWxfaGFu
ZGxlcl91bnJlZ2lzdGVyKHZvaWQpCiB7CiAJc3RydWN0IHNpZ2FjdGlvbiBzaWdhY3QgPSB7
fTsKIAorCWN1cnJlbnRfdGVzdCA9IE5VTEw7CiAJc2lnYWN0LnNhX2hhbmRsZXIgPSBTSUdf
REZMOwogCXNpZ2VtcHR5c2V0KCZzaWdhY3Quc2FfbWFzayk7CiAJaWYgKHNpZ2FjdGlvbihT
SUdJTlQsICZzaWdhY3QsIE5VTEwpIHx8CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvTWFr
ZWZpbGUKaW5kZXggODY3Zjg4Y2UyNTcwLi4yNmVhMzBmYWUyM2MgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZQorKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9zZ3gvTWFrZWZpbGUKQEAgLTEyLDcgKzEyLDcgQEAgT0JKQ09QWSA6PSAk
KENST1NTX0NPTVBJTEUpb2JqY29weQogZW5kaWYKIAogSU5DTFVERVMgOj0gLUkkKHRvcF9z
cmNkaXIpL3Rvb2xzL2luY2x1ZGUKLUhPU1RfQ0ZMQUdTIDo9IC1XYWxsIC1XZXJyb3IgLWcg
JChJTkNMVURFUykgLWZQSUMKK0hPU1RfQ0ZMQUdTIDo9IC1XYWxsIC1XZXJyb3IgJChLSERS
X0lOQ0xVREVTKSAtZyAkKElOQ0xVREVTKSAtZlBJQwogSE9TVF9MREZMQUdTIDo9IC16IG5v
ZXhlY3N0YWNrIC1sY3J5cHRvCiBFTkNMX0NGTEFHUyArPSAtV2FsbCAtV2Vycm9yIC1zdGF0
aWMtcGllIC1ub3N0ZGxpYiAtZmZyZWVzdGFuZGluZyAtZlBJRSBcCiAJICAgICAgIC1mbm8t
c3RhY2stcHJvdGVjdG9yIC1tcmRybmQgJChJTkNMVURFUykKZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYwppbmRleCBkNzNiMjliZWNmNWIuLjIwMDAzNGEwZmVl
NSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3NpZ3N0cnVjdC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYwpAQCAtMSw3
ICsxLDYgQEAKIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAvKiAgQ29w
eXJpZ2h0KGMpIDIwMTYtMjAgSW50ZWwgQ29ycG9yYXRpb24uICovCiAKLSNkZWZpbmUgX0dO
VV9TT1VSQ0UKICNpbmNsdWRlIDxhc3NlcnQuaD4KICNpbmNsdWRlIDxnZXRvcHQuaD4KICNp
bmNsdWRlIDxzdGRib29sLmg+CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9zeW5jL3N5bmNfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc3luYy9zeW5j
X3Rlc3QuYwppbmRleCA0MTRhNjE3ZGI5OTMuLjkzZGI1YWEyNDZhMyAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc3luYy9zeW5jX3Rlc3QuYworKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zeW5jL3N5bmNfdGVzdC5jCkBAIC0xMDksNiArMTA5LDUgQEAg
aW50IG1haW4odm9pZCkKIAkJa3NmdF9leGl0X2ZhaWxfbXNnKCIlZCBvdXQgb2YgJWQgc3lu
YyB0ZXN0cyBmYWlsZWRcbiIsCiAJCQkJCWVyciwga3NmdF90ZXN0X251bSgpKTsKIAotCS8q
IG5lZWQgdGhpcyByZXR1cm4gdG8ga2VlcCBnY2MgaGFwcHkgKi8KLQlyZXR1cm4ga3NmdF9l
eGl0X3Bhc3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL2FkanRpY2suYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RpbWVycy9hZGp0aWNrLmMKaW5kZXggNDdlMDVmZGMzMmM1Li4yMDViNzZhNGFi
YjQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9hZGp0aWNr
LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL2FkanRpY2suYwpAQCAt
MjA1LDcgKzIwNSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlhZGp0
aW1leCgmdHgxKTsKIAogCWlmIChlcnIpCi0JCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOwor
CQlrc2Z0X2V4aXRfZmFpbCgpOwogCi0JcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJa3Nm
dF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3RpbWVycy9hbGFybXRpbWVyLXN1c3BlbmQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3RpbWVycy9hbGFybXRpbWVyLXN1c3BlbmQuYwppbmRleCA0MzMyYjQ5NDEwM2QuLmFkNTJl
NjA4Yjg4ZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL2Fs
YXJtdGltZXItc3VzcGVuZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVy
cy9hbGFybXRpbWVyLXN1c3BlbmQuYwpAQCAtMTczLDYgKzE3Myw2IEBAIGludCBtYWluKHZv
aWQpCiAJCXRpbWVyX2RlbGV0ZSh0bTEpOwogCX0KIAlpZiAoZmluYWxfcmV0KQotCQlyZXR1
cm4ga3NmdF9leGl0X2ZhaWwoKTsKLQlyZXR1cm4ga3NmdF9leGl0X3Bhc3MoKTsKKwkJa3Nm
dF9leGl0X2ZhaWwoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL2NoYW5nZV9za2V3LmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy90aW1lcnMvY2hhbmdlX3NrZXcuYwppbmRleCA5OTJhNzdmMmE3NGMu
LjQ0MjFjZDU2MmMyNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGlt
ZXJzL2NoYW5nZV9za2V3LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJz
L2NoYW5nZV9za2V3LmMKQEAgLTg5LDggKzg5LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCiAJaWYgKHJldCkgewogCQlwcmludGYoIltGQUlMXSIpOwotCQlyZXR1
cm4ga3NmdF9leGl0X2ZhaWwoKTsKKwkJa3NmdF9leGl0X2ZhaWwoKTsKIAl9CiAJcHJpbnRm
KCJbT0tdIik7Ci0JcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJa3NmdF9leGl0X3Bhc3Mo
KTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9mcmVx
LXN0ZXAuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9mcmVxLXN0ZXAuYwpp
bmRleCA0Yjc2NDUwZDc4ZDEuLjczYjYzNmY4OWZkYyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdGltZXJzL2ZyZXEtc3RlcC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3RpbWVycy9mcmVxLXN0ZXAuYwpAQCAtMjU3LDcgKzI1Nyw3IEBAIGludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlzZXRfZnJlcXVlbmN5KDAuMCk7CiAKIAlp
ZiAoZmFpbHMpCi0JCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOworCQlrc2Z0X2V4aXRfZmFp
bCgpOwogCi0JcmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsK
IH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9sZWFwLWEt
ZGF5LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvbGVhcC1hLWRheS5jCmlu
ZGV4IDIzZWIzOThjODE0MC4uOTg2YWJiZGIxNTIxIDEwMDY0NAotLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy90aW1lcnMvbGVhcC1hLWRheS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3RpbWVycy9sZWFwLWEtZGF5LmMKQEAgLTI2OCw3ICsyNjgsNyBAQCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCWlmIChyZXQgPCAwKSB7CiAJCQlwcmlu
dGYoIkVycm9yOiBQcm9ibGVtIHNldHRpbmcgU1RBX0lOUy9TVEFfREVMITogJXNcbiIsCiAJ
CQkJCQkJdGltZV9zdGF0ZV9zdHIocmV0KSk7Ci0JCQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwo
KTsKKwkJCWtzZnRfZXhpdF9mYWlsKCk7CiAJCX0KIAogCQkvKiBWYWxpZGF0ZSBTVEFfSU5T
IHdhcyBzZXQgKi8KQEAgLTI3Nyw3ICsyNzcsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCiAJCWlmICh0eC5zdGF0dXMgIT0gU1RBX0lOUyAmJiB0eC5zdGF0dXMgIT0g
U1RBX0RFTCkgewogCQkJcHJpbnRmKCJFcnJvcjogU1RBX0lOUy9TVEFfREVMIG5vdCBzZXQh
OiAlc1xuIiwKIAkJCQkJCQl0aW1lX3N0YXRlX3N0cihyZXQpKTsKLQkJCXJldHVybiBrc2Z0
X2V4aXRfZmFpbCgpOworCQkJa3NmdF9leGl0X2ZhaWwoKTsKIAkJfQogCiAJCWlmICh0YWlf
dGltZSkgewpAQCAtMjk1LDcgKzI5NSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoq
YXJndikKIAkJc2Uuc2lnZXZfdmFsdWUuc2l2YWxfaW50ID0gMDsKIAkJaWYgKHRpbWVyX2Ny
ZWF0ZShDTE9DS19SRUFMVElNRSwgJnNlLCAmdG0xKSA9PSAtMSkgewogCQkJcHJpbnRmKCJF
cnJvcjogdGltZXJfY3JlYXRlIGZhaWxlZFxuIik7Ci0JCQlyZXR1cm4ga3NmdF9leGl0X2Zh
aWwoKTsKKwkJCWtzZnRfZXhpdF9mYWlsKCk7CiAJCX0KIAkJaXRzMS5pdF92YWx1ZS50dl9z
ZWMgPSBuZXh0X2xlYXA7CiAJCWl0czEuaXRfdmFsdWUudHZfbnNlYyA9IDA7CkBAIC0zNjYs
NyArMzY2LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQlpZiAoZXJy
b3JfZm91bmQpIHsKIAkJCXByaW50ZigiRXJyb3JzIG9ic2VydmVkXG4iKTsKIAkJCWNsZWFy
X3RpbWVfc3RhdGUoKTsKLQkJCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOworCQkJa3NmdF9l
eGl0X2ZhaWwoKTsKIAkJfQogCQlwcmludGYoIlxuIik7CiAJCWlmICgoaXRlcmF0aW9ucyAh
PSAtMSkgJiYgISgtLWl0ZXJhdGlvbnMpKQpAQCAtMzc0LDUgKzM3NCw1IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKIAl9CiAKIAljbGVhcl90aW1lX3N0YXRlKCk7Ci0J
cmV0dXJuIGtzZnRfZXhpdF9wYXNzKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9sZWFwY3Jhc2guYyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9sZWFwY3Jhc2guYwppbmRleCBmNzA4MDJj
NWRkMGQuLjhmZDA2NWVlYzkwNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGltZXJzL2xlYXBjcmFzaC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Rp
bWVycy9sZWFwY3Jhc2guYwpAQCAtODcsNyArODcsNyBAQCBpbnQgbWFpbih2b2lkKQogCQl0
di50dl91c2VjID0gMDsKIAkJaWYgKHNldHRpbWVvZmRheSgmdHYsIE5VTEwpKSB7CiAJCQlw
cmludGYoIkVycm9yOiBZb3UncmUgbGlrZWx5IG5vdCBydW5uaW5nIHdpdGggcHJvcGVyIChp
ZTogcm9vdCkgcGVybWlzc2lvbnNcbiIpOwotCQkJcmV0dXJuIGtzZnRfZXhpdF9mYWlsKCk7
CisJCQlrc2Z0X2V4aXRfZmFpbCgpOwogCQl9CiAJCXR4Lm1vZGVzID0gMDsKIAkJYWRqdGlt
ZXgoJnR4KTsKQEAgLTEwNCw1ICsxMDQsNSBAQCBpbnQgbWFpbih2b2lkKQogCQlmZmx1c2go
c3Rkb3V0KTsKIAl9CiAJcHJpbnRmKCJbT0tdXG4iKTsKLQlyZXR1cm4ga3NmdF9leGl0X3Bh
c3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdGltZXJzL21xdWV1ZS1sYXQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVycy9tcXVldWUtbGF0LmMKaW5kZXggNzkxNmNmNWNjNmZmLi5mMzE3OWE2MDVi
YmEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9tcXVldWUt
bGF0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL21xdWV1ZS1sYXQu
YwpAQCAtMTA3LDggKzEwNyw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAlyZXQgPSBtcXVldWVfbGF0X3Rlc3QoKTsKIAlpZiAocmV0IDwgMCkgewogCQlwcmludGYo
IltGQUlMRURdXG4iKTsKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWlsKCk7CisJCWtzZnRfZXhp
dF9mYWlsKCk7CiAJfQogCXByaW50ZigiW09LXVxuIik7Ci0JcmV0dXJuIGtzZnRfZXhpdF9w
YXNzKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3RpbWVycy9wb3NpeF90aW1lcnMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RpbWVycy9wb3NpeF90aW1lcnMuYwppbmRleCBjMDAxZGQ3OTE3OWQuLjA3Yzgx
YzAwOTNjMCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3Bv
c2l4X3RpbWVycy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3Np
eF90aW1lcnMuYwpAQCAtMjYwLDE2ICsyNjAsMTYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQogCWtzZnRfcHJpbnRfbXNnKCJiYXNlZCB0aW1lcnMgaWYgb3RoZXIgdGhy
ZWFkcyBydW4gb24gdGhlIENQVS4uLlxuIik7CiAKIAlpZiAoY2hlY2tfaXRpbWVyKElUSU1F
Ul9WSVJUVUFMKSA8IDApCi0JCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOworCQlrc2Z0X2V4
aXRfZmFpbCgpOwogCiAJaWYgKGNoZWNrX2l0aW1lcihJVElNRVJfUFJPRikgPCAwKQotCQly
ZXR1cm4ga3NmdF9leGl0X2ZhaWwoKTsKKwkJa3NmdF9leGl0X2ZhaWwoKTsKIAogCWlmIChj
aGVja19pdGltZXIoSVRJTUVSX1JFQUwpIDwgMCkKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWls
KCk7CisJCWtzZnRfZXhpdF9mYWlsKCk7CiAKIAlpZiAoY2hlY2tfdGltZXJfY3JlYXRlKENM
T0NLX1RIUkVBRF9DUFVUSU1FX0lEKSA8IDApCi0JCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgp
OworCQlrc2Z0X2V4aXRfZmFpbCgpOwogCiAJLyoKIAkgKiBJdCdzIHVuZm9ydHVuYXRlbHkg
aGFyZCB0byByZWxpYWJseSB0ZXN0IGEgdGltZXIgZXhwaXJhdGlvbgpAQCAtMjgxLDEwICsy
ODEsMTAgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCSAqIGZpbmQgYSBi
ZXR0ZXIgc29sdXRpb24uCiAJICovCiAJaWYgKGNoZWNrX3RpbWVyX2NyZWF0ZShDTE9DS19Q
Uk9DRVNTX0NQVVRJTUVfSUQpIDwgMCkKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWlsKCk7CisJ
CWtzZnRfZXhpdF9mYWlsKCk7CiAKIAlpZiAoY2hlY2tfdGltZXJfZGlzdHJpYnV0aW9uKCkg
PCAwKQotCQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwoKTsKKwkJa3NmdF9leGl0X2ZhaWwoKTsK
IAogCWtzZnRfZmluaXNoZWQoKTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RpbWVycy9yYXdfc2tldy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGlt
ZXJzL3Jhd19za2V3LmMKaW5kZXggNmViYTIwM2Y5ZGE3Li4wMzAxNDNlYjA5YjQgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9yYXdfc2tldy5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9yYXdfc2tldy5jCkBAIC0xMzcsMTEg
KzEzNywxMSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCWlmICh0eDEu
b2Zmc2V0IHx8IHR4Mi5vZmZzZXQgfHwKIAkJICAgIHR4MS5mcmVxICE9IHR4Mi5mcmVxIHx8
IHR4MS50aWNrICE9IHR4Mi50aWNrKSB7CiAJCQlwcmludGYoIglbU0tJUF1cbiIpOwotCQkJ
cmV0dXJuIGtzZnRfZXhpdF9za2lwKCJUaGUgY2xvY2sgd2FzIGFkanVzdGVkIGV4dGVybmFs
bHkuIFNodXRkb3duIE5UUGQgb3Igb3RoZXIgdGltZSBzeW5jIGRhZW1vbnNcbiIpOworCQkJ
a3NmdF9leGl0X3NraXAoIlRoZSBjbG9jayB3YXMgYWRqdXN0ZWQgZXh0ZXJuYWxseS4gU2h1
dGRvd24gTlRQZCBvciBvdGhlciB0aW1lIHN5bmMgZGFlbW9uc1xuIik7CiAJCX0KIAkJcHJp
bnRmKCIJW0ZBSUxFRF1cbiIpOwotCQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwoKTsKKwkJa3Nm
dF9leGl0X2ZhaWwoKTsKIAl9CiAJcHJpbnRmKCIJW09LXVxuIik7Ci0JcmV0dXJuICBrc2Z0
X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LTIwMzguYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3RpbWVycy9zZXQtMjAzOC5jCmluZGV4IDY4OGNmZDgxYjUzMS4uZjdkOTc4
NzIxYjllIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0
LTIwMzguYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LTIwMzgu
YwpAQCAtMTI4LDYgKzEyOCw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
CiAJLyogcmVzdG9yZSBjbG9jayAqLwogCXNldHRpbWUoc3RhcnQpOwogCWlmIChyZXQpCi0J
CXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOwor
CQlrc2Z0X2V4aXRfZmFpbCgpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LXRhaS5jIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdGltZXJzL3NldC10YWkuYwppbmRleCA4YzQxNzllZTJjYTIuLjVi
Njc0NjJlZmNkNiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJz
L3NldC10YWkuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LXRh
aS5jCkBAIC02MSw5ICs2MSw5IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikK
IAkJcmV0ID0gZ2V0X3RhaSgpOwogCQlpZiAocmV0ICE9IGkpIHsKIAkJCXByaW50ZigiW0ZB
SUxFRF0gZXhwZWN0ZWQ6ICVpIGdvdCAlaVxuIiwgaSwgcmV0KTsKLQkJCXJldHVybiBrc2Z0
X2V4aXRfZmFpbCgpOworCQkJa3NmdF9leGl0X2ZhaWwoKTsKIAkJfQogCX0KIAlwcmludGYo
IltPS11cbiIpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOworCWtzZnRfZXhpdF9wYXNz
KCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0
LXRpbWVyLWxhdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3NldC10aW1l
ci1sYXQuYwppbmRleCA1MGRhNDU0MzdkYWEuLjdjZTI0MGM4OWIyMSAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3NldC10aW1lci1sYXQuYworKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LXRpbWVyLWxhdC5jCkBAIC0yNzgs
NiArMjc4LDYgQEAgaW50IG1haW4odm9pZCkKIAkJcmV0IHw9IGRvX3RpbWVyX29uZXNob3Qo
Y2xvY2tfaWQsIDApOwogCX0KIAlpZiAocmV0KQotCQlyZXR1cm4ga3NmdF9leGl0X2ZhaWwo
KTsKLQlyZXR1cm4ga3NmdF9leGl0X3Bhc3MoKTsKKwkJa3NmdF9leGl0X2ZhaWwoKTsKKwlr
c2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGltZXJzL3NldC10ei5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3Nl
dC10ei5jCmluZGV4IDYyYmQzM2ViMTZmMC4uMjBkYWFmMTc4MmI3IDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2V0LXR6LmMKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdGltZXJzL3NldC10ei5jCkBAIC0xMDIsOSArMTAyLDkgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCXByaW50ZigiW09LXVxuIik7CiAKIAlz
ZXRfdHoobWluLCBkc3QpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFzcygpOworCWtzZnRfZXhp
dF9wYXNzKCk7CiAKIGVycjoKIAlzZXRfdHoobWluLCBkc3QpOwotCXJldHVybiBrc2Z0X2V4
aXRfZmFpbCgpOworCWtzZnRfZXhpdF9mYWlsKCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvc2tld19jb25zaXN0ZW5jeS5jIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdGltZXJzL3NrZXdfY29uc2lzdGVuY3kuYwppbmRleCA2MzkxM2Y3
NWIzODQuLmM4ZTZiZmZlNGUwYSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGltZXJzL3NrZXdfY29uc2lzdGVuY3kuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy90aW1lcnMvc2tld19jb25zaXN0ZW5jeS5jCkBAIC03MCw4ICs3MCw4IEBAIGludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAogCWlmIChyZXQpIHsKIAkJcHJpbnRmKCJb
RkFJTEVEXVxuIik7Ci0JCXJldHVybiBrc2Z0X2V4aXRfZmFpbCgpOworCQlrc2Z0X2V4aXRf
ZmFpbCgpOwogCX0KIAlwcmludGYoIltPS11cbiIpOwotCXJldHVybiBrc2Z0X2V4aXRfcGFz
cygpOworCWtzZnRfZXhpdF9wYXNzKCk7CiB9CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy90aW1lcnMvdGhyZWFkdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGltZXJzL3RocmVhZHRlc3QuYwppbmRleCA4MGFlZDRiZjA2ZmIuLjc2YjM4ZTQxZDlj
NyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3RocmVhZHRl
c3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lcnMvdGhyZWFkdGVzdC5j
CkBAIC0xODksNSArMTg5LDUgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQog
CS8qIGRpZSAqLwogCWlmIChyZXQpCiAJCWtzZnRfZXhpdF9mYWlsKCk7Ci0JcmV0dXJuIGtz
ZnRfZXhpdF9wYXNzKCk7CisJa3NmdF9leGl0X3Bhc3MoKTsKIH0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy92YWxpZC1hZGp0aW1leC5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdGltZXJzL3ZhbGlkLWFkanRpbWV4LmMKaW5kZXggZDEzZWJk
ZTIwMzIyLi5kNTAwODg0ODAxZDggMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVycy92YWxpZC1hZGp0aW1leC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVycy92YWxpZC1hZGp0aW1leC5jCkBAIC0zMjAsMTAgKzMyMCwxMCBAQCBpbnQg
dmFsaWRhdGVfc2V0X29mZnNldCh2b2lkKQogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogewogCWlmICh2YWxpZGF0ZV9mcmVxKCkpCi0JCXJldHVybiBrc2Z0X2V4aXRfZmFp
bCgpOworCQlrc2Z0X2V4aXRfZmFpbCgpOwogCiAJaWYgKHZhbGlkYXRlX3NldF9vZmZzZXQo
KSkKLQkJcmV0dXJuIGtzZnRfZXhpdF9mYWlsKCk7CisJCWtzZnRfZXhpdF9mYWlsKCk7CiAK
LQlyZXR1cm4ga3NmdF9leGl0X3Bhc3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdHR5L3R0eV90c3RhbXBfdXBkYXRl
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90dHkvdHR5X3RzdGFtcF91cGRhdGUuYwpp
bmRleCAwZWU5Nzk0M2RjY2MuLjllMWE0MGY1ZGIxNyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdHR5L3R0eV90c3RhbXBfdXBkYXRlLmMKKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdHR5L3R0eV90c3RhbXBfdXBkYXRlLmMKQEAgLTQ3LDQyICs0Nyw2
MCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJaW50IHI7CiAJY2hhciB0
dHlbUEFUSF9NQVhdID0ge307CiAJc3RydWN0IHN0YXQgc3QxLCBzdDI7CisJaW50IHJlc3Vs
dCA9IEtTRlRfRkFJTDsKIAogCWtzZnRfcHJpbnRfaGVhZGVyKCk7CiAJa3NmdF9zZXRfcGxh
bigxKTsKIAogCXIgPSByZWFkbGluaygiL3Byb2Mvc2VsZi9mZC8wIiwgdHR5LCBQQVRIX01B
WCk7Ci0JaWYgKHIgPCAwKQotCQlrc2Z0X2V4aXRfZmFpbF9tc2coInJlYWRsaW5rIG9uIC9w
cm9jL3NlbGYvZmQvMCBmYWlsZWQ6ICVtXG4iKTsKKwlpZiAociA8IDApIHsKKwkJa3NmdF9w
cmludF9tc2coInJlYWRsaW5rIG9uIC9wcm9jL3NlbGYvZmQvMCBmYWlsZWQ6ICVtXG4iKTsK
KwkJZ290byBvdXQ7CisJfQorCisJaWYgKCF0dHlfdmFsaWQodHR5KSkgeworCQlrc2Z0X3By
aW50X21zZygiaW52YWxpZCB0dHkgcGF0aCAnJXMnXG4iLCB0dHkpOworCQlyZXN1bHQgPSBL
U0ZUX1NLSVA7CisJCWdvdG8gb3V0OwogCi0JaWYgKCF0dHlfdmFsaWQodHR5KSkKLQkJa3Nm
dF9leGl0X3NraXAoImludmFsaWQgdHR5IHBhdGggJyVzJ1xuIiwgdHR5KTsKKwl9CiAKIAly
ID0gc3RhdCh0dHksICZzdDEpOwotCWlmIChyIDwgMCkKLQkJa3NmdF9leGl0X2ZhaWxfbXNn
KCJzdGF0IGZhaWxlZCBvbiB0dHkgcGF0aCAnJXMnOiAlbVxuIiwgdHR5KTsKKwlpZiAociA8
IDApIHsKKwkJa3NmdF9wcmludF9tc2coInN0YXQgZmFpbGVkIG9uIHR0eSBwYXRoICclcyc6
ICVtXG4iLCB0dHkpOworCQlnb3RvIG91dDsKKwl9CiAKIAkvKiBXZSBuZWVkIHRvIHdhaXQg
YXQgbGVhc3QgOCBzZWNvbmRzIGluIG9yZGVyIHRvIG9ic2VydmUgdGltZXN0YW1wIGNoYW5n
ZSAqLwogCS8qIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWZiZjQ3NjM1MzE1YWIzMDhjOWI1
OGExZWEwOTA2ZTcxMWE5MjI4ZGUgKi8KIAlzbGVlcCgxMCk7CiAKIAlyID0gd3JpdGVfZGV2
X3R0eSgpOwotCWlmIChyIDwgMCkKLQkJa3NmdF9leGl0X2ZhaWxfbXNnKCJmYWlsZWQgdG8g
d3JpdGUgdG8gL2Rldi90dHk6ICVzXG4iLAotCQkJCSAgIHN0cmVycm9yKC1yKSk7CisJaWYg
KHIgPCAwKSB7CisJCWtzZnRfcHJpbnRfbXNnKCJmYWlsZWQgdG8gd3JpdGUgdG8gL2Rldi90
dHk6ICVzXG4iLAorCQkJICAgICAgIHN0cmVycm9yKC1yKSk7CisJCWdvdG8gb3V0OworCX0K
IAogCXIgPSBzdGF0KHR0eSwgJnN0Mik7Ci0JaWYgKHIgPCAwKQotCQlrc2Z0X2V4aXRfZmFp
bF9tc2coInN0YXQgZmFpbGVkIG9uIHR0eSBwYXRoICclcyc6ICVtXG4iLCB0dHkpOworCWlm
IChyIDwgMCkgeworCQlrc2Z0X3ByaW50X21zZygic3RhdCBmYWlsZWQgb24gdHR5IHBhdGgg
JyVzJzogJW1cbiIsIHR0eSk7CisJCWdvdG8gb3V0OworCX0KIAogCS8qIFdlIHdyb3RlIHRv
IHRoZSB0ZXJtaW5hbCBzbyB0aW1lc3RhbXBzIHNob3VsZCBoYXZlIGJlZW4gdXBkYXRlZCAq
LwogCWlmIChzdDEuc3RfYXRpbS50dl9zZWMgPT0gc3QyLnN0X2F0aW0udHZfc2VjICYmCiAJ
ICAgIHN0MS5zdF9tdGltLnR2X3NlYyA9PSBzdDIuc3RfbXRpbS50dl9zZWMpIHsKLQkJa3Nm
dF90ZXN0X3Jlc3VsdF9mYWlsKCJ0dHkgdGltZXN0YW1wcyBub3QgdXBkYXRlZFxuIik7Ci0J
CWtzZnRfZXhpdF9mYWlsKCk7CisJCWtzZnRfcHJpbnRfbXNnKCJ0dHkgdGltZXN0YW1wcyBu
b3QgdXBkYXRlZFxuIik7CisJCWdvdG8gb3V0OwogCX0KIAotCWtzZnRfdGVzdF9yZXN1bHRf
cGFzcygKKwlrc2Z0X3ByaW50X21zZygKIAkJInRpbWVzdGFtcHMgb2YgdGVybWluYWwgJyVz
JyB1cGRhdGVkIGFmdGVyIHdyaXRlIHRvIC9kZXYvdHR5XG4iLCB0dHkpOwotCXJldHVybiBF
WElUX1NVQ0NFU1M7CisJcmVzdWx0ID0gS1NGVF9QQVNTOworCitvdXQ6CisJa3NmdF90ZXN0
X3Jlc3VsdF9yZXBvcnQocmVzdWx0LCAidHR5X3RzdGFtcF91cGRhdGVcbiIpOworCisJa3Nm
dF9maW5pc2hlZCgpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
eDg2L2xhbS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L2xhbS5jCmluZGV4IDIx
NWI4MTUwYjdjYy4uODIwZGI0ODY0MjkyIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy94ODYvbGFtLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L2xh
bS5jCkBAIC0xMjM3LDUgKzEyMzcsNSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpCiAKIAlrc2Z0X3NldF9wbGFuKHRlc3RzX2NudCk7CiAKLQlyZXR1cm4ga3NmdF9leGl0
X3Bhc3MoKTsKKwlrc2Z0X2V4aXRfcGFzcygpOwogfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMveDg2L3Rlc3RfbXJlbWFwX3Zkc28uYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3g4Ni90ZXN0X21yZW1hcF92ZHNvLmMKaW5kZXggZjBkODc2ZDQ4Mjc3Li5k
NTM5NTllMDM1OTMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni90
ZXN0X21yZW1hcF92ZHNvLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rl
c3RfbXJlbWFwX3Zkc28uYwpAQCAtMTksNiArMTksNyBAQAogI2luY2x1ZGUgPHN5cy9hdXh2
Lmg+CiAjaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KICNpbmNsdWRlIDxzeXMvd2FpdC5oPgor
I2luY2x1ZGUgIi4uL2tzZWxmdGVzdC5oIgogCiAjZGVmaW5lIFBBR0VfU0laRQk0MDk2CiAK
QEAgLTI5LDEzICszMCwxMyBAQCBzdGF0aWMgaW50IHRyeV90b19yZW1hcCh2b2lkICp2ZHNv
X2FkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKIAkvKiBTZWFyY2hpbmcgZm9yIG1lbW9yeSBs
b2NhdGlvbiB3aGVyZSB0byByZW1hcCAqLwogCWRlc3RfYWRkciA9IG1tYXAoMCwgc2l6ZSwg
UFJPVF9OT05FLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCk7CiAJaWYgKGRl
c3RfYWRkciA9PSBNQVBfRkFJTEVEKSB7Ci0JCXByaW50ZigiW1dBUk5dXHRtbWFwIGZhaWxl
ZCAoJWQpOiAlbVxuIiwgZXJybm8pOworCQlrc2Z0X3ByaW50X21zZygiV0FSTjogbW1hcCBm
YWlsZWQgKCVkKTogJW1cbiIsIGVycm5vKTsKIAkJcmV0dXJuIDA7CiAJfQogCi0JcHJpbnRm
KCJbTk9URV1cdE1vdmluZyB2RFNPOiBbJXAsICUjbHhdIC0+IFslcCwgJSNseF1cbiIsCi0J
CXZkc29fYWRkciwgKHVuc2lnbmVkIGxvbmcpdmRzb19hZGRyICsgc2l6ZSwKLQkJZGVzdF9h
ZGRyLCAodW5zaWduZWQgbG9uZylkZXN0X2FkZHIgKyBzaXplKTsKKwlrc2Z0X3ByaW50X21z
ZygiTW92aW5nIHZEU086IFslcCwgJSNseF0gLT4gWyVwLCAlI2x4XVxuIiwKKwkJICAgICAg
IHZkc29fYWRkciwgKHVuc2lnbmVkIGxvbmcpdmRzb19hZGRyICsgc2l6ZSwKKwkJICAgICAg
IGRlc3RfYWRkciwgKHVuc2lnbmVkIGxvbmcpZGVzdF9hZGRyICsgc2l6ZSk7CiAJZmZsdXNo
KHN0ZG91dCk7CiAKIAluZXdfYWRkciA9IG1yZW1hcCh2ZHNvX2FkZHIsIHNpemUsIHNpemUs
CkBAIC00MywxMCArNDQsMTAgQEAgc3RhdGljIGludCB0cnlfdG9fcmVtYXAodm9pZCAqdmRz
b19hZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpCiAJaWYgKCh1bnNpZ25lZCBsb25nKW5ld19h
ZGRyID09ICh1bnNpZ25lZCBsb25nKS0xKSB7CiAJCW11bm1hcChkZXN0X2FkZHIsIHNpemUp
OwogCQlpZiAoZXJybm8gPT0gRUlOVkFMKSB7Ci0JCQlwcmludGYoIltOT1RFXVx0dkRTTyBw
YXJ0aWFsIG1vdmUgZmFpbGVkLCB3aWxsIHRyeSB3aXRoIGJpZ2dlciBzaXplXG4iKTsKKwkJ
CWtzZnRfcHJpbnRfbXNnKCJ2RFNPIHBhcnRpYWwgbW92ZSBmYWlsZWQsIHdpbGwgdHJ5IHdp
dGggYmlnZ2VyIHNpemVcbiIpOwogCQkJcmV0dXJuIC0xOyAvKiBSZXRyeSB3aXRoIGxhcmdl
ciAqLwogCQl9Ci0JCXByaW50ZigiW0ZBSUxdXHRtcmVtYXAgZmFpbGVkICglZCk6ICVtXG4i
LCBlcnJubyk7CisJCWtzZnRfcHJpbnRfbXNnKCJbRkFJTF1cdG1yZW1hcCBmYWlsZWQgKCVk
KTogJW1cbiIsIGVycm5vKTsKIAkJcmV0dXJuIDE7CiAJfQogCkBAIC01OCwxMSArNTksMTIg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjaGFyICoqZW52cCkKIHsKIAlw
aWRfdCBjaGlsZDsKIAorCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisJa3NmdF9zZXRfcGxhbigx
KTsKKwogCWNoaWxkID0gZm9yaygpOwotCWlmIChjaGlsZCA9PSAtMSkgewotCQlwcmludGYo
IltXQVJOXVx0ZmFpbGVkIHRvIGZvcmsgKCVkKTogJW1cbiIsIGVycm5vKTsKLQkJcmV0dXJu
IDE7Ci0JfQorCWlmIChjaGlsZCA9PSAtMSkKKwkJa3NmdF9leGl0X2ZhaWxfbXNnKCJmYWls
ZWQgdG8gZm9yayAoJWQpOiAlbVxuIiwgZXJybm8pOwogCiAJaWYgKGNoaWxkID09IDApIHsK
IAkJdW5zaWduZWQgbG9uZyB2ZHNvX3NpemUgPSBQQUdFX1NJWkU7CkBAIC03MCw5ICs3Miw5
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndiwgY2hhciAqKmVudnApCiAJCWlu
dCByZXQgPSAtMTsKIAogCQlhdXh2YWwgPSBnZXRhdXh2YWwoQVRfU1lTSU5GT19FSERSKTsK
LQkJcHJpbnRmKCJcdEFUX1NZU0lORk9fRUhEUiBpcyAlI2x4XG4iLCBhdXh2YWwpOworCQlr
c2Z0X3ByaW50X21zZygiQVRfU1lTSU5GT19FSERSIGlzICUjbHhcbiIsIGF1eHZhbCk7CiAJ
CWlmICghYXV4dmFsIHx8IGF1eHZhbCA9PSAtRU5PRU5UKSB7Ci0JCQlwcmludGYoIltXQVJO
XVx0Z2V0YXV4dmFsIGZhaWxlZFxuIik7CisJCQlrc2Z0X3ByaW50X21zZygiV0FSTjogZ2V0
YXV4dmFsIGZhaWxlZFxuIik7CiAJCQlyZXR1cm4gMDsKIAkJfQogCkBAIC05MiwxNiArOTQs
MTMgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjaGFyICoqZW52cCkKIAkJ
aW50IHN0YXR1czsKIAogCQlpZiAod2FpdHBpZChjaGlsZCwgJnN0YXR1cywgMCkgIT0gY2hp
bGQgfHwKLQkJCSFXSUZFWElURUQoc3RhdHVzKSkgewotCQkJcHJpbnRmKCJbRkFJTF1cdG1y
ZW1hcCgpIG9mIHRoZSB2RFNPIGRvZXMgbm90IHdvcmsgb24gdGhpcyBrZXJuZWwhXG4iKTsK
LQkJCXJldHVybiAxOwotCQl9IGVsc2UgaWYgKFdFWElUU1RBVFVTKHN0YXR1cykgIT0gMCkg
ewotCQkJcHJpbnRmKCJbRkFJTF1cdENoaWxkIGZhaWxlZCB3aXRoICVkXG4iLAotCQkJCQlX
RVhJVFNUQVRVUyhzdGF0dXMpKTsKLQkJCXJldHVybiAxOwotCQl9Ci0JCXByaW50ZigiW09L
XVxuIik7CisJCQkhV0lGRVhJVEVEKHN0YXR1cykpCisJCQlrc2Z0X3Rlc3RfcmVzdWx0X2Zh
aWwoIm1yZW1hcCgpIG9mIHRoZSB2RFNPIGRvZXMgbm90IHdvcmsgb24gdGhpcyBrZXJuZWwh
XG4iKTsKKwkJZWxzZSBpZiAoV0VYSVRTVEFUVVMoc3RhdHVzKSAhPSAwKQorCQkJa3NmdF90
ZXN0X3Jlc3VsdF9mYWlsKCJDaGlsZCBmYWlsZWQgd2l0aCAlZFxuIiwgV0VYSVRTVEFUVVMo
c3RhdHVzKSk7CisJCWVsc2UKKwkJCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygiJXNcbiIsIF9f
ZnVuY19fKTsKIAl9CiAKLQlyZXR1cm4gMDsKKwlrc2Z0X2ZpbmlzaGVkKCk7CiB9CmRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvdGVzdF92c3lzY2FsbC5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rlc3RfdnN5c2NhbGwuYwppbmRleCA0N2Nh
Yjk3MjgwN2MuLmQ0YzhlOGQ3OWQzOCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMveDg2L3Rlc3RfdnN5c2NhbGwuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy94ODYvdGVzdF92c3lzY2FsbC5jCkBAIC0yMSw2ICsyMSwxMyBAQAogI2luY2x1ZGUgPHN5
cy91aW8uaD4KIAogI2luY2x1ZGUgImhlbHBlcnMuaCIKKyNpbmNsdWRlICIuLi9rc2VsZnRl
c3QuaCIKKworI2lmZGVmIF9feDg2XzY0X18KKyNkZWZpbmUgVE9UQUxfVEVTVFMgMTMKKyNl
bHNlCisjZGVmaW5lIFRPVEFMX1RFU1RTIDgKKyNlbmRpZgogCiAjaWZkZWYgX194ODZfNjRf
XwogIyBkZWZpbmUgVlNZUyh4KSAoeCkKQEAgLTM5LDE4ICs0Niw2IEBACiAvKiBtYXggbGVu
Z3RoIG9mIGxpbmVzIGluIC9wcm9jL3NlbGYvbWFwcyAtIGFueXRoaW5nIGxvbmdlciBpcyBz
a2lwcGVkIGhlcmUgKi8KICNkZWZpbmUgTUFQU19MSU5FX0xFTiAxMjgKIAotc3RhdGljIHZv
aWQgc2V0aGFuZGxlcihpbnQgc2lnLCB2b2lkICgqaGFuZGxlcikoaW50LCBzaWdpbmZvX3Qg
Kiwgdm9pZCAqKSwKLQkJICAgICAgIGludCBmbGFncykKLXsKLQlzdHJ1Y3Qgc2lnYWN0aW9u
IHNhOwotCW1lbXNldCgmc2EsIDAsIHNpemVvZihzYSkpOwotCXNhLnNhX3NpZ2FjdGlvbiA9
IGhhbmRsZXI7Ci0Jc2Euc2FfZmxhZ3MgPSBTQV9TSUdJTkZPIHwgZmxhZ3M7Ci0Jc2lnZW1w
dHlzZXQoJnNhLnNhX21hc2spOwotCWlmIChzaWdhY3Rpb24oc2lnLCAmc2EsIDApKQotCQll
cnIoMSwgInNpZ2FjdGlvbiIpOwotfQotCiAvKiB2c3lzY2FsbHMgYW5kIHZEU08gKi8KIGJv
b2wgdnN5c2NhbGxfbWFwX3IgPSBmYWxzZSwgdnN5c2NhbGxfbWFwX3ggPSBmYWxzZTsKIApA
QCAtNzUsODMgKzcwLDI1IEBAIHN0YXRpYyB2b2lkIGluaXRfdmRzbyh2b2lkKQogCWlmICgh
dmRzbykKIAkJdmRzbyA9IGRsb3BlbigibGludXgtZ2F0ZS5zby4xIiwgUlRMRF9MQVpZIHwg
UlRMRF9MT0NBTCB8IFJUTERfTk9MT0FEKTsKIAlpZiAoIXZkc28pIHsKLQkJcHJpbnRmKCJb
V0FSTl1cdGZhaWxlZCB0byBmaW5kIHZEU09cbiIpOworCQlrc2Z0X3ByaW50X21zZygiW1dB
Uk5dIGZhaWxlZCB0byBmaW5kIHZEU09cbiIpOwogCQlyZXR1cm47CiAJfQogCiAJdmRzb19n
dG9kID0gKGd0b2RfdClkbHN5bSh2ZHNvLCAiX192ZHNvX2dldHRpbWVvZmRheSIpOwogCWlm
ICghdmRzb19ndG9kKQotCQlwcmludGYoIltXQVJOXVx0ZmFpbGVkIHRvIGZpbmQgZ2V0dGlt
ZW9mZGF5IGluIHZEU09cbiIpOworCQlrc2Z0X3ByaW50X21zZygiW1dBUk5dIGZhaWxlZCB0
byBmaW5kIGdldHRpbWVvZmRheSBpbiB2RFNPXG4iKTsKIAogCXZkc29fZ2V0dGltZSA9ICh2
Z2V0dGltZV90KWRsc3ltKHZkc28sICJfX3Zkc29fY2xvY2tfZ2V0dGltZSIpOwogCWlmICgh
dmRzb19nZXR0aW1lKQotCQlwcmludGYoIltXQVJOXVx0ZmFpbGVkIHRvIGZpbmQgY2xvY2tf
Z2V0dGltZSBpbiB2RFNPXG4iKTsKKwkJa3NmdF9wcmludF9tc2coIltXQVJOXSBmYWlsZWQg
dG8gZmluZCBjbG9ja19nZXR0aW1lIGluIHZEU09cbiIpOwogCiAJdmRzb190aW1lID0gKHRp
bWVfZnVuY190KWRsc3ltKHZkc28sICJfX3Zkc29fdGltZSIpOwogCWlmICghdmRzb190aW1l
KQotCQlwcmludGYoIltXQVJOXVx0ZmFpbGVkIHRvIGZpbmQgdGltZSBpbiB2RFNPXG4iKTsK
KwkJa3NmdF9wcmludF9tc2coIltXQVJOXSBmYWlsZWQgdG8gZmluZCB0aW1lIGluIHZEU09c
biIpOwogCiAJdmRzb19nZXRjcHUgPSAoZ2V0Y3B1X3QpZGxzeW0odmRzbywgIl9fdmRzb19n
ZXRjcHUiKTsKIAlpZiAoIXZkc29fZ2V0Y3B1KQotCQlwcmludGYoIltXQVJOXVx0ZmFpbGVk
IHRvIGZpbmQgZ2V0Y3B1IGluIHZEU09cbiIpOwotfQotCi1zdGF0aWMgaW50IGluaXRfdnN5
cyh2b2lkKQotewotI2lmZGVmIF9feDg2XzY0X18KLQlpbnQgbmVycnMgPSAwOwotCUZJTEUg
Km1hcHM7Ci0JY2hhciBsaW5lW01BUFNfTElORV9MRU5dOwotCWJvb2wgZm91bmQgPSBmYWxz
ZTsKLQotCW1hcHMgPSBmb3BlbigiL3Byb2Mvc2VsZi9tYXBzIiwgInIiKTsKLQlpZiAoIW1h
cHMpIHsKLQkJcHJpbnRmKCJbV0FSTl1cdENvdWxkIG5vdCBvcGVuIC9wcm9jL3NlbGYvbWFw
cyAtLSBhc3N1bWluZyB2c3lzY2FsbCBpcyByLXhcbiIpOwotCQl2c3lzY2FsbF9tYXBfciA9
IHRydWU7Ci0JCXJldHVybiAwOwotCX0KLQotCXdoaWxlIChmZ2V0cyhsaW5lLCBNQVBTX0xJ
TkVfTEVOLCBtYXBzKSkgewotCQljaGFyIHIsIHg7Ci0JCXZvaWQgKnN0YXJ0LCAqZW5kOwot
CQljaGFyIG5hbWVbTUFQU19MSU5FX0xFTl07Ci0KLQkJLyogc3NjYW5mKCkgaXMgc2FmZSBo
ZXJlIGFzIHN0cmxlbihuYW1lKSA+PSBzdHJsZW4obGluZSkgKi8KLQkJaWYgKHNzY2FuZihs
aW5lLCAiJXAtJXAgJWMtJWNwICUqeCAlKng6JSp4ICUqdSAlcyIsCi0JCQkgICAmc3RhcnQs
ICZlbmQsICZyLCAmeCwgbmFtZSkgIT0gNSkKLQkJCWNvbnRpbnVlOwotCi0JCWlmIChzdHJj
bXAobmFtZSwgIlt2c3lzY2FsbF0iKSkKLQkJCWNvbnRpbnVlOwotCi0JCXByaW50ZigiXHR2
c3lzY2FsbCBtYXA6ICVzIiwgbGluZSk7Ci0KLQkJaWYgKHN0YXJ0ICE9ICh2b2lkICopMHhm
ZmZmZmZmZmZmNjAwMDAwIHx8Ci0JCSAgICBlbmQgIT0gKHZvaWQgKikweGZmZmZmZmZmZmY2
MDEwMDApIHsKLQkJCXByaW50ZigiW0ZBSUxdXHRhZGRyZXNzIHJhbmdlIGlzIG5vbnNlbnNl
XG4iKTsKLQkJCW5lcnJzKys7Ci0JCX0KLQotCQlwcmludGYoIlx0dnN5c2NhbGwgcGVybWlz
c2lvbnMgYXJlICVjLSVjXG4iLCByLCB4KTsKLQkJdnN5c2NhbGxfbWFwX3IgPSAociA9PSAn
cicpOwotCQl2c3lzY2FsbF9tYXBfeCA9ICh4ID09ICd4Jyk7Ci0KLQkJZm91bmQgPSB0cnVl
OwotCQlicmVhazsKLQl9Ci0KLQlmY2xvc2UobWFwcyk7Ci0KLQlpZiAoIWZvdW5kKSB7Ci0J
CXByaW50ZigiXHRubyB2c3lzY2FsbCBtYXAgaW4gL3Byb2Mvc2VsZi9tYXBzXG4iKTsKLQkJ
dnN5c2NhbGxfbWFwX3IgPSBmYWxzZTsKLQkJdnN5c2NhbGxfbWFwX3ggPSBmYWxzZTsKLQl9
Ci0KLQlyZXR1cm4gbmVycnM7Ci0jZWxzZQotCXJldHVybiAwOwotI2VuZGlmCisJCWtzZnRf
cHJpbnRfbXNnKCJbV0FSTl0gZmFpbGVkIHRvIGZpbmQgZ2V0Y3B1IGluIHZEU09cbiIpOwog
fQogCiAvKiBzeXNjYWxscyAqLwpAQCAtMTc2LDk4ICsxMTMsNzYgQEAgc3RhdGljIGlubGlu
ZSBsb25nIHN5c19nZXRjcHUodW5zaWduZWQgKiBjcHUsIHVuc2lnbmVkICogbm9kZSwKIAly
ZXR1cm4gc3lzY2FsbChTWVNfZ2V0Y3B1LCBjcHUsIG5vZGUsIGNhY2hlKTsKIH0KIAotc3Rh
dGljIGptcF9idWYgam1wYnVmOwotc3RhdGljIHZvbGF0aWxlIHVuc2lnbmVkIGxvbmcgc2Vn
dl9lcnI7Ci0KLXN0YXRpYyB2b2lkIHNpZ3NlZ3YoaW50IHNpZywgc2lnaW5mb190ICppbmZv
LCB2b2lkICpjdHhfdm9pZCkKLXsKLQl1Y29udGV4dF90ICpjdHggPSAodWNvbnRleHRfdCAq
KWN0eF92b2lkOwotCi0Jc2Vndl9lcnIgPSAgY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdf
RVJSXTsKLQlzaWdsb25nam1wKGptcGJ1ZiwgMSk7Ci19Ci0KIHN0YXRpYyBkb3VibGUgdHZf
ZGlmZihjb25zdCBzdHJ1Y3QgdGltZXZhbCAqYSwgY29uc3Qgc3RydWN0IHRpbWV2YWwgKmIp
CiB7CiAJcmV0dXJuIChkb3VibGUpKGEtPnR2X3NlYyAtIGItPnR2X3NlYykgKwogCQkoZG91
YmxlKSgoaW50KWEtPnR2X3VzZWMgLSAoaW50KWItPnR2X3VzZWMpICogMWUtNjsKIH0KIAot
c3RhdGljIGludCBjaGVja19ndG9kKGNvbnN0IHN0cnVjdCB0aW1ldmFsICp0dl9zeXMxLAot
CQkgICAgICBjb25zdCBzdHJ1Y3QgdGltZXZhbCAqdHZfc3lzMiwKLQkJICAgICAgY29uc3Qg
c3RydWN0IHRpbWV6b25lICp0el9zeXMsCi0JCSAgICAgIGNvbnN0IGNoYXIgKndoaWNoLAot
CQkgICAgICBjb25zdCBzdHJ1Y3QgdGltZXZhbCAqdHZfb3RoZXIsCi0JCSAgICAgIGNvbnN0
IHN0cnVjdCB0aW1lem9uZSAqdHpfb3RoZXIpCitzdGF0aWMgdm9pZCBjaGVja19ndG9kKGNv
bnN0IHN0cnVjdCB0aW1ldmFsICp0dl9zeXMxLAorCQkgICAgICAgY29uc3Qgc3RydWN0IHRp
bWV2YWwgKnR2X3N5czIsCisJCSAgICAgICBjb25zdCBzdHJ1Y3QgdGltZXpvbmUgKnR6X3N5
cywKKwkJICAgICAgIGNvbnN0IGNoYXIgKndoaWNoLAorCQkgICAgICAgY29uc3Qgc3RydWN0
IHRpbWV2YWwgKnR2X290aGVyLAorCQkgICAgICAgY29uc3Qgc3RydWN0IHRpbWV6b25lICp0
el9vdGhlcikKIHsKLQlpbnQgbmVycnMgPSAwOwogCWRvdWJsZSBkMSwgZDI7CiAKLQlpZiAo
dHpfb3RoZXIgJiYgKHR6X3N5cy0+dHpfbWludXRlc3dlc3QgIT0gdHpfb3RoZXItPnR6X21p
bnV0ZXN3ZXN0IHx8IHR6X3N5cy0+dHpfZHN0dGltZSAhPSB0el9vdGhlci0+dHpfZHN0dGlt
ZSkpIHsKLQkJcHJpbnRmKCJbRkFJTF0gJXMgdHogbWlzbWF0Y2hcbiIsIHdoaWNoKTsKLQkJ
bmVycnMrKzsKLQl9CisJaWYgKHR6X290aGVyICYmICh0el9zeXMtPnR6X21pbnV0ZXN3ZXN0
ICE9IHR6X290aGVyLT50el9taW51dGVzd2VzdCB8fAorCQkJIHR6X3N5cy0+dHpfZHN0dGlt
ZSAhPSB0el9vdGhlci0+dHpfZHN0dGltZSkpCisJCWtzZnRfcHJpbnRfbXNnKCIlcyB0eiBt
aXNtYXRjaFxuIiwgd2hpY2gpOwogCiAJZDEgPSB0dl9kaWZmKHR2X290aGVyLCB0dl9zeXMx
KTsKIAlkMiA9IHR2X2RpZmYodHZfc3lzMiwgdHZfb3RoZXIpOyAKLQlwcmludGYoIlx0JXMg
dGltZSBvZmZzZXRzOiAlbGYgJWxmXG4iLCB3aGljaCwgZDEsIGQyKTsKIAotCWlmIChkMSA8
IDAgfHwgZDIgPCAwKSB7Ci0JCXByaW50ZigiW0ZBSUxdXHQlcyB0aW1lIHdhcyBpbmNvbnNp
c3RlbnQgd2l0aCB0aGUgc3lzY2FsbFxuIiwgd2hpY2gpOwotCQluZXJycysrOwotCX0gZWxz
ZSB7Ci0JCXByaW50ZigiW09LXVx0JXMgZ2V0dGltZW9mZGF5KCkncyB0aW1ldmFsIHdhcyBv
a2F5XG4iLCB3aGljaCk7Ci0JfQorCWtzZnRfcHJpbnRfbXNnKCIlcyB0aW1lIG9mZnNldHM6
ICVsZiAlbGZcbiIsIHdoaWNoLCBkMSwgZDIpOwogCi0JcmV0dXJuIG5lcnJzOworCWtzZnRf
dGVzdF9yZXN1bHQoIShkMSA8IDAgfHwgZDIgPCAwKSwgIiVzIGdldHRpbWVvZmRheSgpJ3Mg
dGltZXZhbFxuIiwgd2hpY2gpOwogfQogCi1zdGF0aWMgaW50IHRlc3RfZ3RvZCh2b2lkKQor
c3RhdGljIHZvaWQgdGVzdF9ndG9kKHZvaWQpCiB7CiAJc3RydWN0IHRpbWV2YWwgdHZfc3lz
MSwgdHZfc3lzMiwgdHZfdmRzbywgdHZfdnN5czsKIAlzdHJ1Y3QgdGltZXpvbmUgdHpfc3lz
LCB0el92ZHNvLCB0el92c3lzOwogCWxvbmcgcmV0X3Zkc28gPSAtMTsKIAlsb25nIHJldF92
c3lzID0gLTE7Ci0JaW50IG5lcnJzID0gMDsKIAotCXByaW50ZigiW1JVTl1cdHRlc3QgZ2V0
dGltZW9mZGF5KClcbiIpOworCWtzZnRfcHJpbnRfbXNnKCJ0ZXN0IGdldHRpbWVvZmRheSgp
XG4iKTsKIAogCWlmIChzeXNfZ3RvZCgmdHZfc3lzMSwgJnR6X3N5cykgIT0gMCkKLQkJZXJy
KDEsICJzeXNjYWxsIGdldHRpbWVvZmRheSIpOworCQlrc2Z0X2V4aXRfZmFpbF9tc2coInN5
c2NhbGwgZ2V0dGltZW9mZGF5OiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKIAlpZiAodmRz
b19ndG9kKQogCQlyZXRfdmRzbyA9IHZkc29fZ3RvZCgmdHZfdmRzbywgJnR6X3Zkc28pOwog
CWlmICh2c3lzY2FsbF9tYXBfeCkKIAkJcmV0X3ZzeXMgPSB2Z3RvZCgmdHZfdnN5cywgJnR6
X3ZzeXMpOwogCWlmIChzeXNfZ3RvZCgmdHZfc3lzMiwgJnR6X3N5cykgIT0gMCkKLQkJZXJy
KDEsICJzeXNjYWxsIGdldHRpbWVvZmRheSIpOworCQlrc2Z0X2V4aXRfZmFpbF9tc2coInN5
c2NhbGwgZ2V0dGltZW9mZGF5OiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKIAogCWlmICh2
ZHNvX2d0b2QpIHsKLQkJaWYgKHJldF92ZHNvID09IDApIHsKLQkJCW5lcnJzICs9IGNoZWNr
X2d0b2QoJnR2X3N5czEsICZ0dl9zeXMyLCAmdHpfc3lzLCAidkRTTyIsICZ0dl92ZHNvLCAm
dHpfdmRzbyk7Ci0JCX0gZWxzZSB7Ci0JCQlwcmludGYoIltGQUlMXVx0dkRTTyBnZXR0aW1l
b2ZkYXkoKSBmYWlsZWQ6ICVsZFxuIiwgcmV0X3Zkc28pOwotCQkJbmVycnMrKzsKLQkJfQor
CQlpZiAocmV0X3Zkc28gPT0gMCkKKwkJCWNoZWNrX2d0b2QoJnR2X3N5czEsICZ0dl9zeXMy
LCAmdHpfc3lzLCAidkRTTyIsICZ0dl92ZHNvLCAmdHpfdmRzbyk7CisJCWVsc2UKKwkJCWtz
ZnRfdGVzdF9yZXN1bHRfZmFpbCgidkRTTyBnZXR0aW1lb2ZkYXkoKSBmYWlsZWQ6ICVsZFxu
IiwgcmV0X3Zkc28pOworCX0gZWxzZSB7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgidmRz
b19ndG9kIGlzbid0IHNldFxuIik7CiAJfQogCiAJaWYgKHZzeXNjYWxsX21hcF94KSB7Ci0J
CWlmIChyZXRfdnN5cyA9PSAwKSB7Ci0JCQluZXJycyArPSBjaGVja19ndG9kKCZ0dl9zeXMx
LCAmdHZfc3lzMiwgJnR6X3N5cywgInZzeXNjYWxsIiwgJnR2X3ZzeXMsICZ0el92c3lzKTsK
LQkJfSBlbHNlIHsKLQkJCXByaW50ZigiW0ZBSUxdXHR2c3lzIGdldHRpbWVvZmRheSgpIGZh
aWxlZDogJWxkXG4iLCByZXRfdnN5cyk7Ci0JCQluZXJycysrOwotCQl9CisJCWlmIChyZXRf
dnN5cyA9PSAwKQorCQkJY2hlY2tfZ3RvZCgmdHZfc3lzMSwgJnR2X3N5czIsICZ0el9zeXMs
ICJ2c3lzY2FsbCIsICZ0dl92c3lzLCAmdHpfdnN5cyk7CisJCWVsc2UKKwkJCWtzZnRfdGVz
dF9yZXN1bHRfZmFpbCgidnN5cyBnZXR0aW1lb2ZkYXkoKSBmYWlsZWQ6ICVsZFxuIiwgcmV0
X3ZzeXMpOworCX0gZWxzZSB7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgidnN5c2NhbGxf
bWFwX3ggaXNuJ3Qgc2V0XG4iKTsKIAl9Ci0KLQlyZXR1cm4gbmVycnM7CiB9CiAKLXN0YXRp
YyBpbnQgdGVzdF90aW1lKHZvaWQpIHsKLQlpbnQgbmVycnMgPSAwOwotCi0JcHJpbnRmKCJb
UlVOXVx0dGVzdCB0aW1lKClcbiIpOworc3RhdGljIHZvaWQgdGVzdF90aW1lKHZvaWQpCit7
CiAJbG9uZyB0X3N5czEsIHRfc3lzMiwgdF92ZHNvID0gMCwgdF92c3lzID0gMDsKIAlsb25n
IHQyX3N5czEgPSAtMSwgdDJfc3lzMiA9IC0xLCB0Ml92ZHNvID0gLTEsIHQyX3ZzeXMgPSAt
MTsKKworCWtzZnRfcHJpbnRfbXNnKCJ0ZXN0IHRpbWUoKVxuIik7CiAJdF9zeXMxID0gc3lz
X3RpbWUoJnQyX3N5czEpOwogCWlmICh2ZHNvX3RpbWUpCiAJCXRfdmRzbyA9IHZkc29fdGlt
ZSgmdDJfdmRzbyk7CkBAIC0yNzUsNTYgKzE5MCw2MCBAQCBzdGF0aWMgaW50IHRlc3RfdGlt
ZSh2b2lkKSB7CiAJCXRfdnN5cyA9IHZ0aW1lKCZ0Ml92c3lzKTsKIAl0X3N5czIgPSBzeXNf
dGltZSgmdDJfc3lzMik7CiAJaWYgKHRfc3lzMSA8IDAgfHwgdF9zeXMxICE9IHQyX3N5czEg
fHwgdF9zeXMyIDwgMCB8fCB0X3N5czIgIT0gdDJfc3lzMikgewotCQlwcmludGYoIltGQUlM
XVx0c3lzY2FsbCBmYWlsZWQgKHJldDE6JWxkIG91dHB1dDE6JWxkIHJldDI6JWxkIG91dHB1
dDI6JWxkKVxuIiwgdF9zeXMxLCB0Ml9zeXMxLCB0X3N5czIsIHQyX3N5czIpOwotCQluZXJy
cysrOwotCQlyZXR1cm4gbmVycnM7CisJCWtzZnRfcHJpbnRfbXNnKCJzeXNjYWxsIGZhaWxl
ZCAocmV0MTolbGQgb3V0cHV0MTolbGQgcmV0MjolbGQgb3V0cHV0MjolbGQpXG4iLAorCQkJ
ICAgICAgIHRfc3lzMSwgdDJfc3lzMSwgdF9zeXMyLCB0Ml9zeXMyKTsKKwkJa3NmdF90ZXN0
X3Jlc3VsdF9za2lwKCJ2ZHNvX3RpbWVcbiIpOworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAo
InZkc29fdGltZVxuIik7CisJCXJldHVybjsKIAl9CiAKIAlpZiAodmRzb190aW1lKSB7Ci0J
CWlmICh0X3Zkc28gPCAwIHx8IHRfdmRzbyAhPSB0Ml92ZHNvKSB7Ci0JCQlwcmludGYoIltG
QUlMXVx0dkRTTyBmYWlsZWQgKHJldDolbGQgb3V0cHV0OiVsZClcbiIsIHRfdmRzbywgdDJf
dmRzbyk7Ci0JCQluZXJycysrOwotCQl9IGVsc2UgaWYgKHRfdmRzbyA8IHRfc3lzMSB8fCB0
X3Zkc28gPiB0X3N5czIpIHsKLQkJCXByaW50ZigiW0ZBSUxdXHR2RFNPIHJldHVybmVkIHRo
ZSB3cm9uZyB0aW1lICglbGQgJWxkICVsZClcbiIsIHRfc3lzMSwgdF92ZHNvLCB0X3N5czIp
OwotCQkJbmVycnMrKzsKLQkJfSBlbHNlIHsKLQkJCXByaW50ZigiW09LXVx0dkRTTyB0aW1l
KCkgaXMgb2theVxuIik7Ci0JCX0KKwkJaWYgKHRfdmRzbyA8IDAgfHwgdF92ZHNvICE9IHQy
X3Zkc28pCisJCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoInZEU08gZmFpbGVkIChyZXQ6JWxk
IG91dHB1dDolbGQpXG4iLAorCQkJCQkgICAgICB0X3Zkc28sIHQyX3Zkc28pOworCQllbHNl
IGlmICh0X3Zkc28gPCB0X3N5czEgfHwgdF92ZHNvID4gdF9zeXMyKQorCQkJa3NmdF90ZXN0
X3Jlc3VsdF9mYWlsKCJ2RFNPIHJldHVybmVkIHRoZSB3cm9uZyB0aW1lICglbGQgJWxkICVs
ZClcbiIsCisJCQkJCSAgICAgIHRfc3lzMSwgdF92ZHNvLCB0X3N5czIpOworCQllbHNlCisJ
CQlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoInZEU08gdGltZSgpIGlzIG9rYXlcbiIpOworCX0g
ZWxzZSB7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgidmRzb190aW1lIGlzbid0IHNldFxu
Iik7CiAJfQogCiAJaWYgKHZzeXNjYWxsX21hcF94KSB7Ci0JCWlmICh0X3ZzeXMgPCAwIHx8
IHRfdnN5cyAhPSB0Ml92c3lzKSB7Ci0JCQlwcmludGYoIltGQUlMXVx0dnN5c2NhbGwgZmFp
bGVkIChyZXQ6JWxkIG91dHB1dDolbGQpXG4iLCB0X3ZzeXMsIHQyX3ZzeXMpOwotCQkJbmVy
cnMrKzsKLQkJfSBlbHNlIGlmICh0X3ZzeXMgPCB0X3N5czEgfHwgdF92c3lzID4gdF9zeXMy
KSB7Ci0JCQlwcmludGYoIltGQUlMXVx0dnN5c2NhbGwgcmV0dXJuZWQgdGhlIHdyb25nIHRp
bWUgKCVsZCAlbGQgJWxkKVxuIiwgdF9zeXMxLCB0X3ZzeXMsIHRfc3lzMik7Ci0JCQluZXJy
cysrOwotCQl9IGVsc2UgewotCQkJcHJpbnRmKCJbT0tdXHR2c3lzY2FsbCB0aW1lKCkgaXMg
b2theVxuIik7Ci0JCX0KKwkJaWYgKHRfdnN5cyA8IDAgfHwgdF92c3lzICE9IHQyX3ZzeXMp
CisJCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoInZzeXNjYWxsIGZhaWxlZCAocmV0OiVsZCBv
dXRwdXQ6JWxkKVxuIiwKKwkJCQkJICAgICAgdF92c3lzLCB0Ml92c3lzKTsKKwkJZWxzZSBp
ZiAodF92c3lzIDwgdF9zeXMxIHx8IHRfdnN5cyA+IHRfc3lzMikKKwkJCWtzZnRfdGVzdF9y
ZXN1bHRfZmFpbCgidnN5c2NhbGwgcmV0dXJuZWQgdGhlIHdyb25nIHRpbWUgKCVsZCAlbGQg
JWxkKVxuIiwKKwkJCQkJICAgICAgdF9zeXMxLCB0X3ZzeXMsIHRfc3lzMik7CisJCWVsc2UK
KwkJCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygidnN5c2NhbGwgdGltZSgpIGlzIG9rYXlcbiIp
OworCX0gZWxzZSB7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgidnN5c2NhbGxfbWFwX3gg
aXNuJ3Qgc2V0XG4iKTsKIAl9Ci0KLQlyZXR1cm4gbmVycnM7CiB9CiAKLXN0YXRpYyBpbnQg
dGVzdF9nZXRjcHUoaW50IGNwdSkKK3N0YXRpYyB2b2lkIHRlc3RfZ2V0Y3B1KGludCBjcHUp
CiB7Ci0JaW50IG5lcnJzID0gMDsKKwl1bnNpZ25lZCBpbnQgY3B1X3N5cywgY3B1X3Zkc28s
IGNwdV92c3lzLCBub2RlX3N5cywgbm9kZV92ZHNvLCBub2RlX3ZzeXM7CiAJbG9uZyByZXRf
c3lzLCByZXRfdmRzbyA9IC0xLCByZXRfdnN5cyA9IC0xOworCXVuc2lnbmVkIGludCBub2Rl
ID0gMDsKKwlib29sIGhhdmVfbm9kZSA9IGZhbHNlOworCWNwdV9zZXRfdCBjcHVzZXQ7CiAK
LQlwcmludGYoIltSVU5dXHRnZXRjcHUoKSBvbiBDUFUgJWRcbiIsIGNwdSk7CisJa3NmdF9w
cmludF9tc2coImdldGNwdSgpIG9uIENQVSAlZFxuIiwgY3B1KTsKIAotCWNwdV9zZXRfdCBj
cHVzZXQ7CiAJQ1BVX1pFUk8oJmNwdXNldCk7CiAJQ1BVX1NFVChjcHUsICZjcHVzZXQpOwog
CWlmIChzY2hlZF9zZXRhZmZpbml0eSgwLCBzaXplb2YoY3B1c2V0KSwgJmNwdXNldCkgIT0g
MCkgewotCQlwcmludGYoIltTS0lQXVx0ZmFpbGVkIHRvIGZvcmNlIENQVSAlZFxuIiwgY3B1
KTsKLQkJcmV0dXJuIG5lcnJzOworCQlrc2Z0X3ByaW50X21zZygiZmFpbGVkIHRvIGZvcmNl
IENQVSAlZFxuIiwgY3B1KTsKKwkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJ2ZHNvX2dldGNw
dVxuIik7CisJCWtzZnRfdGVzdF9yZXN1bHRfc2tpcCgidnN5c2NhbGxfbWFwX3hcbiIpOwor
CisJCXJldHVybjsKIAl9CiAKLQl1bnNpZ25lZCBjcHVfc3lzLCBjcHVfdmRzbywgY3B1X3Zz
eXMsIG5vZGVfc3lzLCBub2RlX3Zkc28sIG5vZGVfdnN5czsKLQl1bnNpZ25lZCBub2RlID0g
MDsKLQlib29sIGhhdmVfbm9kZSA9IGZhbHNlOwogCXJldF9zeXMgPSBzeXNfZ2V0Y3B1KCZj
cHVfc3lzLCAmbm9kZV9zeXMsIDApOwogCWlmICh2ZHNvX2dldGNwdSkKIAkJcmV0X3Zkc28g
PSB2ZHNvX2dldGNwdSgmY3B1X3Zkc28sICZub2RlX3Zkc28sIDApOwpAQCAtMzMyLDEwICsy
NTEsOSBAQCBzdGF0aWMgaW50IHRlc3RfZ2V0Y3B1KGludCBjcHUpCiAJCXJldF92c3lzID0g
dmdldGNwdSgmY3B1X3ZzeXMsICZub2RlX3ZzeXMsIDApOwogCiAJaWYgKHJldF9zeXMgPT0g
MCkgewotCQlpZiAoY3B1X3N5cyAhPSBjcHUpIHsKLQkJCXByaW50ZigiW0ZBSUxdXHRzeXNj
YWxsIHJlcG9ydGVkIENQVSAlaHUgYnV0IHNob3VsZCBiZSAlZFxuIiwgY3B1X3N5cywgY3B1
KTsKLQkJCW5lcnJzKys7Ci0JCX0KKwkJaWYgKGNwdV9zeXMgIT0gY3B1KQorCQkJa3NmdF9w
cmludF9tc2coInN5c2NhbGwgcmVwb3J0ZWQgQ1BVICVodSBidXQgc2hvdWxkIGJlICVkXG4i
LAorCQkJCSAgICAgICBjcHVfc3lzLCBjcHUpOwogCiAJCWhhdmVfbm9kZSA9IHRydWU7CiAJ
CW5vZGUgPSBub2RlX3N5czsKQEAgLTM0Myw2MyArMjYxLDg0IEBAIHN0YXRpYyBpbnQgdGVz
dF9nZXRjcHUoaW50IGNwdSkKIAogCWlmICh2ZHNvX2dldGNwdSkgewogCQlpZiAocmV0X3Zk
c28pIHsKLQkJCXByaW50ZigiW0ZBSUxdXHR2RFNPIGdldGNwdSgpIGZhaWxlZFxuIik7Ci0J
CQluZXJycysrOworCQkJa3NmdF90ZXN0X3Jlc3VsdF9mYWlsKCJ2RFNPIGdldGNwdSgpIGZh
aWxlZFxuIik7CiAJCX0gZWxzZSB7CiAJCQlpZiAoIWhhdmVfbm9kZSkgewogCQkJCWhhdmVf
bm9kZSA9IHRydWU7CiAJCQkJbm9kZSA9IG5vZGVfdmRzbzsKIAkJCX0KIAotCQkJaWYgKGNw
dV92ZHNvICE9IGNwdSkgewotCQkJCXByaW50ZigiW0ZBSUxdXHR2RFNPIHJlcG9ydGVkIENQ
VSAlaHUgYnV0IHNob3VsZCBiZSAlZFxuIiwgY3B1X3Zkc28sIGNwdSk7Ci0JCQkJbmVycnMr
KzsKLQkJCX0gZWxzZSB7Ci0JCQkJcHJpbnRmKCJbT0tdXHR2RFNPIHJlcG9ydGVkIGNvcnJl
Y3QgQ1BVXG4iKTsKLQkJCX0KLQotCQkJaWYgKG5vZGVfdmRzbyAhPSBub2RlKSB7Ci0JCQkJ
cHJpbnRmKCJbRkFJTF1cdHZEU08gcmVwb3J0ZWQgbm9kZSAlaHUgYnV0IHNob3VsZCBiZSAl
aHVcbiIsIG5vZGVfdmRzbywgbm9kZSk7Ci0JCQkJbmVycnMrKzsKKwkJCWlmIChjcHVfdmRz
byAhPSBjcHUgfHwgbm9kZV92ZHNvICE9IG5vZGUpIHsKKwkJCQlpZiAoY3B1X3Zkc28gIT0g
Y3B1KQorCQkJCQlrc2Z0X3ByaW50X21zZygidkRTTyByZXBvcnRlZCBDUFUgJWh1IGJ1dCBz
aG91bGQgYmUgJWRcbiIsCisJCQkJCQkgICAgICAgY3B1X3Zkc28sIGNwdSk7CisJCQkJaWYg
KG5vZGVfdmRzbyAhPSBub2RlKQorCQkJCQlrc2Z0X3ByaW50X21zZygidkRTTyByZXBvcnRl
ZCBub2RlICVodSBidXQgc2hvdWxkIGJlICVodVxuIiwKKwkJCQkJCSAgICAgICBub2RlX3Zk
c28sIG5vZGUpOworCQkJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiV3JvbmcgdmFsdWVzXG4i
KTsKIAkJCX0gZWxzZSB7Ci0JCQkJcHJpbnRmKCJbT0tdXHR2RFNPIHJlcG9ydGVkIGNvcnJl
Y3Qgbm9kZVxuIik7CisJCQkJa3NmdF90ZXN0X3Jlc3VsdF9wYXNzKCJ2RFNPIHJlcG9ydGVk
IGNvcnJlY3QgQ1BVIGFuZCBub2RlXG4iKTsKIAkJCX0KIAkJfQorCX0gZWxzZSB7CisJCWtz
ZnRfdGVzdF9yZXN1bHRfc2tpcCgidmRzb19nZXRjcHUgaXNuJ3Qgc2V0XG4iKTsKIAl9CiAK
IAlpZiAodnN5c2NhbGxfbWFwX3gpIHsKIAkJaWYgKHJldF92c3lzKSB7Ci0JCQlwcmludGYo
IltGQUlMXVx0dnN5c2NhbGwgZ2V0Y3B1KCkgZmFpbGVkXG4iKTsKLQkJCW5lcnJzKys7CisJ
CQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoInZzeXNjYWxsIGdldGNwdSgpIGZhaWxlZFxuIik7
CiAJCX0gZWxzZSB7CiAJCQlpZiAoIWhhdmVfbm9kZSkgewogCQkJCWhhdmVfbm9kZSA9IHRy
dWU7CiAJCQkJbm9kZSA9IG5vZGVfdnN5czsKIAkJCX0KIAotCQkJaWYgKGNwdV92c3lzICE9
IGNwdSkgewotCQkJCXByaW50ZigiW0ZBSUxdXHR2c3lzY2FsbCByZXBvcnRlZCBDUFUgJWh1
IGJ1dCBzaG91bGQgYmUgJWRcbiIsIGNwdV92c3lzLCBjcHUpOwotCQkJCW5lcnJzKys7CisJ
CQlpZiAoY3B1X3ZzeXMgIT0gY3B1IHx8IG5vZGVfdnN5cyAhPSBub2RlKSB7CisJCQkJaWYg
KGNwdV92c3lzICE9IGNwdSkKKwkJCQkJa3NmdF9wcmludF9tc2coInZzeXNjYWxsIHJlcG9y
dGVkIENQVSAlaHUgYnV0IHNob3VsZCBiZSAlZFxuIiwKKwkJCQkJCSAgICAgICBjcHVfdnN5
cywgY3B1KTsKKwkJCQlpZiAobm9kZV92c3lzICE9IG5vZGUpCisJCQkJCWtzZnRfcHJpbnRf
bXNnKCJ2c3lzY2FsbCByZXBvcnRlZCBub2RlICVodSBidXQgc2hvdWxkIGJlICVodVxuIiwK
KwkJCQkJCSAgICAgICBub2RlX3ZzeXMsIG5vZGUpOworCQkJCWtzZnRfdGVzdF9yZXN1bHRf
ZmFpbCgiV3JvbmcgdmFsdWVzXG4iKTsKIAkJCX0gZWxzZSB7Ci0JCQkJcHJpbnRmKCJbT0td
XHR2c3lzY2FsbCByZXBvcnRlZCBjb3JyZWN0IENQVVxuIik7Ci0JCQl9Ci0KLQkJCWlmIChu
b2RlX3ZzeXMgIT0gbm9kZSkgewotCQkJCXByaW50ZigiW0ZBSUxdXHR2c3lzY2FsbCByZXBv
cnRlZCBub2RlICVodSBidXQgc2hvdWxkIGJlICVodVxuIiwgbm9kZV92c3lzLCBub2RlKTsK
LQkJCQluZXJycysrOwotCQkJfSBlbHNlIHsKLQkJCQlwcmludGYoIltPS11cdHZzeXNjYWxs
IHJlcG9ydGVkIGNvcnJlY3Qgbm9kZVxuIik7CisJCQkJa3NmdF90ZXN0X3Jlc3VsdF9wYXNz
KCJ2c3lzY2FsbCByZXBvcnRlZCBjb3JyZWN0IENQVSBhbmQgbm9kZVxuIik7CiAJCQl9CiAJ
CX0KKwl9IGVsc2UgeworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoInZzeXNjYWxsX21hcF94
IGlzbid0IHNldFxuIik7CiAJfQorfQorCisjaWZkZWYgX194ODZfNjRfXworCitzdGF0aWMg
am1wX2J1ZiBqbXBidWY7CitzdGF0aWMgdm9sYXRpbGUgdW5zaWduZWQgbG9uZyBzZWd2X2Vy
cjsKKworc3RhdGljIHZvaWQgc2V0aGFuZGxlcihpbnQgc2lnLCB2b2lkICgqaGFuZGxlciko
aW50LCBzaWdpbmZvX3QgKiwgdm9pZCAqKSwKKwkJICAgICAgIGludCBmbGFncykKK3sKKwlz
dHJ1Y3Qgc2lnYWN0aW9uIHNhOwogCi0JcmV0dXJuIG5lcnJzOworCW1lbXNldCgmc2EsIDAs
IHNpemVvZihzYSkpOworCXNhLnNhX3NpZ2FjdGlvbiA9IGhhbmRsZXI7CisJc2Euc2FfZmxh
Z3MgPSBTQV9TSUdJTkZPIHwgZmxhZ3M7CisJc2lnZW1wdHlzZXQoJnNhLnNhX21hc2spOwor
CWlmIChzaWdhY3Rpb24oc2lnLCAmc2EsIDApKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coInNp
Z2FjdGlvbiBmYWlsZWRcbiIpOwogfQogCi1zdGF0aWMgaW50IHRlc3RfdnN5c19yKHZvaWQp
CitzdGF0aWMgdm9pZCBzaWdzZWd2KGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAq
Y3R4X3ZvaWQpCiB7Ci0jaWZkZWYgX194ODZfNjRfXwotCXByaW50ZigiW1JVTl1cdENoZWNr
aW5nIHJlYWQgYWNjZXNzIHRvIHRoZSB2c3lzY2FsbCBwYWdlXG4iKTsKKwl1Y29udGV4dF90
ICpjdHggPSAodWNvbnRleHRfdCAqKWN0eF92b2lkOworCisJc2Vndl9lcnIgPSAgY3R4LT51
Y19tY29udGV4dC5ncmVnc1tSRUdfRVJSXTsKKwlzaWdsb25nam1wKGptcGJ1ZiwgMSk7Cit9
CisKK3N0YXRpYyB2b2lkIHRlc3RfdnN5c19yKHZvaWQpCit7CisJa3NmdF9wcmludF9tc2co
IkNoZWNraW5nIHJlYWQgYWNjZXNzIHRvIHRoZSB2c3lzY2FsbCBwYWdlXG4iKTsKIAlib29s
IGNhbl9yZWFkOwogCWlmIChzaWdzZXRqbXAoam1wYnVmLCAxKSA9PSAwKSB7CiAJCSoodm9s
YXRpbGUgaW50ICopMHhmZmZmZmZmZmZmNjAwMDAwOwpAQCAtNDA4LDMyICszNDcsMjUgQEAg
c3RhdGljIGludCB0ZXN0X3ZzeXNfcih2b2lkKQogCQljYW5fcmVhZCA9IGZhbHNlOwogCX0K
IAotCWlmIChjYW5fcmVhZCAmJiAhdnN5c2NhbGxfbWFwX3IpIHsKLQkJcHJpbnRmKCJbRkFJ
TF1cdFdlIGhhdmUgcmVhZCBhY2Nlc3MsIGJ1dCB3ZSBzaG91bGRuJ3RcbiIpOwotCQlyZXR1
cm4gMTsKLQl9IGVsc2UgaWYgKCFjYW5fcmVhZCAmJiB2c3lzY2FsbF9tYXBfcikgewotCQlw
cmludGYoIltGQUlMXVx0V2UgZG9uJ3QgaGF2ZSByZWFkIGFjY2VzcywgYnV0IHdlIHNob3Vs
ZFxuIik7Ci0JCXJldHVybiAxOwotCX0gZWxzZSBpZiAoY2FuX3JlYWQpIHsKLQkJcHJpbnRm
KCJbT0tdXHRXZSBoYXZlIHJlYWQgYWNjZXNzXG4iKTsKLQl9IGVsc2UgewotCQlwcmludGYo
IltPS11cdFdlIGRvIG5vdCBoYXZlIHJlYWQgYWNjZXNzOiAjUEYoMHglbHgpXG4iLAotCQkg
ICAgICAgc2Vndl9lcnIpOwotCX0KLSNlbmRpZgotCi0JcmV0dXJuIDA7CisJaWYgKGNhbl9y
ZWFkICYmICF2c3lzY2FsbF9tYXBfcikKKwkJa3NmdF90ZXN0X3Jlc3VsdF9mYWlsKCJXZSBo
YXZlIHJlYWQgYWNjZXNzLCBidXQgd2Ugc2hvdWxkbid0XG4iKTsKKwllbHNlIGlmICghY2Fu
X3JlYWQgJiYgdnN5c2NhbGxfbWFwX3IpCisJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiV2Ug
ZG9uJ3QgaGF2ZSByZWFkIGFjY2VzcywgYnV0IHdlIHNob3VsZFxuIik7CisJZWxzZSBpZiAo
Y2FuX3JlYWQpCisJCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygiV2UgaGF2ZSByZWFkIGFjY2Vz
c1xuIik7CisJZWxzZQorCQlrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoIldlIGRvIG5vdCBoYXZl
IHJlYWQgYWNjZXNzOiAjUEYoMHglbHgpXG4iLCBzZWd2X2Vycik7CiB9CiAKLXN0YXRpYyBp
bnQgdGVzdF92c3lzX3godm9pZCkKK3N0YXRpYyB2b2lkIHRlc3RfdnN5c194KHZvaWQpCiB7
Ci0jaWZkZWYgX194ODZfNjRfXwogCWlmICh2c3lzY2FsbF9tYXBfeCkgewogCQkvKiBXZSBh
bHJlYWR5IHRlc3RlZCB0aGlzIGFkZXF1YXRlbHkuICovCi0JCXJldHVybiAwOworCQlrc2Z0
X3Rlc3RfcmVzdWx0X3Bhc3MoInZzeXNjYWxsX21hcF94IGlzIHRydWVcbiIpOworCQlyZXR1
cm47CiAJfQogCi0JcHJpbnRmKCJbUlVOXVx0TWFrZSBzdXJlIHRoYXQgdnN5c2NhbGxzIHJl
YWxseSBwYWdlIGZhdWx0XG4iKTsKKwlrc2Z0X3ByaW50X21zZygiTWFrZSBzdXJlIHRoYXQg
dnN5c2NhbGxzIHJlYWxseSBwYWdlIGZhdWx0XG4iKTsKIAogCWJvb2wgY2FuX2V4ZWM7CiAJ
aWYgKHNpZ3NldGptcChqbXBidWYsIDEpID09IDApIHsKQEAgLTQ0MywyMCArMzc1LDE0IEBA
IHN0YXRpYyBpbnQgdGVzdF92c3lzX3godm9pZCkKIAkJY2FuX2V4ZWMgPSBmYWxzZTsKIAl9
CiAKLQlpZiAoY2FuX2V4ZWMpIHsKLQkJcHJpbnRmKCJbRkFJTF1cdEV4ZWN1dGluZyB0aGUg
dnN5c2NhbGwgZGlkIG5vdCBwYWdlIGZhdWx0XG4iKTsKLQkJcmV0dXJuIDE7Ci0JfSBlbHNl
IGlmIChzZWd2X2VyciAmICgxIDw8IDQpKSB7IC8qIElOU1RSICovCi0JCXByaW50ZigiW09L
XVx0RXhlY3V0aW5nIHRoZSB2c3lzY2FsbCBwYWdlIGZhaWxlZDogI1BGKDB4JWx4KVxuIiwK
LQkJICAgICAgIHNlZ3ZfZXJyKTsKLQl9IGVsc2UgewotCQlwcmludGYoIltGQUlMXVx0RXhl
Y3V0aW9uIGZhaWxlZCB3aXRoIHRoZSB3cm9uZyBlcnJvcjogI1BGKDB4JWx4KVxuIiwKLQkJ
ICAgICAgIHNlZ3ZfZXJyKTsKLQkJcmV0dXJuIDE7Ci0JfQotI2VuZGlmCi0KLQlyZXR1cm4g
MDsKKwlpZiAoY2FuX2V4ZWMpCisJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiRXhlY3V0aW5n
IHRoZSB2c3lzY2FsbCBkaWQgbm90IHBhZ2UgZmF1bHRcbiIpOworCWVsc2UgaWYgKHNlZ3Zf
ZXJyICYgKDEgPDwgNCkpIC8qIElOU1RSICovCisJCWtzZnRfdGVzdF9yZXN1bHRfcGFzcygi
RXhlY3V0aW5nIHRoZSB2c3lzY2FsbCBwYWdlIGZhaWxlZDogI1BGKDB4JWx4KVxuIiwKKwkJ
CQkgICAgICBzZWd2X2Vycik7CisJZWxzZQorCQlrc2Z0X3Rlc3RfcmVzdWx0X2ZhaWwoIkV4
ZWN1dGlvbiBmYWlsZWQgd2l0aCB0aGUgd3JvbmcgZXJyb3I6ICNQRigweCVseClcbiIsCisJ
CQkJICAgICAgc2Vndl9lcnIpOwogfQogCiAvKgpAQCAtNDcwLDE0ICszOTYsMTMgQEAgc3Rh
dGljIGludCB0ZXN0X3ZzeXNfeCh2b2lkKQogICogZmFjdCB0aGF0IHB0cmFjZSgpIGV2ZXIg
d29ya2VkIHdhcyBhIG5pY2UgY291cnRlc3kgb2Ygb2xkIGtlcm5lbHMsCiAgKiBidXQgdGhl
IGNvZGUgdG8gc3VwcG9ydCBpdCBpcyBmYWlybHkgZ3Jvc3MuCiAgKi8KLXN0YXRpYyBpbnQg
dGVzdF9wcm9jZXNzX3ZtX3JlYWR2KHZvaWQpCitzdGF0aWMgdm9pZCB0ZXN0X3Byb2Nlc3Nf
dm1fcmVhZHYodm9pZCkKIHsKLSNpZmRlZiBfX3g4Nl82NF9fCiAJY2hhciBidWZbNDA5Nl07
CiAJc3RydWN0IGlvdmVjIGxvY2FsLCByZW1vdGU7CiAJaW50IHJldDsKIAotCXByaW50Zigi
W1JVTl1cdHByb2Nlc3Nfdm1fcmVhZHYoKSBmcm9tIHZzeXNjYWxsIHBhZ2VcbiIpOworCWtz
ZnRfcHJpbnRfbXNnKCJwcm9jZXNzX3ZtX3JlYWR2KCkgZnJvbSB2c3lzY2FsbCBwYWdlXG4i
KTsKIAogCWxvY2FsLmlvdl9iYXNlID0gYnVmOwogCWxvY2FsLmlvdl9sZW4gPSA0MDk2OwpA
QCAtNDg5LDI3ICs0MTQsNzEgQEAgc3RhdGljIGludCB0ZXN0X3Byb2Nlc3Nfdm1fcmVhZHYo
dm9pZCkKIAkJICogV2UgZXhwZWN0IHByb2Nlc3Nfdm1fcmVhZHYoKSB0byB3b3JrIGlmIGFu
ZCBvbmx5IGlmIHRoZQogCQkgKiB2c3lzY2FsbCBwYWdlIGlzIHJlYWRhYmxlLgogCQkgKi8K
LQkJcHJpbnRmKCJbJXNdXHRwcm9jZXNzX3ZtX3JlYWR2KCkgZmFpbGVkIChyZXQgPSAlZCwg
ZXJybm8gPSAlZClcbiIsIHZzeXNjYWxsX21hcF9yID8gIkZBSUwiIDogIk9LIiwgcmV0LCBl
cnJubyk7Ci0JCXJldHVybiB2c3lzY2FsbF9tYXBfciA/IDEgOiAwOworCQlrc2Z0X3Rlc3Rf
cmVzdWx0KCF2c3lzY2FsbF9tYXBfciwKKwkJCQkgInByb2Nlc3Nfdm1fcmVhZHYoKSBmYWls
ZWQgKHJldCA9ICVkLCBlcnJubyA9ICVkKVxuIiwgcmV0LCBlcnJubyk7CisJCXJldHVybjsK
IAl9CiAKLQlpZiAodnN5c2NhbGxfbWFwX3IpIHsKLQkJaWYgKCFtZW1jbXAoYnVmLCByZW1v
dGUuaW92X2Jhc2UsIHNpemVvZihidWYpKSkgewotCQkJcHJpbnRmKCJbT0tdXHRJdCB3b3Jr
ZWQgYW5kIHJlYWQgY29ycmVjdCBkYXRhXG4iKTsKLQkJfSBlbHNlIHsKLQkJCXByaW50Zigi
W0ZBSUxdXHRJdCB3b3JrZWQgYnV0IHJldHVybmVkIGluY29ycmVjdCBkYXRhXG4iKTsKLQkJ
CXJldHVybiAxOworCWlmICh2c3lzY2FsbF9tYXBfcikKKwkJa3NmdF90ZXN0X3Jlc3VsdCgh
bWVtY21wKGJ1ZiwgcmVtb3RlLmlvdl9iYXNlLCBzaXplb2YoYnVmKSksICJSZWFkIGRhdGFc
biIpOworCWVsc2UKKwkJa3NmdF90ZXN0X3Jlc3VsdF9mYWlsKCJwcm9jZXNzX3JtX3JlYWR2
KCkgc3VjY2VlZGVkLCBidXQgaXQgc2hvdWxkIGhhdmUgZmFpbGVkIGluIHRoaXMgY29uZmln
dXJhdGlvblxuIik7Cit9CisKK3N0YXRpYyB2b2lkIGluaXRfdnN5cyh2b2lkKQoreworCWlu
dCBuZXJycyA9IDA7CisJRklMRSAqbWFwczsKKwljaGFyIGxpbmVbTUFQU19MSU5FX0xFTl07
CisJYm9vbCBmb3VuZCA9IGZhbHNlOworCisJbWFwcyA9IGZvcGVuKCIvcHJvYy9zZWxmL21h
cHMiLCAiciIpOworCWlmICghbWFwcykgeworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoIkNv
dWxkIG5vdCBvcGVuIC9wcm9jL3NlbGYvbWFwcyAtLSBhc3N1bWluZyB2c3lzY2FsbCBpcyBy
LXhcbiIpOworCQl2c3lzY2FsbF9tYXBfciA9IHRydWU7CisJCXJldHVybjsKKwl9CisKKwl3
aGlsZSAoZmdldHMobGluZSwgTUFQU19MSU5FX0xFTiwgbWFwcykpIHsKKwkJY2hhciByLCB4
OworCQl2b2lkICpzdGFydCwgKmVuZDsKKwkJY2hhciBuYW1lW01BUFNfTElORV9MRU5dOwor
CisJCS8qIHNzY2FuZigpIGlzIHNhZmUgaGVyZSBhcyBzdHJsZW4obmFtZSkgPj0gc3RybGVu
KGxpbmUpICovCisJCWlmIChzc2NhbmYobGluZSwgIiVwLSVwICVjLSVjcCAlKnggJSp4OiUq
eCAlKnUgJXMiLAorCQkJICAgJnN0YXJ0LCAmZW5kLCAmciwgJngsIG5hbWUpICE9IDUpCisJ
CQljb250aW51ZTsKKworCQlpZiAoc3RyY21wKG5hbWUsICJbdnN5c2NhbGxdIikpCisJCQlj
b250aW51ZTsKKworCQlrc2Z0X3ByaW50X21zZygidnN5c2NhbGwgbWFwOiAlcyIsIGxpbmUp
OworCisJCWlmIChzdGFydCAhPSAodm9pZCAqKTB4ZmZmZmZmZmZmZjYwMDAwMCB8fAorCQkg
ICAgZW5kICE9ICh2b2lkICopMHhmZmZmZmZmZmZmNjAxMDAwKSB7CisJCQlrc2Z0X3ByaW50
X21zZygiYWRkcmVzcyByYW5nZSBpcyBub25zZW5zZVxuIik7CisJCQluZXJycysrOwogCQl9
Ci0JfSBlbHNlIHsKLQkJcHJpbnRmKCJbRkFJTF1cdHByb2Nlc3Nfcm1fcmVhZHYoKSBzdWNj
ZWVkZWQsIGJ1dCBpdCBzaG91bGQgaGF2ZSBmYWlsZWQgaW4gdGhpcyBjb25maWd1cmF0aW9u
XG4iKTsKLQkJcmV0dXJuIDE7CisKKwkJa3NmdF9wcmludF9tc2coInZzeXNjYWxsIHBlcm1p
c3Npb25zIGFyZSAlYy0lY1xuIiwgciwgeCk7CisJCXZzeXNjYWxsX21hcF9yID0gKHIgPT0g
J3InKTsKKwkJdnN5c2NhbGxfbWFwX3ggPSAoeCA9PSAneCcpOworCisJCWZvdW5kID0gdHJ1
ZTsKKwkJYnJlYWs7CiAJfQotI2VuZGlmCiAKLQlyZXR1cm4gMDsKKwlmY2xvc2UobWFwcyk7
CisKKwlpZiAoIWZvdW5kKSB7CisJCWtzZnRfcHJpbnRfbXNnKCJubyB2c3lzY2FsbCBtYXAg
aW4gL3Byb2Mvc2VsZi9tYXBzXG4iKTsKKwkJdnN5c2NhbGxfbWFwX3IgPSBmYWxzZTsKKwkJ
dnN5c2NhbGxfbWFwX3ggPSBmYWxzZTsKKwl9CisKKwlrc2Z0X3Rlc3RfcmVzdWx0KCFuZXJy
cywgInZzeXNjYWxsIG1hcFxuIik7CiB9CiAKLSNpZmRlZiBfX3g4Nl82NF9fCiBzdGF0aWMg
dm9sYXRpbGUgc2lnX2F0b21pY190IG51bV92c3lzY2FsbF90cmFwczsKIAogc3RhdGljIHZv
aWQgc2lndHJhcChpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKmN0eF92b2lkKQpA
QCAtNTIxLDE1ICs0OTAsMTcgQEAgc3RhdGljIHZvaWQgc2lndHJhcChpbnQgc2lnLCBzaWdp
bmZvX3QgKmluZm8sIHZvaWQgKmN0eF92b2lkKQogCQludW1fdnN5c2NhbGxfdHJhcHMrKzsK
IH0KIAotc3RhdGljIGludCB0ZXN0X2VtdWxhdGlvbih2b2lkKQorc3RhdGljIHZvaWQgdGVz
dF9lbXVsYXRpb24odm9pZCkKIHsKIAl0aW1lX3QgdG1wOwogCWJvb2wgaXNfbmF0aXZlOwog
Ci0JaWYgKCF2c3lzY2FsbF9tYXBfeCkKLQkJcmV0dXJuIDA7CisJaWYgKCF2c3lzY2FsbF9t
YXBfeCkgeworCQlrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoInZzeXNjYWxsX21hcF94IGlzbid0
IHNldFxuIik7CisJCXJldHVybjsKKwl9CiAKLQlwcmludGYoIltSVU5dXHRjaGVja2luZyB0
aGF0IHZzeXNjYWxscyBhcmUgZW11bGF0ZWRcbiIpOworCWtzZnRfcHJpbnRfbXNnKCJjaGVj
a2luZyB0aGF0IHZzeXNjYWxscyBhcmUgZW11bGF0ZWRcbiIpOwogCXNldGhhbmRsZXIoU0lH
VFJBUCwgc2lndHJhcCwgMCk7CiAJc2V0X2VmbGFncyhnZXRfZWZsYWdzKCkgfCBYODZfRUZM
QUdTX1RGKTsKIAl2dGltZSgmdG1wKTsKQEAgLTU0NSwzNiArNTE2LDM1IEBAIHN0YXRpYyBp
bnQgdGVzdF9lbXVsYXRpb24odm9pZCkKIAkgKi8KIAlpc19uYXRpdmUgPSAobnVtX3ZzeXNj
YWxsX3RyYXBzID4gMSk7CiAKLQlwcmludGYoIlslc11cdHZzeXNjYWxscyBhcmUgJXMgKCVk
IGluc3RydWN0aW9ucyBpbiB2c3lzY2FsbCBwYWdlKVxuIiwKLQkgICAgICAgKGlzX25hdGl2
ZSA/ICJGQUlMIiA6ICJPSyIpLAotCSAgICAgICAoaXNfbmF0aXZlID8gIm5hdGl2ZSIgOiAi
ZW11bGF0ZWQiKSwKLQkgICAgICAgKGludCludW1fdnN5c2NhbGxfdHJhcHMpOwotCi0JcmV0
dXJuIGlzX25hdGl2ZTsKKwlrc2Z0X3Rlc3RfcmVzdWx0KCFpc19uYXRpdmUsICJ2c3lzY2Fs
bHMgYXJlICVzICglZCBpbnN0cnVjdGlvbnMgaW4gdnN5c2NhbGwgcGFnZSlcbiIsCisJCQkg
KGlzX25hdGl2ZSA/ICJuYXRpdmUiIDogImVtdWxhdGVkIiksIChpbnQpbnVtX3ZzeXNjYWxs
X3RyYXBzKTsKIH0KICNlbmRpZgogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CiB7Ci0JaW50IG5lcnJzID0gMDsKKwlpbnQgdG90YWxfdGVzdHMgPSBUT1RBTF9URVNUUzsK
IAotCWluaXRfdmRzbygpOwotCW5lcnJzICs9IGluaXRfdnN5cygpOworCWtzZnRfcHJpbnRf
aGVhZGVyKCk7CisJa3NmdF9zZXRfcGxhbih0b3RhbF90ZXN0cyk7CiAKLQluZXJycyArPSB0
ZXN0X2d0b2QoKTsKLQluZXJycyArPSB0ZXN0X3RpbWUoKTsKLQluZXJycyArPSB0ZXN0X2dl
dGNwdSgwKTsKLQluZXJycyArPSB0ZXN0X2dldGNwdSgxKTsKLQotCXNldGhhbmRsZXIoU0lH
U0VHViwgc2lnc2VndiwgMCk7Ci0JbmVycnMgKz0gdGVzdF92c3lzX3IoKTsKLQluZXJycyAr
PSB0ZXN0X3ZzeXNfeCgpOworCWluaXRfdmRzbygpOworI2lmZGVmIF9feDg2XzY0X18KKwlp
bml0X3ZzeXMoKTsKKyNlbmRpZgogCi0JbmVycnMgKz0gdGVzdF9wcm9jZXNzX3ZtX3JlYWR2
KCk7CisJdGVzdF9ndG9kKCk7CisJdGVzdF90aW1lKCk7CisJdGVzdF9nZXRjcHUoMCk7CisJ
dGVzdF9nZXRjcHUoMSk7CiAKICNpZmRlZiBfX3g4Nl82NF9fCi0JbmVycnMgKz0gdGVzdF9l
bXVsYXRpb24oKTsKKwlzZXRoYW5kbGVyKFNJR1NFR1YsIHNpZ3NlZ3YsIDApOworCXRlc3Rf
dnN5c19yKCk7CisJdGVzdF92c3lzX3goKTsKKwl0ZXN0X3Byb2Nlc3Nfdm1fcmVhZHYoKTsK
Kwl0ZXN0X2VtdWxhdGlvbigpOwogI2VuZGlmCiAKLQlyZXR1cm4gbmVycnMgPyAxIDogMDsK
Kwlrc2Z0X2ZpbmlzaGVkKCk7CiB9Cg==

--------------PYPiMvyQ0bQx0s17qCPHNZP3--

