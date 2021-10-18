Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE3432732
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhJRTMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2395D61074;
        Mon, 18 Oct 2021 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584243;
        bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvUpg4p6pamXBSs6Ds3tSb3NexAcu2Ki6eetnqzQNoEjHcWZy3mGU97bHeCYXjt46
         6B+cqesZRiCYOztGzl4fBu3Po7DWfFPi5VwlXJtiRMn2iUzTGSm6NdNMrS0KF0u96T
         3lEuMyT0486644/srU+L40+yzbV6yMJcCf2M/QWImPpdHdmZ3FRz3cl6TOoRa4897G
         i5qS5uMaInEXWDjENKC7D4NXMoGaPz+5WphxTeZLlSvA3Eue32g+Hk1W30vbEQQ/D4
         Mt86P2AfBHcFAvDUko13HM/GEzpqXXBEWUJ1Mtr54gJd7wMFyGdxYRX743OWV6UFcl
         OivlrFFIynzdQ==
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
Subject: [PATCH v2 14/42] tools/nolibc: Implement gettid()
Date:   Mon, 18 Oct 2021 20:08:30 +0100
Message-Id: <20211018190858.2119209-15-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; h=from:subject; bh=KfpPJVWRO66fQ+lHM4RrxvOpwpsFMCzrx77xLw3EyNE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYyztk/96WoNH8DozWFJeEEmhlhgkZPyKxVcLYr laul/l+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GMgAKCRAk1otyXVSH0NDwB/ 0aX+yGRn/Hg83vdrO/dvrFLDM+D/2pog6f8Ci3ib6sTVMTsihO0++spuuuXexdTRAfPVAF9nWOaogw M2zEWwhD5bOyE3RPS/I2wmAbdS/WIe56fLqR6e2tmcm9mM0cs8N0k6uNu37M3o88Y5UxHDhrs0k/Hd URQ5FqbRGf6FH17/kUv89K9pk9JIDTr3ahEIDvQfvF370jjxfbqB32ndFiFdiUIgGMbGR0mOVbtMFQ a3g7PxGMNyaqPXil0kj6XWtr1XyvEA4X1dFAl1bznSknxgdKcLPG44neKJVPvtj/e4nyg47GGWaIAy M4CTgtYXAIN775TNfPbt1iTNE2BGEt
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

