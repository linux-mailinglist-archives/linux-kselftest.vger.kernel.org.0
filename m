Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112E659AEC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346147AbiHTPD3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbiHTPD1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 11:03:27 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108FBF7C
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Aug 2022 08:03:25 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 10DC630EB95;
        Sat, 20 Aug 2022 17:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661007801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9niHnMBOdZ8gLNFfMXZ+PcoYRzuREWzrhMzTvW8610=;
        b=YskTqg5pNH9aq+Z121M5wum2GB3qNmaPGSonK4buJ0IBnXusTEp7jnnjX398yTSPlOmHny
        3mzikzVR0leMlMBeF/sBXLAnGqoYe6qkMdaurCyA6P9GtGhJoF/eLn6mCGubZo7JffpxH2
        5EYv0vE7PQyq9vN28H4ESJrXkMgb65utx0hTuMWIzHryr891//8wJOJcvlqWui3Hei1Q3y
        wCCND+un8DEOCejCERHnCMOPXLGdP+E1GZZG+KemGQz6W0wYBWEXey4L6aMooKZtCdbe/r
        lwqOtjjA5oRVAUgg5DG5MMFyKrqTz5byC4oOt7yadKDJ+G4vDMIdXxstz7Bc1Q==
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
Subject: [PATCH v2 5/5] lib/cpumask_kunit: add tests file to MAINTAINERS
Date:   Sat, 20 Aug 2022 17:03:13 +0200
Message-Id: <8fb0f6130ba542f6cfa2ef2f16a4ff82730162cd.1661007339.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661007338.git.sander@svanheule.net>
References: <cover.1661007338.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cpumask related files are listed under the BITMAP API section, so file
with the tests for cpumask should be added to that list.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: David Gow <davidgow@google.com>
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

