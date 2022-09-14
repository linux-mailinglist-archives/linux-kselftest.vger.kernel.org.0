Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46835B8132
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiINGCL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 02:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiINGCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 02:02:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AC61DB6;
        Tue, 13 Sep 2022 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zXyGOtjB5RSZuyz9uuyrmx8YbIOe3i8LfT2A7vrECsQ=; b=IeJ49Ndbg/qRyON3k1AyApFlMH
        5RWnKolWg65mwqsBnlt98vDFeABM4VVVLsnIGA0txfvBVNtAPMYGpvbTzJ6EmwqqNvl4/p+vdI1w+
        Ppjm7yaFKNmJ8SsHkLF5kTlfLdga2Cx8C3DwK2S7715ybf+9GNR7pS/PsMdhvejPAOh71W6sjyK1d
        BhnLBsC5BGJxGBGMmb2c0YdCxcJe5gR2bwshNn+xw4wnp3SvisyL0D/7sABDDGJTYHYWcngphDBMA
        9kr41VInNV9ORayxXZN6Q/8srXOKqIi7cbuu4J/xvm/QlRcV/BucQMDZyDfe9tV6et5mQ3SARRV6y
        jSNvq5cg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYLT2-00879r-9l; Wed, 14 Sep 2022 06:01:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     joe@perches.com, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] SPDX: add copyleft-next-0.3.1
Date:   Tue, 13 Sep 2022 23:01:45 -0700
Message-Id: <20220914060147.1934064-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As suggested by Thomas Gleixner, I'm following up to move on with
the SPDX tag needed for copyleft-next-0.3.1. I've split this out
from the test_sysfs selftest so to separate review from that.

Changes on this v10:

  o embraced paragraph from Thomas Gleixner which helps explain why             
    the OR operator in the SPDX license name
  o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
    as these are outdated (still valid) in the SPDX spec
  o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
    the test_sysfs stuff is now dropped from consideration in this series

The last series was at v9 but it also had the test_sysfs and its
changes, its history can be found here:

https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/

Luis Chamberlain (2):
  LICENSES: Add the copyleft-next-0.3.1 license
  testing: use the copyleft-next-0.3.1 SPDX tag

 LICENSES/dual/copyleft-next-0.3.1        | 236 +++++++++++++++++++++++
 lib/test_kmod.c                          |  12 +-
 lib/test_sysctl.c                        |  12 +-
 tools/testing/selftests/kmod/kmod.sh     |  13 +-
 tools/testing/selftests/sysctl/sysctl.sh |  12 +-
 5 files changed, 240 insertions(+), 45 deletions(-)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1

-- 
2.35.1

