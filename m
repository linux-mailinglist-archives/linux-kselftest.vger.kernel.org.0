Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5865B44C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjABPfH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 10:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjABPfF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 10:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC19FF3
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Jan 2023 07:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672673659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+5ir2dAxOf4r5jAKNFoKfBMuHdGK8YeHk/tM6kCiR8=;
        b=amkt+7yFQkbWbAXrAhphe9SYm0yC8EfQbHNX8sjAHYeH5gDZ8qFtNKFsO097omb4HjQ/E6
        aFw/yzabO7XLCJlsF5mxNOd/rMX8YnWe/kGeiaf/8fhUtoLjwoIjX1o7ZxT/9X1cb+FPZi
        VtcUW4gkdjJapFT6hrTG66yNdGX8lKs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-5-fLp_wNN9yzwblDEGvxVg-1; Mon, 02 Jan 2023 10:34:17 -0500
X-MC-Unique: 5-fLp_wNN9yzwblDEGvxVg-1
Received: by mail-wr1-f72.google.com with SMTP id w20-20020adf8bd4000000b00272d0029f18so2678777wra.7
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jan 2023 07:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+5ir2dAxOf4r5jAKNFoKfBMuHdGK8YeHk/tM6kCiR8=;
        b=uSS7suGYm9vwVuTSaJyOvBy0bXTdvD1VV7lx/lnHc6uwxm3eihjggM+zqQ/RzT7/qV
         sayyBD8bB5niD4OCEcihrCXh54+Lgfc0SafnOjMW43crU+usSMy2/TWm2ErgUFGenR0x
         FgcpfvLDJjXI0IW+3AY5z31XLt5/lP1O3Te39sV7PehZPV59IQoIZp5qPXBmvGucElfZ
         x6ZlB4Urd6EMmXe1wlk45ssViP2yNnKy88HvPXzPzvcGhETwzQFMPsOHKpIl0tZwYHz+
         dyT/UIXFhvDHUgJqnd3M/DTw7wAes5SWuSpWLyxVj+hSX5FiIDeMWTJuRS21hDqVGctM
         8n0Q==
X-Gm-Message-State: AFqh2kpf+cDu/DBp/PFAjW1CJFe6zHxp8xNvJS7R3A7SsFGc2O/mYfm4
        xEI+1fGhERzb+W8+eiEPRdOXyNeN3L0V/YX4133R9JMucLhFUVjh2/8aQcKNsXGXoUWLt9rs3qI
        avL2ExijdBWDVW+YOrejuHw/eryXV
X-Received: by 2002:a05:600c:540b:b0:3d9:6b72:39c8 with SMTP id he11-20020a05600c540b00b003d96b7239c8mr24840375wmb.31.1672673656042;
        Mon, 02 Jan 2023 07:34:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXualOGi2mf4uyZVb3GyKqwUKW2Eq8B2soMduJPbwsGmd8IjQR6H6+2p6yI4quMvWqXU8ytGaA==
X-Received: by 2002:a05:600c:540b:b0:3d9:6b72:39c8 with SMTP id he11-20020a05600c540b00b003d96b7239c8mr24840364wmb.31.1672673655770;
        Mon, 02 Jan 2023 07:34:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b003d9980c5e7asm19574268wmq.21.2023.01.02.07.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:34:15 -0800 (PST)
Message-ID: <3a4fbe90-b46e-aa49-9866-e2b0cf6de38d@redhat.com>
Date:   Mon, 2 Jan 2023 16:34:14 +0100
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
References: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] selftest/vm: add mremap expand merge offset test
In-Reply-To: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.01.23 15:44, Lorenzo Stoakes wrote:
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
>   tools/testing/selftests/vm/mremap_test.c | 115 ++++++++++++++++++-----
>   1 file changed, 93 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c


...

> +
> +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	if (start == MAP_FAILED) {
> +		ksft_print_msg("mmap failed: %s\n", strerror(errno));

I'd

	ksft_test_result_fail(...)
	return;

> +		goto out;
> +	}
> +
> +	munmap(start + page_size, page_size);
> +	remap = mremap(start, page_size, 2 * page_size, 0);
> +	if (remap == MAP_FAILED) {
> +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
> +		munmap(start, page_size);
> +		munmap(start + 2 * page_size, page_size);
> +		goto out;

dito

	ksft_test_result_fail(...)
	...
	return;

> +	}
> +
> +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
> +	munmap(start, 3 * page_size);
> +
> +out:

then you can drop the out label.

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
> +static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
> +{
> +
> +	char *test_name = "mremap expand merge offset";
> +	bool success = false;
> +	char *remap, *start;
> +
> +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	if (start == MAP_FAILED) {
> +		ksft_print_msg("mmap failed: %s\n", strerror(errno));
> +		goto out;
> +	}
> +
> +	/* Unmap final page to ensure we have space to expand. */
> +	munmap(start + 2 * page_size, page_size);
> +	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
> +	if (remap == MAP_FAILED) {
> +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
> +		munmap(start, 2 * page_size);
> +		goto out;
> +	}
> +
> +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
> +	munmap(start, 3 * page_size);
> +
> +out:

dito.

>   	if (success)
>   		ksft_test_result_pass("%s\n", test_name);
>   	else
>   		ksft_test_result_fail("%s\n", test_name);
> -	fclose(fp);
>   }
>   
>   /*
> @@ -385,6 +447,7 @@ int main(int argc, char **argv)
>   	struct test perf_test_cases[MAX_PERF_TEST];
>   	int page_size;
>   	time_t t;
> +	FILE *maps_fp;

I'd simply use a global variable, same applies for page_size. But 
passing it around is also ok.

>   
>   	pattern_seed = (unsigned int) time(&t);
>   
> @@ -458,7 +521,15 @@ int main(int argc, char **argv)
>   		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
>   				     pattern_seed);
>   
> -	mremap_expand_merge(page_size);
> +	maps_fp = fopen("/proc/self/maps", "r");
> +	if (maps_fp == NULL) {
> +		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));

Maybe simply fail the test completely and return -errno ?

> +	} else {
> +		mremap_expand_merge(maps_fp, page_size);
> +		mremap_expand_merge_offset(maps_fp, page_size);
> +
> +		fclose(maps_fp);

No need to fclose, just keep it open ...

> +	}
>   
>   	if (run_perf_tests) {
>   		ksft_print_msg("\n%s\n",


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

