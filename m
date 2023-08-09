Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FD77660B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjHIREo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjHIREm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 13:04:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C671FD4;
        Wed,  9 Aug 2023 10:04:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F81D75;
        Wed,  9 Aug 2023 10:05:24 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB76C3F59C;
        Wed,  9 Aug 2023 10:04:40 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] selftests: landlock: fix runs on older systems
Date:   Wed,  9 Aug 2023 18:04:33 +0100
Message-Id: <20230809170435.1312162-1-andre.przywara@arm.com>
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

When naively running all kselftests on some systems, it was observed
that the landlock selftest is quite picky and reports failures, even
though the system is fine.

Those two patches relax some tests to make them pass on older kernels:
- The landlock ABI version is only "3" in recent kernels, so patch 1/2
  relaxes the test to accept other numbers.
- Older kernels or some defconfig based kernels might not implement
  the landlock syscall at all. Patch 2/2 catches this.

I couldn't find an easy way to not check for the syscall availability in
*every* test in base_test.c, short of not using TEST_HARNESS_MAIN at all.
If someone has a better idea, I am all ears, especially as this approach
will get quite annoying in fs_base.c.

Cheers,
Andre

Andre Przywara (2):
  selftests: landlock: allow other ABI versions
  selftests: landlock: skip all tests without landlock syscall

 tools/testing/selftests/landlock/base_test.c | 29 +++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.25.1

