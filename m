Return-Path: <linux-kselftest+bounces-29805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A8A71036
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 06:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0243B4645
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33058176AC8;
	Wed, 26 Mar 2025 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSpoz6Ar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882131F94A;
	Wed, 26 Mar 2025 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967726; cv=none; b=eQ3ViUpA1AXykzTs30pwysbiyNKc3/wBS4zZEvo8bcf3pgC8l6HKaY2G+892dNeeK3h3KDLke2xU5yTjVeV1URMP3tlnKFE806/pglxM/LuIun7Dl9G4TXGth/yn9JHeCIHE8A7RxAhn1bcs0eKiEN/srP7GFkgT2q2nMD+egkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967726; c=relaxed/simple;
	bh=9tUJgtx/I4Ula4+wTTHdzcG5PRW2PtmEfKBZ++SEvb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNEy3cNIskmfWgByUrVahpvnbYduBshZTmSGErNGmc4iGtzKuCc7KMOzyK8D/ZFh9ZSLbukyQyqCBxVk9ZBiqL4JaVh9CpTeVTNfjaR0UigIWTDoa5yUUAqj3sUX7hE7wnb44C+DiE+USF47j8G5cf+PHQjsN1nMWpDzWevBJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSpoz6Ar; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso99445596d6.0;
        Tue, 25 Mar 2025 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742967723; x=1743572523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0dEHGVZ4hBSE6bYUe+KXweNXExD02nZ7NS0v7qFDds=;
        b=nSpoz6ArZX7rTW0Z0DChEas9aA+W0p3kJrlTDJr8lD+F/LMKtNNwltgXiqYtGWYGlF
         ztzJDyrS+2rXavxPm11uUqhFD4C/+pbLyQo6Q6ClPzGvDRc62skDggjTxN0rxviuCAfp
         mCpYSFB6yZbBLcnrUYSKAsWookyXxxK5GVZbZ5UScsq/HmS1iSpMs2xXA90YM7mK+pmE
         L1GsuPe+WUxwFZ/++1zaeFDll8Ku6bDUItBjS9Rb3Luh4g7sjCEMoEIwKfrioOfGf6Su
         gC+1JpU6giLoVF+JyR16GtShe1XfSdBz223yGAnmK7ESGtSjghIyjTHqnZ0yYvKoRhZH
         zzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742967723; x=1743572523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0dEHGVZ4hBSE6bYUe+KXweNXExD02nZ7NS0v7qFDds=;
        b=j9l/u7Bc8Fn0rL3rbewPkrwride3zHwjckCHZd0DXQDXM0B6UbTRVtTXKR3C5RF3RN
         uulhEPE7CWxJIvSoFiOOaSqDgnm8VdXWUQoWa7Yl4/nIfA1N2K/BpVyjYQIlQe7xcHdO
         RaU8wgxjaqSq98Izhn2+0G5M4jWeaq3vo/JfoIepxF474aCUAbrw6a6uEBYQHNC3CGgh
         n+N6ZjiZ8WpV3QKKliQXLO/xvsHpKaz9ofRhaDFBaxL1SVAdnYm6Slk9DFAxRKv0zOQi
         yMWD418MFb9KuAXxciV5m/Jai/LGgj8wFOJw64ZjWMakhky7OmiHNi3K9PkcKC74Tf/4
         aHjg==
X-Forwarded-Encrypted: i=1; AJvYcCUuyLKVdm2jGMRUpioo7GXr0SebnXyspnf0Z0LyTded1WmGi45IUyaimBpXc7HOq2cP1ysbciw39f/qEQrved7a76Im@vger.kernel.org, AJvYcCVKVdgjRzJqA2Xm7RUWjPzEw5uvQWqNEgsjjzwYSQlv7m0/ITvRE+WI6c4WAYtxRGjGbgaK3eDrAU0KHHGh@vger.kernel.org, AJvYcCWQ8zLffQh3SQ1ShxEaHZkJCdJzCLL8npyMdzIJqC9KayeN9qiXrFNTk8wqrZmC++5wYy1jcq/hNCQ=@vger.kernel.org, AJvYcCX/ylV2XHiK0oB270rda7YGR0iW9XZSKrnSgsw/4nqVjsBXGYgjLMWHLW8o7Wyk/5+50mdX@vger.kernel.org, AJvYcCXFcCaznXRfz/EuXmIkqucaQktwDaw9zMDCWMKIsUa2OwbCUtFvmH22194ghJbMtnoxS1PW8PBdc6dB9eSrxm4B@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0cfbohiauJ1SD+ceVvMILt6BbOLJQP9hUYDvUc5gN33d01sF
	NhktGPhXXnzoxQ85WsX9KaXJ1xGcNuOiiO+avIXyMW5nQzjaZE/K
X-Gm-Gg: ASbGnctTMbeNp/4s50a7m8G6qnip6U+9KFvY3hSUYH9YsVIBfy/vAzbg2PgzUsDdD4b
	HL69v+ZWhiaW/QPgvNv2G/LAyhJEOteFKpK9RnHewadXngztKUE8ZY6J6bxKsiLpEmuZHTboiel
	KTuTmNOZOSnFm0WySyi92v2DVMjqVFdCCEhtwhdTKhL0GfcAdXDumG7mMtWuErOUSfPcLh5iM1G
	f6+gYuRn7L0FnZYnaKSS50AUT5XZLAr9KyKw2zPTQH/Bdt2MmKUUUFCRQO6mlUuvPyscOfbNb6Y
	EQ++WxXTLThet8ZYljXAdEe/ypowsGiEfqGpX1IkNKN5hXuU9tJo9ZW9W9/0lM7abmRWR5Ftu3V
	U9elRBD9UQP3P7yXXmnk9YRCpL9i99zUvuxwoW+mKROaPrQ==
