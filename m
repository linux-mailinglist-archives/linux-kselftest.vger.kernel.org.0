Return-Path: <linux-kselftest+bounces-19239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26496994C43
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 14:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1A1F23719
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139751DED4B;
	Tue,  8 Oct 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yl2WGF56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BC1DE886
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391948; cv=none; b=Xc1mNgYVTJRMuj57gW2vACu5VSL3s+VPov8RXvBaSDS1Ti/j9tBMEMatRGhIJQlwBMhApjyvin44zk6UIlHUzUrj7qanLubiK+OfGyVEBADem6vcGW6YRQWpeelk88DdFDxPW0TKC8/bgj7tZTL5LtqrH0nKP8jcqsCfbqsaFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391948; c=relaxed/simple;
	bh=JMshcVMusAsqmQZoYah7ZfPoxXpiT1Bsht/XLT2r6z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjF/Zw64wQkus6V1EgldooXMyaWCPL19MS3IWwG+I4P5OsqtZDMeO+ffgU/zeBArjMGZDS6ZX2n+3tH6SS+gxbdAShXoTUcg5RKsN5tvXkkLg/OorGfDmDV1hDMZ1pXAnAN1q6nwxmbekabafh/nuBkXNTJjJY/4KVTWHZHG8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Yl2WGF56; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9953bdc341so282485366b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728391944; x=1728996744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxHs9R/2TfkMyix7gCD8tG/uOFvym8ppDh3PaOKH1vQ=;
        b=Yl2WGF56xVGBRHa7Xn4COs3LcXcIZZjLZm8lgITzt+hDnfNFwmiW/Pf+MMU8DY0nrq
         jf+FvYzcBOlxpfv+UrEvJ2kJHAoR2U7ZGladn2bu11vP7DdUUwqs4Qqd7p+lxZkdfHeK
         NlysMLBWAt9ifq7iLlLIkBbw/vr/nkxO6EFv0RxhQItiXyUgErjdHT+WpR+Ytpx0eKGb
         QpezBiCeoRv7L49TYvjP4iFgHLcfKgoDfgHwvZKB53UlzkMVwkVbGaP0D1omwX9BwWsb
         0ZjIxOAh9JDfvxr/5ZGwXVWUsMOrUlD431MP/MgUtk1T5y6q6j3LLT+cjYSeWebNZ1oE
         jAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391944; x=1728996744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxHs9R/2TfkMyix7gCD8tG/uOFvym8ppDh3PaOKH1vQ=;
        b=ZpqyicXSDtWazwljt7HrhRNg5N62d2m/qKnA9284hT3L3zsIwNFFdUsyb6qf9DhdQz
         PO8D3a/5sTUHpw2WWJhRZVCJdd/Kdtr9SpMvvEXBngC2Skmo6WCkXXDBiICydDIDKwVx
         HA3YQD+tI+AUF8cGBnKcobThi0BOPPwr48uFH4s628j2LVMbn2hT5hpkuo6ZoiQkMzyr
         XCERzCh5kyKclKdKqh3qVeCFZ3ZtMPZLCCHNnQDyVS5QIbkzkzPEnBEQc+Y/lZ+0E3k2
         xS3pF/bQRNiPawM4eu/VhIM53gskDrfwGktsyLZnKSRRW7ndpwC2E1TUnkeaZH8ATKYg
         ZAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX99Tv+1F9kxPiC3mby5C0XcGoCr5YuNJ8zZwLAMK1e6kFfqkHmy1KijZUvj+85K1q620hATdkJ8Vgat5CoLL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9eimoJbEbe9TVBwWxeCN6OUizL7+f0bj8TItbAazv3Bw3t1tJ
	Q174rljttcNfQtzJBVFf6vNlugZPIO1D0tmkj6rTL+NL18hb1FIBJdeJhuzmhFc=
X-Google-Smtp-Source: AGHT+IHanEgNUHcSFgygM+nbbFB/JCZNDfEfGDY4jiCtoGQrZ8QE351YXwlTA5o0pX0acLAotexNWg==
X-Received: by 2002:a17:907:7f2a:b0:a99:5c22:fef6 with SMTP id a640c23a62f3a-a995c22ffdbmr518620066b.1.1728391943907;
        Tue, 08 Oct 2024 05:52:23 -0700 (PDT)
