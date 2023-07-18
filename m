Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C910E758696
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGRVLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGRVLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:11:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3F198D;
        Tue, 18 Jul 2023 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714710; x=1721250710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPgZmHzfOQSFBvALoW8Nw2W4wODG+ZtfXhQLXfu+fy0=;
  b=Zl6+l9ixZitftDfYGzSTl+cLtMpvD0OO7lZDjdsJfXWqJMYSYAbPaHlk
   MzN54RwaP8rn7G6xvBIucxQifsmhiz9dzJQLHIJoxHc8ID2HlJNr6EeEO
   ZjCfN0MesHmZWtdEjZ8njFHyBGi1tJKgazTo6KpN3OEC02u+fnL+n5AcW
   qaq6FYnIOnZqgRH+4NruerGFj1MyUTlkHG0uvOyFad9t6yuSC3mQUX2xJ
   ozUDPd5Tn+GztRmkuTsE1cjUeBhj5+Q+YzTnHKyB5ohshV4r8BKHGVGvD
   1R5nw4NUVCMG2TsOwJmpnkNkxUrR6vlG1mSyfpsKesJ95eN97mjL52bhq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397161871"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="397161871"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789205999"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="789205999"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 14:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9ADD216E; Wed, 19 Jul 2023 00:11:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/4] kernel.h: Split out a couple of macros to args.h
Date:   Wed, 19 Jul 2023 00:11:43 +0300
Message-Id: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are macros in kernel.h that can be used outside of that header.
Split them to args.h and replace open coded variants.

Test compiled with `make allmodconfig` for x86_64.
Test cross-compiled with `make multi_v7_defconfig` for arm.

(Note that positive diff statistics is due to documentation being
updated.)

In v4:
- fixed compilation error on arm (LKP, Stephen)

In v3:
- split to a series of patches
- fixed build issue on `make allmodconfig` for x86_64 (Andrew)

In v2:
- converted existing users at the same time (Andrew, Rasmus)
- documented how it does work (Andrew, Rasmus)

Andy Shevchenko (4):
  kernel.h: Split out COUNT_ARGS() and CONCATENATE() to args.h
  x86/asm: Replace custom COUNT_ARGS() & CONCATENATE() implementations
  arm64: smccc: Replace custom COUNT_ARGS() & CONCATENATE()
    implementations
  genetlink: Replace custom CONCATENATE() implementation

 arch/x86/include/asm/rmwcc.h      | 11 ++---
 include/kunit/test.h              |  1 +
 include/linux/args.h              | 28 +++++++++++++
 include/linux/arm-smccc.h         | 69 ++++++++++++++-----------------
 include/linux/genl_magic_func.h   | 27 ++++++------
 include/linux/genl_magic_struct.h |  8 ++--
 include/linux/kernel.h            |  7 ----
 include/linux/pci.h               |  2 +-
 include/trace/bpf_probe.h         |  2 +
 9 files changed, 84 insertions(+), 71 deletions(-)
 create mode 100644 include/linux/args.h

-- 
2.40.0.1.gaa8946217a0b

