Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC4433D51
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJSR03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbhJSR01 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73D29610FC;
        Tue, 19 Oct 2021 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664255;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROzp8HzX7wop+hyph7Rokd7QJXTwlfdnnFh/cpOQ3Lg/tuE1Kit3weu2/rfUYPm0N
         ATSV3jH+UBxo3fBk24XgnCdAPRpAEYClMfS/yBmdZFZjL6wc5jPIoOZ8fnVjlAGaOR
         gnNjRcvjwFYQ5P/zX6QJCrws43PvVWwcHYKdwpu135Gni+chP+xI4s3FqS3vXit6wF
         8X8va1m2d6754PqZehTDQec/6CmtMo1bem0qljBil+vTccTW3xaYJwhOWRyQ+YnnLp
         OimXXxaHxgOPwaXLBqe60INoQMHF29uwBl4bERDXwd0LkueZMmQ7r3A1TGEK7LAkCg
         ns5UaFjomt5Zg==
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
Subject: [PATCH v3 14/42] tools/nolibc: Implement gettid()
Date:   Tue, 19 Oct 2021 18:22:19 +0100
Message-Id: <20211019172247.3045838-15-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7Oztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+zgAKCRAk1otyXVSH0EKFB/ 96uMU5+WZcSmhrZcorl2ncsrAPUn1z3tvA55P6lhy/TUwKOEDkZFP+LatBuPSkuQfZEfgLWOUjaoll wvcuOXRAVfAPzyBl9vwJagMs66SyD6w/dRqf48vs/vQJtSajNVHTHS6Foi73AKFQvRIx/40GyC22MB ahtkaPCj5oe0ZzTGZ+BfV/Whxx1hP6LnFotcUP5XUzgODagpeOYDcfM6weBZ1lB4Nj9WlEx7y7Fx30 BxJgWSv5H+Zx3Th4oohDqC+JAbb0Xy8mnQTZ/qAeeBWlurp22bzZA2npvHQf4eV4QG4YRKz7nXsPHG 0gJSJjYQW3k9nPBZ7ttVVSdseIsP56
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

