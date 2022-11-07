Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522F61FA71
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiKGQuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiKGQuG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:50:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEDE20340;
        Mon,  7 Nov 2022 08:50:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17FC0611BD;
        Mon,  7 Nov 2022 16:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D389C43148;
        Mon,  7 Nov 2022 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667839804;
        bh=XqrOKcVsJ+boRrvDno7gBUrja/HWLI37DpoaBs9pWC0=;
        h=From:To:Cc:Subject:Date:From;
        b=myvoQ3iqA5MefMAxdVw8To6/c08n8axdkoYs+/ZOHzGAxHn9l8Gxp/ypQZkhtsvXo
         cThcewflV54JJdQGp8/TFJg+X9KLWh1hMbIe3DHuWsie8f8SRuPLsMkDCg68wbw7K4
         BtG3Xf5zfIqFFh/zWK1KMi8C1Y8mOhn/P+sMFXZcEpZWGnN6wb+oSUXdq7c6jQCT/p
         jieRwpdbGeMJ3H446Z+GY/l8zULzVJlFdAcUJYPCEwR3wNPfkMo5xxAtQ2Zs1PeBFK
         XiaG6hS58IceS7q4qB4P1VQsoPPk4HvQXJFN42X8v9rd4ni/8vDwjkm92M3DzAxLs9
         oSNzBINXerClg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix slab-out-of-bounds Write in dbgfs_rm_context_write
Date:   Mon,  7 Nov 2022 16:49:59 +0000
Message-Id: <20221107165001.5717-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from v1
(https://lore.kernel.org/damon/20221031182554.7882-1-sj@kernel.org/)
- Rebase on latest mm-unstable

---

This patchset is for fixing (patch 1) the syzbot-reported
slab-out-of-bounds write in dbgfs_rm_context_write[1], and adding a
selftest for the bug (patch 2).

[1] https://lore.kernel.org/damon/000000000000ede3ac05ec4abf8e@google.com/

SeongJae Park (2):
  mm/damon/dbgfs: check if rm_contexts input is for a real context
  selftests/damon: test non-context inputs to rm_contexts file

 mm/damon/dbgfs.c                              |  7 +++++++
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/debugfs_rm_non_contexts.sh          | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh

-- 
2.25.1

