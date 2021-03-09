Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19F0332EAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Mar 2021 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCITEp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 14:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhCITEU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 14:04:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C7A65230;
        Tue,  9 Mar 2021 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316660;
        bh=zwcEpOUv9pB7JjH2dr+GlEJZkk5sx2ZdexbiAHh9Cc4=;
        h=From:To:Cc:Subject:Date:From;
        b=kIAOZnduLQGhcKFqu17FxCcmZRl/Qv1dmgSpdPhK3bpIjAni6EOZNksqXyQApQhut
         JRrW95BuHAQ2zNLiozzD59VYz9569xVZjEnj9znQ0B/HLuJkl8If1avjaXN471BwsI
         F2UemH00M5xYlSWYmzJeER7dgXEACwvzvoIZwETOC2udXRWlwFa7usOPKcKwyITyN+
         HO2AyAsgK8WnMMIZ40fvtyDjT6+lAds13OEUiQ9GyyzkKzT0zrtbN6VA52/bKUYxmT
         OsN/4HtqeqRDbv7hH7gLpjW3PMzunpSYAkIptMhQi7c3eq2Eu+6MlG5AuIVg4QMyLY
         NaDcSr6o8upug==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: arm64: Fix exit code of sve-ptrace
Date:   Tue,  9 Mar 2021 19:03:04 +0000
Message-Id: <20210309190304.39169-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=JUs2widXm+ZR5pMStCepDaMF5CkeL9TMKM0wN27KbPo=; m=zFuu6WtkdUX74dSNDttZcH84WKTeJilSFVRCK693+RU=; p=htXBdehhfT+FWYr+kSa9oPVMBR7wyPkbo2wdBzSV2cE=; g=087b4c492a3b3ef73e3da2aa3060f92bbe9f590f
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBHxfkACgkQJNaLcl1Uh9AEYgf+Joe YziIPbYZF3LeQ/aDbjP4uoNm4O/VHtSuBs5AMjyTAknSxikm8Ch+u3KNr5jwn4I31k7Mzc32chX+F 9BxiFmWMQNtCk8ioTAr7RmJ99Y6yOgokGZLcADn71ukc/TXHxVYJezOMKWKmjoOIsrkcv9Ivwl1Um BB/VZa64vuI325w5pEkIlOYTAeDSVTN+VNtSGqcvDos2Jfmjk3yAszmzASvzn/+Ghgos3k2uTHk5/ 9HCWE1cz6FCFPfhAF5mOsXsKLFMo77pLKzkhOc7WneGX6o1jApPgmbyZz4VYxVh8Zik3zOXaXuO2w L16Bb3AC5zt4lhRdvjurhT0rfUSBO7w==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We track if sve-ptrace encountered a failure in a variable but don't
actually use that value when we exit the program, do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index b2282be6f938..612d3899614a 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -332,5 +332,5 @@ int main(void)
 
 	ksft_print_cnts();
 
-	return 0;
+	return ret;
 }
-- 
2.20.1

