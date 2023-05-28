Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1721713A4A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1PEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1PEx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 11:04:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3EB1;
        Sun, 28 May 2023 08:04:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso1473074f8f.1;
        Sun, 28 May 2023 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685286289; x=1687878289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmu2fGgKtj6ACiAeNAU++2qaCys/oPeAAPciVcyRr8E=;
        b=VNTP3hIvPOJbJsHZd6LRbIC6MWhK1sardjlLZ64M0YHRKy2jGfyQbZIvleOVdxpIzY
         hP1TLHTpTANUc/qjU7v4MOJBmXjXCUDkzRJybmuQJY7tHdM+r9rlACjXnJYuL5VnzZqz
         KPx5JfBorA1LjDZwtpVDN3Ytr0TYOjjq8yQlnN2W6CKkqhqGg85XJ9q79ZrzcDEVLGLE
         kZQs9rfB/rlGjAJqoSqfB5pDBUxFMmbraGczJTs1cyqKgWNLt75xxEoznyI+oRZlKnMQ
         Bsp+JGXCGU456WqvlKEcMCo3QRlUqVjV1jja8qFZJVYQnjg8p++9b30UtQDOauoLgWej
         mRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685286289; x=1687878289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmu2fGgKtj6ACiAeNAU++2qaCys/oPeAAPciVcyRr8E=;
        b=INjroT7facXiaAU7UFweunD7100JszZKkEQP+BzizVD5iw6l6L3lJmBheEzSwVqAZj
         ykULHosaob657CvmTEEQCo6wyY1iGZBMDni+2+x6Qj0JfuWxBAKZ3hNe9GadfvpUYUmj
         QqIA+FPdfqhlr4fX+8BafbCUC9dOtWDfaQAffWs4hO++r93rWS/pjwdMx+PJkYFhliwb
         lY9renFWq1vdm0vnbFFS5VU8yDXXwDsxaNtdJfCTFxVVECLfwgIbQiFXr3rIKZlR3LdJ
         TMqkhoFpkDbWG2+KgT8ohTEWNRDNX25/tx2gv7zqtUz3YuNnhgR0cPuSWagI1YAmlf4G
         E84w==
X-Gm-Message-State: AC+VfDwRbNVLqu0hLKPZUYi7SViYeXJTRquNOZ2Pdo/L+Lwl6y1aZC7Z
        0m511iRLRbL65iwstOgaw/7z0nNPQNU=
X-Google-Smtp-Source: ACHHUZ5ROSZcIZxIZBRpBPo23jhUI5J74WfJyx14MDTpJxtVMUuL7kjNwe6vOgiT2cypRwPL0RLIDw==
X-Received: by 2002:adf:f412:0:b0:306:2d3d:a108 with SMTP id g18-20020adff412000000b003062d3da108mr5913759wro.11.1685286289090;
        Sun, 28 May 2023 08:04:49 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d65c8000000b0030649242b72sm10939674wrw.113.2023.05.28.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 08:04:48 -0700 (PDT)
