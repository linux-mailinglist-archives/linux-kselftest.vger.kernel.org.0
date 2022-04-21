Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CF50A421
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390081AbiDUPcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiDUPcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FFC42A3F;
        Thu, 21 Apr 2022 08:29:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2AD921112;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5prPCFHB7tTpkq+k4vcAxkUxCclepioM3qt4/48E8Q=;
        b=2Z74KBSTI+RRW3GVqizC7kuz1hDkLz4U4zUBxmnuybv0YQL24y8MZ/NB4Xll2RqEmewWUh
        ImYL2fb/kOneaW3yh1blQ3OZGTLcKxh7ij8YZ8tGSnCx+Hdd8PSEi8xWQ2NhKyqMqddyAD
        WY5J7zo3N49wwyZK533B8iE3ajDLr5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5prPCFHB7tTpkq+k4vcAxkUxCclepioM3qt4/48E8Q=;
        b=cDTswGpjMsuGJ40wpUPWQRFhzrHaBSYb6Oq9VLny/QKIAhXFq2nockljSqAHs15IeQZYTv
        Q+OSzGO1KvMe6nDA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 8F5832C141;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] selftests: firmware: Fix the request_firmware_into_buf() test for XZ format
Date:   Thu, 21 Apr 2022 17:29:06 +0200
Message-Id: <20220421152908.4718-4-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220421152908.4718-1-tiwai@suse.de>
References: <20220421152908.4718-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test uses a different firmware name, and we forgot to adapt for
the XZ compressed file tests.

Fixes: 1798045900b7 ("selftests: firmware: Add request_firmware_into_buf tests")
https://lore.kernel.org/all/20210127154939.13288-1-tiwai@suse.de/
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 731f011def78..3ac09b401a83 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -504,6 +504,7 @@ test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
 
 # test with both files present
 $RUN_XZ -k $FW
+$RUN_XZ -k $FW_INTO_BUF
 config_set_name $NAME
 echo
 echo "Testing with both plain and xz files present..."
@@ -529,6 +530,7 @@ done
 
 # test with only xz file present
 mv "$FW" "${FW}-orig"
+mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
 echo
 echo "Testing with only xz file present..."
 for i in $(seq 1 5); do
-- 
2.31.1

