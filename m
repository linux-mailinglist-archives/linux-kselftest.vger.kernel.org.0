Return-Path: <linux-kselftest+bounces-21094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31E9B6321
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3F3B212EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082C1E9081;
	Wed, 30 Oct 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="mU6Nd/Ev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXh2JPRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F271E885F;
	Wed, 30 Oct 2024 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291524; cv=none; b=k06suX8hGktNRNErIBq+ZUR9YpMo4BdNee9SelZGF5NeHIS3jbDCyTlc1DHW5Iw8uGPEg6hQSwkI7TlNRsBQAy4R5b3soC5daLZqVPAJ/h20sEPTdr3QzTgrYoXsWPmcdlqfbdyTa86llf8tfS7wXYw540KRziAfiIvqvqjEcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291524; c=relaxed/simple;
	bh=Kq5fW09On13fUS0JYLUzYNQGtfOTZ3cdNf1UTRdhyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A80Tu2nr+wemu3RTaROvmzpDftA/eyoBnNw4Z/fyFENWsvNWJwAozbp3BCjZ7v7mx9/izG+nBM853Ppy7J2oVsEbO9h9Ce7AAgFygGrEbci/kqpffu64wYzuEQxixKSvG+OfShZ+bR1Ks1VQc4gE4m5YCum800/C2atpacrZlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=mU6Nd/Ev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXh2JPRR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF2001140098;
	Wed, 30 Oct 2024 08:32:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 08:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730291520; x=
	1730377920; bh=A/ppIlWNYztYatUHxV9Q+2wBv4V7E9P9uRfoUG/IVb4=; b=m
	U6Nd/Ev649pldcj7ZJvmxFbXzwZGJAQ+yyBhF7bjaxYIpgA+TeqPCGS5FbICNDSJ
	Xw2FoTI76wEJ782XlEYM+/+rrmH6TjVII/am9fspRAk06WUTTQ/9+GiBsJk6GZVQ
	fl3jmbwuqQABFTNonmvz5eF4HShd6Bvbdjk/lYUAqGNxWsW5IqIQTK423EoJIYHK
	Hu0tml9sZdSMWW9i7po5YLrU2No5qNekCeL8MnM6tyjevzieF+4sZ3tgPqP4rsLa
	6tRtH/b/Gs6uwUobPgzhF5L4m/R9JVWDAFj+a0oJdjQAcg+oNvBiEXLWzsxmpV3n
	+24cgQmscKAg2AQHzaa5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730291520; x=1730377920; bh=A/ppIlWNYztYatUHxV9Q+2wBv4V7E9P9uRf
	oUG/IVb4=; b=JXh2JPRRiu+bDq4Lnjaa15TZ9AOX/H42pN5AZTUVOpCO2sgRi+B
	a2QURJuqpQMPfy/lZdTUYYmtgtycFtT+AqC9YFyw+Cs/OUBVWsIVt9SN4NQ1WilX
	jNEGzNw9a1ZcQ3JmtyFZ8rZRyIgwV8Ln6wGIfk0BxGF4nImkMYtW6Tlz5IAo8FOq
	HajXVKtRh/dgg5vOcRC+MELJQD9k/bDJcxRDkGcra+yd3fsD4MubOaIATLcWvhGH
	P+i0lkyvR4zc5E2wKsqnmR+OqmFIsjRV5thLRJI3r+ceLS3Pw4gqFu1LuUPUpVMD
	kdut11be3d1VJ0X7lvcwlnR32tk82+jOqJg==
X-ME-Sender: <xms:PyciZ2cgkTijlz0fOdzVR2gj5dET5K3oUyitHPZPCXU_BUOh-LAlJA>
    <xme:PyciZwNy0fGTw_jvlodXhmye4eQ0cvLBviRC8iWFFB1qAT04R_0Fz74lWAW6mLtCN
    _oC-_HLGKubHT5uvT4>
