Return-Path: <linux-kselftest+bounces-49311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F347D399C8
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 21:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8922C3008E89
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0F2FF153;
	Sun, 18 Jan 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPMnWfBk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B6381AF;
	Sun, 18 Jan 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768768706; cv=none; b=Xdbe/wIXNRYPfn8hNYOcI0sRxUGy4KKCcsCb/Q3lQFD1hXyjjrXMLVCo2Xnh6fyN6bBtxm4CGKmoDn8V+QgMsAp8L/pY9v72BkBX6964snI1WJ5GkPumrVKY2uH5kh8S4aLh+VLEHE27uV3uhS5a7IZtcIjHad+c9Szsf4X6GGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768768706; c=relaxed/simple;
	bh=ADdzl45APaP2WymA7DvTf8qjEJfhgQ/QQb5n0Jodj2w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aUCDO21AhrpK0xQn0Fqx63ZcrebFG1XMu1EbHGHIWrVdmuKhx2lCbQ+IZHh1sd+heFkVQDG52FmWp7uZCnOaI2/ahKhe4IhOmuAa9GzHGs/cTy8gYIcUJ50et35BKTFvflSAyTF7B2u3NQY9iEi6VuhAWGavSEnM58tn5AwIEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPMnWfBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFDC116D0;
	Sun, 18 Jan 2026 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768768706;
	bh=ADdzl45APaP2WymA7DvTf8qjEJfhgQ/QQb5n0Jodj2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPMnWfBkdTDjTlx0FPKRnI58KCuOrS/CQZ71wLF80YqRTlvHE7TB2lZ7Ar0OliOLN
	 Yytj3PbXlCUQkd8hYxGZsjV1stUVPLtr/eHxR/f4R7R/CRITCxle2PYT91IaaB6vVw
	 6BGLL2JfioC6/mJeZs1OtkHlzFqGDH/aowWNkI18=
Date: Sun, 18 Jan 2026 12:38:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: zishun yi <zishun.yi.dev@gmail.com>
Cc: shuah@kernel.org, vivek.kasireddy@intel.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com
Subject: Re: [PATCH v1] selftests: udmabuf: fix hugepage size calculation
Message-Id: <20260118123825.c124bd2e01fabc1d78620d87@linux-foundation.org>
In-Reply-To: <20260118135126.102472-1-zishun.yi.dev@gmail.com>
References: <20260118135126.102472-1-zishun.yi.dev@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 21:51:26 +0800 zishun yi <zishun.yi.dev@gmail.com> wrote:

> udmabuf's test 6 and 7 is intended to verify the behavior of 2MB huge pages migration,
> but the helper function still calculates the size using standard (4KB) pages.
> 

lgtm.  Vivek, can you please check it?  Feel free to merge into another
tree and I'll drop the mm.git ccopy.

> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -69,7 +69,7 @@ static int create_udmabuf_list(int devfd, int memfd, off64_t memfd_size)
>  	for (i = 0; i < NUM_ENTRIES; i++) {
>  		list->list[i].memfd  = memfd;
>  		list->list[i].offset = i * (memfd_size / NUM_ENTRIES);
> -		list->list[i].size   = getpagesize() * NUM_PAGES;
> +		list->list[i].size   = page_size * NUM_PAGES;
>  	}
>  
>  	list->count = NUM_ENTRIES;
> @@ -115,8 +115,8 @@ static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
>  	while (i < NUM_ENTRIES) {
>  		off = i * (memfd_size / NUM_ENTRIES);
>  		for (j = 0; j < NUM_PAGES; j++, k++) {
> -			char1 = *((char *)addr1 + off + (j * getpagesize()));
> -			char2 = *((char *)addr2 + (k * getpagesize()));
> +			char1 = *((char *)addr1 + off + (j * page_size));
> +			char2 = *((char *)addr2 + (k * page_size));
>  			if (char1 != char2) {
>  				ret = -1;
>  				goto err;
> @@ -126,7 +126,7 @@ static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
>  	}
>  err:
>  	munmap(addr1, memfd_size);
> -	munmap(addr2, NUM_ENTRIES * NUM_PAGES * getpagesize());
> +	munmap(addr2, NUM_ENTRIES * NUM_PAGES * page_size);
>  	return ret;
>  }
>  
> @@ -240,7 +240,7 @@ int main(int argc, char *argv[])
>  	addr1 = mmap_fd(memfd, size);
>  	write_to_memfd(addr1, size, 'a');
>  	buf = create_udmabuf_list(devfd, memfd, size);
> -	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
> +	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * page_size);
>  	write_to_memfd(addr1, size, 'b');
>  	ret = compare_chunks(addr1, addr2, size);
>  	if (ret < 0)
> @@ -256,7 +256,7 @@ int main(int argc, char *argv[])
>  	size = MEMFD_SIZE * page_size;
>  	memfd = create_memfd_with_seals(size, true);
>  	buf = create_udmabuf_list(devfd, memfd, size);
> -	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
> +	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * page_size);
>  	addr1 = mmap_fd(memfd, size);
>  	write_to_memfd(addr1, size, 'a');
>  	write_to_memfd(addr1, size, 'b');
> -- 
> 2.52.0

