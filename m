Return-Path: <linux-kselftest+bounces-3280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8783546B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 05:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB81F216B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 04:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C742A1D6;
	Sun, 21 Jan 2024 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BwQvJDCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BA26AF5;
	Sun, 21 Jan 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705811950; cv=none; b=N1/5cMeQb7dZSjXBFqwnj6ZztfO/bsrTcI3XzMz7RzY1R3s3UfqZ0Yh6X41yEfldE4C09VpexGc2HQ/tkfVMB/0NeMrkTIshFz6NiGHd6s9OuAXSE3TnmnOhV3hZdnhDrSPDJSyow28MH2ppvpMKmrQEQ3gsKepq8JC9otyWLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705811950; c=relaxed/simple;
	bh=yIOumgNOZ9bkJGMG/1d6rDyM3BTp4bkXptOAOxlqCJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qEIRdZIyA5aKU61Mfc0FRu5ZMTi+lnuVcM/S1/CbORRC94IbVyvvXbcMQC1eBVyxgHhr+XKa37rxrMq3XrhkfmxzbMtRuM/4psb9Ks2BZchW7K/NPyEyagUUHjoMuehXZMNvwKnBkw6mBs/5/RyynrECV8VsJ4yDLedOeNpKCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BwQvJDCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4ECC433F1;
	Sun, 21 Jan 2024 04:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705811949;
	bh=yIOumgNOZ9bkJGMG/1d6rDyM3BTp4bkXptOAOxlqCJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BwQvJDCfYfTXExSJSf3xqci+aY+1XKcLAlmsLPTzqMBhzhMhq2PXggSWvOLiKm4hh
	 +QHW7/hx6bVrSiB8DQhLGVVLV8Oz87H9DikZnni/eOToqFCtAFXYaCwcmtUMhfHeIB
	 1w3YYdL40bkntnnyiotUKSCDxCiaJstu5eZJGJbo=
Date: Sat, 20 Jan 2024 20:39:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, shuah@kernel.org, donettom@linux.vnet.ibm.com,
 Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] selftests: mm: fix map_hugetlb failure on 64K page
 size systems
Message-Id: <20240120203904.8f36140cd2f507b25e9a09a3@linux-foundation.org>
In-Reply-To: <20240119131429.172448-1-npache@redhat.com>
References: <20240119131429.172448-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 06:14:29 -0700 Nico Pache <npache@redhat.com> wrote:

> On systems with 64k page size and 512M huge page sizes, the allocation
> and test succeeds but errors out at the munmap. As the comment states,
> munmap will failure if its not HUGEPAGE aligned. This is due to the
> length of the mapping being 1/2 the size of the hugepage causing the
> munmap to not be hugepage aligned. Fix this by making the mapping length
> the full hugepage if the hugepage is larger than the length of the
> mapping.

Is

Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")

a suitable Fixes: target for this?

> --- a/tools/testing/selftests/mm/map_hugetlb.c
> +++ b/tools/testing/selftests/mm/map_hugetlb.c
> @@ -15,6 +15,7 @@
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <fcntl.h>
> +#include "vm_util.h"
>  
>  #define LENGTH (256UL*1024*1024)
>  #define PROTECTION (PROT_READ | PROT_WRITE)
> @@ -58,10 +59,16 @@ int main(int argc, char **argv)
>  {
>  	void *addr;
>  	int ret;
> +	size_t hugepage_size;
>  	size_t length = LENGTH;
>  	int flags = FLAGS;
>  	int shift = 0;
>  
> +	hugepage_size = default_huge_page_size();
> +	/* munmap with fail if the length is not page aligned */
> +	if (hugepage_size > length)
> +		length = hugepage_size;
> +
>  	if (argc > 1)
>  		length = atol(argv[1]) << 20;
>  	if (argc > 2) {
> -- 
> 2.43.0

