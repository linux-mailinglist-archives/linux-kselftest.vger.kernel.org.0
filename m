Return-Path: <linux-kselftest+bounces-12099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E048290BAA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 21:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757962886F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F240198E74;
	Mon, 17 Jun 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sPaoe0iC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F62161305;
	Mon, 17 Jun 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651630; cv=none; b=oe6A3B7efc28WeuPqXgENJtgV+86adiE1pElV/tBj6CNZS2IzCdwX8yNWDChkNv7AwsPqGVGxJYKUvDUvL8wEioYfwgwU56CjR7jf+eG/2FOgHtXJKy7jqKTZ8ewuh4lB20KEBqOl7NEqPfidTchKmXvEyWy36r3duLyka6ROEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651630; c=relaxed/simple;
	bh=pbHUlH2855XEpgnVeBq3l1Gg1yHC8Uzv+j4aS6wtmU8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o/BC29FUi45T7N25NG8id1YdOIS4a58XyHsR7m17PeEWXpewGmX+L8BfOX3XluBDRCRBu/8e6mnJRtO1u5v9sHmT78c6kGz2J9sMsAbeF+lUbimdLaGljyyWJio2WAidfCCxkAT7JnjQc/78zUFmKDDET/NsVE458jeiN5R6jao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sPaoe0iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D91C2BD10;
	Mon, 17 Jun 2024 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718651629;
	bh=pbHUlH2855XEpgnVeBq3l1Gg1yHC8Uzv+j4aS6wtmU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sPaoe0iCBL6l1jMwgoXW+7ht0mqJDc8JbDNIYNbFYatzNU0799AiQvF1Vpf+6XMMM
	 uZ1aShqucnLu5uwuDau6b/+jvxUubZTI2KIERBxaG3E9KBMjbptcgqsWY2x+b877H9
	 IMvYpDE1CNiHdz6ujhieDf8Sn6zbhQt8m+yRQdXI=
Date: Mon, 17 Jun 2024 12:13:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com,
 ioworker0@gmail.com, muchun.song@linux.dev, shuah@kernel.org,
 corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com,
 fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
Message-Id: <20240617121348.4ee672a1d6bc9202b3ad0e08@linux-foundation.org>
In-Reply-To: <20240617170545.3820912-2-jiaqiyan@google.com>
References: <20240617170545.3820912-1-jiaqiyan@google.com>
	<20240617170545.3820912-2-jiaqiyan@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 17:05:43 +0000 Jiaqi Yan <jiaqiyan@google.com> wrote:

> Correctable memory errors are very common on servers with large
> amount of memory, and are corrected by ECC. Soft offline is kernel's
> additional recovery handling for memory pages having (excessive)
> corrected memory errors. Impacted page is migrated to a healthy page
> if it is in-use; the original page is discarded for any future use.
> 
> The actual policy on whether (and when) to soft offline should be
> maintained by userspace, especially in case of an 1G HugeTLB page.
> Soft-offline dissolves the HugeTLB page, either in-use or free, into
> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> If userspace has not acknowledged such behavior, it may be surprised
> when later failed to mmap hugepages due to lack of hugepages.
> In case of a transparent hugepage, it will be split into 4K pages
> as well; userspace will stop enjoying the transparent performance.
> 
> In addition, discarding the entire 1G HugeTLB page only because of
> corrected memory errors sounds very costly and kernel better not
> doing under the hood. But today there are at least 2 such cases
> doing so:
> 1. GHES driver sees both GHES_SEV_CORRECTED and
>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> 2. RAS Correctable Errors Collector counts correctable errors per
>    PFN and when the counter for a PFN reaches threshold
> In both cases, userspace has no control of the soft offline performed
> by kernel's memory failure recovery.
> 
> This commit gives userspace the control of softofflining any page:
> kernel only soft offlines raw page / transparent hugepage / HugeTLB
> hugepage if userspace has agreed to. The interface to userspace is a
> new sysctl at /proc/sys/vm/enable_soft_offline. By default its value
> is set to 1 to preserve existing behavior in kernel. When set to 0,
> soft-offline (e.g. MADV_SOFT_OFFLINE) will fail with EOPNOTSUPP.
> 

Seems reasonable.  A very simple patch.

Is there sufficient instrumentation in place for userspace to be able
to know that these errors are occurring?  To be able to generally
monitor the machine's health?

> @@ -2783,6 +2795,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		return -EIO;
>  	}
>  
> +	if (!sysctl_enable_soft_offline) {
> +		pr_info("%#lx: OS-wide disabled\n", pfn);

This doesn't seem a very good message.  There's no indication that it
comes from the memory failure code at all.  If the sysadmin sees this
come out in the kernels logs, he/she will have to grep the kernel
sources just to figure out where the message came from.  Perhaps we can
be more helpful here..

> +		put_ref_page(pfn, flags);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	mutex_lock(&mf_mutex);
>  



