Return-Path: <linux-kselftest+bounces-18197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3697E09A
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1921F2114B
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7D193409;
	Sun, 22 Sep 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TNBeKhOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prLWwB3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E7134C4;
	Sun, 22 Sep 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726994414; cv=none; b=qet9QJVvYR/M44WRosuxBlAxowftx0J4lD8qFpSABhYi4pkGxJp7Kio1ZZt0/E1mRVCJaUfjlo9mkcWUsR0t7G7//0HR7FyzTYBYvF/qyUJJyoWw5AvIVyJtTVNdOAk86lBuTriHfacDx1dzR23TWoAJr245nI7gFBj7IWHQTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726994414; c=relaxed/simple;
	bh=NvtNCWYLxAUUYaf1ZV3bfcHr8aPZfVyTOA42rrYChrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gpf+vzVPDAVWKpM9mSqnObbTguzLkp1In/kFzt7vZjb5gN3HRCZK479fGvGNCnTqQ35UVQK5KZ7R23KEpHs4qlUCxLlODpX8vRZb2Z3bQANqXvZq2yOHOxtJB1lJUaAOmX5ooS5XaS8/uAnL2JCIOQPtP7xVCj5Eae2PlX9YAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=TNBeKhOK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prLWwB3Q; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 584DB1380284;
	Sun, 22 Sep 2024 04:40:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Sep 2024 04:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726994411; x=1727080811; bh=L8BCOmBV7Q
	cjMxVuy7I8eLqXWe+XQi090UTPa04zCPk=; b=TNBeKhOKoEd9adPkKsRGNaXRNz
	9IoMMiqZR597YU7Spsvyg/+hj4x5drB5c5wOUtpLVGLHry8FipEFyEnsOL5r6oVJ
	zo80eq6IN9ehZcj9fHtJNPjA3c5hZftD9lOJMwZDYQGMb0ar04tW8aCL80LgVHFJ
	M8b6pzC8T5UenQyEG0PL4B8hw3faio6DK5Gh6nLxX0Y/ExLyoAJTuWJW66jVqmTX
	7bl3qdMsCrXhw/iE4Xy+vQOyTjE15yCZNTVXYk7OBbMBzunRBYDvHmIQZ060CXdD
	yExbjvO5rjAbYATtP3IJuYHupKMiJrxeB9xIWPCSeY5c0vnf3JmzD4KrFbow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1726994411; x=1727080811; bh=L8BCOmBV7QcjMxVuy7I8eLqXWe+X
	Qi090UTPa04zCPk=; b=prLWwB3Qd+m4HjjF7HpB+BP5Yh1RWxH9T/lFAHcVuHOe
	haogI+PFD6ZzqH9UolQ7VhkE/27kQKOdpS6drsmvCUHCzGTmjTh4QBT6jVUKt6tC
	6RzAC+VAsFxDJl+zGy1u4Tk21mJgl87w31JFF/UE6U80MyPOpfBL/yOaZiY+vc2u
	Y86RVKt+HUGXHDfBnlTzLvnCIJl09uDeUjFCvDaApQJ4ZJQqAIGusO3CReKdGrvb
	qbs1wW5L3rGa2tEZGhKHbovwXDx5/dQsWlW02tyTVxoq0thmO3wU43vSpSZAlRWO
	BzpVPnKKizsFBK1P2x2ossAHdlRUMR07Dipxapt4ng==
X-ME-Sender: <xms:6tfvZlOw7KrUmnVHAAWWV7Z3HAuVQtwftWJGSqPwMkegSCKwou3LKg>
    <xme:6tfvZn_Bqzt9cJeZagDq7fNRvWjQgUbAXdQuXyik5HDW1B9ocMZ5xpzJ3xtymA7rh
    oezZC1ecVFEuN6oZg>
X-ME-Received: <xmr:6tfvZkTVbTLRtkQv_orXBfg67KhrJ4tj8i07iA6SilCmzpKN8-ekBw7c1d8CcO9Y0OlJsz6Do_bsLmbzhgGVS7fJZmcJuR2xDTl-sySHX-Kp8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeljedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epvdefkeetuddufeeigedtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepshhhuhgrhheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:6tfvZhtS8v3WG-JpGU7cDOCtiwXzFc4Y1XuprJKXDucsu0P3O4_i2g>
    <xmx:6tfvZtf7GC1EfCwgDM-Ssyq--1C_TOhuHvC1gC0JQnsoQWpEOeeZOg>
    <xmx:6tfvZt0AAcNrB_bbC-FseMoQZF_KxIwvrVYjXxsRPg4JeE_8vuI7KA>
    <xmx:6tfvZp99jdLKtbs4EP1p5eCEimJizrJGk4XkB_mKv8vVkHPyQ0YUUA>
    <xmx:69fvZgWbQ2b7du7rNDLwYlbrZBzzZg5wYjrC-51lH6cF4Uhp_zKO-PWD>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Sep 2024 04:40:08 -0400 (EDT)
