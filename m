Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9452BF98
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiERPk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiERPkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:40:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A32CE38;
        Wed, 18 May 2022 08:40:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8847D21B9B;
        Wed, 18 May 2022 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652888447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s4UvaoqQhOvXVFcayQAcYm+9aULoAvV0U7raXaG3hU=;
        b=ek3UJfEiUiPLsUwTz+kfxjgpe/oHTGh7t+lQgpppq4VT7NQCfgWzI8gtDKPoJHVxEePsbd
        jGjBVmrou19eu2/eV7hu9/gxOzYZRFHFdYa8vSEJ8HhK2TRPIVPr2GH0S09LOiCBot39FG
        tQFeGy3tPwfWGummxk34KWZtUrQKrEE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5831213A6D;
        Wed, 18 May 2022 15:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gL+rFH8ThWJDUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 15:40:47 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 2/4] selftests: memcg: Expect no low events in unprotected sibling
Date:   Wed, 18 May 2022 17:40:35 +0200
Message-Id: <20220518154037.18819-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518154037.18819-1-mkoutny@suse.com>
References: <20220518154037.18819-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is effectively a revert of commit cdc69458a5f3 ("cgroup: account
for memory_recursiveprot in test_memcg_low()"). The case test_memcg_low
will fail with memory_recursiveprot until resolved in reclaim
code.
However, this patch preserves the existing helpers and variables for
later uses.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4958b42201a9..eba252fa64ac 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -528,7 +528,7 @@ static int test_memcg_low(const char *root)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		int no_low_events_index = has_recursiveprot ? 2 : 1;
+		int no_low_events_index = 1;
 
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
 		low = cg_read_key_long(children[i], "memory.events", "low ");
-- 
2.35.3

