Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE572455F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjFFOMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFFOMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E80E139
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686060688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fw9T5rxLrJVKHG27fIjocIY1CyjQERL7+8LiZXQNd7E=;
        b=T6kEkJo7M7K6+ERM990+riMYZU8QiIuLLv33HPUuqtQkqXIcrNcnz8n8YxIOPiM75ILA7a
        3wL9VDhRoau9qkGRlTrxJ1/vwSG0uAxG64WzqVwqUegOoqR6ges3IskXpJvzOSgckcPxKO
        WEeg+Xc6wjuq+wmQdImQNLiAAMUf5mo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-UoeWHc28NqKa0mwh3w3rUw-1; Tue, 06 Jun 2023 10:11:27 -0400
X-MC-Unique: UoeWHc28NqKa0mwh3w3rUw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7678c74beso14908505e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 07:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060686; x=1688652686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw9T5rxLrJVKHG27fIjocIY1CyjQERL7+8LiZXQNd7E=;
        b=lR3fFlDj6IV/LHaE3RCd/2R/PrbSFdWjAUprInt4XcJtVKwKGXb8iDC/kb9KntG1CY
         nmiMtkqPnAlsXEoJILTj19xd5hMhsVm9fpKruXIvBpjR9L2gw+XoIo1IAHAdJEAvt3+3
         wjvkEGsQbsZ9lRV/MmRn03Sl+bdRZwoWmyVWxWyowfmCIxYrgOmT4N0L6jp7ElnEGVl1
         wrIewAVRbp3D7pt3jpGtp2VhtKzEfXpDf3G0wp63AWKDu4TNV9Q/yD6vie4wbAHFRB/b
         rHm17VlqaAVb2D3OBL5JnxeBsqxwJWe3w+7mJ+KUFVGYzssTVGiV9Y/9Smfyx9HS4Xa4
         IY5Q==
X-Gm-Message-State: AC+VfDzm8KeDSpTQG4WZb4yKIiSJMl2/92fiVT4darHx8KT4ZHY2ZZvx
        gYbICQmF0vqrCrId4vetu0CNQQ/5nIa/ZNsjFE4UrX7fGtXH4KrQnOTHLfUozInet11I8q8wGSl
        bOnLvLPyhxf3237YIO8XqT3+Ct+O4
X-Received: by 2002:a1c:7912:0:b0:3f7:33cf:7080 with SMTP id l18-20020a1c7912000000b003f733cf7080mr2254964wme.36.1686060686553;
        Tue, 06 Jun 2023 07:11:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wOLgLIb3XMmyPMrwryL9a1f6reu3dJklYXOBS8ZHG+qjkBneUwt1XyrlPOPxqX+dpQ7I6Tw==
X-Received: by 2002:a1c:7912:0:b0:3f7:33cf:7080 with SMTP id l18-20020a1c7912000000b003f733cf7080mr2254940wme.36.1686060686230;
        Tue, 06 Jun 2023 07:11:26 -0700 (PDT)
Received: from debian (2a01cb058d652b00fa0f162c47a2f35b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:fa0f:162c:47a2:f35b])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f736735424sm9067513wme.43.2023.06.06.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:11:25 -0700 (PDT)
Date:   Tue, 6 Jun 2023 16:11:24 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL] in vrf "bind -
 ns-B IPv6 LLA" test
Message-ID: <ZH8+jLjottBw2zuD@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <60f78eaa-ace7-c27d-8e45-4777ecf3faa2@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60f78eaa-ace7-c27d-8e45-4777ecf3faa2@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 03:57:35PM +0200, Mirsad Todorovac wrote:
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index c4835dbdfcff..c1d81c49b775 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -73,6 +73,10 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         struct rt6_info *rt;
>         struct pingfakehdr pfh;
>         struct ipcm6_cookie ipc6;
> +       struct net *net = sock_net(sk);
> +       struct net_device *dev = NULL;
> +       struct net_device *mdev = NULL;
> +       struct net_device *bdev = NULL;
> 
>         err = ping_common_sendmsg(AF_INET6, msg, len, &user_icmph,
>                                   sizeof(user_icmph));
> @@ -111,10 +115,26 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         else if (!oif)
>                 oif = np->ucast_oif;
> 
> +       if (oif) {
> +               rcu_read_lock();
> +               dev = dev_get_by_index_rcu(net, oif);
> +               rcu_read_unlock();

You can't assume '*dev' is still valid after rcu_read_unlock() unless
you hold a reference on it.

> +               rtnl_lock();
> +               mdev = netdev_master_upper_dev_get(dev);
> +               rtnl_unlock();

Because of that, 'dev' might have already disappeared at the time
netdev_master_upper_dev_get() is called. So it may dereference an
invalid pointer here.

> +       }
> +
> +       if (sk->sk_bound_dev_if) {
> +               rcu_read_lock();
> +               bdev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
> +               rcu_read_unlock();
> +       }
> +
>         addr_type = ipv6_addr_type(daddr);
>         if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
>             (addr_type & IPV6_ADDR_MAPPED) ||
> -           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
> +           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
> +                   !(mdev && sk->sk_bound_dev_if && bdev && mdev == bdev)))
>                 return -EINVAL;
> 
>         ipcm6_init_sk(&ipc6, np);
> 
> However, this works by the test (888 passed) but your two liner is obviously
> better :-)

:)

> Best regards,
> Mirsad
> 
> -- 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu
> 
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> 

