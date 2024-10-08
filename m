Return-Path: <linux-kselftest+bounces-19223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6F994342
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E371F24505
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D917C213;
	Tue,  8 Oct 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g8AJc2iv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04716CD35
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377936; cv=none; b=f3Q62cvd3is0E5gPrroi5cdCAc3/uh5HL2odI+42qBCDIFSLL7UmUW4GggBvd4+54XOtyIMa0Y/X1hezwtpY1lQK/lDGS1R5cMXidoz0Vba4jBBGiZ4zbaxm2mYH6Ij+UTLYKS0n4kI8OKE9uC9svhYfiCrk4+xV1+RyGqmB8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377936; c=relaxed/simple;
	bh=mYq0W3JfnsZ9YHN+okCBI2WA+xEvSuEf2EbiZ6Ovh/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+fnNuRxsiqw2BKqL1zXUBjijZO5oCVckZvA62qUiujNeLCtMxtiY0bT7puyohIi+bWcGncaMVLi3kNfKo9JjWTuliZpwTvI6ne67o7a+rm0Q6FyY44YxPH1sBRX9r2nH/elB83olqSH79pBiI0TMFBk375akI8JQJJqMzOJeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g8AJc2iv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso6543738a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728377932; x=1728982732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjXpaathreNKCP59NrT7WsmFRCx9KxRN96jUPQWsCvw=;
        b=g8AJc2ivQCc1zZfoEOW0b1T7C5ezSeZODPTaGXiLEL0ctjcyirh9ZGaFz+BT/VFmrR
         a6ugorTzq+1PRFSHCNCR6mjmDNUGVZAvBDi93KCoOpvoP5fp3O9LbRBQVUHowRwyoQF6
         BF06nupQI2OXHQ20USPitddrHunARNn/tFogt8tvIfafmwN5ecHD14KQCZxcA6v3dV2S
         Tg4lMZWvx+QzQVwAT83rUsCxbjURIgaw35xkwQ3tyh5KKeCE7hwkRDEfHbRoDIGTfvZ8
         qnw3TG+2j+cLhs3VO8ruM9h+IrUrV/rN0cUb79HFkQrHyEkMbVBub9tbiyLV4uKWiEKe
         45tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377932; x=1728982732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjXpaathreNKCP59NrT7WsmFRCx9KxRN96jUPQWsCvw=;
        b=p6jhHrFNB/hEmB82XEWjw3J1A5lKrVcIZbTAYhxwY7fDzsU7XCrlOcyBi/bCEFCP/m
         H1wmlvH9sMoIenoNcPY/iJ5X8FWFWntcfZnETTv3sv6NF3FSKnFeeDed8Bl5+qBhCqig
         X+/Tv/A0OwkCJ6Y0qFZr9Q/1J6bgiXnzBiiXK58lyMJqA+F3LqG87I4mmKfSbHMKSwHY
         xK/aR9c/SKYMfCO1BNSNkn0s5CeUe3fpL62MqM7ytvCMG3F6Zwia/tqCWuTzBwjhY3Tv
         LfwYbk2m+8xB5dK6moqBWkTvQcF1WD1onT3gNLnWCnaJUDGItP+TrF+obOc1PVvffD+9
         cbig==
X-Forwarded-Encrypted: i=1; AJvYcCVzPVAjG0RcjYv7cviuPIMSvH7SVKPVO0FKitD71slJeFVPEE4yo7tN3AGWpQDl3GaGYbHkN39SLfHb3EtVlPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHtQy8QRcvnvyiy4bFUAJQufNGxYpDG7+WpTJjOBoJ/UKWsEb
	vLJmg4lx3ziyyq9qLOugrSqJ5in3phUj1LyrFhWQhjv7ZYSdxINgLSOaYeX7GrQ=
X-Google-Smtp-Source: AGHT+IEG5w6DR6LJP2zGgeelozQpEvKOlSYsN3e5PMbQ7LfoTwR8Znz5TilKR/exdqgfTVZAFxMJGQ==
X-Received: by 2002:a17:907:9809:b0:a99:3f4e:6de8 with SMTP id a640c23a62f3a-a993f4e6e28mr1083333666b.64.1728377932129;
        Tue, 08 Oct 2024 01:58:52 -0700 (PDT)
