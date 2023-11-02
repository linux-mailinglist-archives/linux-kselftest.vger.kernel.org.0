Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C17DF052
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 11:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbjKBKfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbjKBKfp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 06:35:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE0131;
        Thu,  2 Nov 2023 03:35:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ABAC433C9;
        Thu,  2 Nov 2023 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698921343;
        bh=1nnK+BgW97TZtPhAGFwIN2pVL9Lwel3zDlxOeK1GZE0=;
        h=From:To:Cc:Subject:Date:From;
        b=hp/SNoSVOXUm2gBmEt7NCjTtCofg8ToWbsBifF9Kd3r4tUtWuioL9hwqtS+CbRTM5
         +44EtvxUoltEK16bErmJlLfv13KoegLIHu+lWMDkJ05A1Z6Mplzq2NQR4UT28EmkuJ
         3MN01IJD4ycpIjkpqCnSteIwuhTNqZRYX3zkWFu2xIXocS9tou+zuQi6NhDqUBujgM
         vebm2NL3NQbQJHibw5K1q8LchYPPPfc7KHfsBd98HyiU2YPYViZozcW3OR0nZilgu7
         rXFs7ypd5omEGDhwVRfZkmXb8+llmhTOMLF/3CaanKJUmmk7P9voV0An2U9BjbsVk2
         05su5Veo2NFGg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH bpf] selftests/bpf: Fix broken build where char is unsigned
Date:   Thu,  2 Nov 2023 11:35:37 +0100
Message-Id: <20231102103537.247336-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

There are architectures where char is not signed. If so, the following
error is triggered:

  | xdp_hw_metadata.c:435:42: error: result of comparison of constant -1 \
  |   with expression of type 'char' is always true \
  |   [-Werror,-Wtautological-constant-out-of-range-compare]
  |   435 |         while ((opt = getopt(argc, argv, "mh")) != -1) {
  |       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
  | 1 error generated.

Correct by changing the char to int.

Fixes: bb6a88885fde ("selftests/bpf: Add options and frags to xdp_hw_metadata")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 17c0f92ff160..c3ba40d0b9de 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -430,7 +430,7 @@ static void print_usage(void)
 
 static void read_args(int argc, char *argv[])
 {
-	char opt;
+	int opt;
 
 	while ((opt = getopt(argc, argv, "mh")) != -1) {
 		switch (opt) {

base-commit: cb3c6a58be50c65014296aa3455cae0fa1e82eac
-- 
2.40.1

