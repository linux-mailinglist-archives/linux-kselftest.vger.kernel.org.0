Return-Path: <linux-kselftest+bounces-17656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC083974486
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370D62824D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CFC1A7AEE;
	Tue, 10 Sep 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NKcEUcgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5b14eWp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359A17622D;
	Tue, 10 Sep 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002460; cv=none; b=GPLGm/5mH9y+l3GnRWLT5QbmxC//q2lRxYQQBj5r/0NBd5MFHuOVd5zXx0KibcUWYgxLsDtgZNuLBcc9fXKNjQ/m+oluHVep5S/Ou2UqFnW6hOyj0ntShT1xJWelDM3yVxWEOMU7pjNIvrGsXh5QmuG2KXLxq1NNGet9/7PKU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002460; c=relaxed/simple;
	bh=hZFJbd/8+nyhB2YzrMCHW+UhaWzsPRQ/R/aTHVJ7V8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG5pp051QzLkxSK04Z3lBSaqjF6sYwv14ZomxMpfmZqOizi0cg7MgRTCEierW9r0bFs1R96f+1NHkFGSrGolWYvkT5hlGiLKXCU3y/qo59zX/sj/Qs/ArAI5/2Et5Wx8LnJw3RDRTavTsTyvgACrF64jLPVG0FOzUYRyIpc5U6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NKcEUcgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5b14eWp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4FB111400B0;
	Tue, 10 Sep 2024 17:07:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 17:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726002449;
	 x=1726088849; bh=TkNWhENOyhhpEk3zhiKLTed65bX4Z8sXkyAVOU+7z7M=; b=
	NKcEUcgglDIRxvqaw+Iczadqs8+I9Hr8RnS6nWNmzPg9rvYVyJvdhuHLQvOBZVSa
	OUiK7/TM451GcVDT7+xnITd170f10XRgFNUpAsSYyBmQ/AokiIhcX/csxhfCqIlj
	YwY/18IL6FpCYhvJH7evlnM5EgHEYVUB59583Xe7HTpdd6Zy30Y4XIZP64zFDs+u
	QH6uCQkEtu2pE0OHhoJjk0xOJXCQXL8XtgaXCA8sR2LLeq3neTbvhHsYjw475YR6
	lbv5sHrmMHhdxCw13RbalFnlOVxFGcUW59NxMrFvPMjXsXkJ365Ahuo+xTCWHL7Y
	X/cPIhMFDYb68hz9G3hixQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726002449; x=
	1726088849; bh=TkNWhENOyhhpEk3zhiKLTed65bX4Z8sXkyAVOU+7z7M=; b=i
	5b14eWpEa65rwqAgaaB+QP4x8RyumRPku/tIWSqREl1VzzV8lsc6ifzSz4tJyHCj
	b3dKIJVzssE1apnfunXwLul8Tz7QCz4aTeE0ARS/5gYG4m2RSiWYmuun6b1BlL68
	PbgAJsQKccaSY6UQjRKxmGJfywfPiqyRFI2NFh98QkfKRKOghxZV6G8NrgJiVNc6
	x2dRjhzFSRSAEU9NYS+JkT4+5JHEjRYg2QK4qOYtSUskRB5eiLjikPLZglnsA8kd
	IHz5SvfC0oOQ31zHp0kgsi5s6aIaDHP339nqn8MpUQmmCY2HTxEpwyKD7xp69fI/
	bJ2SxxN0Dxftv9ZSCmzsg==
X-ME-Sender: <xms:EbXgZp-_ryDr225alWc8euev-lVcxOD3DfbM-tOwSOqGWcna9k3BNw>
    <xme:EbXgZtuMh6HqY_KGjXr6GHtnAa8_8XJnV91HOa7ryavk7PzcXNg0Sq-c1-tWvekUA
    Aa4WYB3hfGzqoQc0g>
