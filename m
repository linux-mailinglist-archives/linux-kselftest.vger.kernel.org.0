Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AE7D2608
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJVVHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 17:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVVHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 17:07:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C28FDD;
        Sun, 22 Oct 2023 14:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A11FC433C8;
        Sun, 22 Oct 2023 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698008860;
        bh=5ZgrkUlzCX47pRqWIhyU/veHGqYnGCkei+KNQLGqf1A=;
        h=From:To:Cc:Subject:Date:From;
        b=Mr2+dXiJPkTQamZC9s42dpr+F9W0/gxa5/gu5u+m66R8FYIBTu1+AJbCM7duHuFnV
         3wskyjxpue0Cbn0GZW2V/05/NCIVgiaAzmfVSD1FpZae9HpvNdmj4rSL1u6iD383OY
         HAOGHljzTiXsfZ3c9WqoZKRhR20LSG6+PmC/dkp01D3CnjTnnJCpGa4WdmjDFWfaHe
         uQcj1QvuBJ+k/kSaQmTV7H/F/W8CDV20wOCgNSog60fqpbeY8lgJ3oKq82Sznwbgo2
         iXDj0VOAx9IfaMuGqZhgao0fXWepdy2vr6wDH0s6hp5q37mgSiAxNbTu/8jyOkpS/n
         tKvX3/xb3NJrQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/sysfs: fix unexpected targets adding bug
Date:   Sun, 22 Oct 2023 21:07:32 +0000
Message-Id: <20231022210735.46409-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sysfs code for online targets updating can result in adding more than
expected monigoring targets to the context.  It can result in unexpected amount
of memory consumption and monitoring overhead.  This patchset fixes the issue
(patch 1), and add a kunit test for avoiding similar bug of future (patch 2).

SeongJae Park (2):
  mm/damon/sysfs: remove requested targets when online-commit inputs
  mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()

 mm/damon/Kconfig      | 12 ++++++
 mm/damon/sysfs-test.h | 86 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c      | 52 ++++++--------------------
 3 files changed, 109 insertions(+), 41 deletions(-)
 create mode 100644 mm/damon/sysfs-test.h


base-commit: 9a969da6ffb9609f5fa8d0b7fdc6859c37a10335
-- 
2.34.1

