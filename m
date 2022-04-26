Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8C15104BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353555AbiDZQ7x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353548AbiDZQ7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 12:59:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB21694A9
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 09:56:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e15so2782035iob.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MAOTSTL0j+UcFq0k0W+NNQYDSwGOqBSru0X+peZ2tA=;
        b=iA2K3qO8Mlk9Ua5NjrBg7SmrDhCgy+pnsrScAgZU37nA18Dm8vLoa9Dp2FRpO9sKY0
         T9kvBZ2a/hRsCYUaB2kLLZIZ79LiJ0YL3cDg79Mghbe9aioh/H9FbzsScRypM4iG9Y/d
         dbhCai6A7UI6fc4WVd3kl50Wber7nSoR9Lvps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MAOTSTL0j+UcFq0k0W+NNQYDSwGOqBSru0X+peZ2tA=;
        b=6YJLBM0P9XqFU1OGVbZIA2+U3O2tC9uyRYD5I1zyD86pFAn7UykzW3mb7dNRIVU/kI
         CkJZWATTkBKgsmnGGi2LFV0RXNj8bFNaVznBFgEQX2h3W7/ik6bUw2Y2MY0gg7gsrCh6
         SoIrLF8ulzN5IjTqJdI5gdz2q/1TsbhREDwIhCQXd7vmWLPI3pA+3NDz+8fvgg2mAJMr
         T1heEX0n/C7yrxW85v9FOQ6y7MVaSRW6NtztPvlu49WzQe2NNcHifsOgDR9E/46J/OUP
         jJmc+Mzl83tfPNTye0J/MohmPV8dxbFrHzdCb81BhSKRFAHKDGj2iD2mh4u1eCLtVuMj
         9Xkg==
X-Gm-Message-State: AOAM532GvvNjVbDnx8GH/hyORQ2qE5wBXDWzw2TPcTz+GXJOzzGBsCbT
        wWXA+5B1Kg2LKgqF8NjxOK6ftQ==
X-Google-Smtp-Source: ABdhPJw+4LWQEWNEpInmZrszTqCnuD5qjkIzY/NRqRzX9Ur1stkAuK0Wq5fbUx1+HQ2belv6VdSIkw==
X-Received: by 2002:a05:6638:358b:b0:326:4717:90d4 with SMTP id v11-20020a056638358b00b00326471790d4mr10891855jal.136.1650992199826;
        Tue, 26 Apr 2022 09:56:39 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y21-20020a6bc415000000b00648da092c8esm9737462ioa.14.2022.04.26.09.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 09:56:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] userfaultfd: selftests: make /dev/userfaultfd
 testing configurable
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-6-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bceb4b77-24fa-7654-0c59-fc858bea096a@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 10:56:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220422212945.2227722-6-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> let the user choose which to test.
> 
> As with other test features, change the behavior based on a new
> command line flag. Introduce the idea of "test mods", which are
> generic (not specific to a test type) modifications to the behavior of
> the test. This is sort of borrowed from this RFC patch series [1], but
> simplified a bit.
> 
> The benefit is, in "typical" configurations this test is somewhat slow
> (say, 30sec or something). Testing both clearly doubles it, so it may
> not always be desirable, as users are likely to use one or the other,
> but never both, in the "real world".
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 41 +++++++++++++++++-------
>   1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 12ae742a9981..274522704e40 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -142,8 +142,17 @@ static void usage(void)
>   {
>   	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
>   		"[hugetlbfs_file]\n\n");
> +

Remove the extra blank line here.

>   	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
>   		"hugetlb_shared, shmem\n\n");
> +

Remove the extra blank line here.

> +	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
> +		"Supported mods:\n");
> +	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
> +	fprintf(stderr, "\nExample test mod usage:\n");
> +	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
> +	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
> +
>   	fprintf(stderr, "Examples:\n\n");
>   	fprintf(stderr, "%s", examples);

Update examples above with new test cases if any.

>   	exit(1);
> @@ -1610,8 +1619,6 @@ unsigned long default_huge_page_size(void)
>   
>   static void set_test_type(const char *type)
>   {
> -	uint64_t features = UFFD_API_FEATURES;
> -
>   	if (!strcmp(type, "anon")) {
>   		test_type = TEST_ANON;
>   		uffd_test_ops = &anon_uffd_test_ops;
> @@ -1631,10 +1638,28 @@ static void set_test_type(const char *type)
>   		test_type = TEST_SHMEM;
>   		uffd_test_ops = &shmem_uffd_test_ops;
>   		test_uffdio_minor = true;
> -	} else {
> -		err("Unknown test type: %s", type);
> +	}

At this point, it might make it so much easier and maintainable if
we were to use getopt instead of parsing options.

> +}
> +
> +static void parse_test_type_arg(const char *raw_type)
> +{
> +	char *buf = strdup(raw_type);
> +	uint64_t features = UFFD_API_FEATURES;
> +
> +	while (buf) {
> +		const char *token = strsep(&buf, ":");
> +
> +		if (!test_type)
> +			set_test_type(token);
> +		else if (!strcmp(token, "dev"))
> +			test_dev_userfaultfd = true;
> +		else
> +			err("unrecognized test mod '%s'", token);
>   	}
>   
> +	if (!test_type)
> +		err("failed to parse test type argument: '%s'", raw_type);
> +
>   	if (test_type == TEST_HUGETLB)
>   		page_size = default_huge_page_size();
>   	else
> @@ -1681,7 +1706,7 @@ int main(int argc, char **argv)
>   		err("failed to arm SIGALRM");
>   	alarm(ALARM_INTERVAL_SECS);
>   
> -	set_test_type(argv[1]);
> +	parse_test_type_arg(argv[1]);
>   
>   	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>   	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
> @@ -1719,12 +1744,6 @@ int main(int argc, char **argv)
>   	}
>   	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>   	       nr_pages, nr_pages_per_cpu);
> -
> -	test_dev_userfaultfd = false;
> -	if (userfaultfd_stress())
> -		return 1;
> -
> -	test_dev_userfaultfd = true;
>   	return userfaultfd_stress();
>   }
>   
> 

Same comments as before on fail vs. skip conditions to watch out
for and report them correctly.

thanks,
-- Shuah