Received: from localhost (37-48-49-80.nat.epc.tmcz.cz. [37.48.49.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9958fee567sm214116166b.158.2024.10.08.01.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:58:51 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:58:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sd@queasysnail.net, ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
Message-ID: <ZwT0SkGHu5VHQ9Hd@nanopsycho.orion>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
 <ZwP-_-qawQJIBZnv@nanopsycho.orion>
 <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd952c28-1f17-45da-bd64-48917a7db651@openvpn.net>

Tue, Oct 08, 2024 at 10:01:40AM CEST, antonio@openvpn.net wrote:
>Hi,
>
>On 07/10/24 17:32, Jiri Pirko wrote:
>> Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:
>> 
>> [...]
>> 
>> 
>> > +operations:
>> > +  list:
>> > +    -
>> > +      name: dev-new
>> > +      attribute-set: ovpn
>> > +      flags: [ admin-perm ]
>> > +      doc: Create a new interface of type ovpn
>> > +      do:
>> > +        request:
>> > +          attributes:
>> > +            - ifname
>> > +            - mode
>> > +        reply:
>> > +          attributes:
>> > +            - ifname
>> > +            - ifindex
>> > +    -
>> > +      name: dev-del
>> 
>> Why you expose new and del here in ovn specific generic netlink iface?
>> Why can't you use the exising RTNL api which is used for creation and
>> destruction of other types of devices?
>
>That was my original approach in v1, but it was argued that an ovpn interface
>needs a userspace program to be configured and used in a meaningful way,
>therefore it was decided to concentrate all iface mgmt APIs along with the
>others in the netlink family and to not expose any RTNL ops.

Can you please point me to the message id?


>
>However, recently we decided to add a dellink implementation for better
>integration with network namespaces and to allow the user to wipe a dangling
>interface.

Hmm, one more argument to have symmetric add/del impletentation in RTNL


>
>In the future we are planning to also add the possibility to create a
>"persistent interface", that is an interface created before launching any
>userspace program and that survives when the latter is stopped.
>I can guess this functionality may be better suited for RTNL, but I am not
>sure yet.

That would be quite confusing to have RTNL and genetlink iface to
add/del device. From what you described above, makes more sent to have
it just in RTNL

>
>@Jiri: do you have any particular opinion why we should use RTNL ops and not
>netlink for creating/destroying interfaces? I feel this is mostly a matter of
>taste, but maybe there are technical reasons we should consider.

Well. technically, you can probabaly do both. But it is quite common
that you can add/delete these kind of devices over RTNL. Lots of
examples. People are used to it, aligns with existing flows.

>
>Thanks a lot for your contribution.
>
>Regards,
>
>
>> 
>> 
>> ip link add [link DEV | parentdev NAME] [ name ] NAME
>> 		    [ txqueuelen PACKETS ]
>> 		    [ address LLADDR ]
>> 		    [ broadcast LLADDR ]
>> 		    [ mtu MTU ] [index IDX ]
>> 		    [ numtxqueues QUEUE_COUNT ]
>> 		    [ numrxqueues QUEUE_COUNT ]
>> 		    [ netns { PID | NETNSNAME | NETNSFILE } ]
>> 		    type TYPE [ ARGS ]
>> 
>> ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]
>> 
>> Lots of examples of existing types creation is for example here:
>> https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking
>> 
>> 
>> 
>> > +      attribute-set: ovpn
>> > +      flags: [ admin-perm ]
>> > +      doc: Delete existing interface of type ovpn
>> > +      do:
>> > +        pre: ovpn-nl-pre-doit
>> > +        post: ovpn-nl-post-doit
>> > +        request:
>> > +          attributes:
>> > +            - ifindex
>> 
>> [...]
>
>-- 
>Antonio Quartulli
>OpenVPN Inc.

