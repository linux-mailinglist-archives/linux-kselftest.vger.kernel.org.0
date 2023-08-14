Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4777BC89
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHNPLF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjHNPKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 11:10:48 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C81723
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 08:10:27 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-QwLIulTqNtSfeNOFa008PA-1; Mon, 14 Aug 2023 11:10:02 -0400
X-MC-Unique: QwLIulTqNtSfeNOFa008PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A2F93810D27;
        Mon, 14 Aug 2023 15:10:02 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 636A6140E962;
        Mon, 14 Aug 2023 15:10:00 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:09:59 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 6/6] selftests: tls: add rekey tests
Message-ID: <ZNpDx49WU2g3IqM0@hog>
References: <cover.1691584074.git.sd@queasysnail.net>
 <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
 <ZNUlWDvyOal1p5OY@vergenet.net>
MIME-Version: 1.0
In-Reply-To: <ZNUlWDvyOal1p5OY@vergenet.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2023-08-10, 19:58:48 +0200, Simon Horman wrote:
> On Wed, Aug 09, 2023 at 02:58:55PM +0200, Sabrina Dubroca wrote:
> 
> nit: Ideally a patch description would go here.

I'm not opposed to adding one, but I couldn't come up with anything
that the title doesn't already say :(

> > v2: add rekey_fail test (reject changing the version/cipher)
> > v3: add rekey_peek_splice (suggested by Jakub)
> >     add rekey+poll tests
> > 
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> ...

-- 
Sabrina

