Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0172AFB6
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jun 2023 01:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjFJXvz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJXvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 19:51:54 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F3198C;
        Sat, 10 Jun 2023 16:51:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 01D4360174;
        Sun, 11 Jun 2023 01:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686441109; bh=v4wXQstgWeUzNRuDlXeZ8k492Buj4zZppclAsNx/yB4=;
        h=From:To:Cc:Subject:Date:From;
        b=Dii5rFne6vQCW9tPVWTBPZfQD9cKJZr0IX09PnedfUe59CevjhlVSnf7vnT5hKyk0
         qKygj+FbvV1XkQ9bdwOMmgb1Bv+xfNhCHrrScFKSuGQ71wqdBl0E7bfZKPs+CdgSlA
         ompFrtstnS1zKr0aBgGkDyodk3FzaDGHEj5Ok0dcjPgkSV/A7aJBBEtaTWagoFmYeC
         92jOPmOLTyDpFeKhESZPWi2Kwbu6OhQ2MDD3n6L44EFBVEa3fnm6CtstSdrPGLfuG2
         YwubeJBlc6g7n5zv8u9mdsHlPxoJyE4wYdQ526P18zpRGPyBk09rjugURRGOrMsbAY
         B5xAM1+MVekyQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IcQZa6_0euSK; Sun, 11 Jun 2023 01:51:46 +0200 (CEST)
Received: from defiant.. (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id CC09F60173;
        Sun, 11 Jun 2023 01:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1686441105; bh=v4wXQstgWeUzNRuDlXeZ8k492Buj4zZppclAsNx/yB4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ax0GnqZEGEiKjzWp2X8g3TpxfKrmXMmc4mK34qRy/toO5JyJKu0vIiWuOC7aUtO5z
         MRQh5299/46M+zzYmF833FRbJd18AoO0eOpgQ6M8SZKxJ9u481JixJtcJS9hlGjqD4
         Su3Kn/YHyKb2av43WHmUHaEjKqBOtI26zxOgMftraBQS3+sqQpJTqcMGbKnEovciaf
         xcSvY1gzqqIQbl+JUU/dhm6Tj7rdMVEbT1zg9zSMrQ1YlKfON3j5NB5LfezKvUZoE9
         u2NQd0fxmR1r7XMtO3rhPXyLRgd6vU6Y/t9vwxsRYs19FcZkUTf0xq8kNut4MYImXi
         BA90bYGJKAzqQ==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/1] selftests: mm: uufd-unit-tests: remove a format warning in printf
Date:   Sun, 11 Jun 2023 01:50:17 +0200
Message-Id: <20230610235016.438460-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GCC 11.3.0 issued warnings about macros and types of arguments [edited]:

gcc -Wall -I ../tools/testing/selftests/../../.. \
	-I ../tools/testing/selftests/../../../tools/include/uapi \
	-isystem ../usr/include -no-pie uffd-unit-tests.c vm_util.c \
	uffd-common.c -lrt -lpthread -o \
	../tools/testing/selftests/mm/uffd-unit-tests
uffd-unit-tests.c: In function ‘main’:
uffd-unit-tests.c:1198:41: warning: format not a string literal and no \
	format arguments [-Wformat-security]
 1198 |                         uffd_test_start(test_name);
      |                                         ^~~~~~~~~
uffd-unit-tests.c:100:24: note: in definition of macro ‘uffd_test_start’
  100 |                 printf(__VA_ARGS__);            \
      |                        ^~~~~~~~~~~
uffd-unit-tests.c:1205:33: warning: format not a string literal and no \
	format arguments [-Wformat-security]
 1205 |                                 uffd_test_skip(errmsg);
      |                                 ^~~~~~~~~~~~~~

The macros are defined as:

 #define  uffd_test_start(...)  do {             \
                printf("Testing ");             \
                printf(__VA_ARGS__);            \
                printf("... ");                 \
                fflush(stdout);                 \
        } while (0)

 #define  uffd_test_skip(...)  do {              \
                printf("skipped [reason: ");    \
                printf(__VA_ARGS__);            \
                printf("]\n");                  \
                ksft_inc_xskip_cnt();           \
        } while (0)

Minor workaround, adding "%s" first argument to macro expansion calls seems
to be the easiest way to eliminate the warnings.

Cc: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Fixes: 43759d44dc34 ("selftests/mm: add uffdio register ioctls test")
Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..d356dd271c84 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1195,14 +1195,14 @@ int main(int argc, char *argv[])
 			snprintf(test_name, sizeof(test_name),
 				 "%s on %s", test->name, mem_type->name);
 
-			uffd_test_start(test_name);
+			uffd_test_start("%s", test_name);
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;
 			}
 			if (uffd_setup_environment(&args, test, mem_type,
 						   &errmsg)) {
-				uffd_test_skip(errmsg);
+				uffd_test_skip("%s", errmsg);
 				continue;
 			}
 			test->uffd_fn(&args);
-- 
2.34.1

