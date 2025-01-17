Return-Path: <linux-kselftest+bounces-24711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAEA14DC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5106188B974
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D211FC7C2;
	Fri, 17 Jan 2025 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egbYQl59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000541F9EBD
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110331; cv=none; b=tYs9RUcpl9/Ir5zYoJwn1o5rqJOeWb8Kor2UeCb19/m6fzysAp6qjlgB3GC/hTLgHcMe1eHPaNjmaco0dglId3gvBtaWT2plRL4yoz8tr2wf5xoYarg3yu/a1reCtaXRBmr7Rqi6vCFtk3sHIY3emPFgRATAPtwd0iohZuO6nBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110331; c=relaxed/simple;
	bh=jESdTsxYfm0Ar/eqYlsJDK/1LrlLKGeYD2dTw8UUIak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6i33IXL/kG136qb55bvBQ6Va+2r2cFmWqODYdqzGhqb+0xnMS/JJOkCsD8bwcKycIfogxpCRC4VsX9MQ+Mu/+QbXmgnYC4Yx95iCBY65/oQ+2U8OkKRl83JLj+4U/EbGgJDNbPgGHkD0E4tH6Eqnnh/43rUTGGFEgCLeCesCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egbYQl59; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce7e876317so45ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737110329; x=1737715129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOkIgFL1Hzr+AndI+EGHjs/MAZuXjuse6wPn3/pn2XQ=;
        b=egbYQl59bNpBTHIFAE8Kiwbi0VQYvS4FsPfjsHtjdwcsjxQ0/Gkl4bhL96J5yydnit
         Zkt9e3bh+E5Y6zl/hcZfsgXSTf7Mh4MvoxQ08pA+33XYsGeR5wT803hWBtFUVHIQRr6w
         BnMv/Ui7FDt0Ysi2Iyfei2hQIVM0xGHVkL6bo1FsWK/XJgevvtt3MEkdM0cLc59ZJzUs
         9ZPaI/O685cVKixopxEcKLuaWmxPB9vpufCJj5OqJ6CDkTeU/tzYQSNAcvV9mUMhGhXo
         KhgyV5P0ALJM/SGtvOTWG9CF/jySunY01d6SBWTbgSRxIHcVs/vvidad8wbCnUNs4I0e
         zqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110329; x=1737715129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOkIgFL1Hzr+AndI+EGHjs/MAZuXjuse6wPn3/pn2XQ=;
        b=A+5mK6vMu5SKo4a74F3RgqWMaMO0b/P38VuE9HAT7JPbKLehGWjjXRD9sYvmrZJF3h
         8Aq0dEnqqHzSP9MONWRH1MH3QBHynjpXj4TI27YKdTh7aA6Cb8rs2Ee68SvuwjOhSOoW
         IdZs4CdP0JfmxH1CilhRf7TLiNcCs+XfS58N4WAOwPYSW3wDxBoDA4mR6lQzAiEc+P6P
         PlCgW9OlONHag2tmp+H8iyZY1fAroCfJp/1wDUlw5tctjnUphOwV+/oWTfd/iN0UEpMF
         wAxchz7Z+/JUv5gOpWrJx+faroLpuK/04r8vV6yAmtaMAWQyH68Q7mol1T8cvvMa8Khi
         o0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXloIlAlFCW3iaMAk0tQ9yYNLIa4KVZzM2L6L4mPqTdALl5BdngbqV9cMtPHPsw1J1iqRhlaiHnLHqtB2WeBYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CE5aTZx/es+pY6rVO0lwq/xrA+WOSU+KZliB+bJm8B6KzMsm
	vyjpeqzlxYgIgt2ars3uusSXenMFucMRXuiN82yLqT1zpnZmtMlqZ39d2olig5iqQp0VNLEB3UG
	R/zuqkAxiNHj94/nrhJee2SEMgHicZmgpmsyn
X-Gm-Gg: ASbGncvgAI65yP4fZYnsVAXtafa/J/Oq6ZzBNqrOCJDL48hJ7gEiz+Vlm/n6bixbAss
	t8E97bSzCScGuxs7AlKwgru2gjAtnCmeBM8G7MmQympJhswpy2rGcSt5L8YzSbdEwKbE=
X-Google-Smtp-Source: AGHT+IGpNe/i5D9YYf+WjW+Ud6lnaJSv/Zy5dsVh8kjyiUPHOK3eBc9d21pI06bfxj6upvmMcRdwbN5eXr7Js0Dbx0E=
X-Received: by 2002:a92:dc52:0:b0:3ce:7947:b163 with SMTP id
 e9e14a558f8ab-3cf7a5c5f68mr39625ab.0.1737110328098; Fri, 17 Jan 2025 02:38:48
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114023740.3753350-1-yuyanghuang@google.com>
 <b7305f0a-fe4d-4dd4-aaaf-77a08fd919ac@redhat.com> <CADXeF1EiMaASLhRiNMEeXmUUT3dXhhbasOeReaNy=nuVwa1agw@mail.gmail.com>
 <262b5dce-eca9-429d-92c8-205ce27e02a1@redhat.com>
In-Reply-To: <262b5dce-eca9-429d-92c8-205ce27e02a1@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 17 Jan 2025 19:38:11 +0900
X-Gm-Features: AbW1kvaGdN7p4-FVDUQ4GadRJ0fzSdd2JFi4KpJgVjlQBndIwfeckBcWF0Db-MA
Message-ID: <CADXeF1GbaZ8cv7XAwfNbG6uVaDO8qzVZ_ns7=9SuyiJQprNx7w@mail.gmail.com>
Subject: Re: [PATCH net-next, v5] netlink: support dumping IPv4 multicast addresses
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Do you mean that in the next iteration you are going to remove the 'enum
>addr_type_t type' filed from struct inet_fill_args? That would be good.

Sorry, I already sent out the v6 patch. I should wait for more time.
PTAL at the v6 patch thread and we can continue the discussion there.

>As per the header file, I tend to think that the better choice in this
>case would probably be creating a new one.

Having the `struct inet_fill_args` in igmp.h will make the IPv4 logic
consistent with IPv6 logic.

IPv4:  `struct inet_fill_args` in igmp.h and use it in igmp.c/devinet.c
IPv6: ``struct inet6_fill_args` in addrconf.h and use it in mld.c/addrconf.=
c

Thanks,

Yuyang

On Fri, Jan 17, 2025 at 6:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/17/25 7:56 AM, Yuyang Huang wrote:
> > Hi Paolo
> >
> > Thanks for the review feedback, I will adjust them in the patch v6.
> >
> >> Why moving the struct definition here? IMHO addrconf.h is better suite=
d
> >> and will avoid additional headers dep.
> >
> > The `struct inet_fill_args` is moved from devinet.c to igmp.h to make
> > it usable in both devinet.c and igmp.c.
> > I feel it is incorrect to move `struct inet_fill_args` to addrconf.h
> > because that file contains IPv6 specific definition and it also
> > contains `struct inet6_fill_args`. After refactoring, I will remove
> > the usage of enum addr_type_t type, so we don't need to import
> > addrconf.h anymore.
>
> Do you mean that in the next iteration you are going to remove the 'enum
> addr_type_t type' filed from struct inet_fill_args? That would be good.
>
> As per the header file, I tend to think that the better choice in this
> case would probably be creating a new one.
>
> /P
>

