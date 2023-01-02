Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284CD65B2AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 14:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjABNdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 08:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjABNdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 08:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DE06355
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Jan 2023 05:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672666379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf3kR395pYwqA1hDnRNy8gcAAOWiiQwet+tWNkQj444=;
        b=Bz6PHhbRDDZ12FGLjmSfvNfGgbyC25vWGKqxsljUHKk7HQFUk4c0iermX0nkyoVnMUb3/7
        HT1p30iy/Bh4AEc/FybyBDJNHSlcVZ2i3Ym/KtbvlOwZopRhpuu5bH5gKppnU/dtJxWGbQ
        6oiJV9OGW6uM+hJcaNXe/BN7Nfh2xKc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-H4d25Cz3MKCT4fPNookZaw-1; Mon, 02 Jan 2023 08:32:58 -0500
X-MC-Unique: H4d25Cz3MKCT4fPNookZaw-1
Received: by mail-wm1-f71.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so13666365wmb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jan 2023 05:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf3kR395pYwqA1hDnRNy8gcAAOWiiQwet+tWNkQj444=;
        b=AxW/iCH4H7GOQySQXbDeEhu6fw09C9ikmvE7zIoi5I1qSj0zC4Lig7pHtYUSqsII7A
         EKy0cqWsozNNmNipSjhvwMXPqR4Qnb2H9QcAXja+IAnlMLmEupAQ0dipq9PJ8zENp3Z6
         8hiZZPubEdmxYUl75VBSiWYXIasDLNHQL3NR6BVokV5M7rey0EIwjf5zjU8pu4Nn8d1N
         wXxBIym71hXIIVRDnXntk/V1Tccxx5dpOVYmpINMf9BNKDCk7WuhDI7+S8e2IrmjWXxa
         UQ1jHXj1ocb1D9hdsSBvPYvh5omG8au/M3yDoNVoNHYTu7aoUleNExgq9K5J2i9eFyvY
         D/7Q==
X-Gm-Message-State: AFqh2kpNRbtNdrCk0mHiS86Olbhrjo+UiY5bwNmhN/Z3GOySWYLqI8PB
        +5QG3x/Vg5Nhz7DJYCxmnFuJzAoEsHIJ2qxXbQYbUBctnKMos3ROIyHH156cZwxhBkjHh5vE6qL
        gTM6MzK3TBN+coPC3EbEqFmZHJqlp
X-Received: by 2002:a5d:6981:0:b0:295:6a4f:4183 with SMTP id g1-20020a5d6981000000b002956a4f4183mr3892125wru.5.1672666376982;
        Mon, 02 Jan 2023 05:32:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuTroukUmayWIpORUsIu0s5r1kR+m7Bbv0WwOS61I2SOMs9zaoctF+J0dg2oEIwuRTXm9+zWQ==
X-Received: by 2002:a5d:6981:0:b0:295:6a4f:4183 with SMTP id g1-20020a5d6981000000b002956a4f4183mr3892110wru.5.1672666376656;
        Mon, 02 Jan 2023 05:32:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b0027dcc2d6fc3sm21328801wrm.113.2023.01.02.05.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 05:32:56 -0800 (PST)
