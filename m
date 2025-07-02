Return-Path: <linux-kselftest+bounces-36322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341FAF58A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD1B4E1DB4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9628750D;
	Wed,  2 Jul 2025 13:19:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292ED2874E0;
	Wed,  2 Jul 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462378; cv=none; b=PdsOgiZgXI568l8YZV30QBAUadedVCcRmCYTa/cDGAUU8AVd9rrbAYBXgCzgab5181noG8ZLlVz1NAqT3G70HlpBLfGTQH1Zod8h7fGKydUIpSpGEIEUsxfAwZwp+/eQvo1H51bDaE5x/FsjgY0ytljH+sFC5DlLpy+0KI6B1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462378; c=relaxed/simple;
	bh=tuVAUH59+l/O8UCrXTZ5Z+cA00nPP9nSSO/OIl+MgdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBCIy0Bb0mRHwFneiz8vMCvdQlJfftWVJE6amIukS7E8Bliha8ubTOecT4oxXWMdR1lGzFEQ2WMJTPpuKuyeUwGgV/+BZzpgr+fmvb7H91Iskjb2N1/Iwuy0kGgKhQ+UI9FHqZskANI3C6aWMdg05mUng0usblpZwp3LNgGgbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1uWwab-00058l-00; Wed, 02 Jul 2025 14:29:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 9F5D4C0C86; Wed,  2 Jul 2025 14:28:58 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:28:58 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 1/2] MIPS: Don't crash in stack_top() for tasks
 without ABI or vDSO
Message-ID: <aGUmClZQXMIQAIif@alpha.franken.de>
References: <20250611-kunit-mips-v4-0-1d8997fb2ae4@linutronix.de>
 <20250611-kunit-mips-v4-1-1d8997fb2ae4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611-kunit-mips-v4-1-1d8997fb2ae4@linutronix.de>

On Wed, Jun 11, 2025 at 01:28:26PM +0200, Thomas Weiﬂschuh wrote:
> Not all tasks have an ABI associated or vDSO mapped,
> for example kthreads never do.
> If such a task ever ends up calling stack_top(), it will derefence the
> NULL ABI pointer and crash.
> 
> This can for example happen when using kunit:
> 
>     mips_stack_top+0x28/0xc0
>     arch_pick_mmap_layout+0x190/0x220
>     kunit_vm_mmap_init+0xf8/0x138
>     __kunit_add_resource+0x40/0xa8
>     kunit_vm_mmap+0x88/0xd8
>     usercopy_test_init+0xb8/0x240
>     kunit_try_run_case+0x5c/0x1a8
>     kunit_generic_run_threadfn_adapter+0x28/0x50
>     kthread+0x118/0x240
>     ret_from_kernel_thread+0x14/0x1c
> 
> Only dereference the ABI point if it is set.
> 
> The GIC page is also included as it is specific to the vDSO.
> Also move the randomization adjustment into the same conditional.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  arch/mips/kernel/process.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

