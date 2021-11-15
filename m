Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11345085E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhKOPdr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234996AbhKOPcR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DABE63227;
        Mon, 15 Nov 2021 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990148;
        bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/D3BDTfNy0t/C7JPbIqrhjLtBsdSXEfvtQOYUjvgvx4gRIbet7vxjLpZn0Rjd8DD
         f8IcxnLhlVGjX0OlVAy9Xb1da1D0orSOGXHaOZpqSBX7BgfVoH/E88wpk4vvkg7n3c
         xP/udJdgDb3NgkAUtD/DWd/lgL8VhM8Nr8N/PANncKKyBrQzV+dgOepaFtf7qRd/p1
         nRBfdAdTCAUeZi4g7BjRkQRG/U0rL+Q+5uEwvtvJ4gZ7EaHanq3GykuZLaygrVpBvI
         yL2adr22b2/Z+Y/voUkmGSc7sgRDfPH9gpktC7MRxPi3se8jyaZhc5jnfTLT6MMr3k
         +HoY7Hc/tLujQ==
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
Subject: [PATCH v6 05/37] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Mon, 15 Nov 2021 15:28:03 +0000
Message-Id: <20211115152835.3212149-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; h=from:subject; bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyIapvXFUQP5iZheLLevpxnzZ7rkksc5CJ4Z9nA vpN3VfWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8iAAKCRAk1otyXVSH0KsJB/ 9aMli/dNINOqiuyFcVQXTH0wLdoFEgxoSDS1WYI6P99kml8c902nUG7F2IpGc8WOd2NQXH3FtK5OGR V5+fiEqZ3blaAs5+dJctWUAgpM+cyGUQwI+CNxxltc4kZvnBywuwmE9c+DJNQWU7et3vD5ssYdpZYH s05qS9fvgqAXgqLT5U5EEGt5qe3fwJOgeg4Vd3l1eh8ZbG0cux4KrHz/82JMbvyDKBfvNCgzR2UPac +/rGdUKildB0KZ705nDicImC+1y+w1FE2UGZ7nJzij0ksZxqhS1uifHiPxJO97uDjdEmxUs+Gu8HmC 6lXQXiTcwNRkzMTdi5WhXwvD0nh7PM
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

