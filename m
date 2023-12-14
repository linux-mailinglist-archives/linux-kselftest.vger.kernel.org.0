Return-Path: <linux-kselftest+bounces-1959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802AA8139E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 19:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD686B218D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCD68B84;
	Thu, 14 Dec 2023 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LqG+BjVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bpbf0Ttm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923310A;
	Thu, 14 Dec 2023 10:23:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 022982B000CF;
	Thu, 14 Dec 2023 13:23:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 13:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702578186;
	 x=1702585386; bh=jO8QFkyxT8UnwR2dcix1epeyX1NgYymqMvBUkD8jyH4=; b=
	LqG+BjVVn4Z890upuU+L9WS2St9a3ZnojxXfbpRBnK7O9s2AS1bMbGNSKHeOT/1w
	SoCPQ+MBULtS7Es1+sV64ePILKocDVHsHh+rHbHd/2SpuFK9O3OLyRJMFKDWvgXM
	v7lAPyYZ1l96d6ljhskKAmvwnt8kLfo6etclrSfWLi+dtnBbVeCFjTS6+pvNNDWD
	ym391Yw+8+XG5bNc4vvQT5Rz/8mZ/iF3vlRrv/U14SshKjU/3UFHOQo6+3zLPXzA
	rDdlBXQTNg5Nx/z5fB+XqvNGGW/ZDsTZwvhH3/wHRfq2KpRcNichLdVp9e+EDQYL
	9cKCRRhJxfYQDGmZWpJHLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702578186; x=
	1702585386; bh=jO8QFkyxT8UnwR2dcix1epeyX1NgYymqMvBUkD8jyH4=; b=B
	pbf0Ttm/qZDdaZfK8by5DZs02Zn4xHoqby1dDmnF+SD1Fe9pC5JjQ0/gez6wgo/i
	fqqFihaMwY4HGlE6PyatQ9TPk4JzYHPtKJu4bjTMbL4XGMUM8yNHn7SQUmZAfRyY
	4DH/spKE2Ddh+5J29by+fhiVIitOzsBS4Q9dZUbVF2dm+WgYFaANjQnYBTxBXj6d
	EHvzAHb93C05ysNj/vymwaEfXmvXBrSqhR/MYkTeaIKMET1r8+sgUXvCXFdo0q7G
	YppJqaaz/gk1RDvoCk3h2ex7u0ZLOrMQmE0PxpQ5Pkte5LWXvKphKobRFAg5rd16
	58ww+AcHucbFNQsitTeKg==
X-ME-Sender: <xms:CUh7ZXluxcKsKKaJRLO-eL7CHVajHOVe3-SJpW8YU0XUXVeDN6D5Tg>
    <xme:CUh7Za3b0lzqga_v_Yu8H14V_ibdaIlFaRW22FvWXyqLlii6B8bUI5Gzo6kQGK2jn
    xZKAeGbgUnRc4WOtg>
X-ME-Received: <xmr:CUh7ZdpOAXiFqFBxOX81ivQmHkQUrh1nOQMDtgstUneRE0DMHvncLF1wnmuhydvzZwxqi-IE3JhDHPieZ13S-qId1vsyz5IY0ZLskhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:CUh7ZfnaQUe6SAmGWExXbx3L-NoWo8Nfytc1BIUvogDtWqKWDF_ysQ>
    <xmx:CUh7ZV22lYlqlf0yp219Uej1Z7r8hZF1i6jAdQ5emVc8mxroJbrSAg>
    <xmx:CUh7ZevPOFt-EhzSk7f_HzRs3b20z5o2kfUB5AiEDinq80uz1hhS1Q>
    <xmx:Ckh7ZWdRL25ZhskGJdEUsV97KpeqO1iTp-p8snaYoNjOKjX2qUXgmGh4Ebs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 13:23:03 -0500 (EST)
Date: Thu, 14 Dec 2023 11:23:02 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, daniel@iogearbox.net, 
	davem@davemloft.net, shuah@kernel.org, ast@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, andrii@kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <idbmj3y65mi7isezhlq4lip54bbngoouv5hbai2xd7bqtv7dxy@qjcmln2ovmz2>
References: <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
 <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
 <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
 <CAP01T76ZtehyRidmnV5A0p3LCyjw6Q4sjRH6ZhczgGn1ap-x_g@mail.gmail.com>
 <CAP01T74dKxYKM1GfTUJZ+G4+CKbRU=JLGoNcG6b8PMYcqUyEzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T74dKxYKM1GfTUJZ+G4+CKbRU=JLGoNcG6b8PMYcqUyEzQ@mail.gmail.com>