Message-ID: <d394c380-8f2c-7b8d-3915-7b8b201bb7de@redhat.com>
Date:   Mon, 2 Jan 2023 14:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <20221216214436.405071-1-lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] selftest/vm: add mremap expand merge offset test
In-Reply-To: <20221216214436.405071-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16.12.22 22:44, Lorenzo Stoakes wrote:
> Add a test to assert that we can mremap() and expand a mapping starting
> from an offset within an existing mapping. We unmap the last page in a 3
> page mapping to ensure that the remap should always succeed, before
> remapping from the 2nd page.
> 
> This is additionally a regression test for the issue solved in "mm, mremap:
> fix mremap() expanding vma with addr inside vma" and confirmed to fail
> prior to the change and pass after it.
> 
> Finally, this patch updates the existing mremap expand merge test to check
> error conditions and reduce code duplication between the two tests.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   tools/testing/selftests/vm/mremap_test.c | 111 +++++++++++++++++++----
>   1 file changed, 93 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> index 9496346973d4..28a17d4e8afd 100644
> --- a/tools/testing/selftests/vm/mremap_test.c
> +++ b/tools/testing/selftests/vm/mremap_test.c
> @@ -119,30 +119,19 @@ static unsigned long long get_mmap_min_addr(void)
>   }
> 
>   /*
> - * This test validates that merge is called when expanding a mapping.
> - * Mapping containing three pages is created, middle page is unmapped
> - * and then the mapping containing the first page is expanded so that
> - * it fills the created hole. The two parts should merge creating
> - * single mapping with three pages.
> + * Using /proc/self/maps, assert that the specified address range is contained
> + * within a single mapping.
>    */
> -static void mremap_expand_merge(unsigned long page_size)
> +static bool is_range_mapped(void *start, void *end)
>   {
> -	char *test_name = "mremap expand merge";
>   	FILE *fp;
>   	char *line = NULL;
>   	size_t len = 0;
>   	bool success = false;
> -	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> -			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -
> -	munmap(start + page_size, page_size);
> -	mremap(start, page_size, 2 * page_size, 0);
> 
>   	fp = fopen("/proc/self/maps", "r");
> -	if (fp == NULL) {
> -		ksft_test_result_fail("%s\n", test_name);
> -		return;
> -	}
> +	if (fp == NULL)
> +		return false;

This is unexpected. It would be valuable to ksft_print_msg("[INFO] .." 
something, indicating that we don't know because we cannot access that info.

ksft_print_msg("[INFO] Opening /proc/self/maps failed"


But I'd even suggest opening "/proc/self/maps" once in main() and 
failing directly there. Then we don't have to worry about it here.

> 
>   	while (getline(&line, &len, fp) != -1) {
>   		char *first = strtok(line, "- ");
> @@ -150,16 +139,101 @@ static void mremap_expand_merge(unsigned long page_size)
>   		char *second = strtok(NULL, "- ");
>   		void *second_val = (void *) strtol(second, NULL, 16);
> 
> -		if (first_val == start && second_val == start + 3 * page_size) {
> +		if (first_val <= start && second_val >= end) {
>   			success = true;
>   			break;
>   		}
>   	}
> +
> +	fclose(fp);
> +	return success;
> +}
> +
> +/*
> + * This test validates that merge is called when expanding a mapping.
> + * Mapping containing three pages is created, middle page is unmapped
> + * and then the mapping containing the first page is expanded so that
> + * it fills the created hole. The two parts should merge creating
> + * single mapping with three pages.
> + */
> +static void mremap_expand_merge(unsigned long page_size)
> +{
> +	char *test_name = "mremap expand merge";
> +	bool success = false;
> +	int errsv = 0;
> +	char *remap;
> +	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

I'd suggest


	char *remap, *start;

	start = mmap()
	if (start == MAP_FAILED) { ...

to make this easier to read.

> +
> +	if (start == MAP_FAILED) {
> +		errsv = errno;
> +		goto error;
> +	}
> +
> +	munmap(start + page_size, page_size);
> +	remap = mremap(start, page_size, 2 * page_size, 0);
> +	if (remap == MAP_FAILED) {
> +		errsv = errno;
> +		munmap(start, page_size);
> +		munmap(start + 2 * page_size, page_size);
> +		goto error;
> +	}
> +
> +	success = is_range_mapped(start, start + 3 * page_size);
> +
> +	munmap(start, 3 * page_size);
> +	goto out;
> +
> +error:
> +	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
> +		       strerror(errsv));

Please avoid the "error" label and just print proper errors directly at 
the two callsites. Then, remove the "goto out".

> +out:
> +	if (success)
> +		ksft_test_result_pass("%s\n", test_name);
> +	else
> +		ksft_test_result_fail("%s\n", test_name);
> +}
> +
> +/*
> + * Similar to mremap_expand_merge() except instead of removing the middle page,
> + * we remove the last then attempt to remap offset from the second page. This
> + * should result in the mapping being restored to its former state.
> + */
> +static void mremap_expand_merge_offset(unsigned long page_size)
> +{
> +
> +	char *test_name = "mremap expand merge offset";
> +	bool success = false;
> +	int errsv = 0;
> +	char *remap;
> +	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Dito.

> +
> +	if (start == MAP_FAILED) {
> +		errsv = errno;
> +		goto error;
> +	}
> +
> +	/* Unmap final page to ensure we have space to expand. */
> +	munmap(start + 2 * page_size, page_size);
> +	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
> +	if (remap == MAP_FAILED) {
> +		errsv = errno;
> +		munmap(start, 2 * page_size);
> +		goto error;
> +	}
> +
> +	success = is_range_mapped(start, start + 3 * page_size);
> +	goto out;
> +
> +error:
> +	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
> +		       strerror(errsv));

Dito.

> +out:


-- 
Thanks,

David / dhildenb

