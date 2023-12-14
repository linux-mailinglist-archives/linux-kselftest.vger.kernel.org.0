Return-Path: <linux-kselftest+bounces-1965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE23813B76
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3141C20748
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0396A335;
	Thu, 14 Dec 2023 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XssIEsre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7nuOxai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AC675CD;
	Thu, 14 Dec 2023 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 346A72B007D8;
	Thu, 14 Dec 2023 15:24:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 15:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702585495;
	 x=1702592695; bh=+t4pVgVSi2R2QRypiJjLIGqmBMSDOZdJg7dHN9HfN3g=; b=
	XssIEsreV4K1heTY+91HoJX52cZPmrrpOYEqSO83jF/mx/4N9g6qLaN67bxVdlrM
	gbQLIWXkwxqDkExCf8o5OMz2J8aWyy3eOgm1UZAbT3sEUzWeIg63AmOvo1mD+Ef8
	YaraA/fKVPL8YZWtMa3YKKNttWkdo6wQ7aXGywwsf7iOpRyH7G9U+PPe5vvu6GHq
	irs0SMewZVr0KKLtdNWRV4ZGRD7QdMLFXE+Ih3ziDTtiJW+RaByNl4dKIcV8DRkF
	rt77Mf8rw/d4C0CYFA1x/ugMUTFQoJJcv+AwFFJyP5dy8MUL/Wp1wvxPwkP9jTlK
	cmq89oQMUShG6CPmvnovEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702585495; x=
	1702592695; bh=+t4pVgVSi2R2QRypiJjLIGqmBMSDOZdJg7dHN9HfN3g=; b=n
	7nuOxaiJegwukTTbdEOHgVrsaojYuvEbAZGMkrWLg+wxWGYwt2jmpak/zFoaI8Ei
	Q9lqu2AD6MNZictbUqPH+/xqEex2VCRCAdbn7vbdeOwdo7Fl1VzXi932RL0xSw/L
	xfa0lSqusL8YeIxoJ59m8H7fkOjd2gF4bHd+syamQJxseVcjrVbCANtuRLUBx1yR
	tRDqKMyZg0APRmKHsmDleWuV0JbfVq2XsgYJGzLJlEZpuQqvF1AV9SZYkBR2Vd2W
	PWnLCQUIHPOEVCkLIEjHCbMXEsSpc/c3ZaTso/55ETAE7/HG7ZfKiq9ii49VIZi0
	ejkPVVzP93VFmU0MJviig==
X-ME-Sender: <xms:l2R7ZVgsl6HJ6-vzvv9P299qixo0hDZrWux9ZFimb8nmjaEl6oHZOA>
    <xme:l2R7ZaANSxi_Q1vKDkiWuou3LW3xVmvcbENZkWL3kNQjgwW92mwO7we1A0nBwrM4t
    HbEamfBpngp50acQA>
X-ME-Received: <xmr:l2R7ZVHlEg1prvGc6mN8Z4u_fhGuBIQTPhNS8M2GbWBsQYd1oTr2yHhMurLis6YKooJCxbJ9yGLDOO-FkYRKGjcRfVmBcHERfhGCrow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:l2R7ZaTVoXTmId-GbkkIGRmhGaWXuWPcdD6_C5r1Hu-yzcXnl0jhyw>
    <xmx:l2R7ZSwTTXZWGTwF7ArpmKY8WpeTsSmOHWfQXQhpPo7r_Me01b5Mfw>
    <xmx:l2R7ZQ5OgfOSnYuoe3ksj1o7Dd0JMpmbtHTQ9R-kK5Ffh5jHP019EA>
    <xmx:l2R7ZZL9cMn54QLmQHESJvSRjlZCbZr3vUZp3PiG4iUFJ6V_iIAg_jwyLRs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 15:24:53 -0500 (EST)
Date: Thu, 14 Dec 2023 13:24:51 -0700
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
Message-ID: <i6kxylvo5hcttmjmhpjrmwdaxe4bi6cggk32js72ivr7qelknc@qnjkmr3df3b5>
References: <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
 <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
 <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
 <CAP01T76ZtehyRidmnV5A0p3LCyjw6Q4sjRH6ZhczgGn1ap-x_g@mail.gmail.com>
 <CAP01T74dKxYKM1GfTUJZ+G4+CKbRU=JLGoNcG6b8PMYcqUyEzQ@mail.gmail.com>
 <idbmj3y65mi7isezhlq4lip54bbngoouv5hbai2xd7bqtv7dxy@qjcmln2ovmz2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <idbmj3y65mi7isezhlq4lip54bbngoouv5hbai2xd7bqtv7dxy@qjcmln2ovmz2>

