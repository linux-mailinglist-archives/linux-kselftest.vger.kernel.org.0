Return-Path: <linux-kselftest+bounces-22443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0B9D5BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D7D1F23650
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697611DED54;
	Fri, 22 Nov 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Dz9Sta9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMALlgmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E681DE2CF;
	Fri, 22 Nov 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266837; cv=none; b=KWvReyiPOlJG1bAyc0onu+ele5UHlvtKYumDj3cVufAtf5eI1Q5vkW7Q2L8WJTij/YQh1uYXg/tD7o4ZDgCBT5xmvDqlQi14a39X2qBH74x6L5Ekj89bwHd6piu0qOf6oj/WPdcGtrICFomvZMe+vswo2Tz3AAzylvqQ17TqWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266837; c=relaxed/simple;
	bh=/RiVaYRlUIVDOXW7SckpIS+QoWtu8hzGXOKnCdpSJak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEZm8f0iGxDzG6GfymmEa4o0rcihSbUSzdEuF9HVeGxBJ4rIrst7cv7eYMzMk1UNzA1cDADeyqEc1uGmrDEAsFW7GR055Y2wlZ+uHXu7N81b7itZkKCkt4uvu4FrBCifdzwSWWKzTpWBicHlaU5vncRN4mwxj20UILe40uMq4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Dz9Sta9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMALlgmb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 890BC1380267;
	Fri, 22 Nov 2024 04:13:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 22 Nov 2024 04:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1732266833; x=
	1732353233; bh=n7kZYzz3OBgLUHx6zbIxlb9gAM2VKHvL/nG15VT6Xps=; b=D
	z9Sta9ZqRQvkbIA47wKXI2Xq2AlHCxyBpapV2qxCBwxLVkE3gMCno1IRZyjpZbYg
	2miBIrOWLtr5fwQiFpcSxFXRTBDQfEo4ccR6XOUHHsc6AVOiAviy6lH9SgJ4pZD0
	wnhvE9wLdy+UeKpv74KwbGc3urMc3nKBN3SHCx0j6k8I87d0J28DvcSUiWBoUr7K
	Lf8ekdnB4VEO+kVOU8OMf8nJvEsRVQR3on2Yr84Hur6WM7u63tmjCKaGHYSoa0Ag
	XIJw2B0nAH5j9yItwz/EYNJPNGpYBMYJ7yMm2gJAfhfqIj7k1/2ufNoPRajfKMvP
	oVtIHSocJnbwSy6Kjesdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732266833; x=1732353233; bh=n7kZYzz3OBgLUHx6zbIxlb9gAM2VKHvL/nG
	15VT6Xps=; b=NMALlgmb5Hdxm/RazpOzDtIoVfDI8TsYJ1B4q85uKhgwST9YDhl
	b6C2U0RQ7ROp2MM5wEbprmCcr4Rmd8FQHVIvRRq9WwQyBVgmMe0pWyyfJI1fCf/Z
	XeK6IiDuIY+0IE7lkY1HQMk256sM9d0oePhsqhliWcRx1Z6lqDkMrG8/IrKI+xQe
	0TnWkqyRNGC3E8j/LP2XFr6ifxHtIPaxF0aKJYrV1QeYc9tH3Q+8+dtEG7K6CApA
	iUN13KZh3RZVqLk25Ac3FGW4Z+NSTiYS6tzBP9dtKnjdgW/pajCOpGchwcf2QEWG
	P32xms7oFQ8lzc3u9FjlgM/AechQME32s5w==
X-ME-Sender: <xms:UEtAZ5V9xTmA-VNQ4lU2Ffin7gPwnwBz9Kc4uV5BHZlVjoY_gXjCNA>
    <xme:UEtAZ5lyPEtttLPc9513xqawm1IwSEDWkktDEXW1710xtIZGUeTbYINzTLlXyhg2r
    D65_ZmoxbRSuHv2WTc>
X-ME-Received: <xmr:UEtAZ1aZHqLs9_vG5SOs1kyTarsNnSAWjaYoQir1umeeU2r29HGf85wt8wFCKuASxQ4buQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuhedvgeegfeduledu
    geevvdeuteettefhfefgieekudehiedvuefhvdevkeeigeenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhprghgvghtrggslhgvshdrthhoohhlshenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmoh
    hvrdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmrggtihgvjhdrfihivggtiihorhdqrhgvthhmrghnsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    mhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedrug
    gvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtgho
    mhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrse
    iihihtohhrrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UEtAZ8X59bjHsNNaMmoYCoAOXk1QlrzxXJvOvsZvm_Hes2VoYarLZA>
    <xmx:UEtAZzkbAhPtDUNagE5AcPyq-YVW3q4BtwCm1W8pgrCxTzeEX_jLkQ>
    <xmx:UEtAZ5dpzQM0p035FPPKpdruaOOsv9Asx6kR6iwoyiwhpm0X0F7KkQ>
    <xmx:UEtAZ9EwJecTaVPWy7XkSOcVc4MCv4TG14JS_WqW_3ifsdxIuLp5DA>
    <xmx:UUtAZ8ft-R1YsBXNYXLNTY1Ra0SJsvS4tlI9iVCpJKtsx9PrfkNsGUkh>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Nov 2024 04:13:48 -0500 (EST)
