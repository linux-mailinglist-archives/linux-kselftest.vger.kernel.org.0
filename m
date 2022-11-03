Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF36183E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 17:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKCQOM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKCQOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 12:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DF1A06F;
        Thu,  3 Nov 2022 09:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A0661EE7;
        Thu,  3 Nov 2022 16:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08FBC433D6;
        Thu,  3 Nov 2022 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667492045;
        bh=DLXNl9+4z7DavzpTnZ1L5p06FytfjA+p8ymjbqGgiS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXcfYRg4u0MvTij8P2JTHEeWP0/91Tl0qN/7YDQqapLGO0WNc04x6Jkw7yWvqfaKb
         3drBgTSEo/41veHAOOT8o42eT20vFgQ7nTtnMclIqNYScaQcgwhUHYRD+ixpnh2ias
         ehJCwbepwh221nd+ZWppOUnA6uqEVsz3yw/qvKjTrVhgGf+kj92u9yh8pqh9Q23l8T
         LRazn2RIbIgH+fIpf+EMvN6lmCV80niZTe9G+VD7RNmZts8PzEcBHTDP2IsNW6lMMA
         lI6tG2Rvu4dh+r+T27x5WvCFEi9kKOd4+DbSojCZ9jwubhXwX5DxUYm/tXTK0qv1xv
         gGh6ay7EWDvIA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix slab-out-of-bounds Write in dbgfs_rm_context_write
Date:   Thu,  3 Nov 2022 16:14:03 +0000
Message-Id: <20221103161403.115053-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031182554.7882-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,


May I ask you to merge this fix in your tree if you have no concern for this?
I think it deserves stable@.


Thanks,
SJ

On Mon, 31 Oct 2022 18:25:52 +0000 SeongJae Park <sj@kernel.org> wrote:

> This patchset is for fixing (patch 1) the syzbot-reported
> slab-out-of-bounds write in dbgfs_rm_context_write[1], and adding a
> selftest for the bug (patch 2).
> 
> [1] https://lore.kernel.org/damon/000000000000ede3ac05ec4abf8e@google.com/
> 
> SeongJae Park (2):
>   mm/damon/dbgfs: check if rm_contexts input is for a real context
>   selftests/damon: test non-context inputs to rm_contexts file
> 
>  mm/damon/dbgfs.c                              |  7 +++++++
>  tools/testing/selftests/damon/Makefile        |  1 +
>  .../damon/debugfs_rm_non_contexts.sh          | 19 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
> 
> -- 
> 2.25.1
