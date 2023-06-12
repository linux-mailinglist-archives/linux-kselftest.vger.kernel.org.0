Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1483672BE80
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFLKNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjFLKNU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D64696;
        Mon, 12 Jun 2023 02:54:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31BDE6605907;
        Mon, 12 Jun 2023 10:54:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686563651;
        bh=rito2JpNjG7S6ZzrjRBC00M4lMhGjp6mCmm01aYha1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=KoMomehCXAbDciTeS7+Y2ExKHoDuFHC5QM/m3ji8ngVe+xAZG0/W9jk7oyfHeW6DW
         6AZLgs0L853f+9NB9Pco1ecFDEzcV6GKJ1hl4umlGf1WnrZ8YzMWstAQKTWkIka/Hd
         TVWNQDQtv06Zpw04TYK0Ud/2ATDiBYh5tp7XONtcZIxo8duVg0jFkUE0MOsHZ8tKhT
         Sgz2MqLDusvd/Jd2tes8MKEOGbnayMimFT6dgdGBQfC4GZwn13uhycd2h2uAmAiLJ9
         W3lnt/mZZaori6zUlHdNyWtzVivtzBthX40OVD7EH5tghhtZjstkrcqEa5Z3VZh3e0
         W6N2vyOo4TIoA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Stefan Roesch <shr@devkernel.io>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: mm: remove wrong kernel header inclusion
Date:   Mon, 12 Jun 2023 14:53:46 +0500
Message-Id: <20230612095347.996335-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is wrong to include unprocessed user header files directly. They are
processed to "<source_tree>/usr/include" by running "make headers" and
they are included in selftests by kselftest makefiles automatically with
help of KHDR_INCLUDES variable. These headers should always bulilt
first before building kselftests.

Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 95acb099315e..e6cd60ca9e48 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 
 TEST_GEN_PROGS = cow
-- 
2.39.2

