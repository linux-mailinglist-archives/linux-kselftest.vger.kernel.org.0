Return-Path: <linux-kselftest+bounces-33345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DAEABC85A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DAE1B6445F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B1215766;
	Mon, 19 May 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmR1xifO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DB2116F5;
	Mon, 19 May 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686399; cv=none; b=Jli+K//Tm4hfbyq0fMlI1gNKlLADm/SxGv1onf3ns+LeA1kMwNPoOWuVNFriQF17tzaitTq3sJt+MSnIhwHLhazbKLs9emjtrUdHK1Xmbb8LwQ3O/lYYwixy3PJNhIF7GU1J9PJPnHc467d2XRyR3XZ5PMNrXPmGeCTbgpM1BQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686399; c=relaxed/simple;
	bh=M3Qm7UxyqVWZ7NlBEwv26O0riHxC3eGrEkrMHZFTCvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iafTTjnKcNX/eg5jo68cS/vUENTUbaoAP69iQHD/KPDEBg5sgiI/VWZcHqOjLz9nh9QzDDIElKqAZTDz1tgR9GgFHAbLLqs9lY12sVZttRjn7Qr1iu9UZLXbR3FfY/Gy10cOmG7D15PPvFnri9mFSFLNopsIZj+JZwYQbx6SkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmR1xifO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231bf5851b7so37020515ad.0;
        Mon, 19 May 2025 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747686397; x=1748291197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02GL2wKVW0LkdsZTCqM47NTuhtkoo30AFjaowy05cuE=;
        b=GmR1xifO1D3A4T86M68yyjXXigcxNzg1slcBm4/V+hM7vjHo42BDynRRu/wt9kPDPk
         LFJGopUFmXFDa787bu3qU5R01dt7LcD5W3l7dZ6sZVTg+2jY7/aU3beo06xBCUoltdG6
         hbCMbNlUl8wfiQCqOa9P6F+Vq+62QD22Emccat79MHbDIVRkKNyJ5cNVg+iu1Ateux7W
         WM5mTHUXsveJL5Z1uJNxi+bNac7TdoU+z0zPlrtT29Qf0Zqg8RgY+tRkI+9U0eBbpk6K
         JUKdUVBnwYZAUv8PJOw5RIKjnszn0mD9HvTIiM62mRyg0/UIpi/aS8SckvolAyP3w0NK
         Y9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747686397; x=1748291197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02GL2wKVW0LkdsZTCqM47NTuhtkoo30AFjaowy05cuE=;
        b=DMwFdfEH5Nqwp9FRJBkupWKYGDg0Ugo9+95CMiGvAprZphLjnCJ/IyKHuD7S4j8CXC
         j3Kgg06rPQomlBD4nYUF/1EXcU15bWHrG8SYvr9vZzv0Xjy7zO9VdiSXzEa1kljYCIIe
         UgYKWeD7IDrSYCsEZyH8GK8uQWealKOS37HMWU5zZeg8tYGy9sfX2TF1Xy/+VACPcHbB
         SBPM6Wc7dl9Te6BbCgC3COgWoSB+yFezPILUuyBml6/hI2HPBQkbtGDn58ajntOwuZgy
         wmKOTBHY+FUe4f1uXcaqa08wLR+A14SUE1OJGASut4NOjNd10w4dj3IBHyYzHDlwNGZG
         vVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWPTKC5M/9ksnaEYjQ9K/OfnghTnN0tgMcxYfBgVklOcVak/fmC7BwkxOG5WFHPWqytylplu/SCD1BQenqYunop@vger.kernel.org, AJvYcCXye2TCh5MVaH6Qv/bUb14f2/JRpWkFoQVSwJ9976GDcwp8BW+Q7DJ93RK3Uuum4zoxnwQ7dJbmQ/Q9dik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfP/n52UfT9XSrrCO1jECG4MF449wTRRHaxNaG6EXER56z6U4Y
	6w3lz42JfJWczExORbIdJTk/T0LvrKuhOrbhOBPlEQSLYSe3EQnGww4=
