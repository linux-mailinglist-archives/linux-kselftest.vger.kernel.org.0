Return-Path: <linux-kselftest+bounces-25505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5667A247BD
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0145D7A2F78
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9D13AA41;
	Sat,  1 Feb 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hrnIrD3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlrQ3gOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B11B960;
	Sat,  1 Feb 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738398203; cv=none; b=Um0boPOMrXDGEr10UObAZLWTcE1c+Xbfbf6QpQeOVrqfrFfrT1xBIq0CaqRLcAxOUTHgZMtpl1P9uZQXPDdp4VFL3PSENPYT87csCVFQo7As8sTP54SAouQSE0bRp6UuogljgfbnRH0S8+SWyQRmvwYHh2NEBsBmsOW5qJBNsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738398203; c=relaxed/simple;
	bh=I2x1xNDIv6a2xJQAVWZ6ZI7SUQRt30VNLur5TLaNNGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR4uFY6C8SCz9Aw/CVQYs257eComTlwGWgdvhhqwlxKjmlFGg20TVUoA+7yKIGjYAth7hMP9iFZFUW7sOouojk8Cpvq/Pm5AljbGNZRn8MK1JFJQznLQ8TIUIgPIx5aKAjDFUNusOX088mxr4cVSeYEqNMup1ZoVl9HWkIVDc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hrnIrD3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlrQ3gOZ; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id BB3482005FD;
	Sat,  1 Feb 2025 03:23:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 01 Feb 2025 03:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738398198; x=1738405398; bh=O1mPFwwAy2
	XgJUG0+NNUDpAoMHPfDv8dSUIkUoZJEPg=; b=hrnIrD3ZWt+Au+iZtZx5K8KtGH
	ug2UfjmYXUW7TzTy/LjWNqUjg1uzMTa8L5DArbC6nSg4kZA+dHt1tQCjDnxHK4iZ
	hpMhUXR8yV5X0NmNdf+Rvcsj6OI5ckcFcp25hmwSBn4hjiPyzrF1eYEoG9zjW3xD
	BHua/o8FUICD1DAA3jUDIjLgUgzO37ig4Z4qeAyQukZc+FLDw9lHi7IvoDDUD72p
	kcNrXxZnIVK6vJSWIdTFyk3M3Ivv283RCpk5QlMcjq7W13cyUmRjVletdc0MNJWW
	vnMhTYp0FVmVSpWtv8bsMqsikdhAMy83cbvaA0+fODED5RezClBby3RHmgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738398198; x=1738405398; bh=O1mPFwwAy2XgJUG0+NNUDpAoMHPfDv8dSUI
	kUoZJEPg=; b=IlrQ3gOZmjZRBVeQQIrKHtIoo0LSCWjeaI03u1ryMizInRhFbui
	962y5IVxELD37rcClNURqUcXjJgcdbmMTbPlr+JGcEFuqa9pxLD+NlTnAAKHbimX
	jb5O2opl4yU9d0DooSzgCKgGB3PnxnglVXQ/XjomkAdPoTm+cFIClJMO45UuUkJN
	BSg1nWjDPs3svs5zM1g+FmFL7Ki9ppjrsjcLnDcXZtU6ODocLFTYEPJGizJ0OV22
	H5i0msVFVA6Gg5oWQzszvCSnszJB0HV4+k4CaL4dpShmcVR/M6vynKn+5iZeIjGG
	1Z/+RZsdke4sThrZ7dSZ5bEJ83vXB4xTxEw==
X-ME-Sender: <xms:9dmdZ79-YJjqcUktUBCa4D-70msWLiYK2-BysjvNCFleoKoWGk1y_A>
    <xme:9dmdZ3ut_1Qcozfw8kv951LqbFVFF8uSpKPbnWuU3n3pz-n2aBG9f_QOrPtBUT3e7
    7GmK6TRRd9vzr3o-w>
X-ME-Received: <xmr:9dmdZ5C3fXWrsJnnCh0-wIc-5vaCaMYnK_c_pJdODxbo6CdTXb-lLZue2ki4h8qmFLRmjqXAvV9VQG2TADsVjmVyDSnHtOhl0LIOXNhSAyNG9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeff
    keeuudekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihonhhghhhonh
    hgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehshhhurghhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepmhgr
    rhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:9dmdZ3f0FVdGvftOqExcfQPNGXK_2Rpu1O-Ec6PhNbUVcxHNjYRKaA>
    <xmx:9dmdZwPF85muZS5C5i7wn5AMOKmpgQCcJ20wskxIkAtPzVB-K9Hv4Q>
    <xmx:9dmdZ5kwdkk2JAXWf_zcsLPZ6l0UK6hvbBRf8CJ-6XwKaW88Pc2WYQ>
    <xmx:9dmdZ6u4pWRQs0PVeKEEjAFViA1pohBwgDKwbB84wGYirx-_95NNfQ>
    <xmx:9tmdZxznGuhvfHFB51Ew1BhEjPiKn_KCo0QQqY5ai3aY2GfD9WZzCo-K>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 03:23:15 -0500 (EST)
Date: Sat, 1 Feb 2025 01:23:14 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: shuah@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	nathan@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
Message-ID: <rgcdc7zokwfoars7c2pzredogea3rvolbnzkvko7q6lbgjnvfx@oeyzed5zalpb>
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
 <2d4773f9-c3a4-4512-9c5c-92f841c326f5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4773f9-c3a4-4512-9c5c-92f841c326f5@linux.dev>

Hi Yonghong,

On Thu, Jan 30, 2025 at 10:28:11PM -0800, Yonghong Song wrote:
> 
> 
> 
> On 1/30/25 2:33 PM, Daniel Xu wrote:
> > Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> > libraries"), only statically linking test_progs is supported. However,
> > some distros only provide a dynamically linkable LLVM.
> > 
> > This commit adds a fallback for dynamically linking LLVM if static
> > linking is not available. If both options are available, static linking
> > is chosen.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >   tools/testing/selftests/bpf/Makefile | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 6722080b2107..da514030a153 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -184,9 +184,14 @@ ifeq ($(feature-llvm),1)
> >     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> >     # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
> >     LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
> > -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > -  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > -  LLVM_LDLIBS  += -lstdc++
> > +  # Prefer linking statically if it's available, otherwise fallback to shared
> > +  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
> > +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > +    LLVM_LDLIBS  += -lstdc++
> > +  else
> > +    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> > +  endif
> >     LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
> >   endif
> 
> Although your change looks good, but maybe you can look at bpftool Makefile?
> 
>   # If LLVM is available, use it for JIT disassembly
>   CFLAGS  += -DHAVE_LLVM_SUPPORT
>   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>   # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
>   # (e.g. when bpftool build is called from selftests build as selftests
>   # Makefile includes lib.mk which sets -D_GNU_SOURCE) which would cause
>   # compilation error due to redefinition. Let's filter it out here.
>   CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>     LIBS += -lstdc++
>   endif
>   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
> 
> It would be great if the selftests shared library handling to be the same as bpftool's.

So bpftool is both an internally consumed (from selftests) dependency as
well as a tool packaged up by distros. For the latter case, distros
prefer dynamic linking.

So unfortunately, I think these probably need to be defined separately.
The code looks similar but the use cases are different.

Thanks,
Daniel

