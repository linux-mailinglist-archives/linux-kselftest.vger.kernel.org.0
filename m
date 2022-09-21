Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190F5DEA90
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIUSRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiIUSRj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 14:17:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE203A2AB3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 11:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE12B82257
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 18:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E961C4347C;
        Wed, 21 Sep 2022 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663784256;
        bh=/wdRky+c8y5l3fJkLz0auwkKRLAnk4y+UX2JK1z0b2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=po/ol3IPWt8YBOCQ1vJXV/hJOK6whpgqRs/Wl0JDxpAJbkQ+z2eBm89uzcLnAywvv
         5+pu99Mp3XHyQcRU3qkXPa9/MyE/f3gRHuX4NCu8j2S3LjKAo+Z2jhgo9mFa3ReIGG
         nPtmuxFi5maXrFLaTm2i925Cry6bJLyzSMQ7AeXgP9jVlbzwvBwlTN1V4Zebj7mmFp
         +AYyFszFkYIYDy67d4TnPlRwbdcu/ZRZ6RbYtdX0AiIS82Invwup3Z4s/zpGR8Q9nE
         zgq3SRMjXYAXBMS/tNHdj/Te+Ae+kLr5OJ4tu7ZcFwWYFjkulNSEqCw/pZ/3cCq6sG
         dCHsRzPrIBSdg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] kselftest/arm64: Flag fp-stress as exiting when we begin finishing up
Date:   Wed, 21 Sep 2022 19:13:44 +0100
Message-Id: <20220921181345.618085-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921181345.618085-1-broonie@kernel.org>
References: <20220921181345.618085-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=broonie@kernel.org; h=from:subject; bh=/wdRky+c8y5l3fJkLz0auwkKRLAnk4y+UX2JK1z0b2g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjK1RXdlt6shqQ7vIW+4y9Upo6Pe000MEzEXJULCzd 9qohDaGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYytUVwAKCRAk1otyXVSH0HXXB/ 4yEdYyrzIR1QlHgLr49Qg1Ht4wmVkHOIbipF9+PDm+CXZ9CtXwc0v+iN+Ocr+t2+mgHvM8k7wRzVh5 A8B+PC5cP0nAxCpEyn1hmReTsF01/bF5B+uGiKL450hEosRKAZPfG8ps+D6tCkKr91oWLI6RO2mcc3 wsIFZP3fJ0/qyASezrCu6uO3JZPoeZT+EXgKd5bgRBRmTBm4Ai5L8+j+cPsIaxOCLexYLMRjqiLcnK pgnEdGcvgJrAFq52qcywnYo43Kf9Nw88f5Mak0K5jy6IWJS9fRKBTCCjkXzUFXjEYIdBBZh62SFDH7 mZcsEt3stg9WEGlHWGa0syuGkqRkv7
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Once we have started exiting the termination handler will have the same
effect as what we're already running so set the termination flag at that
point.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4387c3cacaa7..03ce3936220a 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -522,6 +522,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_print_msg("Finishing up...\n");
+	terminate = true;
 
 	for (i = 0; i < tests; i++)
 		child_stop(&children[i]);
-- 
2.30.2

