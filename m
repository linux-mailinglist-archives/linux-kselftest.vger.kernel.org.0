Return-Path: <linux-kselftest+bounces-6531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DE88A562
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 15:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65ADB3AEBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CEB43AAA;
	Mon, 25 Mar 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfEEXMXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF935D480;
	Mon, 25 Mar 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356135; cv=none; b=RrCgoxYDhlaPL6nBDR5hgvV4vv+vzZLb6cDdXaOi+0twLo4aUJS+sMjuzKVsFBubAiK+rcvh/W3Lchp6DqGpH545T2yNSe9FJql5SBF/N+T0RG3tvwievzuCfxIzmTy+c3sm76avCsTVIH/1vrCyMBQKj1yF+7E+V5Z8SaaiQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356135; c=relaxed/simple;
	bh=T7/juRgI0RYFtzJn/DyHvQa9WLQrkIas1WYOJnYYG/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJxJw8xvcZqADK+Tlv0zLGYX3dQapeTmMuM7if//SaTrn9gJGh8Otee/Pjn5d3Q2EZYJidNQi0ZTFARsq9iQAS+QUHlk+80Szz3U+7NkpIJ5ep8oPEM7t+/B9pGZjjb8bC95PXCBTc+Agmxdy1wreYWwBIQp4knDrF+jqS6JI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfEEXMXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA01C433C7;
	Mon, 25 Mar 2024 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711356134;
	bh=T7/juRgI0RYFtzJn/DyHvQa9WLQrkIas1WYOJnYYG/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfEEXMXPQow2DoAAD+t7eJCuk4c9KnusX05DCDf/bK+Nsu9UZiyZMvIsYXE52+zFu
	 KlHld6yGaNSlSguP2KQbDDys8fL2gpBBgI2xNpC1TKZH2vNI7ZrV6gFO3jJmUpKTVV
	 0eybsTG8SXWefeh2wcX7GWYoJIdFp02eoCXg7vP93hRiwVrbFJ1foJ/kVfQ0zjwv0R
	 nFKFxwkjHp/n4b1LUn9VVAa3vSKEwV8ikcInYf/MkCj83ZWEujBFarXtj5Spt/6sdN
	 DrJ3+iAV9yQERO05dHT1MvIPtELUxVciEO46Xtp0oqfuDXzUjdM4lecGJHF+tuGL/K
	 Whcm8N3ppdtmw==
Date: Mon, 25 Mar 2024 09:42:08 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
Message-ID: <d3qeziyeiqfdofuzj266r47g4jpno56jd4dy2wgnm4h7z6fhmu@sltzwlkwj4z5>
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org>
 <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
 <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
 <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com>
 <CAADnVQ+5mSEW-LJwS30hED1cJeHOhqfCTKdBzYCcRd8EiVNvtA@mail.gmail.com>
 <CAP01T757ddmmFR+Cnj70DrTLFcEu+9uAcbscrO-uOmSVGB8eJA@mail.gmail.com>
 <CAADnVQK=aAcNt-8BBJNnp3QGkxVWLYhZ9=9dizo-7eQosjNtow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK=aAcNt-8BBJNnp3QGkxVWLYhZ9=9dizo-7eQosjNtow@mail.gmail.com>

On Mar 24 2024, Alexei Starovoitov wrote:
> On Sat, Mar 23, 2024 at 9:57 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> 
> > > > >
> > > > > Observation is correct. The patch is buggy,
> > > > > but the suggestion to follow process_dynptr_func() will lead
> > > > > to unnecessary complexity.
> > > > > dynptr-s are on stack with plenty of extra checks.
> > > >
> > > > The suggestion was to call process_timer_func, not process_dynptr_func.
> > > >
> > > > > In this case bpf_timer is in map_value.
> > > > > Much simpler is to follow KF_ARG_PTR_TO_MAP approach.
> > > >
> > > > What I meant by the example was that dynptr handling does the same
> > > > thing for kfuncs and helpers (using the same function), so timer
> > > > arguments should do the same (i.e. use process_timer_func), which will
> > > > do all checks for constant offset (ensuring var_off is tnum_is_const)
> > > > and match it against btf_record->timer_off.
> > >
> > > I don't follow. Please elaborate with a patch.
> > > The var_off and off is a part of the bug, but it's not the biggest part of it.
> >
> > Not compile tested.

Compiles just fine :)

> 
> I see. All makes sense to me.
> 
> Benjamin,
> pls incorporate it in your set.
> 

OK, done!

I just had to revert to the following or KF_ARG_TIMER_ID was not
recognized by the verifier:

---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7ee20e9d14bd..a5e147468ac8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10848,7 +10848,7 @@ BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
-BTF_ID(struct, bpf_timer)
+BTF_ID(struct, bpf_timer_kern)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
---

Cheers,
Benjamin


