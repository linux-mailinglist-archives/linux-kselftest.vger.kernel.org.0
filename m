Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47A4D4C63
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiCJOzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346830AbiCJOuG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FC18BA4D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 06:45:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06A86101F
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 14:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C681DC340E8;
        Thu, 10 Mar 2022 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646923500;
        bh=4h0jyFl04wK6Vz/wb2kZmg2WDzho8RQ/eDWrs2L/kz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGSSX9lPEvw6BNUhxVUd+Z7WPnPDXPLrefn0iDpDkW7xrvV+HUxUKXWbGMxS3BUnj
         VIAVLcQv/IY6tbmQUfgbgGoFkBlLBNMQtdbAysLCTknNzylMwI37ApdmzTsXPGxpAb
         mjwttrRDfs4CXSicRMwtFDstbQPi+VG4Zgb9rM2tKsXZE0lNWl5hXbPySmvRa37Er6
         S6jX+4MByP6X8QJVhZgL8CgJO9uHsVN8GYtKDHLksvDH3fO+i4wMHsiqEHUpqYNYCs
         NEk9TUHA+in92RQNj4kRGDWgDgikP5k+uay/MJk8z4B2cRQvt8XZuscZ5R2Xno+N76
         iiJF+1wFXi8aA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] kselftest/arm64: Log unexpected asynchronous MTE faults
Date:   Thu, 10 Mar 2022 14:43:33 +0000
Message-Id: <20220310144335.2097457-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220310144335.2097457-1-broonie@kernel.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; h=from:subject; bh=4h0jyFl04wK6Vz/wb2kZmg2WDzho8RQ/eDWrs2L/kz4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKg6TiwBU/SdIu87f3y0jyt8PavdhNXXtlCv/2EK1 b/rIJXWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYioOkwAKCRAk1otyXVSH0PxeB/ 48veVsA9S6lmdWe0GCP/ixCuwjxvqJAefG1zkAL6ukxW8yCQcJH2td4y6amea4xNHzBpljCBHx7o9+ nwjCsMQJ2AWSjV3M43f10haydH/BBxxYoyzQ7XXDBVpyZwmeWYnBls3aW/Zz70eQVI56/ZGX26bGE/ 2aDLkhJtOkz4xc5Q9FqB4qHQeD4RjqZA6Cab4zAm6DSaViEEoJALzmpUM5qgpCwaWZulRqpyVA5siZ SydwWbxikAUX03Ujthf9plK5Upa4l2g7d3D18QGmuKsFWBsslavCJyvHSBta6jV5lcTbki17NDOE/3 Ozz8mRI96UG/QHrXFHkfTufRBYBKvh
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Help people figure out problems by printing a diagnostic when we get an
unexpected asynchronous fault.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 0328a1e08f65..24b0c14203cb 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -37,6 +37,8 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 		if (si->si_code == SEGV_MTEAERR) {
 			if (cur_mte_cxt.trig_si_code == si->si_code)
 				cur_mte_cxt.fault_valid = true;
+			else
+				ksft_print_msg("Got unexpected SEGV_MTEAERR\n");
 			return;
 		}
 		/* Compare the context for precise error */
-- 
2.30.2

