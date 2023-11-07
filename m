Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D27E3EEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 13:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjKGMou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344063AbjKGMoX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 07:44:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A03397E3;
        Tue,  7 Nov 2023 04:31:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E1AC433D9;
        Tue,  7 Nov 2023 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360297;
        bh=IaD5LuAKOSRiEqSUbXrGBACv2jpcb8C7CQaFLspeXIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kO+pqV+c+KJqmEN+z7IYsENtYmKdKqYFUTDXuP0ruGZrNwxaGVswLWWymTHOq3Y8Y
         XDT5RxBue/9y5TFq9EhxerurOlmyqfXOnomuCCEtZiwqGse8QltGHojcnz0wGJScLL
         a1B6mAKzAZ2ygqqLUGLrpy3Aldry6BSRoQY1mWYA1j4LnD9LW6zerWTOVBt29LiOfX
         bZEeJyKYxccgpJHWIq5tf6dxpi2l0g+ofNOG73jN5ltzT7KA6xM5sGPOTwZ+OKahF9
         JG9XL7DkIKuxKpCMdvcpK33NrYKBoLbxvHy0m8GEnakUfBwirpF1jqFvWjchjF11vm
         brFNKfKyiGj2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhujun2 <zhujun2@cmss.chinamobile.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/11] selftests/efivarfs: create-read: fix a resource leak
Date:   Tue,  7 Nov 2023 07:30:44 -0500
Message-ID: <20231107123100.3762796-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107123100.3762796-1-sashal@kernel.org>
References: <20231107123100.3762796-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: zhujun2 <zhujun2@cmss.chinamobile.com>

[ Upstream commit 3f6f8a8c5e11a9b384a36df4f40f0c9a653b6975 ]

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by code reading

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/efivarfs/create-read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
index 9674a19396a32..7bc7af4eb2c17 100644
--- a/tools/testing/selftests/efivarfs/create-read.c
+++ b/tools/testing/selftests/efivarfs/create-read.c
@@ -32,8 +32,10 @@ int main(int argc, char **argv)
 	rc = read(fd, buf, sizeof(buf));
 	if (rc != 0) {
 		fprintf(stderr, "Reading a new var should return EOF\n");
+		close(fd);
 		return EXIT_FAILURE;
 	}
 
+	close(fd);
 	return EXIT_SUCCESS;
 }
-- 
2.42.0

