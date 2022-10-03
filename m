Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182795F33FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Oct 2022 18:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJCQ7I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Oct 2022 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJCQ7H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Oct 2022 12:59:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5508C31366;
        Mon,  3 Oct 2022 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jR6Ag5TuAzra/yL5wHYaxUys8VgWrtnRBtjhrHtb0xE=; b=FCywKMTQRZ/vXaFZ43R91YIjFE
        DM977g2gZIrSju1lFnPcX5Pk6M+JcU5b1wEM8vmi4RatSqGxeqKcLjoD+ugxOj14eJVnQFnpri/PE
        ogEyZGuArI7iT6YYm4SihTl17nZMIGmebju7cJKcHCsY1z5YPKT33ZTL51nUvWGUeJSifzu7vzo+H
        lkpjZ9esi9BXyPWwLYhr0KG7tPWFv9o/J5RhGRhtGSIBcDGs9lz8bwFwGtOkTbvp9V2ss+uB2UBk3
        82E3grhhdm8Vyo+u1KxiVatRHb6Yf2LxFvVYbAOu65VRSefxzzBuGdgUyYKYqK2wSrY0B9C2gK7Nw
        PTs2ndoA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofOmK-006xNJ-Bw; Mon, 03 Oct 2022 16:58:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, keescook@chromium.org
Cc:     joe@perches.com, mcgrof@kernel.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/2] SPDX: add copyleft-next-0.3.1
Date:   Mon,  3 Oct 2022 09:58:47 -0700
Message-Id: <20221003165849.1658170-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As suggested by Thomas Gleixner, I'm following up to move on with
the SPDX tag needed for copyleft-next-0.3.1. I've split this out
from the test_sysfs selftest so to separate review from that.

Changes on this v11:
  o Fixed a minor typo on patch #2 as noted by Kees Cook
  o Added Reviewed-by tags by Kees Cook

Changes on this v10:
  o embraced paragraph from Thomas Gleixner which helps explain why             
    the OR operator in the SPDX license name
  o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
    as these are outdated (still valid) in the SPDX spec
  o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
    the test_sysfs stuff is now dropped from consideration in this series

Prior to this the series was at v9 but it also had the test_sysfs and its
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

