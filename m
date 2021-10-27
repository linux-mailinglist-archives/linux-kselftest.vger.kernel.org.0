Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EF43D112
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhJ0Sx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJ0SxZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66A51610A6;
        Wed, 27 Oct 2021 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360659;
        bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mv1sUyMOunXrxxfGoXQiJAzyITfitxnmdIGU+sC3yIFAZcKWeR0qWGOLbTpVBywWt
         pummMO+leXRWWI5kUd8fULHzpXUSSDqbqLZcoJgQraq/TJZBGLCxQfFH8yardX0+On
         D72Nbr7sOMWq6O4PiRgunrsLG7VGz89uxs397h4HHJLhBA6l3a9e1M8xuPugiAX++3
         TNRrk8IPghd2ODQpwPvoWEGMDqU+yPdtcNqiXWjC61p+q4wlk+ANb+iIVZf8kxmws3
         8ynoYJYn1gxtk6VzVxaa4zI/Qh6XLAZnsBSd9/GfLhO080eKZIah34UYYJWORIw7Ll
         DqiuyReHGHxrQ==
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
Subject: [PATCH v5 03/38] arm64/sve: Minor clarification of ABI documentation
Date:   Wed, 27 Oct 2021 19:43:49 +0100
Message-Id: <20211027184424.166237-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3pbdYv2hXbEyhOJ3EEommD5opdHGXoM9/MryFW 8NF/teCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd6QAKCRAk1otyXVSH0EDoB/ 9PnGGBEkwb0RF6P/jIsaMjqNjJHHxhdDLsDiOq+aSRXPKKT25QIBNe2exVqihZBIxM6iWWbCypoBh0 BU7sxe4BMCdSgeiZYqXYJsAAtxAWHSTINLCQWjngW5eAwb7XPk+U9fjRssJcbL1yBI1raKLjK/Yuez Eaul1CZ+MH4z5Pk3YtcYdZZ/ZcPH1q3ecumDm3xPOsrxuBIW8Qxi5MYyKfY1pVk5Guo99etz9qzI/g CLvaRcc2W/zTSThIQOIfwUjdjkvPLXxc4l5kAa2k/IglLbv5HJtMusNQ2mipMT51hQnZqWdf4YGyRf jEw5x5w9vXM0P9+a+RrjbeXmIjiBLp
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

