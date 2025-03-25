Return-Path: <linux-kselftest+bounces-29763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DBA70497
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B66166925
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1E25BACB;
	Tue, 25 Mar 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQXjsABG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DE25A33A;
	Tue, 25 Mar 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915280; cv=none; b=eZok98O4FBoI35DcP0X2fRod4UMB1FhPKzdN82ucxURQ7MsJ7NmYqOfL0nNBs2yD1oRrgA+nuSGi54zsFP4wcdwIWrcfvzDONm2YzUhFLWxbrf8I2hnzt37wP2EAMgMGU30g3QBgZ2Hln8SAMyY91FzKJjceWIljJ7eDKFCHKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915280; c=relaxed/simple;
	bh=FVtW+znZpqIiN9CqfSZ9CbuEpNile4mPRx1yMLXOKBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA3JT730T8iE0xEXlcUzCxiugGQM4MNzLfEv+nxkDwhWoGsdKZ/4JruZ+gBaKUbLLJS+5rpdATEkgyIWKoIbp4BZn5IHlzbPDq2b3n2cIxgxu451E3Kr+P+8thOWYf00n9XrasFjUnldd8561XD/iwf0trBj1O6h5t4A7f1QcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQXjsABG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207BC4CEE4;
	Tue, 25 Mar 2025 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915280;
	bh=FVtW+znZpqIiN9CqfSZ9CbuEpNile4mPRx1yMLXOKBA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kQXjsABGJFG7H/SydkIhmI9ti6PbsbLSitopLcSKhCyb1xZYJ6DV2oNA5jYmwCjDq
	 ptq13iaxKhRsr61P2b28vGBE6y2eZRw4fjPkxRQrQ2Ah0+B+oXNgnV0gARBcI1S895
	 Lz2/P3cqM5Zq/PM3V0PMmfehqubuW/CqtULK0AUUgMFW//grEiSliEshbBgXOfqZlY
	 V9MsXfmbI+6OQly3Iuss1wPBKwEhGGVcA0xTD2VCtSMKNnPKecQZ+tWOceb637oNRp
	 UeMJdM6uid8QWyAJehuJT6XUKFfNjpfF8S25s2iTgYxkFg/uc9tVIbt7lKZ6j9GCio
	 Wd7nmM+860+8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1C1CCE0843; Tue, 25 Mar 2025 08:07:59 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:07:59 -0700
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
Message-ID: <b4ac95ce-7cfd-4d31-aa7d-54ef04f4ae24@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250219153938.24966-1-boqun.feng@gmail.com>
 <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
 <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
 <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>

On Tue, Mar 25, 2025 at 03:57:43PM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Tue, 25 Mar 2025 at 15:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Mar 25, 2025 at 09:04:31AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 19 Feb 2025 at 16:44, Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >
> > > > The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
> > > > map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
> > > > that have NMI-safe this_cpu_inc() operations.  This makes the underlying
> > > > __srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
> > > > difficult to test on (for example) x86 systems, allowing bugs to creep in.
> > > >
> > > > This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
> > > > forces those underlying functions to be used even on systems where they
> > > > are not needed, thus providing better testing coverage.
> > > >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > >
> > > Thanks for your patch, which is now commit 536e8b9b80bc7a0a ("srcu:
> > > Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing") in linus/master
> > >
> > > > --- a/kernel/rcu/Kconfig
> > > > +++ b/kernel/rcu/Kconfig
> > > > @@ -65,6 +65,17 @@ config TREE_SRCU
> > > >         help
> > > >           This option selects the full-fledged version of SRCU.
> > > >
> > > > +config FORCE_NEED_SRCU_NMI_SAFE
> > > > +       bool "Force selection of NEED_SRCU_NMI_SAFE"
> > >
> > > What am I supposed to answer here? "n" I guess.
> > > What about distro and allmodconfig kernels?
> >
> > Yes, you should select "n" unless ...
> >
> > > > +       depends on !TINY_SRCU
> > > > +       select NEED_SRCU_NMI_SAFE
> > > > +       default n
> > > > +       help
> > > > +         This option forces selection of the NEED_SRCU_NMI_SAFE
> > > > +         Kconfig option, allowing testing of srcu_read_lock_nmisafe()
> > > > +         and srcu_read_unlock_nmisafe() on architectures (like x86)
> > > > +         that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> > >
> > > Perhaps this should depend on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?
> >
> > ... you are on a system selecting ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and
> 
> So a dependency on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS does make sense,
> doesn't it?

The FORCE_NEED_SRCU_NMI_SAFE has no effect otherwise, so it cannot
hurt.  Again, please see below.

							Thanx, Paul

> > you would like to test the SRCU setup that needed only by systems that
> > do not select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS.
> >
> > Ah.  I forgot to add "depends on RCU_EXPERT".
> 
> Yes, that makes sense.
> 
> > Apologies, I will fix this.  Does the patch show below do the trick?
> >
> >                                                         Thanx, Paul

-----------------------------------------------------------------------

commit 2245ef8605a80726548253d885b4cadd97f69f3b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Mar 25 07:31:45 2025 -0700

    srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
    
    The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
    the SRCU code paths that accommodate architectures that do not have
    NMI-safe per-CPU operations, that is, those architectures that do not
    select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
    is a specialized Kconfig option that is not intended for casual users.
    
    This commit therefore hides it behind the RCU_EXPERT Kconfig option.
    Given that this new FORCE_NEED_SRCU_NMI_SAFE Kconfig option has no effect
    unless the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option is also selected,
    it also depends on this Kconfig option.
    
    [ paulmck: Apply Geert Uytterhoeven feedback. ]
    
    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b3f985d41717a..ceaf6594f634c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -68,6 +68,8 @@ config TREE_SRCU
 config FORCE_NEED_SRCU_NMI_SAFE
 	bool "Force selection of NEED_SRCU_NMI_SAFE"
 	depends on !TINY_SRCU
+	depends on RCU_EXPERT
+	depends on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select NEED_SRCU_NMI_SAFE
 	default n
 	help

