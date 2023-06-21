Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581AD738868
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjFUPHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjFUPHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 11:07:32 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673934239;
        Wed, 21 Jun 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687359745; x=1718895745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zbPAeOGrUEIOV+JujOL9INmhyma6JwFI+vqDZGWGqOk=;
  b=fop1sEkk90qtxm8OZfTFpmBI5Q6kymfZtycgyCraGKaaWw9K/9hyrbgo
   2dd2Zr5+kIjW+fiVrNDuF48N/eztk0PKMT8Ucj7qseujBHBP7jI5lFKWM
   ulpXD9rnjwKELepcnj/AN1kzf451o37NV+N/YQXPVTtoWbAycsf6VlC/3
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,260,1681171200"; 
   d="scan'208";a="138321779"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:01:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-d40ec5a9.us-west-2.amazon.com (Postfix) with ESMTPS id EC7B840D4E;
        Wed, 21 Jun 2023 15:01:12 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Jun 2023 15:01:12 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.169.70) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Jun 2023 15:01:07 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
        <hemanthmalla@gmail.com>, <joe@wand.net.nz>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>,
        <song@kernel.org>, <willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
Date:   Wed, 21 Jun 2023 08:00:58 -0700
Message-ID: <20230621150058.59250-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8gYuW5P3t5881YdMq1pYnG9DsQJFiJWPoLFsKVsZiLLQQ@mail.gmail.com>
References: <CAN+4W8gYuW5P3t5881YdMq1pYnG9DsQJFiJWPoLFsKVsZiLLQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.119.169.70]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 21 Jun 2023 09:01:15 +0100
> On Tue, Jun 20, 2023 at 7:31 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Good point.  This is based on an assumption that all SO_REUSEPORT
> > sockets have the same score, which is wrong for two corner cases
> > if reuseport_has_conns() == true :
> >
> >   1) SO_INCOMING_CPU is set
> >      -> selected sk might have +1 score
> >
> >   2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
> >      -> selected sk will have more than 8
> >
> > Using the old score could trigger more lookups depending on the
> > order that sockets are created.
> 
> So the result will still be correct, but it's less performant? Happy
> to fix a perf regression, but if the result is incorrect this might
> need a separate fix?

Right, the result is always correct.

If BPF prog selects a different socket per lookup, there is no
consistency, but it _is_ corret.


> I did some more digging. I think this was introduced by commit
> efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.") which
> unfortunately ran into a merge conflict. That resulted in Dave Miller
> moving the bug around in commit a57066b1a019 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"). Can you
> take a look and let me know if you think that is correct?

Yes, I should have updated the score too in efc6b6f6c311 to save
unneeded lookups.  The conflict itself was resolved properly.
