Return-Path: <linux-kselftest+bounces-29762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389FA70467
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D712D3A92DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3525A651;
	Tue, 25 Mar 2025 14:58:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45725A63F;
	Tue, 25 Mar 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914685; cv=none; b=sDJh6es/tyIppnwBAsC9NIXx660PZ2blE3blAVWRQKTtZdAsDV0p7JkaIgV/TY8mhssd9WdA2SwPg8Xzhq3qT9G/LLqHyKBrjYHoZYS97WJh2j40d3ffMGxRtUNRECQxx0YBdf2k57/i+s8ZxcZxKjN3AReo2IUHQsKQAZHmcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914685; c=relaxed/simple;
	bh=ECDApjKKkxK8BLcVDBby8co8PGQ7o40O6gPfOXXCcTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDr3Wa3VK6k3Y1gTf3Hp3Wo52JRusd7MDz9ljhuE67/47kfOpBVTA0YFJ6Cz8MJHxtdE2Bbabi55PtWklrLLfZ18qrVWTll9+ghmp6LSx4xPXic5L/IwjytMIFXAWWfpTlLUvnfOEdC0Tm0aTA5wOlPxPoTnZiL8UkBO48e85r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5240a432462so5346478e0c.1;
        Tue, 25 Mar 2025 07:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914680; x=1743519480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0xebWM0gmHhjt6fLzcbqQE0UUa1N6EAIlr9dz4Grvs=;
        b=gDQ0kJ2in819awRUxxkGkHLmtoUBfibhp7nJzHf2fmqzk7W4Gn91RcDV4JeDUCv4vQ
         ds4ZJJdoD3f2+13yVSzfBQCJcyHBS3fDcHdw7GP9KMRT+slseancjncXK7ixg3sIsWi/
         rX9IH4a99v8mDgg4KR9uugBpgnM7udx9fiMSafowsS/B1UdoT1YTVUQbliREXpZMzZxG
         8LFiYPzDwKmr2e06huJNTj411oSFOK3zvdjQ15UVzJdrKm20Td7LlpkEhYjQd500ziDg
         as4XiGp2080G3vnroyZjuS+EFekeWz3bwLAgrb087rGk6Jcq7QkqDVOTDDohshWpWSK6
         OaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDP4LiW+vH1z2Zn+k5VIJ6MmNqtvzH78u8XxYKp4/Qcv58dQ0+XXfVaAYx9witt3ukypa+@vger.kernel.org, AJvYcCVfe6+FqUzL5dxgcFqh5NtOBWwLQ/7savYdA+P31co7TMzgxvq+vyhEc3dVG4/nsfjS29vbYfvLxAIlBukO@vger.kernel.org, AJvYcCWKJI1t9IMvnaYeKlOuSpEAfKd8gi6lkoN1RLHNXiIyEUyk0XvDToRSa4c7eWCMVUrFrsT9+1/C9CewtYyGRxBO1U0c@vger.kernel.org, AJvYcCWMSzkGmnDkHOR3KQvnhNHXbGtPsXmhB4WNRxb0hKLeCfZSZvbubCni1Kq2nlu0tLMRUjVMl7aNqCg=@vger.kernel.org, AJvYcCXpLWnNzuICXSbIABKlLBL92efxJQRtXA3a/wWx9AeSPRHnsawqRZpYNf/7l9QMN0WMofUhMYF5BaILVItdxfeV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5mE0ZZe+j5votqS6X22UtDViOENthmoQnm2sWLh660e/QHHv
	YD7j0eM4cFaWrnIuKBEM4HATGu4OMUtDt5nQuxUENFFJuftGxgT46PQWqEkG
X-Gm-Gg: ASbGnctwzqqSzhMXpM3mmLyJtrDejRFSrYOa7BGtwn2CbYw9GJS6/XbPLGNaPDuTGpL
	SCuz4nfR89x+1OFugO2g/xkEoCIGuJ7mnyXLdnsoF3ZVoB/LOFP7FD8ct/2lULVEUQ7h53kKP64
	33wdrVla+Rr0VxTQ5S0uJrtezbsq6RfwpyScwQoQmGRGfH6XfRmsd76ZiJ5s/rd3b59sbn5Pyaz
	mTRukKZ/uGw3c8b8kih+9zHOxOJNdfyJqjfYgeCAMR0FIDcZEb+2UxA5OjkZJ7WD5RBfE3J1W/Z
	X0hSmnEWQQNEekqeggk/UwVWvenF1JVzd9u3UEXWOGNljOwcG1HKMyPoSHEzvan6IJpLsFxLbAw
	xm6IteWs=
