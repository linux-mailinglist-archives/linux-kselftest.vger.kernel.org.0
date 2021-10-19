Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FFA433D67
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJSR1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhJSR1Z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0CDE610E5;
        Tue, 19 Oct 2021 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664312;
        bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsbwkXO/qmrk/v9JAwsV0pEVJvp9koDVmGENazlIC9T+wGIPnXfTz5kPYwoMs9haF
         iVbLf6zIGxzbgI4C/c9Qkc+FuGWUrWnFD0rn/ZyOP52dnWTJdMk9snFJp+eLjQqkLZ
         MlOqZDlfdh4ynmFNp+4iL2j4I8lv3RpbTdyG+z/ZFzzSJBhrhpLwOXdXmytzuqehZL
         xRx834b+kerlxEQKReYNB/cETWcSFOy+SZ575mbkwQ7biu2c7kLmE6NQIGSQJDkEmZ
         TScMnlg+/Dlf2ilkfk/gxtW77K7/A4SsnJcGHW96PPAfh2MAyPlajX8PeOrcOHOdV+
         M3Yxc+csrb/oQ==
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
Subject: [PATCH v3 35/42] kselftest/arm64: sme: Add streaming SME support to vlset
Date:   Tue, 19 Oct 2021 18:22:40 +0100
Message-Id: <20211019172247.3045838-36-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7fOiCWCuqdEhEwDeB0fuhFIzO/DqyGIULZWFjy SmyMmrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+3wAKCRAk1otyXVSH0AbEB/ 4wiSw4QF0STLnihM/cKX/8WtrMDjW6lQxmoTH8WFcyCZKPLBZU7f8ztUV9O9swZsc2dhC+ag1wmvDK 44AhudbH2nnjIexEI0zX3Bx3bHHFkJ6JWACmRAZnzALJiEAGLFHB++itxKkFmzsCXoMU+yh7m64TpH ZdsoVlMSrDs8oOaSS8f8p4fQdAJMmUUe4LbfN3AynJpLTROdfLRLdhNb1LHVj27laLVij4E1ozT2lx jCQFfJqJ813PRjET6+kMh+/qTDaXSqW4gckM4ZNGlixy1Q+OdWysnL/Kr2KmMjSnrSqCkfR487nJpa 46AcDbo0jJxPEJIay5iG1vvOYMfoWF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Scalable Matrix Extenions (SME) introduces additional register state
with configurable vector lengths, similar to SVE but configured separately.
Extend vlset to support configuring this state with a --sme or -s command
line option.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vlset.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vlset.c b/tools/testing/selftests/arm64/fp/vlset.c
index 308d27a68226..76912a581a95 100644
--- a/tools/testing/selftests/arm64/fp/vlset.c
+++ b/tools/testing/selftests/arm64/fp/vlset.c
@@ -22,12 +22,15 @@ static int inherit = 0;
 static int no_inherit = 0;
 static int force = 0;
 static unsigned long vl;
+static int set_ctl = PR_SVE_SET_VL;
+static int get_ctl = PR_SVE_GET_VL;
 
 static const struct option options[] = {
 	{ "force",	no_argument, NULL, 'f' },
 	{ "inherit",	no_argument, NULL, 'i' },
 	{ "max",	no_argument, NULL, 'M' },
 	{ "no-inherit",	no_argument, &no_inherit, 1 },
+	{ "sme",	no_argument, NULL, 's' },
 	{ "help",	no_argument, NULL, '?' },
 	{}
 };
@@ -50,6 +53,9 @@ static int parse_options(int argc, char **argv)
 		case 'M':	vl = SVE_VL_MAX; break;
 		case 'f':	force = 1; break;
 		case 'i':	inherit = 1; break;
+		case 's':	set_ctl = PR_SME_SET_VL;
+				get_ctl = PR_SME_GET_VL;
+				break;
 		case 0:		break;
 		default:	goto error;
 		}
@@ -125,14 +131,14 @@ int main(int argc, char **argv)
 	if (inherit)
 		flags |= PR_SVE_VL_INHERIT;
 
-	t = prctl(PR_SVE_SET_VL, vl | flags);
+	t = prctl(set_ctl, vl | flags);
 	if (t < 0) {
 		fprintf(stderr, "%s: PR_SVE_SET_VL: %s\n",
 			program_name, strerror(errno));
 		goto error;
 	}
 
-	t = prctl(PR_SVE_GET_VL);
+	t = prctl(get_ctl);
 	if (t == -1) {
 		fprintf(stderr, "%s: PR_SVE_GET_VL: %s\n",
 			program_name, strerror(errno));
-- 
2.30.2

