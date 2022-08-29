Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470BF5A5068
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH2PpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2PpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C12B199
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C6DCB81106
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379DBC433C1;
        Mon, 29 Aug 2022 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787915;
        bh=fBxL1nzlY8qeFhnm7QsFfEvtJ4Mb/hUggbozRGaqApM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQidzeZH43tP5nLkoGlHQDK41L+EJc8IM4s+F8lt4yy/IlXrpzLrBidJ8L/ii9JWC
         1NlpPx2tglLbE+DmNb8G4ylUIo6zT7U5ExvfNcKM85wvlFGD+dDxCo+2SDNfokJlpK
         ap8/Pe9mzkTmr298g49bmurt74EB6XxeaPqrivdn/uO2GQJGcAVHPwSDuJ4pL5Qqoy
         4BMuCsTHLXid/3Ot2VdJyvgUX9Z4LN6qEOQPD6m7RRZf9YFvkJCO1zyomYw2KIycr2
         AS7oFjqo7Sn720pMTGDTj8H+Y5sCwTc6KwuzK2yKTsWMU06xQK3ccmKHhbV6JU3VwN
         yEzVebUcB2bag==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Always encourage preemption for za-test
Date:   Mon, 29 Aug 2022 16:44:49 +0100
Message-Id: <20220829154452.824870-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154452.824870-1-broonie@kernel.org>
References: <20220829154452.824870-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=broonie@kernel.org; h=from:subject; bh=fBxL1nzlY8qeFhnm7QsFfEvtJ4Mb/hUggbozRGaqApM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN7x88WNfyOa5FHhYX6WLftaPWxS0aXpEVmXAFKj 1ozMyeaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwze8QAKCRAk1otyXVSH0IKbB/ 9J2Ke+yDKi+kgQur1HTAKNtlZa0690GRTraoZCG0GE0DCWUShtOYQ9Fiz7Wfzg+1fA6kEgLiSZfva3 J8cM8Ah5v6EkG8CfLZDsvfJ6YV5p1+TxvQFQDtTxWtYUW+F8oP9ypPdpM7klRcj1W5eSgPLuFW3IiT 3mDHF+1atEtD7xCNI7jSabQI78IWiINjQ8IVAZ74wIVAM2A6eKROGHiKyskaos15HzTRDCTUqP0QNA A5jU00rPiz5dJkr8F+kaUr1IkHK/Mu+gxJi0elCbp9hLQBwvpax0yFcOCe50FfSNKR4MYhgIyEYbbQ FPTkuXXSpguSRo0Cn+CgklhdkzAlDZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we now have an explicit test for the syscall ABI there is no need for
za-test to cover getpid() so just unconditionally do sched_yield() like we
do in fpsimd-test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/za-test.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 9ab6f9cd9623..2dd358f9edf2 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -287,12 +287,7 @@ _start:
 	subs	x21, x21, #1
 	b.ne	0b
 
-	and	x8, x22, #127		// Every 128 interations...
-	cbz	x8, 0f
-	mov	x8, #__NR_getpid	// (otherwise minimal syscall)
-	b	1f
-0:
-	mov	x8, #__NR_sched_yield	// ...encourage preemption
+	mov	x8, #__NR_sched_yield	// encourage preemption
 1:
 	svc	#0
 
-- 
2.30.2

