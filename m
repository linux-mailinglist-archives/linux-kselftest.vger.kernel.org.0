Return-Path: <linux-kselftest+bounces-13668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6192F7A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A97281870
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178E1442F7;
	Fri, 12 Jul 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RIdtfsdn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E9143747;
	Fri, 12 Jul 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775455; cv=none; b=oQZrdH4vGN59szeuIgVusAnKr66aRUbL8qhZV2t+VbY8rzg/ADQQ3chsrYmQWtVvA5s2sWXrpn44jIByweVj4Xxi/RV3nH4A3/MJDPE07U5XaNCIhItMXbN8F/VSQyvfWNjyr1SenGtrMSTZolqtHImNIXEBObzrg4uwKoxrkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775455; c=relaxed/simple;
	bh=RqrDhr4mKdHOIlBs1nQe1pWETVXoN5c5DZn2yZP90V8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUA0mr8G72r16tiMXZn8HcLQ5DbcSOKLzxz2t87j1XbI8toSo/j2rG5rmrppL1iwezF0gY+5tP6uSuxG/K7T5sApl94ajp5e0rJHcUl86lLd8DgqybLzsSCXScf0ZT2SzSnbuZKF6clOxHBiRhj3mZ/n1cSqXArBCm7L9b7d6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RIdtfsdn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720775452;
	bh=RqrDhr4mKdHOIlBs1nQe1pWETVXoN5c5DZn2yZP90V8=;
	h=From:To:Cc:Subject:Date:From;
	b=RIdtfsdnYXpnFid3qwfKgEuFSBviD1hq9vmC7ckpVQNWVz1XULbbBo4PB8vKIT3GU
	 +7ooljJpIhTEre1z9Et0ihFEorobz865JKit4HBF/Q+DumvD7sba6Kd2PuXpLs4TaI
	 gm47Q0Y4UTzFrOlBaoFU/KztCjjSZ3MbwwVQcme9ZqVkXs9m6xRhZos+r5i8Tl/m5o
	 xleLUt1p8A7Bux3Dr5d5YJONaBIGZSRfaBrG5nCp7IFvHJR2DX0mgtLbguaRr4G8ne
	 2Fu4Ll5ToP/88sKARx/qTOY5GwVyn/zsyoVtIn3brxlv0zrP/bUWzRT+XVIPYxtjKf
	 LFLuFwrwM5HDw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 11E1137821DB;
	Fri, 12 Jul 2024 09:10:52 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-07-11
Date: Fri, 12 Jul 2024 11:11:21 +0200
Message-Id: <20240712091121.19116-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

KernelCI is hosting a bi-weekly call on Thursday to discuss improvements to
existing upstream tests, the development of new tests to increase kernel
testing coverage, and the enablement of these tests in KernelCI. In recent
months, we at Collabora have focused on various kernel areas, assessing the
tests already available upstream and contributing patches to make them
easily runnable in CIs.

Below is a list of the tests we've been working on and their latest status
updates, as discussed in the last meeting held on 2024-07-11:

*USB/PCI devices kselftest*

- Upstream test to detect unprobed devices on discoverable buses:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dacf1d7a78bf8a131346c47bfba7fe1f3ff44beb
- Updated KernelCI PRs according to feedback, now waiting for the first
  test results: https://github.com/kernelci/kernelci-core/pull/2577 and
  https://github.com/kernelci/kernelci-pipeline/pull/642

*Error log test*

- Proposing new kselftest to report device log errors:
  https://lore.kernel.org/all/20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com/
- Series got Acked-By from Greg, going to be picked up by Shuah soon
- Feedback from Tim Bird: this series follows an unusual model where
  tests can only fail but never pass, as no test case is generated unless
  there is an error. It takes an unusual approach to detect regressions and
  fixes. The autogenerated test case names are not very descriptive.

*Suspend/resume in cpufreq kselftest*

- Enabling suspend/resume test within the cpufreq kselftest in KernelCI -
- Sent patch upstream for adding RTC wakeup alarm in the cpufreq
  kselftest:
  https://lore.kernel.org/all/2e667d-668ff800-1-22d70300@133606496/
- Received a review from Rafael J. Wysocki, who suggested using the
  rtcwake utility instead of the sysfs entry

*Boot time test*

- Drafted initial implementation with two scripts, a config fragment and
  a bootconfig file
- One script generates a YAML file containing initial timestamps for
  relevant boot events, parsed from the trace file (run once)
- The other script is the actual test, which takes the generated YAML
  file and a delta in seconds as arguments. The script then parses the
  current trace file and checks if any timestamp deviates from the
  reference timestamps in the YAML file by more than the specified delta.
- Tracking only a few functions at the moment (populate_rootfs,
  unpack_to_rootfs, run_init_process). Next steps: refine bootconfig file
  to include more tracepoints (potentially initcalls too?). Useful
  tracepoints should be discussed upstream.
- Will present this at LPC 2024 (embedded and IoT MC)

*Support for benchmark data in KTAP*

- Tim Bird is working on adding performance data to KTAP output, which
  can be used in tests to detect slowdowns
- The idea is to keep reference values and criteria separate from the
  test itself
- There is a need to store per-platform files with previous times for
  comparison
- Will need to figure out where these files can be stored so they can be
  shared and used by different people and systems. Potential options: KCIDB
  or https://github.com/kernelci/platform-test-parameters
- Submitted a proposal for LPC 2024 
- Other related topics for discussion at LPC 2024 include: how to avoid
  device tree overhead in the boot process and boot phases (time-critical
  vs non-critical)

*TAP conformance in kselftests*

- Focusing on standardizing the way kernel's testing modules report
  results
- Discussion ongoing upstream over patches converting tests to TAP:
  https://lore.kernel.org/all/fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org
  and
  https://lore.kernel.org/all/6d82fa16-ed2e-41f1-a466-c752032b6f68@linuxfoundation.org

Please reply to this thread if you'd like to join the call or discuss any
of the topics further. We look forward to collaborating with the community
to improve upstream tests and expand coverage to more areas of interest
within the kernel.

Best regards,

Laura Nao



