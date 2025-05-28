Return-Path: <linux-kselftest+bounces-33924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F4AC65F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBFD4E08EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C9276049;
	Wed, 28 May 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFc33oKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4412033A
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424541; cv=none; b=dvOEcSyBML1pNjL3UVNtC9kXFnDyukuy0c2+THqLt4rXl3wAv4ER7QYJo+rW2tjKnzUzk8266sa+Uw1Z5mdqpLz/0zcKWrUsKATQ2vMldge1QeQVnYelaIsACh5oL5UOHiKPNqn0frqpTiFW2Bi27/QJTLzvt2rYcgGEBkuk2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424541; c=relaxed/simple;
	bh=RVRBM0RuYVyvhcotX52kpZx1R8EMcidpMsxxq8Rgg5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qnLu/n75WgXLDv72yc7e/ot5WTZ6os9YmHWS8jIeAFXe6oY4reIcclCRlySIvvAz0mCM0GME2CCuGM9kfB+3+pD+3Rx4CHs3dZtIepmhEvlfGj/IWeUHZQss7IbLj4cWbWmuHnmygVTUuaC7BBQjZYLh0CiS0PmW0YsfZPVwfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFc33oKl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748424539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVRBM0RuYVyvhcotX52kpZx1R8EMcidpMsxxq8Rgg5k=;
	b=YFc33oKl38kF6sNf2bfN3WbAT3OSGsJwv+aGJhNQvpyQdgI6R4lF1xhCUr46qc2WAEEPsL
	GyS43gQ6y7UJxmPiqK3sSFP3vdqE+Dk6UYfUhbQ2QMadC4E25tDB8CVB3eXN3xMighO2y1
	bkjEXhbUJ9gmK8izShEAyM6NO3uIyTs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-moFC_4tdPY6LvI0bpXPGOA-1; Wed, 28 May 2025 05:28:58 -0400
X-MC-Unique: moFC_4tdPY6LvI0bpXPGOA-1
X-Mimecast-MFC-AGG-ID: moFC_4tdPY6LvI0bpXPGOA_1748424536
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5532a2d970fso794281e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748424536; x=1749029336;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVRBM0RuYVyvhcotX52kpZx1R8EMcidpMsxxq8Rgg5k=;
        b=wWYSTcE/ufE6XnRK4tToXDWtHFmt99gIi75pKVp6jCcrgsxkw2OnW3naiUrcKF7qaO
         jDsZH3KfCN/3lPOOcl54NY0QRVcbYRy+ji5jiZhXZ4HD3la8Kgg5EgTr8hmKUWrAcZjL
         9qgPFEo4aaFj8T7WTE/NKF4ArpTB/UyzqbJp9qFOJ/BHxCckwNcK0AHeGe4KtAFh2wNy
         nqLGTw9kM21xSU9VlnFX//iceNTei+07f0XGciDHsIcmqn85BuBpgiblJkmjy2Gdecl9
         MM9GIylC6QD3VeP8S3M4eOFLZG4aVZNn0hAzMeaHFGTZWYS43JQZSUIUGEqLduft88oL
         v6wg==
X-Forwarded-Encrypted: i=1; AJvYcCUECySY5SvXmIVsUot3X8ghSZT/CSbQPtATj0QqS15qx8dx+Cg0jAxcieLf7R3FH2nVlcMEvN0jcmg8lc60drc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawttXVx52yRRcdHxUNpQCGPlWNmXWCkmmIoQCi/QKAf3OjTsN
	ZqaWqJgKd2pywPBsQkKiIupADf2wWcsWlMhSGOuLO9zpACeu2f74KjMOa6Gxb8G0C2CmsBSDAew
	JMvoKMI7mlX/fFyw8rbmYXAZmSupn6iKFtM5isbdbezY70m4o3Hwp5cmaLJuZlMoCJViisQ==
X-Gm-Gg: ASbGncvZSguEiob/719J1S3OaZC20hgqKPcuprsf1IJ881+AQRwv06GpTwfYFMDqZOY
	miV9O0e0fgCMRhTJSaunzIyOpOJ9N12ItP46F8vAD7xWrnolE0bbDRDbDPoybnLlWC+Hsbi2Ey3
	84S8gs00qrJp+xVY8X56tsgWeSNxUQDVIsZW0UuFXGR/pRidKed1Vnui3jXgtcaoJO6Ij5dlbf4
	mo6LoZfTJmIDnhNa0UHZkL9mt1hKx9YHqlwlU3+HEebotZf6vd9pQHqvowzBsYbCkoeOsnL2Prv
	LtOYXnRf
X-Received: by 2002:a05:6512:3b24:b0:553:2ca4:39e2 with SMTP id 2adb3069b0e04-5532ca43ae5mr1082636e87.52.1748424536316;
        Wed, 28 May 2025 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERtNwL1FkFyF5XJrwQ/6eIIimnsdoqLDXrIrCZO1fju6zFy9XmVXSsHiIUEFU+SKOJJmRqCA==
X-Received: by 2002:a05:6512:3b24:b0:553:2ca4:39e2 with SMTP id 2adb3069b0e04-5532ca43ae5mr1082627e87.52.1748424535858;
        Wed, 28 May 2025 02:28:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532f6b3f0esm199717e87.221.2025.05.28.02.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:28:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 358001AA8877; Wed, 28 May 2025 11:28:54 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool
 benchmark
In-Reply-To: <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk>
 <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 May 2025 11:28:54 +0200
Message-ID: <87h615m6cp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Mon, May 26, 2025 at 5:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>> > Fast path results:
>> > no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
>> >
>> > ptr_ring results:
>> > no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
>> >
>> > slow path results:
>> > no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
>> > ```
>> >
>> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
>> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > Cc: Jakub Kicinski <kuba@kernel.org>
>> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>> >
>> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>>
>> Back when you posted the first RFC, Jesper and I chatted about ways to
>> avoid the ugly "load module and read the output from dmesg" interface to
>> the test.
>>
>
> I agree the existing interface is ugly.
>
>> One idea we came up with was to make the module include only the "inner"
>> functions for the benchmark, and expose those to BPF as kfuncs. Then the
>> test runner can be a BPF program that runs the tests, collects the data
>> and passes it to userspace via maps or a ringbuffer or something. That's
>> a nicer and more customisable interface than the printk output. And if
>> they're small enough, maybe we could even include the functions into the
>> page_pool code itself, instead of in a separate benchmark module?
>>
>> WDYT of that idea? :)
>
> ...but this sounds like an enormous amount of effort, for something
> that is a bit ugly but isn't THAT bad. Especially for me, I'm not that
> much of an expert that I know how to implement what you're referring
> to off the top of my head. I normally am open to spending time but
> this is not that high on my todolist and I have limited bandwidth to
> resolve this :(
>
> I also feel that this is something that could be improved post merge.
> I think it's very beneficial to have this merged in some form that can
> be improved later. Byungchul is making a lot of changes to these mm
> things and it would be nice to have an easy way to run the benchmark
> in tree and maybe even get automated results from nipa. If we could
> agree on mvp that is appropriate to merge without too much scope creep
> that would be ideal from my side at least.

Right, fair. I guess we can merge it as-is, and then investigate whether
we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)

-Toke


