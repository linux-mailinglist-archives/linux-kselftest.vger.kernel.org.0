Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB24281E02
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJBWFW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 18:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJBWFW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 18:05:22 -0400
Received: from X1 (c-76-21-107-111.hsd1.ca.comcast.net [76.21.107.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD27C20719;
        Fri,  2 Oct 2020 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601676322;
        bh=A/PUNC/h74mMFqFuFyQBZzOM4+GqXQWYyk2J9FTBXHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gDd85F52dSGYlWT7WLjb6cPPYCWvYOjIS1DAhkHOAS81iXNE3o1e1VQntR7DqkM0x
         ud10WxaijIbe9zMe/BQYIddIVa2H5Eaib8MiYft0L1YO+xxfhMCf8rfHr/TC2PhIjq
         wcTv0vTS+IYJxrh6oaonopzTcGeq75KcRrd8cQNE=
Date:   Fri, 2 Oct 2020 15:05:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        Sri Jayaramappa <sjayaram@akamai.com>
Subject: Re: [PATCH 1/1] selftests/vm: 8x compaction_test speedup
Message-Id: <20201002150520.2ea3db53d88f8d10ba8348c9@linux-foundation.org>
In-Reply-To: <20201002080621.551044-2-jhubbard@nvidia.com>
References: <20201002080621.551044-1-jhubbard@nvidia.com>
        <20201002080621.551044-2-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2 Oct 2020 01:06:21 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> This patch reduces the running time for compaction_test from about 27
> sec, to 3.3 sec, which is about an 8x speedup.
> 
> These numbers are for an Intel x86_64 system with 32 GB of DRAM.
> 
> The compaction_test.c program was spending most of its time doing
> mmap(), 1 MB at a time, on about 25 GB of memory.
> 
> Instead, do the mmaps 100 MB at a time. (Going past 100 MB doesn't make
> things go much faster, because other parts of the program are using the
> remaining time.)

Seems nice.  It's been 5 years, but hopefully Sri is still at Akamai?

> --- a/tools/testing/selftests/vm/compaction_test.c
> +++ b/tools/testing/selftests/vm/compaction_test.c
> @@ -18,7 +18,8 @@
>  
>  #include "../kselftest.h"
>  
> -#define MAP_SIZE 1048576
> +#define MAP_SIZE_MB	100
> +#define MAP_SIZE	(MAP_SIZE_MB * 1024 * 1024)
>  
>  struct map_list {
>  	void *map;
> @@ -165,7 +166,7 @@ int main(int argc, char **argv)
>  	void *map = NULL;
>  	unsigned long mem_free = 0;
>  	unsigned long hugepage_size = 0;
> -	unsigned long mem_fragmentable = 0;
> +	long mem_fragmentable_MB = 0;
>  
>  	if (prereq() != 0) {
>  		printf("Either the sysctl compact_unevictable_allowed is not\n"
> @@ -190,9 +191,9 @@ int main(int argc, char **argv)
>  		return -1;
>  	}
>  
> -	mem_fragmentable = mem_free * 0.8 / 1024;
> +	mem_fragmentable_MB = mem_free * 0.8 / 1024;
>  
> -	while (mem_fragmentable > 0) {
> +	while (mem_fragmentable_MB > 0) {
>  		map = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
>  			   MAP_ANONYMOUS | MAP_PRIVATE | MAP_LOCKED, -1, 0);
>  		if (map == MAP_FAILED)
> @@ -213,7 +214,7 @@ int main(int argc, char **argv)
>  		for (i = 0; i < MAP_SIZE; i += page_size)
>  			*(unsigned long *)(map + i) = (unsigned long)map + i;
>  
> -		mem_fragmentable--;
> +		mem_fragmentable_MB -= MAP_SIZE_MB;
>  	}
>  
>  	for (entry = list; entry != NULL; entry = entry->next) {
> -- 
> 2.28.0
> 
