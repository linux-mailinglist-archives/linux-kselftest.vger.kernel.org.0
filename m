Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103D8656BAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiL0OVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 09:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiL0OVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 09:21:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E980065E8
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 06:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F600B81071
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 14:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4EAC43392;
        Tue, 27 Dec 2022 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150864;
        bh=M4Nq7DCPdliRWWQ+AnxkvH/6TKqPr78E3ulmX7bH0mU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PPlVG4Qx8X4Mc8N8u+Yc8nkP7ty4sYm+Pixmx+SdFdMH/h/PchI7YiU0/OjWEPdKx
         zoJQdRGUWnURFPjLHI68EEWhiMlAX2UwSptYWg2sa0dsozMrXfm0iP91xgUDThAiar
         aNDpKUbOFc/2b3xT52wwgtUR/6b9lVTUn4OFic8TiY39mlm3RIKst7MxGrsCJ+Nd2z
         Rcux7K+bJLNnYPQ9wgZsQ1i+HOOCfVioJGC+q/PzX2x8Zje46fQFA+PA8aC3MVxxTk
         xN2LaUkLZpMIr6OTDhYFYCr46+FJ7WwtwtuPaCmyFHUPQtufgNi49L7T8oK9CmYeHR
         cFZnOfddNpFIw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 14:20:40 +0000
Subject: [PATCH v3 1/4] arm64/sme: Document ABI for TPIDR2 signal information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-tpidr2-sig-v3-1-c77c6c8775f4@kernel.org>
References: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
In-Reply-To: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M4Nq7DCPdliRWWQ+AnxkvH/6TKqPr78E3ulmX7bH0mU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqv9Juq5U/OSo5zIwcjdT4Ali6sNEo5vXiAOJVEaV
 YiS6JgaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6r/SQAKCRAk1otyXVSH0CgRB/
 9CRyXmEjrNh6b8zk25LK3gHZmlDI2leVr8vgOAujsw+oJ3LJ54qrJkgAWUHLdynwQigv3tyYSAZgmj
 BpuLoml7omJDqVwH4hrCafH3fypoPhFQZR/CoIb8aqq0idlcT2gzOeC1P0wUJyWVps5iJriXc0hD3x
 Z27WQ6NKE7Ii2W/s+LswsEEFc9eVM9s00J8F2b7n8NouL+AiMifU4T43abNsQR61oQOqZ+SI0mGSoF
 xQvVziJZyR7vBwSyTRhzyVjNM+9c2xCPXxavf3yF+ntjFMqWF7aKRSfcYsUCfifucY7S+mNV2fIlZK
 DOUsCr/fhyBD63/CMMqgPSK//gTDLO
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

In order to allow access to TPIDR2 from signal handlers we need to add it
to the signal context, document that we are doing so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sme.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
index 16d2db4c2e2e..36b08a105dd1 100644
--- a/Documentation/arm64/sme.rst
+++ b/Documentation/arm64/sme.rst
@@ -111,6 +111,9 @@ be zeroed.
 
 * Signal handlers are invoked with streaming mode and ZA disabled.
 
+* A new signal frame record TPIDR2_MAGIC is added formatted as a struct
+  tpidr2_context to allow access to TPIDR2_EL0 from signal handlers.
+
 * A new signal frame record za_context encodes the ZA register contents on
   signal delivery. [1]
 

-- 
2.30.2
