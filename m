Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5A59D10E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiHWGNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbiHWGNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 02:13:00 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968F5FF5D
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 23:12:59 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B2511310212;
        Tue, 23 Aug 2022 08:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661235177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2o1rg99c9jE5s8cxU2HEcE8p1xFOfF6k+D1wBc3N2HE=;
        b=xnbES8GCy9LTjTlMp7hCcQO+sXx9AhfVtQ7Is0yjLbsKZNtX5dx9tb/icTUlfL4YugcTSv
        QxhfhKq4y12Aw/fxi4FUVLFQbIMhEAKQH2PyjeCNGjv/tR/qabIp8OCiwoJrDnbqx9Gopp
        QzNZ/E8QTsuP4VkI2/I59+W4osKEVg+iRs5o1wSg8fCs04C666q4zT7q2hBfgHVNoZYiNM
        KRX76j1MI4xj7lVn/Em7U0TIHJ68t+6WOm+49CWsQd2Ig5vaY8Xj9geomFK6usw4eDLJmq
        zFJ8ccQy5Hr1Hr+raJjYN5v33Q3BG2Yu9P5tc5KC1O2mzm0YXaKtyVCUwHHL4w==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 5/5] lib/cpumask_kunit: add tests file to MAINTAINERS
Date:   Tue, 23 Aug 2022 08:12:23 +0200
Message-Id: <a4d878c1a0f95837f4d2b6db1e3c9248044e6002.1661234636.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661234636.git.sander@svanheule.net>
References: <cover.1661234636.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cpumask related files are listed under the BITMAP API section, so the
file with tests for cpumask should be added to that list.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..0f41174be0d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3612,6 +3612,7 @@ F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	lib/bitmap.c
 F:	lib/cpumask.c
+F:	lib/cpumask_kunit.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
-- 
2.37.2

