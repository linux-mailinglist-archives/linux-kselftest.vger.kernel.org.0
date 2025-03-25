Return-Path: <linux-kselftest+bounces-29758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28833A703F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23283BFC69
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43D25A342;
	Tue, 25 Mar 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKEIiGy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E2CA52;
	Tue, 25 Mar 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913393; cv=none; b=EY/teOBLb37sHvcFJT38jMSL/N7g3NQepEdTxxCVFCJfPtAfyFiEuyMMQBldXDitnAzJVr7kXYM43oXz58uPVaFgppyiB6QRaDyApBs8h1pa+rwH/Kxp2wlnO2crxs9CqVbODXLEBLW/uEwz7AYjIJRMV3TYUwIblW5vJPyhwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913393; c=relaxed/simple;
	bh=IVOSkXmDgbIuOfSI47r9Hqv+oNEWNJibsDYP8zrNx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzlumD2Opd+1cP4CpVvWnD5151WP1OyRW2IB3kjbgK8uZmVLpVbEd5sN709lqpAWc4nKDTefMemf/zDlUalruOfGGpE/au5jvI5wpI3/NxaFhSGu9oPcuJoXY2BLFeDf7db/pTfI4ltDHLfl8Rs8sAY0FjaY7Jf9vf/D0bhjcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKEIiGy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E08C4CEE4;
	Tue, 25 Mar 2025 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913393;
	bh=IVOSkXmDgbIuOfSI47r9Hqv+oNEWNJibsDYP8zrNx3Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eKEIiGy1SwR60AHw3h6GukjJuQw4w/ACHqyr1Zqto8JanvvUeahsivIi2rgd7VHVV
	 JFL4E8m3z3unEMYX3t2pgrRzb7xfUbtSKy9UCSBV/YccvFMjK3UijQaFQ+ZWM9M5tw
	 5k5hU6yAr/2Co4XljrrFs+VjuhgZEdw94SYdfDaNCcIxep3Iexcp36KaZbfuP5fFsd
	 1vlCGetEyWfFWYeNOzGfY6jviBLrBexSqxRjEtIxkKOM3w3CHf/oNGhJmpEoUvHL0e
	 dSbfc2/PZ+tKrP2EtSj9fBFr79hK5xokSJ7jdnnAL9OLQ2i2B7OMnToTO3aL1k7hg1
	 JAWKqvGvLyEnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C066CE0843; Tue, 25 Mar 2025 07:36:33 -0700 (PDT)
Date: Tue, 25 Mar 2025 07:36:33 -0700
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
Message-ID: <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250219153938.24966-1-boqun.feng@gmail.com>
 <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:04:31AM +0100, Geert Uytterhoeven wrote:
> Hi Boqun, Paul,
> 
> On Wed, 19 Feb 2025 at 16:44, Boqun Feng <boqun.feng@gmail.com> wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
> > map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
> > that have NMI-safe this_cpu_inc() operations.  This makes the underlying
> > __srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
> > difficult to test on (for example) x86 systems, allowing bugs to creep in.
> >
> > This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
> > forces those underlying functions to be used even on systems where they
> > are not needed, thus providing better testing coverage.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Thanks for your patch, which is now commit 536e8b9b80bc7a0a ("srcu:
> Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing") in linus/master
> 
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -65,6 +65,17 @@ config TREE_SRCU
> >         help
> >           This option selects the full-fledged version of SRCU.
> >
> > +config FORCE_NEED_SRCU_NMI_SAFE
> > +       bool "Force selection of NEED_SRCU_NMI_SAFE"
> 
> What am I supposed to answer here? "n" I guess.
> What about distro and allmodconfig kernels?

Yes, you should select "n" unless ...

> > +       depends on !TINY_SRCU
> > +       select NEED_SRCU_NMI_SAFE
> > +       default n
> > +       help
> > +         This option forces selection of the NEED_SRCU_NMI_SAFE
> > +         Kconfig option, allowing testing of srcu_read_lock_nmisafe()
> > +         and srcu_read_unlock_nmisafe() on architectures (like x86)
> > +         that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> Perhaps this should depend on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?

... you are on a system selecting ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and
you would like to test the SRCU setup that needed only by systems that
do not select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS.

Ah.  I forgot to add "depends on RCU_EXPERT".

Apologies, I will fix this.  Does the patch show below do the trick?

							Thanx, Paul

------------------------------------------------------------------------

commit b5c8c6f89c6d7ac778e961ad4b883eada0c1f42a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Mar 25 07:31:45 2025 -0700

    srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
    
    The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
    the SRCU code paths that accommodate architectures that do not have
    NMI-safe per-CPU operations, that is, those architectures that do not
    select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
    is a specialized Kconfig option that is not intended for casual users.
    
    This commit therefore hides it behind the RCU_EXPERT Kconfig option.
    
    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b3f985d41717a..cc4ce79f58aa6 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -68,6 +68,7 @@ config TREE_SRCU
 config FORCE_NEED_SRCU_NMI_SAFE
 	bool "Force selection of NEED_SRCU_NMI_SAFE"
 	depends on !TINY_SRCU
+	depends on RCU_EXPERT
 	select NEED_SRCU_NMI_SAFE
 	default n
 	help