Date: Fri, 22 Nov 2024 11:13:44 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/lam: Test get_user() LAM pointer handling
Message-ID: <kabcughnduiak2ipmzujq5gmsqu4ugfwxpd23gbic2hcinirb4@r3quhedtuvms>
References: <20241122085521.270802-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085521.270802-1-maciej.wieczor-retman@intel.com>

On Fri, Nov 22, 2024 at 09:55:20AM +0100, Maciej Wieczor-Retman wrote:
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
> 4/5 level pagetables code paths were also successfully tested in Simics
> on a 5-level capable machine.
> 
> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
> [2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - mmap the pointer passed to get_user to high address if 5 level paging
>   is enabled and to low address if 4 level paging is enabled.
> 
> Changelog v2:
> - Use mmap with HIGH_ADDR to check if we're in 5 or 4 level pagetables.
> 
>  tools/testing/selftests/x86/lam.c | 110 ++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 0ea4f6813930..616a523c3262 100644
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
> @@ -43,7 +44,15 @@
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
> @@ -370,6 +379,80 @@ static int handle_syscall(struct testcases *test)
>  	return ret;
>  }
>  
> +static int get_user_syscall(struct testcases *test)
> +{
> +	uint64_t ptr_address, bitmask;
> +	void *p, *ptr;
> +	int ret = 0;
> +	int fd;
> +
> +	p = mmap((void *)HIGH_ADDR, 1, PROT_READ | PROT_WRITE,
> +		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +
> +	if (p == MAP_FAILED) {
> +		bitmask = L4_SIGN_EXT_MASK;
> +		ptr_address = LOW_ADDR;
> +
> +	} else {
> +		bitmask = L5_SIGN_EXT_MASK;
> +		ptr_address = HIGH_ADDR;
> +	}

Hm. Why not use cpu_has_lam() for the paging check?

> +
> +	munmap(p, 1);
> +
> +	ptr = mmap((void *)ptr_address, 1, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);

Mapping sizer of 1 byte looks odd. It is not wrong, but looks strange.
Maybe use PAGE_SIZE instead?

> +
> +	if (ptr == MAP_FAILED) {
> +		perror("failed to map byte to pass into get_user");
> +		return 1;
> +	}
> +
> +	if (test->lam != 0) {

It is always true, right?

> +		if (set_lam(test->lam) != 0) {
> +			ret = 2;
> +			goto error;
> +		}
> +	}
> +
> +	fd = memfd_create("lam_ioctl", 0);
> +	if (fd == -1) {
> +		munmap(ptr, 1);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	switch (test->later) {
> +	case GET_USER_USER:
> +		/* Control group - properly tagger user pointer */
> +		ptr = (void *)set_metadata((uint64_t)ptr, test->lam);
> +		break;
> +	case GET_USER_KERNEL_TOP:
> +		/* Kernel address with top bit cleared */
> +		bitmask &= (bitmask >> 1);
> +		ptr = (void *)((uint64_t)ptr | bitmask);
> +		break;
> +	case GET_USER_KERNEL_BOT:
> +		/* Kernel address with bottom sign-extension bit cleared */
> +		bitmask &= (bitmask << 1);
> +		ptr = (void *)((uint64_t)ptr | bitmask);
> +		break;
> +	case GET_USER_KERNEL:
> +		/* Try to pass a kernel address */
> +		ptr = (void *)((uint64_t)ptr | bitmask);
> +		break;
> +	default:
> +		printf("Invalid test case value passed!\n");
> +		break;
> +	}
> +
> +	if (ioctl(fd, FIOASYNC, ptr) != 0)
> +		ret = 1;
> +
> +error:
> +	munmap(ptr, 1);

	close(fd);

> +	return ret;
> +}
> +
>  int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
>  {
>  	return (int)syscall(__NR_io_uring_setup, entries, p);
> @@ -883,6 +966,33 @@ static struct testcases syscall_cases[] = {
>  		.test_func = handle_syscall,
>  		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
>  	},
> +	{
> +		.later = GET_USER_USER,
> +		.lam = LAM_U57_BITS,
> +		.test_func = get_user_syscall,
> +		.msg = "GET_USER: get_user() and pass a properly tagged user pointer.\n",
> +	},
> +	{
> +		.later = GET_USER_KERNEL_TOP,
> +		.expected = 1,
> +		.lam = LAM_U57_BITS,
> +		.test_func = get_user_syscall,
> +		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the top bit cleared.\n",
> +	},
> +	{
> +		.later = GET_USER_KERNEL_BOT,
> +		.expected = 1,
> +		.lam = LAM_U57_BITS,
> +		.test_func = get_user_syscall,
> +		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the bottom sign-extension bit cleared.\n",
> +	},
> +	{
> +		.later = GET_USER_KERNEL,
> +		.expected = 1,
> +		.lam = LAM_U57_BITS,
> +		.test_func = get_user_syscall,
> +		.msg = "GET_USER:[Negative] get_user() and pass a kernel pointer.\n",
> +	},
>  };
>  
>  static struct testcases mmap_cases[] = {
> -- 
> 2.46.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

