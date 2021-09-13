Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D16408CAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhIMNVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhIMNUe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DAA261211;
        Mon, 13 Sep 2021 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539140;
        bh=OgQoI0YmbmfY7WdrTXe60wCgVXiWk5V9jGWdGjPhjqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwtDZ97HcCdaFGQq4xPCkWDOfD51PsCk6fFaSGo0XvkA2uuE+ZBq5hoVbpqzZ7QZF
         b94hNuMKYb+0jLs5vLmXmzOI3+8C/rjLi4Of8gsBmTsWbAhwNq9WIU53y5ebgfGDuT
         GftXXJdDW7T+URKFAPbd6DxjW6mEFFAdK1FnSsEeBhGo9gVdL2K9hYAHNd4Hpaa7oJ
         3uDYQhF2hm6E2JU/lKxDTTcGCCnc46mdRLh97cIDr3OKog9Xbblp/cs8RwYRq0YwBb
         2D4n7DPBuXnLiTFfFVnKUwqjxaA9NGRySIHGalfkDK+F+iW2sohiThtA7ts2itsmID
         EfboXDt3hmtjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/8] selftests: arm64: Clarify output when verifying SVE register set
Date:   Mon, 13 Sep 2021 13:55:02 +0100
Message-Id: <20210913125505.52619-6-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; h=from:subject; bh=OgQoI0YmbmfY7WdrTXe60wCgVXiWk5V9jGWdGjPhjqk=; b=owGbwMvMwMWocq27KDak/QLjabUkhkR7L7W4frVdnlVq4jo6Vb+WvC9vqrB95+t/1eaJr8y9I3Mb 18/qZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmItPH/le2h2f7UlYF1wTW2infJS R/aXDrLDilaPjwz9XFCtW1HQx7Zu/xY1x9sDizsifRfv41NlVuf1fpv3W3BQty2C9fmpT11P5WXsHh Y4ouQomOqjyvn3vz7GWUsut3PHbVt8vCLqh94mS9sISFeSJRxxIF3ZS2Cz+QLzZiuPt0+hr/n9xME/ MsLu1VDvx6/c0NLlnnhruMAurXTvBPuhNo9u/ltx5hz8vREQ/keyczae1tLTzvGltTabhnL3/VdYUH HWu3ntGQacjtL3jH3373Trh376ygSXF1B1iuComsv6TftqArWbewvHzahnltx7YLebJsYfI+7s11Y9 1DbwVNltiN2Wlh/cufT37avVcJAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When verifying setting a Z register via ptrace we check each byte by hand,
iterating over the buffer using a pointer called p and treating each
register value written as a test. This creates output referring to "p[X]"
which is confusing since SVE also has predicate registers Pn. Tweak the
output to avoid confusion here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index fc4a672825eb..2d130fedc019 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -275,7 +275,7 @@ static int do_parent(pid_t child)
 		if (__BYTE_ORDER == __BIG_ENDIAN)
 			expected = sizeof fpsimd->vregs[0] - 1 - expected;
 
-		ksft_test_result(p[i] == expected, "p[%d] == expected\n", i);
+		ksft_test_result(p[i] == expected, "buf[%d] == expected\n", i);
 		if (p[i] != expected)
 			goto error;
 	}
-- 
2.20.1