Received: from localhost (37-48-49-80.nat.epc.tmcz.cz. [37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9942c5216fsm407883666b.3.2024.10.08.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:52:22 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:52:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: ryazanov.s.a@gmail.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sd@queasysnail.net
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
Message-ID: <ZwUrAn8xrF2BCrMp@nanopsycho.orion>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
 <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
 <ZwT0SkGHu5VHQ9Hd@nanopsycho.orion>
 <056588a7-de1b-4416-8553-750c8d20dc97@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056588a7-de1b-4416-8553-750c8d20dc97@openvpn.net>

Tue, Oct 08, 2024 at 11:16:01AM CEST, antonio@openvpn.net wrote:
>On 08/10/2024 10:58, Jiri Pirko wrote:
>> Tue, Oct 08, 2024 at 10:01:40AM CEST, antonio@openvpn.net wrote:
>> > Hi,
>> > 
>> > On 07/10/24 17:32, Jiri Pirko wrote:
>> > > Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
>> > > 
>> > > [...]
>> > > 
>> > > 
>> > > > +operations:
>> > > > +  list:
>> > > > +    -
>> > > > +      name: dev-new
>> > > > +      attribute-set: ovpn
>> > > > +      flags: [ admin-perm ]
>> > > > +      doc: Create a new interface of type ovpn
>> > > > +      do:
>> > > > +        request:
>> > > > +          attributes:
>> > > > +            - ifname
>> > > > +            - mode
>> > > > +        reply:
>> > > > +          attributes:
>> > > > +            - ifname
>> > > > +            - ifindex
>> > > > +    -
>> > > > +      name: dev-del
>> > > 
>> > > Why you expose new and del here in ovn specific generic netlink iface?
>> > > Why can't you use the exising RTNL api which is used for creation and
>> > > destruction of other types of devices?
>> > 
>> > That was my original approach in v1, but it was argued that an ovpn interface
>> > needs a userspace program to be configured and used in a meaningful way,
>> > therefore it was decided to concentrate all iface mgmt APIs along with the
>> > others in the netlink family and to not expose any RTNL ops.
>> 
>> Can you please point me to the message id?
>
><CAHNKnsQnHAdxC-XhC9RP-cFp0d-E4YGb+7ie3WymXVL9N-QS6A@mail.gmail.com> from
>Sergey and subsequent replies.
>RTNL vs NL topic starts right after the definition of 'ovpn_link_ops'

Yeah, does not make sense to me. All devices should implement common
rtnl ops, the extra-config, if needed, could be on a separate channel.
I don't find Sergey's argumentation valid.


>
>Recently Kuniyuki commented on this topic as well in:
><20240919055259.17622-1-kuniyu@amazon.com>
>and that is why I added a default dellink implemetation.

Having dellink without newlink implemented is just wrong.


>
>> 
>> 
>> > 
>> > However, recently we decided to add a dellink implementation for better
>> > integration with network namespaces and to allow the user to wipe a dangling
>> > interface.
>> 
>> Hmm, one more argument to have symmetric add/del impletentation in RTNL
>> 
>> 
>> > 
>> > In the future we are planning to also add the possibility to create a
>> > "persistent interface", that is an interface created before launching any
>> > userspace program and that survives when the latter is stopped.
>> > I can guess this functionality may be better suited for RTNL, but I am not
>> > sure yet.
>> 
>> That would be quite confusing to have RTNL and genetlink iface to
>> add/del device. From what you described above, makes more sent to have
>> it just in RTNL
>
>All in all I tend to agree.
>
>> 
>> > 
>> > @Jiri: do you have any particular opinion why we should use RTNL ops and not
>> > netlink for creating/destroying interfaces? I feel this is mostly a matter of
>> > taste, but maybe there are technical reasons we should consider.
>> 
>> Well. technically, you can probabaly do both. But it is quite common
>> that you can add/delete these kind of devices over RTNL. Lots of
>> examples. People are used to it, aligns with existing flows.
>
>The only counterargument I see is the one brought by Sergey: "the ovpn
>interface is not usable after creation, if no openvpn process is running".
>
>However, allowing to create "persistent interfaces" will define a use-case
>for having an ovpn device without any userspace process.
>
>@Sergey what is your opinion here? I am not sure persistent interfaces were
>discussed at the time you brought your point about RTNL vs NL.
>
>
>Regards,
>
>
>> 
>> > 
>> > Thanks a lot for your contribution.
>> > 
>> > Regards,
>> > 
>> > 
>> > > 
>> > > 
>> > > ip link add [link DEV | parentdev NAME] [ name ] NAME
>> > > 		    [ txqueuelen PACKETS ]
>> > > 		    [ address LLADDR ]
>> > > 		    [ broadcast LLADDR ]
>> > > 		    [ mtu MTU ] [index IDX ]
>> > > 		    [ numtxqueues QUEUE_COUNT ]
>> > > 		    [ numrxqueues QUEUE_COUNT ]
>> > > 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
>> > > 		    type TYPE [ ARGS ]
>> > > 
>> > > ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
>> > > 
>> > > Lots of examples of existing types creation is for example here:
>> > > https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
>> > > 
>> > > 
>> > > 
>> > > > +      attribute-set: ovpn
>> > > > +      flags: [ admin-perm ]
>> > > > +      doc: Delete existing interface of type ovpn
>> > > > +      do:
>> > > > +        pre: ovpn-nl-pre-doit
>> > > > +        post: ovpn-nl-post-doit
>> > > > +        request:
>> > > > +          attributes:
>> > > > +            - ifindex
>> > > 
>> > > [...]
>> > 
>> > -- 
>> > Antonio Quartulli
>> > OpenVPN Inc.
>
>-- 
>Antonio Quartulli
>OpenVPN Inc.

