Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009E77CFB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjHOP5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbjHOP4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E15172A;
        Tue, 15 Aug 2023 08:56:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231801063;
        Tue, 15 Aug 2023 08:57:12 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E533F6C4;
        Tue, 15 Aug 2023 08:56:28 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] selftests: cachestat: fix build and run on older kernels
Date:   Tue, 15 Aug 2023 16:56:09 +0100
Message-Id: <20230815155612.2535947-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I ran all kernel selftests on some test machine, and stumbled upon
cachestat failing (among others).
Those patches fix the cachestat test compilation and run on older
kernels.

Also I found that the but-last test (on a normal file) fails when run on
a tmpfs mounted directory, as it happens on an initramfs-only system, or
when the current directory happens to be /dev/shm or /tmp:
# Create/open tmpfilecachestat
# Cachestat call returned 0
# Using cachestat: Cached: 4, Dirty: 4, Writeback: 0, Evicted: 0, Recently Evicted: 0
# Cachestat call (after fsync) returned 0
# Using cachestat: Cached: 4, Dirty: 4, Writeback: 0, Evicted: 0, Recently Evicted: 0
# Number of dirty should be zero after fsync.
not ok 6 cachestat fails with normal file

That same test binary succeeds on the same machine right afterwards if
the current directory is changed to an ext4 filesystem.

I don't really know if this is expected, and whether we should try to
figure out if the test file lives on a tmpfs filesystem, or whether the
test itself is not strict enough, and requires more "flushing"
(drop_caches?) to cover tmpfs directories as well.

Any ideas how to fix this would be appreciated.

Cheers,
Andre

Andre Przywara (3):
  selftests: cachestat: properly link in librt
  selftests: cachestat: use proper syscall number macro
  selftests: cachestat: test for cachestat availability

 tools/testing/selftests/cachestat/Makefile    |  2 +-
 .../selftests/cachestat/test_cachestat.c      | 29 +++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.25.1

