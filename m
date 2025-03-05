Return-Path: <linux-kselftest+bounces-28274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E849BA4F4EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DB67A1CAC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD0B153800;
	Wed,  5 Mar 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4B4NUjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0545C18;
	Wed,  5 Mar 2025 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143285; cv=none; b=PMjgOKi++Qyp0nNA0h5ZGpu2X/1Os7eOZGKDqOxA/tddIrAkZ2+PXEV1zzijx1Wh+qumx2AmuwR5bgSVy9f+lBaupHfYsLmzfc23Bm/lbkeVyJCQ7xwEKitVgHGmy5jiZ4zuR2v9cxrTokZda8Tu5uWvL11cFb5qJgxqITkswcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143285; c=relaxed/simple;
	bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrcQRhLV+dXW72XusvMWbxglGrv86WRI7Na6VYuWkT4B8mzxGyHC9JvIo1FsDRW4yCQPs8JnmYFuHc31z+k1kyPoJT6+ZfslzMTMzw3cs0sYLcOQx7I8gRwkA+NtLm8Ih0cxs+kI1JLmSN+JR/DSIdOKsOx4G00t6eRYf9snuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4B4NUjW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c3b4c4b409so495400785a.3;
        Tue, 04 Mar 2025 18:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143283; x=1741748083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
        b=C4B4NUjWr9adFGs1UGGtUwqZQAcB5IHNJq1++qHwkFlsLCKvoHOoJ/0115JMQssPgT
         MsCan0gxBrwsOwbPXsFHBGepmZlSUzBlCRO6WkK1xhfBOCu3VxUlttE2FfiZSUdU8l2F
         dxGqOdFA/I063Tf8/+lbFrGPnygor5CDX1AOks8d/7e8QdDl1ulTucX//gMfQTJ+zrwt
         ljzQ84A34REWanHJRO5gXBVTY/DlBo42Ah+Koprf5UAQd1SnnEr59XrSck78u1i8VEma
         IBWxjf+gToPfM87u+0u30qOfC4B2Z9+S1f7fm+Cafw5wnF3K3mEe+EUa+15cbK7qiQxa
         bRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143283; x=1741748083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV6gyGazzJ42NubyrUwHa0PU0qVcgVll114FV7ifGlA=;
        b=D4ABOLKCMiOsj2u7yLophJF5yhM3BGa0DlkdzUvwCjfOCP0uQkjgQQgvJPv9zMLZ3x
         8H1d8EE2T259KpVXmA2Zp/ANgg65CFe5szzz+rTNhBsTNPTbFL/SjWcjpAouvcnn8LW/
         NIRlDrqIWXUus9SPKWZI/Hnng3+RkAQZ4OUzcroudMH8RU/Rf2xBMDb5HQukdQziClMB
         yu7R3NMWTvyztibUMntAp0xDFQ9SmneURMbJkA9UINZ0gXqQ9HSHqkcBy3gf5gtrcbTH
         YkLXNQGU9bCV5b8YhpkL70Wu4KDgQloRqtTY96+PZVC58Uyc5EHxH2OlFBYlSdCTVh5X
         Jifg==
X-Forwarded-Encrypted: i=1; AJvYcCUrdEdC78OMUSZ4rk1fYgPnriLn7UwkEe0aNzgBXh4mS8LYYSYWO957iXTy2Z7QgIE1adMfG5yDpErz7WeD3qNi@vger.kernel.org, AJvYcCWgxPnrx29q+gAU4BXE3vMjQKo7TJDJXaW6z2fk+G34d0sGpng8MS+5YKGgJWnFandgMYuy3lbudebMfI2ckaCPKfXG@vger.kernel.org, AJvYcCWnfmVU3QQxiU/U3a0Ah0jYWAegfJrppPglaehbI+6J4cj3yF6pEBNDx5l7e2N8m1XfC67MG7ziMdNnNmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRNTzuQk+6WB7Ff3huGIRnhiQbXbTBmoMf2hYfPnjNE2k8Si6
	vtzxTCWYffxsPuFYeQSgViNUbVufQ6MjpyVuq8RkY3fpHVQUjokv
