Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0D436A18
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhJUSK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSK1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF8E361AFC;
        Thu, 21 Oct 2021 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839691;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=My04aqlxLq/TMXcFIjaL1SRDMHD6m/v7nDjlOPBRuKNtDXu2jGkhVHhSzJ//1zLIn
         l/8ym3F3P9+b7IlSVoAkZgJEE2eLB6/UWz26Pi+UqoUwYzZsPo/elxXMHfIdxkyIvW
         nxzn+UF7EJ752BDpWsHi9+k5KsE6Q2vRSFncdDzv8wh7uszQ443kBxO1SM3RXp2hDi
         U+bClJuX1ecVhZIr/kHGns9h9gVaft4e0cxNeT4VpcDM79iCAYPVOaxIFjE/ypvyZT
         zchEFjiet4gM98dA+q3uCBf3wGaZeTnhuAQUmiw2GDtLuoCIVQlpjAx7vu+CPFMWhO
         EdhLIYq8UWUyA==
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
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 05/33] tools/nolibc: Implement gettid()
Date:   Thu, 21 Oct 2021 19:06:54 +0100
Message-Id: <20211021180722.3699248-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxCztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsQgAKCRAk1otyXVSH0Jm0B/ 4/HQdP8zzvK11v3PjiHAiRs3OE2nP77wfyiJNChTlrryA66Ac2uyUMpp1/eG443BYH1qoYRgICoU95 YiURHwBPqOMCBuESpdJnFd2jEpdBMmg3QP9RlF3uhyDQsyH8U0Pz+7PWSl83Nfs3TwkN7Eynw4VFdp QliRn1Cbq45h2GaBg9aV9zLxB/Ic8PmumM9AoU3L+v07m0NRxgiLOhm5+uS/4BbxqvuYR4NWKmMYC0 P5tsJwYm7zJlsXOOuwTAoOTFWWJEeezR96MbbnMw/dzV1naZZi2Nak8L9d9NzRzDIJbhYe5QpJqyt+ g51/Xa9ujg7sASrkPm+7JJj8IK7WmN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow test programs to determine their thread ID.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3430667b0d24..fea8aace0119 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1555,6 +1555,12 @@ pid_t sys_getpid(void)
 	return my_syscall0(__NR_getpid);
 }
 
+static __attribute__((unused))
+pid_t sys_gettid(void)
+{
+	return my_syscall0(__NR_gettid);
+}
+
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
@@ -2013,6 +2019,18 @@ pid_t getpid(void)
 	return ret;
 }
 
+static __attribute__((unused))
+pid_t gettid(void)
+{
+	pid_t ret = sys_gettid();
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 static __attribute__((unused))
 int gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-- 
2.30.2

