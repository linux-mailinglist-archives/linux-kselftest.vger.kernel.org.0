Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4227681CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjG2Uhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2Uhk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 16:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5AC7;
        Sat, 29 Jul 2023 13:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4476027E;
        Sat, 29 Jul 2023 20:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B73C433C7;
        Sat, 29 Jul 2023 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690663057;
        bh=iMknI2mssvMpvNEEtPFsjpKnh0+OEHxOEdyJZpeCgHY=;
        h=From:To:Cc:Subject:Date:From;
        b=vFJySY2rk1//Bkt9H41fBKeJvOhjKt9m7pNLfcYd/YbXNoDwBUj2HavpAFun6VP8b
         fpqIbkQKa9JyY+9FArMVz3l5JUe+ji6L2OwZA4tOjXV8DBcT53kkP+kdJN+7rnGOgJ
         OHMq25YIkjtAIVhX71U9KccUySxnQwKh+gOANdDqlB+MqQ2dzQ9CwGpfpDGTdumfsq
         yVynLsLCQiJ3nHfOvA3dswClNDRjCrA4gGnrJ1mf5h5HnSXLHqmKThXGFP4U9BVWgG
         XP18+zQi8wTYIR2MG3bVK9SM43+WIrj2jk9NogyN69sz8qGzCSgQOHGmuOiqiWslzu
         Nq/Xps6fD3aVQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/core: fix unitialized memory error from
Date:   Sat, 29 Jul 2023 20:37:31 +0000
Message-Id: <20230729203733.38949-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

damos_new_filter() is returning a damos_filter struct without
initializing its ->list field.  And the users of the function uses the
struct without initializing the field.  As a result, uninitialized
memory access error is possible.  Actually, a kernel NULL pointer
dereference BUG can be triggered using DAMON user-space tool, like
below.

    # damo start --damos_action stat --damos_filter anon matching
    # damo tune --damos_action stat --damos_filter anon matching --damos_filter anon nomatching
    # dmesg
    [...]
    [   36.908136] BUG: kernel NULL pointer dereference, address: 0000000000000008
    [   36.910483] #PF: supervisor write access in kernel mode
    [   36.912238] #PF: error_code(0x0002) - not-present page
    [   36.913415] PGD 0 P4D 0
    [   36.913978] Oops: 0002 [#1] PREEMPT SMP PTI
    [   36.914878] CPU: 32 PID: 1335 Comm: kdamond.0 Not tainted 6.5.0-rc3-mm-unstable-damon+ #1
    [   36.916621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
    [   36.919051] RIP: 0010:damos_destroy_filter (include/linux/list.h:114 include/linux/list.h:137 include/linux/list.h:148 mm/damon/core.c:345 mm/damon/core.c:355)
    [...]
    [   36.938247] Call Trace:
    [   36.938721]  <TASK>
    [...]
    [   36.950064] ? damos_destroy_filter (include/linux/list.h:114 include/linux/list.h:137 include/linux/list.h:148 mm/damon/core.c:345 mm/damon/core.c:355)
    [   36.950883] ? damon_sysfs_set_scheme_filters.isra.0 (mm/damon/sysfs-schemes.c:1573)
    [   36.952019] damon_sysfs_set_schemes (mm/damon/sysfs-schemes.c:1674 mm/damon/sysfs-schemes.c:1686)
    [   36.952875] damon_sysfs_apply_inputs (mm/damon/sysfs.c:1312 mm/damon/sysfs.c:1298)
    [   36.953757] ? damon_pa_check_accesses (mm/damon/paddr.c:168 mm/damon/paddr.c:179)
    [   36.954648] damon_sysfs_cmd_request_callback (mm/damon/sysfs.c:1329 mm/damon/sysfs.c:1359)
    [...]

The first patch of this patchset fixes the bug by initializing the field in
damos_new_filter().  The second patch adds a unit test for the problem.
Note that the second patch Cc stable@ without Fixes: tag, since it would
be better to be ingested together for avoiding any future regression.

SeongJae Park (2):
  mm/damon/core: initialize damo_filter->list from damos_new_filter()
  mm/damon/core-test: add a test for damos_new_filter()

 mm/damon/core-test.h | 13 +++++++++++++
 mm/damon/core.c      |  1 +
 2 files changed, 14 insertions(+)

-- 
2.25.1

