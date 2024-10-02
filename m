Return-Path: <linux-kselftest+bounces-18858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABEB98C9EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 02:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7F8284EA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 00:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06661635;
	Wed,  2 Oct 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="g54aUNVi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arwftmMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBB621;
	Wed,  2 Oct 2024 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827679; cv=none; b=CeLAQmWXQnaYVedVOkq7ptGunmjKaLZI25BSKQwT4wELwpftyQqznv2rfg4hdhErkA1KAoBg29I/KJ0sKEUYDjWQmfHRNaHl02BYeDDMpdMpJvYJkzbUGMHiiGoKs+owj5jxHErgdYAJsI033aXDdVkrRc9HCrZCwaiPxR4GpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827679; c=relaxed/simple;
	bh=jukmSJH+7KJBbCJWdv8teAbP7RJLD7j+E98Km0Qjhwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRUPSBH181dopfgdC+B4MZLFd7TfgdNN9q8ckpLmRw4sj8LBavRwa8oqj5MKpxC9mIN6NwE/sxJlJHc0C72Abie6IMcabGkCzpTZrMNMXe14cQyE5xPUuxqw2Bh3Ya+X6zOlfgeAHQ3+wH1wMR9bwtYpVN0rBDaWwRRmesTgV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=g54aUNVi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arwftmMs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 11E541380AF8;
	Tue,  1 Oct 2024 20:07:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 20:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727827677;
	 x=1727914077; bh=kc/KJSkNio75EeAigj46aYdRyCtYdr5dc2BgBYEgWrQ=; b=
	g54aUNViiNdOsnZukl6tIoBuaaJHYRdu5DSbCkH/TzuzerISdPn4+T0QcAlvU/52
	1t1RKma9OVRbmxCV+vIf7T3pi/WhrArgoauuW2JmCnbx4e4F9kVt63VeKq/O4ntH
	h5FJuFakpOFZOOssPoeX5rSOPQ4Ik8g2G2cUzjNm60xsRbR5UX4L7FIrffi5QGS+
	O0Nr4DkEQQRKk8Df/nnlXjyc4YDR+bX8IXdTUBuQgMJflqcGYPSer62e8KbThUPF
	WnbWChVNMDC7ui+rgKKp7LmBk9A7fqROiMZX1mEIaqFZPSuXXQrAyYSDeFitjw5b
	Otpae+2W1F2Ty0mwORLmJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727827677; x=
	1727914077; bh=kc/KJSkNio75EeAigj46aYdRyCtYdr5dc2BgBYEgWrQ=; b=a
	rwftmMsh30JGfC0ho7gsld6SXOlw5DWXSwk0J0Pi7gLoX34svPW+podQ6q5MGhlB
	6xIfQsmO2SRLr6Ja7L8i//ZEoAmUl8RnTNRSEs5SthaGJAJNjkcf9B6eWKHoyXrs
	QUZqUyZXZrHsq61WG4QkaVYaUQ1JqVNpiYBmJ+LBUNortw5CShkL8k9Uo+Uj/xUW
	Dx1POoB3uH23nfm1GSuZnyc0EE59Uf2cDFMWIc4r2pLezHGmO/iX5fGlDEcw0jvH
	IIxi5EdavwKUtYR2sY3upqJpm1JnFESwdZTFYeCZSUk25gfBG43PG3x+95hRxo12
	wzNaFGdB/sRqxvwGuvGXA==
X-ME-Sender: <xms:2478ZiZnEhet8Rf8J7rhv0i0HFmDQNJVVFZR38SNM_fyS4CIwJ5vZQ>
    <xme:2478ZlYrgK4_UFPI1LXz_UX4RbvnekSYZCSoFWj27p6djPSBwAHHXaR2hh8Kihk1c
    -bTpkQDw2-bCYRkOA>
X-ME-Received: <xmr:2478Zs8PKvI8oRlS5XctgDh-mc84T0zgSJx5VArtwr40tyjhJN1IHJoQb5ipmysxDkdebz6KpC7VXk8jBvBa-J0zSK0Xo2LC8CwWLSbivb1sRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeff
    leetkeekkeeggeffvedtvdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghird
    hsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrd
    hnvghtpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggu
    ugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpth
    htohepshhonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2478Zkoh1D_RLL0awLQEf006D0wEgtbNLp-0JkyOAEaXWY23Itsytg>
    <xmx:2478ZtpsttvLcmbqVbldmppMaDWXMd5Wm4Vvv9uV1wg3sbYTh6h6EQ>
    <xmx:2478ZiTRVliorduIREunrNV29v1gGh4ihPS5zzxs4BrjqzjVdFMgcg>
    <xmx:2478Ztr1qhTuzucLAns_w4KTa6VBc_umt1msVku_bvaoDG42LtfICw>
    <xmx:3Y78Zsd-6JbXtO1HwagbhoiXIc8BeIz0CFAytuoCfGG_P5O2I9xcxpyl>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 20:07:53 -0400 (EDT)
Date: Tue, 1 Oct 2024 18:07:52 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <haktyvoigwi2hz7f5j4m3go3trljy4u2cqis3wl7cl5iuhb4d7@nql73373o3ru>
References: <cover.1727174358.git.dxu@dxuuu.xyz>
 <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
 <CAADnVQKZ1MkBttCKsOMh7nNXNP4OVxGdYLnJuXjNFLPUv3Bm6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKZ1MkBttCKsOMh7nNXNP4OVxGdYLnJuXjNFLPUv3Bm6w@mail.gmail.com>

On Wed, Sep 25, 2024 at 10:24:01AM GMT, Alexei Starovoitov wrote:
> On Tue, Sep 24, 2024 at 12:40 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > +
> > +/* Returns constant key value if possible, else -1 */
> > +static long get_constant_map_key(struct bpf_verifier_env *env,
> > +                                struct bpf_reg_state *key)
> > +{
> > +       struct bpf_func_state *state = func(env, key);
> > +       struct bpf_reg_state *reg;
> > +       int stack_off;
> > +       int slot;
> > +       int spi;
> > +
> > +       if (key->type != PTR_TO_STACK)
> > +               return -1;
> > +       if (!tnum_is_const(key->var_off))
> > +               return -1;
> > +
> > +       stack_off = key->off + key->var_off.value;
> > +       slot = -stack_off - 1;
> > +       if (slot < 0)
> > +               /* Stack grew upwards */
> 
> The comment is misleading.
> The verifier is supposed to catch this.
> It's just this helper was called before the stack bounds
> were checked?

Yeah. Stack bounds checked in check_stack_access_within_bounds() as part
of helper call argument checks.


> Maybe the call can be done later?

Maybe? The argument checking starts clobbering state so it'll probably
be not very simple to pull information out after args are checked.

I think the logic will probably be much easier to follow with current
approach. But maybe I'm missing a simpler idea.

> 
> > +               return -1;
> > +       else if (slot >= state->allocated_stack)
> > +               /* Stack uninitialized */
> > +               return -1;
> > +
> > +       spi = slot / BPF_REG_SIZE;
> > +       reg = &state->stack[spi].spilled_ptr;
> > +       if (!tnum_is_const(reg->var_off))
> > +               /* Stack value not statically known */
> > +               return -1;
> > +
> > +       return reg->var_off.value;
> > +}
> 
> Looks like the code is more subtle than it looks.
> 
> I think it's better to guard it all with CAP_BPF.

Ack.


