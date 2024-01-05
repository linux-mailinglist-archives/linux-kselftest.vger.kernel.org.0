Return-Path: <linux-kselftest+bounces-2646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B37824C70
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 02:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1961C21FEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273281854;
	Fri,  5 Jan 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="CChYtD/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1wh6oQWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4020EE;
	Fri,  5 Jan 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id C93FE2B003E7;
	Thu,  4 Jan 2024 20:17:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 20:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704417477; x=1704424677; bh=52XpvHOHlL
	252gSJofKsvelo6vnSoD2F1sW3aqDiEc8=; b=CChYtD/qnwH77ERKCPSM4z8LRz
	+8OB5rRXpI1jXkdcTzfUhf1Z2sPC4AqY0+RERDIf2sl3Zpi9c1QF6Xiv/KgdqX0M
	2/4NQXFRVGnYbZiLpVrsXl7YmtORxrP/88PjCtbL6T6YwPu1rFfRMZeBFJWLG2FY
	WqrTwekcbM1qEtYsR+iYhMeQ6SvH1Rro+ZVTCRC0rYc7OoD8jn8kA1kt7GZMHNz3
	QDYkR0qxGQ1TjCzL9pTIyb8ctnFn5GhbX6W+WinGlhwZKeCHm4F2IYicjwD+MjgG
	zvvOvdT6yPMGipIjboVEExpht1uwx3I7yqe3ayjPzBhYF6C+y0HP6ZGs0fmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704417477; x=1704424677; bh=52XpvHOHlL252gSJofKsvelo6vnS
	oD2F1sW3aqDiEc8=; b=1wh6oQWvPt1AjiN1FW4IOBsDfmPMjEe2uVSRt45VvcLx
	6arPsk+rG0ahJF5ZOshlyrLEVyGX8KMp7Oe0jXW3hf8kYMfIEnjsShlyx/u0CqK4
	737ZUsPlqRAPfLSZPFR9vykLMgc0cCtPNGLJDkVBN4vIYasROEgKueRRnco/dccH
	xJ3wmQ4Z0jvKgf7kgi05FaevaxEhaX0ZPaWDV83c6kcCj74FZxcDnE9ayu7Age81
	NRBDbIFKe2ZvYJ5r17sOZyZt2VlRQXK6IB3XbP45nFfhqRHWzoukfojoh+2pESAT
	qAGyQhz5LGqoFDDdmxrgGFDYL1DzCRCpCpvAmZsCgw==
X-ME-Sender: <xms:w1iXZQeEttVwQM-R3vZQ4HEjdhQF8hyO7f9OrnH9ps-4RUFAyFNadA>
    <xme:w1iXZSOdvgmukBfCLvnRq5Xg5haJd1OgRKXSfigHFW7s4Rw7ynpqk2gxpF6-KrfjS
    ijQztVtgADbulmSfA>
X-ME-Received: <xmr:w1iXZRiy-pRLAYn_AVW4HSknB1nhIhypI5MJiNwI9g-82JPkTCoc_GvA9XVRbCJHoWz-tgs2R5GiH5_QEG9l_V4ZF9c_AaalFlS01D0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:w1iXZV_Qwu2WMv8EByq9LGS-5hmqZHx9ygDd2aljTvrIsaOKol8JfA>
    <xmx:w1iXZcvW__hoVurNrGi43dnwCeDE9JeyPI-BSJ2hLh8RkOSfceIVCg>
    <xmx:w1iXZcFy822a46qBXxBSbllHxXuD7J9sfzqyTvxU-Cd6wTNwSzBIdA>
    <xmx:xViXZcXkc8ccHN_ZxMaNCS-R59zdNxS6LVIE_-jcTZggLP8pSgMpknUwrXM>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 20:17:52 -0500 (EST)
