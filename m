Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BB3DA751
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhG2PR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 11:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237703AbhG2PRw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 11:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E86660F23;
        Thu, 29 Jul 2021 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627571869;
        bh=cqrIBm2+sPklmC33fnKs89kCRIiPSCWLJxj9sFAPJDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGA7da3KouR3OLzK70xFfXXCJUOZDcxIRUgun74N/X6VVYZNn4NrSJgyzqBl7Z2xu
         1HouEMUBptGxi1fHZnRbfflYxqhAk03TaQjZG0QDbf9mDbNQIDgImMOK+sHxEQ4rrV
         Icjt4KaPv7Uyjt0qIOPcLf6CHO/V3IjcPrRfWj6KaVpxMdYxl3KfaoSA/jxO3VXf/p
         wNh9PAmPZ9N/NSdVkuPrpiwNXu2MwjCsF11PkYmVFbdmhY9GlxsVCLgT7k1dYldR7y
         MbNpD6VS3+Y88bgoiEIwwDl1CXrkjcAvthC0srZsR/BU3IobrHuS4SgTVYt5lkkl46
         UJ3vkNyO37Biw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/4] kselftest/arm64: Add a TODO list for floating point tests
Date:   Thu, 29 Jul 2021 16:15:18 +0100
Message-Id: <20210729151518.46388-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729151518.46388-1-broonie@kernel.org>
References: <20210729151518.46388-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; h=from:subject; bh=cqrIBm2+sPklmC33fnKs89kCRIiPSCWLJxj9sFAPJDg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAsX+pAt85pVYYwEvPdu3ySEq4insB+GbRbW9Wt46 aWTg8G+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQLF/gAKCRAk1otyXVSH0Fj+B/ 0STLbMhTsh3Q/RRUL10xdmDIWXuFvtezy1485rsM5f/0uaaCO+j2kPQjE7oWuaPzxOqEVxAd2N2kUP cZImdWcLqp9ZLLbT6IjXn1YUX9i08tb4M1zsBoUu+oF9o0K2JaMwkWpQ4ObA9iC+ACn/pnhJxjBDLz +F+3HVJ9KR8AhT0JSblCS7pH0rR/pq5ZxKk68VxddQZ7O8NUnBhwluzWjHv/qXAP0nATlSaiFsvX2x 1FKAOItM2aksMxgcgKz6DsOSZ8YmAft/5zbl/tb6/IjC0JFO38gwdp/+jneJkg/9Ptn8mCPxCjqGGp Nh3Qs+OPCJ9puhf9zqWc+T5DYfkKkN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Write down some ideas for additional coverage for floating point in case
someone feels inspired to look into them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/TODO | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/TODO

diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
new file mode 100644
index 000000000000..eada915227cf
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/TODO
@@ -0,0 +1,3 @@
+- Test unsupported values in the ABIs
+- More coverage for ptrace (eg, vector length conversions).
+- Coverage for signals.
-- 
2.20.1

