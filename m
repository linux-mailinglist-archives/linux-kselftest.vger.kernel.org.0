Return-Path: <linux-kselftest+bounces-47953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D8CDD6F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196C03016DC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D972BE629;
	Thu, 25 Dec 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ5Exr/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153A22A4D8
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Dec 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647930; cv=none; b=UApdN44eSjERLHpWe5/9Tqo3SLffXzkoID6WJQIlL0J6acmPpwa0bysbCLM8S4Sl1y/crCKTxVj24XJ2yeZJzYvPMGLaw6WdXlXddLaGEvBRDRiOKnN96nl/mxRLOKtuRZdK9Ig5+Y9gb1AFXJy0ylc/ULa6OjrdT+Y6rRo0usI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647930; c=relaxed/simple;
	bh=0N4eKLumzRuYEhx+M3A6Mpr55XrJDzrPRihNBFWtngQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwcNYYQVRzSZRtrl2xf6rD7OLZv/FtPqvKVBlZdVGPk+h9fXs1g6p2qDU2nXRfQzt2zVcJTUhLkfQCWxuH1KGl6tGEC7h6cTr0aIhWuHtt0U90cp14wZvwA4VtpzsrXtmS7BdJ6qIVqH1cPKLgK9XbrQnYhW9srWYTYcSFTbojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJ5Exr/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fK3dMa2mWaPDRsadQa9zuivMiY3mwPtVm9qCGSqHwdI=;
	b=VJ5Exr/te9igHBpopfVVdA1xT4oZCtAQdQ3x1qYsqYMfJmBdS/sha3VXmuf4MXbzXBu1sw
	6552w71rHK5hFrA3GJIUZpCn8s6a0az0ZRTroa+qqyvH5OLFTcJntgL8k4DjoPOpXfow6d
	zgtOd6Q90nWG97BxptLLsdhJj3jT+xM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-Y0E4xYXgOEaFfOgrQEoqeQ-1; Thu,
 25 Dec 2025 02:32:04 -0500
X-MC-Unique: Y0E4xYXgOEaFfOgrQEoqeQ-1
X-Mimecast-MFC-AGG-ID: Y0E4xYXgOEaFfOgrQEoqeQ_1766647923
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB06218011DF;
	Thu, 25 Dec 2025 07:32:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0713019560AB;
	Thu, 25 Dec 2025 07:31:58 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.20 PATCH 0/4] cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict
Date: Thu, 25 Dec 2025 02:30:52 -0500
Message-ID: <20251225073056.30789-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series is inspired by the cpuset patch sent by Sun Shaojie [1].
The idea is to avoid invalidating sibling partitions when there is a
cpuset.cpus conflict. However this patch series does it in a slightly
different way to make its behavior more consistent with other cpuset
properties.

The first 3 patches are just some cleanup and minor bug fixes on
issues found during the investigation process. The last one is
the major patch that changes the way cpuset.cpus is being handled
during the partition creation process. Instead of invalidating sibling
partitions when there is a conflict, it will strip out the conflicting
exclusive CPUs and assign the remaining non-conflicting exclusive
CPUs to the new partition unless there is no more CPU left which will
fail the partition creation process. It is similar to the idea that
cpuset.cpus.effective may only contain a subset of CPUs specified in
cpuset.cpus. So cpuset.cpus.exclusive.effective may contain only a
subset of cpuset.cpus when a partition is created without setting
cpuset.cpus.exclusive.

Even setting cpuset.cpus.exclusive instead of cpuset.cpus may not
guarantee all the requested CPUs can be granted if parent doesn't have
access to some of those exclusive CPUs. The difference is that conflicts
from siblings is not possible with cpuset.cpus.exclusive as long as it
can be set successfully without failure.

[1] https://lore.kernel.org/lkml/20251117015708.977585-1-sunshaojie@kylinos.cn/

Waiman Long (4):
  cgroup/cpuset: Streamline rm_siblings_excl_cpus()
  cgroup/cpuset: Consistently compute effective_xcpus in
    update_cpumasks_hier()
  cgroup/cpuset: Don't fail cpuset.cpus change in v2
  cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus
    conflict

 kernel/cgroup/cpuset-internal.h               |   3 +
 kernel/cgroup/cpuset-v1.c                     |  19 +++
 kernel/cgroup/cpuset.c                        | 135 +++++++-----------
 .../selftests/cgroup/test_cpuset_prs.sh       |  26 +++-
 4 files changed, 93 insertions(+), 90 deletions(-)

-- 
2.52.0


