Return-Path: <linux-kselftest+bounces-17135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7096C048
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE71C25131
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476A1DCB25;
	Wed,  4 Sep 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJFZeYX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1271DA635;
	Wed,  4 Sep 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459794; cv=none; b=rs1wB+S23YDxUC74wksrS998eHbHAnIVQvLpPA0W3Z6IVh8jS5rBAvb1hV4z4P1JHzPXRtiJKQjt5h9YL25Y7Wu+xSZahdznDX39ODIHdnHcbAD9qBY3wqnlr+DzbxpDhG4afNwnD7VASRrJ4AY3n9neEs+a0E1/sbw6UhBqJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459794; c=relaxed/simple;
	bh=CvbyeGCxrQiChryKz94sbVDhTQtEiCPezl0dW6mRsnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuzvuHaa3eJny7rDAmqs7/hGMr/ihxL14I+yC8SYoDRX91OJbTzEc2MWrLE0nfvdTLcTtBY5h2yatvBoCxVVL/fVJZy6aorHagkRv6VJ5aUidqJy3jrVyCYyhck6Ktr1chtms3+FMdHFKwM2D/sjNt+hf8ezUXPuajr/sr+f7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJFZeYX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD5C4CEC2;
	Wed,  4 Sep 2024 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725459794;
	bh=CvbyeGCxrQiChryKz94sbVDhTQtEiCPezl0dW6mRsnM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WJFZeYX1wffp3wp+R2cnMauFH179h3M1dOs6mJPpTaPirh3V8s4gf6jcr1JkUzy3U
	 wW8uwvuezQmEUfAYzStLDQysadt5ZwCvqlEI9LV4/PWxYlcKvMX9Zz4RkZrrgKeY2e
	 fsNjOdOFEsLqpdAdrRL35TLeP1QaEBuDtwqJVGNZP8lwWMLC3pSuj4JEVagKOZJ2A/
	 t3CftXUxrzvp8/L+EV7lkOmtSZkGsiKZaVYdF0yfTXuLlUkMEkDyfuNDwsNsMqAHOe
	 SOXrZ8rnrbeB0JxkW8eKeEJsVxP9XuzEJHYb+KqHhAtYGzPXfj2dn4+BTFx7KLvvae
	 qIoLtQYLj56ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF1B2CE0B6A; Wed,  4 Sep 2024 07:23:13 -0700 (PDT)
Date: Wed, 4 Sep 2024 07:23:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	yangyun50@huawei.com, Zhen Lei <thunder.leizhen@huawei.com>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: rcu_preempt self-detected stall on CPU -
 queued_spin_lock_slowpath
Message-ID: <ef2fbd11-6f37-4484-93c4-6a84e63c3bce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
 <CAOssrKdc4rcjJOqBnhbRa=R5yQY1erh+KuXr_2-nGTQ-qk3vOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKdc4rcjJOqBnhbRa=R5yQY1erh+KuXr_2-nGTQ-qk3vOg@mail.gmail.com>

On Wed, Sep 04, 2024 at 04:19:39PM +0200, Miklos Szeredi wrote:
> On Wed, Sep 4, 2024 at 2:06 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The following kernel rcu info generated while running the test case
> > selftests: memfd: run_fuse_test.sh on qemu-arm64 running Linux
> > next-20240902. The qemu-arm64 did not recover.
> >
> > This build was created with kselftest merge configs.
> >
> > Anders bisected this to,
> >   # first bad commit:
> >     [5fb9c98e9d8ddf2abc645e2dcd9eb6703f77fdab]
> >     fuse: add support for no forget requests
> 
> The bad commit was reverted from -next.

A bit "Thank You!" to everyone involved!

							Thanx, Paul

