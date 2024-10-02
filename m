Return-Path: <linux-kselftest+bounces-18859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0398C9EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 02:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EA02841CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C04391;
	Wed,  2 Oct 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="W+9z86p7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFCXA7ey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30B621;
	Wed,  2 Oct 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827911; cv=none; b=dr7PIR9gTSNpPgqkbtZBIkvrtFQkKYxtHxPJuV2fOWyV087Njd9fyikmdUCgur29q+1EUGI5TDSnqxHGvvAF+H/1cRBiaB1ik/ehYet5ER739gib1BiUOcnHZyXUMk7Fk7sffl5fchfbgO2mOTrZ5rOimXElXde9bFB/41zVR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827911; c=relaxed/simple;
	bh=Ib91Ew06f6fYUzXIg9LcsQQxRq577BMw+4swT97DzdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O4JtXx5fYZEz7OIqEahNm6unnUvKVkxLNaL7BlklVFKshFNGHOo7FgPU05bNTb0PjA50Kp8jai0AFKJNAOVaqQlwj2WouxHdZqMa8qpV2HahQ7VOJpF9ihGWs5I/y4LL2t9kyD0oTCLsHOdWFBJbj69inzLVVMIzSPwBcs4UeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=W+9z86p7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFCXA7ey; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 507711140315;
	Tue,  1 Oct 2024 20:11:49 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 01 Oct 2024 20:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727827909;
	 x=1727914309; bh=2SF2F6iaMaGHalWghdSaYZetoBsT1QBxYybwXSYCObQ=; b=
	W+9z86p7/KnuUS/m6uuFq+bPSPq94vgT/mY8risGAkxVAVPrBB41+nXQTjW7S7H2
	ainn1NHDl8BIAg4VAiEJk8R46Y98GpLi9K1iwEmUOJ4n0GKanyPKIH9TuxB+5vKt
	eNuFEiFJDBA5ALHMi3awlT7NkJWhg0Q24iCYYhtRSd1eWsYYo2tNk36KBPNFaCw2
	FZt/YYnmm+AY4kQBVLzvNK15C05REHDbyCtYkEco74NfAUbDzGhGayKhYkhB8yLj
	ScccHZuerrrAvfUtwQCJvy+oK4j33XK2nPkqtnQwg2B+rd75+gDbBOXmhAcHt+L1
	5avYhR0ABPMtwye0h8yp1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727827909; x=
	1727914309; bh=2SF2F6iaMaGHalWghdSaYZetoBsT1QBxYybwXSYCObQ=; b=C
	FCXA7ey08nFyyz9FAHMrgQfRSOMB9rFH7Z/2WCjIGTBTxVTFyZzYNXw+4wubcCe9
	X3/kjGUyD3uTEkLNEneoS/bA+gHJeZQ8hnGjmNoWY1VnGn2NsKeJKrn85prXrjbh
	UjXHhMUtQ1OX2JEkgGIkDZi59hlgrOyfkSaskM8+Mq9qNFZNjNToVdqo7hkt8t/F
	L1iDA4B9SocT7c72jMG+hSxCi50+OPeSoWkJyUl6T4GW4scC/67W0LIbAptW9kSV
	CYHug7iMcpWVtkgmJdPCRfOzGDWJ5503fxJ00RHq9piQkd/VFY+HyCAeSqpm3fjh
	T9kVSiv2/r+XBb+LvHYJA==
X-ME-Sender: <xms:xI_8Zsublz45AhzpKaysfxzam1tBz1InNMrF5MTU8ftc_8aFakEXBQ>
    <xme:xI_8ZpfTn831IYNgIta4lxdvwbUrqoe8-Ea3EMrByUJ7PsxvI3LZxr7qcP2WJiJoW
    9jLiD7ulzeNHWFEzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedufefh
    ffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhihkhholh
    grlhesfhgsrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgt
    phhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprh
    gtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhn
    rdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhose
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidr
    nhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xI_8ZnwZux3-CMRRPK85p7GL00x5Wktbh6tlhPAp1EZ4UB0F0Ny1Hw>
    <xmx:xI_8ZvOtwgzGP-L2ISa6SdJeXkXpE5RVNbTbrhXq_qq6YGbrtnD9pw>
    <xmx:xI_8Zs8mdKmCxEbkuKXA4ukLRF_V5yfpUInJWHf9Fh-bNMwGJQHLBA>
    <xmx:xI_8ZnUcDUuHx-srb88helw15YB4bCWOh3nuPPLNNJqjJHZcAaSHDg>
    <xmx:xY_8Zv2aNFP5igJ3qrxVpUYUbGjNbB75lAc-_X3B3eaHQpOiXXER5QND>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BF8EF18A0065; Tue,  1 Oct 2024 20:11:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Oct 2024 17:11:27 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Shuah Khan" <shuah@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <d0fb1d17-cd90-4ff1-9f8d-e671c99848b3@app.fastmail.com>
In-Reply-To: 
 <haktyvoigwi2hz7f5j4m3go3trljy4u2cqis3wl7cl5iuhb4d7@nql73373o3ru>
References: <cover.1727174358.git.dxu@dxuuu.xyz>
 <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
 <CAADnVQKZ1MkBttCKsOMh7nNXNP4OVxGdYLnJuXjNFLPUv3Bm6w@mail.gmail.com>
 <haktyvoigwi2hz7f5j4m3go3trljy4u2cqis3wl7cl5iuhb4d7@nql73373o3ru>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: verifier: Support eliding map lookup nullness
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hit send too early.

On Tue, Oct 1, 2024, at 5:07 PM, Daniel Xu wrote:
> On Wed, Sep 25, 2024 at 10:24:01AM GMT, Alexei Starovoitov wrote:
>> On Tue, Sep 24, 2024 at 12:40=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wr=
ote:
>> >
>> > +
>> > +/* Returns constant key value if possible, else -1 */
>> > +static long get_constant_map_key(struct bpf_verifier_env *env,
>> > +                                struct bpf_reg_state *key)
>> > +{
>> > +       struct bpf_func_state *state =3D func(env, key);
>> > +       struct bpf_reg_state *reg;
>> > +       int stack_off;
>> > +       int slot;
>> > +       int spi;
>> > +
>> > +       if (key->type !=3D PTR_TO_STACK)
>> > +               return -1;
>> > +       if (!tnum_is_const(key->var_off))
>> > +               return -1;
>> > +
>> > +       stack_off =3D key->off + key->var_off.value;
>> > +       slot =3D -stack_off - 1;
>> > +       if (slot < 0)
>> > +               /* Stack grew upwards */
>>=20
>> The comment is misleading.
>> The verifier is supposed to catch this.
>> It's just this helper was called before the stack bounds
>> were checked?
>
> Yeah. Stack bounds checked in check_stack_access_within_bounds() as pa=
rt
> of helper call argument checks.
>
>
>> Maybe the call can be done later?
>
> Maybe? The argument checking starts clobbering state so it'll probably
> be not very simple to pull information out after args are checked.
>
> I think the logic will probably be much easier to follow with current
> approach. But maybe I'm missing a simpler idea.

I can make the comment a bit more verbose. Maybe that's better than
trying to wire a bunch of logic through memory access checks.

