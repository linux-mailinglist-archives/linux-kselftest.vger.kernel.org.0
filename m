Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C206BACA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCOJwn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 05:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCOJwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 05:52:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BC7C945
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=wOdBB9DOy3abvz7foLOKdqYSNmPeKma/dxBrSBJ0zLQ=; t=1678873865; x=1680083465; 
        b=D/9xyLrjpdObDUEccKaOr7PG6w6XCgl0pVoAfYnHqLuj8PjQCIUv6Y4XwZEWurno9dx6exjNaPV
        5R44574+ECUWE7FAfbjbAeEQgeWPTyrG7hOYYWXDhNoMxxEoyJkkGPhMsvV4aMoaDeAcRfAv03xak
        YzmrAAs0/bNTtBpb6WqY1dL42syhkRGh/oDwkt4jz67XwVDXhQTnimNtAJ+fjhJeok1au/QlICMQ/
        ezJQxsWT/+QO885us5ejQavZnawusQt+yf1hcNfr9+CcqIAtlPBU5rwLABsammK//fpCi0yNEZZ+t
        br9RMJPuifh4M633FcUgFL6mXCDxD3W2IXLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pcNmf-0042d0-1r;
        Wed, 15 Mar 2023 10:51:01 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] kunit: tool: fix type annotation for IO
Date:   Wed, 15 Mar 2023 10:50:55 +0100
Message-Id: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This should be IO[str], since we use it for printing strings.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 tools/testing/kunit/kunit_printer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
index 5f1cc55ecdf5..015adf87dc2c 100644
--- a/tools/testing/kunit/kunit_printer.py
+++ b/tools/testing/kunit/kunit_printer.py
@@ -15,7 +15,7 @@ _RESET = '\033[0;0m'
 class Printer:
 	"""Wraps a file object, providing utilities for coloring output, etc."""
 
-	def __init__(self, output: typing.IO):
+	def __init__(self, output: typing.IO[str]):
 		self._output = output
 		self._use_color = output.isatty()
 
-- 
2.39.2

