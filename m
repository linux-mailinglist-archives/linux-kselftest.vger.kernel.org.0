Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0824043D117
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbhJ0Sxj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJ0Sxi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0481610A0;
        Wed, 27 Oct 2021 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360673;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l70WMe/3rpX7g59kwI0bdDH57oLgWriaheqPCdSbes9le9xlPYdMaRjidWJgOLPz2
         rzDqPt0UScZRK2yML3TsCpYrs8iJxI6j6nJ5r1uJ1IxYDzR80mlHcuNpcwUmPNj46A
         kis2gCFklav4FqGeynK7ICJa1myz4SCHBiW5hSiEb9Q1QZb/qzo4bcA4FpI/8uxkvK
         AkMPZ23p3hNkPXXCJftt1HsDXT+r5HQQVLuzovd5Q7xireQK1pIuWJQcDAO9P1uYCG
         EbH3UePeECQ9E6MwBHxWPzuSXt8j0j3j/UO2O7aMa5pIfAyNuPJ0ZavS5bX3JghFIe
         kgKTk3NNV4Bmw==
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
Subject: [PATCH v5 07/38] tools/nolibc: Implement gettid()
Date:   Wed, 27 Oct 2021 19:43:53 +0100
Message-Id: <20211027184424.166237-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3sztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd7AAKCRAk1otyXVSH0OzcCA CA08sXqpi/bLJAQaBQrRGZZDc5KhyJQFkKAgyvNV+I+jl68999ZVH5m1ML31sAbI/odkHtBEYM/GFj 7S9QacGKzmrjZ9MUEh7b2BXGrRMO5A2+nKnKDxZPV7OyWK6eKLQxL3LwutjX7VQLv5e+RgUMgGb+zb z6/BAWcDfULYMBYfsdDH4jFqNbm/yb01s7rF5NsQzclAU018gr29iudFoosPZG8U+gF/tZu/ZIUc0T WLyyor5wmXZoN1lV8bGRrZwFzJsxKxW9Dr04t6YRheA4CJvbebcxDs57fw3WWN4YwadSY0mJ15+M2b zRTksBTHSVxpFEH6svTUeE6dVuy0GR
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

