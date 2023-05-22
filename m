Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9A70C15C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjEVOnX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjEVOnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 10:43:23 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297999;
        Mon, 22 May 2023 07:43:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A9A8260174;
        Mon, 22 May 2023 16:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684766598; bh=gFAip1LpaBAenVLmxO9SERe2dCyBM+Uu9Yhp1b8WsqY=;
        h=Date:To:From:Subject:From;
        b=O2OcQeTHZtCybT1uEFwFLD6C5AAHkcuFGXrIXxSSTkqPzYTyZgPg9EKZT8QuqpD1t
         5cLJty0R1fMaP7zt5M7qq3P1yvh4NkSGKKzbJzKA9uYDikOSf9HqGje+QkU2XqfxU0
         FhxQs7z+uFLqUUm0h7rzMYrPXeBNpIifLTbcWwZgydOFF/0F1q9ZSRpELJIK2+XUtV
         1wFJkqj+L7GFR609dJ470+/EBWqfPhe2C17d9Ga2H7Ao75ueZuTwpuAatKgcAOR+5A
         hZ4g1JoKQYw9fy6GHxTd5zHgQlYMEgew0FgVlspYeI4F363Lq8BrSa+GYb4RoVgQsC
         ePlZcUiIrrfYQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0hV_zlYnz9Z8; Mon, 22 May 2023 16:43:16 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 3510460173;
        Mon, 22 May 2023 16:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684766596; bh=gFAip1LpaBAenVLmxO9SERe2dCyBM+Uu9Yhp1b8WsqY=;
        h=Date:To:From:Subject:From;
        b=DlvhoQKPuRU2FSQHkaWepSFFk9Yw+guaNw8MWMZCJdbFh6gcpVTVCnpo/7f8boqRu
         MIz6tv3qJT9bMaxbzgfEmpgbdehVT36EQxVPbAH6iBwGuNxdMeusX7MJmHrjYvLVJM
         c4RqfBwiEA3FxcyCXVyPBpwtyY3/8tJJ6/t/oLqrd2KAJLTXpSra3iVQd0bHiwTjlX
         TPX9TM4e4uKiHLhTZ83CbTIB3EE6CEXznmdcaPx4UOFuDHiYgTGdPSzf0YiK/5e25z
         bg2HDxxLFXw8ZGuHSx+hKMAEEwoQJC0aw7L8JtUL05nsb1pWtirVg1wPJERnA0m6ty
         RGu47tn3T8ybQ==
Message-ID: <0ed660e3-1261-7c97-8fa7-7145743c4650@alu.unizg.hr>
Date:   Mon, 22 May 2023 16:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, hr
To:     Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: selftests: memfd/memfd_test.c: does not compile under AlmaLinux 8.7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On AlmaLinux 8.7, make kselftest-all fails at memfd/memfd_test.c:

make[2]: Entering directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd'
gcc -D_FILE_OFFSET_BITS=64 -isystem /home/marvin/linux/kernel/linux_torvalds/usr/include     memfd_test.c common.c  -o 
/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd/memfd_test
memfd_test.c: In function ‘test_seal_future_write’:
memfd_test.c:916:27: error: ‘F_SEAL_FUTURE_WRITE’ undeclared (first use in this function); did you mean ‘F_SEAL_WRITE’?
   mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
                            ^~~~~~~~~~~~~~~~~~~
                            F_SEAL_WRITE
memfd_test.c:916:27: note: each undeclared identifier is reported only once for each function it appears in
memfd_test.c: In function ‘test_exec_seal’:
memfd_test.c:36:7: error: ‘F_SEAL_FUTURE_WRITE’ undeclared (first use in this function); did you mean ‘F_SEAL_WRITE’?
        F_SEAL_FUTURE_WRITE | \
        ^~~~~~~~~~~~~~~~~~~
memfd_test.c:1058:27: note: in expansion of macro ‘F_WX_SEALS’
   mfd_assert_has_seals(fd, F_WX_SEALS);
                            ^~~~~~~~~~
make[2]: *** [../lib.mk:147: /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd/memfd_test] Error 1
make[2]: Leaving directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd'

Apparently, the include file include/uapi/linux/fcntl.h defines this
F_SEAL_FUTURE_WRITE as 0x0010:

include/uapi/linux/fcntl.h:45:#define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */

This patch fixed the issue:

---
  tools/testing/selftests/memfd/memfd_test.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..868f17c02e32 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,7 +28,13 @@
  #define MFD_DEF_SIZE 8192
  #define STACK_SIZE 65536

-#define F_SEAL_EXEC    0x0020
+#ifndef F_SEAL_FUTURE_WRITE
+#define F_SEAL_FUTURE_WRITE    0x0010
+#endif
+
+#ifndef F_SEAL_EXEC
+#define F_SEAL_EXEC            0x0020
+#endif

  #define F_WX_SEALS (F_SEAL_SHRINK | \
                     F_SEAL_GROW | \


Hope this helps.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
