Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753D7AE078
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 22:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjIYUxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYUxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 16:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB8C0;
        Mon, 25 Sep 2023 13:53:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14040C433C8;
        Mon, 25 Sep 2023 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695675212;
        bh=7hXvLQbvJIz227Ub7eXBQQ+8+Mqa/7Yw7vX+OS9wJUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7KIR50pB1YTnipIRcBQKkp4IAvLhUqlQofH+lGegv4snvLGNcCkP5z+R48wy8xne
         rOL1rsTs9N174A/GSq7ZGz2RLvFrSsfLcCfRATKVj1Wtnn1NtZYXFCjP55SnkfSi5H
         BNiM7+4SQCYBs+FhcXL6gmm9jWbf6/AUZSEpmeYqFAa4/rzULQxqcEpLSQWFEmpqmf
         f9SX4hqdI0bwfnW1lAY6H3zP/YW+tMVm6djtqKcv4u8htepEAHX60jz+j6xYYiSg9U
         K/n6ljgBS2DlhxNfAJtWPnLV+oGdE3fw5w4FPEirIDIHTHVbzU/5G1UFy+5wwVCgrD
         8/Zb6sMemRZcQ==
From:   SeongJae Park <sj@kernel.org>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     sj@kernel.org, shuah@kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/damon: Add executable permission to test scripts
Date:   Mon, 25 Sep 2023 20:53:30 +0000
Message-Id: <20230925205330.83701-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <VI1P193MB07529234393616AE94D58C7B99FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Juntong,

On Tue, 26 Sep 2023 04:35:52 +0800 Juntong Deng <juntong.deng@outlook.com> wrote:

> When running the test for the damon subsystem, there are a lot of
> warnings because test scripts do not have executable permission,
> for example:
> 
> Warning: file debugfs_attrs.sh is not executable
> Warning: file debugfs_schemes.sh is not executable
> Warning: file debugfs_target_ids.sh is not executable
> ...
> 
> This patch adds executable permission to test scripts to eliminate
> these warnings.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/debugfs_attrs.sh                    | 0
>  .../testing/selftests/damon/debugfs_duplicate_context_creation.sh | 0
>  tools/testing/selftests/damon/debugfs_empty_targets.sh            | 0
>  tools/testing/selftests/damon/debugfs_huge_count_read_write.sh    | 0
>  tools/testing/selftests/damon/debugfs_rm_non_contexts.sh          | 0
>  tools/testing/selftests/damon/debugfs_schemes.sh                  | 0
>  tools/testing/selftests/damon/debugfs_target_ids.sh               | 0
>  tools/testing/selftests/damon/lru_sort.sh                         | 0
>  tools/testing/selftests/damon/reclaim.sh                          | 0
>  tools/testing/selftests/damon/sysfs.sh                            | 0
>  tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh  | 0
>  11 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_attrs.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_schemes.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/lru_sort.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/reclaim.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
> 
> diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
> old mode 100644
> new mode 100755
> -- 
> 2.39.2
> 
> 