X-Google-Smtp-Source: AGHT+IGzfsAwE7M0WS1WP8TfmnuUIRJPCT6tsBuqJLqGGNxyRcr+N2BydslFQYsUnakz0MpTselcHA==
X-Received: by 2002:a05:6122:1818:b0:524:2fe0:61bc with SMTP id 71dfb90a1353d-525f0b6292cmr73054e0c.5.1742914680306;
        Tue, 25 Mar 2025 07:58:00 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a76428c5sm1805122e0c.29.2025.03.25.07.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:57:58 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so5377226241.1;
        Tue, 25 Mar 2025 07:57:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTmOVqh8nc7iHyhgoUJ7/1FHS1XGKDyofpTjmTUMBDOJNN0POp52oftHzT2cx/8DZBA+N/@vger.kernel.org, AJvYcCW80ndZJWotyArR7+BnYRhe4M6cK9YurAYvziYH0fy/hwlXki4paZvjmPpkDptUQ14H7/FlWEQ2TkQxPAt3F5cEraqW@vger.kernel.org, AJvYcCWYWndqXSswV7lL7H0RpOEb+Og5xinr0rgy4ZAYZVyPhQRZc1zhQq/RXJvtjunLACwrQW/k3HiH9migEM0/knqM@vger.kernel.org, AJvYcCXNCRCu+trfAxzeSizMcw/cufB8cSvKPY3GJuxpGpgT5a2KU43eub1sE2kVVhP3GcYYDxzBE2S6rrc=@vger.kernel.org, AJvYcCXt9HSmLwaM8WKYN8gC9jK1k+PsQeZ2wb3VV9+RUxtP1ZdujH4NBXZEIP2IS7w8DH2ckZCOEi2IpfwtN8S5@vger.kernel.org
X-Received: by 2002:a05:6102:3670:b0:4c3:69f:5be with SMTP id
 ada2fe7eead31-4c5738bd026mr44200137.7.1742914677640; Tue, 25 Mar 2025
 07:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219153938.24966-1-boqun.feng@gmail.com> <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com> <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
In-Reply-To: <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 15:57:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
X-Gm-Features: AQ5f1Jqvh_9an-Egl41e3TmRLSW98_V3Ly9zINYsX1Gd4KteCcb00aGL-dyJYHk
Message-ID: <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
Subject: Re: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Huth <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Valentin Schneider <vschneid@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Tue, 25 Mar 2025 at 15:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, Mar 25, 2025 at 09:04:31AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 19 Feb 2025 at 16:44, Boqun Feng <boqun.feng@gmail.com> wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > >
> > > The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
> > > map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
> > > that have NMI-safe this_cpu_inc() operations.  This makes the underlying
> > > __srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
> > > difficult to test on (for example) x86 systems, allowing bugs to creep in.
> > >
> > > This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
> > > forces those underlying functions to be used even on systems where they
> > > are not needed, thus providing better testing coverage.
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > Thanks for your patch, which is now commit 536e8b9b80bc7a0a ("srcu:
> > Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing") in linus/master
> >
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -65,6 +65,17 @@ config TREE_SRCU
> > >         help
> > >           This option selects the full-fledged version of SRCU.
> > >
> > > +config FORCE_NEED_SRCU_NMI_SAFE
> > > +       bool "Force selection of NEED_SRCU_NMI_SAFE"
> >
> > What am I supposed to answer here? "n" I guess.
> > What about distro and allmodconfig kernels?
>
> Yes, you should select "n" unless ...
>
> > > +       depends on !TINY_SRCU
> > > +       select NEED_SRCU_NMI_SAFE
> > > +       default n
> > > +       help
> > > +         This option forces selection of the NEED_SRCU_NMI_SAFE
> > > +         Kconfig option, allowing testing of srcu_read_lock_nmisafe()
> > > +         and srcu_read_unlock_nmisafe() on architectures (like x86)
> > > +         that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > Perhaps this should depend on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS?
>
> ... you are on a system selecting ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and

So a dependency on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS does make sense,
doesn't it?

> you would like to test the SRCU setup that needed only by systems that
> do not select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS.
>
> Ah.  I forgot to add "depends on RCU_EXPERT".

Yes, that makes sense.

> Apologies, I will fix this.  Does the patch show below do the trick?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit b5c8c6f89c6d7ac778e961ad4b883eada0c1f42a
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Mar 25 07:31:45 2025 -0700
>
>     srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
>
>     The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
>     the SRCU code paths that accommodate architectures that do not have
>     NMI-safe per-CPU operations, that is, those architectures that do not
>     select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
>     is a specialized Kconfig option that is not intended for casual users.
>
>     This commit therefore hides it behind the RCU_EXPERT Kconfig option.
>
>     Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index b3f985d41717a..cc4ce79f58aa6 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -68,6 +68,7 @@ config TREE_SRCU
>  config FORCE_NEED_SRCU_NMI_SAFE
>         bool "Force selection of NEED_SRCU_NMI_SAFE"
>         depends on !TINY_SRCU
> +       depends on RCU_EXPERT
>         select NEED_SRCU_NMI_SAFE
>         default n
>         help

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

