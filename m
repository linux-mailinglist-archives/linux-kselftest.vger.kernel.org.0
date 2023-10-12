Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96D7C797B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442975AbjJLWaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442949AbjJLWaU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 18:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47188B8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697149776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbxmea2WR8zy+HV2ZkU9FZ8WoeRWX3COQXG5xMnT4jQ=;
        b=CcBKVebU8QiGO3JEd1FGlPxfxM7HaeC8xidMLjutkXt3V2dg9JNzVRKw9RwbbJjinFg25W
        C+gUrSLc8LzIIUSU1O2rLBErZNEgNqEtrEqTWOtD8+jK37FqWzIMI1cWl8y0q0kQ1ISQ0b
        x9DXekJbYlxwKKQV2zhxoGK0rZDACec=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-AuclzfMIMEKldxCZ-dsOvg-1; Thu, 12 Oct 2023 18:29:35 -0400
X-MC-Unique: AuclzfMIMEKldxCZ-dsOvg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-57be3c78856so418624eaf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 15:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149774; x=1697754574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbxmea2WR8zy+HV2ZkU9FZ8WoeRWX3COQXG5xMnT4jQ=;
        b=lntLrOO+liV8bt2k3oHriMVzc5Q9+OYn8et4JIB4NiyvOTcJ/KNGrbEe+b+bneep5G
         sVAX45GbeH2CQHbhbLmFW2ceRPASDpIPyzRxS+2QyJ4OUbhR15CjrLUA4P6ELHTCwwrW
         vN0a1nsEBtuO27G79ZK8dVIf4NtDZTBzYpdg3wmilLPuWZeepwG8vPAU5VeRTL9uYpgO
         AHzkAGJG5lX0XhjcQSLyawRmol8XJlIMBMt1dff//y+1ErawbsJzTMkNvUyRy9FZj2WG
         V9JJJyJ8/BSU4trE9SWnsq67bptspCMSmsK6nLXzldXX/jo+Each+6CbaBLq4fs6K+zE
         u1fg==
X-Gm-Message-State: AOJu0YzB/N/A9j4ErKaGkAAB7rONAYODL+qDZv7Kx/nuuHQjYGdtQWRy
        FHwHXkXbHjEvVzxPpqwkK96kq7/xB9uliSv224h5ESNsjPuUJdhEpQCMOLYbG4urxb8CiwK7QkL
        Gl6u+aTWXJlJln1i2ol/7BUD1nSe0
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id y8-20020a4ade08000000b0056e94edc098mr24312383oot.0.1697149774478;
        Thu, 12 Oct 2023 15:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKHHvaCnJlAb5Fsh9rcCD5h1lwlP/+zLtgttVOz37fV94FHyyxcmOjUVsRA7iIBRv53WB5ZA==
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id y8-20020a4ade08000000b0056e94edc098mr24312360oot.0.1697149774169;
        Thu, 12 Oct 2023 15:29:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id et15-20020a056214176f00b0065896b9fb15sm150399qvb.29.2023.10.12.15.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:29:33 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:29:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 3/3] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZShzSvrN7FgdXi71@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009064230.2952396-4-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 08, 2023 at 11:42:28PM -0700, Suren Baghdasaryan wrote:
> Add a test for new UFFDIO_MOVE ioctl which uses uffd to move source
> into destination buffer while checking the contents of both after
> remapping. After the operation the content of the destination buffer
> should match the original source buffer's content while the source
> buffer should be zeroed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c     | 41 ++++++++++++-
>  tools/testing/selftests/mm/uffd-common.h     |  1 +
>  tools/testing/selftests/mm/uffd-unit-tests.c | 62 ++++++++++++++++++++
>  3 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 02b89860e193..ecc1244f1c2b 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -52,6 +52,13 @@ static int anon_allocate_area(void **alloc_area, bool is_src)
>  		*alloc_area = NULL;
>  		return -errno;
>  	}
> +
> +	/* Prevent source pages from collapsing into THPs */
> +	if (madvise(*alloc_area, nr_pages * page_size, MADV_NOHUGEPAGE)) {
> +		*alloc_area = NULL;
> +		return -errno;
> +	}

Can we move this to test specific code?

