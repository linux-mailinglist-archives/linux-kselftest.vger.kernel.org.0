Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E06723A91
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjFFHw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFFHwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:52:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB12270C;
        Tue,  6 Jun 2023 00:48:36 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B02776602242;
        Tue,  6 Jun 2023 08:48:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037715;
        bh=JhbByRlc6EGRRYGw0Ja885SVDTyM19OMADJSBxVAHMQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jZCrUbuXc5HBQl7ZnAG9GwfIUKrSJyfWYwn/H5AzCKlu/M5kCg7hlaPhvkcCIBgaO
         tJYP4dhCc4+2UV/R48mZsep/zKOErtgFWKOV7wUwpkibe++m/f2UzSI/z9WzT3zCf3
         lsyO6u8o5iGF8vJI0QSyrMiM4gaRtftzzAp6GZvd4juO54Ra2JxRI+xNmQKr2yQCie
         NH6KrJy6dvj2V1w/FubZH8QPHrd3SnkygET47BviXOPwhHfUxEdl0HI7N81idecZ2F
         sJsAtzo2bEJ4+yOew7Ay/+/KT6mpkNxkrqnR1/uGPa8YiZ7Ltah9RvL4/2pT20ma0d
         4589MziVr8rmg==
Message-ID: <b069d5c5-7ea0-6960-74de-dcc6caf81a5e@collabora.com>
Date:   Tue, 6 Jun 2023 12:48:29 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] selftests/mm: fix unused variable warnings in
 hugetlb-madvise.c, migration.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-3-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-3-jhubbard@nvidia.com>
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

On 6/6/23 12:16 PM, John Hubbard wrote:
> Dummy variables are required in order to make these two (similar)
> routines work, so in both cases, declare the variables as volatile in
> order to avoid the clang compiler warning.
> 
> Furthermore, in order to ensure that each test actually does what is
> intended, add an asm volatile invocation (thanks to David Hildenbrand
> for the suggestion), with a clarifying comment so that it survives
> future maintenance.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
>  tools/testing/selftests/mm/migration.c       | 5 ++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 28426e30d9bc..d55322df4b73 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>  
>  void read_fault_pages(void *addr, unsigned long nr_pages)
>  {
> -	unsigned long dummy = 0;
> +	volatile unsigned long dummy = 0;
>  	unsigned long i;
>  
> -	for (i = 0; i < nr_pages; i++)
> +	for (i = 0; i < nr_pages; i++) {
>  		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
> +
> +		/* Prevent the compiler from optimizing out the entire loop: */
> +		asm volatile("" : "+r" (dummy));
> +	}
>  }
>  
>  int main(int argc, char **argv)
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 1cec8425e3ca..379581567f27 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
>  
>  void *access_mem(void *ptr)
>  {
> -	uint64_t y = 0;
> +	volatile uint64_t y = 0;
>  	volatile uint64_t *x = ptr;
>  
>  	while (1) {
>  		pthread_testcancel();
>  		y += *x;
> +
> +		/* Prevent the compiler from optimizing out the writes to y: */
> +		asm volatile("" : "+r" (y));
>  	}
>  
>  	return NULL;

-- 
BR,
Muhammad Usama Anjum
