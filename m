Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6666247B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjAILnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 06:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjAILnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 06:43:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312FD20D;
        Mon,  9 Jan 2023 03:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCCDB6102E;
        Mon,  9 Jan 2023 11:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D185CC433EF;
        Mon,  9 Jan 2023 11:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673264580;
        bh=k4VFwDwt+3kN+Vy2Mbffh4lRQPurzk1UNIus5/rXg4I=;
        h=From:To:Cc:Subject:Date:From;
        b=OQJWuHnAubh118bda8DEf94hNpg3w0eNF5RRtif1owHukw9rd0cUn3AgyQI36Xk/3
         3GIUuSXDdGXXmC5CDcBCulDRftNEb6CXJuWqDy3dGUycik5Tbtf0jOv94JCl2xvbx0
         TwCtP+vqyWBgI/eudylW2rAY8qnpTchD+KZ/hzFcM1KIGmWt+NiM5a82s60QWf16zf
         pGGjPB6wIEKVvDWw+vtdiPOnXXZalE+wppcIhD/J5Ws0l8nx3jvDVKBikla4bhujHs
         HzjGOcSXxsZapwlv/T5lRYNBnYlER6i14FVo66EiPiuKFJCDrKXV5kkSdit2ePg1j3
         4YyIzTXrHneag==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: Enable cross-compilation
Date:   Mon,  9 Jan 2023 12:42:51 +0100
Message-Id: <20230109114251.3349638-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Selftests vm builds break when doing cross-compilation. The Makefile
MACHINE variable incorrectly picks upp the host machine architecture.

If the CROSS_COMPILE variable is set, dig out the target host
architecture from CROSS_COMPILE, instead of calling uname.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/vm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 89c14e41bd43..1cded308dddf 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -5,7 +5,11 @@ LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
 
 include local_config.mk
 
+ifeq ($(CROSS_COMPILE),)
 uname_M := $(shell uname -m 2>/dev/null || echo not)
+else
+uname_M := $(shell echo $(CROSS_COMPILE) | grep -o '^[a-z0-9]\+')
+endif
 MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/ppc64/')
 
 # Without this, failed build products remain, with up-to-date timestamps,

base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
-- 
2.37.2

