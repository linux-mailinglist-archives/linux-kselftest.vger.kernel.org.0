Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006574EB1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGKJtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGKJtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F06DD;
        Tue, 11 Jul 2023 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689068974;
        bh=FsS50Rrim8MuDCPlM48T3gytZjzvk+u7y3PzL9nBrJM=;
        h=From:Subject:Date:To:Cc:From;
        b=o1CDIbxHbAnDkfux/Bps6rjYqxnpceGCeKKCqBL7g7ITU/e6NUiK1WNECmdLCuSCW
         2kUziYlADjOWSM0Q5bf/QVun0DJlyQNTeYqZdgZ2n2vWjrlyvuQINQS2GNkli1i+Cs
         H1DSLfy4Nc4B3JT/ieH5jLrRef6GrTF9FfDro1bE=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] selftests/nolibc: simplify conditions and testcases
Date:   Tue, 11 Jul 2023 11:48:38 +0200
Message-Id: <20230711-nolibc-sizeof-long-gaps-v1-0-dc78c3b85fc3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHclrWQC/x3MQQqAIBBA0avErBtQC4quEi3URhsIDQciiu6et
 HyL/x8QKkwCU/NAoZOFc6rQbQN+sykS8loNRplODVpjyjs7j8I35YB7ThGjPQRVMKN3diDqV6j
 1USjw9Z/n5X0/ZlEEr2kAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689068953; l=662;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FsS50Rrim8MuDCPlM48T3gytZjzvk+u7y3PzL9nBrJM=;
 b=UMDf0t7s2OekdNEY8knIYZXgZ7qVv8iCAlVMsOBWLekg7wkvIt2puz5JGDANeJLttwWVvSzyM
 1LEwIFQEI+CD1HFDyjfhMlmxwe+ZUOB06LUwwg8xa4K00K5dZBhYJp1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few cleanups to the existing test logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      selftests/nolibc: make evaluation of test conditions
      selftests/nolibc: simplify status printing
      selftests/nolibc: simplify status argument
      selftests/nolibc: avoid gaps in test numbers

 tools/testing/selftests/nolibc/nolibc-test.c | 201 +++++++++++----------------
 1 file changed, 85 insertions(+), 116 deletions(-)
---
base-commit: 078cda365b3f47f61047a08230925a1478e9a1c8
change-id: 20230711-nolibc-sizeof-long-gaps-0f28cba7ee4d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

