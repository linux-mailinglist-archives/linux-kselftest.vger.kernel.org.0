Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C356AECAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCGR5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 12:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCGR4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 12:56:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15635A42C8;
        Tue,  7 Mar 2023 09:51:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B75561522;
        Tue,  7 Mar 2023 17:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EAFC4339B;
        Tue,  7 Mar 2023 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678211484;
        bh=B9SXSPHOZ8dmNNiuXWw1/8WcmeIEgRI7oLH4wukwo9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeONtwLpQDrMeg4ZG8cTbMFnx+tXLsfpXTFwmC+7/Z0SC4FxV1dGKePCwrvZCjJD2
         zV5XqDaqpSwIeKrOm8IUvnu42LBbjyb99uI6e0M7/cPNuqAc9y/RfxZzbJXfnyJzUo
         ifSq7kpjTFDaaKPWsRoTlZHIfQaRJJyhG+6BENvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 6.2 0877/1001] selftests: dmabuf-heaps: Fix incorrect kernel headers search path
Date:   Tue,  7 Mar 2023 18:00:49 +0100
Message-Id: <20230307170059.963859139@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307170022.094103862@linuxfoundation.org>
References: <20230307170022.094103862@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit f80f09b59fdd45753dd80ac623981ad00ece4c2d upstream.

Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
building against kernel headers from the build environment in scenarios
where kernel headers are installed into a specific output directory
(O=...).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <stable@vger.kernel.org>  # 5.18+
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/dmabuf-heaps/Makefile      |    2 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/dmabuf-heaps/Makefile
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS = dmabuf-heap
 
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -13,10 +13,9 @@
 #include <sys/types.h>
 
 #include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
 #include <drm/drm.h>
 
-#include "../../../../include/uapi/linux/dma-heap.h"
-
 #define DEVPATH "/dev/dma_heap"
 
 static int check_vgem(int fd)


