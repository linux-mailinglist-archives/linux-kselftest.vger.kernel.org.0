Return-Path: <linux-kselftest+bounces-25377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754DA22213
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9E3A6AB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCA1DFD8C;
	Wed, 29 Jan 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="yXeaHL3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVP/a/IH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EF1DF99D;
	Wed, 29 Jan 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169359; cv=none; b=ZSijuOh6ZqcJBIYa3mE7jy458ZPv3WbYY2mVQ6JcH5QRtZq9Q2TII86hR0drtmwTp+U4hoZ8mBh6YnNUyCosajs6uY3ddKkZZUxIbptgOlLTZgGe/XSL3efzyZc5vNwbUkq+YUev5ONCFV1nahA2I4rcGevwtmt1dvu3lY6G4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169359; c=relaxed/simple;
	bh=ScNGwMw3yrW7uEnx8gMr7SocWDNRpxCJn+8tkeRUdwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVCjjdeWZAUclHJESEUvHoOoNAsHRklOLjFxE/K7kd289nAs3hfckuC1dp6AN/MJfKAJRam42e/HN14b2I4L6s572J3urUlAp0U+ci9yhUX17o+M3lKlGpXGU0grmaPEN9vZxoUDujuJ9Ov5ewTXI/ZpB+cV9oxBKdEa/l0yqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=yXeaHL3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVP/a/IH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DE661140126;
	Wed, 29 Jan 2025 11:49:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jan 2025 11:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738169356;
	 x=1738255756; bh=bBgnwCaZmFQcqHwIuKoOPFtB2fxHPzpWL7bX3kk/lUU=; b=
	yXeaHL3QbfL5dc5oF3lZZJhW02VdAyOGqdE56Jb4snsC+9Rlq7C5L8jaUY+KHhm6
	Nx5EX4WYrJd9Kdw025FbRuWeMnmaU8dgyCl2r29OCxgz8XHv8DjLgrTVw6lU8cB/
	lmifrqTreqWcDVYR8J34zLskiNMF9zXBq8AroMXXFLdeM7xZXH/kX/PhNC2UzYT6
	9+yAhISRkk1U68e1Jk27FazI4ttxO+UEpH7SS8y8NOPCs7FabO22Th6eZGvytGUX
	QVr7jI2jzJyF9hFIDV4KW7A/oSF9Guwcc4A2br4LvCMA/oQSKLr7lEK/FfNo6+IE
	8+PobsVwE25lrb+nRpgXSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738169356; x=
	1738255756; bh=bBgnwCaZmFQcqHwIuKoOPFtB2fxHPzpWL7bX3kk/lUU=; b=C
	VP/a/IH2ksyX4zqIt9V/WzUxjdXKZLC9xR2mBpWCov7bbqgYqlfCGyX/qGJYw8+a
	Vrpzg/4zPiuFZm+zUj8W6iAwHIjBFKmnJOZWFKDmxYGAo08h65Z0/+ra2OAq4+z6
	G+sZl3p8UiedqVM0GIB+JI/xM2hFokRtk5VNlUaLWKc0l6WTruBGcsuK1wAOaTyK
	gMjGemDIvry2YDMlaNAO7gDrwGxVfzRluuUphdWRPQS6a4yt7BlDD8qIBrdyazzG
	CMQS5s4siNMwa1f+Xx1VlWnA8H+aPAuzNVMSMh3uLV8/Z5hJS/iGPX4KZCRmhwHs
	ahganvblA2e2J+UVichiQ==
X-ME-Sender: <xms:C1yaZ17CoUV-XIXmW8cR6JtAZMds65myOy_3Rz6A0QoG1Lq0QRD3sA>
    <xme:C1yaZy5SHvUHr2NCw1xmPrwozohiOH_OCUYpMpV9p3bypMBpgqltNLP2IUCpzhv9O
    U4eXtumh52zUdYiMA>
X-ME-Received: <xmr:C1yaZ8ephjmGxNp98pIVGv6ick9ttPuvR7ymurzZdKJEBqvOj78ur_W3E7FS0iMHW5fO5sqZtmDcpIoomPDuteF5AyFiwZL2ZLK4NjnuKZwAxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedufeeitdeiheffueffleffgeeh
    geejkeetkefgtdekfeejheffjedtgfekieetleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhiiheslhhinh
    hugidrihgsmhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghsth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohig
    rdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:DFyaZ-J_NtVS2ifzedY8_U6MRGtCuL8G8RpfYGhgL8UunUZ-_aL2Nw>
    <xmx:DFyaZ5JDtdtino8FAP_T0Huw5Qz2jIW1texbtDgEPP2dgOwzLzDsfw>
    <xmx:DFyaZ3yNYc5gVhpGKdrmpx2ltbFC-uTvsWxaKwsPDhTJnlvEMQhHGg>
    <xmx:DFyaZ1I3lO2NsN6873MQbsmAKYvg6M2EEpna2jpXqr95S0nrmgGJOQ>
    <xmx:DFyaZx_097w-7cNKADIyscFxCZ3zRIIS0141Wx6aBqy046PvX9luLzM8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 11:49:14 -0500 (EST)
