Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2E7ADE31
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjIYR6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjIYR6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187E19E
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695664677; x=1727200677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FNtO6GAEV5vAdrVcg9C+rRwuTzaz5sN93qtjUy9BdYc=;
  b=SH5yx1Cr9Z9O6MHVNAgg1/RQRbbNc/p4JPYJ2xCeGN+cuIExXULBAa8a
   NCMrV63Ub1NXWx76a+kTgQXEbNvc0e96pI0sPKpbpFMg5lye2W+LZE6sg
   LZFVDZuKt/76T2Q9gaY1FNuHcyZ6DdlLW+CqVCu9BXhPq8xzKeQLZ4bWU
   MqaqmHR2ljE29JYlhXsEcdQ/VRYzVyhBsSHPWzccryXCEK6IkNJjku//c
   QrG65aeVlScN2skFGgFhpMXlwDcQzWtkaMqdsp0fBKODpbGySHzWzQtjn
   U1SCvPcWhbV5K04FAkLJJeEReWM8FRhdliH0TknQpCeMuWbrlbJOnx7KV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371643638"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371643638"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995489251"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995489251"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.28])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:57:52 -0700
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH 0/4] kunit: Fix indentation of parameterized tests messages
Date:   Mon, 25 Sep 2023 19:57:29 +0200
Message-Id: <20230925175733.1379-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The indentation of parameterized tests messages is currently broken in kunit.
Try to fix that by introducing a test level attribute, that will be increased
during nested parameterized tests execution, and use it to generate correct
indent at the runtime when printing message or writing them to the log.

Also improve kunit by providing test plan for the parameterized tests.

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
    
Michal Wajdeczko (4):
  kunit: Drop redundant text from suite init failure message
  kunit: Fix indentation level of suite messages
  kunit: Fix indentation of parameterized tests messages
  kunit: Prepare test plan for parameterized subtests

 include/kunit/test.h | 25 ++++++++++++--
 lib/kunit/test.c     | 79 +++++++++++++++++++++++---------------------
 2 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.25.1

