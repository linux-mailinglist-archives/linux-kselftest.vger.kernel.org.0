Return-Path: <linux-kselftest+bounces-23316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A249F0C4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44551889534
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2E1DF97A;
	Fri, 13 Dec 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdmoHYi6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBD1DF752;
	Fri, 13 Dec 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093160; cv=none; b=NdZ+2QZgF8ODKnpy8B+O17DnFeAYkEMEuvm/DeFhh6mdnwjM0EvzT3ODI/ai4iNzWx4d75Iw2doosegn3N5PUYiA0Cy20bYZjlRwee26atUFiww3vGXn+8CRsy5ixyKfX8ko77CslUamt6aYCQBBxrKrAwIqQuduoR01sFYusEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093160; c=relaxed/simple;
	bh=fsTrHAiO83eVNFyOeYdHYXhiTz7hRv6LJ42aHUnEANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdecXivZAUfklImfV2HnRZVc69c8zUAXXdREZpbAUmwhuzas2HW+tWQYXfjiF3fxfCRry182lza2i6tMT3m2fS0P0ZPb+IbB8JYswNTQ3OBu1ojqzbHtE/YDFxhlPqJzUMftdHxNJyTOaHQh/GWNw98TPiY0rZEteD9svTsHsdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdmoHYi6; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29e5c0c46c3so826986fac.3;
        Fri, 13 Dec 2024 04:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734093158; x=1734697958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rTGR/DL1qtr5aYS8f+9xO5Ih5JqqbBsRuf62d1H81s4=;
        b=hdmoHYi6OVXlngwUzdFKeCXuiufm8dpy5PMAJY18X9laiG98wWwJoomsBxvN50UIZ3
         xXn2mUOHIOw/C5qItGC0g/Y0PUCChPOo3Zd+FevyDoXAFtr4KvgVjLg43ZvelpELheGP
         SVYTtkiAFyxx75tbs67D89LS1ZQIv/fXIn50Y1yPLbm79sFl9n/H61bA1Xh6ejaU5oUb
         +V9HzV5tv85ov4kyiTcYram6zddI2Sr3142aOKwwDfZOcYawxDcvu7HD7vyLstjEPRob
         J2e9O7KK1Mf3j4pof9WwJnXpKZObtZKIHdI/i7/mknNns8i+5OJUK+cpU8My7BDoC4DW
         P/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093158; x=1734697958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTGR/DL1qtr5aYS8f+9xO5Ih5JqqbBsRuf62d1H81s4=;
        b=lUcnXGOVnsG9i3KeyMDcN11p1I062dN1b75Tt4xw5l6J01vJvy7ewQW87nna9xHI9k
         jTpkH+W6zR4ASuMUtJXHdyme/3GjGYAYYTK5DENvxLKhi5RGyHnfZVzayXf4UPceTffV
         VLrWCXfjmc6T+xVvkuQHTLTafjAdW/LCvHI6z9YPY5rwFUT/9w3e01C+GuaV+D+pQOkQ
         r6vs/5zWomryawUuRjxbwLjYARIoNSI+Sviji5bS9ZRBNaUQ/GKz0oSTOgXnRNys7ZBK
         A4oiFrfztOifrn+01T8DcTAT/r5IQpZHzjd6xroDF0skmv1WB5OQStYRqoC3S4UpkW0g
         KraQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa1z7Ea88OzX/39ftsSsdBH0yC6LlummHeHD8oCoUcEVnKi2okHjB3rfAdJZgQh6JDCDmtKaqBjIlWSZ0UXMsx@vger.kernel.org, AJvYcCWr1rWOEMSwIpPh1vg4Th6slQxEuCO1WWNV2qSxzeG5re4UR0ACjQxnJMIHtojjRA5PUhQ8Fpu/EmwYFP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5oGVbyTW5PN8Zk8Qyvp9fN2IVLD8AsVweVaFZOYIhddqqOIs
	AF1eo95HF+V7CTI2n8WzJ684TCHXXbb8gfJGi9LLZpvfyHD1Sy9RAiPZvCWIldiXLZoBTNWgVq/
	rquM1QDve/BJCB/6lzBBokjvOB9U=
X-Gm-Gg: ASbGncsTwo/kD/1br55dpGgXoqhR5lsyy4rwTP5+UnCyFihwR86Iw0hihudU5CCRyqg
	+kaa3pyh3zmI6rNqvxEgOqK2yrZEYgyhnivVowYQddqwPwC9NScsQZ6m3+QY5loz2AXkn
X-Google-Smtp-Source: AGHT+IFwYIoqLqjl/TuiKrRORnQy/+BxiiyOPxgy7qaRAjIZ95kOqJVGZ9Xdoa3iSz19TX5MxdU4f0HIyBZv8+4dRN0=
X-Received: by 2002:a05:6870:82a4:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2a3ac8a8d08mr1470450fac.26.1734093157864; Fri, 13 Dec 2024
 04:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net> <20241211-b4-ovpn-v15-3-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-3-314e2cad0618@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 13 Dec 2024 12:32:26 +0000
Message-ID: <CAD4GDZyXK6rBH_ccHkYrA4h71bDkKxVy_B5o-bj0ezzdHTJKxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/22] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>
>  static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>                         struct nlattr *tb[], struct nlattr *data[],
>                         struct netlink_ext_ack *extack)
>  {
> -       return -EOPNOTSUPP;
> +       struct ovpn_priv *ovpn = netdev_priv(dev);
> +       enum ovpn_mode mode = OVPN_MODE_P2P;
> +
> +       if (data && data[IFLA_OVPN_MODE]) {
> +               mode = nla_get_u8(data[IFLA_OVPN_MODE]);
> +               netdev_dbg(dev, "setting device mode: %u\n", mode);
> +       }
> +
> +       ovpn->dev = dev;
> +       ovpn->mode = mode;
> +
> +       /* turn carrier explicitly off after registration, this way state is
> +        * clearly defined
> +        */
> +       netif_carrier_off(dev);
> +
> +       return register_netdevice(dev);
>  }
>
>  static struct rtnl_link_ops ovpn_link_ops = {
>         .kind = "ovpn",
>         .netns_refund = false,
> +       .priv_size = sizeof(struct ovpn_priv),
> +       .setup = ovpn_setup,
> +       .policy = ovpn_policy,
> +       .maxtype = IFLA_OVPN_MAX,
>         .newlink = ovpn_newlink,
>         .dellink = unregister_netdevice_queue,
>  };

You need to implement .fill_info to add IFLA_OVPN_MODE into get / dump ops.