On Thu, Dec 14, 2023 at 11:23:02AM -0700, Daniel Xu wrote:
> On Thu, Dec 14, 2023 at 05:16:08PM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 14 Dec 2023 at 17:08, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Thu, 14 Dec 2023 at 00:49, Eyal Birger <eyal.birger@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 3:15 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > > [...]
> > > > > > >
> > > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > index c0dd38616562..f00dba85ac5d 100644
> > > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > > @@ -8,8 +8,9 @@
> > > > > > >   */
> > > > > > >  #include "vmlinux.h"
> > > > > > >  #include <bpf/bpf_core_read.h>
> > > > > > > -#include <bpf/bpf_helpers.h>
> > > > > > >  #include <bpf/bpf_endian.h>
> > > > > > > +#include <bpf/bpf_helpers.h>
> > > > > > > +#include "bpf_experimental.h"
> > > > > > >  #include "bpf_kfuncs.h"
> > > > > > >  #include "bpf_tracing_net.h"
> > > > > > >
> > > > > > > @@ -988,8 +989,9 @@ int xfrm_get_state_xdp(struct xdp_md *xdp)
> > > > > > >         opts.family = AF_INET;
> > > > > > >
> > > > > > >         x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
> > > > > > > -       if (!x || opts.error)
> > > > > > > +       if (!x)
> > > > > > >                 goto out;
> > > > > > > +       bpf_assert_with(opts.error == 0, XDP_PASS);
> > > > > > >
> > > > > > >         if (!x->replay_esn)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > results in:
> > > > > > >
> > > > > > > 57: (b7) r1 = 2                       ; R1_w=2 refs=5
> > > > > > > 58: (85) call bpf_throw#115436
> > > > > > > calling kernel function bpf_throw is not allowed
> > > > > > >
> > > > > >
> > > > > > I think this might be because bpf_throw is not registered for use by
> > > > > > BPF_PROG_TYPE_XDP. I would simply register the generic_kfunc_set for
> > > > > > this program type as well, since it's already done for TC.
> > > > >
> > > > > Ah yeah, that was it.
> > > > >
> > > > > >
> > > > > > > It looks like the above error comes from verifier.c:fetch_kfunc_meta,
> > > > > > > but I can run the exceptions selftests just fine with the same bzImage.
> > > > > > > So I'm thinking it's not a kfunc registration or BTF issue.
> > > > > > >
> > > > > > > Maybe it's cuz I'm holding onto KFUNC_ACQUIRE'd `x`? Not sure.
> > > > > > >
> > > > > >
> > > > > > Yes, even once you enable this, this will fail for now. I am sending
> > > > > > out a series later this week that enables bpf_throw with acquired
> > > > > > references, but until then may I suggest the following:
> > > > > >
> > > > > > #define bpf_assert_if(cond) for (int ___i = 0, ___j = (cond); !(___j) \
> > > > > > && !___j; bpf_throw(), ___i++)
> > > > > >
> > > > > > This will allow you to insert some cleanup code with an assertion.
> > > > > > Then in my series, I will convert this temporary bpf_assert_if back to
> > > > > > the normal bpf_assert.
> > > > > >
> > > > > > It would look like:
> > > > > > bpf_assert_if(opts.error == 0) {
> > > > > >   // Execute if assertion failed
> > > > > >   bpf_xdp_xfrm_state_release(x);
> > > > > > }
> > > > > >
> > > > > > Likewise for bpf_assert_with_if, you get the idea.
> > > > >
> > > > > I gave it a try and I'm getting this compile error:
> > > > >
> > > > >         progs/test_tunnel_kern.c:996:2: error: variable '___j' used in loop condition not modified in loop body [-Werror,-Wfor-loop-analysis]
> > > > >                 bpf_assert_with_if(opts.error == 0, XDP_PASS) {
> > > > >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >         /home/dxu/dev/linux/tools/testing/selftests/bpf/bpf_experimental.h:295:38: note: expanded from macro 'bpf_assert_with_if'
> > > > >                 for (int ___i = 0, ___j = (cond); !(___j) && !___j; bpf_throw(value), ___i++)
> > > > >                                                     ^~~~      ~~~~
> > > > >         1 error generated.
> > > > >         make: *** [Makefile:618: /home/dxu/dev/linux/tools/testing/selftests/bpf/test_tunnel_kern.bpf.o] Error 1
> > > > >
> > > > > Seems like the compiler is being clever.
> > > >
> > > > It looks like ___j is used twice - maybe it was meant to be ___i? i.e.:
> > > >
> > > >    for (int ___i = 0, ___j = (cond); !(___j) && !___i; bpf_throw(value), ___i++)
> > > >
> > >
> > > Ah, yes, that's a typo. Eyal is right, it should be ___i.
> > 
> > Additionally, I would modify the macro to do ___j = !!(cond).
> 
> Makes sense. Will send out v6 with these fixes today.
> 

Looks like only x86 supports exceptions (looking at
bpf_jit_supports_exceptions()).

This causes selftests in this patchset to fail on !x86, which is
unfortunate. We probably want to be running these tests on all the major
archs, so I will drop the assertion patches from this patchset.

But since they're generally useful and I've already written the
selftests for it, I could put them up in another patchset? Or maybe not
cuz you're gonna fix it later anyways. WDYT?

Thanks,
Daniel

