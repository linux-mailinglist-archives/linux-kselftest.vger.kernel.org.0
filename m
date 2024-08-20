Return-Path: <linux-kselftest+bounces-15787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C70958EE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D9C1C20F8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F415C152;
	Tue, 20 Aug 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We1KVI2n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4B15C13E
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183774; cv=none; b=NrR7+GMJ2Yh2qkvndVUqIC500mqPPwxHXw9z1khkpZMjwE+jEb6sGxifqrzs7kw9/pVF0ObV5/U9aSc9YHDwMrMZ7tsHjbGza4oLP/5CcOopmBFDsyeTzByPxRN0ww35TTkxpCQtpq4SZIgYOlyn7zXn6l1ckyu7ynlJF90TkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183774; c=relaxed/simple;
	bh=csrxiVvLG9IgDFpaXoNeGXm5JX+nOI0jfkSkiKKTqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWeVdMgTHysqGqlb5PsYmNJVTQQwp/tmYUKRfcM0CMZOe5XeQVSkQkr8epVNuHQMsA1Cx6/JST4lv8SpSSTIKTa02Us+LyzFcanJetvQgAOgX1cjkxMNQA5uLiU0FLlzKy/rnqh/JstmahO49iIt84ovvtnFT81Tj+BPV4hYheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=We1KVI2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724183770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mRWet40YKp36IkKgF8VcXdQuutTUysbDPs0ilrpzxqI=;
	b=We1KVI2naKxeH76jmCcG6MUWV6RiNtY69XTMZDS0lPDFuXGneN6I5pnYiHtDQQ+dHKaOQG
	004QHwKhofyoHtKnml6XI/pQptefbOhJBwtHYGjKN8YKSC2JjmEv/4Qn0U4nXvhuxn1b05
	vXKwCV1PK34SuvW4bFatYtPfDjxklrc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-73GB9XyDMdChp5zKiQlbGg-1; Tue,
 20 Aug 2024 15:56:07 -0400
X-MC-Unique: 73GB9XyDMdChp5zKiQlbGg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D24551955D44;
	Tue, 20 Aug 2024 19:56:04 +0000 (UTC)
Received: from llong.com (unknown [10.2.17.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22B8E3001FF1;
	Tue, 20 Aug 2024 19:56:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated CPUs
Date: Tue, 20 Aug 2024 15:55:34 -0400
Message-ID: <20240820195536.202066-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The current cpuset code and test_cpuset_prs.sh test have not fully
account for the possibility of pre-isolated CPUs added by the "isolcpus"
boot command line parameter. This patch series modifies them to do the
right thing whether or not "isolcpus" is present or not.

The updated test_cpuset_prs.sh was run successfully with or without the
"isolcpus" option.

Waiman Long (2):
  cgroup/cpuset: Account for boot time isolated CPUs
  selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs

 kernel/cgroup/cpuset.c                        | 23 +++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 44 ++++++++++++++-----
 2 files changed, 51 insertions(+), 16 deletions(-)

-- 
2.43.5


