Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5551929A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 02:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbiEDAPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEDAPa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 20:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04C14087;
        Tue,  3 May 2022 17:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC3861839;
        Wed,  4 May 2022 00:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B4C385A4;
        Wed,  4 May 2022 00:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651623116;
        bh=G+aZGUAr0FfQ9F3/qjycZ/CR4Cv6boS+C83q1nKXSqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y755J25ivPjrwAchjwtRXCl12Pb8K0fw3kyVxOnTlY6Hdxzz2F0OglpCYZixitNmV
         guNWSmrZ2F5uNigbRYyIyN6oc76Ff3DD+O3b203M1sNgd3jSr8YnqNsqDt7Ay4KwA3
         ycS3Bwk/Ip9sSVfM87PEpEzJULU+VC6CssAWgxBikYhSA9iHnjFdIQuP2LU5itqH2m
         m5cxVR56lYwOlqtUlZplpI4fJd88Ue/Wvxt/Jt+dSQPWL4MAAcmjtVFaqN9K5jAs0s
         2iBtC1+kqUZzwiseH+WqDSaZ3kZFNCqH9YkfeS/EDkABmqzAdJ2b1bJPPZyGggKhB5
         Bgb8J9jiZy0dA==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/damon: suppress compiler warnings for huge_count_read_write
Date:   Wed,  4 May 2022 00:11:53 +0000
Message-Id: <20220504001153.119485-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504000358.1174849-1-yuanchu@google.com>
References: 
MIME-Version: 1.0
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

Hi Yuanchu, thank you for this patch!

On Wed, 4 May 2022 00:03:57 +0000 Yuanchu Xie <yuanchu@google.com> wrote:

> The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> use '__GFP_NOWARN' for user-specified size buffer allocation")
> intentionally writes and reads with a large count to cause
> allocation failure and check for kernel warnings. We suppress
> the compiler warnings for these calls as they work as intended.
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
> ---
>  tools/testing/selftests/damon/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> index 0470c5f3e690..a300b4c5b373 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for damon selftests
>  
> +CFLAGS += -Wno-stringop-overread
> +CFLAGS += -Wno-stringop-overflow
> +
>  TEST_GEN_FILES += huge_count_read_write
>  
>  TEST_FILES = _chk_dependency.sh _debugfs_common.sh
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 
