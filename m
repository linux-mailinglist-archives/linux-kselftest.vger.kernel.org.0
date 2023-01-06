Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960AF660588
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jan 2023 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjAFRTX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Jan 2023 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAFRTL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Jan 2023 12:19:11 -0500
X-Greylist: delayed 56087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 09:19:05 PST
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4707DE18;
        Fri,  6 Jan 2023 09:19:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 14F92604F3;
        Fri,  6 Jan 2023 18:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673025542; bh=bbciZY0FY+dm7Ftyy2TqJhYcG6unTZLWiVPeHAgnz3s=;
        h=Date:From:Subject:To:Cc:From;
        b=rmNDDYGMJGcBV8AUoZ2S7vvVwW5qLFETB3QUv9n2ofyRFLYG2129oiyOncPCVVDo1
         /97DjBxSr9upT0KGhvYLhb92FZ8Pzl2DOhoik0ZHZgSy/yVf5nszK7E+I/5R+JwcJH
         fM8reeJ+aFxTVWkg1MS1i+6ZOkEqNP9EThLmuqGNHkGyuZe8qIhiSyxFDdbmkgPONF
         qbQ5mq/hOxnZC5gZAtxnAmLtK438UsJNBeHc6Lsut9kK1cp0TXHCfpR75p8EF8x1gV
         hGOxE09whWU0KFYpesg3QFlFzcEXo/jZW97FD8Eo5y6oEXR3WUHnq2VLbgg+Cvj+IV
         KfPquE3p74TkA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XtY6v37OufNU; Fri,  6 Jan 2023 18:18:59 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 439B4604F0;
        Fri,  6 Jan 2023 18:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673025539; bh=bbciZY0FY+dm7Ftyy2TqJhYcG6unTZLWiVPeHAgnz3s=;
        h=Date:From:Subject:To:Cc:From;
        b=lnfQxP5Xm0X3NGASRcnG48pXseJqrkD3Mz6puc8BwJU9ckRsLvNGG71j4vzI+wmGQ
         R28uejPWWXXq7/BDf0M1s/mBiXrIJKk/tc4CqzeYnLgKSJqj/nZWVzORuAtuE4nT/e
         /nataA+Ay9oDpp2YlBMZ7RRBJ1EO+rlV1vNZf3+E9X3W87LXsKp72mRf1BDO0tyR+d
         T+YzLgjTKfm6FEeq9z9ZYzQFQVRLeCNin4HwffqIRejTI08mCNUyczjIzqF45LaQ8s
         n7Jlef+P3tiUOoiSgr4xvTO6n5IKBEaHnsmv8KUugBarAIk+khCCZbvGvbSvJvEv3Z
         YvA5U6QS+Vv+Q==
Message-ID: <bd7ff00a-6892-fd56-b3ca-4b3feb6121d8@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 18:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH selftest/net/af_unix 1/1] Fix size of parameter to connect()
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Adjust size parameter in connect() to match the type of the parameter, to fix "No such file or directory"
error in selftests/net/af_unix/test_oob_unix.c:127.

The existing code happens to work provided that the autogenerated pathname is shorter than
sizeof (struct sockaddr), which is why it hasn't been noticed earlier.

Visible from the trace excerpt:

bind(3, {sa_family=AF_UNIX, sun_path="unix_oob_453059"}, 110) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7fa6a6577a10) = 453060
[pid <child>] connect(6, {sa_family=AF_UNIX, sun_path="unix_oob_45305"}, 16) = -1 ENOENT (No such file or directory)

BUG: The filename is trimmed to sizeof (struct sockaddr).

The patch is generated against the "vanilla" torvalds mainline tree 6.2-rc2.

Thanks and regards,
Mirsad Todorovac

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc: Florian Westphal <fw@strlen.de>
Reviewed-by: Florian Westphal <fw@strlen.de>

---
  tools/testing/selftests/net/af_unix/test_unix_oob.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/test_unix_oob.c b/tools/testing/selftests/net/af_unix/test_unix_oob.c
index b57e91e1c3f2..532459a15067 100644
--- a/tools/testing/selftests/net/af_unix/test_unix_oob.c
+++ b/tools/testing/selftests/net/af_unix/test_unix_oob.c
@@ -124,7 +124,7 @@ void producer(struct sockaddr_un *consumer_addr)

         wait_for_signal(pipefd[0]);
         if (connect(cfd, (struct sockaddr *)consumer_addr,
-                    sizeof(struct sockaddr)) != 0) {
+                    sizeof(*consumer_addr)) != 0) {
                 perror("Connect failed");
                 kill(0, SIGTERM);
                 exit(1);

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union
