Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498E6839BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjAaW46 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjAaW45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:56:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF0B3C30
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E2AB81D7C
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 22:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC34EC433A0;
        Tue, 31 Jan 2023 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675205814;
        bh=OtSjI6ErC2KrOpOPD79SOpL8y4H/aKc0tdYvKxcYNe0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LgKikaC/U0JusrKWAZEhz8Qxwen9RlEN5dOXrjLIhAZN3sDFE5ROtPVAFt1oURFUV
         H/qcm7A71pc2fp1gSK9zLiagz47llXuHU1bftqVfIjR7J6nXOTCC81jHWE8FhB6KkN
         Rz1IcLgzlwq1VyqW8XfvB+LEQPHYQnS/eq36LDh1Y3HeD++0WyjV27m41WiO3fNE/b
         TN+7KV40STpDoNUSdoOyTFenk/LDRPwqgGOLdP5hxoqpS090w0FyctEu6L3pD5l60w
         bFGmOfPA/bylAe83wFkprz55LiFo/13Hg/9IZgIgHmZFKwsXZu3qswGojaEeYiVqwG
         O5Dlj+gw+zrLw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:56:35 +0000
Subject: [PATCH 2/2] kselftest/arm64: Fix enumeration of systems without
 128 bit SME for SSVE+ZA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-arm64-kselftest-sig-sme-no-128-v1-2-d47c13dc8e1e@kernel.org>
References: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
In-Reply-To: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OtSjI6ErC2KrOpOPD79SOpL8y4H/aKc0tdYvKxcYNe0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2Zywr31KZLAYLwJ5v6DynGCGVMQoGzElJh0HBMei
 3kHgE0yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mcsAAKCRAk1otyXVSH0OgRB/
 4wtAYPV4wlkbmsVU5P7Hta+FKaTfj/MgzI6/3uUNLvJGk6O5gZn2Yd39pV6pJulll5EkqUQDgQI/bw
 xNQ+eBAXy/8UdueD7o4OcJkcWSw0lPTTT0w/XeRAyuotcJiH4CFuL33VFP+mXQwS/YAQzziLT3tnMt
 RslNf/3oOPftLUv0YS9x1WRqeGiaEf0wv8Yfxw0K1Goclhbxb2N3EAyEk1gMZOxGUxaa+nU7KdzqN8
 uyBB3J9RSqT5a/WF7jef6C2Qbmfdq0AtvBnWEux2SZ2FQavLA3qUkIJPQA+DFR/iNLfnJ7ASPnKLQd
 jz4MwsFkuGTcs2agK80cizz7SkTKTu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current signal handling tests for SME do not account for the fact that
unlike SVE all SME vector lengths are optional so we can't guarantee that
we will encounter the minimum possible VL, they will hang enumerating VLs
on such systems. Abort enumeration when we find the lowest VL in the newly
added ssve_za_regs test.

Fixes: bc69da5ff087 ("kselftest/arm64: Verify simultaneous SSVE and ZA context generation")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
index 954a21f6121a..1f62621794d5 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -34,6 +34,10 @@ static bool sme_get_vls(struct tdescr *td)
 
 		vl &= PR_SME_VL_LEN_MASK;
 
+		/* Did we find the lowest supported VL? */
+		if (vq < sve_vq_from_vl(vl))
+			break;
+
 		/* Skip missing VLs */
 		vq = sve_vq_from_vl(vl);
 

-- 
2.30.2

