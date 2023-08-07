Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853077309B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHGUrH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHGUrG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 16:47:06 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD351189;
        Mon,  7 Aug 2023 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691441226; x=1722977226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i3BspMO1SbyaVrPL43K1PgldA9iQctRpaOUukh+SQm0=;
  b=m7hnTHmYsgih5/c6G+Gd0jAODsQfKnWA/wKrhNUsDMzP8GR1sfWuuPiC
   u+Ac9FA1SKGJKbG1mnHJtvQ4DhropoQHJbf4AgwAvsdAqYkpiJVUy1Mdm
   E1NFRuUcSe2Fsfxuux6nOS3I5xeRlKAp5xqJX8NrgfvdV0dnV2BxWDYHs
   w=;
X-IronPort-AV: E=Sophos;i="6.01,263,1684800000"; 
   d="scan'208";a="665009981"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:47:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 7766510064B;
        Mon,  7 Aug 2023 20:46:59 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 20:46:59 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Mon, 7 Aug 2023 20:46:56 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <mirsad.todorovac@alu.unizg.hr>
CC:     <alexander@mihalicyn.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <fw@strlen.de>, <kuba@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: selftests: net/af_unix test_unix_oob [FAILED]
Date:   Mon, 7 Aug 2023 13:46:47 -0700
Message-ID: <20230807204648.50070-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <abf98942-0058-f2ad-8e55-fbdd83b7c2d6@alu.unizg.hr>
References: <abf98942-0058-f2ad-8e55-fbdd83b7c2d6@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Date: Mon, 7 Aug 2023 21:44:41 +0200
> Hi all,
> 
> In the kernel 6.5-rc5 build on Ubuntu 22.04 LTS (jammy jellyfish) on a Ryzen 7950 assembled box,
> vanilla torvalds tree kernel, the test test_unix_oob unexpectedly fails:
> 
> # selftests: net/af_unix: test_unix_oob
> # Test 2 failed, sigurg 23 len 63 OOB %
> 
> It is this code:
> 
>          /* Test 2:
>           * Verify that the first OOB is over written by
>           * the 2nd one and the first OOB is returned as
>           * part of the read, and sigurg is received.
>           */
>          wait_for_data(pfd, POLLIN | POLLPRI);
>          len = 0;
>          while (len < 70)
>                  len = recv(pfd, buf, 1024, MSG_PEEK);
>          len = read_data(pfd, buf, 1024);
>          read_oob(pfd, &oob);
>          if (!signal_recvd || len != 127 || oob != '#') {
>                  fprintf(stderr, "Test 2 failed, sigurg %d len %d OOB %c\n",
>                  signal_recvd, len, oob);
>                  die(1);
>          }
> 
> In 6.5-rc4, this test was OK, so it might mean we have a regression?

Thanks for reporting.

I confirmed the test doesn't fail on net-next at least, but it's based
on v6.5-rc4.

  ---8<---
  [root@localhost ~]# ./test_unix_oob 
  [root@localhost ~]# echo $?
  0
  [root@localhost ~]# uname -r
  6.5.0-rc4-01192-g66244337512f
  ---8<---

I'll check 6.5-rc5 later.


> 
> marvin@defiant:~/linux/kernel/linux_torvalds$ grep test_unix_oob ../kselftest-6.5-rc4-1.log
> /net/af_unix/test_unix_oob
> # selftests: net/af_unix: test_unix_oob
> ok 2 selftests: net/af_unix: test_unix_oob
> marvin@defiant:~/linux/kernel/linux_torvalds$
> 
> Hope this helps.
> 
> NOTE: the kernel is vanilla torvalds tree, only "dirty" because the selftests were modified.
> 
> Kind regards,
> Mirsad Todorovac