X-Gm-Gg: ASbGncs/8uZkYMs6eEtn3tPOxTcBQr4zERlNfFBuD0wYhS/z0iFY+LR1owj7ikCi6U0
	ElF8p+XfzhQuG8LfcxVM8bsC7Akav2Z4XzDL2b8AjZRnHSkOCDBsO2yOsFXK48SGntffZBXbMlq
	Gta+30+HWapFZijYzpQvF6YfUq/LYjEubtNlnsviaXfA1SsyS6ERotXFFWH3MdE1f+HfMEtBID7
	CxLhzzj9yIUNxPlg6cRCl7YHa4lS2MUMiNNfSN/dvh6mkVFJHQmHSb9/HAwoL9tpM8uc2xKgse4
	LGXqOiZUYDeO8+O7U8torhf4C/Ml66O8gpFiPqTcrEUAy5UHeayT82BixOL/UeuoWhRrivHIwAi
	qjVJKb8tiMEIE
X-Google-Smtp-Source: AGHT+IH3Njb1ruXaok9z6rsx1z8T8I9pAGPNq77aZ6L/zHkoVRfFzVXe9cnxvfL59FRWkvqTEomqdQ==
X-Received: by 2002:a17:903:94f:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-231d45a9aa0mr217834815ad.40.1747686397006;
        Mon, 19 May 2025 13:26:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4adbfcbsm64224505ad.75.2025.05.19.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:26:36 -0700 (PDT)
Date: Mon, 19 May 2025 13:26:35 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 5/9] net: devmem: ksft: add ipv4 support
Message-ID: <aCuT-3rdNQTzb6UD@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-6-almasrymina@google.com>
 <aCtPEBmBFvM-bA_i@mini-arch>
 <CAHS8izMjCX=PkU0bE6s46uXxrnHjP71G6LN0v6oQumNa2Mouzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMjCX=PkU0bE6s46uXxrnHjP71G6LN0v6oQumNa2Mouzg@mail.gmail.com>

On 05/19, Mina Almasry wrote:
> On Mon, May 19, 2025 at 8:32 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 05/19, Mina Almasry wrote:
> > > ncdevmem supports both ipv4 and ipv6, but the ksft is currently
> > > ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
> > > are limited to these networks can also test.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >  .../selftests/drivers/net/hw/devmem.py        | 33 ++++++++++++-------
> > >  1 file changed, 22 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > > index f5d7809400ea..850381e14d9e 100755
> > > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > > @@ -18,30 +18,36 @@ def require_devmem(cfg):
> > >          raise KsftSkipEx("Test requires devmem support")
> > >
> > >
> > > -def check_rx(cfg) -> None:
> > > -    cfg.require_ipver("6")
> > > +def check_rx(cfg, ipver) -> None:
> > >      require_devmem(cfg)
> > >
> > > +    addr = cfg.addr_v[ipver]
> > > +    if ipver == "6":
> > > +        addr = "[" + addr + "]"
> >
> > I think you can add [] unconditionally, no need to special case v6.
> >
> 
> I'll double check, but IIRC the [] were v6-only.
> 
> > > +
> > > +    socat = f"socat -u - TCP{ipver}:{addr}:{port}"
> > > +
> > >      port = rand_port()
> > >      listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
> > >
> > > -    with bkg(listen_cmd) as socat:
> > > +    with bkg(listen_cmd) as ncdevmem:
> > >          wait_port_listen(port)
> > > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
> > > +        cmd(f"echo -e \"hello\\nworld\"| {socat}", host=cfg.remote, shell=True)
> > >
> > > -    ksft_eq(socat.stdout.strip(), "hello\nworld")
> > > +    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
> > >
> > >
> > > -def check_tx(cfg) -> None:
> > > -    cfg.require_ipver("6")
> > > +def check_tx(cfg, ipver) -> None:
> > >      require_devmem(cfg)
> > >
> > >      port = rand_port()
> > > -    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
> > > +    listen_cmd = f"socat -U - TCP{ipver}-LISTEN:{port}"
> > >
> > > -    with bkg(listen_cmd, exit_wait=True) as socat:
> > > +    addr = cfg.addr_v[ipver]
> > > +
> > > +    with bkg(listen_cmd) as socat:
> > >          wait_port_listen(port)
> > > -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
> > > +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {addr} -p {port}", host=cfg.remote, shell=True)
> > >
> > >      ksft_eq(socat.stdout.strip(), "hello\nworld")
> > >
> > > @@ -51,8 +57,13 @@ def main() -> None:
> > >          cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
> > >          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> > >
> > > +        if "4" in cfg.addr_v:
> > > +            ipver = "4"
> > > +        else:
> > > +            ipver = "6"
> >
> > If we have both, we prefer v4, can we do the opposite?
> 
> Sure, but why? Just curious.

We want to be in the v6-only world at some point (unlikely to get there
though), and having dualstack deployments prefer v6 is the way to go.

