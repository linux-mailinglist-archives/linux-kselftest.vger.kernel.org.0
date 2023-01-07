Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C19660B88
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 02:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjAGBiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Jan 2023 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGBiF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Jan 2023 20:38:05 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755E7FED9;
        Fri,  6 Jan 2023 17:38:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 87274604F1;
        Sat,  7 Jan 2023 02:38:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673055480; bh=bTNWDnS92qaE79On7aDdfTeVTGKTxcnF2/kwNwT8vww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vM13FKk1TRwZRY/WzVK9DCCoxoDeJMmMdJ7J/35tqNycP9ixAQPdE9g2zBFLcuDI8
         su5cz0uzAGKyGQAgRAyYRq7x/3+34ggzZBh54P5ZFnhUcsNkfA0Fx3MN7skTSKyDuy
         XA/PG/iWOt8cgEdWLAB0G1jPZnEZhbLoiudpSP2GpwHcMQz4GXl3CiZuRHRrKAuHsF
         SS0IvQcZkpYQHPaHs9/BL1CboBgEV7J8oJ3DEQXfv9OrG4cUHfS088uIFNsSojrY7/
         0LUOx8ydA7cK7nZs37kU54szglhAc0wYCKAg6LYNDdvhfcvZezFHjJVZuJ2eO6fqXT
         gYnAL+MWfcn9A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ERq_qlQfZXgt; Sat,  7 Jan 2023 02:37:58 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 6CC66604F0;
        Sat,  7 Jan 2023 02:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673055478; bh=bTNWDnS92qaE79On7aDdfTeVTGKTxcnF2/kwNwT8vww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l+D/NuZZPIcI+ANxTOpvTyeBNJ5pQ7TWC2H5iMKq9jVvYrpuACDn9GMJFSBB59vcL
         /GnJSzr1pRhahV4qH5DP6V0oMuTNTYygt0PclnAfIq4nfR5qBm4t/kTa1srt7W3arJ
         VuH7NgNeN2nHRnqG4ojXoeuKxiULdHGKkV9CBF3ywAQfQfo2QaU6jrt29OjRaBsQaw
         4tuuEdJN89CU4HAXCU9xDTZVp2SjdpTGAAUuNL2feKnpwM3t/FDFzgigm4Wmwi62Td
         /2O3Zve6njfDswJedKJry6YmgR8/Q+zBAU7PaWAJ3OW38w77DJ1UBMepSN6Pfp4/1v
         r4mxqbjQVqdPw==
Message-ID: <2523def7-7fce-9e06-1b99-8fce43708629@alu.unizg.hr>
Date:   Sat, 7 Jan 2023 02:37:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: [PATCH net v3] af_unix: selftest: Fix the size of the parameter to
 connect()
Content-Language: en-US, hr
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        edumazet@google.com, fw@strlen.de, kuniyu@amazon.co.jp,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <bd7ff00a-6892-fd56-b3ca-4b3feb6121d8@alu.unizg.hr>
 <20230106175828.13333-1-kuniyu@amazon.com>
 <b80ffedf-3f53-08f7-baf0-db0450b8853f@alu.unizg.hr>
 <20230106161450.1d5579bf@kernel.org>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230106161450.1d5579bf@kernel.org>
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

Adjust size parameter in connect() to match the type of the parameter, to
fix "No such file or directory" error in selftests/net/af_unix/
test_oob_unix.c:127.

The existing code happens to work provided that the autogenerated pathname
is shorter than sizeof (struct sockaddr), which is why it hasn't been
noticed earlier.

Visible from the trace excerpt:

bind(3, {sa_family=AF_UNIX, sun_path="unix_oob_453059"}, 110) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7fa6a6577a10) = 453060
[pid <child>] connect(6, {sa_family=AF_UNIX, sun_path="unix_oob_45305"}, 16) = -1 ENOENT (No such file or directory)

BUG: The filename is trimmed to sizeof (struct sockaddr).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc: Florian Westphal <fw@strlen.de>
Reviewed-by: Florian Westphal <fw@strlen.de>
Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---

The patch is generated against the "vanilla" Torvalds mainline tree 6.2-rc2.
(Tested against the net.git tree.)

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

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

