Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7688D470910
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhLJSrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85883C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0A22CE2C89
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBDFC341C5;
        Fri, 10 Dec 2021 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161824;
        bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unqHgp9pT3/BnxfOK9/MrQBDy0ekpDwgQw3vOaBmKXtaBh3Kh7arPVDqPf2J/Zols
         bpXKRZxyT3FtUYi3WMnyvgkVtCPsBxycU3Va5sYcDGQJJUn5BBtPNiH+QHDjjKPCOe
         Uq29zAAy5fMVtIJYjR/XCdfXV3oijvGkvfPH5AMoEZ1i4t+Mbv8KJ/ieblagQQ+vtH
         4ZewsIbReAua/+Io7giBw6mdR0JPAFHKriGc2NxP1tSslgy726W+KDl/HLKY1Z0rSo
         S90gpp08jSMKq6q8THsQdmz9kyGaBSwKE95MkKqhYM1ozumQB5E7D+69j87X5y44UB
         zqSZJ1BsQUihg==
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
Subject: [PATCH v7 03/37] arm64/sve: Minor clarification of ABI documentation
Date:   Fri, 10 Dec 2021 18:40:59 +0000
Message-Id: <20211210184133.320748-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=n/w7AweH9L8FxO6JYJptKDInrWPMknCr7JxAnBAUncs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59AbdYv2hXbEyhOJ3EEommD5opdHGXoM9/MryFW 8NF/teCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfQAAKCRAk1otyXVSH0JCDB/ 4tpwABWmZ+7O4HZ17p61JjA8D3sab7J/SBktpYcv1fBxhhY6GAcPPylJrXQt2QvtaMWJnWavbtgP9N M+wRT9+GDTzrgAtThSkj5e/QtCPn5Y880HkILtq6CS2PWFm8zoW/dOzp93oFpAsa88/R2wOT9AGJiu atiywgqaI11XC+umRqonXnaMAWuE3RvlDW2KfBlF7hvE9BYjibTb6fPQtPuTX4dMv4NGYTDe1HKoHn KMebWjkMLQcJVCUtNqYWNGI6r0wNzmKXvd77O2xttl9lPqr0pIfSwmLAvci3cXCxxLtCZu2clXaihn Sr0Y/6B517gNBAQ39rSRD9gelkULiX
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