Date: Sun, 22 Sep 2024 02:40:07 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: daniel@iogearbox.net, shuah@kernel.org, andrii@kernel.org, 
	ast@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <x32qvwnfnouk2zbvllwi7xy6w7jyjp6ifobumuohf4fy32sy2x@gczdukjvjo36>
References: <cover.1726458273.git.dxu@dxuuu.xyz>
 <3b54139f8d4877e0487daebdd799c3878ee27ed0.1726458273.git.dxu@dxuuu.xyz>
 <a1b7e902e6f8be05f7d42bf340484b64583e1389.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b7e902e6f8be05f7d42bf340484b64583e1389.camel@gmail.com>

On Fri, Sep 20, 2024 at 03:05:35PM GMT, Eduard Zingerman wrote:
> On Sun, 2024-09-15 at 21:45 -0600, Daniel Xu wrote:
> > This commit allows progs to elide a null check on statically known map
> > lookup keys. In other words, if the verifier can statically prove that
> > the lookup will be in-bounds, allow the prog to drop the null check.
> > 
> > This is useful for two reasons:
> > 
> > 1. Large numbers of nullness checks (especially when they cannot fail)
> >    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> > 2. It forms a tighter contract between programmer and verifier.
> > 
> > For (1), bpftrace is starting to make heavier use of percpu scratch
> > maps. As a result, for user scripts with large number of unrolled loops,
> > we are starting to hit jump complexity verification errors.  These
> > percpu lookups cannot fail anyways, as we only use static key values.
> > Eliding nullness probably results in less work for verifier as well.
> > 
> > For (2), percpu scratch maps are often used as a larger stack, as the
> > currrent stack is limited to 512 bytes. In these situations, it is
> > desirable for the programmer to express: "this lookup should never fail,
> > and if it does, it means I messed up the code". By omitting the null
> > check, the programmer can "ask" the verifier to double check the logic.
> 
> Nit: maybe add a few lines why tools/testing/selftests/bpf/progs/iters.c
>      has to be changed.

Ack.

> 
> [...]
> 
> > +/* Returns constant key value if possible, else -1 */
> > +static long get_constant_map_key(struct bpf_verifier_env *env,
> > +				 struct bpf_reg_state *key)
> > +{
> > +	struct bpf_func_state *state = func(env, key);
> > +	struct bpf_reg_state *reg;
> > +	int stack_off;
> > +	int slot;
> > +	int spi;
> > +
> > +	if (key->type != PTR_TO_STACK)
> > +		return -1;
> > +	if (!tnum_is_const(key->var_off))
> > +		return -1;
> > +
> > +	stack_off = key->off + key->var_off.value;
> > +	slot = -stack_off - 1;
> > +	if (slot >= state->allocated_stack)
> > +		/* Stack uninitialized */
> > +		return -1;
> 
> I'm not sure verifier guarantees that key->off is negative.
> E.g. the following simple program:
> 
>     0: (b7) r1 = 16                       ; R1_w=16
>     1: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
>     2: (0f) r2 += r1
>     mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1 
>     mark_precise: frame0: regs=r1 stack= before 1: (bf) r2 = r10
>     mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 16
>     3: R1_w=16 R2_w=fp16
> 
> => I think 'slot' should be checked to be >= 0.

Ah, so in case stack grows "up" right? Which seems invalid but probably
good to check.

> 
> > +
> > +	spi = slot / BPF_REG_SIZE;
> > +	reg = &state->stack[spi].spilled_ptr;
> > +	if (!tnum_is_const(reg->var_off))
> > +		/* Stack value not statically known */
> > +		return -1;
> > +
> > +	return reg->var_off.value;
> > +}
> > +
> >  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> >  			    const struct bpf_func_proto **ptr)
> >  {
> > @@ -10511,6 +10557,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> >  	}
> >  
> > +	/* Logically we are trying to check on key register state before
> > +	 * the helper is called, so process here. Otherwise argument processing
> > +	 * may clobber the spilled key values.
> > +	 */
> > +	regs = cur_regs(env);
> > +	if (func_id == BPF_FUNC_map_lookup_elem)
> > +		meta.const_map_key = get_constant_map_key(env, &regs[BPF_REG_2]);
> 
> Nit: there is a long 'switch (func_id)' slightly below this point,
>      maybe move this check there?

I had that initially but discovered that verifier marks the stack value
as unknown as part of check_func_arg(). I _think_ it was:

        if (is_spilled_reg(&state->stack[spi]) &&
            (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
             env->allow_ptr_leaks)) {
                if (clobber) {
                        __mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
                        for (j = 0; j < BPF_REG_SIZE; j++)
                                scrub_spilled_slot(&state->stack[spi].slot_type[j]);
                }
                goto mark;
        }

I remember spending some time debugging it. Which is why I left that
comment above this code.

Thanks for reviewing!

