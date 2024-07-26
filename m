Return-Path: <linux-kselftest+bounces-14271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F993D495
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98231F21D2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1AC1E87B;
	Fri, 26 Jul 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nlOsVcbG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C41E533;
	Fri, 26 Jul 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001840; cv=none; b=b8xfNHlpTo6Ex527NKV9eFQh1M+OUmZsgg4UJ724vw5183IkHY+bCLcqPqKjfu/E6tqdXoR5t1mbGPzQLmHNPTUxxPos7Gv2IXxFFqRqXpoDu1gmqee+feTe/+vmQof3zEeC//+9xJ9+awGh8oLKV9nf1h1xjE8WX5h5MVtWQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001840; c=relaxed/simple;
	bh=Iyax8yzW+8JlNwyoV0RroXKbzsmNZ93yFf8MATkzhX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFlZUE7dqyUDtrJhUybEvQhO8ESA0QCXNex+ViDne8j6vRk7JxeuJCcCGXkC0vaqf3dJf5/EwAmlNVXEsCJghHTTVZGpZWuUMAWReQYgLIUmB0IdGWa45DU0ROpbSPidE4AtAs9LPScj4WVy6ZHRH3osCgbYQ3U8drnOQ1ew2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nlOsVcbG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722001837;
	bh=Iyax8yzW+8JlNwyoV0RroXKbzsmNZ93yFf8MATkzhX0=;
	h=From:To:Cc:Subject:Date:From;
	b=nlOsVcbG+Hg7At42isUuQKbEt1q8tAyo+u2TyBkCjkh3zucN+INueuJ/TS70VRUrW
	 lL0w7t8Akb56vv6Y7uQI1pNamPwiXa4V0Jdf1CpmljKgtf61pnzl+UOq412+/JJ8Bx
	 NhXhSITZorALMfJgzmKpBiVoesezRH4MZ2pFQbjyeQ6Be/VsPMRWaFA05rWYtWAyCH
	 IONr+S1s0/4V56gqF7k5c0d+7LvGaDzZEavnmtiVDX2CsHtFRf75RzoS3W3HBPTrNO
	 GAtCQRckfWwnHxWV+Lph59hTgP1Oxy5dZHe+4JCmaHEqB53d96S8JrOJDEbo4cpHmb
	 jwfXeUlFcZS3A==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C754B37804CE;
	Fri, 26 Jul 2024 13:50:36 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-07-25
Date: Fri, 26 Jul 2024 15:51:01 +0200
Message-Id: <20240726135101.45018-1-laura.nao@collabora.com>
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
status updates, as discussed in the last meeting held on 2024-07-25:

*USB/PCI devices kselftest*

- Upstream test to detect unprobed devices on discoverable buses: 
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dacf1d7a78bf8a131346c47bfba7fe1f3ff44beb 
- Test location changed 
  (https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-1-163b9cd7b3c1@collabora.com/), 
  updated KernelCI PRs accordingly: 
  https://github.com/kernelci/kernelci-core/pull/2577 and https://github.com/kernelci/kernelci-pipeline/pull/642
- Will need to figure out how to structure the files to ensure 
  scalability. A YAML schema would be useful too.

*Error log test*

- Proposing new kselftest to report device log errors: 
  https://lore.kernel.org/all/20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com/
- Now merged upstream

*Missing devices kselftest*

- Proposing new kselftest to report devices that go missing in the system: 
  https://lore.kernel.org/all/20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com/#r
- The test checks the number of devices present against a reference file, 
  generated by the program at a previous point on a known-good kernel, 
  and reports any missing device.
- Helps identifying missing kernel configs or broken driver features

*Suspend/resume in cpufreq kselftest*

- Enabling suspend/resume test within the cpufreq kselftest in KernelCI
- Sent v2 for patch adding RTC wakeup alarm in the cpufreq kselftest: 
  https://lore.kernel.org/lkml/20240715192634.19272-1-shreeya.patel@collabora.com/
- The test now uses rtcwake, as suggested by Rafael J. Wysocki in the 
  first review. There's no easy way to declare the dependency in the 
  kselftest itself.
- Patch got acked by the cpufreq kselftest author Viresh Kumar

*Boot time test*

- Sent first RFC:
  https://lore.kernel.org/all/20240725110622.96301-1-laura.nao@collabora.com/T/#ma568382acdc81af65c30fe3823a7be3e49f98108

*TAP conformance in kselftests*

- Ongoing discussion upstream on TAP headers: 
  https://lore.kernel.org/all/87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com
- Working to convert test modules used by kselftests into kunit. Cleanup 
  patches sent:
  https://lore.kernel.org/all/20240725110817.659099-1-usama.anjum@collabora.com 
  and https://lore.kernel.org/all/20240725121212.808206-1-usama.anjum@collabora.com

Please reply to this thread if you'd like to join the call or discuss 
any of the topics further. We look forward to collaborating with the 
community to improve upstream tests and expand coverage to more areas 
of interest within the kernel.

Best regards,

Laura Nao

