Return-Path: <linux-kselftest+bounces-48624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9830BD0B4A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F438300DB21
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B7364043;
	Fri,  9 Jan 2026 16:38:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20680363C52;
	Fri,  9 Jan 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976712; cv=none; b=tvQri8J1QYESujJYksvCLpncmhwbuFPIcOPpjsAvpLale7JTAX8DdvGyCUdJJk3316t3kvGm/v84LWmII9Q+hyU3k4HX4v7bH3rqQfp/A/qVP8ZQKGbymRyP112L2eubBgbgt7d4o+SmSc5bjMWY1b/2Q2Shop91L3RWox+Njjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976712; c=relaxed/simple;
	bh=dmKFEIvTIANp3SO/CLS13O5Zvtx8lCjW/ri81Wr0ex4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvdSdiKPJNrRWdnAFbswqzezQLGRrnVnp7FCDaYQ54MZKSPfvZHIp7eDkRLfhRyWGtpnEWRpth1/Bj3q557itvLW9fzrJGu3cU2xta0Oe3q4r1WVBa5AEmOv2dgh/PwW+guFo5F4lsDjkc9tL6nBUuO768ns6zheLuqyofeItUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 20B28D0367;
	Fri,  9 Jan 2026 16:38:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 721892E;
	Fri,  9 Jan 2026 16:38:19 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:38:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yao Kai <yaokai34@huawei.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, <rcu@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Shuah Khan
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Tengda Wu <wutengda2@huawei.com>,
 <liuyongqiang13@huawei.com>, <yujiacheng3@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <20260109113850.2133c5ff@gandalf.local.home>
In-Reply-To: <20260105121611.470294d3@gandalf.local.home>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
	<20260101163417.1065705-2-joelagnelf@nvidia.com>
	<20260102122807.7025fc87@gandalf.local.home>
	<20260102123009.453dfb90@gandalf.local.home>
	<68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
	<252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
	<34ff0ff6-217e-4574-a3b1-af74b2f40937@huawei.com>
	<20260105121611.470294d3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7r5dcagmgp9pjb66ukftmfitb6wi5zya
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 721892E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Glua9WT8dBeoRtPcuIs5T4MXmiGY1yII=
X-HE-Tag: 1767976699-987882
X-HE-Meta: U2FsdGVkX18fspqHkNQr67C4mhoZ9mX3Mj1qszS6VqDDUIcbrLPTTTNH3YwPb5dUNnv4rWpvx8Yr+E2MdrkZclDss5GuE/Uus3x2kRn4W5swl4X+Yn9H0DOL1zPQ9UreTRVTP5v2QFuv3M83d6pRSItxEl8YwMasKMpRQbIaCz3hO4xww96mBWrDg8iynWhHdoIRrLXMbY9rQSGoc8jbcpvjldmImAx1IHkmcoPFwOG7adUaI8h4UyL4Houmgqjyq0NDn2WQ3gVqNFCsoQqc9BbZKaUuQzi5hvCIPYNqt6xTrA0rOoXYOVyzH9uV7Vptpelsu3C2l3aRtn5kt+lJe0H6vUeIhWApycbhb9ItRIcUWlxcaZgVxcSqazgkdzcbh8IGcWXRpVZ8h40H7DOignbGkIx5ny/0II7rc4XZnTI=

On Mon, 5 Jan 2026 12:16:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 4 Jan 2026 11:20:07 +0800
> Yao Kai <yaokai34@huawei.com> wrote:
> 
> > Yes, I tested Steve's patch. It fixes the issue too.
> > 
> > Tested-by: Yao Kai <yaokai34@huawei.com>  
> 
> Thanks for testing. I'll send out a formal patch.
> 
> And yes, I agree we should do both.

FYI, the tracing recursion protection made it to mainline:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f1ef0dfcb5b7f4a91a9b0e0ba533efd9f7e2cdb

-- Steve

