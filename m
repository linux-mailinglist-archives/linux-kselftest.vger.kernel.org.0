Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FF4CC603
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCCT3L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 14:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiCCT3K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 14:29:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7DDF75
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 11:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37DB61ADD
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB9EC004E1;
        Thu,  3 Mar 2022 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646335703;
        bh=Gu54SDuNGqvRTFA+K0jNYFMTkgy3bhM9Qwoo8QUVzOk=;
        h=From:To:Cc:Subject:Date:From;
        b=GKOG9HAjvMDmHBryTm0qNnRbHgDuJuF5tVOw59KtbPebMN61MM2jFFcZbo/dRovCw
         D/FclFIo7HO5n+Zj7lPVag59D/i2GSSiJm4JEnHOcyinNIlpNslxGGCv6+QgmmJks6
         Zjx+5+v+c6pky3acH6dlwiNXFa//Mxcu4k2Xvhd84WkBWm3kcmnFeX8x10sB39ovcU
         TSEm2FpfA+uI2RdNq3vM2ckJiyBwppcIZWtIf6pBw5z9ZipTdChGjzDxTtwfdra9ua
         ytVqA3A6YVkyPtlkT/q9e1N2m41YHHbsrKPArDNtjVbUYWDUKDtaCoo/a0XZmBYpW2
         yvZRTv9kUP63w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Log the PIDs of the parent and child in sve-ptrace
Date:   Thu,  3 Mar 2022 19:28:17 +0000
Message-Id: <20220303192817.2732509-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; h=from:subject; bh=Gu54SDuNGqvRTFA+K0jNYFMTkgy3bhM9Qwoo8QUVzOk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiIRYvTufy3PDsPE8JygSUWpL3TwjpNYrS6dH7Nixm 6Sl1mwCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYiEWLwAKCRAk1otyXVSH0D1HB/ 4tsCYbZWi3b3BC5YIi373kdhHmt+pBJ+OMI2xdMAfH+ztmur+0RndXGyJVJMi41QnrvA1dtGwZhf0b 4T12o62ATqVKl1dad3Esauc72U3VdLWods95I6buYiPMs1aA2yAP07bjf0CokZnzvQsD9PkKh+nvqv WXaG3jRlEpmiEW53vPAl1+8pyv+nQVqj2VgYLLlYNWr5KqJ16sz8Y6yFPd/qLDJpG3+8/7GEmKzG2G 55Iw8OmgiNFNHXjtoOjmf8YnzDH28NDStnSTvK0u7l2IlO4jg2vb0X6bOtZAxfjx9V46WCdD+QPsWm YRaeHD7FMA0DeHpsKcT3vYYw5Izttj
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the test triggers a problem it may well result in a log message from
the kernel such as a WARN() or BUG(). If these include a PID it can help
with debugging to know if it was the parent or child process that triggered
the issue, since the test is just creating a new thread the process name
will be the same either way. Print the PIDs of the parent and child on
startup so users have this information to hand should it be needed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 4bd333768cc4..4c418b2021e0 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -487,6 +487,8 @@ static int do_parent(pid_t child)
 	unsigned int vq, vl;
 	bool vl_supported;
 
+	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
+
 	/* Attach to the child */
 	while (1) {
 		int sig;
-- 
2.30.2

