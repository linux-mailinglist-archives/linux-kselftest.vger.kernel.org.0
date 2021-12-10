Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3684470912
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhLJSr2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47392 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E52CECE2C8F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFFEC341CA;
        Fri, 10 Dec 2021 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161830;
        bh=D17yk1zR4u/tbpzHelBxjt4e/OyzQT5NdhW1NM50LaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akCnF22TwRsPxhj9wfX5uy7gkhfqOLChoIJp5Cfsv0n80OQTqg586RqGi+n6LPsTB
         /BFum03A2fcm7P4OR2h8+HybDfJJTNcvJL31/wWNgQzqZI82kDXAKeYmbewhYsekNo
         SIeCIFTIxLVohMd9/EeKoXVhX2g5YYaaRXW62sKYaFXaWnOmpgyXB+7A4u9iC9UmQj
         ttdLCDHQBdpb5/5ZckPvISiBLNQ8W+iXFEvSxjGOB/3CMtaQg9Cuw/s6sdYpGhl3Ao
         F+p8OZ/NdJIt5rkxoT+ZGC5jGELDJKnpeTN2R9jm5DovD6ovNtWqi5EMF6l3YV1nF9
         5XsXlUDrI6LvQ==
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
Subject: [PATCH v7 05/37] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Fri, 10 Dec 2021 18:41:01 +0000
Message-Id: <20211210184133.320748-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; h=from:subject; bh=D17yk1zR4u/tbpzHelBxjt4e/OyzQT5NdhW1NM50LaQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59CqY0m9l2zq0hzFylTH3lBLgE1L+2rCj6FQucR vXBuE/eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfQgAKCRAk1otyXVSH0JYHB/ 9MdZ9RWh9W56xuNbGFxpEJOSNKXilH4l6eZ36n+PUwXBlyLW+gRvRXraZbNUEIsXjFiojYT12k6oVy MB9ahQNL43MYk238b50o3aCxbWoqzkclj0jl5ugM8sBBEs/Ck+DcW65qdjHzyjo0AdVucYCJUdcUgo eLXQ6RtmxM4LYyEyLTxEUuJKgPghzWiz7CA9e3iCfeZLKVr+cc8Ok6nYRAdGHrZs+p7yYWq7KdqEoX jey4KREhjZuXDgeXCQeEesAfK+1//p8p+o7CYL3Ut6gllyg4YnN7ApR/1jiExMn5/NPIdx1J2A26cN AmONfKPH1F2BQlzyl+YGHKolUp4z22
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
 .../selftests/arm64/signal/test_signals_utils.c      | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 22722abc9dfa..2f8c23af3b5e 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -310,14 +310,12 @@ int test_setup(struct tdescr *td)
 
 int test_run(struct tdescr *td)
 {
-	if (td->sig_trig) {
-		if (td->trigger)
-			return td->trigger(td);
-		else
-			return default_trigger(td);
-	} else {
+	if (td->trigger)
+		return td->trigger(td);
+	else if (td->sig_trig)
+		return default_trigger(td);
+	else
 		return td->run(td, NULL, NULL);
-	}
 }
 
 void test_result(struct tdescr *td)
-- 
2.30.2

