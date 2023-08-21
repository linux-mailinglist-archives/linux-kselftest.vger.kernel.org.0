Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172E5782DCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjHUQFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHUQFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 12:05:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 935A6F3;
        Mon, 21 Aug 2023 09:05:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 450512F4;
        Mon, 21 Aug 2023 09:06:20 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FEB63F64C;
        Mon, 21 Aug 2023 09:05:38 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] selftests: cachestat: fix run on older kernels
Date:   Mon, 21 Aug 2023 17:05:32 +0100
Message-Id: <20230821160534.3414911-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I ran all kernel selftests on some test machine, and stumbled upon
cachestat failing (among others).
These patches fix the run on older kernels and when the current
directory is on a tmpfs instance.

I dropped the first two fix patches from v1, since Shuah applied those
already. [PATCH v2 1/2] is almost the same as [PATCH 3/3] from v1, but
using the proper skip function from kselftest.h. I am not sure if Shuah
applied that already, if yes, it's not a big problem, the output is the
same.

Patch 2/2 implements the tmpfs detection that Nhat suggested the last
time (many thanks for pointing me to statfs and the magics!).

Cheers,
Andre

Andre Przywara (2):
  selftests: cachestat: test for cachestat availability
  selftests: cachestat: catch failing fsync test on tmpfs

 .../selftests/cachestat/test_cachestat.c      | 80 +++++++++++++++----
 1 file changed, 65 insertions(+), 15 deletions(-)

-- 
2.25.1

