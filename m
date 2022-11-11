Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8062608E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiKKRjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 12:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiKKRjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 12:39:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046AD61B84;
        Fri, 11 Nov 2022 09:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9527E6206D;
        Fri, 11 Nov 2022 17:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C25C433C1;
        Fri, 11 Nov 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668188338;
        bh=pVSG4o9o7ELZjK0i4XqofCGBuPWYjWKlXf96GCOImGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1H/cEE4N44Xw3DctnOnlHXKoi27WfQjOTKxdjmtmS5ep1HuMVWnGoaD7M40rz/PZ
         HDCenm1V5W+mtGUbmNqu3oSf+fUpPjUrAMNIT18SVLnuV1WXuG8A4817b55IJ4dI8Z
         ion0aTgFjjYPAU0BvtvFpFaHuJ4VK5nzQ04BqU9CtdF4wm3hcmVpemXs+mVmOHXq29
         ZFOb0H57A+Z3wtKiM5+JhmCUWey7dRhfe+wQwsUdPFWA8dexZYM9Jf3lDRZvlulz2r
         bv0BFpbPPziC3o8ry8PqGp49AaI9HO3JHdXQAxFpyfdWRMvowhzIFjo4FCsub3v3PZ
         TbEGlfhvOjuqQ==
From:   SeongJae Park <sj@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sj@kernel.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        rongtao@cestc.cn, shuah@kernel.org, yuanchu@google.com
Subject: Re: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date:   Fri, 11 Nov 2022 17:38:55 +0000
Message-Id: <20221111173855.108360-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_32CBE47252C5F69571B40751DE6054082D05@qq.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rong,


It would be better if you could notice the version of this patch using 'PATCH
v2' like subject prefix from next time.

On Fri, 11 Nov 2022 10:37:20 +0800 Rong Tao <rtoax@foxmail.com> wrote:

> From: Rong Tao <rongtao@cestc.cn>
> 
> When testing overflow and overread, there is no need to keep unnecessary
> compilation warnings, we should simply ignore them.
> 
> How to reproduce the problem:
> 
>     $ make -C tools/testing/selftests/
>     ...
>     warning: ‘write’ reading 4294967295 bytes from a region of size 1
>     [-Wstringop-overread]
>     warning: ‘read’ writing 4294967295 bytes into a region of size 25
>     overflows the destination [-Wstringop-overflow=]

Thank you for indenting as I suggested!  BTW, I'm ok to violate the line length
limit for quoting commands outputs.

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/damon/huge_count_read_write.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
> index ad7a6b4cf338..8fbe276870e7 100644
> --- a/tools/testing/selftests/damon/huge_count_read_write.c
> +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> @@ -8,6 +8,11 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  
> +#pragma GCC diagnostic push
> +/* Ignore read(2) overflow and write(2) overread compile warnings */
> +#pragma GCC diagnostic ignored "-Wstringop-overread"

This still trigger below error on my old gcc.

    gcc -Wno-stringop-overread -Wno-stringop-overflow    huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/selftests/damon/huge_count_read_write
    huge_count_read_write.c:13:32: warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
       13 | #pragma GCC diagnostic ignored "-Wstringop-overread"
          |                                ^~~~~~~~~~~~~~~~~~~~~
    cc1: warning: unrecognized command line option ‘-Wno-stringop-overread’

I don't think that's a blocker of this patch, but hope to hear your opinion.


Thanks,
SJ

> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +
>  void write_read_with_huge_count(char *file)
>  {
>  	int filedesc = open(file, O_RDWR);
> @@ -27,6 +32,8 @@ void write_read_with_huge_count(char *file)
>  	close(filedesc);
>  }
>  
> +#pragma GCC diagnostic pop
> +
>  int main(int argc, char *argv[])
>  {
>  	if (argc != 2) {
> -- 
> 2.31.1
> 
