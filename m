Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAD718916
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEaSMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEaSM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 14:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6D98
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685556706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAWAJe3UA9xA6PqORf3KUovsk+ctYnZo8FLCQDjgOnc=;
        b=crju0aubawoYU4mm8exgvUgGHdWCH2IbFJuXA8+Ajhh9ywkwgHVINh1+8VkilEyBJa/HOU
        OCkd+IeTgq+Fxzw5JtpRySQ765RwAf17GMrhEAlKeWg2IJRppy/Rd4oN2J8AQ7QYsrN++6
        RLvAR/c25DDR/BoZbVeU7NDWGCVYOiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-OUnuczQMNfiJTK-Y1Ynodw-1; Wed, 31 May 2023 14:11:44 -0400
X-MC-Unique: OUnuczQMNfiJTK-Y1Ynodw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5fb41bc42so27203245e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 11:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685556703; x=1688148703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAWAJe3UA9xA6PqORf3KUovsk+ctYnZo8FLCQDjgOnc=;
        b=bmw7uCrPCOa4ULKkt9YrMV+eQKpxdyvBg5lLmHnHlh4I1nAa6MYVMFoymSERkTAkQS
         HArGBsheqBPQOrxEgVdewYTuRKyzoGPjWI+Ir6eOtptduFoY9FZbedpB6DWO8tdQPO71
         Oj8mLsKO1PdPrpiwYnGdHqCnuCpRHuqHipx5Bh0dBv9ha18vXJRww+jPcP8I6IHATCRP
         qLljbCzi/2ArX5eg8GajuKUalmEdVAH3P/CpeZF2OmArnjfwTACpZJDbIeMNVhEgJ+V1
         gArmdqvbdET+qNsO96x+dfW/+mfFx1FPOxh3u0SUknDpUUrB+rVuAGRk15AiJkFXkk5R
         Hn2g==
X-Gm-Message-State: AC+VfDxwcun3F2cOkD+MNP/M/a14DHNNZrltpXdRlmxRE5S9gBQUcaxd
        bxFpZVdA3lu5xGVmBiUb8GH1K5j1ju8pb8sHitNCn72ZkXDOcLzK4MHyPm9PSJMb7jiQEqphuo3
        DKn7fNFgNG1TYW1tNNj9Y76KkRE51
X-Received: by 2002:a7b:c00f:0:b0:3f6:464:4b32 with SMTP id c15-20020a7bc00f000000b003f604644b32mr29559wmb.13.1685556703648;
        Wed, 31 May 2023 11:11:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4I3bej1gd6wxKA029xGlz2GTs++Hria7YlGL0+uG0cpjKlxWcboCFOk9SMAY3CSI+B+vPhdg==
X-Received: by 2002:a7b:c00f:0:b0:3f6:464:4b32 with SMTP id c15-20020a7bc00f000000b003f604644b32mr29540wmb.13.1685556703308;
        Wed, 31 May 2023 11:11:43 -0700 (PDT)
Received: from debian (2a01cb058d652b003ebe8a257dfba413.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:3ebe:8a25:7dfb:a413])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d4607000000b0030647449730sm7533168wrq.74.2023.05.31.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:11:42 -0700 (PDT)
Date:   Wed, 31 May 2023 20:11:41 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL] in vrf "bind -
 ns-B IPv6 LLA" test
Message-ID: <ZHeN3bg28pGFFjJN@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 02:17:09PM +0200, Mirsad Todorovac wrote:
> Hi,

Hi Mirsad,

> The very recent 6.4-rc3 kernel build with AlmaLinux 8.7 on LENOVO 10TX000VCR
> desktop box fails one test:
> 
> [root@host net]# ./fcnal-test.sh
> [...]
> TEST: ping out, vrf device+address bind - ns-B loopback IPv6                  [ OK ]
> TEST: ping out, vrf device+address bind - ns-B IPv6 LLA                       [FAIL]
> TEST: ping in - ns-A IPv6                                                     [ OK ]
> [...]
> Tests passed: 887
> Tests failed:   1
> [root@host net]#

This test also fails on -net. The problem is specific to ping sockets
(same test passes with raw sockets). I believe this test has always
failed since fcnal-test.sh started using net.ipv4.ping_group_range
(commit e71b7f1f44d3 ("selftests: add ping test with ping_group_range
tuned")).

The executed command is:

ip netns exec ns-A ip vrf exec red /usr/bin/ping6 -c1 -w1 -I 2001:db8:3::1 fe80::a846:b5ff:fe4c:da4e%eth1

So ping6 is executed inside VRF 'red' and sets .sin6_scope_id to 'eth1'
(which is a slave device of VRF 'red'). Therefore, we have
sk->sk_bound_dev_if == 'red' and .sin6_scope_id == 'eth1'. This fails
because ping_v6_sendmsg() expects them to be equal:

static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
{
...
                if (__ipv6_addr_needs_scope_id(ipv6_addr_type(daddr)))
                        oif = u->sin6_scope_id;
...
        if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
            (addr_type & IPV6_ADDR_MAPPED) ||
            (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if)) <-- oif='eth1', but ->sk_bound_dev_if='red'
                return -EINVAL;
...
}

I believe this condition should be relaxed to allow the case where
->sk_bound_dev_if is oif's master device (and maybe there are other
VRF cases to also consider).

