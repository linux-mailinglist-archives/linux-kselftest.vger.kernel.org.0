Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00F436A17
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJUSKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSKY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B08761B03;
        Thu, 21 Oct 2021 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839688;
        bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbSSbKLBdA+0M3rg0pIEH8HqL4TuLyGkqXWddTbrIDlJT7fopscYZB11OM9EdTaMJ
         Zzgv+hJNR08Qz9iwUre5D+h/Lw/aKpu0GKz//iLRWDSooAvLPm4/5cvdY5MSs0Ldi5
         i4fjwrMObGyJASAwp3zWlYKox0dBZ7Jvlse/mVxkTxYE/6yuwlzOSBHlO1oUMoU76c
         cXrXaXlSPR45hczq2avE6Z6EQX2iIebupSW/3aRPl2MJfKksB/yAq+AiBU98IgD50w
         K82EJqKl/yLVfe1y4siEr/biNNv+/Yx5qzgUkqLuoeckh8XzT1vh8IodmdhLtHkT6C
         XwZb5q+xb/cWg==
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
Subject: [PATCH v4 04/33] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Thu, 21 Oct 2021 19:06:53 +0100
Message-Id: <20211021180722.3699248-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; h=from:subject; bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxBapvXFUQP5iZheLLevpxnzZ7rkksc5CJ4Z9nA vpN3VfWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsQQAKCRAk1otyXVSH0G4lCA CBXM4XDYidS5y5Ft6EmcVhWIWNSRjlRYD9neRBVeW4I2D1owvciqny9DatNObPu3gkq8xrK2rDo2Xr JlJxK+gc2o0PBku9wO2gr/MeLqE5zjwVts6XW/J3zKqIrINRuU29dP4CxQ89mud1EVt4l7P9H+7cKB 791qym47k4zLOcEhwdrLOddmUpQvHjnVf1pdDCoF1WHIDb5GmsaVxatTET5vUkhlOPjc1YUY+E4Py0 NslvvHpRCQTQ7aDmd24m9RJ9o2ug0J3MQZe4sBdJkPiWYoDkOeWXoCLnOsIVPMg1gmCi+a1ezrEuAN CoXnhyJBgDYmt0zp4PGDHNZ3Pl5BJK
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

