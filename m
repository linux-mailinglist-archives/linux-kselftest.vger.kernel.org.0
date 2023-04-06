Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90AC6D9D63
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjDFQTs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbjDFQTr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A526B2;
        Thu,  6 Apr 2023 09:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672CB63E6A;
        Thu,  6 Apr 2023 16:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B02FC433A1;
        Thu,  6 Apr 2023 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680797985;
        bh=hamVzMz9fjIydQKzWnoxc8ljm2X/SGTmnnWMknPU8qo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=L/eHlr/0i1MzCIAN1gHxc/YruWy3HG/FCt5fT8+ediYZVUMjiy/ecDx3D3dAkjtnJ
         hOkNU1KOAW24YeiYfm+qrEdwMkuNxVoKL0ZSBn8VHjb4vE7o8WNLJIGJ4gSYVGhvLa
         6ip7Rt8HWIkeMcOT2aVm0/5ZhxNqqW+gJo9o/lwIKwahWAD00jPZPfBCnZyFukutdt
         fyRDHY+JIrRwXEXH5P6R1sb4D4NFNQ+/L8DtVX/ui9faJmwETABC3pEBVL9KJoNXdM
         krGbIoMTE0yXG5fCZn97ywZ76FkoHdCMqzo1Q2DfmC0LdcGwR9eX4IvcwvfJDxD4K2
         IjKqX6Hiee6Rw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 06 Apr 2023 17:19:10 +0100
Subject: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
In-Reply-To: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hamVzMz9fjIydQKzWnoxc8ljm2X/SGTmnnWMknPU8qo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLvEb/1QElH3jcf6mGR0Yr87YFxIWpB05FFQCPzUj
 d6UsAiOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7xGwAKCRAk1otyXVSH0E9VB/
 42fwyW20SjTj5Mg8Kks8LM/BQ3Rju1MQCEqx/puiJcz9ORzkHriIPJwp9O38Cij4AjZrb1JKVrSFi+
 q8sePpQWXhEVu0NSjFJEg4ASrufsht6yNYSKLzeYS9GfOrHdWAa/46bRqWcp6Cay6qHtahrgfHXcV5
 Lm0yyFGNzR8BikcOeAfljY3fydwpW08lyuHf1ig1EvBiDBsnoq+GxFm3URSgxvpKJ5laouaoV/c1zb
 RqnxACr9T90ChkaB/Y5L11TBfBMGDemXGsDvqwSrn3exOuFkP7+n0o9Puiraf+zbBwWc+tcybdgnwV
 3QBfbxocQdxADvPwS9xH9Ace4PvXfZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vprintf() is equivalent to vfprintf() to stdout so implement it as a simple
wrapper for the existing vfprintf(), allowing us to build kselftest.h.

Suggested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/stdio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 96ac8afc5aee..6cbbb52836a0 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -273,6 +273,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 	return written;
 }
 
+static __attribute__((unused))
+int vprintf(const char *fmt, va_list args)
+{
+	return vfprintf(stdout, fmt, args);
+}
+
 static __attribute__((unused, format(printf, 2, 3)))
 int fprintf(FILE *stream, const char *fmt, ...)
 {

-- 
2.30.2

