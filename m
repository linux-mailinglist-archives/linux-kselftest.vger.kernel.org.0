Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B577244C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjFFNrf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFFNre (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A510C0
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686059218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptXauuCBD1PCG9ib1NA3tuS4we6SP4trE10C7/jO/rU=;
        b=i6ZudmSQBfnWO44QyjRRw3R6/M9n58jaCGJCLLoXqesS1Z76lusQjz/1dfIeFASYswDL96
        UJxyy6KCYV2QZHigrCFDG/v2UkTXeBIcobpPsSLzPkNAci28KSdprcLLZU+wQCUkhk1NqY
        pso/SER+I5FJQfjgOJQt8bY4n81gTcA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-xJqwc264ObC0u1iH2d2wAQ-1; Tue, 06 Jun 2023 09:46:56 -0400
X-MC-Unique: xJqwc264ObC0u1iH2d2wAQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f6038dc351so26503115e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 06:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059215; x=1688651215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptXauuCBD1PCG9ib1NA3tuS4we6SP4trE10C7/jO/rU=;
        b=T+XqpNMHRQ/sSDcHah48loGBUBWbUgN6kIVP2TffMPsLOUjfU01v18nf12OP5Mh2dr
         MJjrPWSVghmktF8jpWLtaJHivOJbk2qRF72DgfJHmKeWAihSN/THLZ+CA5HlkevHEyhN
         0DTIp2tal/VU3bOMfIqks2T0/x+u1vH50SDXKGXoekO/GAWJSXYQJofpVnH1X9Sgl/k7
         pYf2yp69bKs0k2vcdfUES+tAZIMYmm4QmWfdtglRUrvEWCp5zahnxU/YnAWM2BxgaNY0
         rXMWoYlkD32oPlZ7ika83PB3iQgpftnb9LN4vUNNm/ugFfS8l+u3+AnFdHl3IGzBDnea
         TFgw==
X-Gm-Message-State: AC+VfDw0cPa91ZO/vZ89GBY19tosamcLGgoFOQakUaXKU+8BflS+tPAF
        7oRrwOqYqfNfl/IbJrRija9QUBgZX/dpDTLwvMdBjO4ojqKGI8TETPZD00FLj5GdCf2uvODGh3R
        f5rZm9/Don4NGWZv77nBiv6HzElcn
X-Received: by 2002:a05:600c:210:b0:3f7:2d7d:c673 with SMTP id 16-20020a05600c021000b003f72d7dc673mr2418140wmi.14.1686059215080;
        Tue, 06 Jun 2023 06:46:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y42arS3sf+JMJGfQY8U+MTu6mCEmQV2avTDbCSIXEM+noeWVrgY9hMz5LISuQwGh0nAEYYA==
X-Received: by 2002:a05:600c:210:b0:3f7:2d7d:c673 with SMTP id 16-20020a05600c021000b003f72d7dc673mr2418122wmi.14.1686059214733;
        Tue, 06 Jun 2023 06:46:54 -0700 (PDT)
Received: from debian (2a01cb058d652b00fa0f162c47a2f35b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:fa0f:162c:47a2:f35b])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b0030e5482bd8esm251173wrt.90.2023.06.06.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:46:54 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:46:52 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL] in vrf "bind -
 ns-B IPv6 LLA" test
Message-ID: <ZH84zGEODT97TEXG@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 08:24:54AM +0200, Mirsad Goran Todorovac wrote:
> On 5/31/23 20:11, Guillaume Nault wrote:
> > I believe this condition should be relaxed to allow the case where
> > ->sk_bound_dev_if is oif's master device (and maybe there are other
> > VRF cases to also consider).
> 
> I've tried something like this, but something makes the kernel stuck
> here:
> 
> TEST: ping out, blocked by route - ns-B loopback IPv6                         [ OK ]
> TEST: ping out, device bind, blocked by route - ns-B loopback IPv6            [ OK ]
> TEST: ping in, blocked by route - ns-A loopback IPv6                          [ OK ]
> TEST: ping out, unreachable route - ns-B loopback IPv6                        [ OK ]
> TEST: ping out, device bind, unreachable route - ns-B loopback IPv6           [ OK ]
> 
> #################################################################
> With VRF
> 
> [hanged process and kernel won't shutdown]
> 
> The code is:
> 
> ---
>  net/ipv6/ping.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index c4835dbdfcff..81293e902293 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -73,6 +73,9 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         struct rt6_info *rt;
>         struct pingfakehdr pfh;
>         struct ipcm6_cookie ipc6;
> +       struct net *net = sock_net(sk);
> +       struct net_device *dev = NULL;
> +       struct net_device *mdev = NULL;
>         err = ping_common_sendmsg(AF_INET6, msg, len, &user_icmph,
>                                   sizeof(user_icmph));
> @@ -111,10 +114,17 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         else if (!oif)
>                 oif = np->ucast_oif;
> +       if (oif) {
> +               dev = dev_get_by_index(net, oif);
> +               mdev = netdev_master_upper_dev_get(dev);
> +       }
> +
>         addr_type = ipv6_addr_type(daddr);
>         if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
>             (addr_type & IPV6_ADDR_MAPPED) ||
> -           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
> +           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
> +                   !(mdev && sk->sk_bound_dev_if &&
> +                             mdev != dev_get_by_index(net, sk->sk_bound_dev_if))))
>                 return -EINVAL;
>         ipcm6_init_sk(&ipc6, np);
> 
> I am obviously doing something very stupid.

The problem is that dev_get_by_index() holds a reference on 'dev' which
your code never releases. Also netdev_master_upper_dev_get() needs rtnl
protection. These should have generated some kernel oops.

You can try this instead:

-------- >8 --------

diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index c4835dbdfcff..f804c11e2146 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -114,7 +114,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	addr_type = ipv6_addr_type(daddr);
 	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
 	    (addr_type & IPV6_ADDR_MAPPED) ||
-	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
+	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
+	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, np);

