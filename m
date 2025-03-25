Return-Path: <linux-kselftest+bounces-29766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8DA7058C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 16:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D43516545D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76A52066FA;
	Tue, 25 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlUzxxau"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658811FAC34;
	Tue, 25 Mar 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917867; cv=none; b=g6mjGM9veZLvsI8dzwDjdjWbAAM7g3Ftn0JnnYxRmIMgn5CM81Q4D+wkcCovh0StafkcqiBqqs6HP7jUIZ/HkOxUO0sBQcj955IA6ynqhZJCdsvJutV9VfEa7WM6MgPzeiQ06UQN8K0zPSGakaNSqrfTn+cqF3bS5KtHQ1eXA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917867; c=relaxed/simple;
	bh=j4rXUq3HLLJeJAgPNR0OyuWtwDa5eS3hzd04iZLT0pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk/ys3h8bmh12dcoWGtv8roNGAExWGd1UGy8JJzBExVt1VImNVpP3GVvoMopm5JJe86bOK66Gta6llMrEaAq/yDYdMSsqEQVom+4UwsHsQGXrTuaHBrQL0S5/xd/TIEYuDSEYKlZk1gTBqgxNVtObeVmdLg1jp/lrKjJ15IWD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlUzxxau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6068C4CEE4;
	Tue, 25 Mar 2025 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917865;
	bh=j4rXUq3HLLJeJAgPNR0OyuWtwDa5eS3hzd04iZLT0pQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HlUzxxauWmzXikkP0trVEbBIIGHWsQMaXC0qpDI+QW4NlHnHoWplagvDAY7sBeDp0
	 qRqNa9B7V8CLPE9Xii7TmoPmjCrA9xSK91VIgRgUUHc7NGEZoqJNW3LFkaDU4diQrt
	 lSk52DcsKFVHHfKIHmai10mi8UwXx7ki+QfE3fyXEvl29SyXixj1Cqq5A61d/vJrJt
	 tSxIj2yfc4wh9s2bcmAX+YQvSjGaQosVSjRvJJJ5fwPbrWWjwRlpFlv66m0YOgbSN9
	 /DcViGMddwAhLKh8rm3OwdetqTiH055etmqOCqbRP9RhxqyG/vI2R07TR0LUcit6TG
	 yw1yz+QzOwKrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7CB94CE0843; Tue, 25 Mar 2025 08:51:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:51:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for
 testing
Message-ID: <5449d7d5-198e-4c86-916a-998464c9932a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250219153938.24966-1-boqun.feng@gmail.com>
 <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
 <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
 <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
 <b4ac95ce-7cfd-4d31-aa7d-54ef04f4ae24@paulmck-laptop>
 <CAMuHMdXsuKMLrg5qmS3oTAWfv3Ph34Hq5jeid974+RoTAR2Rkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXsuKMLrg5qmS3oTAWfv3Ph34Hq5jeid974+RoTAR2Rkw@mail.gmail.com>

On Tue, Mar 25, 2025 at 04:36:23PM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Tue, 25 Mar 2025 at 16:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > commit 2245ef8605a80726548253d885b4cadd97f69f3b
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Mar 25 07:31:45 2025 -0700
> >
> >     srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
> >
> >     The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
> >     the SRCU code paths that accommodate architectures that do not have
> >     NMI-safe per-CPU operations, that is, those architectures that do not
> >     select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
> >     is a specialized Kconfig option that is not intended for casual users.
> >
> >     This commit therefore hides it behind the RCU_EXPERT Kconfig option.
> >     Given that this new FORCE_NEED_SRCU_NMI_SAFE Kconfig option has no effect
> >     unless the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option is also selected,
> >     it also depends on this Kconfig option.
> >
> >     [ paulmck: Apply Geert Uytterhoeven feedback. ]
> >
> >     Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >     Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index b3f985d41717a..ceaf6594f634c 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -68,6 +68,8 @@ config TREE_SRCU
> >  config FORCE_NEED_SRCU_NMI_SAFE
> >         bool "Force selection of NEED_SRCU_NMI_SAFE"
> >         depends on !TINY_SRCU
> > +       depends on RCU_EXPERT
> > +       depends on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> >         select NEED_SRCU_NMI_SAFE
> >         default n
> >         help
> 
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, and thank you very much for both the review and the report!

							Thanx, Paul

