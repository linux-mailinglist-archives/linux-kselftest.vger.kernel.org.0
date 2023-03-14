Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07446B8989
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCNEYI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCNEYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:24:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12EFF1ACCE;
        Mon, 13 Mar 2023 21:24:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1C64B3;
        Mon, 13 Mar 2023 21:24:47 -0700 (PDT)
Received: from a077209.blr.arm.com (a077209.arm.com [10.162.42.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 615533F71A;
        Mon, 13 Mar 2023 21:24:00 -0700 (PDT)
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] selftests: Fix virtual address range for arm64
Date:   Tue, 14 Mar 2023 09:53:48 +0530
Message-Id: <20230314042351.13134-1-chaitanyas.prakash@arm.com>
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

When the virtual address range selftest is run on arm64 and x86 platforms,
it is observed that both the low and high VA range iterations are skipped
when the MAP_CHUNK_SIZE is set to 16GB. The MAP_CHUNK_SIZE is changed to
1GB to resolve this issue, following which support for arm64 platform is
added by changing the NR_CHUNKS_HIGH for aarch64 to accommodate up to 4PB
of virtual address space allocation requests. Dynamic memory allocation
of array holding addresses is introduced to prevent overflow of the stack.
Finally, the overcommit_policy is set as OVERCOMMIT_ALWAYS to prevent the
kernel from denying a memory allocation request based on a platform's
physical memory availability.

This series has been tested on 6.3.0-rc1 mainline kernel, both on arm64
and x86 platforms.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Chaitanya S Prakash (3):
  selftests: Change MAP_CHUNK_SIZE
  selftests: Change NR_CHUNKS_HIGH for aarch64
  selftests: Set overcommit_policy as OVERCOMMIT_ALWAYS

 tools/testing/selftests/mm/run_vmtests.sh     |  8 +++++++
 .../selftests/mm/virtual_address_range.c      | 24 +++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.30.2

