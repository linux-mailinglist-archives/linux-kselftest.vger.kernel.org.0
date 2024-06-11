Return-Path: <linux-kselftest+bounces-11691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1A90420F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DA51F24A93
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260344C6E;
	Tue, 11 Jun 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HNtxPS6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMEzhY5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618017578;
	Tue, 11 Jun 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125113; cv=none; b=IT6S1momMkxjGP3+GCAx0TbzdhQvbw/b5IB4LEA17VaY3AK0MgaSmqkKQfDluEZz+0FpPPzIaCnvthy2wfgoDPmnQnAByZB5R0yXJTJCFiDqjpkxnlM33eQfj3ZvP8YuoJl4L2sEA4gy2HWbMi969dcJxkFU4aI1Krz22zPmFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125113; c=relaxed/simple;
	bh=8SY4dECWglq57tFvEFA6sQZdC/024FgtdpPZQqJybcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+Xh7pDPfVWWgmde+8dJ42exvDzMJOMTBWzpi+NM5boymp4qGHpuwQZKYmbqrrXaaaU5xs64BT7W/d2Nd8Dpd59QNT87jIHaUt+VW3DDrxqQGOtW/Th7JlEc51czBrInpyXTligqC1H2XY9KAKEeP47PjgU/fy4DFEHbPfTlqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HNtxPS6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMEzhY5L; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 8382F2002AF;
	Tue, 11 Jun 2024 12:58:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 12:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718125109; x=1718132309; bh=kTsf/XjG12
	FVk17WuA7d1tL6MKxw/YBHpNOowUqpZbY=; b=HNtxPS6+iCZ8+1cfY/sSZ9/ZXF
	1LGHuCUvt7fcxZptXUMepaOnq6oloZQL5QQ5lYITEwc+t7OGBlscIZ6vcSDTPAjX
	DffAB4D9d15G8SXoloFnaqYzP8S3zOBEiWtsf6tFCTDt7I0PbylnQ2zcK+AsIYUW
	CIbLPLpJljyZKf+1SbkveJg4jT02SkZH/eDfTK39P0WpemggYhQ7nzifkZBS3Krm
	wQptVOAvf48gu+iweeV+PIySbDrkOegngkpZW12fafUWEHqcPPdAAaYfM8N1b2BP
	fR1ErsJZmlsCioybyE8WUR0VKn+0PsMNAwFGtg7Y/3/rqHyuV86Aphqn+F5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718125109; x=1718132309; bh=kTsf/XjG12FVk17WuA7d1tL6MKxw
	/YBHpNOowUqpZbY=; b=GMEzhY5LVS51kXJlSwbADAeUgsXzI+lP1nAdPnU6CZtv
	KrLVpLhAjPFLpbE29GO3hNGm4G8TJwRJGBotWW3AIMcv7y/z6R5JQhrFEv2GQFt3
	xuwza32TGSptHqX1k3F9meZF68IBSnoXfiOa4J58GwjnNxmG3HAYIC2O2ViAH4sg
	sn7ZZ0FiY5cJ8JZxSSAYnKdqQhSiCYARmwrPQapRZ+zRS4reRQzNcaBAOlSvNMnP
	WiEgG/axJmyvKBUityiHIrsy3vguZed7ecK2gL7LsYTUdomDkPQ+75xqWVeL/yIE
	e+oSB07ou/DhjgvqpoR7enNMxzo1UcNIdwTaaNZVRw==
X-ME-Sender: <xms:NYJoZkVtsmI9UE_5Ce1q1cC6FgvLfGDaRhx602DPw50Ucofyj8-yuQ>
    <xme:NYJoZomgti10pZ2RaBjjyeXoWs5GzSE7k1LFzfL9sah-Rx0E1PdbliGPpwxlfYSgK
    X04DpU3sOtL7HdvJQ>
X-ME-Received: <xmr:NYJoZobIqU5CKd6mWbjxUZN_1TY_eBPgc1YEr6pHkIdTnzjKPnAZNf3F2TW40Fb5g7-e99lyvEj9bXjbJ4st8jdmA-r00EGItw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:NYJoZjUx3lzU5hr4G3Z7pP1IIfHMRXQVYn-HGRZYnxU5ELp7av2PWQ>
    <xmx:NYJoZulV8Lkn0Uc0c5MiS3-6oN7nd3Rsv8TTMgVs3OL17RnCYKl84A>
    <xmx:NYJoZoeGNtrJacC1w1GDL6SXLfHe7_tqF3CpeNYYCgDktxLwGEvzAA>
    <xmx:NYJoZgEjJm8QGAoxV94augFby2UHmxYIskbrGcWyRRy3rvwQMx6M9A>
    <xmx:NYJoZtedwF1u9vgxn3g7M2RCV5JVvw96N8fC1cQdUBpzUhbDiQAt6eu3>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 12:58:27 -0400 (EDT)
Date: Tue, 11 Jun 2024 10:58:26 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	acme@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	mykolal@fb.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 03/12] bpf: selftests: Fix fentry test kfunc
 prototypes
Message-ID: <gwrlw7wtc72vz3ky2pltvpoadtjlezv6kdrs6wf3ptsecyu2sh@aexbk4rotm3x>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <1f493cb7a7e5349f99e2badf0880b75dd6681898.1717881178.git.dxu@dxuuu.xyz>
 <Zmb_hJQqxi44Nj5B@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmb_hJQqxi44Nj5B@krava>

On Mon, Jun 10, 2024 at 03:28:36PM GMT, Jiri Olsa wrote:
> On Sat, Jun 08, 2024 at 03:15:59PM -0600, Daniel Xu wrote:
> > The prototypes in progs/get_func_ip_test.c were not in line with how the
> > actual kfuncs are defined in net/bpf/test_run.c. This causes compilation
> > errors when kfunc prototypes are generated from BTF.
> > 
> > Fix by aligning with actual kfunc definitions.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > index 8956eb78a226..a89596f7585d 100644
> > --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > @@ -5,13 +5,13 @@
> >  
> >  char _license[] SEC("license") = "GPL";
> >  
> > -extern const void bpf_fentry_test1 __ksym;
> > -extern const void bpf_fentry_test2 __ksym;
> > -extern const void bpf_fentry_test3 __ksym;
> > -extern const void bpf_fentry_test4 __ksym;
> > -extern const void bpf_modify_return_test __ksym;
> > -extern const void bpf_fentry_test6 __ksym;
> > -extern const void bpf_fentry_test7 __ksym;
> > +extern int bpf_fentry_test1(int a) __ksym;
> 
> hum, the only registered one as kfunc is bpf_fentry_test1, to allow fmodret
> also there's bpf_fentry_test9 as kfunc, which AFAICS is not really needed

I think bpf_modify_return_test() is also registered. But otherwise yeah,
I think I was overaggressive here. Are you thinking something like this?


diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index a89596f7585d..2011cacdeb18 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -6,12 +6,11 @@
 char _license[] SEC("license") = "GPL";

 extern int bpf_fentry_test1(int a) __ksym;
-extern int bpf_fentry_test2(int a, __u64 b) __ksym;
-extern int bpf_fentry_test3(char a, int b, __u64 c) __ksym;
-extern int bpf_fentry_test4(void *a, char b, int c, __u64 d) __ksym;
 extern int bpf_modify_return_test(int a, int *b) __ksym;
-extern int bpf_fentry_test6(__u64 a, void *b, short c, int d, void *e, __u64 f) __ksym;
-extern int bpf_fentry_test7(struct bpf_fentry_test_t *arg) __ksym;
+
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;

 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;

