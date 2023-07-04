Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF385747967
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 23:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGDVEx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 17:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjGDVEw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 17:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9878E170A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688504632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTm5iRt8zflfiJ3ZPlJNpWMOOG3kiO0nsowNZ4n8eHM=;
        b=DCquZtGd2/sBTpoCQIoiRFVQhgEoxublmgwL2tIXsd+AKsXG3czjiHm6Z7Q1QCaX1qO6+P
        qIsXZDO95VtV2aUesgIb9BG7T4i4LPXmMUEvTzPI0oyRCGQUN6ULhIpqTYpA24txDwOayT
        n4i7UH2kXzE06OkT+lbDCQCYjFBnywU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-XkAAvC7ZO-2Pg75z2AzFWg-1; Tue, 04 Jul 2023 17:03:51 -0400
X-MC-Unique: XkAAvC7ZO-2Pg75z2AzFWg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-b96a5d9abfbso860239276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 14:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688504631; x=1691096631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTm5iRt8zflfiJ3ZPlJNpWMOOG3kiO0nsowNZ4n8eHM=;
        b=CO6zcU6516u4oGFuA6uburBjOGvO4Ii4tv1pQTeT6gb4YRnHGjWhBfk5tM2/n7ikUK
         lu87H6PNGvIkQy4xB7tV/PyQNS5MZHkhd9pkUWqhcbJAPD88u3shmmuBpP4D1v2BJ16i
         8vSLU8CcdoKgj81B7/1/RyQ/4dnodkReVWtBYokxVXwbkRL9UdQ3EZQ/wqsieRP+q8g5
         kG9i8B6xvnR0CL9vOnCJJvsYtync6KqAy7tWXTJfFKmWl/oP04nolxcbqG9zbyUhoR1t
         rxsSz4eyRH8E8Mn3fZ6LWwUVgUTCi6H3a1c1oaNvCryJR+s7lc5E4ROGpRXR4+qcmdkp
         tIVA==
X-Gm-Message-State: ABy/qLY8ofliEolBhD7RWqdmqrvDsygwr/dKLBdQqjOhInHOl1GWs8+2
        0qaU53hlvqqk9G1YJho9Z/avR0PfVPNgBRXh9xGAetm/qImWaSvHxtn8wGInsTKuQDX8YEVX+uv
        z6FJpJ7aUhfTm/9Bmtkbs5fq9GzJ/
X-Received: by 2002:a81:5256:0:b0:577:296:af5d with SMTP id g83-20020a815256000000b005770296af5dmr7772619ywb.0.1688504630735;
        Tue, 04 Jul 2023 14:03:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEU/ddMX0V6QpVOJVqAhiVXSKzIzTOTMOOXQz51O8ktL/Z6iFKhrgoHJai7fICleSqWD0LAdw==
X-Received: by 2002:a81:5256:0:b0:577:296:af5d with SMTP id g83-20020a815256000000b005770296af5dmr7772596ywb.0.1688504630457;
        Tue, 04 Jul 2023 14:03:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id pv16-20020ad45490000000b0063019b482f8sm12934335qvb.85.2023.07.04.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 14:03:50 -0700 (PDT)
Date:   Tue, 4 Jul 2023 17:03:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/6] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
Message-ID: <ZKSJNB3BbCiPxcdD@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629205040.665834-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 01:50:38PM -0700, Axel Rasmussen wrote:
> Previously, we had "one fault handler to rule them all", which used
> several branches to deal with all of the scenarios required by all of
> the various tests.
> 
> In upcoming patches, I plan to add a new test, which has its own
> slightly different fault handling logic. Instead of continuing to add
> cruft to the existing fault handler, let's allow tests to define custom
> ones, separate from other tests.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c |  5 ++++-
>  tools/testing/selftests/mm/uffd-common.h |  3 +++
>  tools/testing/selftests/mm/uffd-stress.c | 12 +++++++-----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index ba20d7504022..02b89860e193 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -499,6 +499,9 @@ void *uffd_poll_thread(void *arg)
>  	int ret;
>  	char tmp_chr;
>  
> +	if (!args->handle_fault)
> +		args->handle_fault = uffd_handle_page_fault;
> +
>  	pollfd[0].fd = uffd;
>  	pollfd[0].events = POLLIN;
>  	pollfd[1].fd = pipefd[cpu*2];
> @@ -527,7 +530,7 @@ void *uffd_poll_thread(void *arg)
>  			err("unexpected msg event %u\n", msg.event);
>  			break;
>  		case UFFD_EVENT_PAGEFAULT:
> -			uffd_handle_page_fault(&msg, args);
> +			args->handle_fault(&msg, args);
>  			break;
>  		case UFFD_EVENT_FORK:
>  			close(uffd);
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 197f5262fe0d..7c4fa964c3b0 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -77,6 +77,9 @@ struct uffd_args {
>  	unsigned long missing_faults;
>  	unsigned long wp_faults;
>  	unsigned long minor_faults;
> +
> +	/* A custom fault handler; defaults to uffd_handle_page_fault. */
> +	void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args);
>  };
>  
>  struct uffd_test_ops {
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 995ff13e74c7..50b1224d72c7 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -189,10 +189,8 @@ static int stress(struct uffd_args *args)
>  				   locking_thread, (void *)cpu))
>  			return 1;
>  		if (bounces & BOUNCE_POLL) {
> -			if (pthread_create(&uffd_threads[cpu], &attr,
> -					   uffd_poll_thread,
> -					   (void *)&args[cpu]))
> -				return 1;
> +			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
> +				err("uffd_poll_thread create");

irrelevant change?

>  		} else {
>  			if (pthread_create(&uffd_threads[cpu], &attr,
>  					   uffd_read_thread,
> @@ -247,9 +245,13 @@ static int userfaultfd_stress(void)
>  {
>  	void *area;
>  	unsigned long nr;
> -	struct uffd_args args[nr_cpus];
> +	struct uffd_args *args;
>  	uint64_t mem_size = nr_pages * page_size;
>  
> +	args = calloc(nr_cpus, sizeof(struct uffd_args));
> +	if (!args)
> +		err("allocating args array failed");
> +

It's leaked?

Isn't "args[] = { 0 }" already working?

Thanks,

>  	if (uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED, NULL))
>  		err("context init failed");
>  
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
Peter Xu

