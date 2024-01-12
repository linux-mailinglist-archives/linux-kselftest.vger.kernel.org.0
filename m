Return-Path: <linux-kselftest+bounces-2925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE082C617
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AB21C21042
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389551640B;
	Fri, 12 Jan 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XKtJaWQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q0MxCTl2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1D15ACF;
	Fri, 12 Jan 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id EAC4E3200AE9;
	Fri, 12 Jan 2024 15:04:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Jan 2024 15:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705089843; x=1705176243; bh=+8mz4XZguZ
	in9UP/KR7blhH64FTif6Z1M+wN3fDN6dQ=; b=XKtJaWQ5K8ENuQnLrOOFCe9Oqr
	N+oxaTUlyPe1bFrj5Ndq8a9kzF/XPvQX6V/zjvpeJFWrKO4IiAz56Im7dS/5tUrg
	LF9LA2PXRzfpXWbenlCDejl4IS1BT9j3K7syUQeoyl9bti1963hqfi4BGr5C6VIx
	7/y6K8qb/pQgvRf8Cc1Z1d99CITcCUaqBgQJ/alRxAxlprAawk1pR5QwDr7e5c/b
	ianfPN82FOg+0d3pFTd2bCjoiHFs8krGwgd6f9yRPCSGZwV6KTfPmNpAaLrtgvZi
	YD9Tc+mLGUrXWWGkDNSaLo3Z1GqZdK8IaN4HFZFYb8AxZzOjLh6SgBZS9VNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705089843; x=1705176243; bh=+8mz4XZguZin9UP/KR7blhH64FTi
	f6Z1M+wN3fDN6dQ=; b=q0MxCTl2AoML2E0BHeGfYNog4xC/sRa8vIfOKKiGddNw
	0prH+OWyfMFIyJ2II/bw0Acx5uQfHaBhF0KaGnf4l9MeU5DC8wRMphxLi9FFqupn
	mdp2kiq0yiIJlmTTPaIo0RfC9hGgujQs71lq2ft23KL2cJCLIGP0nMoXJN6HySnc
	pHMz5fo0GGhFKXRhBqa1Fw0Rwo/nbPjp3wAVG8IpcYU3ToCvgoUa5JlsPA8dzUN9
	J35/kx7dlxio9pAYIzJj4Z+P1/PFaUZ93JOdvKJqO6haIYJ09PELFGwtjX14fylt
	d8NSFTZNlLWN/+KGSMjW5yQnmel62kXjpV94alsy3w==
X-ME-Sender: <xms:MpuhZb8duYQSytqWdU77MM6IyqWHqYh050N5HvRxrLHKhlKlkVCRXA>
    <xme:MpuhZXtglSlLhLRZefoYM7vdW83i9wqN1BKWtHjZXQJlCL8hyF8itey3_N2gvsuzB
    NzND2cMU2agHpfTOA>
X-ME-Received: <xmr:MpuhZZDuDHyUNifp5hPfOoiAEamPCMUJHybPVSKqEB6-EjrFvWPg744nZvo-X_Rbjw0W7SqQRprjTdHRuLTWcd2QbEVrqJ_SXEwR0lo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:MpuhZXdfeoElfiSSF5KdEALU43XdsO3V3q9kxSEDq4zGsYW4hMg2ag>
    <xmx:MpuhZQNU14LzFDa4papP7154zoWDsLRztvp615vN5cZ88HXyqd19ew>
    <xmx:MpuhZZkT1Li4-Lqb_29omSMiU-F0NlfGeKOwvQLHj6BY5T46UmhJEA>
    <xmx:M5uhZVvjD4ejrvco6EgFK3lew0AWY7HU4KijWUhlweUkBmFLK5sPog>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 15:04:00 -0500 (EST)
Date: Fri, 12 Jan 2024 13:03:59 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-input@vger.kernel.org, coreteam@netfilter.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, fsverity@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	cgroups@vger.kernel.org, alexei.starovoitov@gmail.com, quentin@isovalent.com, 
	alan.maguire@oracle.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <2dhmwvfnnqnlrui2qcr5fob54gdsuse5caievct42trvvia6qe@p24nymz3uttv>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <ZaFm13GyXUukcnkm@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFm13GyXUukcnkm@krava>

On Fri, Jan 12, 2024 at 05:20:39PM +0100, Jiri Olsa wrote:
> On Sat, Jan 06, 2024 at 11:24:07AM -0700, Daniel Xu wrote:
> > === Description ===
> > 
> > This is a bpf-treewide change that annotates all kfuncs as such inside
> > .BTF_ids. This annotation eventually allows us to automatically generate
> > kfunc prototypes from bpftool.
> > 
> > We store this metadata inside a yet-unused flags field inside struct
> > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > 
> > More details about the full chain of events are available in commit 3's
> > description.
> > 
> > The accompanying pahole changes (still needs some cleanup) can be viewed
> > here on this "frozen" branch [0].
> 
> so the plan is to have bpftool support to generate header file
> with detected kfuncs?

Yep, that's the major use case. But I see other use cases as well like
precision probing of kfuncs. Rather than guess and check which progs can
load (in the event of backwards incompatible kfunc changes), programs
can look at kfunc type signature thru BTF.

