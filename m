Return-Path: <linux-kselftest+bounces-11874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649CA9077EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B041C22554
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1312FB0B;
	Thu, 13 Jun 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGawiitr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40805A23;
	Thu, 13 Jun 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295042; cv=none; b=j5U2JMmTLh8Lr7f4rkWZu9lgTpwHDhfS1AO2kx0fpEC/sX0z5WCITcCj0wFUT9iW5TtEabRcTTBqCY10M/YxUwkbjJ2f5vBqQubyS1S8ZbuiUwZcickKZXoj8NF2ZZRhyoOgyBPPPITrIzc2ZU4csJo8p482n5KKARxPKWb3scM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295042; c=relaxed/simple;
	bh=hg3ZFX1ZdZkhCBl0cycfGdCXZQ4o5gfmME3tRBWguwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij5dOvtD1DwK0BK5c78hukgtG3mK+EQZC2GfrdF842A51a9YMH5m7qxQUX/6HbUPTCHuLXXCEAyJ9RWnvC/L9Sk7IfSkrOyS11bsJ0pCFpfxl4usfuuawXaXTknqJ3JP0iIyTlYrKivwgZuDo49HtFiw0MLk2QkRnxIT9QgK+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGawiitr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BBC2BBFC;
	Thu, 13 Jun 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718295041;
	bh=hg3ZFX1ZdZkhCBl0cycfGdCXZQ4o5gfmME3tRBWguwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGawiitrSTl4D4rivmIxK2Oi0t9rHJYvZejrrvqg/cKKXIBd3EO7svZMgXA2PUpzl
	 UP/u0Z0iqXD/ywWs2CrkUjY7ovZAvm0ZJpzDd5aX5Oms9EaHiZLletbxjOsA+4lYbr
	 fwz5YexiuheI88zZR9yQwv0SBnNQipiVQmNTypdNkyt2eVPqRKku+QfV28PKZSAg3m
	 x7MByJYAMGn7iezYywecmd+wUyjXeIbkHtv0YJ/vgYtFPzW2ILqzh4naVVwp2wB/5a
	 Id7suEadAY11JqGsf6bfPQDdlIS53V0a+Esj+8wHpIFZewp/q+0I5/Vlnd+3iH5prr
	 0TJnH/oMecg/g==
Date: Thu, 13 Jun 2024 10:10:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
 <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
 <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>

On Thu, Jun 13, 2024 at 09:01:47AM -0700, Paul E. McKenney wrote:
> 
> Is there a way to avoid this issue by making this be a statement parameter
> to a macro?

Something like this? It appears to work for the intended use, at least.

---
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 3dc1e58865f77..cdd2e5c0d5cdb 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -204,6 +204,30 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+
+static inline void __list_cut_start(struct list_head *list,
+				    struct list_head *head,
+				    struct list_head *entry)
+{
+	list->next = entry;
+	list->prev = head->prev;
+	__list_del(entry->prev, head);
+}
+
+static inline void __list_cut_end(struct list_head *list,
+				  struct list_head *entry)
+{
+	entry->prev = list;
+	list->prev->next = list;
+}
+
+#define list_cut_rcu(list, head, entry, sync)		\
+	do {						\
+		__list_cut_start(list, head, entry);	\
+		sync;					\
+		__list_cut_end(list, entry); 		\
+	} while (0)
+
 /**
  * __list_splice_init_rcu - join an RCU-protected list into an existing list.
  * @list:	the RCU-protected list to splice
--

