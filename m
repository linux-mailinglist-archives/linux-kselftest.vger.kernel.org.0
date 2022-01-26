Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6149C77B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiAZK1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 05:27:41 -0500
Received: from foss.arm.com ([217.140.110.172]:57870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232606AbiAZK1i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 05:27:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 928E81FB;
        Wed, 26 Jan 2022 02:27:37 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BCD73F766;
        Wed, 26 Jan 2022 02:27:36 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/5] Miscellaneous trivial fixes
Date:   Wed, 26 Jan 2022 10:27:18 +0000
Message-Id: <20220126102723.23300-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

a small series collecting a few trivial fixes that I have already sent
previously (~Dec2021) as distinct patches.

They are mostly trivial patches addressing failures that seemed more
sensible to be marked as skips instead. (at least to me ...).
Original developers are in Cc. (but not heard back from anyone :D)

Thanks,
Cristian

Cristian Marussi (5):
  selftests: skip mincore.check_file_mmap when fs lacks needed support
  kselftest: Fix vdso_test_time to pass on skips
  selftests: openat2: Print also errno in failure messages
  selftests: openat2: Add missing dependency in Makefile
  selftests: openat2: Skip testcases that fail with EOPNOTSUPP

 .../selftests/mincore/mincore_selftest.c      | 20 +++++++++++++------
 tools/testing/selftests/openat2/Makefile      |  2 +-
 tools/testing/selftests/openat2/helpers.h     | 12 ++++++-----
 .../testing/selftests/openat2/openat2_test.c  | 12 ++++++++++-
 tools/testing/selftests/vDSO/vdso_test_abi.c  |  3 ++-
 5 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.17.1