X-Google-Smtp-Source: AGHT+IGIwau/CnHCqX24zaMorFuv7Hu/k1LNnkEFkp0/C2g/AeEg8rZztvsb4QeiQRSALOYiW2H+9A==
X-Received: by 2002:a05:6214:f62:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eb3f1a731bmr288486256d6.0.1742967723231;
        Tue, 25 Mar 2025 22:42:03 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0f1afsm63932976d6.15.2025.03.25.22.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 22:42:02 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 135BE1200043;
	Wed, 26 Mar 2025 01:42:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Mar 2025 01:42:02 -0400
X-ME-Sender: <xms:qZPjZ_ZcTFHmMfatb9rcsY_ZCr5AagbIlXW18PZA2s-9lvpqZ_9cBg>
    <xme:qZPjZ-a0xofDujTM3fNi9gRqEDC8NK_izuZiJDOagaqNuQQ3T-KASOUQ3jmbAYjo3
    golVJ6FCTgwAGqpvQ>
X-ME-Received: <xmr:qZPjZx8CioXpHWqsFTul2sPwFdokHhzpItKkIqR0GXlBg6e_vVLrkiy3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgvvghrthes
    lhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthho
    pehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrg
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigv
    rhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:qZPjZ1otIvUG-dX-6nuQYuCcZ6sSjPy-lFrBP2TAiV5iTYK0epsEVw>
    <xmx:qpPjZ6rvhysJhHWKLiOGibQURgMtusN00Sgo6QDlZkIE0IiHzvsZsQ>
    <xmx:qpPjZ7Rj0ocqd80X9Vxok7ncXugSjn_xPZ9p-v0aZdndFk3Kf_kRGw>
    <xmx:qpPjZyq9tU5VkQLS_GcfP-Tv-tn7DVkJ6GzTEcrE3Z9FyO6mh-JHeA>
    <xmx:qpPjZ74TvqK96wVV9M07z0IZxKykhYCdQLqWIH7nuKQ7ddCLO9GSTw_U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:42:01 -0400 (EDT)
Date: Tue, 25 Mar 2025 22:42:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, rcu@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
 Shuah Khan <shuah@kernel.org>,	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Yury Norov <yury.norov@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for
 testing
Message-ID: <Z-OTqMiXMhnImKDC@Mac.home>
References: <20250219153938.24966-1-boqun.feng@gmail.com>
 <20250219153938.24966-11-boqun.feng@gmail.com>
 <CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com>
 <5bf94fdb-7556-4b34-ba21-389dfa1df4f7@paulmck-laptop>
 <CAMuHMdVVQWZCUFT2uF+QSQz-GzOz2PvugkeatA6bDQeNHU9PSA@mail.gmail.com>
 <b4ac95ce-7cfd-4d31-aa7d-54ef04f4ae24@paulmck-laptop>
 <CAMuHMdXsuKMLrg5qmS3oTAWfv3Ph34Hq5jeid974+RoTAR2Rkw@mail.gmail.com>
 <5449d7d5-198e-4c86-916a-998464c9932a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5449d7d5-198e-4c86-916a-998464c9932a@paulmck-laptop>

On Tue, Mar 25, 2025 at 08:51:05AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 25, 2025 at 04:36:23PM +0100, Geert Uytterhoeven wrote:
> > Hi Paul,
> > 
> > On Tue, 25 Mar 2025 at 16:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > commit 2245ef8605a80726548253d885b4cadd97f69f3b
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Mar 25 07:31:45 2025 -0700
> > >
> > >     srcu: Make FORCE_NEED_SRCU_NMI_SAFE depend on RCU_EXPERT
> > >
> > >     The FORCE_NEED_SRCU_NMI_SAFE is useful only for those wishing to test
> > >     the SRCU code paths that accommodate architectures that do not have
> > >     NMI-safe per-CPU operations, that is, those architectures that do not
> > >     select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.  As such, this
> > >     is a specialized Kconfig option that is not intended for casual users.
> > >
> > >     This commit therefore hides it behind the RCU_EXPERT Kconfig option.
> > >     Given that this new FORCE_NEED_SRCU_NMI_SAFE Kconfig option has no effect
> > >     unless the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option is also selected,
> > >     it also depends on this Kconfig option.
> > >
> > >     [ paulmck: Apply Geert Uytterhoeven feedback. ]
> > >
> > >     Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >     Closes: https://lore.kernel.org/all/CAMuHMdX6dy9_tmpLkpcnGzxyRbe6qSWYukcPp=H1GzZdyd3qBQ@mail.gmail.com/
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index b3f985d41717a..ceaf6594f634c 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -68,6 +68,8 @@ config TREE_SRCU
> > >  config FORCE_NEED_SRCU_NMI_SAFE
> > >         bool "Force selection of NEED_SRCU_NMI_SAFE"
> > >         depends on !TINY_SRCU
> > > +       depends on RCU_EXPERT
> > > +       depends on ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> > >         select NEED_SRCU_NMI_SAFE
> > >         default n
> > >         help
> > 
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Applied, and thank you very much for both the review and the report!
> 

Queued for further testing, thank you both!

Regards,
Boqun

> 							Thanx, Paul

