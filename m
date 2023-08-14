Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85877BD5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHNPqm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjHNPqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 11:46:25 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473AF10F4
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 08:46:24 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184--xZHB92IP4OU1uQ2F_SF_g-1; Mon, 14 Aug 2023 11:46:19 -0400
X-MC-Unique: -xZHB92IP4OU1uQ2F_SF_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83A13855716;
        Mon, 14 Aug 2023 15:46:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0C3063F71;
        Mon, 14 Aug 2023 15:46:16 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:46:15 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <ZNpMR8nYKlIP9JQw@hog>
References: <cover.1691584074.git.sd@queasysnail.net>
 <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
 <20230811184347.1f7077a9@kernel.org>
 <ZNpC4lAmlLn-5A9h@hog>
 <20230814082128.632d2b03@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230814082128.632d2b03@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2023-08-14, 08:21:28 -0700, Jakub Kicinski wrote:
> On Mon, 14 Aug 2023 17:06:10 +0200 Sabrina Dubroca wrote:
> > 2023-08-11, 18:43:47 -0700, Jakub Kicinski wrote:
> > > On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:  
> > > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
> > > >  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
> > > >  			conf = TLS_SW;  
> > > 
> > > Should we add a statistic for rekeying?  
> > 
> > Hmpf, at least I shouldn't be incrementing the existing stats on every
> > update, especially not TLSCURR* :/
> > 
> > I don't see much benefit in tracking succesful rekeys. Failed rekeys
> > seem more interesting to me. What would we get from counting succesful
> > rekeys?
> 
> No huge benefit from counting rekeys, the main (only?) one I see is
> that when user reports issues we can see whether rekeys were involved
> (given that they are fairly rare). It could help narrow down triage.

Ok. So unless you objcet I'll add 4 more counters: {RX,TX}REKEY{OK,ERROR}.

And it probably shouldn't be "rekey" in case we decide to implement
full 1.2 renegotiation (with cipher change) and use the same
counter. Or 1.2 renegotiation without cipher change gets to use the
rekey counters, and cipher change would get a new set of counters.

I could also just call them *UPDATE* but that might be a bit too
vague.

-- 
Sabrina

