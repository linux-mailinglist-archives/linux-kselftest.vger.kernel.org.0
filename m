Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE81580703
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jul 2022 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGYV6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jul 2022 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGYV6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jul 2022 17:58:51 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F941EC72;
        Mon, 25 Jul 2022 14:58:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658786329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GS9qkjDWVYyTMBjKL8U/qgM/1iWoi/1jaZgdFbkaSHE=;
        b=dEfcC+CBg9W2j00cp8F5iVSpWUlyGHOd+LpnYLgey/jpoAeBrsuTG4UiQ3f59jtAEpczxf
        xZgnwmccWXZ7ml/qH5ghkDvEDRaBO/1N2rSV+tFswgXDJcXT2sr64wKI9ey89OncJhKTP5
        jf6XBsjIFd5k0URW8IFTthnD2WEQBFs=
From:   Brendan Higgins <brendan.higgins@linux.dev>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        akpm@linux-foundation.org, brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendan.higgins@linux.dev>
Subject: [PATCH v1] mailmap: add linux.dev alias for Brendan Higgins
Date:   Mon, 25 Jul 2022 17:58:33 -0400
Message-Id: <20220725215833.789133-1-brendan.higgins@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Because of my new work remote setup at Google, I can no longer use
command line tools with my google.com email address, for this reason I
got a linux.dev account. So update the mailmap to show the new alias I
will be using.

Signed-off-by: Brendan Higgins <brendan.higgins@linux.dev>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 13e4f504e17f..24aca1d3a5f1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -74,6 +74,7 @@ Boris Brezillon <bbrezillon@kernel.org> <b.brezillon.dev@gmail.com>
 Boris Brezillon <bbrezillon@kernel.org> <b.brezillon@overkiz.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
+Brendan Higgins <brendan.higgins@linux.dev> <brendanhiggins@google.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
 Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
-- 
2.37.1.359.gd136c6c3e2-goog

