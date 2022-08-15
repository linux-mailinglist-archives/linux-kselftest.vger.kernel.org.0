Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FB592FE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiHON0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiHON0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4CF1F622
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF31F60B69
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543BBC43143;
        Mon, 15 Aug 2022 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570002;
        bh=I6wbY4rBExBRkBYLUHMGd3IIhweWX+ewlcK2hqnl2UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oG609GCYZ4okQQt0K+GWF+AdTL56/TPekOOMH6+ZHnkYzInJ9yxDC9yRmwXPIdvsL
         W5x57G6K+ya5ZvBQjib6mS1bxZIu3GNUaHO2dpfq5RLzVDWwEf1USDt+vodA/GP3RM
         P2ycwWCGKnvuiLFUmKWeO9kEUrOrK/i2sg6qKJVgk6IvbDsWXQ/Sgxf15S44oDrK9F
         JI5ZQErD9fDyN2CH6wJOhkjeH2MVhJ4zT0SGMYwO5PIxiLbl8gGMu554E1g13Qmqwt
         6rs+KBI9zi0+xnjfLPg+ZeD2Gt8Kv3Nx8MBbhtrR/npLasS1lY/zt3IJGQ4xAf6nzp
         GLWcenut64amw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
Date:   Mon, 15 Aug 2022 14:26:21 +0100
Message-Id: <20220815132622.220118-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815132622.220118-1-broonie@kernel.org>
References: <20220815132622.220118-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=broonie@kernel.org; h=from:subject; bh=I6wbY4rBExBRkBYLUHMGd3IIhweWX+ewlcK2hqnl2UM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kl89QwzDpe3nJ1hAN12I5LNc/Gpmp6X+5qwHlQC GtmYMn+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpJfAAKCRAk1otyXVSH0FMbB/ 0UEyq+JtpLPkuOxr7eQKqX/W8XNdgO+pEn2oyyVuUx+j8yx+nQLJ9lul1FPzabOuf2BJw+qvbtAolu ZaGrB92gCGRL3SKf8IefjDKYskv6ry9kyxByPhmLULUWdc4QoLoGz0U6P/dwaFigtxlRSUH6GsbIcG 7H7cAe6RLeZ4FlJz9ef9ggtgEUCFHlQSGJ1sXx3q2IcZ+FCg1s+lhZ4WPawwLgkdsCd3Sa/Hyb4TMO urZBEwWb4qLTEabAurxFJKc+gIyN9w4sQ1Ou9mVuwhlQGwjPkwX/Wjb6zS29CzdfaQ8eI5Fv4R/sr/ mdsyd26yUGC7O/abFisg3EV4KpV8Ml
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

