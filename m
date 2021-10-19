Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9DB433D50
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhJSR0Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSR0Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA2BD610E5;
        Tue, 19 Oct 2021 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664251;
        bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tvc220cc4K0Jv5P4jFUczqZX4bE8gzEGrlhB7BbKY5QZjFdxP241mNBJ4AAh9WFwU
         o8gSX2ZN/cOywMttuhqyjveSLuATBlcUQStQsjfSTYU1YDzu5P92c0ucpRI+3LOSKA
         NY9yIU4XiVsQRan5PuINfr60dlAmY0KTjU9nPHzPEhkyqnSZJ7+sUVdin56bdZzV+B
         71fTb7DFnzJkJJ69yEqge2rt992MgI4y/aMLiStU18fJnwjCBeYd1l1yyG+8xu1Lq8
         JQaM9Ny1iF7sBSCdX+7CiREY1MH1tnFjzSbeE7RRbmaTaL1lAC+bgb1TQv3eh4sFOI
         6DrYI15NacK6Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 13/42] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Tue, 19 Oct 2021 18:22:18 +0100
Message-Id: <20211019172247.3045838-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; h=from:subject; bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7OapvXFUQP5iZheLLevpxnzZ7rkksc5CJ4Z9nA vpN3VfWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+zgAKCRAk1otyXVSH0BpfB/ wOhRhezrkmQiBNr5tjJ5ZBVgD5FVwgUGRzwmQhS5A3o0qT4x+QJr3EeUFk00XL2keK5KFggT56NwzV q38aA7NbAp9jZ0ENQ+f39S57xAisjyuAP4UgtQu8rjXwvAPdM7nsNNE++SqI++093qRs2pldQOBwJf 9QZuaKPJpmMeWltAQrXrAyaDkCvW3RvciJrZtvIpuxT8ufWbTszPoh+sLKeB30dWu3uvbZQHhDjpRF bUx6NZaFvZmjERZ0Jsm388XKZ911vKGkaRbZ/vWsI3iXL0sbCF4TT/l/V219rXDgkEYOjqYlebqaHA GtEAPbICGcnIyz+4LqCHTc2Hk84Tih
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we have the facility to specify custom code to trigger a signal
but none of the tests use it and for some reason the framework requires us
to also specify a signal to send as a trigger in order to make use of a
custom trigger. This doesn't seem to make much sense, instead allow the
use of a custom trigger function without specifying a signal to inject.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 22722abc9dfa..8bb12be87a51 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -310,7 +310,7 @@ int test_setup(struct tdescr *td)
 
 int test_run(struct tdescr *td)
 {
-	if (td->sig_trig) {
+	if (td->sig_trig || td->trigger) {
 		if (td->trigger)
 			return td->trigger(td);
 		else
-- 
2.30.2

