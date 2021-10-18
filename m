Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9562432731
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhJRTMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF7C6128B;
        Mon, 18 Oct 2021 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584240;
        bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qs9FHMtTb9TLbsrjsPr+lVj5EC9GukoEH9HnlP2dRdZZfdNwtH4Rrg7OfjEZgtQnh
         bZRYB1XwRnZKcyz1ZrqO3iROzuDKLPzGfk9b4XIZnEFLEFcVeVB3eagflc+G+aheZH
         yFl4oKP7QUCIAKoxNNKCt5hq0jTQ6lkRoft9kjbZRq7hP4ldFb+3w5VysvEBNxcHY7
         qwI+9AZ33nR0Dquiem/wO162ZJY37ZXYNn/04A2mVf0XF25fLaZ/zt8y9HkF2v9bxP
         qeUW7pW5cQ3om1P1SBOugtvt2uzV8CUgVN2QFJTYtritwR6OU+6GgQIRb5Yn8NbVZX
         XEY9dcv19xdVw==
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
Subject: [PATCH v2 13/42] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Mon, 18 Oct 2021 20:08:29 +0100
Message-Id: <20211018190858.2119209-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; h=from:subject; bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=; b=owGbwMvMwMWocq27KDak/QLjabUkhsTcY4ZZs6+LuvA/U0us2HRv35z0s/NeT/KWeaJUkX7zwL7J 5aFfOxmNWRgYuRhkxRRZ1j7LWJUeLrF1/qP5r2AGsTKBTGHg4hSAiejfZ/+nLFtj0lAWv1t974dP9s fTT5UtcTZI53k3zZQr28KGyUp97yTvU4o6rcwPtlxs+BVctD8gQsorbNKig882aezSjG/fsCz50J2U BvXTKxws/59wSGnNMjnCEmUt43shgWdtzCND709flyTyKeq4yifuN2ZZ01n03WGqUh/LPO6FbOxVps a55kolaTnsylKXa2N7N6/Y8f6bu9uHlIZHlVeNJ7Qff3C28H4Vq2r2h9S7rhLCezicA6bbCybUsT26 UT/tRIhw+68FH/NupzQWhQYqXe9pO6oVv1Nr7ctk42v/xZu2b/944FBuRczuoq0Kk9/+aBO9mh/+sX +HSnAQr4tX3qYHsoJp6i1aZpuyAQ==
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

