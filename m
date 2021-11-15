Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30E745085F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhKOPds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236538AbhKOPb6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:31:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C7DF63223;
        Mon, 15 Nov 2021 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990142;
        bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CygbMmPYG+fnQSZM/SAXzpUbRa03D6pAtBpzeb1e2B8rza3pL73BuDCMBZYqBjsQo
         kM1xjrhfPEeTQzfkSjjlYY+A86IQuKczyq3v7lZ+LlXKOXJYk6a+Re09GAAxRmZbA3
         kEBsh24T5WLQqyCZv2n0ezt34UDoY6R1xZbc2bpUe9ARNR1QQ117+xvuQQMYfA7cKM
         V0p+gs65FU2l41U8V4KCltawY5D8poqc69NDasviUYTmKaHGv13T6S4V1FGdNDM//Q
         Z1FFNk8P3toWLLuk+JOFMyYhNGgkAHnDTAUItpHh+0oFRKVtSwpBEdQLNnmvrYZrJX
         PuURVr7+2XiWA==
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
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Luis Machado <Luis.Machado@arm.com>
Subject: [PATCH v6 03/37] arm64/sve: Minor clarification of ABI documentation
Date:   Mon, 15 Nov 2021 15:28:01 +0000
Message-Id: <20211115152835.3212149-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyHbdYv2hXbEyhOJ3EEommD5opdHGXoM9/MryFW 8NF/teCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8hwAKCRAk1otyXVSH0CMSB/ 0TGoutx2W+b7XWSOEXm9eq/f+UKd9F4WyUTf3r1vm7U5abFjdYVygVTKfI+mUatLQizVJsAeFlY0jW cY3md1SQyAn5dF4R6aPE3jcIyxdDanTdIjrPCt4K9MtR2/bnIW+cz2neWQjzS3PNHk/4TDfSvXVpuI pIfcEdtAmo0vpXjb1pzV7PjT49+BqR8eEeMfc00RwszrRqfgI6f1qXaRfcJLZb0Wp9EUZnibtaeKkN sH6/b4dB3jjzr2O3zBj13ekHVZGVu2rxbJh1OkhrrNknB6wZuZMHNEFEs4TCukakYz7ONWGEnLx9al I0CIsRSa1V+W7JHVJLJRO4634GGFX1
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As suggested by Luis for the SME version of this explicitly say that the
vector length should be extracted from the return value of a set vector
length prctl() with a bitwise and rather than just any old and.

Suggested-by: Luis Machado <Luis.Machado@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sve.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index 03137154299e..9d9a4de5bc34 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -255,7 +255,7 @@ prctl(PR_SVE_GET_VL)
     vector length change (which would only normally be the case between a
     fork() or vfork() and the corresponding execve() in typical use).
 
-    To extract the vector length from the result, and it with
+    To extract the vector length from the result, bitwise and it with
     PR_SVE_VL_LEN_MASK.
 
     Return value: a nonnegative value on success, or a negative value on error:
-- 
2.30.2

