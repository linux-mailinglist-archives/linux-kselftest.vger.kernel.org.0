Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317252FA71
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 11:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiEUJnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiEUJnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 05:43:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A75BD2E;
        Sat, 21 May 2022 02:43:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A88491F465C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653126219;
        bh=JxpYWqA4EvWvPXVdzoV9L/2PthWDoiS5DByYbtXK87U=;
        h=From:To:Cc:Subject:Date:From;
        b=G2nOMSYS/ujgEaDWVYPKh8nfXqDVWgaPRZPWswVtkZHh/OrqPvNSsZ+pKEtWv7TqN
         O/6m1mxQX7bOMJGaG3PzuBs1EBML5i40mrOvB1Op4mvC6gXhPPySjyJnJ9qkO8vUEM
         ABh2CQexKA+hAxFaXpYrZyavrMQwnDJJh2u5i5zvh42e5iqgx92C72KpycpFK8lG8Y
         +OUeRZPZwRP0ypgfkMRuSSvyS1rs7H2yJvrzywjLHzJpFHzzp2AWEh1KKcOlLSThpc
         xLl6K2zrRPx16J7x/fmsMJDXMgYm8AbkV4SbtNpv65lxGp/NKc0YdpR91Kzsemluon
         4tavJqWBvmj/Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: add migration to the .gitignore
Date:   Sat, 21 May 2022 14:43:13 +0500
Message-Id: <20220521094313.166505-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add newly added migration test object to .gitignore file.

Fixes: 0c2d08728470 ("mm: add selftests for migration entries")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 6c2ac4208c272..31e5eea2a9b90 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -9,6 +9,7 @@ map_hugetlb
 map_populate
 thuge-gen
 compaction_test
+migration
 mlock2-tests
 mrelease_test
 mremap_dontunmap
-- 
2.30.2

