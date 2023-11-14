Return-Path: <linux-kselftest+bounces-80-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC077EAE8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 12:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C511C20AAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB621359;
	Tue, 14 Nov 2023 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDvTY3QQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FEC8C8
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 11:02:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE40D9
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 03:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699959724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUXsqelsJNnZOHo6MdSK7uiOyKZzzRr8zAhoL0nUXLU=;
	b=QDvTY3QQ/RrnRkXs2FwLAkQ0idnzMf1/MN7c/ywbdJZNNPNESnqlqROAM0Ewe5JgH/FIBS
	whxq2skJnl1PhnUvt2YuMEbyEMu+uBL8n9i/r3nXk0eiJCnlUC70+X2YtRTE2wCJSrxpUJ
	loK/F2BwNdXun+76XjxvrhmSDOFqalE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-v89gcR45OaOT0TJRM8xDaw-1; Tue, 14 Nov 2023 06:02:03 -0500
X-MC-Unique: v89gcR45OaOT0TJRM8xDaw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9dd4e40349bso84807066b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 03:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699959722; x=1700564522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUXsqelsJNnZOHo6MdSK7uiOyKZzzRr8zAhoL0nUXLU=;
        b=WMAgerF+iaIor1tVhLUYd3JQ6wELtVh7aivUEf8KicscRtFKfV8yLbF7FSh6Zjo7Wo
         JQVteF9Pcs6rgix+ouNMaKyqnD/1/nPTkfBvwT5gZLn4KBUw3d3rMt7AbXrv7Ky90qlT
         Ej1mY5yH79oPS8BnCl0xWPIo5zjM2TZQ+SfWzWMmgQJXj20Kuq/Dn9V4x6x711csbuhQ
         7CAUgsda73P0X59G8Oz7pV2SMkFXl7H4weXYZ4Gjz3rjdvIApE6Xp7pSdOIlnNXkUIIo
         0L0rBexjqn4ofrWwdr8EhFhKMrS4wFlL/GTaDr9Bqhn8MkCcduUvYx3mfeAMN2zMEW79
         isJw==
X-Gm-Message-State: AOJu0YyD914iUMym0Jk/30fxywwV4oG4CRJkWk9u/e1WChvEm9T9uy8B
	Ens1KocKAyTf5XSe6OfyRFCRaCFMkJyVQAvc58hOjvFkcD0eGha/dVse55kttfaV7pHVTQmQF4O
	gv13zNULakV4Yzsx5QSH2y1rYyYWM
X-Received: by 2002:a05:6402:2786:b0:547:b96:1167 with SMTP id b6-20020a056402278600b005470b961167mr1122027ede.2.1699959722269;
        Tue, 14 Nov 2023 03:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFHMgdmzKm6u+j43lw90y5XxQWJUYQMEgEe5IhluAOT9S8xu6IGYYWZ4wZIlqFR2zsdh9FRw==
X-Received: by 2002:a05:6402:2786:b0:547:b96:1167 with SMTP id b6-20020a056402278600b005470b961167mr1122008ede.2.1699959721932;
        Tue, 14 Nov 2023 03:02:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-91.dyn.eolo.it. [146.241.230.91])
        by smtp.gmail.com with ESMTPSA id c70-20020a509fcc000000b00536ad96f867sm5045067edf.11.2023.11.14.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:02:01 -0800 (PST)
Message-ID: <7b2d70645fecf83f30d71c44ae0071da1b3be67c.camel@redhat.com>
Subject: Re: [Discuss] Seeking advice on net selftests netns naming method
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, 
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>, 
 Guillaume Nault <gnault@redhat.com>
Date: Tue, 14 Nov 2023 12:02:00 +0100
In-Reply-To: <ZVND+e6RKLFudYQA@Laptop-X1>
References: <ZVND+e6RKLFudYQA@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-14 at 17:55 +0800, Hangbin Liu wrote:
> Good day! Following Guillaume's suggestion, I've been working on updating=
 all
> net self-tests to run in their respective netns. This modification allows=
 us
> to execute all tests in parallel, potentially saving a significant amount=
 of
> test time.
>=20
> However, I've encountered a challenge while making these modifications. T=
he
> net selftest folder contains around 80 tests (excluding the forwarding te=
st),
> with some tests using common netns names and others using self-defined na=
mes.
> I've considered two methods to address this issue:
>=20
> One approach is to retain the original names but append a unique suffix u=
sing
> $(mktemp -u XXXXXX). While this is a straightforward solution, it may not
> prevent future tests from using common names.
>=20
> Another option is to establish a general netns lib. Similar to the NUM_NE=
TIFS
> variable in the forwarding test, we could introduce a variable like NUM_N=
S.
> This variable would define the number of netns instances, and all tests w=
ould
> use the netns lib to set up and clean up netns accordingly. However, this
> approach might complicate test debugging, especially for tests like
> fib_nexthops.sh, which relies on clear and visually netns names
> (e.g., me/peer/remote).

I personally would like sort of both :) e.g. lib function(s) to
automatically create and dispose netns, and retain a script-
specific/related name prefix.=C2=A0

The library function could optionally set  the newly created namespaces
name in global variables provided by the caller, e.g.:

# create 3 namespaces:
netns_init 3=20

# create 3 namespaces and set the global variables:
# $remote, $local $me=C2=A0
# to their respective names
netns_init 3 remote local me

The trick to do such assignment would be using the 'eval' statement,
something alike

netns_init()
{
	# create the netns

	shift
	while [ -n "$1" ]; do
		eval $1=3D$NETNS_NAMES[0]
		shift
	done
}

While at that, it would be useful to package some common helper e.g. to
wait for a (tcp) listener to be created (available) on a given port.

WDYT?

Thanks!

Paolo


