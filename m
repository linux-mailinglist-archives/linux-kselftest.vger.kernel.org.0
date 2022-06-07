Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1318653A864
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jun 2022 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354477AbiFAOIX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354510AbiFAOHW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 10:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB17A2073;
        Wed,  1 Jun 2022 07:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B2B0615BF;
        Wed,  1 Jun 2022 14:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D4FC34119;
        Wed,  1 Jun 2022 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654092001;
        bh=KJhUKllErRJpBntBCZwKFWW3K3q4jqc9MvCVLYA5Vgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSbO3vNwdDp3hvanO2mD6VrlUEq/I9RD+hWykXMLzzUVp69GfYbvTpe0sBX35R41G
         796O2Fk8kn/FBKJlzFlgfj6Klx9crgnTvD+e87cWRli0XFTyX5QoezAQFKT8l8RQTM
         fLPBG4M+9Rtq1wc2Jr9OJiNI4G4mD3kDihgwf78Nw85TYeOCm5Yt+LxY2BGcC2SzkU
         wigbkozU19+Cx0OMBMy8XhJh6yr0NT9P92LJ2MBrCY9V2PrGONq4J6ZfmrQ1i9WkE4
         4p+NuIuBc91Cbm673wY0q3HjpgIsOn9t40IequX4X+QyIyARSOExPn4HDS9MrX3bdg
         MfS4zkLeBZn7Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/15] selftests/resctrl: Change the default limited time to 120 seconds
Date:   Wed,  1 Jun 2022 09:59:40 -0400
Message-Id: <20220601135951.2005085-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601135951.2005085-1-sashal@kernel.org>
References: <20220601135951.2005085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

[ Upstream commit e2e3fb6ef0d6548defbe0be6e092397aaa92f3a1 ]

When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
selftests fail due to timeout after exceeding the default time limit of
45 seconds. On this system the test takes about 68 seconds.
Since the failing test by default accesses a fixed size of memory, the
execution time should not vary significantly between different environment.
A new default of 120 seconds should be sufficient yet easy to customize
with the introduction of the "settings" file for reference.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/settings | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/settings

diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
new file mode 100644
index 000000000000..a383f3d4565b
--- /dev/null
+++ b/tools/testing/selftests/resctrl/settings
@@ -0,0 +1,3 @@
+# If running time is longer than 120 seconds when new tests are added in
+# the future, increase timeout here.
+timeout=120
-- 
2.35.1