> +
>  	return 0;
>  }
>  
> @@ -484,8 +491,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
>  		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
>  		offset &= ~(page_size-1);
>  
> -		if (copy_page(uffd, offset, args->apply_wp))
> -			args->missing_faults++;
> +		/* UFFD_MOVE is supported for anon non-shared mappings. */
> +		if (uffd_test_ops == &anon_uffd_test_ops && !map_shared) {

IIUC this means move_page() will start to run on many other tests... as
long as anonymous & private.  Probably not wanted, because not all tests
may need this MOVE test, and it also means UFFDIO_COPY is never tested on
anonymous..

You can overwrite uffd_args.handle_fault().  Axel just added a hook which
seems also usable here.  See 99aa77215ad02.

> +			if (move_page(uffd, offset))
> +				args->missing_faults++;
> +		} else {
> +			if (copy_page(uffd, offset, args->apply_wp))
> +				args->missing_faults++;
> +		}
>  	}
>  }
>  
> @@ -620,6 +633,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>  	return __copy_page(ufd, offset, false, wp);
>  }
>  
> +int move_page(int ufd, unsigned long offset)
> +{
> +	struct uffdio_move uffdio_move;
> +
> +	if (offset >= nr_pages * page_size)
> +		err("unexpected offset %lu\n", offset);
> +	uffdio_move.dst = (unsigned long) area_dst + offset;
> +	uffdio_move.src = (unsigned long) area_src + offset;
> +	uffdio_move.len = page_size;
> +	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> +	uffdio_move.move = 0;
> +	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> +		/* real retval in uffdio_move.move */
> +		if (uffdio_move.move != -EEXIST)
> +			err("UFFDIO_MOVE error: %"PRId64,
> +			    (int64_t)uffdio_move.move);
> +		wake_range(ufd, uffdio_move.dst, page_size);
> +	} else if (uffdio_move.move != page_size) {
> +		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
> +	} else
> +		return 1;
> +	return 0;
> +}
> +
>  int uffd_open_dev(unsigned int flags)
>  {
>  	int fd, uffd;
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 7c4fa964c3b0..f4d79e169a3d 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -111,6 +111,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
>  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
>  int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
>  int copy_page(int ufd, unsigned long offset, bool wp);
> +int move_page(int ufd, unsigned long offset);
>  void *uffd_poll_thread(void *arg);
>  
>  int uffd_open_dev(unsigned int flags);
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 2709a34a39c5..f0ded3b34367 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -824,6 +824,10 @@ static void uffd_events_test_common(bool wp)
>  	char c;
>  	struct uffd_args args = { 0 };
>  
> +	/* Prevent source pages from being mapped more than once */
> +	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> +		err("madvise(MADV_DONTFORK) failed");

Modifying events test is weird.. I assume you don't need this anymore after
you switch to the handle_fault() hook.

> +
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>  	if (uffd_register(uffd, area_dst, nr_pages * page_size,
>  			  true, wp, false))
> @@ -1062,6 +1066,58 @@ static void uffd_poison_test(uffd_test_args_t *targs)
>  	uffd_test_pass();
>  }
>  
> +static void uffd_move_test(uffd_test_args_t *targs)
> +{
> +	unsigned long nr;
> +	pthread_t uffd_mon;
> +	char c;
> +	unsigned long long count;
> +	struct uffd_args args = { 0 };
> +
> +	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +			  true, false, false))
> +		err("register failure");
> +
> +	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> +		err("uffd_poll_thread create");
> +
> +	/*
> +	 * Read each of the pages back using the UFFD-registered mapping. We
> +	 * expect that the first time we touch a page, it will result in a missing
> +	 * fault. uffd_poll_thread will resolve the fault by remapping source
> +	 * page to destination.
> +	 */
> +	for (nr = 0; nr < nr_pages; nr++) {
> +		/* Check area_src content */
> +		count = *area_count(area_src, nr);
> +		if (count != count_verify[nr])
> +			err("nr %lu source memory invalid %llu %llu\n",
> +			    nr, count, count_verify[nr]);
> +
> +		/* Faulting into area_dst should remap the page */
> +		count = *area_count(area_dst, nr);
> +		if (count != count_verify[nr])
> +			err("nr %lu memory corruption %llu %llu\n",
> +			    nr, count, count_verify[nr]);
> +
> +		/* Re-check area_src content which should be empty */
> +		count = *area_count(area_src, nr);
> +		if (count != 0)
> +			err("nr %lu move failed %llu %llu\n",
> +			    nr, count, count_verify[nr]);

All of above should see zeros, right?  Because I don't think anyone boosted
the counter at all..

Maybe set some non-zero values to it?  Then the re-check can make more
sense.

If you want, I think we can also make uffd-stress.c test to cover MOVE too,
basically replacing all UFFDIO_COPY when e.g. user specified from cmdline.
Optional, and may need some touch ups here and there, though.

Thanks,

> +	}
> +
> +	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +		err("pipe write");
> +	if (pthread_join(uffd_mon, NULL))
> +		err("join() failed");
> +
> +	if (args.missing_faults != nr_pages || args.minor_faults != 0)
> +		uffd_test_fail("stats check error");
> +	else
> +		uffd_test_pass();
> +}
> +
>  /*
>   * Test the returned uffdio_register.ioctls with different register modes.
>   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
> @@ -1139,6 +1195,12 @@ uffd_test_case_t uffd_tests[] = {
>  		.mem_targets = MEM_ALL,
>  		.uffd_feature_required = 0,
>  	},
> +	{
> +		.name = "move",
> +		.uffd_fn = uffd_move_test,
> +		.mem_targets = MEM_ANON,
> +		.uffd_feature_required = UFFD_FEATURE_MOVE,
> +	},
>  	{
>  		.name = "wp-fork",
>  		.uffd_fn = uffd_wp_fork_test,
> -- 
> 2.42.0.609.gbb76f46606-goog
> 

-- 
Peter Xu

