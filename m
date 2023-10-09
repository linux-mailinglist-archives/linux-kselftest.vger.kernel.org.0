Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFE7BD89C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbjJIKbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345903AbjJIKbi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:31:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BBDF1;
        Mon,  9 Oct 2023 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847494; x=1728383494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHXhr/Amo8gh/HA2VTVFzzTi37cYr/rpIJkcT+9qONg=;
  b=J/iGfmrdKP6K0jOGxF0XXDc7fA7pb1e2ug8o6UfCmor3uvdrjmvO0gxO
   xK79xh+6SQ+AVasqH9u/cBfxrkaO3A5/4TijSvNJHNf5sHnSOJTUG+6bJ
   bFVo6Bd+DD9gZXQ9PyIJW4pG49a8y2ZHKWwssBUhOSC1K/xgQmqUL89YM
   OOGWjThzoWmiAhyDY4fkdxSXDSbP5QYkbcEScRiQXHMvPWGzQ8r1rvnwz
   +IlPvHI0YcsKhB7kxlupbODJnAXs3VjYPyRoAKG4HgtK6KrPE4YQxDNgK
   eCWWyWS4Ycwkm6hbBeuOKhlG6ukUQHP22hTPRE4AMwrDyPyn8m1DO6ri5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363468450"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363468450"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926718722"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="926718722"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:31:31 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] selftests/sigaltstack: Fix wrong format specifier
Date:   Mon,  9 Oct 2023 12:30:39 +0200
Message-ID: <9550750decf20a2c8540d5aec74b7747e4d6862f.1696846568.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
References: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The format specifier inside ksft printing function expects a long
unsigned int but the passed variable is of unsigned int type.

Fix the format specifier so it matches the passed variable.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v2:
- Added Reviewed-by tag (Ilpo)

 tools/testing/selftests/sigaltstack/sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 98d37cb744fb..07227fab1cc9 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -111,7 +111,7 @@ int main(void)
 
 	/* Make sure more than the required minimum. */
 	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
-	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+	ksft_print_msg("[NOTE]\tthe stack size is %u\n", stack_size);
 
 	ksft_print_header();
 	ksft_set_plan(3);
-- 
2.42.0

