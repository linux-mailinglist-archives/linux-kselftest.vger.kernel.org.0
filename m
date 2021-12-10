Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65239470915
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhLJSri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47438 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 580FDCE2C89
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6064C00446;
        Fri, 10 Dec 2021 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161839;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1mes+zYzFZiZJhAtn8qDaksiNRi/yNyfHHTKMc+CUjk0H3EOnc7d7/BoRUsvPnH7
         3dwFT0ETXmCP10ie2iNfwb3yQkxePmGxmes+agNfgYAoikDwFoEGhUqGthRDUB6Zks
         y4qz2Fy0idLTWfZCEzIei+cawv6szJEym1h+Z7WkZ0GVRZDuo4eB4gebl7U+6qLhse
         tMjPI6IDLZFPuvcrWXNPXlmNvghlAnzYovqxfrN8pW5OLqw6h5KP3O+LEdvk8uVr4x
         QbPL7KvtpUtqcuYA3F12aDq6ae24AQEF57/JpcLA413CxmnN8a0OeRXTbkPwKdDhuN
         qHY5olvbERp2w==
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
Subject: [PATCH v7 08/37] tools/nolibc: Implement gettid()
Date:   Fri, 10 Dec 2021 18:41:04 +0000
Message-Id: <20211210184133.320748-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59Eztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfRAAKCRAk1otyXVSH0KSKB/ 43sgipVO8/VsZahGfgj6EejvTLju6RPr2nrGBenujqT0cfDNTyOCl+mi41Oz5KM7vNeYuJhbEdjZJ1 8U06ISC0DlNki1dAFixTRgB54AyXrvGojgugqkpMAqnMBHc5YQvNWbgDLADxgY0DVh7BlnWCzd0lAz Wxhf4hsEJLrpuv0+oKs8jvAno68u+r6bx2/+7Cv95jp8skq2z3rq4Q4ixkLHFjJ89J8Ow6J9WHQvlB Twukrf5hyKcDqd5jvfrR3oYpnenlMdk1aT9/xwrCBJdWLGK27kUqV0tDSCNFJUZkfzRNoZNMHL/0VM 78Fzmnd6OH3duZP7FILYfwsoU4043x
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

