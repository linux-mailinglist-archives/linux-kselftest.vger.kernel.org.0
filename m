Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC9387DAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbhERQfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 12:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235080AbhERQfm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 12:35:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00085611AD;
        Tue, 18 May 2021 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355664;
        bh=cU6cQJL1zR+w17ObBrDMmXnYH7gaEHq7bCEjJa79yiM=;
        h=From:To:Cc:Subject:Date:From;
        b=rHF5FMm5RYHaGNcHahZPy2PDKlxDYc4eKDHbd3sPkvBQfmWOpKAf4wC8pGRl6GaIj
         7aZ0aPjyeIDGKh4BsPW7RU5qaZkoBziT5+/cNXjLormdvvIXk2+kZnoGYmj3haWaGU
         +eeAP3FG6SXR5/U9BPMLuSb56FcPOpxKY00BowcEcihdN8J+uG7486hxNRcal8UxlD
         mmmDNDS6JE7ONc7pN7qTpF9acCEC8fcMkODCShl7HPFVyTKVPYUk1y/xa7y6W8mz4B
         KVXmf356GeT7Iv/vGy1qavTkDiv9vOnuz/3PI1JWkcdUQ+W8noRnP/yTVyhCvpfqMl
         SP3PKQH8+wgHA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Add missing newline to SVE test skipping output
Date:   Tue, 18 May 2021 17:33:31 +0100
Message-Id: <20210518163331.38268-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; h=from:subject; bh=cU6cQJL1zR+w17ObBrDMmXnYH7gaEHq7bCEjJa79yiM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgo+n5bB/Cq/vRNuEHUes26P0Vxjc4ABpwBenOguU7 rZcqWI2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYKPp+QAKCRAk1otyXVSH0DamB/ 9gzNhAgHhsgm9AkAuXLflRPvK18JympKiXZsMChlc2bc4aLYIEP0xwe+LO/9lLHL1cYKtDi7GqAqtj zanL3WAt/tEebhsrPzDtpYRMZETZ0X1CsupHMkvek+FUWOBB4Dq6y3UOwo5yCEfEhMILWu4wa/HidD g10YDuZJyjpVlWZ9GRVlcDFWFhYuvvB5GDbJDT47eMGqJC+syuhh3ZjQnlHnHSjHuOCRhXe2LAU1dS 3TJRzrJz9s5xhk3FijMvALVq5r9zBPDsLLkM2GGEJqorokzO5Y5vHUJIqUI217jTj8CUgx6UAp9RiT KDGp5xio+AqByK/yHOYhWFumuDzNmW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The newline is expected to come from the caller but got missed for this
test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-probe-vls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
index b29cbc642c57..76e138525d55 100644
--- a/tools/testing/selftests/arm64/fp/sve-probe-vls.c
+++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
 	ksft_set_plan(2);
 
 	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
-		ksft_exit_skip("SVE not available");
+		ksft_exit_skip("SVE not available\n");
 
 	/*
 	 * Enumerate up to SVE_VQ_MAX vector lengths
-- 
2.20.1

