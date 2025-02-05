Return-Path: <linux-kselftest+bounces-25822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D38A289FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323023A788F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BE22B8CD;
	Wed,  5 Feb 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oFO2A2pg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6zSbh0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F17218AC4;
	Wed,  5 Feb 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757702; cv=none; b=iDHu6fucmVFFbxPBBinyfH4whd6ih38LpT+Sum63AxK+x1F572BofWqoXIpT1D62J0ThVtcCJyyMv9SbSpEsMDr+/e1GSdb/zyX4bcckXqRbXglqFstSNur31F1Wt19yj+AQlnP13ZyMqE4cXDb7jD1+2GbSZVDiUrbqX4Yd0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757702; c=relaxed/simple;
	bh=FMLGSLj6R8JVgLvkdOdwv134eD/wDE/J7GN3jj3lJvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc+kNcOXsx3aHQatb3oc+LbpVT3nvS9TOKxC4J4iDLrWAUyRmx7Dc9lp99uwfcbrId07fnlbTZdx/Njz4HhQa/+67mU58o7t/hdrZ/YcJ9IpdeeL77WGUv2GQsfRoz/3vyeHfp3j8CFLhZGmqx5G2tQjArNugPtuJefnSISrDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oFO2A2pg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6zSbh0E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E63C011400E4;
	Wed,  5 Feb 2025 07:14:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Feb 2025 07:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738757698; x=1738844098; bh=ZEkXZWhhni
	DQ23BUYVMWyvX3Ay9kHR31GJKwgx6W/G8=; b=oFO2A2pgXLHzJzdFKyBKCelNn5
	L5pkEvoqHVoU2FRozr2mtPtFF7qEbGJEEc7HrLe5N5T/BouIYV8devfJIbu+QHJe
	oEHYrpDj8sqRSzs9dqNCb30stXZtE1X3QKX8tgFIqgT04VR+tTD8PcPFTSt8KaCU
	If8zwdVUMQnpdmtisOTjta3++Lf6G4vi7181DdbRRYGBcf7qcbJJx6TnDhO/z+Fh
	0yKpahVs2IlL/+09MEP7MAPVx12gnX1IfSh0vJVfYxaL0A5nTb6cqu8ek+LfC1f2
	NgJO+NISaXabitkL7p5VUxPkdzWomjHLhsuotzPkjarZsN3U9s/GjLTg/o/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738757698; x=1738844098; bh=ZEkXZWhhniDQ23BUYVMWyvX3Ay9kHR31GJK
	wgx6W/G8=; b=X6zSbh0EOWqv3fmrfPU9iYtbWOrlpjsYkgVisARFsOgFpuhe1BY
	SdT55t7iprSYfJEdXa6CfmfKMri2WyyvismKosLtd64QnFNmUPaMF/KF8dE6eGhd
	lKVNTSz/G+JCt+lIB21XC0M6KuKD7Zgfp7ly5Vsk57H0SvOhmzg7qDvL+gXe32Zx
	8+j0mesBL2WR/G6vrmbRowBKo8rkjoc/8BinWiRv6xqUaW2FCfUnxQVi/9mDYo3r
	Wzz/8T/deDQQCbdrP3vcn7hmVjPri1vP/+slZc6eFkSHzEtqZTi8jYjfD7XhfplV
	sQUmrJnaO4fXFxvGHUBELWiy8If7MPHDCBw==
X-ME-Sender: <xms:QlajZ2ifL2uHrFupypxXD2WljhW3MR0ZTn3sPfgPhv5qSsIu1NkZcQ>
    <xme:QlajZ3BrVNhpkeL3PoikA2dXUz39FlWPmwYa_yrlDTHjbomfpRFNiBG3k0FgD9JfK
    UOi9Z0jXcrQOg>
X-ME-Received: <xmr:QlajZ-G2GBfSswox4yPg5PGsrqAlbgcI93B-BmNEcg-uu3UcBG-mB3ZD54z7eKQSY4BpCcSOTq2WqYZujtkua40sKjBCqHOke5nEYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgv
    gheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgfdtledutdelke
    efgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihihhfvghirdhlrdhlihhusehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghvihhnrdgsrhhoughskhihsegrrhhmrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhht
    vghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QlajZ_RvIwQmHFqY4KS1TgqdnfX3lRou0dECf9jvXglNvdoAzMqbFA>
    <xmx:QlajZzyn36K1jq1Ir8PakjSYdsz5zDyi2ncmCbDJ-tMXz4FpgZyTxQ>
    <xmx:QlajZ964sP0EL_PDAPiy-T99tGfoqdLT9wpbR7WYWumS4IzLl13uBg>
    <xmx:QlajZwy8my3lVtz6W7peoFLcZi9n94527mfHqyJQPEZ3Uq-VopFpaQ>
    <xmx:QlajZ4qArvGqtd-EuOnOcZ8WzQi3DJy8azP8fCnj7hNCnuEWd5_MpfVm>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 07:14:57 -0500 (EST)
Date: Wed, 5 Feb 2025 13:14:55 +0100
From: Greg KH <greg@kroah.com>
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: shuah@kernel.org, kevin.brodsky@arm.com, stable@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1] selftests/mm: build
 with -O2
Message-ID: <2025020544-preview-worshiper-8539@gregkh>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204214723.1991309-1-yifei.l.liu@oracle.com>

On Tue, Feb 04, 2025 at 01:47:23PM -0800, Yifei Liu wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> [ Upstream commit 46036188ea1f5266df23a6149dea0df1c77cd1c7 ]
> 
> The mm kselftests are currently built with no optimisation (-O0).  It's
> unclear why, and besides being obviously suboptimal, this also prevents
> the pkeys tests from working as intended.  Let's build all the tests with
> -O2.
> 
> [kevin.brodsky@arm.com: silence unused-result warnings]
>   Link: https://lkml.kernel.org/r/20250107170110.2819685-1-kevin.brodsky@arm.com
> Link: https://lkml.kernel.org/r/20241209095019.1732120-6-kevin.brodsky@arm.com
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Keith Lucas <keith.lucas@oracle.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 46036188ea1f5266df23a6149dea0df1c77cd1c7)
> [Yifei: This commit also fix the failure of pkey_sighandler_tests_64,
> which is also in linux-6.12.y and linux-6.13.y, thus backport this commit]
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> ---
>  tools/testing/selftests/mm/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 02e1204971b0..c0138cb19705 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -33,9 +33,16 @@ endif
>  # LDLIBS.
>  MAKEFLAGS += --no-builtin-rules
>  
> -CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>  LDLIBS = -lrt -lpthread -lm
>  
> +# Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
> +# automatically enabled at -O1 or above. This triggers various unused-result
> +# warnings where functions such as read() or write() are called and their
> +# return value is not checked. Disable _FORTIFY_SOURCE to silence those
> +# warnings.
> +CFLAGS += -U_FORTIFY_SOURCE
> +
>  TEST_GEN_FILES = cow
>  TEST_GEN_FILES += compaction_test
>  TEST_GEN_FILES += gup_longterm

This does not apply to 6.13 :(


