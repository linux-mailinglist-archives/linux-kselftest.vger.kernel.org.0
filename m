Return-Path: <linux-kselftest+bounces-48078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFACEF124
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8093A301354D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAD2D3EC1;
	Fri,  2 Jan 2026 17:30:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7572D23A8;
	Fri,  2 Jan 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375004; cv=none; b=nzzALxiQYzD3NN0Xk3YLLARGswMxr3dWant2LkOaq3yxhgFNqhPUnnvjOpzddEzqed0AyEw+Xe+CNNonTVg+P6eO+NXUtBrfr2MRpWwjR0jjZCWbz8gl2se8PN6w6WYYCg08u7OqowKfFGyGJeDbojUp36J+tSROx3kJwzWb9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375004; c=relaxed/simple;
	bh=jgMiko//y3IpHXOOjq4RojnnA6udDWIoPjidmOJaOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM/ycvv3h+aCw08MCErkmVTr7LvIHhBacbAk3VH7sx3XPbqPmwDD9Tj9fXCdYnLEeXa+epjQaG74vecpnKKMX9GXM2RTGLvxsRPNft4AW23VMI5oNoWaR4a9F+WiQkHLWrmnqWMinm9Y/mHwVoQ1jtk4nL0hD8gb+F1DGOGKZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D880D1A07D6;
	Fri,  2 Jan 2026 17:29:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id AABDB20025;
	Fri,  2 Jan 2026 17:29:54 +0000 (UTC)
Date: Fri, 2 Jan 2026 12:30:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, rcu@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yao Kai <yaokai34@huawei.com>, Tengda Wu
 <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <20260102123009.453dfb90@gandalf.local.home>
In-Reply-To: <20260102122807.7025fc87@gandalf.local.home>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
	<20260101163417.1065705-2-joelagnelf@nvidia.com>
	<20260102122807.7025fc87@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cfxbdg7u7wmps8defuxb55ihktm8nrq8
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AABDB20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SQRpZLc4ZHQh/m570lxEzf+14yDB7Zc4=
X-HE-Tag: 1767374994-254322
X-HE-Meta: U2FsdGVkX1/mTArce0L8moBPZmQnjzUz6UXdvOxfQw3fSg4tPUzSW3F2yORhjve18+aChqfRzRUmBZrWuNtGV0L7PtLRRoemnQqiRjb4nxVFLwkUFC8Xvdwu0qHGbXyogQKN8nkYuLGbPde3/lo1Gh8rMdszc7qNAeuZgW1xmvkQVR9v8UpnwNTg0vLYHuPmWztkLoo1fMMgNyzorgDKBwxdV97FIe8HfdsPgONJYahfcGkBgZTNvWLwdyx4F/KSErS8QSijIIYZlgeyZ7LWnQM+W8BmnYiFz9JDfsauILSjlkH0v4N8Tc2dotwFftVv2e3iX+Mwc2u/3UWBdjHoku0BOpAw8UbYi+cIbLQiLSy1nv2DipFo5X1NAobRrryw

On Fri, 2 Jan 2026 12:28:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Stacktrace should have recursion protection too.
> 
> Can you try this patch to see if it would have fixed the problem too?

As I believe the recursion protection should be in the tracing
infrastructure more than in RCU. As RCU is used as an active participant in
the kernel whereas tracing is supposed to be only an observer.

If tracing is the culprit, it should be the one that is fixed.

Thanks,

-- Steve

