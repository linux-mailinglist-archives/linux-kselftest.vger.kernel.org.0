Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25E436A2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJUSLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJUSLg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFC6F61B00;
        Thu, 21 Oct 2021 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839760;
        bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsMaJ6onRAmNZx38Z6vq4oh0OCbaxAI8FvT/POH5+GdEn+ok3nGZ3h7m3x1ZBXK7k
         S1YndC+E1bHiioy/Bpif2De2ki2qtv5X1yzwebD15e6DpRZ1naj5zx4urF4y/EiTx4
         aSk0Syy03aqE9O4KLSw4X1jF55ALLaGfu3uFJl8777rKy0qMsQPti2j9bmmf6U8E03
         nE04NkKaCnlucs9j1mkNDCZwmBAvt6geCIknHeNunrVM5+TS3HF1xV08gGttFxwikQ
         DwKOWlsWZKXo7f0FVPgi5ukp9HhAuOgOr3JK9Zm2PNA4uoriQzNNehKKl5MCPAdqCi
         Hh0LpKkgNVEYQ==
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
Subject: [PATCH v4 26/33] kselftest/arm64: sme: Add streaming SME support to vlset
Date:   Thu, 21 Oct 2021 19:07:15 +0100
Message-Id: <20211021180722.3699248-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=P2l5Y5PDPDJcPc6k74icHUD6sRurj6ctKkCgiE7n3uE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxTOiCWCuqdEhEwDeB0fuhFIzO/DqyGIULZWFjy SmyMmrCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsUwAKCRAk1otyXVSH0Lo7B/ 9e7HnTH77zr2y3qLAuWw63yuuPwi1zqjNztxAWNaIpCuUhZScTh62b2raIYlYvU8mIZ9rW3v4R8Avy 4Gapt6Eiq+zSLXXwUo3Gg0UOfEG8TV87n37tqVB1j3Rz8DmMirJHt9l21AisqNl368OqPI9H4fvJIC POyy0UCtgjcHdOco+7MFaRDxNOSBjcGj+kEfgHR7BD9DxJLzS0tyGty5y1KVxa4fLeSEWd22bLckh+ dXtQY1j9YY5wQgyUDjsVbxTQ9kX1ZoWShpoX8tdw0GA9BXVAIHJ619f8Tuq1OrP8hAjPsLKi2Ofgrr Dt2OagKTPuGWqBNAkSRYi6mEG0EC8x
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

