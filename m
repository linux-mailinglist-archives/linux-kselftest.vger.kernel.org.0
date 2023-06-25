Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C973D21F
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFYQ1f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYQ1e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:27:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C361F7;
        Sun, 25 Jun 2023 09:27:32 -0700 (PDT)
X-QQ-mid: bizesmtp77t1687710441t3hpzh77
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:27:16 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3jfv+GrddGy/h732CQmxjaLBuw5R7mVsFbalvzaON6GtUk2EqZiu
        yil084Xx27fPqRjLobtwWVFo7IvOvFlhslNa8GzceazCMbcUhHFNrHC+lwMzVUiL4S2kSdH
        K9GOr0sgynSUm8WOXFab3g+7Zqi50/2Q8GI01zDu8jAbco2urpJCZF/xr7VzbboZhI/wLUj
        32v2kQDpnY2unmncRMtucZo5zAitwlV00cV5ZqDTaqvE3AVp+TZkxIs24rcvNsmRF6Vu7Up
        Iy1qAwPGCUY9flOO0FZOYzO9y3j6tOPyFav11bCRDIagzJODzej/cfOEflphlq5/v79G/OG
        QyyL9ocHaYXR3JfV347eLsFMZZKUnqWjcMJoCDrESycuacsjR4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 986414869022069346
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 10/22] selftests/nolibc: add extra configs for i386
Date:   Mon, 26 Jun 2023 00:26:31 +0800
Message-Id: <ccfb4ae9c696291332ba4a9b7dae4645960c295a.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable CONFIG_COMPAT_32BIT_TIME for the poll test cases.

Add 8250 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 1cddacbeb95e..16bfb6f9644a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -58,6 +58,7 @@ EXTCONFIG_COMMON    += -e PROC_FS
 EXTCONFIG_COMMON    += -e SHMEM -e TMPFS
 
 # extra kernel configs by architecture
+EXTCONFIG_i386       = -e COMPAT_32BIT_TIME -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

