Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299B626D05
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Nov 2022 01:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKMAiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Nov 2022 19:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMAiy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Nov 2022 19:38:54 -0500
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E246143;
        Sat, 12 Nov 2022 16:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668299930;
        bh=2cRdI/S/pyLy+8nretmHqms1HRWKzI/Jnv2HJzT7vdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LLXxo9Np4ajwhcjzpV6dffIOOKiIiUEkW1PPrC6/yK4O4mhZK8M5Zy/Uw9y3avYcl
         k/bbGWm+WwWJ3femlAwzqFJk6iSIfGYrQC3/6eifO7K2ImV2WHNg4BH46G+R3HswQ4
         3J/MDs0Ufmw0wmfq9txGdor3xU0czjVYzB/AoMnY=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id 9AF8F8B9; Sun, 13 Nov 2022 08:38:47 +0800
X-QQ-mid: xmsmtpt1668299927tfp8q3hqv
Message-ID: <tencent_51C4ACA8CB3895C2D7F35178440283602107@qq.com>
X-QQ-XMAILINFO: NZzGjqyvvdMfgsydAIcT9xoW54Ws8FXNoBHd1bfWi2DLG/M637nms1IARbv4YI
         B1/ovn5BvkebVUjYB5DAHVRo0RnG/lz7oUrjtyASvwDC9Y8vHeQ3Mk+q6wlnDnix7VXaGO/OX+K9
         CQNPuqvBtXCJ2Z5XClJNL0GOGSv6dBX/JoWeDeprg2+anp3pVKmBABw4bziSLiZSHzClLL5ZI68Q
         eCW0a0qRb0XJK6jfTTov9A/kv2RdeFOA1gbA+JKwXU7PqaVE/v6CLHVLod11qbTCGwbZZw2uenkB
         eLMhyXtiYvEurhulKr7+2pljEiriqUiAu9wWfLWfNOwMaKu1fR/PMikd0m5UuVMAqkE8fx0qBsre
         f9I8Y+2PKHVfHRMkDE7THf8GdIe8Xl8bce21DjH3X9RnF7vbfbPkg+2JhMnxcwfroI+C6c3UeZjU
         6nWoHXfkJo8LDIc3x61hFOZhjztXxppIgivcUsg+YMKxNZ/xiM09R9dVvXtEzu7crfhCLpoF4QGp
         0fVVIJvGnbQesI7IvoR60iTYwSMelarb1v8DxTRNczblCcHuty/cAVymuUSxe6+tay3b5qkYfK/M
         gGd/ErfCWXWPCtEqDKXEv22G7xVhL72ZPrDLrPrMLjpLXZX/OjNlbDng4GeYta09VOSMRBUIX1s6
         foCzwA0RURtNDOP+cZwbksYKxTPU3BYoTWkdwlfALwvXktppHHaYUjRgDqfIw3FwV2y0hJtEZjCz
         IpNyJAftvPUugM9t5/kzjqWwlEvZIw5u1wgNR9RZ6c60oL24ds4/T7haKaJ2Hbrl/gtdWFAPFic/
         ej7xYldv4ShJ/+3jAwknSLAqhFEFnlhx+I48L0sNyIv3C8Asbf4tCJisb/h+ViAS8Qw47gy8ucmD
         +IBlErS2CuXffX+Z/ZGnFxgodtkGYkCLQB8AA5qjC8UPo1Uvlc0WdpkOcw/krSdTE/2Amm63b8OT
         8Fc6FWP3X+rgDUNSyvlMb15aX5EnsPYn4KF8uwyFATDkOxwg0jYD/Il/YPaHbD
From:   Rong Tao <rtoax@foxmail.com>
To:     sj@kernel.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        rongtao@cestc.cn, rtoax@foxmail.com, shuah@kernel.org,
        yuanchu@google.com
Subject: [PATCH v3] selftests/damon: Fix unnecessary compilation warnings
Date:   Sun, 13 Nov 2022 08:38:45 +0800
X-OQ-MSGID: <20221113003845.8709-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221112183050.85200-1-sj@kernel.org>
References: <20221112183050.85200-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

When testing overflow and overread, there is no need to keep unnecessary
compilation warnings, we should simply ignore them.

The motivation for this patch is to eliminate the compilation warning,
maybe one day we will compile the kernel with "-Werror -Wall", at which
point this compilation warning will turn into a compilation error, we
should fix this error in advance.

How to reproduce the problem (with gcc-11.3.1):

    $ make -C tools/testing/selftests/
    ...
    warning: ‘write’ reading 4294967295 bytes from a region of size 1
    [-Wstringop-overread]
    warning: ‘read’ writing 4294967295 bytes into a region of size 25
    overflows the destination [-Wstringop-overflow=]

"-Wno-stringop-overread" is supported at least in gcc-11.1.0.

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d14c547abd484d3540b692bb8048c4a6efe92c8b
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/damon/huge_count_read_write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index ad7a6b4cf338..a6fe0689f88d 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -8,6 +8,13 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#pragma GCC diagnostic push
+#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
+/* Ignore read(2) overflow and write(2) overread compile warnings */
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif
+
 void write_read_with_huge_count(char *file)
 {
 	int filedesc = open(file, O_RDWR);
@@ -27,6 +34,8 @@ void write_read_with_huge_count(char *file)
 	close(filedesc);
 }
 
+#pragma GCC diagnostic pop
+
 int main(int argc, char *argv[])
 {
 	if (argc != 2) {
-- 
2.31.1

