Return-Path: <linux-kselftest+bounces-27820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5380A48CF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 00:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF53B5C2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2822B5BC;
	Thu, 27 Feb 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgKWI+Gs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C68276D13;
	Thu, 27 Feb 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700058; cv=none; b=EqSWhDla0b30x2fBsQJQvlLCtjJ2qyhgE5f91r54M1q179HPKeD8IuPkFJadaNy4UPMgbD5lYPRMpkbIvce6ZGHhlyBw4M9PvaDMpchB5DE7/NVakn3G9ebUzKqP760Ol6Bpi2wvg9Op//FGIqfpBnfCfW8dU1Dz0OGeM6OwUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700058; c=relaxed/simple;
	bh=c0oYsmyu//bfUW48faBRQo8ItRj/gBwXXjbw7H7EfQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jew09JcQsO+0V+LLjMCGbM1yX0aU60gQUFB9ciARidG43R9GaTJGfnWr0N+nkv5bLahM00WNTEcP0T0WV963V9tWwaQj0jHGVqX/d9cUre4DqqZS5j22O4xz++R5cTmZuJ5JZreGt0hvtc/ILirZgpPwKNlJAZpu3xWzA+zsis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgKWI+Gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57319C4CEDD;
	Thu, 27 Feb 2025 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740700057;
	bh=c0oYsmyu//bfUW48faBRQo8ItRj/gBwXXjbw7H7EfQE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RgKWI+GspJn7hE7J9mcDJJ2vqB3NUtVCZFG4YE3vLwMRajxDv/fyEoclXVe+u/WAN
	 jaQAFcaaqpw6/B3uIMG427FUVOVWVOjF5DPHhaBmg7GdF2gjYmRvOMzHMIa2w9PYE3
	 nLvq8CAram0W7yR+6F9p8wT1rZ1x+ypelEc+iDD2JEdfelcUZWwOr91va0431r6Ny9
	 b8x7N43CGE4DWZa0Qx/Fkj02WvppLE2Y6JQLNdj8CaqS3gqZ52ZkrehMjle4RTcbjt
	 GkY6P9G3giZSYPyDdK8r0X/MqNVZva684PqoYv8UbEf7482/zYfiMaiY0AX9nlq1ke
	 01QijDOrvvDsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F22ECCE04CA; Thu, 27 Feb 2025 15:47:36 -0800 (PST)
Date: Thu, 27 Feb 2025 15:47:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH rcu 00/11] Lazy Preempt changes for v6.15
Message-ID: <a43b531a-241e-4a0a-b373-5a111b519d0f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250225035516.26443-1-boqun.feng@gmail.com>
 <87mse70xqn.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mse70xqn.fsf@oracle.com>

On Thu, Feb 27, 2025 at 03:33:04PM -0800, Ankur Arora wrote:
> 
> Boqun Feng <boqun.feng@gmail.com> writes:
> 
> > Hi,
> >
> > Please find the upcoming changes for CONFIG_PREEMPT_LAZY in RCU. The
> > changes can also be found at:
> >
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git lazypreempt.2025.02.24a
> >
> > Paul & Ankur, I put patch #7 and #8 (bug fixes in rcutorture) before
> > patch #9 (which is the one that enables non-preemptible RCU in
> > preemptible kernel), because I want to avoid introduce a bug in-between
> > a series, appreciate it if you can double check on this. Thanks!
> 
> Makes sense to me.

Looks good to me as well, and thank you for spotting this!

							Thanx, Paul

