Return-Path: <linux-kselftest+bounces-15080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDA94D4A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37114280F6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DE1990C4;
	Fri,  9 Aug 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="Su4Kf1Ya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A51990AD;
	Fri,  9 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220735; cv=pass; b=jaBhl/LQTNN2so+qEYhQlzqoGEQ2ybgBoG48hHchzvB2sj1MYe5dwHiv10UMGWlnM7VJAnNPThKPUTo5gi9T4Gbkkna/BI9yexghDh+Olb7GmABB2RA4XPMgaqJlG0ymjaHQKQaaioJIHc6nUR9JfuAqgt+Bmh/s9LFb7JnC710=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220735; c=relaxed/simple;
	bh=uQCqtJkUdQ1jKlpa4vxcmvCmXb2EPakE0nbZcoRVk+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4YB7arMF6pgBROlf19Mtb8Li1VvPsavDopg8cbJCYUG2KpKFS1hKrNizzPA7mL/2wzQTyLNHHGAWxPWq71Az0n8+vCYSS7PtHsVPBq02UcPAa73cdMJZO8XYM6ZqHiFUm/60R49G9xF8xHwi3m3bXHhi0zO7Wave15LihXitFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=Su4Kf1Ya; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723220729; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EIDtJXUCDbX29JPomatD90bSCrNxdIVkdBaPP9/cD2MWkRu3d4NGZnYS6W0wvsEN1uqLGtDF527Pkl+4hygRaL4aa3R/R86vdRRnj+0rxsAggemV/PD607eKps4NR38m/lbRPkWeAMikfdVNNllRcTJxEEWkiYBf0US5YB+7otw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723220729; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ytJAQtlx2zxWIOsp5xVT7X9vrgTIf3+4EEF+s5oG3xM=; 
	b=U1PdTVstt+MKWipGBfNYwnrvyZgUqG/MO8pf3poECfPq9D63lCA5mrqis2aZUZsuvu2AOpP+7qsen6qDyjLC/jOeFphoPWjpexp4EGoVvZb7XLbk/EhjUhAiy/20JtWu1gESMiVuX86F2SBqOWjxbw3qQheEiDvbx0Uq12YgTYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723220729;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ytJAQtlx2zxWIOsp5xVT7X9vrgTIf3+4EEF+s5oG3xM=;
	b=Su4Kf1YacWydOybbEwwCwA1x20BrALC0eA/s8/dgu/k0TudhbKxb+ph0x4GTd9OT
	Q1+IL88aPMmpnGRCLkX4RfeDbAVkUhQ0rt/1+PRmUdXw4F32NlkYhbU7n585kPlW7fc
	CcpPEoSwCIXd/ibrUbFDnEPlvpDYhJ6MBFP3VFLE=
Received: by mx.zohomail.com with SMTPS id 1723220728607163.70555237743986;
	Fri, 9 Aug 2024 09:25:28 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: kernelci@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Testing Quality Call notes - 2024-08-08
Date: Fri,  9 Aug 2024 18:25:57 +0200
Message-Id: <20240809162557.32300-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

KernelCI is hosting a bi-weekly call on Thursday to discuss improvements
to existing upstream tests, the development of new tests to increase 
kernel testing coverage, and the enablement of these tests in KernelCI. 

Below is a list of the tests the community has been working on and their 
latest status updates, as discussed in the last meeting held on 
2024-08-08:

*KTAP performance counters*

- Upcoming presentation @LPC2024 by Tim Bird on adding benchmark results 
  to KTAP: https://lpc.events/event/18/contributions/1791/
- Proposing new system to handle benchmark data, composed of 3 parts:
  adding syntax to KTAP to support benchmark values, using a set of
  external criteria for interpreting benchmark results, an automated tool
  to determine and set the reference values used in these criteria.
- One related topic for discussion is where to store the reference files
  and the test configuration, including all details that might impact the
  results.

*Missing devices kselftest*

- Proposing new kselftest to report devices that go missing in the system:
  https://lore.kernel.org/all/20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com/#r
- Received feedback on the usability of the test and main unknowns about
  management of reference files in tests

*Boot time test*

- RFC:
  https://lore.kernel.org/all/20240725110622.96301-1-laura.nao@collabora.com/T/#ma568382acdc81af65c30fe3823a7be3e49f98108
- Got feedback on the potential use of scripts from pm-graph. The
  bootgraph.py script could be adapted for the test with some
  modifications, such as adding support for machine-readable output and
  different ftrace configurations.

*Suspend/resume in cpufreq kselftest*

- Sent v2 for patch adding RTC wakeup alarm in the cpufreq kselftest:
  https://lore.kernel.org/lkml/20240715192634.19272-1-shreeya.patel@collabora.com/
- Looking into using the sleepgraph.py script from pm-graph to calculate
  suspend/hibernation and resume time:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/power/pm-graph/sleepgraph.py?h=v6.11-rc1
- Would require additional configs to be enabled in an automated
  environment

*TAP conformance in kselftests and other fixes*

- Some dead selftests were removed:
  https://lore.kernel.org/all/20240725110817.659099-1-usama.anjum@collabora.com
  and
  https://lore.kernel.org/all/20240725121212.808206-1-usama.anjum@collabora.com
- Bitmap test module conversion to KUnit was not accepted:
  https://lore.kernel.org/lkml/49108735-c776-4b6f-8264-62a827dd7b26@collabora.com/T/
- Fixing error when kvm suite is built for unsupported architecure:
  https://lore.kernel.org/kvm/c2aaa06e-e86d-4af9-bce4-6067e53cdf39@collabora.com/T/

Please reply to this thread if you'd like to join the call or discuss any
of the topics further. We look forward to collaborating with the community
to improve upstream tests and expand coverage to more areas of interest
within the kernel.

Best regards,

Laura Nao


