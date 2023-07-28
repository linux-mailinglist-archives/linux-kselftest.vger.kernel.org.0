Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F17676D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 22:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjG1US2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjG1US2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC92D75;
        Fri, 28 Jul 2023 13:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3220F621F3;
        Fri, 28 Jul 2023 20:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF109C433C7;
        Fri, 28 Jul 2023 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575505;
        bh=UVBU1bmCqbHYSrEwhTG13CafVyks5FJvwzFQOQt5stM=;
        h=From:To:Cc:Subject:Date:From;
        b=KnJ8rmUNVoGFKcCNUKRwK89H2KXXAVLsepsFVQRa8iq4OoKzKnituu+rU0m/e7wJx
         uAVd0NxyObI7bWeGNqmuwUCWqQFn0yUKUXbZR0gT9GqzYGwzjp6ETymgfGp/0bvNCX
         nlqZUBhTP+tOhmS1RLPv11wBvEuvRUwwxbTtt74EoFFwojxtEu0HH614lcs2N1Lo67
         eQBhLQdYv/PDCfocQBxT2XJfJ4o4fRRjONXROUjT0VkNfgFZ+UrEh57tkK4bwQFjxp
         NNkpvhVBApP7A7T6MVluboFkz5FCrfcQBYYnIdKNcZCC/S809axL3QyaJ6pjL+oXJq
         6pqz5f6ogfIlQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] mm/damon/sysfs: add a file for efficiently get total size of DAMOS tried regions
Date:   Fri, 28 Jul 2023 20:18:12 +0000
Message-Id: <20230728201817.70602-1-sj@kernel.org>
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

The tried_regions directory of DAMON sysfs interface is useful for
retrieving monitoring results snapshot or DAMOS debugging.  However, for
common use case that need to monitor only the total size of the scheme
tried regions (e.g., monitoring working set size), the kernel overhead
for directory construction and user overhead for reading the content
could be high if the number of monitoring region is not small.  This
patchset implements DAMON sysfs files for efficient support of the use
case.

The first patch implements the sysfs file to reduce the user space
overhead, and the second patch implements a command for reducing the
kernel space overhead.

The third patch adds a selftest for the new file, and following two
patches update documents.

SeongJae Park (5):
  mm/damon/sysfs-schemes: implement DAMOS tried total bytes file
  mm/damon/sysfs: implement a command for updating only schemes tried
    total bytes
  selftests/damon/sysfs: test tried_regions/total_bytes file
  Docs/ABI/damon: update for tried_regions/total_bytes
  Docs/admin-guide/mm/damon/usage: update for tried_regions/total_bytes

 .../ABI/testing/sysfs-kernel-mm-damon         | 13 +++++-
 Documentation/admin-guide/mm/damon/usage.rst  | 42 ++++++++++++-------
 mm/damon/sysfs-common.h                       |  2 +-
 mm/damon/sysfs-schemes.c                      | 24 ++++++++++-
 mm/damon/sysfs.c                              | 26 +++++++++---
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 6 files changed, 83 insertions(+), 25 deletions(-)

-- 
2.25.1

