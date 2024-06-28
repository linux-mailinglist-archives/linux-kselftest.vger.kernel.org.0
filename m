Return-Path: <linux-kselftest+bounces-12924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8D91BB59
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788521C226E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A8152783;
	Fri, 28 Jun 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oi2XBDoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82D1465A1;
	Fri, 28 Jun 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566544; cv=none; b=uSi8jlDumBtOCDLb/7fAzmD67ChEbDa8dxJ3SFjHz0B9htcK1OvEgHvnxGlyYa1Ign/oUhlIKFhso/+KUbkbrkKmioUAzKMKtsDlD4QgBtI9cn1eIUD4onzxpIv8hhSnVt1gfvt261kk0dtdBhAnY90S56Dr/ampBo0imtrR6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566544; c=relaxed/simple;
	bh=No5kI0JbClGdXNXP6BWBYQzHDNI+RX4pElyDv6jIUJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWtZBHtxX++TjmS+oHby0Nbn4Ez/NIhcgqCrpX5p4TD1rwxswt64oZAVJcREeHGGGJCL/c0RG3/6d6sGZUnyo1P2zE/0YOAXmaEpzUv8Phi1rEjiHPJLneMa3NbVFj4xN2tZmNv2PT6Y5fqKzo3hHYseJsbGG3RdhS/osBtPo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oi2XBDoD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719566534;
	bh=No5kI0JbClGdXNXP6BWBYQzHDNI+RX4pElyDv6jIUJA=;
	h=From:To:Cc:Subject:Date:From;
	b=Oi2XBDoDzH2H+YQXkPHfnOkemXC9QZbvBVlFnBLw6Q97qvHa6qQXc7udTWCgYKmgZ
	 jF55LXYylWhWXofaB0DsqvVer3PwsOo6fcuBUh4jIK2pGC9iL0FT0pjN8wxXbsfj6B
	 xmaUNxGKAMPONbxrBy7kLtkilkge8Saa0mbUC7lhHSY064t77UnA+NhpYixH4xnE3Q
	 M7SBnp8i2w/zD2t7DoZI0udFlfXU1n1vmAQbODPk8VMSJJfpQC8VFwBrE+6kYGhwIv
	 Xg0sV1vHJGljnueAtB2wggcx5i7iKsWySqLqohIQ3ZoVBVL9aCoC7H2rgTmK5lFwif
	 PpNr40bE2KAaA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B6B837821A8;
	Fri, 28 Jun 2024 09:22:13 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-06-27
Date: Fri, 28 Jun 2024 11:22:49 +0200
Message-Id: <20240628092249.26582-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

KernelCI is hosting a bi-weekly call on Thursday to discuss improvements 
to existing upstream tests, the development of new tests to increase 
kernel testing coverage, and the enablement of these tests in KernelCI. 
In recent months, we at Collabora have focused on various kernel areas,
assessing the tests already available upstream and contributing patches 
to make them easily runnable in CIs.

Below is a list of the tests we've been working on and their latest 
status updates, as discussed in the last meeting held on 2024-06-27:

*USB/PCI devices kselftest*

- Upstream test to detect unprobed devices on discoverable buses:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dacf1d7a78bf8a131346c47bfba7fe1f3ff44beb 
- Kernel patches to allow running the test on more platforms on KernelCI 
  were merged:
  https://lore.kernel.org/all/20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com
- Waiting for KernelCI PRs to be merged:
  https://github.com/kernelci/kernelci-core/pull/2577 and https://github.com/kernelci/kernelci-pipeline/pull/642

*Error log test*

- Proposing new kselftest to report device log errors: 
  https://lore.kernel.org/all/20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com/
- Currently fixing test failures in KernelCI

*Suspend/resume in cpufreq kselftest*

- Enabling suspend/resume test within the cpufreq kselftest in KernelCI
- Parameter support for running subtests in a kselftest was merged: 
  https://github.com/Linaro/test-definitions/pull/511
- Added rtcwake support in the test to enable automated resume, currently 
  testing/debugging solution

*Boot time test*

- Investigating possibility of adding new test upstream to measure the 
  kernel boot time and detect regressions
- Currently looking into boot tracing with ftrace events and kprobes 
  (see: https://www.kernel.org/doc/html/latest/trace/boottime-trace.html)
- Idea for potential kselftest: insert explicit tracepoints in strategic 
  places, let the user configure which times to measure. The test could 
  provide a bootconfig file and a fragment to enable the required configs.
  This could be an alternative to using external tools (e.g. grabserial 
  w/ early serial port init).
- Need a list of functions to track in order to measure key metrics 
  (e.g. device tree overhead, probe overhead, module load overhead)
- Identify key drivers that need to be loaded early, for potentially 
  supporting a two-phase boot: (1) time-critical, and (2) rest of the 
  system

*Other interesting updates*

- Flaky serial on sc7180 was recently fixed: 
  https://github.com/kernelci/kernelci-project/issues/380 and https://lore.kernel.org/all/20240610222515.3023730-1-dianders@chromium.org/#t

*Strategy for test enablement in KernelCI*

- Guidance on test quality: KernelCI should set the standard for test 
  quality, providing guidance on which tests to enable from various 
  projects (e.g., kselftest, LTP). By doing so, KernelCI can serve as a 
  model for other CI systems.
- Develop mechanisms to automatically detect which tests should run on a
  specific platform
- Embed metadata in the test themselves to facilitate the test selection
  process
- Leverage device tree info to determine the appropriate tests for each 
  platform

Please reply to this thread if you'd like to join the call or discuss 
any of the topics further. We look forward to collaborating with the 
community to improve upstream tests and expand coverage to more areas 
of interest within the kernel.

Best regards,

Laura Nao

