Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE6613D47
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJaS0L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaS0K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 14:26:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6110FC8;
        Mon, 31 Oct 2022 11:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0FFBB819DC;
        Mon, 31 Oct 2022 18:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C70C433C1;
        Mon, 31 Oct 2022 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667240763;
        bh=G91I60Ol4QydHlf0mecqvnzRJ7lAwY37ycd5EgIHiNA=;
        h=From:To:Cc:Subject:Date:From;
        b=mwkrMkEzxQ2aBJiRdepyeP5t5fLzY4CAtpKfH6JMCnHZ/VQ+dYxFX0iCcFO5gFDix
         02rFZKQTxdKHR/Lv8Jlcv2w+ShC0DPpVcYM2H876SKCw/B5ufMRO9bzaAQsd7iIpzP
         gUJ5v/jTtpxcpsrk8tH598uGrOb2BpzHxGQZafU/J2/QqS3D8D97kVy+K0Lt9b7Nf2
         +A3s1Gu6nonRmiA5N7F+dp5FdSau3BRTLg4JaXOLU3PiDRT7bfDa01vdEK+l8oDm5R
         C8do+DA6t2WbL0Lq3UMSEOopPedqr40+hIGrdo+LpmjTud6HHXLACzH8+00cNo7dMg
         h14pnuSkhu3rw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix slab-out-of-bounds Write in dbgfs_rm_context_write
Date:   Mon, 31 Oct 2022 18:25:52 +0000
Message-Id: <20221031182554.7882-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

