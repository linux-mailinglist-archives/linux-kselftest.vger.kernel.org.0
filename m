Return-Path: <linux-kselftest+bounces-11547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A8E901DF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 11:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841BD1F22828
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3574054;
	Mon, 10 Jun 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F79GrgXI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF92335A7
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011253; cv=none; b=NIliGv1GVvv6J2ZlthlbVVctb2fhVTuh/kKRjgO8rLaOjg4d8MRvBTUTv2uG1A1atxa8PBwOVIJstB+JIjjT9bd/06VCg2UkleGt6JgJ07NQP/ugoXKR7z0EAbJkefg7tpYcR2Ev2G8EjdJSNuvymAqYV9suOcuUsMuXRBWzIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011253; c=relaxed/simple;
	bh=Xv/dEiCRkSpodmaL2d//ZO1u0bmo9WpTjN01UGyMVF0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSxfAGZV7Mk1q9TB3SDz2cepXupTIPwuCMBYwgzNzVY05e7RKq0Al8bzzNFZBamIOc8JvWHn6Bj9ZBjpHNlk47MpP9gvc8fO3Wli90SF1WQQoj5YkZSl/nhHfnFKpWaEcKCaMR2zPyfMu7kHJIBdK8cZGDpL2DictzGpWTQoy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F79GrgXI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
	b=F79GrgXIboyumavs4OktKj/EXLJydCCpWHRRADW6QGNKs6Mpz+q+ZDdpaHSgS0a43/OuM4
	y7KGnPmWgYNzaBvKDLrPjg5XN4iXPsQegXPHMk7XflUYmu63rERySs3PDAbpNJ5BY72C4d
	0/feck1Y3zMBFdPgV6j2UusTIFiTdIU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rN5hOhSAOaWOOmCReYtyeA-1; Mon, 10 Jun 2024 05:20:49 -0400
X-MC-Unique: rN5hOhSAOaWOOmCReYtyeA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-62a0841402aso69701777b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011249; x=1718616049;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
        b=lcKMpzfkU+dIGd4iBFkPRVZgxeRvFDozT6lGbnitvU5EbGFDyOu+i6N8uwHrQtFFnb
         VpKMUmR00Wpo5jFYBAf4BBypzti+iv6rMKNXVU8h2v8P9+N0RpHLNANLlEl0dNvAaPGq
         hKDtvw6uZmyQUPbfWG5oalhQUzECprv2fZSEhvNXykv2DCC+1AUqRKPYoeyv0J05YUS9
         7SgSSivg4G8oOJ/2fGQRUyj0Qc8cdIqjMNviVSsQQgNYPEihA0M4+xwNXaFXxMo2YRXU
         owZ9/WimSjadzxNobb2DicxdxuVPK/2ANnq+0oIEC2ROUFtjm0DJitUjXoRiIf9Tmiys
         f+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWb9nHugp4LkLA/JhXW7tfvA/ovQLkVIU7l5wh2OAV1TxUE6E0mSvpm3zIt04lMf8ICd/lamW5zqjdLZRbkTd+gaT3FAT8j6G+UU4IeSxSM
X-Gm-Message-State: AOJu0Yym2GRYfN8IWOTRUUNjJkrotWeDfMMkDFYUt/5jGDZO+g6q9zsb
	prAI9zM8B4+d4keJ1FPvoXTVZH/H7U4HxYKAa/WKybDKqfhjXgkyjlR0fQ/wXAGgNQlHOAP/IYc
	3LpigbGdY3T2UpsrZwopMn4ozq6J/bVChs0EVU4yunW7DQMQgLPKRtol/5B+yzdQD3Tk4+1RUwT
	i8FBivlLNZVGkwpSFYALn9zRC6fv3/u0OqLRu1uQKW
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id 00721157ae682-62cd56a9f69mr80025647b3.47.1718011248850;
        Mon, 10 Jun 2024 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFjnKBptFBgLEV5bzktHbMReA8zI8OX4PPVkODmioQ2wqMk8XLBtAg+pDd9bzT3M9lgzkU0g8BWKSGH4IH14Q=
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id
 00721157ae682-62cd56a9f69mr80025547b3.47.1718011248570; Mon, 10 Jun 2024
 02:20:48 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jun 2024 05:20:47 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <20240605194314.GX791188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605194314.GX791188@kernel.org>
Date: Mon, 10 Jun 2024 05:20:47 -0400
Message-ID: <CAG=2xmMgEUVwhqSFV5uXe_HuXeMaN7kDPW5TpmcihHYe0seo+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:43:14PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:43PM +0200, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > In order to also test simultaneous sFlow and psample actions and
> > packet truncation, add missing parsing support for "userspace" and
> > "trunc" actions.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> ...
>
> > @@ -803,6 +819,25 @@ class ovsactions(nla):
> >                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
> >                  parsed = True
> >
> > +            elif parse_starts_block(actstr, "userspace(", False):
> > +                uact = self.userspace()
> > +                actstr = uact.parse(actstr[len("userpsace(") : ])
>
> nit: userspace
>
>      Flagged by checkpatch.pl --codespell
>

Thanks. Will fix it.

> > +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> > +                parsed = True
> > +
> > +            elif parse_starts_block(actstr, "trunc", False):
> > +                parencount += 1
> > +                actstr, val = parse_extract_field(
> > +                    actstr,
> > +                    "trunc(",
> > +                    r"([0-9]+)",
> > +                    int,
> > +                    False,
> > +                    None,
> > +                )
> > +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> > +                parsed = True
> > +
> >              actstr = actstr[strspn(actstr, ", ") :]
> >              while parencount > 0:
> >                  parencount -= 1
>


