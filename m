Return-Path: <linux-kselftest+bounces-6184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036F877FB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A481C222E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB293C467;
	Mon, 11 Mar 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0acgCqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4213BB48;
	Mon, 11 Mar 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159113; cv=none; b=ZrKU6ipbQrS2YckT6mD89lZD8T61gezuZ3bEHkeywop3w6uhRH5ng3UWnA4LWg/gEjMEgasAzlD/CoDJ1t59Thjsqg2NrgHMDd93Uc5BKcfY3DDP1sd9K0G3XH72uJVVNef+uafNjCv9ax9W//lyVYggF05xGYy3IK6KLvqaaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159113; c=relaxed/simple;
	bh=do5Fzw84xe03KvWmx+Hc5C9ekh46v1TkZG4CX1Wrtdc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wpv3MTzrucld8rHWPa5vCxdxpVaUR/RdjQ0U3QOQ06xdAQ2bpead41hXNoD/qFwPE4DU4O600V0zkuz9xYawQQXLMx4uivRtkKQK5Yktj8SiKWUiq/2SIw8BIrW/gcIudG/YN1OQrA3Icbg15WRMkDNkBw+8rpUPMPvZ24OC7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0acgCqd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42edb7a1114so14458661cf.1;
        Mon, 11 Mar 2024 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710159111; x=1710763911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4Xg+fbI3bvOXLt2U1Rug0LW8HB70pTO+WPSQxPgpRE=;
        b=K0acgCqdYsrsiSPrtt09zm5gRnVwSYZ9k4DVJGxV64+QF40hfzd5kzEh6uIK90vSnO
         JyAnw7snRFXtCFfutjqGjb6NePaFGDrYnpWwTClH5XqfF+hpMrW0lyfll+Qo/Q+Oj9po
         bYZ1U/1Fsbxhd3BS004gYyTY4DOsZJPGWOP6fWLr4nEzM4VLGWyGQx0RVMJoIxc0DVzz
         mZSM3P0wLNga3JUEZD8mUM2xG0K5/46MOJ0mt4kWAjOpSsKGIPsCoFSRFVDxkJyAfXk0
         sV5Ajtcthavyw+7Z05K2adfxC4mzW5LzkduR6AS68gKg9nV2QbZM8SwpSmo4CRMgM7yT
         vo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159111; x=1710763911;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4Xg+fbI3bvOXLt2U1Rug0LW8HB70pTO+WPSQxPgpRE=;
        b=nELyggMWI7X5MoXnk4IDv76w8MvqE3fQTVoGDp8nuVyXb4G3DZ0DalHRuuG7Xg++yd
         x7zAvNbojT73d9UeKFIRwAwx6u3O6UYWM/I6eoPevGybvx0ZK5kotnZu1W8Ot6auJeAJ
         IK+DWk+8+btqe/oMkrRD4+1fNOzGHxGdVR0fQYcN/MmRJ9xw+ifPzqulaIKRmJs8cAuf
         RGTv/2xDJUpAmo1KZATbgHgis4Wj1YfKz9poI5TTuLZ2X6wUwWaBmX3wkJXOvA3erZbr
         qbq2Qv6TNE93SzYsjWiprfQwAwPkhwph3R0Z+fjLJPNS/ZqaX/AfW1NcXTbEuioyorvu
         bLcg==
X-Forwarded-Encrypted: i=1; AJvYcCU4q7xhk7avHsXDzZ3zeFRQiWEgBrwzV78pOke/wc4kEh+HRV5tGx9xShmlK9Z790cthlMmBjICiXLHNr/+8i+XiFinMq+r4hpFQRofQRF8m3lgjXe0U88phSHcmxRE3mv6WvHMu/hFouxlBpzK6e3wYtvjwgJuUf6TkiTQkbtc9ElJQaBW
X-Gm-Message-State: AOJu0Yybqq47+9gzLTpCl0T1KErCRN9uQmvghYX34iVhozkiC+7gSMEI
	LEQsIcgwlkw1+cB6HgkWslShgUHTPM8lc5x1RZRZepg132ldgXn7
X-Google-Smtp-Source: AGHT+IHklVTd5o7UKWkApU2MI7ymCi2nWEWhmzGewC9PGTNlIhp2Xg8zYorcs6MTDTUZ18JGNneJmQ==
X-Received: by 2002:a05:622a:489:b0:42e:c111:7662 with SMTP id p9-20020a05622a048900b0042ec1117662mr8498312qtx.16.1710159110890;
        Mon, 11 Mar 2024 05:11:50 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id v13-20020a05620a090d00b007884103dfcesm2606265qkv.87.2024.03.11.05.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:11:50 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:11:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 xeb@mail.ru, 
 shuah@kernel.org, 
 idosch@nvidia.com, 
 razor@blackwall.org, 
 amcohen@nvidia.com, 
 petrm@nvidia.com, 
 jbenc@redhat.com, 
 bpoirier@nvidia.com, 
 b.galvani@gmail.com, 
 gavinl@nvidia.com, 
 liujian56@huawei.com, 
 horms@kernel.org, 
 linyunsheng@huawei.com, 
 therbert@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <65eef506331e8_1db78c2941c@willemb.c.googlers.com.notmuch>
In-Reply-To: <967ed173-b556-4bfc-b3c8-ff0fc902b951@gmail.com>
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
 <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
 <967ed173-b556-4bfc-b3c8-ff0fc902b951@gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Gobert wrote:
> Eric Dumazet wrote:
> > On Sat, Mar 9, 2024 at 4:35=E2=80=AFPM Richard Gobert <richardbgobert=
@gmail.com> wrote:
> >>
> >> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> >> iph->id, ...) against all packets in a loop. These flush checks are
> >> relevant only to tcp flows, and as such they're used to determine wh=
ether
> >> the packets can be merged later in tcp_gro_receive.
> >>
> >> These checks are not relevant to UDP packets.
> > =

> > I do not think this claim is true.
> > =

> > Incoming packets  ->  GRO -> GSO -> forwarded packets
> > =

> > The {GRO,GSO} step must be transparent, GRO is not LRO.
> =

> Sorry, I should rephrase myself. The patch preserves the
> current logic in GRO. These L3 checks (ttl, flags, etc.) are written to=

> NAPI_GRO_CB(p)->{flush,flush_id}, and NAPI_GRO_CB(skb)->is_atomic - and=

> all of these are currently used only in tcp_gro_receive.

That was perhaps an oversight when adding UDP GRO?

Simply because the flush is determined in the innermost callback.

