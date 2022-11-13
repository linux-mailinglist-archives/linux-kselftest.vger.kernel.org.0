Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1262724F
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Nov 2022 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiKMTtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Nov 2022 14:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiKMTtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Nov 2022 14:49:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80897F034;
        Sun, 13 Nov 2022 11:49:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B84E60D2F;
        Sun, 13 Nov 2022 19:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB9C433D6;
        Sun, 13 Nov 2022 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668368950;
        bh=yrDG2V+vcg1HVPtwi+FlRMwsR7nnH8N/b1BGzR2HGdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bD3ZVJ9Sj+CuNd4SnlcFNNuixJYu6WW+7JkqTQFPrUFKEpqxUYVmJvr7ec9zEVuZn
         QwTz/5HPpVvh79OKiBBxouHYwGI5wp1UPi0RpBCDtArino48OnjQgqutLOEJymzIKQ
         XV17gaAddwx6fhFlXKnMuLk1UfRJLLSZ60Qk4Iz7sU1ey9DeD7TPRPKc/ZEsYhcv43
         gpKCz/Sx6yIgh1nfMFfwLr0Z4SwEtJlw2NC2klgYhsDlK77ILRKQWQ7V7fOyizf7oX
         5PTq+vWll8oU1s4dC4iDbwtS6DGxDfG2Ef2mUaskL68eI7NTX7pcoGNSOKPA85tkzR
         sYeVSKszBlDlQ==
From:   SeongJae Park <sj@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sj@kernel.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        rongtao@cestc.cn, shuah@kernel.org, yuanchu@google.com
Subject: Re: [PATCH v3] selftests/damon: Fix unnecessary compilation warnings
Date:   Sun, 13 Nov 2022 19:49:07 +0000
Message-Id: <20221113194908.18554-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_51C4ACA8CB3895C2D7F35178440283602107@qq.com>
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

On Sun, 13 Nov 2022 08:38:45 +0800 Rong Tao <rtoax@foxmail.com> wrote:

> From: Rong Tao <rongtao@cestc.cn>
> 
> When testing overflow and overread, there is no need to keep unnecessary
> compilation warnings, we should simply ignore them.
> 
> The motivation for this patch is to eliminate the compilation warning,
> maybe one day we will compile the kernel with "-Werror -Wall", at which
> point this compilation warning will turn into a compilation error, we
> should fix this error in advance.
> 
> How to reproduce the problem (with gcc-11.3.1):
> 
>     $ make -C tools/testing/selftests/
>     ...
>     warning: ‘write’ reading 4294967295 bytes from a region of size 1
>     [-Wstringop-overread]
>     warning: ‘read’ writing 4294967295 bytes into a region of size 25
>     overflows the destination [-Wstringop-overflow=]
> 
> "-Wno-stringop-overread" is supported at least in gcc-11.1.0.
> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d14c547abd484d3540b692bb8048c4a6efe92c8b
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for fixing this old problem!


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/huge_count_read_write.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
> index ad7a6b4cf338..a6fe0689f88d 100644
> --- a/tools/testing/selftests/damon/huge_count_read_write.c
> +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> @@ -8,6 +8,13 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  
> +#pragma GCC diagnostic push
> +#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
> +/* Ignore read(2) overflow and write(2) overread compile warnings */
> +#pragma GCC diagnostic ignored "-Wstringop-overread"
> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#endif
> +
>  void write_read_with_huge_count(char *file)
>  {
>  	int filedesc = open(file, O_RDWR);
> @@ -27,6 +34,8 @@ void write_read_with_huge_count(char *file)
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
> 
