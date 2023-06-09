Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330A729FD7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjFIQPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbjFIQOw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 12:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7D3A9A
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjnwFmKQpbvVOv8RhC06l9oJtf9FhCX/e6y5G4jDiGU=;
        b=EjbgYVXimZK5E0O57TRW4jzkLNvxFwk8+tAbEb75ORQaQHeQQB7QbkPni9uv1BAJZ7nyQi
        L92K1sKjsruJYuS0RBaaw5yOh0RKVtZaP2YHKpO5jFFYZRuT9ZE6E3OE7kQysUIxQOz9rs
        MJV8kTzoJ2pT3kdoQgp9XOUh7ieuvfM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-1ePTzwxpNaOuOhuPxFQusg-1; Fri, 09 Jun 2023 12:13:55 -0400
X-MC-Unique: 1ePTzwxpNaOuOhuPxFQusg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f6255b3cd3so1580500e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 09:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327228; x=1688919228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjnwFmKQpbvVOv8RhC06l9oJtf9FhCX/e6y5G4jDiGU=;
        b=TdeQPbKfTCvzlzVK7CBO2uWFPmJUHT2A0bVxJKQJ9z9XfXZQaW7e8XyTgncYpxeEgS
         JnXCQ5nUbExHACy5ckG1CN1/ciCMhqTLnCeiJFuwLIpPtkfmkSEMGJWIIQ17YqdV26nD
         m3sdQaopTIuhXmDgLGcjU6CiZSE9sICziuk1kqMtXZcxWl3crbqezfVhhFXTeHqiqa5J
         LPZddO1aIQRmmlPWWV0zs8HmHPcUEgtkVAaGMQvXR7hzpa5xS0gK0EkCrBfXXCPHDGRI
         zw+KX9e8/rcf4dEAbpqIIPqedhd8k48yD5f4IM+lcYMg4UKebWJgpJ7Cs+DtJ2pbfI0s
         EdmA==
X-Gm-Message-State: AC+VfDyeFFMM3j6PALrhzkTsu+DlHjXom4X3Fsn71inaumdVJHmaZJtu
        h240M2o844/rhh5c/QIYxqrhDk7IDy+BpovyN36MQpqeJZN7Au3SGrIGkFYNTEl9uzsIi4sgFYa
        4bul/ZWaaRxDOJgInupLa/Vq4xgbp
X-Received: by 2002:a19:671a:0:b0:4f1:458c:c4c with SMTP id b26-20020a19671a000000b004f1458c0c4cmr1048711lfc.43.1686327228514;
        Fri, 09 Jun 2023 09:13:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eiDpt4qpPOKsRpIwXVfpY5xuIiaiJRcUaZa3uurpD0Gy5kWNN3IDlSv9xR4c2XOYksnMJ7Q==
X-Received: by 2002:a19:671a:0:b0:4f1:458c:c4c with SMTP id b26-20020a19671a000000b004f1458c0c4cmr1048698lfc.43.1686327228139;
        Fri, 09 Jun 2023 09:13:48 -0700 (PDT)
Received: from debian (2a01cb058918ce00d1f444ced1f78888.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d1f4:44ce:d1f7:8888])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003f7ed463954sm3107493wmj.25.2023.06.09.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:13:47 -0700 (PDT)
Date:   Fri, 9 Jun 2023 18:13:45 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL][FIX TESTED] in
 vrf "bind - ns-B IPv6 LLA" test
Message-ID: <ZINPuawVp2KKoCjS@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <48cfd903-ad2f-7da7-e5a6-a22392dc8650@alu.unizg.hr>
 <ZH+BhFzvJkWyjBE0@debian>
 <a3b2891d-d355-dacd-24ec-af9f8aacac57@alu.unizg.hr>
 <ZIC1r6IHOM5nr9QD@debian>
 <884d9eb7-0e8e-3e59-cf6d-2c6931da35ee@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884d9eb7-0e8e-3e59-cf6d-2c6931da35ee@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 07:37:15AM +0200, Mirsad Goran Todorovac wrote:
> On 6/7/23 18:51, Guillaume Nault wrote:
> > On Wed, Jun 07, 2023 at 12:04:52AM +0200, Mirsad Goran Todorovac wrote:
> > > [...]
> > > TEST: ping local, VRF bind - ns-A IP                                          [ OK ]
> > > TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> > > TEST: ping local, VRF bind - loopback                                         [ OK ]
> > > TEST: ping local, device bind - ns-A IP                                       [FAIL]
> > > TEST: ping local, device bind - VRF IP                                        [ OK ]
> > > [...]
> > > TEST: ping local, VRF bind - ns-A IP                                          [ OK ]
> > > TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> > > TEST: ping local, VRF bind - loopback                                         [ OK ]
> > > TEST: ping local, device bind - ns-A IP                                       [FAIL]
> > > TEST: ping local, device bind - VRF IP                                        [ OK ]
> > > [...]
> > 
> > I have the same failures here. They don't seem to be recent.
> > I'll take a look.
> 
> Certainly. I thought it might be something architecture-specific?
> 
> I have reproduced it also on a Lenovo IdeaPad 3 with Ubuntu 22.10,
> but on Lenovo desktop with AlmaLinux 8.8 (CentOS fork), the result
> was "888/888 passed".

I've taken a deeper look at these failures. That's actually a problem in
ping. That's probably why you have different results depending on the
distribution.

The problem is that, for some versions, 'ping -I netdev ...' doesn't
bind the socket to 'netdev' if the IPv4 address to ping is set on that
same device. The VRF tests depend on this socket binding, so they fail
when ping refuses to bind. That was fixed upstream with commit
92ce8ef21393 ("Revert "ping: do not bind to device when destination IP
is on device"") (https://github.com/iputils/iputils/commit/92ce8ef2139353da3bf55fe2280bd4abd2155c9f).

Long story short, the tests should pass with the latest upstream ping
version.

Alternatively, you can modify the commands run by fcnal-test.sh and
provide the -I option twice: one for setting the device binding and one
for setting the source IPv4 address. This way ping should accept to
bind its socket.

Something like (not tested):

-                run_cmd ping -c1 -w1 -I ${VRF} ${a}
+                run_cmd ping -c1 -w1 -I ${VRF} -I ${a} ${a}
[...]
-        run_cmd ping -c1 -w1 -I ${NSA_DEV} ${a}
+        run_cmd ping -c1 -w1 -I ${NSA_DEV} -I ${a} ${a}

> However, I have a question:
> 
> In the ping + "With VRF" section, the tests with net.ipv4.raw_l3mdev_accept=1
> are repeated twice, while "No VRF" section has the versions:
> 
> SYSCTL: net.ipv4.raw_l3mdev_accept=0
> 
> and
> 
> SYSCTL: net.ipv4.raw_l3mdev_accept=1
> 
> The same happens with the IPv6 ping tests.
> 
> In that case, it could be that we have only 2 actual FAIL cases,
> because the error is reported twice.
> 
> Is this intentional?

I don't know why the non-VRF tests are run once with raw_l3mdev_accept=0
and once with raw_l3mdev_accept=1. Unless I'm missing something, this
option shouldn't affect non-VRF users. Maybe the objective is to make
sure that it really doesn't affect them. David certainly knows better.

> Thanks,
> Mirsad
> 

