Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0E532EF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiEXQaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiEXQaQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 12:30:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5A3FBE2;
        Tue, 24 May 2022 09:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5751F93F;
        Tue, 24 May 2022 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653409812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uw2274IZaH6wHNxtdm16PTTjUp+I1Z5ZIJ2mltVHUsc=;
        b=f3ITPDW8ZmyDffQ+RVLr09F0AOIYDqQdoBUbftcYWElrvzH+ZGF3CYxF1+jhdvf2wcZ4Ef
        XgqgprPYXJzn0/sAOHQE43rbh8j0MnLZD2SH3GrisWY4is2X2s0YAdMzKpXus7fdFP5wLx
        qoDN+OL4+KqX3CJyL0rhGdXimAKXb3w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C766413ADF;
        Tue, 24 May 2022 16:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kHmtLxMIjWJaWgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 May 2022 16:30:11 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3 2/5] selftests: memcg: Expect no low events in unprotected sibling
Date:   Tue, 24 May 2022 18:29:52 +0200
Message-Id: <20220524162955.8635-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220524162955.8635-1-mkoutny@suse.com>
References: <20220524162955.8635-1-mkoutny@suse.com>
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
Reviewed-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c012db9d07d6..4924425639b0 100644
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