On Thu, Dec 14, 2023 at 05:16:08PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 14 Dec 2023 at 17:08, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Thu, 14 Dec 2023 at 00:49, Eyal Birger <eyal.birger@gmail.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 3:15 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > [...]
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > index c0dd38616562..f00dba85ac5d 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > @@ -8,8 +8,9 @@
> > > > > >   */
> > > > > >  #include "vmlinux.h"
> > > > > >  #include <bpf/bpf_core_read.h>
> > > > > > -#include <bpf/bpf_helpers.h>
> > > > > >  #include <bpf/bpf_endian.h>
> > > > > > +#include <bpf/bpf_helpers.h>
> > > > > > +#include "bpf_experimental.h"
> > > > > >  #include "bpf_kfuncs.h"
> > > > > >  #include "bpf_tracing_net.h"
> > > > > >
> > > > > > @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > >         opts.family = AF_INET;
> > > > > >
> > > > > >         x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > > > -       if (!x || opts.error)
> > > > > > +       if (!x)
> > > > > >                 goto out;
> > > > > > +       bpf_assert_with(opts.error == 0, XDP_PASS);
> > > > > >
> > > > > >         if (!x->replay_esn)
> > > > > >                 goto out;
> > > > > >
> > > > > > results in:
> > > > > >
> > > > > > 57: (b7) r1 = 2                       ; R1_w=2 refs=5
> > > > > > 58: (85) call bpf_throw#115436
> > > > > > calling kernel function bpf_throw is not allowed
> > > > > >
> > > > >
> > > > > I think this might be because bpf_throw is not registered for use by
> > > > > BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
> > > > > this program type as well, since it's already done for TC.
> > > >
> > > > Ah yeah, that was it.
> > > >
> > > > >
> > > > > > It looks like the above error comes from verifier.c:fetch_kfunc_meta,
> > > > > > but I can run the exceptions selftests just fine with the same bzImage.
> > > > > > So I'm thinking it's not a kfunc registration or BTF issue.
> > > > > >
> > > > > > Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
> > > > > >
> > > > >
> > > > > Yes, even once you enable this, this will fail for now. I am sending
> > > > > out a series later this week that enables bpf_throw with acquired
> > > > > references, but until then may I suggest the following:
> > > > >
> > > > > #define bpf_assert_if(cond) for (int ___i = 0, ___j = (cond); !(___j) \
> > > > > && !___j; bpf_throw(), ___i++)
> > > > >
> > > > > This will allow you to insert some cleanup code with an assertion.
> > > > > Then in my series, I will convert this temporary bpf_assert_if back to
> > > > > the normal bpf_assert.
> > > > >
> > > > > It would look like:
> > > > > bpf_assert_if(opts.error == 0) {
> > > > >   // Execute if assertion failed
> > > > >   bpf_xdp_xfrm_state_release(x);
> > > > > }
> > > > >
> > > > > Likewise for bpf_assert_with_if, you get the idea.
> > > >
> > > > I gave it a try and I'm getting this compile error:
> > > >
> > > >         progs/test_tunnel_kern.c:996:2: error: variable '___j' used in loop condition not modified in loop body [-Werror,-Wfor-loop-analysis]
> > > >                 bpf_assert_with_if(opts.error == 0, XDP_PASS) {
> > > >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >         /home/dxu/dev/linux/tools/testing/selftests/bpf/bpf_experimental.h:295:38: note: expanded from macro 'bpf_assert_with_if'
> > > >                 for (int ___i = 0, ___j = (cond); !(___j) && !___j; bpf_throw(value), ___i++)
> > > >                                                     ^~~~      ~~~~
> > > >         1 error generated.
> > > >         make: *** [Makefile:618: /home/dxu/dev/linux/tools/testing/selftests/bpf/test_tunnel_kern.bpf.o] Error 1
> > > >
> > > > Seems like the compiler is being clever.
> > >
> > > It looks like ___j is used twice - maybe it was meant to be ___i? i.e.:
> > >
> > >    for (int ___i = 0, ___j = (cond); !(___j) && !___i; bpf_throw(value), ___i++)
> > >
> >
> > Ah, yes, that's a typo. Eyal is right, it should be ___i.
> 
> Additionally, I would modify the macro to do ___j = !!(cond).

Makes sense. Will send out v6 with these fixes today.

