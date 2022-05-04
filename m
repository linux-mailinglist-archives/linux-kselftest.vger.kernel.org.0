Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C451AD34
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377251AbiEDStX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbiEDStU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 14:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952BC101FB;
        Wed,  4 May 2022 11:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9AD61B56;
        Wed,  4 May 2022 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD338C385AE;
        Wed,  4 May 2022 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651689940;
        bh=neqWJaNNLruFhLtSzdV4d34b2LqsaISq6IIrNL+8k3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQQ6pZGbDLYpdM++Rf71SDU2F9ffIOyzhltFZGnaHtHn6t+/IwkrkuwLLICOa36tT
         491tMoF32XeDQGf7/+v3aSgydhc9Nhhv/SA2bBa8POihmVrHt39ecRR4PWZM74RZqr
         9+tz/yB16nTSHsMWAlolcomkiHZrzQXqopKKxtDTlsAMFA6C1C1pOyYaPzCP03DOwb
         zT0euTcOk76xivPnQoku2NolGBi8vhW6BpNagm0e2Se9RC3tj1j2ss0ZP2ZTXQib2n
         3EaiDhId0AqGqWVRbmvVZLfsA5Ru7si569Hfz+N7/9lLQa04+gqdYeRlor4EatZ4SF
         PCoNpcDraH14Q==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
Date:   Wed,  4 May 2022 18:45:37 +0000
Message-Id: <20220504184537.130085-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504182908.1322874-1-yuanchu@google.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yuanchu,

On Wed, 4 May 2022 18:29:08 +0000 Yuanchu Xie <yuanchu@google.com> wrote:

> The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> use '__GFP_NOWARN' for user-specified size buffer allocation")
> intentionally writes and reads with a large count to cause
> allocation failure and check for kernel warnings. We suppress
> the compiler warnings for these calls as they work as intended.
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---

It would be a good practice to mention the changes from the previous version of
this patch here[1].

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

>  tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
> index ad7a6b4cf338..91bd80c75cd9 100644
> --- a/tools/testing/selftests/damon/huge_count_read_write.c
> +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> @@ -2,6 +2,8 @@
>  /*
>   * Author: SeongJae Park <sj@kernel.org>
>   */
> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#pragma GCC diagnostic ignored "-Wstringop-overread"

I agree that this must be the cleaner way than v2.  But, I get below warning
after applying this:

    $ sudo make -C tools/testing/selftests/damon run_tests
    make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
    gcc     huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/selftests/damon/huge_count_read_write
    huge_count_read_write.c:6:32: warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
        6 | #pragma GCC diagnostic ignored "-Wstringop-overread"
          |                                ^~~~~~~~~~~~~~~~~~~~~

My gcc version is:

    $ gcc --version
    gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0


Thanks,
SJ

>  
>  #include <fcntl.h>
>  #include <stdlib.h>
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 
