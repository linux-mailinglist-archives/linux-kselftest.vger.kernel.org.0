Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8A3C2770
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGIQYU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 12:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhGIQYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 12:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625847696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCqb8bTRGuT8LGCi+wzELAIbJWNbd2rPSZggl5JyHx0=;
        b=UEEyUab+eGNfPXEQ7Ja2nmf/Z/AV6fyBW2qGqFaD+p4YsN5mSzqyeWrduEGpDM6vQ6Szrv
        CEN+OAcXrjKnhIQgeMhCYRGi6krdXgfz2BiVSBMfzJeNlBTOseWrNtk963IAp4yYnkdXRD
        9bvp7Jf+K2c0hhdKQWsC3owqKhzQ2uU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-vdzo0eytPoqrRC7teUQjdw-1; Fri, 09 Jul 2021 12:21:35 -0400
X-MC-Unique: vdzo0eytPoqrRC7teUQjdw-1
Received: by mail-wr1-f70.google.com with SMTP id u13-20020a5d6dad0000b029012e76845945so3143728wrs.11
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jul 2021 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qCqb8bTRGuT8LGCi+wzELAIbJWNbd2rPSZggl5JyHx0=;
        b=P++O+89Ci5SGg3952XdRhAOS3RMHTcX9M9E8UJhjv0Oee3vq95sERAJWlvHLi8KT3P
         HK7zNDNA0I65x/VHNo8HX2FLWwUq/rRrg2yTYC5yaVaIgYxrOvagvnz+fp8afjCamHA6
         ocSf4ycIhlJYyd/cfQ/vWjVukkhS6gHSTkD5cizFTUEzFTrhChyNKDArUVeYFpMX++Fd
         V8fcP8UuzPqB42fVkQKnqf5EsK2hCWcKk44WeQihU5c9ataegx5kRDUiB2Ekw4JerMTz
         poPBwJeb0Il9O0dtTfv503cJpM40MHQVBCIjN+KIqfysR9o7hrbQkzI8GL5TauklV5gY
         vrwQ==
X-Gm-Message-State: AOAM531CMu4iYjy4xpn4xk2mjVYaGchIuzuLGCbWUT68a5V9Z7yoc38Y
        w0NGB4shV87nCRQgwez7oYjvQuJMYUDzj2EFhQPCDQRkJ+WCo82+YDEu8QIAqGmsOVyMnUYLJ0Q
        hL3ZjvW+fNzafpEZRY6yj4s6/4qhL
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr43466903wrs.170.1625847694132;
        Fri, 09 Jul 2021 09:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye42yT/aBj7wlNzCf44RwRUaVOBD9mUJ/ZZ0FDTF/Ti6W/DoEv+IapeCfhWJ7go9gkzn1itA==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr43466885wrs.170.1625847693993;
        Fri, 09 Jul 2021 09:21:33 -0700 (PDT)
Received: from pc-23.home (2a01cb058d44a7001b6d03f4d258668b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d44:a700:1b6d:3f4:d258:668b])
        by smtp.gmail.com with ESMTPSA id s13sm1600606wrm.13.2021.07.09.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 09:21:33 -0700 (PDT)
Date:   Fri, 9 Jul 2021 18:21:23 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Ido Schimmel <idosch@idosch.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] selftests: forwarding: Test redirecting gre
 or ipip packets to Ethernet
Message-ID: <20210709162123.GB19430@pc-23.home>
References: <cover.1625056665.git.gnault@redhat.com>
 <0a4e63cd3cde3c71cfc422a7f0f5e9bc76c0c1f5.1625056665.git.gnault@redhat.com>
 <YN1Wxm0mOFFhbuTl@shredder>
 <20210701145943.GA3933@pc-32.home>
 <1932a3af-2fdd-229a-e5f5-6b1ef95361e1@gmail.com>
 <20210706190253.GA23236@pc-32.home>
 <391b6a56-b7e0-867c-617e-a05afec50b24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391b6a56-b7e0-867c-617e-a05afec50b24@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 07, 2021 at 07:50:38PM -0600, David Ahern wrote:
> On 7/6/21 1:02 PM, Guillaume Nault wrote:
> > --- a/drivers/net/vxlan.c
> > +++ b/drivers/net/vxlan.c
> > @@ -3767,8 +3767,7 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
> >  		    (conf->flags & (VXLAN_F_RCV_FLAGS | VXLAN_F_IPV6)))
> >  			continue;
> >  
> > -		if ((conf->flags & VXLAN_F_IPV6_LINKLOCAL) &&
> > -		    tmp->cfg.remote_ifindex != conf->remote_ifindex)
> > +		if (tmp->cfg.remote_ifindex != conf->remote_ifindex)
> >  			continue;
> >  
> >  		NL_SET_ERR_MSG(extack,
> 
> Looking at the vxlan driver and that restriction is unnecessary. While
> IPv6 LLA requires a device index, allowing separate LINK attributes is a
> legit use case - as VRF shows.

I believe there's more to do than just my quick hack patch. At least
vxlan_vs_find_vni() probably needs to be modified too. At which point
VXLAN_F_IPV6_LINKLOCAL would become essentially unused and should be
removed.

> Do you want to send a formal patch to fix this one since you have it
> diagnosed?

I'll work on that after net-next reopens. I might try to make bareudp
compatible with VRF too, if time allows. If I get at least VXLAN and
bareudp to work in a multi-VRF setup, then I'll rebase the selftests on
the VRF infrastructure (and just remove the tests for tunnels still
incompatible with this setup).

