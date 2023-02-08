Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE26068EBD0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBHJki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBHJkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:40:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361801BFF;
        Wed,  8 Feb 2023 01:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675849237; x=1707385237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbyMqYScSggn/A0pXbBICIlYDlEQgK9ZOdKuaxlgRSY=;
  b=ed8Es94TX8mQxRQc2h4vMHtL4i480SMx+hlSGOJpSwkYHt8cQbg7kVi/
   qO1EgsEE7Xii6tJ5fk1BdVFfWNmsHlFkxlBRl8Kh/yrkaLftm+QzUM7Yb
   KyakpMLmz/WLa0eMLWFeY79m9t3tF9FF1z60cvRnQRhtnLJSe4Bzeq57G
   VyGgyCxZGM6+jGJPPpICyGW7+KGmpmsJxUfEV6Yaz/QUuk7fJmr4lsHCO
   lyoQP8dMmaravdViIvs45iW7ANlJjKnEQ1GjPOlXR2U7G9cPFZMvNM6fz
   IcVDAyfPQChrs5kNxTMRB8KzT/j/bFHSEBR6dno5NCXxtlW8xxqHZNa/V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328410773"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="328410773"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617150228"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617150228"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:40:34 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] selftests/resctrl: Small cleanups
Date:   Wed,  8 Feb 2023 11:40:22 +0200
Message-Id: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fenghua Yu (1):
  selftests/resctrl: Don't hard code divisor in MBM results

Ilpo Järvinen (2):
  selftests/resctrl: Change initialize_llc_perf() return type to void
  selftests/resctrl: Use remount_resctrlfs() consistently with boolean

Signed-off-by: Fenghua Yu (1):
  selftests/resctrl: Change name from CBM_MASK_PATH to INFO_PATH

 tools/testing/selftests/resctrl/cache.c     | 11 +++--------
 tools/testing/selftests/resctrl/cat_test.c  |  2 +-
 tools/testing/selftests/resctrl/cmt_test.c  |  7 +++----
 tools/testing/selftests/resctrl/mba_test.c  |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c  |  6 +++---
 tools/testing/selftests/resctrl/resctrl.h   |  4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c |  2 +-
 7 files changed, 14 insertions(+), 20 deletions(-)

-- 
2.30.2