Date: Thu, 4 Jan 2024 18:17:50 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: benjamin.tissoires@redhat.com, hawk@kernel.org, edumazet@google.com,
 	alexandre.torgue@foss.st.com, ebiggers@kernel.org, tj@kernel.org,
 rostedt@goodmis.org, 	shuah@kernel.org, martin.lau@linux.dev,
 ast@kernel.org, fw@strlen.de, 	kuba@kernel.org, pablo@netfilter.org,
 jikos@kernel.org, john.fastabend@gmail.com, 	mcoquelin.stm32@gmail.com,
 mhiramat@kernel.org, yonghong.song@linux.dev,
 	Herbert Xu <herbert@gondor.apana.org.au>, dsahern@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, 	pabeni@redhat.com,
 steffen.klassert@secunet.com, daniel@iogearbox.net, 	tytso@mit.edu,
 andrii@kernel.org, davem@davemloft.net, kadlec@netfilter.org,
 	song@kernel.org, alexei.starovoitov@gmail.com, quentin@isovalent.com,
 	alan.maguire@oracle.com, memxor@gmail.com, kpsingh@kernel.org,
 sdf@google.com, 	haoluo@google.com, mathieu.desnoyers@efficios.com,
 mykolal@fb.com, 	linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, fsverity@lists.linux.dev,
 	bpf@vger.kernel.org, cgroups@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 	linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next 2/2] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <bix2uwya2mnk2vgno3vkdpg5kyusq763bmfj2ov6zwpbva6q4h@nqgm3vk4byh5>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
 <68d5598e5708dfe3370406cd5c946565ca4b50f1.1704324602.git.dxu@dxuuu.xyz>
 <ZZaZf_8RuX2xqZGf@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZaZf_8RuX2xqZGf@krava>

Hi Jiri, 

On Thu, Jan 04, 2024 at 12:41:51PM +0100, Jiri Olsa wrote:
> On Wed, Jan 03, 2024 at 04:31:56PM -0700, Daniel Xu wrote:
> 
> SNIP
> 
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index 88f914579fa1..771e29762a2d 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -8,6 +8,9 @@ struct btf_id_set {
> >  	u32 ids[];
> >  };
> >  
> > +/* This flag implies BTF_SET8 holds kfunc(s) */
> > +#define BTF_SET8_KFUNC		(1 << 0)
> > +
> >  struct btf_id_set8 {
> >  	u32 cnt;
> >  	u32 flags;
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 51e8b4bee0c8..b8ba00a4179f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7769,6 +7769,9 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
> >  	struct btf *btf;
> >  	int ret, i;
> >  
> > +	/* All kfuncs need to be tagged as such in BTF */
> > +	WARN_ON(!(kset->set->flags & BTF_SET8_KFUNC));
> 
> __register_btf_kfunc_id_set gets called also from the 'hooks' path:
> 
>   bpf_mptcp_kfunc_init
>     register_btf_fmodret_id_set
>       __register_btf_kfunc_id_set
> 
> so it will hit the warn.. it should be probably in the register_btf_kfunc_id_set ?

Yeah, good catch.

> 
> also given that we can have modules calling register_btf_kfunc_id_set,
> should we just return error instead of the warn?

It looks like quite a few registrations go through late_initcall(),
in which error codes are thrown away. I'm looking at
init/main.c:do_initcall_level:

        for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
                do_one_initcall(initcall_from_entry(fn));

Higher level question: if out of tree module does not follow convention,
it would still make sense to WARN(), right?

> 
> SNIP
> 
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 91907b321f91..32972334cd50 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -341,7 +341,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
> >  	.write = bpf_testmod_test_write,
> >  };
> >  
> > -BTF_SET8_START(bpf_testmod_common_kfunc_ids)
> > +BTF_SET8_START(bpf_testmod_common_kfunc_ids, BTF_SET8_KFUNC)
> >  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
> 
> we need to change also bpf_testmod_check_kfunc_ids set

Good catch, thanks.

Daniel

