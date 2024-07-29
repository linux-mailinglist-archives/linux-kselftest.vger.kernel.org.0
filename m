Return-Path: <linux-kselftest+bounces-14396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31715940051
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 23:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E5D1C220BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC718D4D0;
	Mon, 29 Jul 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b="ffqgKZRz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m35-116.mailgun.net (m35-116.mailgun.net [69.72.35.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771F18D4DF
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.35.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288185; cv=none; b=agSw15qMV+NRsKJYUMQZ+xET6b2ty5UvudShB+j0J9Y18+RBLtC0b2/RN8lgksTz3u/26eBWWRSxQ9cM8BOeI/MMIrUAcio36/BhwjWtvXXmFW0KtUyk8tINFyJP41GLN89lTO8M9bjkdQHbIXB0FsC/PBrPUfPfE1bJ7PRfWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288185; c=relaxed/simple;
	bh=54Ak1+K4R79/npDbs4UtUU9rG6vREN5KRCLxgY0YgX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8t/Pu/tKotMUftc1ane7IYDbfnoUdafyfdR3X2QlgdxghODgF7u2a8Xnfd/xdUFujIA6DMzX87B6RCwdx7szrRrugLn61UR5gTdiGMfqpHfzk6NHOjTHAOhQNi8xUSfz7cYeuJgLZGnX4wuPk3R+IuNUUmx+D8Z10AiTIPM0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=pass smtp.mailfrom=relay.vimeo.com; dkim=pass (1024-bit key) header.d=relay.vimeo.com header.i=@relay.vimeo.com header.b=ffqgKZRz; arc=none smtp.client-ip=69.72.35.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relay.vimeo.com
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=relay.vimeo.com; q=dns/txt; s=mailo; t=1722288182; x=1722295382;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=a7Ljw3AXkZDzOFLBKFNTY35O0ifJdJ40YsuUE1AtXfE=;
 b=ffqgKZRzwWe/rjwPkeU0auwsgZE8n2OXANRPo2taxUJDP0teyQ4lDzl9KAoWMQDz6Vi3AkQYEEsFq7Zi8tFTJ4tx4GDVV7Kc3rRIxBKnd4mM1Wi1rHVoow4GSeaC/aqKf/TWK8teWRy6j+WIyIieLSgxGzM/u9FBtrxxp7rjo6c=
X-Mailgun-Sending-Ip: 69.72.35.116
X-Mailgun-Sid: WyI5MTQwZiIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI5ZDJhMWMiXQ==
Received: from smtp.vimeo.com (215.71.185.35.bc.googleusercontent.com [35.185.71.215])
 by 1ba2f445e949 with SMTP id 66a80836c423567e51c57d52 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jul 2024 21:23:02 GMT
Sender: davidf=vimeo.com@relay.vimeo.com
Received: from nutau (gke-sre-us-east1-main-c45160e0-ow8k.c.vimeo-core.internal [10.56.27.211])
	by smtp.vimeo.com (Postfix) with ESMTP id 120CA64FC7;
	Mon, 29 Jul 2024 21:23:02 +0000 (UTC)
Received: by nutau (Postfix, from userid 1001)
	id 5BB66B409D2; Mon, 29 Jul 2024 10:38:00 -0400 (EDT)
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
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v6] mm, memcg: cg2 memory{.swap,}.peak write handlers
Date: Mon, 29 Jul 2024 10:37:41 -0400
Message-Id: <20240729143743.34236-1-davidf@vimeo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an updated patchset rebasing onto -torvalds master (post
6.11-rc1), and addressing comments from Michal and Tejun.

As requested by Tejun and Johannes, I've removed the explicit check for
the string "reset", so it now allows any non-empty string. (Empty
strings get filtered before our write handler executes)

I've also made several of the field reads and writes atomic with
{READ,WRITE}_ONCE, and adjusted more of the types to be unsigned.

Documentation/admin-guide/cgroup-v2.rst          |  22 ++--
include/linux/cgroup-defs.h                      |   5 +
include/linux/cgroup.h                           |   3 +
include/linux/memcontrol.h                       |   5 +
include/linux/page_counter.h                     |  11 +-
kernel/cgroup/cgroup-internal.h                  |   2 +
kernel/cgroup/cgroup.c                           |   7 +
mm/memcontrol.c                                  | 116 +++++++++++++++--
mm/page_counter.c                                |  30 +++--
tools/testing/selftests/cgroup/cgroup_util.c     |  22 ++++
tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
tools/testing/selftests/cgroup/test_memcontrol.c | 229 +++++++++++++++++++++++++++++++--
12 files changed, 419 insertions(+), 35 deletions(-)

[1]: https://lore.kernel.org/cgroups/20240724161942.3448841-3-davidf@vimeo.com/T/




