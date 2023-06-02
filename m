Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF6720781
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjFBQZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbjFBQZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:25:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02CBE44;
        Fri,  2 Jun 2023 09:25:24 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A69526603219;
        Fri,  2 Jun 2023 17:25:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685723123;
        bh=C47gbnaLE3FpJnFXLSuBsIZ0ri3JV8UzEv6qEz546uE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=d5Sfx7KGHO1wZ3AQtdiU3MWsx4Y1GYIBZWGc8oAf1N/Pfu5FOzaAvY9D3oWWG6bAa
         4FYzQoNqEfGJOVifEUx3cX+kyYgcI1JfKlPPgO34CbwELpMjCAaM/7iopfwcRk/Pcs
         N5YVsmFHt1agKn2NLRz9TQAw8T9HWSEfiP4RoPWYQl0WTCmbREcocVvYCECa6+QFq7
         DuQ9wv2/6vuA40K09aycN+oGyy+LLtZf8hqmebLoBNwLsNypZYNMD8VA0E/uvmfh/i
         2jS1DUoKs5tfUYtvLnzqMuwnwgYvsr0jcIXfia8ft2iujVq/nikpW6GNBpoSFTXK92
         fAj+ZTaTUKm7A==
Message-ID: <bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com>
Date:   Fri, 2 Jun 2023 21:25:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230602013358.900637-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 6:33 AM, John Hubbard wrote:
> UFFDIO_CONTINUE_MODE_WP, UFFD_FEATURE_WP_UNPOPULATED, USERFAULTFD_IOC,
> and USERFAULTFD_IOC_NEW are needed lately, but they are not in my host
> (Arch Linux) distro's userfaultfd.h yet. So put them in here.
Selftests are never supposed to build with native header files. Build the
headers in kernel source first. Then building the selftests picks up these
newly built headers by itself. The method to build header files has changed
to `make headers`. The following command builds the mm selftests
successfully every time for me.

make headers && make -C tools/testing/selftests/mm

Please let me know if this doesn't work for you. I'll try to reproduce and fix.

> 
> A better approach would be to include the uapi version of userfaultfd.h
> from the kernel tree, but that currently fails with rather difficult
> linker problems (__packed is defined multiple times, ugg), so defer that
> to another day and just fix the build for now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/uffd-common.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index a1cdb78c0762..98847e41ecf9 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -36,6 +36,23 @@
>  
>  #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
>  
> +#ifndef UFFDIO_CONTINUE_MODE_WP
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
> +#endif
> +
> +#ifndef UFFD_FEATURE_WP_UNPOPULATED
> +#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
> +#endif
> +
> +/* ioctls for /dev/userfaultfd */
> +#ifndef USERFAULTFD_IOC
> +#define USERFAULTFD_IOC 0xAA
> +#endif
> +
> +#ifndef USERFAULTFD_IOC_NEW
> +#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
> +#endif
> +
>  #define _err(fmt, ...)						\
>  	do {							\
>  		int ret = errno;				\

-- 
BR,
Muhammad Usama Anjum