X-Gm-Gg: ASbGncsyjzMxhnx4CcF9bHCrMRc4q214bzUzkNdujlHcUSsztrY28tGikmZVQNuhNFg
	HZu0wrpAf/8+5lQyDjALaiwpzEq2iPosb8Q1Qjcvo0fSCoBZsIO0F4K9OJK0XEQ7Y5oo+bdU22X
	aBGK8eaYQKg+6VS0govHROurwO9etnOdzgxSweJKnTaRV2zyzhius7Q3A/xo1GiDdKzzDHw112U
	HVX123LGX5b475Zc9HPS9yHWq36Hwb/GwXJr0R848+p49WBc9CG+otKiIjOVQIIn9i3q2Ocqqjl
	KmzmkMry8em59RVtmI+PPpp2EhBHMTLcms905hT3O4FPumZlYUzTcthVqNn2A/EHHgZ3VC23NZ8
	YDRtU7Beqj5cuIUxWsa2f4fwZJIjVgthED/g=
X-Google-Smtp-Source: AGHT+IHBoQiW7YLCUvoHR0BGtgdkr30Lh1JWx2qiZpsHE/51TJNn1Bw7Jeixsoev4iKBvUmgHnx5uQ==
X-Received: by 2002:a05:620a:2607:b0:7c2:40d1:8593 with SMTP id af79cd13be357-7c3d8e20ee3mr236316985a.3.1741143282793;
        Tue, 04 Mar 2025 18:54:42 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3ca43ad81sm228200185a.80.2025.03.04.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:54:42 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71EED1200068;
	Tue,  4 Mar 2025 21:54:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 21:54:41 -0500
X-ME-Sender: <xms:8bzHZ9LFSO-a7ihBB_pv8V5rMhqrCR_uO6brALv_DTsMkbnINqpj9w>
    <xme:8bzHZ5ICRQVksAlERae5OZAvduwZlz1qAgrERq5bNKjTQt0f2uYUbcUpoMigZ3QGd
    UpwwI3GC1dXsBLtQA>
X-ME-Received: <xmr:8bzHZ1ucqTCiCh6UQ1HAcC2SWKqx4g4_vR06lzjQbgjSp2dCVHYOF0BiRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhfstddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepheeufeduuefftdevffffhfehudeitdff
    uedvveegleffudetueegvdehtdfhlefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeftddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhish
    drohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvg
    hrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhih
    rgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrg
    hnuggvshdrohhrghdprhgtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdho
    rhhgpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
X-ME-Proxy: <xmx:8bzHZ-bAeG0ZN1GRSTXMehPu8GzSaSPV29guxqRdGz2fwFl_WYKV5Q>
    <xmx:8bzHZ0aKBJ5-5VFBHCz5DMRPMteMbfFZAPBaND6ZAQN2X7WHkXQD7Q>
    <xmx:8bzHZyBgmAnxKIcGNuSZ5RxojsTbDVVWDzKB6k-raS6dr88qNYe3dQ>
    <xmx:8bzHZyY_W8yOb5yK3MJYbCUbBXmGtxXxETMRJS4EIEmVEcYWau52eQ>
    <xmx:8bzHZwrUTjFR0__3g6VW5Q28j-I-8Okx3u1SPTqqw8wuH5BuD7BoXgjr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 21:54:40 -0500 (EST)
Date: Tue, 4 Mar 2025 18:54:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 	Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 	Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 	Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 	Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, 	Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, 	Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 	Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 	Valentin Schneider <vschneid@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, 	Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH rcu 06/11] osnoise: provide quiescent states
Message-ID: <hrwgh7fevnkmkaizc7226kyywgzi22efmtnepzwah7ticrozbv@lcg23v6j7p7g>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
 <20250225035516.26443-7-boqun.feng@gmail.com>
 <20250304142127.391ca6bd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250304142127.391ca6bd@gandalf.local.home>

On Tue, Mar 04, 2025 at 02:21:27PM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 19:55:11 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> > From: Ankur Arora <ankur.a.arora@oracle.com>
> >=20
> > To reduce RCU noise for nohz_full configurations, osnoise depends
> > on cond_resched() providing quiescent states for PREEMPT_RCU=3Dn
> > configurations. For PREEMPT_RCU=3Dy configurations -- where
> > cond_resched() is a stub -- we do this by directly calling
> > rcu_momentary_eqs().
> >=20
> > With (PREEMPT_LAZY=3Dy, PREEMPT_DYNAMIC=3Dn), however, we have a
> > configuration with (PREEMPTION=3Dy, PREEMPT_RCU=3Dn) where neither
> > of the above can help.
> >=20
> > Handle that by providing an explicit quiescent state here for all
> > configurations.
> >=20
> > As mentioned above this is not needed for non-stubbed cond_resched(),
> > but, providing a quiescent state here just pulls in one that a future
> > cond_resched() would provide, so doesn't cause any extra work for
> > this configuration.
> >=20
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
>=20
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>=20

Applied, thanks!

Regards,
Boqun

> -- Steve
>=20
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---

