Return-Path: <linux-kselftest+bounces-8105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120D8A6706
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FB11F2231D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AF85286;
	Tue, 16 Apr 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbQOtonw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0184D09
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259316; cv=none; b=tKnz0HwaWyEUhD+kGppgJ0ss2Crdl4jdd0+FwqCsXFQGar40ZQdVJWsQfTNZDVCXG2JC+ugNmlJJ+QnHbisxq8VxB43jLcOYBVuIMdk7bx2NYauvuOlOlEDV2AAEUVfj51UMBmOgMRVaK33sW/J7tSY0aueQTnFwePQQFZw/aYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259316; c=relaxed/simple;
	bh=vfMO8tSbWBgg6gzH7n20CTUmvHM2LxNEXzFSeilrvF0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EauTgH1zY6S9cZf0xFXn6Yb6PhLOLs3HQ4fh+d26VdTtLlE43pZRzYHzIhlFXQTYUppeP1N7K4wBkaKw0JedZpK2bDvyMw5lo1krS/aoStH7CKGao4k2KXt7z0OEnNDzZEQdklLpeHoh6Yi/ZAVy3wbr4/qjmKn1VtFOkrawros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbQOtonw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713259313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zRFDx/vUOOS7DFozqqtqYWupAKoGiHleDbCWTUfR1E8=;
	b=NbQOtonwOMSb0ECHsMrglnDTVfpMDX3RT7Wh6TNlPdIY0ECpRqGslB3aOG7D8NG02LfJee
	HRjUdFa96HR6GJF2YvFXVhAs4mGhA9oKtE8eB4IBivV0WRQ4nwmODc02CoWCNYUuTcqm14
	TIX9NgMN3v/7QQlVUOloh1O8Fpcmwdc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-yLE1uEvjOHOUxB92fkOyYw-1; Tue, 16 Apr 2024 05:21:51 -0400
X-MC-Unique: yLE1uEvjOHOUxB92fkOyYw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3450bcc1482so1085042f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 02:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713259310; x=1713864110;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRFDx/vUOOS7DFozqqtqYWupAKoGiHleDbCWTUfR1E8=;
        b=crBia8svImu355YTcc/d/cqoecFSd0KgH28Kl3MZ4bLuF/K7kELvCTkNwO+QuiNLvb
         z9SbKzCH5+eNvxZ6mAg/7NdK2fyrnR88rJqXL5yJ9RlVyzNYFLc9HMi8qZCOV7QiUHrI
         RGH0yKcyapV2idWN53+WhYwMFBKmo0wngSFmbI5rcAxJOij04PwlH82ADAi+bVt/Lygw
         p3HR6qSDN+TPYCEkln0uTZ34Wy1Z5w5SE99sZMdogSMZ4riaCxWGQyIPL2lQ7eW6NFMt
         gp9kkSm9iNUUvoNdMMSfxGOR5If/cx0NQNOOdKXaXVcm0e0+H4gZ6B26CY50VZbDLzNi
         LkCg==
X-Forwarded-Encrypted: i=1; AJvYcCVFOSbsh6Ak2xzWIFXVAHa+S5KY5eVI/lebOKctALyYesOFMTeZn6ltu2Q2WnSBMQWBDd+hJe7erf6lZg36UonVTBoBoglaZCiWUXZNkbFK
X-Gm-Message-State: AOJu0YzaatHg6UzkC4ehfdjR8DeZCk0H7BYkiufDdHBjQ+Q8iltAP3ti
	LXBp4XeWXbB9gZJHp7ptqVZo9DyqIIn6MUzdIOh12lHFWmn+NXZfaWWX8x0QyscCkbe6ypTrCJS
	ka8RHPEIRAK60Qdhgri8LK2FiFGmbBIJAVSa1gb9ypekp1z41NzTXxUzeudJroP2Vyw==
X-Received: by 2002:adf:f011:0:b0:348:4164:d021 with SMTP id j17-20020adff011000000b003484164d021mr1074839wro.4.1713259310744;
        Tue, 16 Apr 2024 02:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE94UtjFd+tU5lKwzbZ/ZDGhbZTrc5plMo/4GjbVh06s0/kn96ypaGk71SsEjCQmY23yOT08A==
X-Received: by 2002:adf:f011:0:b0:348:4164:d021 with SMTP id j17-20020adff011000000b003484164d021mr1074828wro.4.1713259310387;
        Tue, 16 Apr 2024 02:21:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b003445bb2362esm14241043wru.65.2024.04.16.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:21:49 -0700 (PDT)
Message-ID: <a36bf0b117f7786bbf028494d68185486025777d.camel@redhat.com>
Subject: Re: [PATCH net-next v7 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 16 Apr 2024 11:21:48 +0200
In-Reply-To: <20240412155533.115507-3-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
	 <20240412155533.115507-3-richardbgobert@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 17:55 +0200, Richard Gobert wrote:
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently in all tcp flows and in some UDP flows in GRO.
>=20
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
>=20
> Leveraging the previous commit in the series, in which correct network
> header offsets are saved for both outer and inner network headers -
> allowing these checks to be done only once, in tcp_gro_receive and
> udp_gro_receive_segment. As a result, NAPI_GRO_CB(p)->flush is not used a=
t
> all. In addition, flush_id checks are more declarative and contained in
> inet_gro_flush, thus removing the need for flush_id in napi_gro_cb.
>=20
> This results in less parsing code for UDP flows and non-loop flush tests
> for TCP flows.
>=20
> To make sure results are not within noise range - I've made netfilter dro=
p
> all TCP packets, and measured CPU performance in GRO (in this case GRO is
> responsible for about 50% of the CPU utilization).
>=20
> L3 flush/flush_id checks are not relevant to UDP connections where
> skb_gro_receive_list is called. The only code change relevant to this flo=
w
> is inet_gro_receive. The rest of the code parsing this flow stays the
> same.
>=20
> All concurrent connections tested are with the same ip srcaddr and
> dstaddr.
>=20
> perf top while replaying 64 concurrent IP/UDP connections (UDP fwd flow):
> net-next:
>         3.03%  [kernel]  [k] inet_gro_receive
>=20
> patch applied:
>         2.78%  [kernel]  [k] inet_gro_receive

Why there are no figures for
udp_gro_receive_segment()/gro_network_flush() here?

Also you should be able to observer a very high amount of CPU usage by
GRO even with TCP with very high speed links, keeping the BH/GRO on a
CPU and the user-space/data copy on a different one (or using rx zero
copy).

Thanks,

Paolo


