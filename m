Return-Path: <linux-kselftest+bounces-1000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6058018C3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C39281E23
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301563B;
	Sat,  2 Dec 2023 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fZaopnCG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Czlaiui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BA26B6;
	Fri,  1 Dec 2023 16:10:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 18A21580D31;
	Fri,  1 Dec 2023 19:10:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 19:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701475851; x=1701483051; bh=YupG7R41Yytt8vtYDqX//EZ/J14h7fjiRvB
	hKo5wcQ0=; b=fZaopnCGRFsBTf8Hf8AOl8dS/w0n3o4CUHSSJa0N2SSII79piEw
	ROinTnt/xawgSnY+5A63JsoYpZ5UgKW5rhtycmzuvUpZuIaVSunfX+gbRdJxTIcx
	ztPvFmJJT+Qajpbv0PtCNGfoW+YZh11Z4XKtd+Xkf3FwCNsvVtPOzT8Z9oHvdIa1
	PW9shyOVV39b8Gq7ZbNpce38C3HBgYIFTLhc9/WIR/7Bh3Jt4IlwvSsSiwAXQCFS
	W293uqB3Jy2OSurPVh3FUypdxO4L2t/JtpTxOZMaDIlXRgjaf99WrH0fvhRlL/yF
	Ln7a4rEe3fw96DwBWDuYAwxxscZSqK2aYbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701475851; x=1701483051; bh=YupG7R41Yytt8vtYDqX//EZ/J14h7fjiRvB
	hKo5wcQ0=; b=2CzlaiuiLR0lkj3BUwP/uUloOpxFEtS91d/oX9A/dpFzNYWY0FB
	zfwQcvIh4srIpIhsT1Z9YF3IGCpD/OUrWThtUFlDWLv40NRbdqaZGcMtqnIosCLl
	QoH2Lr4mIMrl5Tjx/ym72sJPBJ0JFLjyzI7hFizgF9Euwt5M5TQ7KVIAgJwYR72v
	s1R5DJbnvwLCUS3Or5hRuscL88TlLWTAn65sYe/tmxXXxDXtI98uc7tnJPkYJP3E
	WdZFpYUfDzXIkDGO7f4RRApT7K8ZCZ+kFKs3zMh9ZhrsJhDERRxaKvhOyb4iYLlI
	uRbL46vGkHjz0Srigbb99GeGsYZ5p1o2FcQ==
X-ME-Sender: <xms:CnZqZTH3dn-2jalmnSGbmQjsch_f-imxDnlNasDQsqXKyzDyFfCcEg>
    <xme:CnZqZQVi384DE91elHswzgec2aiRl96V5MFM_pDo5XEnsDrV2BtQ1Dl4Sd83DABHz
    ADQFWoWJKoeTatBNQ>
X-ME-Received: <xmr:CnZqZVKSKXEOAJBEqXMeG6V80TH8u-ZScIhRjEW8vC4U-1xRgFVG0kVKHAtYqm-hvlIH12bDXepmZ3iuTobMXBEtGH3cRWHZcfNcSaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:CnZqZRFlpMwEeeHjn5XyQ9EQnVNTUR9WKU8iTyknxLyvglrDj4IMrw>
    <xmx:CnZqZZUSvPqdil_mXkVluKaG7vF30j_yMsudLiuZGIlWpTKNcqquIg>
    <xmx:CnZqZcNjCJMaBSDwG2Gl8sgsGddVaSwDWufffWPmAVZMqNcYwwl77g>
    <xmx:C3ZqZed3Q_SKSY7VAgfmWuajzpeKI9MiuYemQsM8VLrG91CoRHkLkw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 19:10:49 -0500 (EST)
Date: Fri, 1 Dec 2023 17:10:47 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org, 
	andrii@kernel.org, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v3 5/9] libbpf: selftests: Add verifier tests
 for CO-RE bitfield writes
Message-ID: <ka2irjz53qjkax545o67mvouyytzqw3dvorqixe2q72crgzjpi@he2uiobuelvd>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
 <e4d14fb5f07145ff4a367cc01d8dcf6c82581c88.1701462010.git.dxu@dxuuu.xyz>
 <CAEf4Bzaz+_y=kxBpPmwYsvzaHypmL=ZBfOK12vLom04DRDWyPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzaz+_y=kxBpPmwYsvzaHypmL=ZBfOK12vLom04DRDWyPg@mail.gmail.com>

Hi Andrii,

On Fri, Dec 01, 2023 at 03:52:25PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 1, 2023 at 12:24 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> > non-trivial bit fiddling is going on, make sure various edge cases (such
> > as adjacent bitfields and bitfields at the edge of structs) are
> > exercised.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++++++++++++
> >  2 files changed, 102 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
> >
> 
> LGTM, but I'm not sure why we need all those __failure_unpriv, see
> below. Regardless:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index 5cfa7a6316b6..67b4948865a3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -6,6 +6,7 @@
> >  #include "verifier_and.skel.h"
> >  #include "verifier_array_access.skel.h"
> >  #include "verifier_basic_stack.skel.h"
> > +#include "verifier_bitfield_write.skel.h"
> >  #include "verifier_bounds.skel.h"
> >  #include "verifier_bounds_deduction.skel.h"
> >  #include "verifier_bounds_deduction_non_const.skel.h"
> > @@ -115,6 +116,7 @@ static void run_tests_aux(const char *skel_name,
> >
> >  void test_verifier_and(void)                  { RUN(verifier_and); }
> >  void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
> > +void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
> >  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
> >  void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
> >  void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
> > new file mode 100644
> > index 000000000000..8fe355a19ba6
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bitfield_write.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <stdint.h>
> > +
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_core_read.h>
> > +
> > +#include "bpf_misc.h"
> > +
> > +struct core_reloc_bitfields {
> > +       /* unsigned bitfields */
> > +       uint8_t         ub1: 1;
> > +       uint8_t         ub2: 2;
> > +       uint32_t        ub7: 7;
> > +       /* signed bitfields */
> > +       int8_t          sb4: 4;
> > +       int32_t         sb20: 20;
> > +       /* non-bitfields */
> > +       uint32_t        u32;
> > +       int32_t         s32;
> > +} __attribute__((preserve_access_index));
> > +
> > +SEC("tc")
> > +__description("single CO-RE bitfield roundtrip")
> > +__btf_path("btf__core_reloc_bitfields.bpf.o")
> > +__success __failure_unpriv
> 
> do we want __failure_unpriv at all? Is this failure related to
> *bitfield* logic at all?

Oh, I pre-emptively added it. From the docs, I thought __failure_unpriv
meant "don't try to load this as an unprivileged used cuz it'll fail".
And since I used the tc hook, I figured it'd fail.

Removing the annotation doesn't seem to do anything bad so I'll drop it
for v4.

[...]

Thanks,
Daniel

