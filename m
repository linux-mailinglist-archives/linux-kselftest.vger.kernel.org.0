Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDAC43D114
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhJ0Sxc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJ0Sxb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D69610C7;
        Wed, 27 Oct 2021 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360666;
        bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Idv2e5oHputVHYfcCMdDG8U7awOeZxh+PPmtTds+YEDFzZ8slouKNEAuwJEXFuqp/
         qQ4kRpt+9L0lovEdXxzDKdlDxIXibP+26/jNUYTGWQN4NpDL4rsX4oFwnF5EZ1ieTN
         1J5UIWl5w2481QcWIJ4XUZ9XMgu2LRUvHk2EHs4uc9b54LZIxop42zTl6BBvlRhIpt
         PC+fokZ8Pb/eUd1gwZXKieLZ+pS4OlF6jqtn3qt8KOisg2oRIyhLw6s9VdH/Wv7ygI
         tlKZxf8gJGEMPt2yRbl+h1T7ihyWXGbxraNl/JE4Aoh0D3lRYfDKJ91kG1s5qDhXl4
         vpWBf+4TYI2bA==
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
Subject: [PATCH v5 05/38] kselftest/arm64: Allow signal tests to trigger from a function
Date:   Wed, 27 Oct 2021 19:43:51 +0100
Message-Id: <20211027184424.166237-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; h=from:subject; bh=tSRR1Hx2vQ1L9CglGj8K2kL3Yw2aytBFNKVt5S2lyps=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3qapvXFUQP5iZheLLevpxnzZ7rkksc5CJ4Z9nA vpN3VfWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd6gAKCRAk1otyXVSH0AkhB/ 4812jQl83RVYdvEGPqNZT3vTvpbuJ2rE7XiLBo8kk6N9n3NM/kpQsTXBJIzy4IVW90doZRESe5HVWf qCFNiXf7iKwTg8pfJqHsjualjKBEr/A4w1z4NyUHZ2vI+w97DzFx7avMwcxKsZbM74RZC90dnMS13A cFRX6NOCjyERZFl7FDQMuVli3fA2wBVWZNGWyxujtKIanC1fFdQs7O9RH+E/W4Dqt8z/WtlzTq7Av1 5Dg6+RYmexpIk1/u6b/d4kcWOx8h5ngI7l/SKNUPMddZIQG4junMSJeCmYoYkuqbj5xVDkp6JZwVvc bl6Pg46l8WcnQSRR8dwj8xVs7IUzmW
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

