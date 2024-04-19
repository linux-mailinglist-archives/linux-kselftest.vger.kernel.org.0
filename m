Return-Path: <linux-kselftest+bounces-8457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E228A8AB2B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747F01F2157C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B74130A72;
	Fri, 19 Apr 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tznkkjs7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C212F5A3;
	Fri, 19 Apr 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542495; cv=none; b=smvyAyOM0RIO8BQFC/zzgh8SBmMBGqbBI64zL2blEeN6rcP/PMgmQsVXmaMlZszKgcD90ErCR//QsZG5uOgpnxlta5NWYwrAamJ4Vd1+0lAnsdlncod5WGnvX2rWCGtPhTsu18rIW05m5B/xlHpM8f6CJIRy9oKjmTEdLDnTRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542495; c=relaxed/simple;
	bh=oG+eyuNx5evdOk6qBKTdlsXCspoEv9Lhqp4EUQfjFU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUnh9tbmvnd9da+6Xh4PXgtVPbWDD1PqPJ6ogZ/n1oKPsQscd2uqUZnd6WnDfHGEakMdeDG9bb2nLHSb27g0P0vwtA/kl2cMItWwRwdorBPEOviuhi4iYcPAfmetylvTt8GiXpzM+hE3JF1QHdRoNPzpy/lFosSW2FQTreDZAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tznkkjs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80551C072AA;
	Fri, 19 Apr 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542495;
	bh=oG+eyuNx5evdOk6qBKTdlsXCspoEv9Lhqp4EUQfjFU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tznkkjs7r7kKe0PM3Z220g4jO4h6fYG7YU4LFLK7mSRkMy4IQYC28WbVKlD32CQqx
	 GF4u0Hkv+nYeEHH8BlohiGSrn1jU1DI7Iez6X8wMQkTej2tCwxXB/CMNeIo/8hHfCa
	 mz4rDuyu+4thwmQkI6q82q8djMm61y4xY7Ks788/1iyfsCm11eQkE/Mwd2klLQsbqU
	 F3iMYb3noSLM0dUD5mBttNHaVuMNhBAbKY06fCk1mtwMI4cA/UPlm0bWbPrErlIbHq
	 zirkVQTHw7zE4gLJ56HXapjkAV8wvGJVvhoxcX0Dea9VUhXw/GSKKTY+iTopDHycdG
	 ycj/ZSEb3W7rg==
Date: Fri, 19 Apr 2024 18:01:28 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 17/18] bpf: add bpf_wq_start
Message-ID: <tvdzaaicdnxri24e56yfecdlonhbuji4cnovyshpqjlxjy57ob@gpp6cvyo32nt>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>
 <khz5omyjsd2iklm66bi3na4gdxw2cpwhb3c2xwu4fjxkaefi77@puck4pfltjgm>
 <b7akvvt67m7w6hdfq5vboojnzyjbntxrjioh6nuqziz4pzia3d@6x2le6iz6cor>
 <CAADnVQ+hPNQ3-fVj-5qt+UrT8yPavE9L7AaphsLLEKwve21P-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+hPNQ3-fVj-5qt+UrT8yPavE9L7AaphsLLEKwve21P-g@mail.gmail.com>

On Apr 19 2024, Alexei Starovoitov wrote:
> On Fri, Apr 19, 2024 at 8:14 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> >
> > Honestly I just felt the patch series was big enough for a PoC and
> > comparison with sleepable bpf_timer. But if we think this needs not to
> > be added, I guess that works too :)
> 
> It certainly did its job to compare the two and imo bpf_wq with kfunc approach
> looks cleaner overall and will be easier to extend in the long term.

Yeah. I agree. I'm also glad we pick the bpf_wq approach as I gave it a
lot more care :)

Talking about extending, I think I'll need delayed_work soon enough.
Most of the time when I receive an input event, the device is preventing
any communication with it, and with plain bpf_wq, it's likely that when
the code kicks in the device won't have processed the current input,
meaning to a useless retry. With delayed_works, I can schedule it
slightly later, and have a higher chance of not having to retry.

I've got a quick hack locally that I can submit once this series get
merged.

> 
> I mean that we'll be adding 3 kfuncs initially:
> bpf_wq_init, bpf_wq_start, bpf_wq_set_callback.
> 
> imo that's good enough to land it and get some exposure.

sounds good to me.

> I'll be using it right away to refactor bpf_arena_alloc.h into
> actual arena allocator for bpf progs that is not just a selftest.
> 
> I'm currently working on locks for bpf_arena.
> Kumar has a patch set that adds bpf_preempt_disble kfunc and
> coupled with bpf_wq we'll have all mechanisms to build
> arbitrary data structures/algorithms as bpf programs.

Oh. I did not realize that it was that needed for outside of my
playground. That's good to hear :)

Cheers,
Benjamin

