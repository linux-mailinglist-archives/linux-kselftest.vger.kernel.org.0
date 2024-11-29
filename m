Return-Path: <linux-kselftest+bounces-22617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298539DE690
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 13:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB462164692
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493F19D06D;
	Fri, 29 Nov 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R16UI2sO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72802155352;
	Fri, 29 Nov 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883981; cv=none; b=mLFVtvryLZLdfpuAE1ispVscP7c67BtwSDDvOcZ74jHt+L4ap7kYZh+Yc2VbmRBw9rpNMCExAjbncaIAacbC37bYHcd7w8jvPSz8d6Anq+HzmnUIU26/MZRdrMY+EqBRPeoUFhLYWF6HowAqt4HcGoZStzQn5LKigK5KEX3kqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883981; c=relaxed/simple;
	bh=Dr5bRSLTl3QMechp7cIYxzqt1uWUN7yHesMmav2qSbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cksAfItIgj4glFlIx4ht1c35t0YWm/xVr+E110YqFjD0UUWh48jewY36rtyA97XnNbi97pusVvN6yx6e/1axi1T+7wM8UtaueUDJfpdKGHsdTGCvlD2bhCml7XuO97SKFU148QcDwNlvk2Wv23tPT0WLzOJPRsFkB8s6E+9+TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R16UI2sO; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732883979; x=1764419979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mR0/WZBsSVJKyzUHx1nK1XmzVfPcIwiHMj7Qmp6UTCE=;
  b=R16UI2sOHOC/Mz44fAPN/iEmB7KOUl9o/zLQcEpWvrx1SH1KWSViNEIG
   mA298sflRcs3oUpmyFcG7FnFdZy6FAIywQ8EaYNnw4aABpuur8eJSuUyi
   nQg66O+LKc5ndtWbbe5SklLK9vToBUpxbQBoxH5WtTxZcSZhvxgQ1am51
   0=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="151746608"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 12:39:36 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:7366]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.84:2525] with esmtp (Farcaster)
 id 04dd6e55-c77a-4f11-99e2-29083b9202bd; Fri, 29 Nov 2024 12:39:34 +0000 (UTC)
X-Farcaster-Flow-ID: 04dd6e55-c77a-4f11-99e2-29083b9202bd
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 12:39:34 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 12:39:34 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 12:39:34 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTPS id 10084A0504;
	Fri, 29 Nov 2024 12:39:30 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH v2 0/2] KVM: guest_memfd: use write for population
Date: Fri, 29 Nov 2024 12:39:27 +0000
Message-ID: <20241129123929.64790-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

As discussed in the v1 [1], with guest_memfd moving from KVM to mm, it
is more practical to have a non-KVM-specific API to populate guest
memory in a generic way.  The series proposes using the write syscall
for this purpose instead of a KVM ioctl as in the v1.  The approach also
has an advantage that the guest_memfd handle can be sent to another
process that would be responsible for population.  I also included a
suggestion from Mike Day for excluding the code from compilation if AMD
SEV is configured.

There is a potential for refactoring of the kvm_gmem_populate to extract
common parts with the write.  I did not do that in this series yet to
keep it clear what the write would do and get feedback on whether
write's behaviour is sensible.

Nikita

[1]: https://lore.kernel.org/kvm/20241024095429.54052-1-kalyazin@amazon.com/T/

Nikita Kalyazin (2):
  KVM: guest_memfd: add generic population via write
  KVM: selftests: update guest_memfd write tests

 .../testing/selftests/kvm/guest_memfd_test.c  | 85 +++++++++++++++++--
 virt/kvm/guest_memfd.c                        | 79 +++++++++++++++++
 2 files changed, 158 insertions(+), 6 deletions(-)


base-commit: 1508bae37044ebffd7c7e09915f041936f338123
-- 
2.40.1