Date: Wed, 29 Jan 2025 09:49:12 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: shuah@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
 <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>

Hi Ilya,

On Wed, Jan 29, 2025 at 03:58:54PM +0100, Ilya Leoshkevich wrote:
> On Tue, 2025-01-14 at 13:28 -0700, Daniel Xu wrote:
> > This commit allows progs to elide a null check on statically known
> > map
> > lookup keys. In other words, if the verifier can statically prove
> > that
> > the lookup will be in-bounds, allow the prog to drop the null check.
> > 
> > This is useful for two reasons:
> > 
> > 1. Large numbers of nullness checks (especially when they cannot
> > fail)
> >    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> > 2. It forms a tighter contract between programmer and verifier.
> > 
> > For (1), bpftrace is starting to make heavier use of percpu scratch
> > maps. As a result, for user scripts with large number of unrolled
> > loops,
> > we are starting to hit jump complexity verification errors.  These
> > percpu lookups cannot fail anyways, as we only use static key values.
> > Eliding nullness probably results in less work for verifier as well.
> > 
> > For (2), percpu scratch maps are often used as a larger stack, as the
> > currrent stack is limited to 512 bytes. In these situations, it is
> > desirable for the programmer to express: "this lookup should never
> > fail,
> > and if it does, it means I messed up the code". By omitting the null
> > check, the programmer can "ask" the verifier to double check the
> > logic.
> > 
> > Tests also have to be updated in sync with these changes, as the
> > verifier is more efficient with this change. Notable, iters.c tests
> > had
> > to be changed to use a map type that still requires null checks, as
> > it's
> > exercising verifier tracking logic w.r.t iterators.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/verifier.c                         | 92
> > ++++++++++++++++++-
> >  tools/testing/selftests/bpf/progs/iters.c     | 14 +--
> >  .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
> >  .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
> >  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
> >  5 files changed, 99 insertions(+), 13 deletions(-)
> 
> [...]
> 
> > @@ -9158,6 +9216,7 @@ static int check_func_arg(struct
> > bpf_verifier_env *env, u32 arg,
> >  	enum bpf_arg_type arg_type = fn->arg_type[arg];
> >  	enum bpf_reg_type type = reg->type;
> >  	u32 *arg_btf_id = NULL;
> > +	u32 key_size;
> >  	int err = 0;
> >  
> >  	if (arg_type == ARG_DONTCARE)
> > @@ -9291,8 +9350,13 @@ static int check_func_arg(struct
> > bpf_verifier_env *env, u32 arg,
> >  			verbose(env, "invalid map_ptr to access map-
> > >key\n");
> >  			return -EACCES;
> >  		}
> > -		err = check_helper_mem_access(env, regno, meta-
> > >map_ptr->key_size,
> > -					      BPF_READ, false,
> > NULL);
> > +		key_size = meta->map_ptr->key_size;
> > +		err = check_helper_mem_access(env, regno, key_size,
> > BPF_READ, false, NULL);
> > +		if (err)
> > +			return err;
> > +		meta->const_map_key = get_constant_map_key(env, reg,
> > key_size);
> > +		if (meta->const_map_key < 0 && meta->const_map_key
> > != -EOPNOTSUPP)
> > +			return meta->const_map_key;
> 
> Mark Hartmayer reported a problem that after this commit the verifier
> started refusing to load libvirt's virCgroupV2DevicesLoadProg(), which
> contains the following snippet:
> 
> 53: (b7) r1 = -1                      ; R1_w=-1
> 54: (7b) *(u64 *)(r10 -8) = r1        ; R1_w=-1 R10=fp0 fp-8_w=-1
> 55: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> 56: (07) r2 += -8                     ; R2_w=fp-8
> 57: (18) r1 = 0x9553c800              ; R1_w=map_ptr(ks=8,vs=4)
> 59: (85) call bpf_map_lookup_elem#1
> 
> IIUC here the actual constant value is -1, which this code confuses
> with an error.

Thanks for reporting. I think I know what the issue is - will send a
patch shortly.

Daniel

