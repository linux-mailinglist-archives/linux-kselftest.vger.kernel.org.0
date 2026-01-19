Return-Path: <linux-kselftest+bounces-49317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E413DD39BF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 02:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D9030012CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0757E19E98D;
	Mon, 19 Jan 2026 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="upRzQ3CB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82319CCFC;
	Mon, 19 Jan 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768786237; cv=none; b=QaHEpVhgtHB/4WWugdqp8E5njYbzwAg1Icde4cnQ28d0GiaeKrkpW963S2lp9bz79h74iBJbyRg4qLdFdNdKAwlE8ybvADuLdQtw+FKQk6vN9PhT/ERr77GwH37aVxeiOx3ppUC88r/Op2FClCRHoW7x127TNilU7fpVhlhoTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768786237; c=relaxed/simple;
	bh=4uWXsuttBNCCVFU/RvHSwM0N/8EI42SlOaD2L6KzBZY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BebDL9jxxaxtMCl7ROm4z+r/Vu19Nmv48tPsg0fyT5rCRT5PRMI3hHgpwF9JTNIKZ0u9HslZN1NLmRstoJomeJNjoQH+GatVp43+iK4fVoZ3ur1fA3mCQGD2HD9Pp/kW6DHgePFbGjj/sBXZxvzyAhLYpbCpqFtqulI4XtKC5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=upRzQ3CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA87FC116D0;
	Mon, 19 Jan 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768786237;
	bh=4uWXsuttBNCCVFU/RvHSwM0N/8EI42SlOaD2L6KzBZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=upRzQ3CBNEWVQpnwzgRd2DT0N26414EOrztmfEEIg1EZbKQsU2sYUPNN3J03IPGTM
	 ykbUbKR9HuQ2HvJhxMlKn5Eo095h0w6Ufy+uKQG7swHiJFqzO8O/XPeNXQk+o0iGpJ
	 2Lpy0wLLWA5c30Q5hhcvjykzQ68Mv3g+bJIRl6VU=
Date: Sun, 18 Jan 2026 17:30:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Audra Mitchell <audra@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 surenb@google.com, rppt@kernel.org, vbabka@suse.cz,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@kernel.org,
 urezki@gmail.com, raquini@redhat.com
Subject: Re: [PATCH] lib/test_vmalloc.c: Minor fixes to test_vmalloc.c
Message-Id: <20260118173036.fd0784f59848303024065b9b@linux-foundation.org>
In-Reply-To: <20251201181848.1216197-1-audra@redhat.com>
References: <20251201181848.1216197-1-audra@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 13:18:48 -0500 Audra Mitchell <audra@redhat.com> wrote:

> If PAGE_SIZE is larger than 4k and if you have a system with a
> large number of CPUs, this test can require a very large amount
> of memory leading to oom-killer firing. Given the type of allocation,
> the kernel won't have anything to kill, causing the system to
> stall. Add a parameter to the test_vmalloc driver to represent the
> number of times a percpu object will be allocated. Calculate this
> in test_vmalloc.sh to be 90% of available memory or the current
> default of 35000, whichever is smaller.
> 
> ...
>
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -57,6 +57,9 @@ __param(int, run_test_mask, 7,
>  		/* Add a new test case description here. */
>  );
>  
> +__param(int, nr_pcpu_objects, 35000,
> +	"Number of pcpu objects to allocate for pcpu_alloc_test");
> +
>  /*
>   * This is for synchronization of setup phase.
>   */
> @@ -292,24 +295,24 @@ pcpu_alloc_test(void)
>  	size_t size, align;
>  	int i;
>  
> -	pcpu = vmalloc(sizeof(void __percpu *) * 35000);
> +	pcpu = vmalloc(sizeof(void __percpu *) * nr_pcpu_objects);

Could have used vmalloc_array() here.  Otherwise lgtm, thanks.