X-ME-Received: <xmr:PyciZ3iVwM6qvQS4vI8rb2guUoB9IJvah_HA1OXKbSPGzlpi0hmXiSdhm6rZIZAv1-PzPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    dutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrtghivghjrdifihgvtgii
    ohhrqdhrvghtmhgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehtghhlgieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnh
    hsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QCciZz_gzC2uxHBSkFeUPEqaX-bMvoeM9hMlw6CmqpH9ROdywucoCQ>
    <xmx:QCciZyvZCyoNN8bnzV31eXoJLb9DR8yk7nouElTGJZ6n5Yj6hd_PSA>
    <xmx:QCciZ6G1soq_ts3LhLAdMfQ3bgkO6sO00LWTdGYJC_4SHMJ27xdZ8g>
    <xmx:QCciZxONTx7ujt1qOyd7qCheiEEdj72iXxXbjQzCvmbhyA-cDhyRZA>
    <xmx:QCciZzkMl9w0vKLQuKRYQuNP3OaP5CCJMrOEadhCfeIe-ubh5YpjeNum>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 08:31:56 -0400 (EDT)
Date: Wed, 30 Oct 2024 14:31:51 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/lam: Test get_user() LAM pointer handling
Message-ID: <6va3r22jkgpk2kah7d3au7euiqrdeuooegezaguk4j4djfydop@3dpbdrl7akrp>
References: <20241029141421.715686-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029141421.715686-1-maciej.wieczor-retman@intel.com>

On Tue, Oct 29, 2024 at 03:14:20PM +0100, Maciej Wieczor-Retman wrote:
> Recent change in how get_user() handles pointers [1] has a specific case
> for LAM. It assigns a different bitmask that's later used to check
> whether a pointer comes from userland in get_user().
> 
> While currently commented out (until LASS [2] is merged into the kernel)
> it's worth making changes to the LAM selftest ahead of time.
> 
> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
> get_user() in its implementation. Execute the syscall with differently
> tagged pointers to verify that valid user pointers are passing through
> and invalid kernel/non-canonical pointers are not.
> 
> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
> test was ran without issues with both the LAM lines from [1] untouched
> and commented out. The test was also ran without issues with LAM_SUP
> both enabled and disabled.
> 
> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
> [2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/x86/lam.c | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 0ea4f6813930..3c53d4b7aa61 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -4,6 +4,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/syscall.h>
> +#include <sys/ioctl.h>
>  #include <time.h>
>  #include <signal.h>
>  #include <setjmp.h>
> @@ -43,10 +44,19 @@
>  #define FUNC_INHERITE           0x20
>  #define FUNC_PASID              0x40
>  
> +/* get_user() pointer test cases */
> +#define GET_USER_USER           0
> +#define GET_USER_KERNEL_TOP     1
> +#define GET_USER_KERNEL_BOT     2
> +#define GET_USER_KERNEL         3
> +
>  #define TEST_MASK               0x7f
> +#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
> +#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
>  
>  #define LOW_ADDR                (0x1UL << 30)
>  #define HIGH_ADDR               (0x3UL << 48)
> +#define L5_ADDR                 (0x1UL << 48)
>  
>  #define MALLOC_LEN              32
>  
> @@ -370,6 +380,54 @@ static int handle_syscall(struct testcases *test)
>  	return ret;
>  }
>  
> +static int get_user_syscall(struct testcases *test)
> +{
> +	int ret = 0;
> +	int ptr_value = 0;
> +	void *ptr = &ptr_value;
> +	int fd;
> +
> +	uint64_t bitmask = ((uint64_t)ptr & L5_ADDR) ? L5_SIGN_EXT_MASK :
> +						       L4_SIGN_EXT_MASK;

Emm. Do you expect stack to be above at the very top of address space on
5-level paging machines? It is not true. We don't allocate any memory
above 46-bit unless asked explicitly.

See tools/testing/selftests/mm/va_high_addr_switch.c

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

