Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92DA450869
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhKOPdg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236562AbhKOPcS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD9A06322A;
        Mon, 15 Nov 2021 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990154;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzO9kuMR3amsz8zWLqxQR5Rav8yZ18PayZlHbK4A9xzshL3xHIA5FFQ8n26DDOw+q
         1Vz2u8zoliWWi4IVPFnuZ8f2wOJgFJ2+0PYiU/3rMtDvBAjLCw1GO+GyrOx30DSyMz
         IpGf39n5dHH7FGyTKekwswdyne6+7LKi5irlhGFeBhMtVf3BAL503+j+898imFeRLH
         waKNJjrGE7An3DbvTI1iTOW7BUqZptNWnYst9ctipvcXQ4Lz99VNw8GyZBO0AWwM18
         9uL9YOiHM0+aSjjnLlc6g6XZm1/oI4x9gB3BIhzs5BgOOBvpAnEvOKXcIHjNUr6H8S
         Z+WytsWrk6kjQ==
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
Subject: [PATCH v6 07/37] tools/nolibc: Implement gettid()
Date:   Mon, 15 Nov 2021 15:28:05 +0000
Message-Id: <20211115152835.3212149-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyKztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8igAKCRAk1otyXVSH0PizCA CBmHJnBHekMypAYVsg5ysJbuLOw9lwnfo/9tmiZWS99njPAcjgf9OB3iXvQVsA1ueFEwollVzRA9es NTvrHollvuYS4QSvY/I4KoGMC5rcbu0MCr3pgPozEHZxY91D2k2hOMir2iuU0N3TsCTFUWQwZnMy+k lFoHePlFiUHo2D44jQkovinlkYMsYXH4ReX6LySy3HyKdeoor8x2sx+LXl3/1HBwKIrRjJsPDu2PtA lfrRYcYe99iSdhzQY+iTH+Wn6ufcHf1NCDe6aZy8GC7QjiNxXjfi2Y+9jhzmd+mEZo6cyGY9GByKEb WF1emrzPoRbaEUzRM1SqXXP4Tw8K45
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

