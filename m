Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503F73D277
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFYQfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFYQfp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:35:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83180D2;
        Sun, 25 Jun 2023 09:35:27 -0700 (PDT)
X-QQ-mid: bizesmtp65t1687710553t98ik04m
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:29:12 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3jAAyOIuYctrEAjhb6lfe3FzB4NnUfK8VafOKQE7HZhtdj4uDGS+
        1W00RXUROLI+idPD0bhJrNaGXY12br/ovI2SbZ7XL0oyCPVpVDMC/PGb/MshT2mM3Bv8G6V
        Yq4Jsio/H2+5DbAvbgUXDjZGAsdmVKeUwVcYMoafnUtjcXkTWbK5kZTAL27NYh5dQcEABaG
        NVXtVp51mAfJbZ+vMl3/Ja7EpiaPJywcET9lwTrfb16YsP3QcUGy9J5wv/F3DT+Oqea9z3d
        UdPwSsJgcXT4edZ58GD9Oi7nLGD/i7yzQLBS0mZZlQGjqaz6Je+nVfZ55ssegksEk6HAaJ4
        gBGUstM9JmOQDP/E28rvhGrgsuwIHaiDU2VLu3s6LrJxq07BEg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15685378674173329080
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 11/22] selftests/nolibc: add extra configs for x86_64
Date:   Mon, 26 Jun 2023 00:28:26 +0800
Message-Id: <3a29bf1052f72703ec4fca867164ae13fa6c90c7.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable CONFIG_64BIT for x86_64 and x86.

Add 8250 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 16bfb6f9644a..d45454f86ae1 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -59,6 +59,8 @@ EXTCONFIG_COMMON    += -e SHMEM -e TMPFS
 
 # extra kernel configs by architecture
 EXTCONFIG_i386       = -e COMPAT_32BIT_TIME -e SERIAL_8250 -e SERIAL_8250_CONSOLE
+EXTCONFIG_x86_64     = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
+EXTCONFIG_x86        = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

