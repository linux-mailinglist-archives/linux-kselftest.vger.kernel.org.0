Return-Path: <linux-kselftest+bounces-12155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980B90D625
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1253B2E7B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9A148310;
	Tue, 18 Jun 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GtOJ81v+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF31494BD;
	Tue, 18 Jun 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720114; cv=none; b=RZ92rQboyNqhGouAgT2+YvpL4kdljIByvVF4c4olKvFiHcp29yLBd/iQ6tpPiACZwBUnUsHCrD3nRDLB0yE6obnN7kGTGr7qjzYBIJ6l3yAYE5A/nFPQL/MiMRTvVteucrbc8dltGriQfH5bi9BhlCTudxwA1A23WrDVfJ1hbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720114; c=relaxed/simple;
	bh=XiNA2bmdGPVnZdV4xtxYDEsTyXlfzKtM5Af0h6rckcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PrIhnjdQ3eFAC/s1Hfns7ZSxdBYc+hBJXxmWK8jgcyhuu88SYny0e/891uHIeYBjzhQvC6aJeRcmRmfxTr7NiOmIVHphwVDmf3ZlkxSd9gnQEEFVp+WS8hd48MTC6WccRNSxh+16pMOFFvuAVzApHKxkkxgP9UipQAjnp0TdglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GtOJ81v+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718720110;
	bh=XiNA2bmdGPVnZdV4xtxYDEsTyXlfzKtM5Af0h6rckcY=;
	h=From:To:Cc:Subject:Date:From;
	b=GtOJ81v+Je2ts2llIY4JtQP+EhBh0b6nAgBFnBy8mnn8gQANH1xUIs1cflsysPYx1
	 nF4IXO2o1g5eSxbP07PZ3KjEZrTjMmv9zXyL4xGJIt7qF4h5GbsX19H7jf87qHrouX
	 P8UwmgizejGFxTMs1IdRZefyVq7E6VpoO4ecS5kY1AYpJHw8eS1fef2JJoi4/nNI7i
	 9r5V261N6SBK6WYlr+8rVjsTzdASUiikmVczTzHSHMKBvfkfnhZUyuDjGYDH3BiOF1
	 cvOW9RpFsEDX0UTaaRyOYWpPqJDEsrNadCIo3VMbw2r9z1ZOqSqdVeSDjEZ3JWqnMA
	 N68VUBBjuVA+Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B7783780F7F;
	Tue, 18 Jun 2024 14:15:10 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-06-13
Date: Tue, 18 Jun 2024 16:15:29 +0200
Message-Id: <20240618141529.60741-1-laura.nao@collabora.com>
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
status updates, as discussed in the last meeting held on 2024-06-13:

*ACPI probe kselftest*

- Proposing new kselftest to detect unprobed devices on ACPI platforms:
  https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com
- Regression on acpi_fan driver detected and fixed upstream after
  preliminary testing in KernelCI. Sent follow-up on RFCv2. 

*USB/PCI devices kselftest*

- Upstream test to detect unprobed devices on discoverable buses:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dacf1d7a78bf8a131346c47bfba7fe1f3ff44beb 
- Preparing to enable the test in KernelCI on MediaTek Chromebooks in the
  Collabora LAVA lab - see: https://github.com/kernelci/kernelci-pipeline/issues/579

*Watchdog kselftest*

- Adding KTAP output and limiting the ping loop to run the test 
  individually in CIs:  https://lore.kernel.org/all/20240506111359.224579-1-laura.nao@collabora.com
- Received feedback on series, discussion ongoing

*Watchdog reset test*

- Implementing out-of-tree test in KernelCI to detect device reset after 
  watchdog timeout expiration: 
  https://github.com/kernelci/kernelci-pipeline/issues/608
- Enabled test in KernelCI for all ARM64 and AMD Chromebooks, currently 
  monitoring the results

*Error log test*

- Proposing new kselftest to report device log errors:
  https://lore.kernel.org/all/20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com/
- Standardizing error log format suggested for easier parsing, including 
  for kernel panic/oops/warning messages.

*Suspend/resume in cpufreq kselftest*

- Enabling suspend/resume test within the cpufreq kselftest in KernelCI
- Adding parameter support to kselftest script in KernelCI:
  https://github.com/Linaro/test-definitions/pull/511 
- Planning to add support for rtcwake in the test, to enable automated
  resume 
- Considering measuring latency for suspend and resume processes

*TAP conformance in kselftests*

- Ongoing improvements to KVM selftests, discussion ongoing upstream
  https://lore.kernel.org/all/20240422170842.2073979-1-usama.anjum@collabora.com/
  https://lore.kernel.org/all/20240612104500.425012-1-usama.anjum@collabora.com/
- Enabling more kselftests in KernelCI  (dmabuf-heaps, exec, and iommu): 
  https://github.com/kernelci/kernelci-pipeline/pull/640/

*Boot time test*

- Investigating possibility of adding new test upstream to measure the 
  kernel boot time and detect regressions 
- Need to investigate available interfaces for reporting boot/probe times
- Multiple measurement points may be necessary, need to establish a clear 
  definition of "boot" first
- Influenced by defconfig; testing with various kernel configurations 
  recommended

*Possible improvements to kselftest documentation*

- Document tests excluded from default kselftest run and parameter 
  support

*Test configuration reporting in KernelCI*

- Discussing reporting more details on the test configuration used:
  https://github.com/kernelci/kernelci-pipeline/issues/636

Please reply to this thread if you'd like to join the call or discuss 
any of the topics further. We look forward to collaborating with the 
community to improve upstream tests and expand coverage to more areas 
of interest within the kernel.

Best regards,

Laura Nao

