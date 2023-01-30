Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB66809AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 10:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjA3JiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjA3Jhu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 04:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07734305DF
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 01:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675071369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZuPrOqnF+C8depmt/jN3f7zksAKoJMpdivybnIZgog=;
        b=VegCrLD2Fg0HBfjL5S70y49OW8TrCvijQAAeZZ+1wV9FPZyb7htZBs1dIBvDQnReU4nDIk
        0GqGT4cSEjr3tCjRsQ4fHgxgquaJoDr14OyfeeBx7v8bjnq/Gptj5u2YLs8Z/qK0UFA/yT
        lW8F/2uUUy5mna5gXY2JrnBybgDXXM0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-6txCo_YAMHOXiDCCLPaPfg-1; Mon, 30 Jan 2023 04:25:40 -0500
X-MC-Unique: 6txCo_YAMHOXiDCCLPaPfg-1
Received: by mail-qt1-f198.google.com with SMTP id z12-20020ac8710c000000b003b829a0eda2so2867353qto.21
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 01:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZuPrOqnF+C8depmt/jN3f7zksAKoJMpdivybnIZgog=;
        b=4DcjCcJCKgSrP2dCvI62qCDb4sfTSWz4NYWY97m9yAtz3/wZhLgcNCJMgcXsfftn4e
         Ex8gpGGQueg3xvsn2kkI6GhS3NlvEVYczsrj1q1IKRwSAZW7NptzmL/25BMjWHGN9T5V
         dhhrkuwHVzzcKi+VwdqZumeHT1lFiKcNjwKynh3cCOJj0+HK1TFnI4wXe+QlEcZH1XEA
         HzA6iME7R2DBM0s64xldH3b/o5w2f4cPO+QG3MwwIsb93Jftbg3fBpoj3U6tNpwuHS19
         hxQJjNL1dwFtglAo4Td0UNifi1WYE1zb6ApuzjFx4okjHYgHLdb/lJ9CSwZG/xwvEYBV
         KkCg==
X-Gm-Message-State: AO0yUKXuiDBilby4lDjea7WZbs6jRYckSoee78aez6TZukMTYxZxPIi2
        NtC4eRZ9A6K4DXI1MVbi5T299yCS9TzDwYEXrBsJkLQPftrUGcS0Rf9T9ghaLfwa6je8pMQqFq6
        dKfYf4kFz2qbabPYp4TxTQNXURhVx
X-Received: by 2002:a05:622a:181d:b0:3b8:2e8b:d8af with SMTP id t29-20020a05622a181d00b003b82e8bd8afmr15551769qtc.55.1675070739709;
        Mon, 30 Jan 2023 01:25:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+sOy41UT/ZDZMZ+wD1t8Z2kvoWXElgYvFvcoYAAmKffuSNPDnxwXj7d39+hiX6c43hfutP+w==
X-Received: by 2002:a05:622a:181d:b0:3b8:2e8b:d8af with SMTP id t29-20020a05622a181d00b003b82e8bd8afmr15551748qtc.55.1675070739417;
        Mon, 30 Jan 2023 01:25:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id em7-20020a05622a438700b003b646123691sm7596192qtb.31.2023.01.30.01.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:25:38 -0800 (PST)
Message-ID: <6758c48d926845ae323a68fb4649fb982e2321c4.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/3] net: introduce rps_default_mask
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Mon, 30 Jan 2023 10:25:34 +0100
In-Reply-To: <20201104114226.250a4e85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1604055792.git.pabeni@redhat.com>
                <20201102145447.0074f272@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
         <86c37d881a93d5690faf20de3bccceca1493fd74.camel@redhat.com>
            <20201103085245.3397defa@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
         <79c58e6cf23196b73887b20802daebd59fe89476.camel@redhat.com>
         <20201104114226.250a4e85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

On Wed, 2020-11-04 at 12:42 -0700, Jakub Kicinski wrote:
> On Wed, 04 Nov 2020 18:36:08 +0100 Paolo Abeni wrote:
> > On Tue, 2020-11-03 at 08:52 -0800, Jakub Kicinski wrote:
> > > On Tue, 03 Nov 2020 16:22:07 +0100 Paolo Abeni wrote: =20
> > > > The relevant use case is an host running containers (with the relat=
ed
> > > > orchestration tools) in a RT environment. Virtual devices (veths, o=
vs
> > > > ports, etc.) are created by the orchestration tools at run-time.
> > > > Critical processes are allowed to send packets/generate outgoing
> > > > network traffic - but any interrupt is moved away from the related
> > > > cores, so that usual incoming network traffic processing does not
> > > > happen there.
> > > >=20
> > > > Still an xmit operation on a virtual devices may be transmitted via=
 ovs
> > > > or veth, with the relevant forwarding operation happening in a soft=
irq
> > > > on the same CPU originating the packet.=20
> > > >=20
> > > > RPS is configured (even) on such virtual devices to move away the
> > > > forwarding from the relevant CPUs.
> > > >=20
> > > > As Saeed noted, such configuration could be possibly performed via =
some
> > > > user-space daemon monitoring network devices and network namespaces
> > > > creation. That will be anyway prone to some race: the orchestation =
tool
> > > > may create and enable the netns and virtual devices before the daem=
on
> > > > has properly set the RPS mask.
> > > >=20
> > > > In the latter scenario some packet forwarding could still slip in t=
he
> > > > relevant CPU, causing measurable latency. In all non RT scenarios t=
he
> > > > above will be likely irrelevant, but in the RT context that is not
> > > > acceptable - e.g. it causes in real environments latency above the
> > > > defined limits, while the proposed patches avoid the issue.
> > > >=20
> > > > Do you see any other simple way to avoid the above race?
> > > >=20
> > > > Please let me know if the above answers your doubts, =20
> > >=20
> > > Thanks, that makes it clearer now.
> > >=20
> > > Depending on how RT-aware your container management is it may or may =
not
> > > be the right place to configure this, as it creates the veth interfac=
e.
> > > Presumably it's the container management which does the placement of
> > > the tasks to cores, why is it not setting other attributes, like RPS?=
 =20
> >=20
> > The container orchestration is quite complex, and I'm unsure isolation
> > and networking configuration are performed (or can be performed) by the
> > same precess (without an heavy refactor).
> >=20
> > On the flip hand, the global rps mask knob looked quite
> > straightforward to me.
>=20
> I understand, but I can't shake the feeling this is a hack.
>=20
> Whatever sets the CPU isolation should take care of the RPS settings.

Let me try for a moment to revive this old thread.

Tha series proposed a new sysctl know to implement a global/default rps
mask applying to all the network devices as a way to simplify some RT
setups. It has been rejected as the required task is doable in user-
space.

Currently the orchestration infrastructure does that, setting the per
device, per queue rps mask and CPU isolation.

The above leads to a side problem: when there are lot of netns/devices
with several queues, even a reasonably optimized user-space solution
takes a relevant amount of time to traverse the relevant sysfs dirs and
do I/O on them. Overall the additional time required is very
measurable, easily ranging in seconds.

The default_rps_mask would basically kill that overhead.

Is the above a suitable use case?

Thanks,

Paolo

