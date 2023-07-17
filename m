Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF27A75635D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGQMz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQMz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC8E49;
        Mon, 17 Jul 2023 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598525; x=1721134525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b2YtQTOB52EtISwGmNJvxnB+CChgEJ2fe0RvWIVjTAk=;
  b=NN6T9T4YlDdLb5zvFn5B0l4umAz+elj/wXOvmmHxhBZkuHxWDhYAphIP
   kJO/S4x5T7yZ/c+gGBzkzqP77gi7yrehM708stTbbmwQmTOBJn3vqK6aH
   dpDOIbFltpCigFE6SugYuynTdvcGu5v9+rMlqlGKQg8bRhO5kmZCOhteb
   8a3sCQOab8ZpzZfFI79vNXIy6trEsMjiJoqZ2/OSKvpsNkqpAHdTRwfmI
   TfWvcMQLmygbmZD7MSVIddEnvK0Ra7IXemxW6xODqTO9WJ9ITwiEPnSWD
   LcZg2a43AL+2hIZ1TgDloaAkYPWcYv9kRIU5YKA+70YIWfp9SHcNtWKdJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429680653"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429680653"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793234536"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793234536"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 05:55:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6EB4256; Mon, 17 Jul 2023 15:55:23 +0300 (EEST)
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
Subject: [PATCH v3 0/4] kernel.h: Split out a couple of macros to args.h
Date:   Mon, 17 Jul 2023 15:55:17 +0300
Message-Id: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are macros in kernel.h that can be used outside of that header.
Split them to args.h and replace open coded variants.

Test compiled with `make allmodconfig` for x86_64.

(Note that positive diff statistics is due to documentation being
updated.)

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

 arch/x86/include/asm/rmwcc.h      | 11 +++--------
 include/kunit/test.h              |  1 +
 include/linux/args.h              | 28 ++++++++++++++++++++++++++++
 include/linux/arm-smccc.h         | 27 ++++++++++-----------------
 include/linux/genl_magic_func.h   | 27 ++++++++++++++-------------
 include/linux/genl_magic_struct.h |  8 +++-----
 include/linux/kernel.h            |  7 -------
 include/linux/pci.h               |  2 +-
 include/trace/bpf_probe.h         |  2 ++
 9 files changed, 62 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/args.h

-- 
2.40.0.1.gaa8946217a0b

