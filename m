Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6519572F83A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbjFNIsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbjFNIsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 04:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7A1BD2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686732441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKa17mcJ3JZO5ohKJLfi/PuyyQC704/6NuVAqrSjVLw=;
        b=b6ryRXJ3G4iAGJ4iqErOTa3yMcJ6tNWYK8qma20J4HnFGeHsQ542KCaVhfWuUBluSZFfIU
        b1OixgTNG8I0NjGzwgURWPSvhcl7WdXseBv35JdJ+EJKdHd15Dw+kFtDjMHhTXdbPgz9ox
        4NVjCiVIaOxnBLcg1mYg+h5LBj3ZzPc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-AAKROitaPkeTQYmF4sLMKA-1; Wed, 14 Jun 2023 04:47:19 -0400
X-MC-Unique: AAKROitaPkeTQYmF4sLMKA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f8d79fdd33so3538445e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732438; x=1689324438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKa17mcJ3JZO5ohKJLfi/PuyyQC704/6NuVAqrSjVLw=;
        b=lj3563/7upYdpNbTryVFuDjIOc0WnJwa2SQJjllrRnG8l52RFVz1kApuPAowHSzPh/
         pvwmEqTkyVvLZN3nJk6hdMxHEJzpihM7AHJ44CvX0KgSOvrau2c1d0sxNLOMfgt8HgG0
         qtwOP7k+9ijmBgVnGD0aYuZX7mcphE+KoUlC+BQbzwReVHjKP8rAE4+h4w4HXE0e0Ihi
         qBK5sf6ac01br63+8Kmxi6CC7gB5Z0ZD7Pl9V3wm21QrpN+t037x8kodXWbWGdT8DTuk
         ikeOkmnOr1qvPRoc84C1wFRrBDdLvhH3zMwo+Oj75oekIKtXRFoDE/gE1XC8hledc/ai
         kE2g==
X-Gm-Message-State: AC+VfDyH1x6UkL4cxrFtJsAEvTlN0F8gyH4C705/zKDBwh+tZjn1rFUC
        HP8pV3VSnPj/Tz5EbZ42ECGL4VP7k6XM0K3HqXqr0cdw6FR0SLy3JEHZPbOkGSLoBlj3TOWpTCU
        B30BrNSB9hSEIP8TpeZ4IXEQxyaut
X-Received: by 2002:a7b:c7c6:0:b0:3f7:dfdf:36ce with SMTP id z6-20020a7bc7c6000000b003f7dfdf36cemr11707246wmk.9.1686732438396;
        Wed, 14 Jun 2023 01:47:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z8YuuOGNs6Hj04dXo4iS3Q8t38rLYcTbaUG4CGkcr2jU5sVUgPGIIdof9BgkDzKPkajtuCg==
X-Received: by 2002:a7b:c7c6:0:b0:3f7:dfdf:36ce with SMTP id z6-20020a7bc7c6000000b003f7dfdf36cemr11707228wmk.9.1686732437995;
        Wed, 14 Jun 2023 01:47:17 -0700 (PDT)
Received: from debian (2a01cb058d652b0004dec95078ab8527.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:4de:c950:78ab:8527])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm16824117wma.24.2023.06.14.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 01:47:17 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:47:15 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL][FIX TESTED] in
 vrf "bind - ns-B IPv6 LLA" test
Message-ID: <ZIl+k8zJ7A0vFKpB@debian>
References: <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <48cfd903-ad2f-7da7-e5a6-a22392dc8650@alu.unizg.hr>
 <ZH+BhFzvJkWyjBE0@debian>
 <a3b2891d-d355-dacd-24ec-af9f8aacac57@alu.unizg.hr>
 <ZIC1r6IHOM5nr9QD@debian>
 <884d9eb7-0e8e-3e59-cf6d-2c6931da35ee@alu.unizg.hr>
 <ZINPuawVp2KKoCjS@debian>
 <a74fbb54-2594-fd37-c5fe-3a027d9a5ea3@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74fbb54-2594-fd37-c5fe-3a027d9a5ea3@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 10, 2023 at 08:04:02PM +0200, Mirsad Goran Todorovac wrote:
> This also works on the Lenovo IdeaPad 3 Ubuntu 22.10 laptop, but on the AlmaLinux 8.8
> Lenovo desktop I have a problem:
> 
> [root@pc-mtodorov net]# grep FAIL ../fcnal-test-4.log
> TEST: ping local, VRF bind - ns-A IP                                          [FAIL]
> TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> TEST: ping local, device bind - ns-A IP                                       [FAIL]
> TEST: ping local, VRF bind - ns-A IP                                          [FAIL]
> TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> TEST: ping local, device bind - ns-A IP                                       [FAIL]
> [root@pc-mtodorov net]#
> 
> Kernel is the recent one:
> 
> [root@pc-mtodorov net]# uname -rms
> Linux 6.4.0-rc5-testnet-00003-g5b23878f7ed9 x86_64
> [root@pc-mtodorov net]#

Maybe a problem with the ping version used by the distribution.
You can try "./fcnal-test.sh -t ipv4_ping -p -v" to view the commands
run and make the script stop when there's a test failure (so that you
can see the ping output and try your own commands in the testing
environment).

> > > However, I have a question:
> > > 
> > > In the ping + "With VRF" section, the tests with net.ipv4.raw_l3mdev_accept=1
> > > are repeated twice, while "No VRF" section has the versions:
> > > 
> > > SYSCTL: net.ipv4.raw_l3mdev_accept=0
> > > 
> > > and
> > > 
> > > SYSCTL: net.ipv4.raw_l3mdev_accept=1
> > > 
> > > The same happens with the IPv6 ping tests.
> > > 
> > > In that case, it could be that we have only 2 actual FAIL cases,
> > > because the error is reported twice.
> > > 
> > > Is this intentional?
> > 
> > I don't know why the non-VRF tests are run once with raw_l3mdev_accept=0
> > and once with raw_l3mdev_accept=1. Unless I'm missing something, this
> > option shouldn't affect non-VRF users. Maybe the objective is to make
> > sure that it really doesn't affect them. David certainly knows better.
> 
> The problem appears to be that non-VRF tests are being ran with
> raw_l3mdev_accept={0|1}, while VRF tests w raw_l3mdev_accept={1|1} ...

The reason the VRF tests run twice is to test both raw and ping sockets
(using the "net.ipv4.ping_group_range" sysctl). It doesn't seem anyone
ever intended to run the VRF tests with raw_l3mdev_accept=0.

Only the non-VRF tests were intended to be tested with
raw_l3mdev_accept=0 (see commit c032dd8cc7e2 ("selftests: Add ipv4 ping
tests to fcnal-test")). But I have no idea why.

> I will try to fix that, but I am not sure of the semantics either.
> 
> Regards,
> Mirsad
> 

