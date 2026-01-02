Return-Path: <linux-kselftest+bounces-48080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BECEF3E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ECE830115FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605E2D239A;
	Fri,  2 Jan 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHKnkaxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5627F005;
	Fri,  2 Jan 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767383471; cv=none; b=LX9cq6f6dC68xMlluS4PcEQ76gQrRLFzs3h7fK1Utu4Kd9mLGt4yroo7Mj1LyhWZ7d01liTw+uvLEHz5Nwl8uUrH9tLGrsUC/D72O1sP1gvyAf4cA7aiAh9n1k5r+ryhChWurfTl8ujxxLZJHX/xT8DxU1Fb/jd180VszrhUw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767383471; c=relaxed/simple;
	bh=QJVR02bdJUsXRAmRc7VJw5ONf6Mkf57nlBofuG6MZyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl8bWS20RhT/UCo1HnZS/BpD5ReEnAX0YdIAMf7Jb3+5Wf+BtBKRQ8t1Itwh6rHIHuYbBJjyvzwpFUP25Y1DNfQFgZt9yl1i9PqyTcRoKqkT4fuqUAXCwuE1+Tg7iT9sXs3ozy938kVZvkg4rX5gaHOaAphcYiadV2Iwu9tYr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHKnkaxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1254C116B1;
	Fri,  2 Jan 2026 19:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767383470;
	bh=QJVR02bdJUsXRAmRc7VJw5ONf6Mkf57nlBofuG6MZyA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jHKnkaxh4j6I64PeBYIGMwyf11Iio6rDPR06BoGTqVMvV7oc7yGMbu+Bs69GcuaKZ
	 pwecQ5WjW651sEtx2YUeYW5G+vAEtEPm2ZxXksr2lrSR5qAVzK8K9cX09O6MyBuUfJ
	 ZvTcLG3fVED8yLjC7mYmJtjTxL8Vh64Wdx0sw3zh8YujinLamg8g9wDL9x6Df+j5I9
	 cQApG1lttVO/n/dx7fA1F7GnmZvn2cLeHAZZpHjJdPzBSnchje+WNV760P49vJB4Rc
	 lTwjSkjy8hCZB+3P9PoOGwPtEMBOa+z6wbmHpaJ8+OBxxvXu5uXLifA6e02lcbtsiw
	 cxkRlsYT+O5Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3EFCBCE0D1C; Fri,  2 Jan 2026 11:51:10 -0800 (PST)
Date: Fri, 2 Jan 2026 11:51:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yao Kai <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-2-joelagnelf@nvidia.com>
 <20260102122807.7025fc87@gandalf.local.home>
 <20260102123009.453dfb90@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102123009.453dfb90@gandalf.local.home>

On Fri, Jan 02, 2026 at 12:30:09PM -0500, Steven Rostedt wrote:
> On Fri, 2 Jan 2026 12:28:07 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Stacktrace should have recursion protection too.
> > 
> > Can you try this patch to see if it would have fixed the problem too?
> 
> As I believe the recursion protection should be in the tracing
> infrastructure more than in RCU. As RCU is used as an active participant in
> the kernel whereas tracing is supposed to be only an observer.
> 
> If tracing is the culprit, it should be the one that is fixed.

Makes sense to me!  But then it would...  ;-)

							Thanx, Paul

