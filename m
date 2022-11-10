Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F260F624350
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiKJNec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKJNeb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 08:34:31 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B38B850;
        Thu, 10 Nov 2022 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668087266;
        bh=eY7h4fhFTfwfC9Nhrrjq36hOBtSMKTwHQ0XH45yPyYA=;
        h=From:To:Cc:Subject:Date;
        b=jW0xUs58Ma6Hzl6RLY2VbdzV26A1lw7/ViwGucjFGDXxA7py2Wcytu04lzpLdXSY6
         hqd4jp5p9p5XJeTzCF8xAGB17RGUIwlSzlTTUeFmv+6DgflAwvoShTzeH0775O9uuD
         CBGLr2MYmGDJrL6DyY2yRUCxxaiDzhUHvdHDml+I=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 8972E81A; Thu, 10 Nov 2022 21:34:23 +0800
X-QQ-mid: xmsmtpt1668087263te4c0uqb5
Message-ID: <tencent_CF837EA1B8AC81CB7715E85797510D441E07@qq.com>
X-QQ-XMAILINFO: MCKLvPxUEMECfDLJ42pOPtys1rQM8Gm7uOj/ovE65laisNHzQg0mOva9tNmM3V
         lxbEHMODtvFjD+2wfQta0kK+RYHMKDmYM0kwPDGYMhuG2IJEY+Yidi7wGU3bR40D5B9Qx/DBZ1Mk
         K05fuzfEU28zJUDc5gdULKgHlMkZFX4tQvxZglqhgSgMtDcbgkYGeWB9OaZ/NAeFBn7BQlQ+ybRD
         Uw0f3WEiAd03jBWeYU0t1EGpUNPwBnchI9oBQXujRpWJKkSPLPO3lHCA+mqeMXXhxs39fKgGFtMj
         m3uEdIB6gDyy1RNJKArlBau7L/Du73VfwP6hmwh/Ussgr9sLNFQKkLo5iidcI8eFLBLzFeMHzZzq
         Vbr38x8oUQazxYWvICYz9VYmuAYw5IrflhQNrPqMhh2ixW/87qJI8cdkcuvEWPJ8jTB+2u9ozAZk
         FWwPgRAj0KVjqgigCmvqFEKC9fx8Da/fqXqST3k3ehSrkgJkZVb4zdEqtLZwQ5BMYAZYmYd0BWiK
         oEeLCLGAPbKghD94iRxd15WZGr7ylK7HFkAPhij2gdZQqFx+qKvcQm2NhITvsp53S5AzneXze5al
         MUmZJKmmnN6gb9kYDfvN7Q2moGTWh6QLOGnR4RqOpXqal9WPBzITW8gY/DU2flsr91lBcflX6t8d
         uvMWj3qBsyVq3wtdGSS/gzU2430tq6lUTh5UXTPOqcSB7pMPozZllCDA0lk6TKZXq6vbpFx1v3o6
         HzInbE65NyRFfmRGYaB7Xe4auglqj2qk/UGVXCFw62ZQ8eeOAsgx4d5htDWdsYxQrXACgBGRDbsq
         rbw4B0XOK5mNKJOl/7kW3VOtIhVUdPsMP0niDNlJr/BFPETQfngVj8wrShvgpTLaHFEeLWlsa1nI
         lj/MHlvZWVzmy+PN20XQgPuX/+BnoGhr2tktr5PZAgRdeTKcAOsw5mc3UEFbmNW+MRjaWD0Q7FeO
         KmpKJOOxzoH/Krn8lcl9lqYmUDsxVpzNFzMKC8mrysvbu+8c5VJA==
From:   Rong Tao <rtoax@foxmail.com>
To:     sj@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev (open list:DATA ACCESS MONITOR),
        linux-mm@kvack.org (open list:DATA ACCESS MONITOR),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date:   Thu, 10 Nov 2022 21:34:18 +0800
X-OQ-MSGID: <20221110133418.17054-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

When testing overflow and overread, there is no need to keep unnecessary
compilation warnings, we should simply ignore them.

How to reproduce the problem:

$ make -C tools/testing/selftests/
gcc     huge_count_read_write.c  -o /home/sd/Git/linux/tools/testing/selftests/damon/huge_count_read_write
huge_count_read_write.c: In function ‘write_read_with_huge_count’:
huge_count_read_write.c:23:9: warning: ‘write’ reading 4294967295 bytes from a region of size 1 [-Wstringop-overread]
   23 |         write(filedesc, "", 0xfffffffful);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from huge_count_read_write.c:8:
/usr/include/unistd.h:378:16: note: in a call to function ‘write’ declared with attribute ‘access (read_only, 2, 3)’
  378 | extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
      |                ^~~~~
huge_count_read_write.c:25:15: warning: ‘read’ writing 4294967295 bytes into a region of size 25 overflows the destination [-Wstringop-overflow=]
   25 |         ret = read(filedesc, buf, 0xfffffffful);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
huge_count_read_write.c:14:14: note: destination object ‘buf’ of size 25
   14 |         char buf[25];
      |              ^~~
In file included from huge_count_read_write.c:8:
/usr/include/unistd.h:371:16: note: in a call to function ‘read’ declared with attribute ‘access (write_only, 2, 3)’
  371 | extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur
      |                ^~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/damon/huge_count_read_write.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index ad7a6b4cf338..8fbe276870e7 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -8,6 +8,11 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#pragma GCC diagnostic push
+/* Ignore read(2) overflow and write(2) overread compile warnings */
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+
 void write_read_with_huge_count(char *file)
 {
 	int filedesc = open(file, O_RDWR);
@@ -27,6 +32,8 @@ void write_read_with_huge_count(char *file)
 	close(filedesc);
 }
 
+#pragma GCC diagnostic pop
+
 int main(int argc, char *argv[])
 {
 	if (argc != 2) {
-- 
2.31.1

