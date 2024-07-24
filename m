Return-Path: <linux-kselftest+bounces-14159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0C93B4CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED1A1C239B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785115DBD8;
	Wed, 24 Jul 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="yKc/GNMT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m47-110.mailgun.net (m47-110.mailgun.net [69.72.47.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986C156997
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.47.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837991; cv=none; b=M/soic5mZkLh4fLAJ3PL8RTfwmHdeLpXxOqpueE5f+vIKnyRqdPU48cULGRzeMItMVRc1VIhYn93p9n67e1uPL8OlmsyWrxjId0eaudP1VS61ngDrKmDkGTObxMXYhitFZhvb0WO3/C78R/pJf+6DPdgDdhzWD2wPfmJWR/t4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837991; c=relaxed/simple;
	bh=d9fkiJRRsiIZ/Q8EB5xjEqYM0khlByQoZ9pZOz5LNKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QHU+DLIOkgl4c/gd+gy9D2/EXWlYdeK2ZtbInMN7gZltEsCnCYgzSXoqJEa/OREKy9HxdfDyuWjfkcMKSNxKSLRrMSAzO5TjdJeK+aQhnialuaMzEVUszfdok/tcRAKBow1OsopnmVSLKIynPrMOtyAWJrhCNFKa3+rBWAAw1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=yKc/GNMT; arc=none smtp.client-ip=69.72.47.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1721837989; x=1721845189;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=d9fkiJRRsiIZ/Q8EB5xjEqYM0khlByQoZ9pZOz5LNKQ=;
 b=yKc/GNMTodH8oDp4mo5I12/bVJx4fmLR/SaVZTqrVHVU/0iZ+8zIzy7uR3EOvUwGZ4y64QcVcwtHym3cJQiArxf1nyoiA+6EyZZ1HFRiUn0i7/Q0iBwJi3ou38Eqp2NUYFbz4jn8ONuBUZj4u2xCGmI9w0Ub2ngdfcDSZ277lnE=
X-Mailgun-Sending-Ip: 69.72.47.110
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 7f195ee39b8b with SMTP id 66a129a5630e231ced4a1d8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jul 2024 16:19:49 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-4c35368b-g75q.c.vimeo-core.internal [10.56.27.204])
	by smtp.vimeo.com (Postfix) with ESMTP id 226EB65C5B;
	Wed, 24 Jul 2024 16:19:49 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id CBC5AB4128D; Wed, 24 Jul 2024 12:19:48 -0400 (EDT)
From: David Finkel <davidf@vimeo.com>
To: Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Wed, 24 Jul 2024 12:19:40 -0400
Message-Id: <20240724161942.3448841-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch revision addresses a few comments from Longman and Johannes
here[1], and rebases onto master again.

(I still have issues with starting my UML instance to run the tests.
I'll see if I an figure out what's going on with that after I get some
other work done today)

[1]: https://lore.kernel.org/cgroups/20240723233149.3226636-1-davidf@vimeo.com/T/

Thanks again,

David Finkel
Senior Principal Software Engineer, Core Service
Vimeo Inc.



