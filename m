Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB462D861
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiKQKtn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 05:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKQKtm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 05:49:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFB13F61
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 02:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3748BB81FF5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 10:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561DC433D7;
        Thu, 17 Nov 2022 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668682178;
        bh=qEjfEk+eevrhFHGlVf+wkuhUShqD8MCpIbXhyirJC68=;
        h=From:To:Cc:Subject:Date:From;
        b=alX7F0fKNbgp/UiiCUhoxfUJtsRIgF3dp8wJC5uBW16ZQIQyXf17QZSNrbaaWACM9
         11/oV1Mqsb41X0IVoQ4Ouds/aoin0+ptrpicHu6ADn9zlehW9OxkcLOzXA0r66ZLW4
         BC+NUdoXsqvRIFk6FtfEImeiT2/pHGf+Na7ZrUjz9/VUsY6VVaYxZYMDdZ3tCuzsZE
         /Nz3xM1tUmWdc3hlfznV+wFokt7ex2Aicc5c+eHvEfcfNqaoo5YzJFO9xiSPYXEE14
         IxKfmQXnjSPe1p1ciaFYzfhXkj586HX37I0OYYCcxqPKbScqUd508LF6c/31JLNs4A
         HfDtYdEMYIfRA==
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] Documentation: dev-tools: Clarify requirements for result description
Date:   Thu, 17 Nov 2022 10:46:36 +0000
Message-Id: <20221117104636.639889-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=broonie@kernel.org; h=from:subject; bh=qEjfEk+eevrhFHGlVf+wkuhUShqD8MCpIbXhyirJC68=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjdhELLBBYk8IOKoW55b4vpO2LFytCrdgugPagM0Gc i6GD1HeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY3YRCwAKCRAk1otyXVSH0FX+B/ 9INVMOJN4dHzOhG81hCHlyEM5GIlXXvKs85FlU8GRUtBTslxc3CXfV5ICthY+gj0O6nx2VrgbX2VZS 7G6xA/KfqmKGTEl3ogH3v94tQio4ZsywK1Gg30w4WDkmg3MuhWp/rSWpaSj0I0TcYHKOjJTBINh3FR Rix6kpZRd4cdK7kSaUobkvncvly4Pd42Dsqtr3H19JfsztCtnkNNRaO+aXHfthiirPk5xdJx7wixFz fGjHO0j7z+y5l+DzBDgdhXQgs1xftihQVlgBVKS+0bnZeLE1njBliOZ1LQdC7Ko7bN4ygiZU6eLC8j Y2rKuSARKMSkCeBG8zY8XYnW57I9ge
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

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.30.2

