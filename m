Return-Path: <linux-kselftest+bounces-10098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244AD8C32AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF18A28206E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2891B970;
	Sat, 11 May 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="N0dHxiYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473C1B7F7
	for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447703; cv=none; b=j5vtby7+SjOzBnIEAla3OURskvktDjHgSMXHjuPRdUkJykuSbJW0aNUDszoUcB+NDR1jvvRQZqp67yKlMs4KxvbdPyrc51KQs+9/oBYXzh583BHpNXRIyi1lb9WrR+T9K8fGkM0ZNw61i7deNaurJ80CqujXPJ2cbRD7xlZwpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447703; c=relaxed/simple;
	bh=+tQTqpBZCO71TI+xI+ycJvxEwQZ2ovGc4EulihGFtA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IpP1FqkCMFtGIE4x2+laT4ttKGCzRAyVBpgudLWQ6JbRUWHz2p9uI4bkbduFyVK3EvNTMWifLcmcVnnJgErliJKSEwW4jC8b2JJ3yoUNp4xvCgRw6niyrA26NGyc3uTQo/ecRrHNG+CnrmKosPaEIL3hkwpE6Bf1bCmFvOBUBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=N0dHxiYm; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcC6g06BzzZwN;
	Sat, 11 May 2024 19:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715447690;
	bh=AhX78OfDbhvNohV5s96n3dHIuZwZXD9GikV+VwHjPBk=;
	h=From:To:Cc:Subject:Date:From;
	b=N0dHxiYmx8vVCys6IRVXrYH2dIepVwv2/zMpcy+tQzcVlIsHRbh/USCROwlSJ6UnD
	 4Bh6tkCOOX2dNo9htOlBc63EMhcAuI3Z6Rn7RFHEGt3VmFLvAIIxtqFD4XL9Sa5r4m
	 ZOAauyRkkzriLHck1Jl9r4HjGL+PSbfDZBHJ9mi4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcC6c3FkrzRFZ;
	Sat, 11 May 2024 19:14:48 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 00/10] Fix Kselftest's vfork() side effects
Date: Sat, 11 May 2024 19:14:35 +0200
Message-ID: <20240511171445.904356-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This seven series fix an issue reported by kernel test robot [3].

Shuah,  I (as well as Kees and Sean [4]) think this should be in -next
really soon to make sure everything works fine for the v6.9 release,
which is not currently the case.  I cannot test against all kselftests
though.  I would prefer to let you handle this, but I guess you're not
able to do so and I'll push it on my branch without reply from you.
Even if I push it on my branch, please push it on yours too as soon as
you see this and I'll remove it from mine.

Mark, Jakub, could you please test this series?

As reported by Kernel Test Robot [1] and Sean Christopherson [2], some
tests fail since v6.9-rc1 .  This is due to the use of vfork() which
introduced some side effects.  Similarly, while making it more generic,
a previous commit made some Landlock file system tests flaky, and
subject to the host's file system mount configuration.

This series fixes all these side effects by replacing vfork() with
clone3() and CLONE_VFORK, which is cleaner (no arbitrary shared memory)
and makes the Kselftest framework more robust.

I tried different approaches and I found this one to be the cleaner and
less invasive for current test cases.

I successfully ran the following tests (using TEST_F and
fork/clone/clone3, and KVM_ONE_VCPU_TEST) with this series:
- kvm:fix_hypercall_test
- kvm:sync_regs_test
- kvm:userspace_msr_exit_test
- kvm:vmx_pmu_caps_test
- landlock:fs_test
- landlock:net_test
- landlock:ptrace_test
- move_mount_set_group:move_mount_set_group_test
- net/af_unix:scm_pidfd
- perf_events:remove_on_exec
- pidfd:pidfd_getfd_test
- pidfd:pidfd_setns_test
- seccomp:seccomp_bpf
- user_events:abi_test

[1] https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
[2] https://lore.kernel.org/r/ZjPelW6-AbtYvslu@google.com
[3] https://lore.kernel.org/r/202405100339.vfBe0t9C-lkp@intel.com
[4] https://lore.kernel.org/r/202405061002.01D399877A@keescook

Previous versions:
v1: https://lore.kernel.org/r/20240426172252.1862930-1-mic@digikod.net
v2: https://lore.kernel.org/r/20240429130931.2394118-1-mic@digikod.net
v3: https://lore.kernel.org/r/20240429191911.2552580-1-mic@digikod.net
v4: https://lore.kernel.org/r/20240502210926.145539-1-mic@digikod.net
v5: https://lore.kernel.org/r/20240503105820.300927-1-mic@digikod.net
v6: https://lore.kernel.org/r/20240506165518.474504-1-mic@digikod.net

Regards,

Mickaël Salaün (10):
  selftests/pidfd: Fix config for pidfd_setns_test
  selftests/landlock: Fix FS tests when run on a private mount point
  selftests/harness: Fix fixture teardown
  selftests/harness: Fix interleaved scheduling leading to race
    conditions
  selftests/landlock: Do not allocate memory in fixture data
  selftests/harness: Constify fixture variants
  selftests/pidfd: Fix wrong expectation
  selftests/harness: Share _metadata between forked processes
  selftests/harness: Fix vfork() side effects
  selftests/harness: Handle TEST_F()'s explicit exit codes

 tools/testing/selftests/kselftest_harness.h   | 127 +++++++++++++-----
 tools/testing/selftests/landlock/fs_test.c    |  83 +++++++-----
 tools/testing/selftests/pidfd/config          |   2 +
 .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
 4 files changed, 147 insertions(+), 67 deletions(-)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.45.0


