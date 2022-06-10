Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E108547024
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jun 2022 01:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbiFJXgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiFJXfl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244228D6A6;
        Fri, 10 Jun 2022 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654904136; x=1686440136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Js4f9kz2YaYmoc0VfWWcGpSWtATIkYgM+SbstpVR+cU=;
  b=lx8enN9UZURh+OytnrTRqHseqiulRz3z5gPkQxF54i0A+DGlnbsBoy/N
   KGo/PRfHl4PqqAhvCOOnoMrxe1U9ZkWRjT1Yotsg0ZMMz72dgwVeO2e6g
   Qq8qvVWobQPWCuRl/AZ8/7gu4EjcDE679uM5C93bFqoOp/icGYbSsM6I+
   CZgxc23QO4F98vV8qUojRmVm+4BkOh1Y4tFqWuW3wzEPIHzCCNimhyP56
   RnH0uq+5igBiNcGHN3Kd6xcNf+Pj7poI+ueXoAsgvGDpR8D4/PvoD/Ve6
   bgMMJr9cY1dIX7YJn8ZfDr/RdzU7+MaW8Zt+Rg+Ir23IekeQKQneZ9qnr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="276561759"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="276561759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="638384941"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:35 -0700
From:   ira.weiny@intel.com
To:     linux-api@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/6] User pkey minor bug fixes
Date:   Fri, 10 Jun 2022 16:35:27 -0700
Message-Id: <20220610233533.3649584-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


While evaluating the possibility of defining a new type for pkeys within the
kernel I found a couple of minor bugs.

Because these patches clean up the return codes from system calls I'm sending
this out RFC hoping that users will speak up if anything breaks.

I'm not too concerned about pkey_free() because it is unlikely that anyone is
checking the return code.  Interestingly enough, glibc recommends not calling
pkey_free() because it does not change the access rights to the key and may be
subsequently allocated again.[1][2]

The pkey_alloc() is more concerning.  However, I checked the Chrome source and
it does not differentiate among the return codes and maps all errors into
kNoMemoryProtectionKey.

glibc says it returns ENOSYS if the system does not support pkeys but I don't
see where ENOSYS is returned?  AFAICS it just returns what the kernel returns.
So it is probably up to user of glibc.

In addition I've enhanced the pkey tests to verify and test the changes.

Thanks to Rick Edgecombe and Sohil Mehta for internal review.


[1] Quote from manual/memory.texi:

Calling this function does not change the access rights of the freed
protection key.  The calling thread and other threads may retain access
to it, even if it is subsequently allocated again.  For this reason, it
is not recommended to call the @code{pkey_free} function.

[2] PKS had a similar issue and went to statically allocated keys instead.


Ira Weiny (6):
  testing/pkeys: Add command line options
  testing/pkeys: Don't use uninitialized variable
  testing/pkeys: Add additional test for pkey_alloc()
  pkeys: Lift pkey hardware check for pkey_alloc()
  pkeys: Up level pkey_free() checks
  pkeys: Change mm_pkey_free() to void

 arch/powerpc/include/asm/pkeys.h             | 18 ++---
 arch/x86/include/asm/pkeys.h                 |  7 +-
 include/linux/pkeys.h                        |  5 +-
 mm/mprotect.c                                | 13 +++-
 tools/testing/selftests/vm/pkey-helpers.h    |  7 +-
 tools/testing/selftests/vm/protection_keys.c | 75 +++++++++++++++++---
 6 files changed, 86 insertions(+), 39 deletions(-)


base-commit: 874c8ca1e60b2c564a48f7e7acc40d328d5c8733
-- 
2.35.1

