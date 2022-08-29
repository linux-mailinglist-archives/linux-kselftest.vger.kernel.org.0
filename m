Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2405A51E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiH2Qfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiH2Qf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3122BCF
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5126EB81115
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0505C43140;
        Mon, 29 Aug 2022 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790925;
        bh=I6wbY4rBExBRkBYLUHMGd3IIhweWX+ewlcK2hqnl2UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJN55/cT/Jv8gQBym99PQFhZVkPlgUyahwE7vFMqw+d7VCCdzvO1UsUKQxOKhrs7G
         0h6tu5WJ4p4NEd0ExKS0E625aEk7Ry1vcI11rcf1YIlV6Y+SggtTa1Bstv7ymIk8Pv
         mEOmUIlZgwguHrx/4pt4xIHZgAPIcQVVtZ3hXKIvTHRgbzJl561nWUWbMa4I7/p8Qi
         Tx1s7JdpC8IFzPxwC2DZzFmnD3bG6h58IJfL04UsRfmuf2SMRZMkkYjArnawUEF8ns
         BT4XO674xlzGSnHjxkNTx/KfbcCZPm070alwOagYqe4K723lpmUgFNl2ztscqMGig5
         YmugubJXWQbjw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
Date:   Mon, 29 Aug 2022 17:25:01 +0100
Message-Id: <20220829162502.886816-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829162502.886816-1-broonie@kernel.org>
References: <20220829162502.886816-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=broonie@kernel.org; h=from:subject; bh=I6wbY4rBExBRkBYLUHMGd3IIhweWX+ewlcK2hqnl2UM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOhc9QwzDpe3nJ1hAN12I5LNc/Gpmp6X+5qwHlQC GtmYMn+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzoXAAKCRAk1otyXVSH0Gj/B/ 9PM726kcYnVozQ0nOQeDbXTdsXF/9ttCi4akkyNY7hvAmqN59eWkE30bKBwM/LiP2zkFtMIFfIKx1M My+FE9LoGI0qb2mw5MKVqLqz+yaIksmr07uqxdmYcOcy9vPSiK0tNb/NsoS517QAg89W73H627jguK 0f33pDEFbLihaKls2CabPwGS09mgXAwjJGmlyoXthXHmebxgeKBUBHgopki410tYT/tjwxckeyNtGR bvfDggkYjUPInzrKcuX4y3Gb4rvzEbSjGRmh61YcP+HOD2unpADiFOepnLL8Jdr/P/zqLT6IrdjF5q rm17qS1F6UNmzjZxP7WFpyTxmNUFRM
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

Currently our ABI documentation says that the state of the bits in the Z
registers not shared with the V registers becomes undefined on syscall but
our actual implementation unconditionally clears these bits. Taking
advantage of the flexibility of our documented ABI would be a change in the
observable ABI so there is concern around doing so, instead document the
actual behaviour so that it is more discoverable for userspace programmers
who might be able to take advantage of it and to record our decision about
not changing the kernel ABI.

This makes qemu's user mode implementation buggy since it does not clear
these bits.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/sve.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index 93c2c2990584..e39acf95d157 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -111,7 +111,7 @@ the SVE instruction set architecture.
 
 * On syscall, V0..V31 are preserved (as without SVE).  Thus, bits [127:0] of
   Z0..Z31 are preserved.  All other bits of Z0..Z31, and all of P0..P15 and FFR
-  become unspecified on return from a syscall.
+  become zero on return from a syscall.
 
 * The SVE registers are not used to pass arguments to or receive results from
   any syscall.
-- 
2.30.2

