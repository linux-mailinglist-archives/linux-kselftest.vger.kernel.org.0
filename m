Return-Path: <linux-kselftest+bounces-35098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D7ADB635
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48894189038F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04702874E2;
	Mon, 16 Jun 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8KYK0sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA5286428;
	Mon, 16 Jun 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090063; cv=none; b=d6UhwmrG8Ys+IUAfzzaN9ggXT5Mq/miWBxDRKsi4SOmXdKgR7XvQ6rg74ebxLRxkiM9GUJ0pLPVH1CPxH/OBr5x1cVK16SPnMTXobKl4SjQUkLnXZAQ1mfXfpteQtLrmQcaAYqgFqVJ3JLL8hjO/ZZ1j1K3q7maNsc0egciX4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090063; c=relaxed/simple;
	bh=KsgLfuDYy7dDbDgTv6+EomPA1mb4NN/cDbkcAly4i04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5tLv0PzhUK/wjVUH6oQ14zMW3wjA+m9advl1td7ACB5ZbuqTIpZBQWu/tZSup4GqdNOTG6+PE8TROx2Ewxidl1X6OK3Km2NAG31YDB0plR6jHvlT12gyskldCNUjxEkf6ZqyO1WQJppQs+/dQMGBt3Qv2tTWMc42f+lGF1xA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8KYK0sx; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8187df27f8so551691276.3;
        Mon, 16 Jun 2025 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090061; x=1750694861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMxTLAjWm10iLw7QnXC6/MuovWFMfEKiXtH5mlIUP3g=;
        b=G8KYK0sxYz5sQTT6k2axlm7xJdviNEUakDVVyH29m2CvN5i28CrrQZxdoOg67V+WWk
         3RaPOsADM4qtH+Qbrho7fddfKFwHuJstedEK2GcsWW1VfRiIkl6y8unct1Hcxspf3jir
         yj/6qJQX2G2rAlBnFL2HH9J0joXqI+0JUTkk38s8P1AK+E0PIajT+YpHmCPiTrRWedYI
         L6v+E+gjP82MQwtBPj0y7F7w+ia7+Udj6/GJHKDZrNGbDNn6WiCzrF2lMYKBwrSXdzty
         GNZxKAaSCFXZriIIiH56hNpdXwaMqAuvqHTLYyQ7ErG4Db/9tTfVVcFHwPm8touVl9gv
         c2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090061; x=1750694861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMxTLAjWm10iLw7QnXC6/MuovWFMfEKiXtH5mlIUP3g=;
        b=bRn59thQV+cFtwUXYxs5nhXNLvGch9EhL+YqHqzLJDooYM42YS6103Tu6gYOkrNVdF
         Nvh8LLizpcNWngKgSLx0Ienf2WMCXTssyud+T+VPgUyIBldOWyZnhvrkWDf7PqYMI51g
         I0h89JyJpWlZVGGoITiWfJoVwWpjnBc8LDUmojI62jpwQln83K5lJ6neac3AZ0lpK0vX
         peDPGZfqYtH5pwAPS4/NVH/HEgbmz5E3bQZ5s8WSvjXIjRD1tdnd303BsoYARMmmeSCW
         0w66u+PulKvZB1h9FJmmpHd8rQTNy3VtoLr+cGbfnJK1nLemMOGJBleNzojgTjMmZnT0
         rDAg==
X-Forwarded-Encrypted: i=1; AJvYcCV8q55V0HNYP5+k6JOj9prp5HBNN8KQ7jeqlY/vkBC5Soub/HhDCL9L/JeikPZA9Kvo6o5ayY7DBitcI4XB@vger.kernel.org, AJvYcCVGka4tO65OLm6RiRFfkaW6buwMjABYaA3kaH504yf01aaoA68ByZUDrCrgpTxMa/Ye9KKMdoRFrxA=@vger.kernel.org, AJvYcCVHlTc36WV/3MkwlMB8rA4BnPH75RCCdwRo9uElpBPyX8MPHrN5Lv3yuynrM1WGXBSe/FDkG0aP@vger.kernel.org, AJvYcCWPMq/zN7wpGRkwSk8ISdszJr8zKxumMAqa0Lvu2d/PoT8hMKjFuYSQefwsIUvzj8XdqMSF2ndDmkFT57QOsA81@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUqHAcxtwOpmQPVS71BPPGXd8wp6TpDaJv5hm6EY76xQSv1Zs
	175I2CryQQTP914p1saQSfRFM9CgdXYyu4a0MF94UMvLPJc5Y4KizZeGhInib1qmna9giRC7MvW
	CKzRljqr5sG/fg1BnhIwJimk+N6T5U6c=
X-Gm-Gg: ASbGncsyirb9SBEmd/Uu0U8YrNYhsITQ9al9mA+/IZhSDceF4Fh5Vci7FjzKZ26YXdw
	gYtlQMHCbPBS/bGHO/XI0cUDA5qEiS5YevCsHMLJuBokrodMJhKF5UvwqPDY7Nd/eNgF5iyFgyg
	jXOOyq57RguhRW4IJr/mXwm1FSi3bssXlKR7aRXzyxv9xHB4WRsW4Tq2Itf1xL1H8iL2ID
X-Google-Smtp-Source: AGHT+IFNg7I4XsDY/FdlWOLQEVc4xIZLS0HZaG/S0kB5iwZhvz5AUSvqz4talBpkFkW4J4zqnPwP0y0I4ly2Ykaqbwo=
X-Received: by 2002:a05:690c:1d:b0:710:ee89:d34e with SMTP id
 00721157ae682-7117551588cmr57892367b3.8.1750090061132; Mon, 16 Jun 2025
 09:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
 <20250612-netconsole-msgid-v2-3-d4c1abc84bac@gmail.com> <20250614125149.55a8bc1f@kernel.org>
In-Reply-To: <20250614125149.55a8bc1f@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 17:07:28 +0100
X-Gm-Features: AX0GCFsG7aAkCLxvAEeFhB0hvUvlv9vtc2b6rgSY6b_6uyOO7FHX3qHDEuWg0tY
Message-ID: <CAGSyskU4Hh8qebN6KhVjFZXsPr3A5At7gAtm9wipnEZbiZZ+9g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] netconsole: append msgid to sysdata
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 8:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Jun 2025 13:02:16 -0700 Gustavo Luiz Duarte wrote:
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 3bf8777fcd01..baa9862c1bc3 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -155,6 +155,8 @@ struct netconsole_target {
> >       size_t                  userdata_length;
> >       /* bit-wise with sysdata_feature bits */
> >       u32                     sysdata_fields;
> > +     /* protected by target_list_lock */
> > +     u32                     msgcounter;
> >  #endif
>
> kdoc is complaining that:
>
> drivers/net/netconsole.c:167 struct member 'msgcounter' not described in =
'netconsole_target'

Good catch. I'm sending v3 to fix this (will also add kdoc check to my
pre-send checklist).
Thanks for the review!

