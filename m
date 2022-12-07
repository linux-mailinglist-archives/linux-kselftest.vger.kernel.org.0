Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0479F645A53
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLGNDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 08:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGND3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 08:03:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C67248E7
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 05:03:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAE3FB81DC6
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 13:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B3C433C1;
        Wed,  7 Dec 2022 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670418206;
        bh=ZoMUBiXMY4nrVymPcclP7eUV6nooijG6WN+H+0DnhHU=;
        h=From:To:Cc:Subject:Date:From;
        b=HJ3azF19iWSjurbWkbQmvgVhA7XAMeE8YcED24LVhjop9sCank3vtSReiy6JubxRj
         HTB52cm55vNX5GDQrkNDsiEDY8tazPBOkNZz6loBnzKgc6EvvMEgWsZU8wSpZckc1f
         OWOF4fhvUvUNKP2LuaeUvhvd9aZ88Qms/bhN14wMBN1ISB4JGHSvR2W3Bam5MExvpN
         Z8b7KaKysInvC+yE8SrdAuFKXGIT6sDIZ17lkA67DsQrpMbABdUzEoTAZULk6baXfK
         M4vYkLa5xOXc2o2SGh/z+uhrReZL2E1Q5I9sOqP34myOUYbMnnhOtZ72hpBQr8HYau
         vrntrlAqZGjvg==
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH RESEND] Documentation: dev-tools: Clarify requirements for result description
Date:   Wed,  7 Dec 2022 13:03:02 +0000
Message-Id: <20221207130302.129026-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=broonie@kernel.org; h=from:subject; bh=ZoMUBiXMY4nrVymPcclP7eUV6nooijG6WN+H+0DnhHU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjkI8FH57whm/8uK1qnggy1M6mKqj4uTp75d/F+ZLI dO6iX4WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY5CPBQAKCRAk1otyXVSH0HMCB/ 0cBgUt9JoQIdbO+dBuBrLkV6IU30oYmSpWkpKNNrAzzfoy+c5obAhR4B+1J0E5RHCe8+2Jf5m8NDpY 7V8FgnGbxsFg+HxbH+8xR/Qm2xaZas7KeC21igwXiTw2yV8aLeEX8+QjCTKwEtSKqhfakrfF+bzQCx F73/oDDi9tJ/YWIiQsif74BvdpMrZXdMRzLxzYKkFbbC/KelLte4GKbRBql9ET5981/I4kjeS+c18z Vau96zk+WrG7NWwhUzKKtuPAEXnFhlPDf5iGCP8ZZraXO5G6UGikO0H3szMole/MTSp21Xq8sMq9Kg /DYdgF28JMtHtSAl+HUMrThwoOeXyh
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the KTAP specification says that a test result line is

  <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]

and the description of a test can be "any sequence of words
(can't include #)" which specifies that there may be more than
one word but does not specify anything other than those words
which might be used to separate the words which probably isn't
what we want.  Given that practically we have tests using a range
of separators for words including combinations of spaces and
combinations of other symbols like underscores or punctuation
let's just clarify that the description can contain any character
other than # (marking the start of the directive/diagnostic) or
newline (marking the end of this test result).

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/ktap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index d0a9565b0f44..414c105b10a9 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -80,8 +80,8 @@ have the number 1 and the number then must increase by 1 for each additional
 subtest within the same test at the same nesting level.
 
 The description is a description of the test, generally the name of
-the test, and can be any string of words (can't include #). The
-description is optional, but recommended.
+the test, and can be any string of characters other than # or a
+newline.  The description is optional, but recommended.
 
 The directive and any diagnostic data is optional. If either are present, they
 must follow a hash sign, "#".
-- 
2.30.2

