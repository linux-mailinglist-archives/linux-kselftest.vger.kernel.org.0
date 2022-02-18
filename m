Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB124BB39E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBRHxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:53:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiBRHxQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905D6A3B4;
        Thu, 17 Feb 2022 23:52:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A161B82538;
        Fri, 18 Feb 2022 07:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE8C340E9;
        Fri, 18 Feb 2022 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645170777;
        bh=WLAGjSGNb/26rp/2ZS1J2DnI/WrX+hLgCMjaN0HluQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Ssq4OgTen80Y5rHXytvnaql9XvpvLjb30KcpAtGaWAMLqULzzajbsI0PGqIEP6SaL
         0amvoKpfWSgxpx2RrEwMwDxhyiq3ZmMdSLBBQ3CkhsZLNqrG/bfHz7gRYjV1Q5aQF6
         Pm/DZe+Bq1XQvuzqqsU6LKxyf7XElqHXqIrLDd90dtD/fkmENjoL2JxbDGZ6mhRXGB
         REXhTRLD1ARxjFKfUuffVr4jpm9VwW+6v2m0TPeHxjUXFR6bxIlu88w0QmqJa5Y9c8
         Ri1Bg542nyLpcz2fLY626Y6TNP9aAJcF8IsjM1h4dwQ4AVnHUbbka/y/XnD/tLQqre
         Sr0cO05crqT3Q==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/damon: make selftests executable
Date:   Fri, 18 Feb 2022 07:52:54 +0000
Message-Id: <20220218075254.11467-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218001017.3500673-3-yuanchu@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Yuanchu,

Thank you for this patch!

On Fri, 18 Feb 2022 00:10:17 +0000 Yuanchu Xie <yuanchu@google.com> wrote:

> The damon selftests do not have the executable bit on. We fix that by
> setting the x bits on the .sh files similar to other existing shell
> selftests.
> 
> Fixes: 9ab3b0c8ef62 ("selftests/damon: split test cases")
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/debugfs_attrs.sh                 | 0
>  tools/testing/selftests/damon/debugfs_empty_targets.sh         | 0
>  tools/testing/selftests/damon/debugfs_huge_count_read_write.sh | 0
>  tools/testing/selftests/damon/debugfs_schemes.sh               | 0
>  tools/testing/selftests/damon/debugfs_target_ids.sh            | 0
>  5 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
> 
> diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
> old mode 100644
> new mode 100755
> -- 
> 2.35.1.265.g69c8d7142f-goog
