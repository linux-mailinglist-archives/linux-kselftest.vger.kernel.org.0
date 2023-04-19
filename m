Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37C6E7B80
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Apr 2023 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDSOFr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDSOFq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 10:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50FF40C7;
        Wed, 19 Apr 2023 07:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A5F863F9F;
        Wed, 19 Apr 2023 14:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B59AC433D2;
        Wed, 19 Apr 2023 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681913143;
        bh=nOoKTOCJ3uH9k61FiEasxH0rLarWnxmZFFtaJY5x3/g=;
        h=Subject:From:To:Cc:Date:From;
        b=NNATWlOJ+m5LfLsJ/jPP8wbO/+W6MKvPubxzWJBfn/iZOd5K/cFyY8BNFjmY3JGsU
         0m7HUs5KzEPb8qg54kGhm1YC2WrcSbMKb9vHANkN031fOztKzkIhlm50R0PCIvyM7z
         Call2nUEX+bKK6D73TvqgMBzMAN1lGTRum2P6sArZ0B+8vWXT1rnYxqvHmj2dDz6uv
         vKmo8ELoHeX6fZsNudd8a3lF6ND9UpDh2m0VA78yXEhwwM5ignx+td1KbaGvnqeyIz
         sM7g3g9es2tf9TTgi8IZlpLzHEuI6n/ekoiez/9PGc3F/NojLO4tLx89WQAHUnyreP
         9DijXi/9bvzJw==
Subject: [PATCH RESEND] .gitignore: Do not ignore .kunitconfig files
From:   Chuck Lever <cel@kernel.org>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        cel@kernel.org
Date:   Wed, 19 Apr 2023 10:05:42 -0400
Message-ID: <168191307928.6696.11689169705819224951.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Resending...  It was not clear to me if this file has a specific
maintainer. I chose to send it to the most recent committer.

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


