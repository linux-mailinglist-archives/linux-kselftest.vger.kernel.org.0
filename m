Return-Path: <linux-kselftest+bounces-8792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C018B10E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DED728B0A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F916D304;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2WIpPo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E30160794;
	Wed, 24 Apr 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979488; cv=none; b=ZwlBdf5JU590Y6j3n9s3ukED31hypOETGV+tDgGCtVz8MIhJek278kSdMEhetRj/zGueybg9cUUCV4bP9WGMBW/b8KunB6FIhYzOffbXDxSxtU53s5Wuozo2RedTHQV4wbsttEr+eIqWvwJMzm2KYNZ27Rv3q2fhtAw5thyu97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979488; c=relaxed/simple;
	bh=7a/aAi2AQMEaXyJBYPENiWldcWe8zLQuMjiOVus5MY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VhDzMUCNJ4gP7x+cVmojQQbxgOTTv5v1vb0vw4krG/jBWP6eNoRfV1viXq9bkwusy3QGqPvu1r56YiZIU6s6V1WRt3s/oxt/dB2OQ9FXKe8HFwZXVdoxWFJ1/UyTW+LCf9aZzDry+wl3mb92f7hnh9qzh1sVklExIIDok2OHGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2WIpPo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9595C113CD;
	Wed, 24 Apr 2024 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979487;
	bh=7a/aAi2AQMEaXyJBYPENiWldcWe8zLQuMjiOVus5MY4=;
	h=From:Subject:Date:To:Cc:From;
	b=Z2WIpPo3CfWypicVRNJgNKpBkKw2IDDbvmOWn/pVpXbT3ddGt53iU2hSr3QT2XvPj
	 wxzIO4K6WCuwaLySXxCbnVEl3zbO6CHF+i2H3cIn83SpoSi/QbIQ+3xG/GXMC/+ynt
	 6XfMM6R4nAZXnsIcNclHdJGJZsSriTj2zah+o18dWvKm8RDEN2R1bqzV0dCUQetPLt
	 7GXh2qfhnGrZKbGIN+ZYsfvyic5ysOF7jq1yI+vmsA/VLZlExE3uhY55rXuV38hYlm
	 s8G2GZ79FFhaa16xxP42lR7/fRXs4jys6AsSCM1pi0lHlzrpR4LA0AcmDbO7h+YtRe
	 N9NgUNJN2i+ig==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 00/10] selftests: Make ksft_exit functions return void
 instead of int
Date: Wed, 24 Apr 2024 10:24:03 -0700
Message-Id: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNAKWYC/3WNQQ6CMBBFr0Jm7RgKKODKexgWrZ3CBNOStmkwh
 LtbSVy6fC/5728QyDMFuBUbeEoc2NkM1amA5yTtSMg6M1Rl1ZSNuOIcTERaOSLbiNFhcqzxImW
 vVd2Juu0hbxdPhtej+xgyTxyi8+/jJomv/RXbP8UkUCAZ03RGK6nq/j6Tt/Q6Oz/CsO/7BxdNF
 5W7AAAA
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
 fenghua.yu@intel.com, reinette.chatre@intel.com, anna-maria@linutronix.de, 
 frederic@kernel.org, jstultz@google.com, sboyd@kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5976; i=nathan@kernel.org;
 h=from:subject:message-id; bh=7a/aAi2AQMEaXyJBYPENiWldcWe8zLQuMjiOVus5MY4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrHX9pxyqA0s1zFa5KucKbPIvNvLxSXIj5eP6bY38
 w+GULuOUhYGMS4GWTFFlurHqscNDeecZbxxahLMHFYmkCEMXJwCMJGJ9gz/dBh2a/QtuCOVdXra
 xRLeO0EBkZfNHHwmZ4SqRfb1Pj6WyvCT0eKB95fvR5afu9AXkLl11RvpwEuhSusOa31c1XGm+Y0
 TIwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn") marked functions that call
exit() as __noreturn but it did not change the return type of these
functions from 'void' to 'int' like it should have (since a noreturn
function by definition cannot return an integer because it does not
return...) because there are many tests that return the result of the
ksft_exit function, even though it has never been used due to calling
exit().

Prior to adding __noreturn, the compiler would not know that the functions
that call exit() will not return, so code like

  void ksft_exit_fail(void)
  {
    exit(1);
  }

  void ksft_exit_pass(void)
  {
    exit(0);
  }

  int main(void)
  {
    int ret;

    ret = foo();
    if (ret)
      ksft_exit_fail();
    ksft_exit_pass();
  }

would cause the compiler to complain that main() does not return an
integer, even though when ksft_exit_pass() is called, exit() will cause
the program to terminate. So ksft_exit_...() returns int to make the
compiler happy.

  int ksft_exit_fail(void)
  {
    exit(1);
  }

  int ksft_exit_pass(void)
  {
    exit(0);
  }

  int main(void)
  {
    int ret;

    ret = foo();
    if (ret)
      return ksft_exit_fail();
    return ksft_exit_pass();
  }

While this results in no warnings, it is weird semantically and it has
issues as noted in the aforementioned __noreturn change. Now that
__noreturn has been added to these functions, it is much cleaner to
change the functions to 'void' and eliminate the return statements, as
it has been made clear to the compiler that these functions terminate
the program. Drop the return before all instances of ksft_exit_...() in
a mostly mechanical way.

---
Changes in v2:
- Split series into individual patches per subsystem at Shuah's
  request and CC maintainers for subsystems that have one.
- Rewrite commit messages for new patches and move previous commit
  message into cover letter to high level explain all changes.
- Carry forward Thomas and Muhammad's review on patch split, as there
  were no functional changes, please holler if this was inappropriate.
- Link to v1: https://lore.kernel.org/r/20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org

---
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

 tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
 tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
 tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
 tools/testing/selftests/kselftest.h                          | 12 ++++++------
 .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
 .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
 tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
 tools/testing/selftests/mm/cow.c                             |  2 +-
 tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
 tools/testing/selftests/mm/gup_test.c                        |  4 ++--
 tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
 tools/testing/selftests/mm/madv_populate.c                   |  2 +-
 tools/testing/selftests/mm/mkdirty.c                         |  2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
 tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
 tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
 tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
 tools/testing/selftests/sync/sync_test.c                     |  3 +--
 tools/testing/selftests/timers/adjtick.c                     |  4 ++--
 tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
 tools/testing/selftests/timers/change_skew.c                 |  4 ++--
 tools/testing/selftests/timers/freq-step.c                   |  4 ++--
 tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
 tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
 tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
 tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
 tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
 tools/testing/selftests/timers/set-2038.c                    |  4 ++--
 tools/testing/selftests/timers/set-tai.c                     |  4 ++--
 tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
 tools/testing/selftests/timers/set-tz.c                      |  4 ++--
 tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
 tools/testing/selftests/timers/threadtest.c                  |  2 +-
 tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
 tools/testing/selftests/x86/lam.c                            |  2 +-
 38 files changed, 81 insertions(+), 79 deletions(-)
---
base-commit: 0e275f65f3ef9c662b678655c70aca555fbde304
change-id: 20240416-ksft-exit-int-to-void-5aa9db381379

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


