Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C24BB389
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiBRHvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:51:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBRHvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADBB0EA9;
        Thu, 17 Feb 2022 23:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21997B8257C;
        Fri, 18 Feb 2022 07:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60CBC340EB;
        Fri, 18 Feb 2022 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645170646;
        bh=mJRaMEex6raK6353llbGviKh82YJn/hPKaTuIEyH+rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=dBFXJYF484qAzCNoVO3WgAM0Uk/bG1sHk5nGr+5wKCAWSDDrfWfchhnAiIq9XHlzy
         +ih3ThppekFARPhWJQE5d8WnhrR4z1p1oMoI8R+0sQDHUT9VmkNN7U3iQW+BRA0Q+9
         1+zl8L64bDzF5iBL1OMfs+bsOzu6/11+1conlKLQowmDgvxPgVa8qk+AoON4aPlBXS
         3LO40BG5XaU8e1xYpm6Nh/WWhK+iYAz/WK6fR5ScwT0Ht3EH7ummta5clNtDx9t4lk
         +/Ozr4wOQaG7DtUQYIAuGBdmdpJu/Df25e7l0DK4AiUUnFgLKhmvHEFTHA17QKS7tE
         EusEK8f1litRw==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/damon: add damon to selftests root Makefile
Date:   Fri, 18 Feb 2022 07:50:42 +0000
Message-Id: <20220218075042.11326-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218001017.3500673-2-yuanchu@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yuanchu, thank you for this patch!

On Fri, 18 Feb 2022 00:10:16 +0000 Yuanchu Xie <yuanchu@google.com> wrote:

> Currently the damon selftests are not built with the rest of the
> selftests. We add damon to the list of targets.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..ffe453760a12 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -9,6 +9,7 @@ TARGETS += clone3
>  TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
> +TARGETS += damon
>  TARGETS += drivers/dma-buf
>  TARGETS += efivarfs
>  TARGETS += exec
> -- 
> 2.35.1.265.g69c8d7142f-goog
