Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934AE6E3A76
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Apr 2023 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDPR0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Apr 2023 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDPR0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Apr 2023 13:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E82114;
        Sun, 16 Apr 2023 10:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233B761048;
        Sun, 16 Apr 2023 17:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D737C433EF;
        Sun, 16 Apr 2023 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681665966;
        bh=ncxpGOSaL56uTiJe56OB54FSN1HoiRc4uRzhwedAZws=;
        h=Subject:From:To:Cc:Date:From;
        b=lRZbYCRXEoQ5bAXwyT/UjuHpHbi0Kn/oOn8pPmYCvYoS1Ap1n1DkkoWODDcX6mMsi
         hMAerBVlkaM5iRT2jmCZRVqCw7fx7LgvrZGUxyFriJU2F0M78LJWfKw9IcEwqTOTzw
         T8b5DAS1mTdWdG7H+zH+akypCcjHEJpoOtO15GVqAli8wWgfgz+ec94qwJcy7+Wv2l
         h3cQy9X68EBLH3QDpryFlmG+qtUGPWxDfagRlLqNpMHXCbv4b0SCTf5mr10Q+475UG
         2TGlKcxub6mf0N25YYzECCISdiogL5D1sqhz9Jhvxilt92R7+q5g9cZ8ZCIY2grCEt
         FsgKtdcp8SURg==
Subject: [PATCH v1] .gitignore: Do not ignore .kunitconfig files
From:   Chuck Lever <cel@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     cel@kernel.org
Date:   Sun, 16 Apr 2023 13:26:05 -0400
Message-ID: <168166596494.8585.5098775951875234065.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Circumvent the .gitignore wildcard to avoid warnings about ignored
.kunitconfig files. As far as I can tell, the warnings are harmless
and these files are not actually ignored.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304142337.jc4oUrov-lkp@intel.com/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..51117ba29c88 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,7 @@ modules.order
 !.gitignore
 !.mailmap
 !.rustfmt.toml
+!.kunitconfig
 
 #
 # Generated include files


