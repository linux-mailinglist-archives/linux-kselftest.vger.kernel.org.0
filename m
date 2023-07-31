Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD7769F9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGaRmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGaRmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 13:42:04 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA5AC7;
        Mon, 31 Jul 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690825323; x=1722361323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eL5D6LXJAo53y5XJzB17VKf8cV4Z9HiANksEo3Es+4g=;
  b=dJ2zezi/1327b2aeca7e40Xm8FsOc64dUHeoo0SZWuxNlRPEeyrAqYsf
   pY3i7N2E4hPN8uFgOXmdHxqSw/CkWsjQx+RAmPP+Njtx6CXANrmDKX+lZ
   2Xake68ipa+wG/xlV/QkP/2D1D3mAFp7j4hToxyCcXJ6XqJxlNMlhWLfA
   0=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="145781549"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 17:42:00 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id C7DC740D5E;
        Mon, 31 Jul 2023 17:41:59 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 17:41:54 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 17:41:52 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <dan.carpenter@linaro.org>
CC:     <kuniyu@amazon.com>, <linux-kselftest@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [bug report] selftest: Add test for SO_INCOMING_CPU.
Date:   Mon, 31 Jul 2023 10:41:43 -0700
Message-ID: <20230731174143.99810-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <fe376760-33b6-4fc9-88e8-178e809af1ac@moroto.mountain>
References: <fe376760-33b6-4fc9-88e8-178e809af1ac@moroto.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.27]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan,

From:   Dan Carpenter <dan.carpenter@linaro.org>
Date:   Mon, 31 Jul 2023 17:18:37 +0300
> Hello Kuniyuki Iwashima,
> 
> The patch 6df96146b202: "selftest: Add test for SO_INCOMING_CPU."
> from Oct 21, 2022 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	./tools/testing/selftests/net/so_incoming_cpu.c:163 create_clients()
> 	error: uninitialized symbol 'ret'.
> 
> ./tools/testing/selftests/net/so_incoming_cpu.c
>     146 void create_clients(struct __test_metadata *_metadata,
>     147                     FIXTURE_DATA(so_incoming_cpu) *self)
>     148 {
>     149         cpu_set_t cpu_set;
>     150         int i, j, fd, ret;
>     151 
>     152         for (i = 0; i < NR_SERVER; i++) {
>     153                 CPU_ZERO(&cpu_set);
>     154 
>     155                 CPU_SET(i, &cpu_set);
>     156                 ASSERT_EQ(CPU_COUNT(&cpu_set), 1);
>     157                 ASSERT_NE(CPU_ISSET(i, &cpu_set), 0);
>     158 
>     159                 /* Make sure SYN will be processed on the i-th CPU
>     160                  * and finally distributed to the i-th listener.
>     161                  */
>     162                 sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
> 
> Presumabley ret = sched_setaffinity() was intended.

Right, thanks for reporting.
I'll post a patch.

Thanks!


> 
> --> 163                 ASSERT_EQ(ret, 0);
>     164 
>     165                 for (j = 0; j < CLIENT_PER_SERVER; j++) {
>     166                         fd  = socket(AF_INET, SOCK_STREAM, 0);
>     167                         ASSERT_NE(fd, -1);
>     168 
>     169                         ret = connect(fd, &self->addr, self->addrlen);
>     170                         ASSERT_EQ(ret, 0);
>     171 
>     172                         close(fd);
>     173                 }
>     174         }
>     175 }
> 
> regards,
> dan carpenter
