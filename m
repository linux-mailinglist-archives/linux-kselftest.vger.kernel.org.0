Return-Path: <linux-kselftest+bounces-4495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B224850E19
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3211F22616
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9837468;
	Mon, 12 Feb 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S09Tyt5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654016FCC
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723416; cv=none; b=Dd4ATRtIG/z/Udvg8Yiex57G16/12vz38Q1sOLYtiVyBmr2Fy1hyp18Bh4G+E4vtmHDwGdkavHXoq0aO2PFDkpL3B0KTrtErs/M0RZAjMOyz21A+/puvolk1TlMf8r3Bk4ibDFB7END4qQRNGfZHE+4CSJPr1cxUUnUxy7tWt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723416; c=relaxed/simple;
	bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r48HxSEaZakGM1FTrxt7wrJx99T8hHHeKFmq8qTiKCg/wQRT5y/q+tHU9b+ycEYDjhxg2hIwCabZ+h3EITKG+oUJl5yz8vSFVjPsh3rXk4EDNxON3SbwVhyma/C3n1n8w5MghvzmLFW+DoEDQUluxu2JIGg5io2mByuTeOYnY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S09Tyt5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707723413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
	b=S09Tyt5hyrs8unA+fFoOwKHlWrTntvguGdGhiZrUyqPwXHRO/rVJSDXnY5VEP+yptSyUXp
	rP86P5qdPJfFJMoGCzwV0E8OHjdrVFH3BuIxiK8F5RCvIc4I5T3IC9QHwmUWR4MAtmi1+Y
	Re8NzA4TJGkCgGs+4yu1M0DOa5jmnFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-WA9L2dXvPYOEQdWb3GVLSA-1; Mon, 12 Feb 2024 02:36:51 -0500
X-MC-Unique: WA9L2dXvPYOEQdWb3GVLSA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33b244526c3so446857f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Feb 2024 23:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707723410; x=1708328210;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
        b=mYsSBAssuogJcVyCE+tEizfPyXlGo0cFJji89ZMO8eOPqoeLNLqkn7d/EIXHjA1xHY
         Xa198skQggqLH0Nrjd5H6Q+xC4YTkd2yYbHhKeanJO57Wq8aL2wDgRmHYqXkiM2Awdme
         bFnxuWg/AZwublb6Arhj0CSRX/7m4vVsiEELPS482+PoihrZ4uEzA7qCAbt38tZsB4gI
         7m9SfeuihX8VzBeCY9p/HvD3/9hzs07q0WQv3idJIpQeRGy2XKe+as/wVsHK6Gkp0ER9
         FvdfeseA5RqP/bDAX38hyE+7pdSqWyXwQdoKC5YtZVE9epN9eR2Uy4U9ZwUZt5a8HTAi
         jOdA==
X-Forwarded-Encrypted: i=1; AJvYcCWKbntwqtLxseW/YCXX3F8PRwqbYyIMDXiWeyyiYGRgsg2f/0yX8IAoE/CC3vxyZYHjMYAyiYsjmsKTO2bQ+AVXqO4UmK2RSVFoej1eU5iP
X-Gm-Message-State: AOJu0YySQF20h6IKgO3vRvH1ZN2c51E7Gu2Wa2ZiQl0qRgyNobyP+VSr
	R6JJku+ZQT7AoqgiQD/f2hLTShbmfrPffGd/fFMA4yF9UdJ1/xEhL+uQSVH2AXRp1YkxZFwJMe8
	99osZAjymU4OCMyD4AghSqaLoIM7SxOTTSnwIu3DwG7vkvy19mgn8fdADMBgrPUWL3A==
X-Received: by 2002:a05:6000:1f98:b0:33b:4d82:a487 with SMTP id bw24-20020a0560001f9800b0033b4d82a487mr3957069wrb.1.1707723410515;
        Sun, 11 Feb 2024 23:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzdi2myEpIV5pSMye7lXbZ28lafw0b9MPkuCVuHqhvB0hspiilwTyb1gxA9CNHGUdhMqPjPA==
X-Received: by 2002:a05:6000:1f98:b0:33b:4d82:a487 with SMTP id bw24-20020a0560001f9800b0033b4d82a487mr3957053wrb.1.1707723410159;
        Sun, 11 Feb 2024 23:36:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZWrmzIVHG/WJVwUJzwztQBq575qgSmKM1vT1dzjWDHSTSQzkrIT8mf18flR29IrqGDIyMIrd/s0UWd6YdC1no4Y9ZKQIdrx/ZB8iaRxgEXbR9mJPEGY16MU+F+g3JA04/H/8VVh/jF15W5p2hALmuaSxcBJ8xtsV4sfg6/QE1ol4jEAFy0qdBZmu/AOu5PHBm1Bo0yKDb24e3uXHAQeZWkMofYSO8I/mwoY2uCsjcQbeeSSy9DKD8PAi1YMk=
Received: from gerbillo.redhat.com (146-241-233-147.dyn.eolo.it. [146.241.233.147])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b0033929310ae4sm5963097wrv.73.2024.02.11.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:36:49 -0800 (PST)
Message-ID: <d9261aa8d33c2730e78bef29b2635bf7dd81bffa.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah Khan
	 <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Feb 2024 08:36:48 +0100
In-Reply-To: <20240209111730.5e67d9ac@kernel.org>
References: 
	<53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
	 <5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
	 <ee9d2e224d063dc66070b060f716219c976759cd.camel@redhat.com>
	 <20240209111730.5e67d9ac@kernel.org>
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

On Fri, 2024-02-09 at 11:17 -0800, Jakub Kicinski wrote:
> On Fri, 09 Feb 2024 17:45:28 +0100 Paolo Abeni wrote:
> > But I'm pretty sure that even with that there will be sporadic failures
> > in slow enough environments.
> >=20
> > When the host-induced jitter/delay is high enough, packets are dropped
> > and there are functional failures. I'm wondering if we should skip this
> > test entirely when KSFT_MACHINE_SLOW=3Dyes.
>=20
> By skip do you mean the same approach as to the gro test?
> Ignore errors? Because keeping the code coverage for KASAN etc.
> would still be good (stating the obvious, sorry).

I see my wording was not clear/misleading, I'm sorry. Yes, I mean
checking KSFT_MACHINE_SLOW in the caller script and ignoring errors.

Cheers,

Paolo


