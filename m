Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291D07B7F15
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjJDM1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbjJDM1i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:27:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A193;
        Wed,  4 Oct 2023 05:27:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B52C433CB;
        Wed,  4 Oct 2023 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422454;
        bh=wY6Lz/zx7I9HiBpRiawuNkcCXD5tjJfz6F8komvznPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXrJm4DS5M4NI/TAZPxlBg/4QQ0mBVNPLkmxB0BQ+hyoYvazGaRUKOD7m7X9a7Jsv
         9BQSthEQTVVz3PvMnA853dexF644DxsIXZd7XMY0YUqA1h6IW1y8arPOx6lBVwS3NY
         tzRySzd1Ui1cu7I/GOXbI9Z0Y3orcUbZRhpb1WCz40Mz0Rw0FFuhs04+N2qo8lr6pX
         FvVqjZjX1j9HBv6WKAzAchdr1V/PrsjijZk4T+8ZmndGXybhpnaq+piKKLj+Wo7MGq
         kc24UfdHzDd8tkC5q7PZ7SQZRleU1B42NmDDujJtqhl/bQzMIwGKl4oFIQzSHi10vS
         8op2PCRoSiVBQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add uprobe_multi to gen_tar target
Date:   Wed,  4 Oct 2023 14:27:21 +0200
Message-Id: <20231004122721.54525-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
References: <20231004122721.54525-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The uprobe_multi program was not picked up for the gen_tar target. Fix
by adding it to TEST_GEN_FILES.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 098e32c684d5..07ac73cc339d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -104,7 +104,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.39.2