Date:   Sun, 28 May 2023 16:04:47 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 3/3] selftests/mm: gup_longterm: add liburing tests
Message-ID: <91f08840-4a43-4678-a116-ead7d3d77d19@lucifer.local>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519102723.185721-4-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 12:27:23PM +0200, David Hildenbrand wrote:
> Similar to the COW selftests, also use io_uring fixed buffers to test
> if long-term page pinning works as expected.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/gup_longterm.c | 73 +++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 44a3617fd423..d33d3e68ffab 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -22,6 +22,9 @@
>  #include <linux/memfd.h>
>
>  #include "local_config.h"
> +#ifdef LOCAL_CONFIG_HAVE_LIBURING
> +#include <liburing.h>
> +#endif /* LOCAL_CONFIG_HAVE_LIBURING */
>
>  #include "../../../../mm/gup_test.h"
>  #include "../kselftest.h"
> @@ -80,6 +83,9 @@ enum test_type {
>  	TEST_TYPE_RO_FAST,
>  	TEST_TYPE_RW,
>  	TEST_TYPE_RW_FAST,
> +#ifdef LOCAL_CONFIG_HAVE_LIBURING
> +	TEST_TYPE_IOURING,
> +#endif /* LOCAL_CONFIG_HAVE_LIBURING */
>  };
>
>  static void do_test(int fd, size_t size, enum test_type type, bool shared)
> @@ -173,6 +179,51 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		ksft_test_result(should_work, "Should have worked\n");
>  		break;
>  	}
> +#ifdef LOCAL_CONFIG_HAVE_LIBURING
> +	case TEST_TYPE_IOURING: {
> +		struct io_uring ring;
> +		struct iovec iov;
> +
> +		/* io_uring always pins pages writable. */
> +		if (shared && fs_is_unknown(fs_type)) {
> +			ksft_test_result_skip("Unknown filesystem\n");
> +			return;
> +		}
> +		should_work = !shared ||
> +			      fs_supports_writable_longterm_pinning(fs_type);
> +
> +		/* Skip on errors, as we might just lack kernel support. */
> +		ret = io_uring_queue_init(1, &ring, 0);
> +		if (ret < 0) {
> +			ksft_test_result_skip("io_uring_queue_init() failed\n");
> +			break;
> +		}
> +		/*
> +		 * Register the range as a fixed buffer. This will FOLL_WRITE |
> +		 * FOLL_PIN | FOLL_LONGTERM the range.
> +		 */
> +		iov.iov_base = mem;
> +		iov.iov_len = size;
> +		ret = io_uring_register_buffers(&ring, &iov, 1);
> +		/* Only new kernels return EFAULT. */
> +		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
> +			    errno == EFAULT)) {
> +			ksft_test_result(!should_work, "Should have failed\n");
> +		} else if (ret) {
> +			/*
> +			 * We might just lack support or have insufficient
> +			 * MEMLOCK limits.
> +			 */
> +			ksft_test_result_skip("io_uring_register_buffers() failed\n");
> +		} else {
> +			ksft_test_result(should_work, "Should have worked\n");
> +			io_uring_unregister_buffers(&ring);
> +		}
> +
> +		io_uring_queue_exit(&ring);
> +		break;
> +	}
> +#endif /* LOCAL_CONFIG_HAVE_LIBURING */
>  	default:
>  		assert(false);
>  	}
> @@ -310,6 +361,18 @@ static void test_private_ro_fast_pin(int fd, size_t size)
>  	do_test(fd, size, TEST_TYPE_RO_FAST, false);
>  }
>
> +#ifdef LOCAL_CONFIG_HAVE_LIBURING
> +static void test_shared_iouring(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_IOURING, true);
> +}
> +
> +static void test_private_iouring(int fd, size_t size)
> +{
> +	do_test(fd, size, TEST_TYPE_IOURING, false);
> +}
> +#endif /* LOCAL_CONFIG_HAVE_LIBURING */
> +
>  static const struct test_case test_cases[] = {
>  	{
>  		"R/W longterm GUP pin in MAP_SHARED file mapping",
> @@ -343,6 +406,16 @@ static const struct test_case test_cases[] = {
>  		"R/O longterm GUP-fast pin in MAP_PRIVATE file mapping",
>  		test_private_ro_fast_pin,
>  	},
> +#ifdef LOCAL_CONFIG_HAVE_LIBURING
> +	{
> +		"io_uring fixed buffer with MAP_SHARED file mapping",
> +		test_shared_iouring,
> +	},
> +	{
> +		"io_uring fixed buffer with MAP_PRIVATE file mapping",
> +		test_private_iouring,
> +	},
> +#endif /* LOCAL_CONFIG_HAVE_LIBURING */
>  };
>
>  static void run_test_case(struct test_case const *test_case)
> --
> 2.40.1
>

All good,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
