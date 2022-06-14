Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18FC54BAD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 21:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiFNTnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344628AbiFNTnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 15:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E0F42AE39
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655235790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaTfScKXlrbTkiP4vfe3NQO4/VTa9RTXFc7gSdqVKa8=;
        b=IPOaed6bVCv7yyNToEtqYuBy3+/rYNUwgcjkBtb6gKZLPKcAHKAz3aaH3dPZ5XQ/I4GlFy
        T1v2ZGq1SYkwiiGSd2DGKbHXjZZOKPgC5bPJOvOI1kq2YPhzbV1uDG66iMulzkNakwDH/x
        2/1HaRlM0w2tn8Fx0vAMR/tEwcnc35Y=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-1nuX5NoANQeEg4hIKJ9qyg-1; Tue, 14 Jun 2022 15:43:09 -0400
X-MC-Unique: 1nuX5NoANQeEg4hIKJ9qyg-1
Received: by mail-il1-f197.google.com with SMTP id a3-20020a924443000000b002d1bc79da14so7167085ilm.15
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 12:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vaTfScKXlrbTkiP4vfe3NQO4/VTa9RTXFc7gSdqVKa8=;
        b=MBoPkdYzc9qy3gUKgRVrG0dHXbIpAXnhuZbJr+ZhE49Sajv2OmmY+iU9U+zCO4IDcl
         JkVLYzBx3r09XeeBRaJxIRWlYyijg/BgNWXiwU8852NDksqz5G/ndZEpMrwyAFHoAnQj
         d1wxA4ppKaYi0BtuLHy7/j52xX+QR2qhayLKS4fk9+5LnIOIly9WfxtaOjru58baGJSc
         1BQQWsGO3teVUqWMci//g/eKtoKs1OobLLwpop4Z8x2T0b4aKQONbbLCc2AtRBK8s1rA
         NmcD6iSDMQgdEV892YacPe3sgQNZZZn0kIyES8y3kMCTVHfrCV9eex+ItMEGXJetAWk/
         vuAw==
X-Gm-Message-State: AOAM531HGJwpdsMKNC8pqvIGS3icANvz8rjP+oZ7Flj6pFDktad9m1rH
        G6Tidcvf7tGYfZBvzCmUlTBwziz9YCA+IV2lgcZ2jpizQkn0/Qiy3ZWmQ0VU4yoD8lYeuMyD5uW
        fnquJmlfBiKeKDNgN+HKyFDtSQM9T
X-Received: by 2002:a05:6638:1117:b0:331:4bc8:3856 with SMTP id n23-20020a056638111700b003314bc83856mr3502723jal.128.1655235788319;
        Tue, 14 Jun 2022 12:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS4BXo6S8IqsfxYTIzMi93s0rW45hsfYOZO/scnT22HT25Sk1w2c81oGFG69c9SFrDXgIoxA==
X-Received: by 2002:a05:6638:1117:b0:331:4bc8:3856 with SMTP id n23-20020a056638111700b003314bc83856mr3502694jal.128.1655235788033;
        Tue, 14 Jun 2022 12:43:08 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g18-20020a02c552000000b00332122c106dsm5261847jaj.152.2022.06.14.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:43:07 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:43:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/6] userfaultfd: selftests: make /dev/userfaultfd
 testing configurable
Message-ID: <YqjkyFIgPSuXK+dz@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:50PM -0700, Axel Rasmussen wrote:
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

Yes, when I was reading your other patch I was wishing no timeout of any of
QE testbeds could trigger.

If you plan to remove it anyway, mind to squash these?

> 
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 41 +++++++++++++++++-------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 1badb5d31bf9..aeee6f1ad8ef 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -128,6 +128,8 @@ struct uffd_stats {
>  const char *examples =
>      "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
>      "./userfaultfd anon 100 99999\n\n"
> +    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
> +    "./userfaultfd anon:dev 100 99999\n\n"
>      "# Run share memory test on 1GiB region with 99 bounces:\n"
>      "./userfaultfd shmem 1000 99\n\n"
>      "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
> @@ -144,6 +146,13 @@ static void usage(void)
>  		"[hugetlbfs_file]\n\n");
>  	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
>  		"hugetlb_shared, shmem\n\n");
> +	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
> +		"Supported mods:\n");
> +	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");

That looks better than running everything by default twice. Though let's
also provide "syscall" if we're at it, anyway?

Thanks,

> +	fprintf(stderr, "\nExample test mod usage:\n");
> +	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
> +	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
> +
>  	fprintf(stderr, "Examples:\n\n");
>  	fprintf(stderr, "%s", examples);
>  	exit(1);
> @@ -1607,8 +1616,6 @@ unsigned long default_huge_page_size(void)
>  
>  static void set_test_type(const char *type)
>  {
> -	uint64_t features = UFFD_API_FEATURES;
> -
>  	if (!strcmp(type, "anon")) {
>  		test_type = TEST_ANON;
>  		uffd_test_ops = &anon_uffd_test_ops;
> @@ -1626,10 +1633,28 @@ static void set_test_type(const char *type)
>  		test_type = TEST_SHMEM;
>  		uffd_test_ops = &shmem_uffd_test_ops;
>  		test_uffdio_minor = true;
> -	} else {
> -		err("Unknown test type: %s", type);
> +	}
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
>  	}
>  
> +	if (!test_type)
> +		err("failed to parse test type argument: '%s'", raw_type);
> +
>  	if (test_type == TEST_HUGETLB)
>  		page_size = default_huge_page_size();
>  	else
> @@ -1676,7 +1701,7 @@ int main(int argc, char **argv)
>  		err("failed to arm SIGALRM");
>  	alarm(ALARM_INTERVAL_SECS);
>  
> -	set_test_type(argv[1]);
> +	parse_test_type_arg(argv[1]);
>  
>  	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
> @@ -1714,12 +1739,6 @@ int main(int argc, char **argv)
>  	}
>  	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>  	       nr_pages, nr_pages_per_cpu);
> -
> -	test_dev_userfaultfd = false;
> -	if (userfaultfd_stress())
> -		return 1;
> -
> -	test_dev_userfaultfd = true;
>  	return userfaultfd_stress();
>  }
>  
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

-- 
Peter Xu