X-ME-Received: <xmr:EbXgZnATiErcxZUhLQOvWl1gEkyJCB_ZqvkN9JvscrHVx2_ZPK-NP9VZNFRPjVuGL1eBn-d98KRrZxZ6cGBwHMOblyf4OivgpU7JO_0USX3AYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueek
    ffelteekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhhiih
    drnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigvghirdhs
    thgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekje
    esghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:EbXgZtdSik0MzBa99ZVHcBI0GfcLKM85xIhL9SFgOf3iUGBFbDdkHQ>
    <xmx:EbXgZuMzylYPx2koruqokmlGuPpulkqsFVQsb7NGLNzdbUNQLr7IMg>
    <xmx:EbXgZvml4M6QHVzzKPpNYulXdueXsJ3xAN2xhAQL7T8v_hj17mk4hQ>
    <xmx:EbXgZovy7Uz-cNdIYDvG-gdsauyJc6oAyY8y36kCsqpzhUCmcZxxtQ>
    <xmx:EbXgZquqMMOW5pEZmDFCp4KOZnexnESXWYkp9xE3UeADMfX5J1tzOMqj>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 17:07:26 -0400 (EDT)
Date: Tue, 10 Sep 2024 15:07:24 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
Message-ID: <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>

On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> On Tue, Sep 10, 2024 at 11:36 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 5:55 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > Right now there exists prog produce / userspace consume and userspace
> > > produce / prog consume support. But it is also useful to have prog
> > > produce / prog consume.
> > >
> > > For example, we want to track the latency overhead of cpumap in
> > > production. Since we need to store enqueue timestamps somewhere and
> > > cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BPF
> > > ringbuf is such a data structure. Rather than reimplement (possibly
> > > poorly) a custom ringbuffer in BPF, extend the existing interface to
> > > allow the final quadrant of ringbuf usecases to be filled. Note we
> > > ignore userspace to userspace use case - there is no need to involve
> > > kernel for that.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  kernel/bpf/verifier.c                         |  6 +-
> > >  tools/testing/selftests/bpf/Makefile          |  3 +-
> > >  .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
> > >  .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++++++
> > >  4 files changed, 120 insertions(+), 3 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 53d0556fbbf3..56bfe559f228 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
> > >                     func_id != BPF_FUNC_ringbuf_query &&
> > >                     func_id != BPF_FUNC_ringbuf_reserve_dynptr &&
> > >                     func_id != BPF_FUNC_ringbuf_submit_dynptr &&
> > > -                   func_id != BPF_FUNC_ringbuf_discard_dynptr)
> > > +                   func_id != BPF_FUNC_ringbuf_discard_dynptr &&
> > > +                   func_id != BPF_FUNC_user_ringbuf_drain)
> > >                         goto error;
> > >                 break;
> > >         case BPF_MAP_TYPE_USER_RINGBUF:
> > > @@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
> > >                         goto error;
> > >                 break;
> > >         case BPF_FUNC_user_ringbuf_drain:
> > > -               if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
> > > +               if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF &&
> > > +                   map->map_type != BPF_MAP_TYPE_RINGBUF)
> > >                         goto error;
> >
> > I think it should work.
> >
> > Andrii,
> >
> > do you see any issues with such use?
> >
> 
> Not from a quick glance. Both ringbufs have the same memory layout, so
> user_ringbuf_drain() should probably work fine for normal BPF ringbuf
> (and either way bpf_user_ringbuf_drain() has to protect from malicious
> user space, so its code is pretty unassuming).
> 
> We should make it very explicit, though, that the user is responsible
> for making sure that bpf_user_ringbuf_drain() will not be called
> simultaneously in two threads, kernel or user space.

I see an atomic_try_cmpxchg() protecting the drain. So it should be
safe, right? What are they supposed to expect?

> 
> Also, Daniel, can you please make sure that dynptr we return for each
> sample is read-only? We shouldn't let consumer BPF program ability to
> corrupt ringbuf record headers (accidentally or otherwise).

Sure.

> 
> And as a thought exercise. I wonder what would it take to have an
> open-coded iterator returning these read-only dynptrs for each
> consumed record? Maybe we already have all the pieces together. So
> consider looking into that as well.
> 
> P.S. And yeah "user_" part in helper name is kind of unfortunate given
> it will work for both ringbufs. Can/should we add some sort of alias
> for this helper so it can be used with both bpf_user_ringbuf_drain()
> and bpf_ringbuf_drain() names?

You mean register a new helper that shares the impl? Easy enough, but I
thought we didn't want to add more uapi helpers.

Thanks,
Daniel

