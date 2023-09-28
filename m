Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF37B1FD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjI1Oi1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjI1Oi0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 10:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B8136;
        Thu, 28 Sep 2023 07:38:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18154C433C9;
        Thu, 28 Sep 2023 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695911904;
        bh=aPoflz+0XfSplhDFdzkyq96yM+hmFL9PxAktgAzpKrM=;
        h=From:Subject:Date:To:Cc:From;
        b=m7zBIdufiFVl5zubjwGpmDbW86rNAggbRxyuoC/LLwpqLkV8ojvPCJPNIoNB3113V
         KWVkDapZkQuur/R9uWXYmhQ5qIti8OXN7aeoNQVeRAEl2dC9eWE5agCHidNC5oAQw1
         YIr4HG+6gyDf5EBvwx/DFX23yseGaFFLSgQXPD4Of+YTmVoZGT61w02I1clPZFyMnR
         zPWoqDZOhLPcqM3X/uHdGLamim01BFq3sFaKiW7z/nnaqvTiCKrcokqEaLy0amXe/t
         wwFcniYEqrA451XMT9corveqxFzHxM7dKv9KhID9LAiAGcEvyHOR4wEjJAOJkLwXgN
         NoOd6rT2Rey+Q==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/exec: Convert execveat test to KTAP output
Date:   Thu, 28 Sep 2023 16:38:10 +0200
Message-Id: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKPFWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyML3eySxALd1IrUZF0T09REixQjC6B4ohJQfUFRalpmBdis6NjaWgA
 RqwF3WwAAAA==
To:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aPoflz+0XfSplhDFdzkyq96yM+hmFL9PxAktgAzpKrM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFY/dWFG8FGxG/6v4U0PpZeohtnjTM31BrEZdB
 icnAQTOAZKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRWP3QAKCRAk1otyXVSH
 0FyRB/0QZYXfur9oxSKrnSls6vqeoaiQUVX6WpdZ11nd7MA76sipOPl3/VPOBzs2DKNihLWVoXi
 knxP/hr9ScazTYOeUMsLjuZYRwkZuT2khR8HyQ5EA+WdHEP5rzCXsrXk66ex6OzCPo63KPwkWVs
 kGZiEf4y2hYRiLwcOb+U0cjHTCXz7/vavUMG2IMflBhLEoZEoWkNhaR8PnzrApYbtyKw/RWy31I
 u5hqkArOq4AS3qGVmZEvyvisumBlhs6knClvutQjMqP7GiMm4cmsIvjqrpMWaPRTIzznurqU4dP
 AHUuvsiX4v2v4t5YeukdEncGuv2yXghwoTTwIZBtyDRl63ME
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series converts the execveat test to generate KTAP output so it
plays a bit more nicely with automation, KTAP means that kselftest
runners can track the individual tests in the suite rather than just an
overall pass/fail for the suite as a whole.

The first patch adding a perror() equivalent for kselftest was
previously sent as part of a similar conversion for the timers tests:

   https://lore.kernel.org/linux-kselftest/8734yyfx00.ffs@tglx/T

there's probably no harm in applying it twice or possibly these should
both go via the kselftest tree - I'm not sure who usually applies timers
test changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest: Add a ksft_perror() helper
      selftests/exec: Convert execveat test to generate KTAP output

 tools/testing/selftests/exec/execveat.c | 87 ++++++++++++++++++++-------------
 tools/testing/selftests/kselftest.h     | 14 ++++++
 2 files changed, 66 insertions(+), 35 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230928-ktap-exec-45ea8d28309a

Best regards,
-- 
Mark Brown <broonie@kernel.org>

