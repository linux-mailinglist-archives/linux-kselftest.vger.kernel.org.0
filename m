Return-Path: <linux-kselftest+bounces-28898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E0A5F09E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F191173396
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6C265CB2;
	Thu, 13 Mar 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lumSFRBx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C3261583;
	Thu, 13 Mar 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861354; cv=none; b=TzuWT+rFhfHKUxS2zfhjRAa+oK69KpwHVAmtXeBR91YVyE/I8wD4O6i6qa3eeReVK7w61AD13EC8Xqwp9aMt+tIeF0tbZRWng4AoXil1ORX3Uvb+RfK1TAFHNGg90aBZlqGnQCGgWFGIsspDkjn6gw3rZcE/zkk2VEuBaqZYv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861354; c=relaxed/simple;
	bh=dpw9fVHupVdv7LX0zuifR7cy5kgztBnsRocr7lox/WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfhDdHRAJq5kdBA2mojJkOHvi1ac/SChQZCWfTSaGHvE7rInp1ks2pS5jGpehykthtXHkETQk5XwwyuMN5EMuhap3Q0cnp1QjxrNAyYnphVuxqgBuahVNK+CjXstRR4+1vAuLKJ7q4F0e2IzM3wuM8GXHQdR6iwjs7XbLJhx8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lumSFRBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89817C4CEF1;
	Thu, 13 Mar 2025 10:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861353;
	bh=dpw9fVHupVdv7LX0zuifR7cy5kgztBnsRocr7lox/WI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lumSFRBxiOhLgpjZq9Pz7lvTatX2PelR792XbAHvJZ7W9GORd5pqkTsc7lAiQ0swD
	 kenaoLD3DSJezH71UY8tzMYuU4ortVRFgUq9A6B/UccRr//QBvXf5XNmPti7RS7Aoy
	 yRKnjSQlV2K8Km02TWNys7GDDOkxGUrKt4M6QdTlXbroomqsIPpWfSq8OT9J5eaMpc
	 sQoLeGwQMcIkwYO2tqqvcHmAGuDb76Jc3An6hlbwRILHCZlWmvJt2ljHsPUWM904MO
	 beZWXm6o4m85VDRu0V46dKewc7tgPkOBWbLb+AmdbKyTG9EW/wPd8vHlsOkuQBNX/H
	 EoYFk0GyxwkBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:55 +0100
Subject: [PATCH net-next 06/12] mptcp: pm: define struct mptcp_pm_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-6-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FGNzRWS1hbYhpaLxqjQs0t93G2xcjg3oMS6W4kp09/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGb2opmR2ZGBa80BlplBbjzpCYfk3ZInqCKp
 FdHCaA2sTuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 c803EADH/C8cKWC1/0VICk4wqzBvM1r1HE7GScVbRqA2H+AINkhd+UR8SrJx359fBj53eEM4K+V
 dvvliLltIuPCTZEa+Ca4kJuFwOCJM0IoC6qSKG9TK7pGVooZF4aBlOVwsEZ5S4ViErj75SEJQwY
 eJc/NVARB3+hFh7qbeN7wnUzQvkWQQIJDyoUq9lh4c1xSs9waF8jTo2eubaVy0GSbQs/M10O1EH
 adp4tfPFQ1rnb/MQ5NqN97LW3dijX84ayfnUnjgIYnBgJ1vkxGy0zKzbYP0IZ0U4gyaDTe9Qtas
 v4bQ0HFKmirkhCqJD/Jn1IXFavjI4hBBWUzy35nDKDFhGq3Qn2KR8PmVPeD4Gh6m1G/UktW9nco
 I0Elc2jEe4s0bHTR1MT2ULOaEKGnq/UIS0B1GD+9kUAIxS2JtPDtnri4EIh3K+GRYcFJh/rvFTi
 RVMi4ThkVqZU4f9IbxBMoGb1nOwt2+Z/9RcsWWSzJGfLXFRkTxxEi8WEvQ9IRUmlveFXb98nPzU
 tIIABp3ceD/znLw98084/mWv9WIgUhypufsEnCcijiuK2FiA3L5sDAhllrCpwMI1UlwdUvVKNaB
 Z0NaD6u13AlTEthWp2m6EDNLxIemABQpga8NMaYR/KB87MWOeC5o6JTjq18qYJB/44o8AJC3383
 /n1Berk+8VSIqLA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to allow users to develop their own BPF-based path manager,
this patch defines a struct ops "mptcp_pm_ops" for an MPTCP path
manager, which contains a set of interfaces. Currently only init()
and release() interfaces are included, subsequent patches will add
others step by step.

Add a set of functions to register, unregister, find and validate a
given path manager struct ops.

"list" is used to add this path manager to mptcp_pm_list list when
it is registered. "name" is used to identify this path manager.
mptcp_pm_find() uses "name" to find a path manager on the list.

mptcp_pm_unregister is not used in this set, but will be invoked in
.unreg of struct bpf_struct_ops. mptcp_pm_validate() will be invoked
in .validate of struct bpf_struct_ops. That's why they are exported.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h  | 12 ++++++++++++
 net/mptcp/pm.c       | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 +++++
 3 files changed, 67 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2c85ca92bb1c39989ae08a74ff4ef9b42099e60d..645d15695e3f5ec4b945bb543630f3dcc54453f2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -121,6 +122,17 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+#define MPTCP_PM_NAME_MAX	16
+
+struct mptcp_pm_ops {
+	char			name[MPTCP_PM_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+} ____cacheline_aligned_in_smp;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 85ee999729a1c37f42bb21490d7f68d186e6734f..f4948a2cf9be078043bd237f56a57c27804ef4db 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -5,6 +5,8 @@
  */
 #define pr_fmt(fmt) "MPTCP: " fmt
 
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include "protocol.h"
 #include "mib.h"
 
@@ -18,6 +20,9 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
 /* path manager helpers */
 
 /* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
@@ -1015,3 +1020,48 @@ void __init mptcp_pm_init(void)
 	mptcp_pm_kernel_register();
 	mptcp_pm_nl_init();
 }
+
+/* Must be called with rcu read lock held */
+struct mptcp_pm_ops *mptcp_pm_find(const char *name)
+{
+	struct mptcp_pm_ops *pm_ops;
+
+	list_for_each_entry_rcu(pm_ops, &mptcp_pm_list, list) {
+		if (!strcmp(pm_ops->name, name))
+			return pm_ops;
+	}
+
+	return NULL;
+}
+
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
+{
+	return 0;
+}
+
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
+{
+	int ret;
+
+	ret = mptcp_pm_validate(pm_ops);
+	if (ret)
+		return ret;
+
+	spin_lock(&mptcp_pm_list_lock);
+	if (mptcp_pm_find(pm_ops->name)) {
+		spin_unlock(&mptcp_pm_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&pm_ops->list, &mptcp_pm_list);
+	spin_unlock(&mptcp_pm_list_lock);
+
+	pr_debug("%s registered\n", pm_ops->name);
+	return 0;
+}
+
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	list_del_rcu(&pm_ops->list);
+	spin_unlock(&mptcp_pm_list_lock);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 15e2a03025ecb4cae44ccb700fcbbdd06ab806d1..ac8a178426e4ef495d7c5b5b9bd4c8b8835d71e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops);
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,

-- 
2.48.1


