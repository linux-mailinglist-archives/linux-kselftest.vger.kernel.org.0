Return-Path: <linux-kselftest+bounces-3695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489C840B9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F7A2867FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47715959A;
	Mon, 29 Jan 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA2z/OYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625E1586D7
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545903; cv=none; b=i82HDOrlceXeMigJ+NeiTLi3ENFjeFbKm/4hEuNShmHwBfSu186WrFNH0rtMOnk4dKorDE+AWohypfAD4RaMQKcLL+rCRb5ol0YdxELV2IdHDJMsrKsIEhO+oU4ItmyEQ/NMNyOEpfl8SokTueM/W70v6rwgmdXGw0XmZI6LHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545903; c=relaxed/simple;
	bh=2BRuyFVgIb5TO9+dXjYlhFBn6zs2JQjXvu4w8oiWPMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRMwjOnNQueeOvevcwHdaUZI7lFEYcEFqDYM/O1EtKnGILqqHV4iiWn591Cvhn8vzq5goWTsitdrGhSGRICQitBzch7zmsAe1b4Ks6gMwXWBQJhn/3b7YHHs7LPiAzgRpa77OvChgc5M9lOVRTLUYBAPnaYs5kEuxQD5W5OepKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA2z/OYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706545901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PrTG93nwnjNZo4an7WIc5B85b9vutnOPs+JSgyzyASE=;
	b=KA2z/OYuNfbgFPHBt8Gl7gsTMnI9fbKMa/CMaVfpgf6kB8C5clJmVzQ/qpITC9AMUdmClv
	1yWhkC9aCBmFK7v2HeCg8iw+vy23YrmjDW2S9OAvRdhIfVs2VR8mRE7J/0NzQEDOStJa+c
	WtCicaSJsJ0SYZ/Hsr1nONnh2Wctoyk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-hCca8zqSMKCCk8YLajPrPg-1; Mon, 29 Jan 2024 11:31:38 -0500
X-MC-Unique: hCca8zqSMKCCk8YLajPrPg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3be75cab163so155344b6e.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 08:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545897; x=1707150697;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrTG93nwnjNZo4an7WIc5B85b9vutnOPs+JSgyzyASE=;
        b=gmR+3qIlHvYGh33WYQQpvMu/Dfo+4UviFkLjeWsRniRDhK2IUHWAhOtOUn0Fv/dpBP
         wX/+M8i3j/arZBHddMzMobCYFZCxP8cAurs3FXGIJaHAZW8ihGGXEeR19i+ozxyCB2ZH
         AeLWhln5WCbLw+8GbIo8b/OW1rykFQ6Pjt9cnPmtFEboucFFpW6VnOso0yb3yTMeSFKX
         Wh9otUrvAahy6bV2GhGowUjFSzLWrmFur+Agzin3WF/wH/JZyS9cUkVzu0CR3WCVMfM/
         UosaUUA7GDGh9WQecXsQbQ/5nC86+moqUpx7lVv+HRBqk23kLOf3rhAbGtVrfun6+T6I
         wgcg==
X-Gm-Message-State: AOJu0YwC7Cl2FNG2/2kNCghMqAHe4NRHPz3hjCrMaQ+ExxbEYlZ7wg1O
	5WAxlTQkazLLTeZTZG8tbj4405REvM86/niVddH+aTII9SmYN7IjWbPMJlO/KSvjnK0xYLwCR8h
	qrHgB+yi4BaPdYhOha3fZjeAJEdBZjVWEs+lStvat8uNl3HwMouUqUrpGA+29PSZtXg==
X-Received: by 2002:a05:6870:3911:b0:218:57b9:ad8f with SMTP id b17-20020a056870391100b0021857b9ad8fmr6937856oap.5.1706545897444;
        Mon, 29 Jan 2024 08:31:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFThX687VxZzjsxhIIg+Ch9y3yZRwFJukTobief8WTlZnd/BqsCAihyBcGhsy1V9KCABPdmYw==
X-Received: by 2002:a05:6870:3911:b0:218:57b9:ad8f with SMTP id b17-20020a056870391100b0021857b9ad8fmr6937828oap.5.1706545897145;
        Mon, 29 Jan 2024 08:31:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-151.dyn.eolo.it. [146.241.230.151])
        by smtp.gmail.com with ESMTPSA id ph29-20020a0562144a5d00b0068c524a70fbsm701463qvb.66.2024.01.29.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:31:36 -0800 (PST)
Message-ID: <d67d7e4a77c8aec7778f378e7a95916c89f52973.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp tests
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>,  Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Date: Mon, 29 Jan 2024 17:31:33 +0100
In-Reply-To: <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
References: 
	<21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
	 <20240126115551.176e3888@kernel.org>
	 <a090936028c28b480cf3f8a66a9c3d924b7fd6ec.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 10:11 +0100, Paolo Abeni wrote:
> On Fri, 2024-01-26 at 11:55 -0800, Jakub Kicinski wrote:
> > On Fri, 26 Jan 2024 16:32:36 +0100 Paolo Abeni wrote:
> > > The big_tcp test-case requires a few kernel knobs currently
> > > not specified in the net selftests config, causing the
> > > following failure:
> > >=20
> > >   # selftests: net: big_tcp.sh
> > >   # Error: Failed to load TC action module.
> > >   # We have an error talking to the kernel
> > > ...
> > >   # Testing for BIG TCP:
> > >   # CLI GSO | GW GRO | GW GSO | SER GRO
> > >   # ./big_tcp.sh: line 107: test: !=3D: unary operator expected
> > > ...
> > >   # on        on       on       on      : [FAIL_on_link1]
> > >=20
> > > Add the missing configs
> > >=20
> > > Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >=20
> > Ah, great, I was missing RF_RAW in the local hack.
> > I applied manually because looks like this change is on top of
> > something:
> >=20
> > patching file tools/testing/selftests/net/config
> > Hunk #3 succeeded at 73 with fuzz 1 (offset -1 lines).
> > Hunk #4 succeeded at 82 (offset -1 lines).
>=20
> Ooops... yes, indeed it's on top of the few patches I sent in the past
> days.
>=20
> > While at it I reordered the values a little bit to be closer to what=
=20
> > I think would get us closer to alphasort. Hope you don't mind.
>=20
> Sure thing I don't mind! I'm sorry for the extra work on you.

Uhm... while the self-test doesn't emit anymore the message related to
the missing modules, it still fails in the CI env and I can't reproduce
the failures in my local env (the same for the gro.sh script).

If I understand correctly, the tests run under double virtualization (a
VM on top AWS?), is that correct? I guess the extra slowdown/overhead
will need more care.

Thanks,

Paolo


