Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3524AFA0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiBISeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiBISdy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 13:33:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95FC05CB8A;
        Wed,  9 Feb 2022 10:33:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BBE9B82385;
        Wed,  9 Feb 2022 18:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33228C36AE7;
        Wed,  9 Feb 2022 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644431634;
        bh=Kp3T8Uq/wmdAQIvGZCoRhZ+9BMeChwVbO3ac4eqCP1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjjAyhzjTWSwZC3vK0eV84Ki9kvilUF4oOtZECaOD81W7TiKy7v/teBMCJQZKhT0j
         kDqIV4QEUYf+czHKzQPLGhrmhwLjhPy5z40QPdp2kxt+WQIGCNOLlE9SgahG6Cui92
         xfxsLTxRkcOc0sOl2iccKAuDsquUAtnqxUO+tNIzbxZVjNxDXGlU1GoN5WfpIXBOPW
         EDWAp1QV7K2cnED1fLPc3G7Wjc9VTZjcaALGJAhjtbPKQhmXf6sbtDlkR6rWi0fFUW
         mOpNS8fZGwlRoHZyFxVOqArjO6AoRZTpE5hHYuj3MObor6FTn9epYKSCyep6o51zXL
         k6btDoXljieMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, a.zummo@towertech.it,
        shuah@kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 06/42] selftests: rtc: Increase test timeout so that all tests run
Date:   Wed,  9 Feb 2022 13:32:38 -0500
Message-Id: <20220209183335.46545-6-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183335.46545-1-sashal@kernel.org>
References: <20220209183335.46545-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit f034cc1301e7d83d4ec428dd6b8ffb57ca446efb ]

The timeout setting for the rtc kselftest is currently 90 seconds. This
setting is used by the kselftest runner to stop running a test if it
takes longer than the assigned value.

However, two of the test cases inside rtc set alarms. These alarms are
set to the next beginning of the minute, so each of these test cases may
take up to, in the worst case, 60 seconds.

In order to allow for all test cases in rtc to run, even in the worst
case, when using the kselftest runner, the timeout value should be
increased to at least 120. Set it to 180, so there's some additional
slack.

Correct operation can be tested by running the following command right
after the start of a minute (low second count), and checking that all
test cases run:

	./run_kselftest.sh -c rtc

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rtc/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index ba4d85f74cd6b..a953c96aa16e1 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=90
+timeout=180
-- 
2.34.1

