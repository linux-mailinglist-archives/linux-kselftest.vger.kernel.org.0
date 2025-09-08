Return-Path: <linux-kselftest+bounces-40912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEBB482D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C3D7AADA6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319C19F121;
	Mon,  8 Sep 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTS5h4f0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8572AF0A;
	Mon,  8 Sep 2025 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301626; cv=none; b=RGUmq65iRgcn6IL2qxJ1Hcvu6+4DcN1ErgPs773i5yfwuGP53kZgtpbAhaw3KY8il8yLegRg4QLQIWnsKZGMrjn+MpubrAQXc+df1TsHmKGF34OBjj8uDisxz6ax0HFINwzwnR7pJf+S8TcGabV//Q0AiiJYk/qbNiR1EHoFWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301626; c=relaxed/simple;
	bh=EwhzMYqe1Xj2utRfYFtfhVdLaa1Zk8lRWqZlK5EdRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNPrkrEDLAfNpnebEG5iki0nuXsw8qrYbcWKYonYJE/584iHf7T7pVSwa1CutrpnYCf+4ahjahdHnjf8tltg7ZIAqWPi7TxyjiLH4FMy6V+xsPoGV71WkF+HsNfIRMhmkCkB5IjW1t325HScRgm0Ro2NBSeKX58DUi0sIgLDO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTS5h4f0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso2584022a12.0;
        Sun, 07 Sep 2025 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757301624; x=1757906424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nQuprz9+iPOc6Hdx8EJtvsGxwZd1/+5PLT0+hvaev0=;
        b=CTS5h4f03eU+2ftJMDUA/qy1CIOzGc3FFFEntNUQrEn79/oSBlJ+Co5yn7w9djpuiY
         JlCFaZA1JboNX+etZbwwTdEm8KleoigIstsd7md4VngmK38pVkvE60YibMakleNvHTfy
         Rn8wrRXFCljKp71zkMj5JonrWdFwL5fmxusaXDwMKZ1nooxE0G7V83wXdNsq0/iqSS0a
         gMMWy/lXJpU4jq58+wrYqZGsQewpFe5nSTHGgjEAjyTdKPrGtAHNmWBR3zakjFKTPhD2
         jOSVBVggYTNjSV5lhiRrqezQGx70A7rNhdI5rUnEXCxyW11/NfCb5mY6Xmq5Ba468sQG
         srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757301624; x=1757906424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nQuprz9+iPOc6Hdx8EJtvsGxwZd1/+5PLT0+hvaev0=;
        b=peT17A8mIHZqCx6RK3ZIk6FwUIy73zv9D47fTSAAGHAF4CDlUUjE8wU7y+nPYdv5fX
         qPXlgigd+sgDwT86HWrUJFfpht3c9nSIrWmAQ2f5Me8h5QwfqQdzl+XMp7gEHtrpYkZX
         opA4T7YyzS81FChZPhzhmrXYJ0CJginJsVrCx0gPG/Gl3/FuTgs+w8Lj/8aC5legXR+O
         is0OUaY8TAb30Iwu56mS5ZIBxpW8Iz91SfjqlHVeoOb6utrNn2eMGJlbSz0V3+aHhmnJ
         tPYUROaAW/KUXSX7AEzsPwgi0szeI9pjdaoWTtu1FRCGVrWxf4GYxFUPj/KowfiTGLBG
         0tcA==
X-Forwarded-Encrypted: i=1; AJvYcCXrq+kLA+FcYb4Lee/yRjEPj7SviI+XIIVzQzcYI3pc4k4+KC0Lpnm3fdI1ryCOX6Y4Z/MZt/jDq6NooZCCY2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBJsl0yttXUdWs194CWx4PZpavzisq/PAc9Hm5+EztkklDpxx
	5RaivD2x2B2nDKTxjUr2vc6fDk5BtkaVF9J/QIRy2+SCZWk63SodZsre
X-Gm-Gg: ASbGncu2IBNjsLFuBZK2iPawmhUx/oMYEKxJtadZo+wHlTLuQ2FtKRE+pSYQGfU9LZ1
	VBEMTnoY8zgBqEGxA2BupVhsb/N5z+gLVATFWlw+7ewz42iSzRAhnTIAqTXOt2jmdXRr6OoAkIB
	KCtiIoQ4RaFcAoym5xabUNMl4p7NxO4TXRQtaDCIg7togYt9+BvTIl8w63SYZb561+DhI9fXZ+b
	r1A/UVlhcR57ZgL91enczRkcXZwGV/Xd8r2vMpb7ILjkirv65kufqNku4Z7XUoGVykvTLzpl4js
	ynRZf+vSUN/XCnn8gQbpgljOhPzc6Ow2WnGd72iPJMqvBQ7tgP+N2boljU6ayukRzLWz5FCfcJT
	DXMyGrXfDYlyEJAeh5P02hF22jzWWCvkRJVfZHw==
X-Google-Smtp-Source: AGHT+IEoSQGXZbGinmecOf/ZXQarNjfG39uhHBUMWGfk8LR5uTWXBfvqzZzxScLZFpwuRvqXf2Wc/g==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr95832515ad.44.1757301624231;
        Sun, 07 Sep 2025 20:20:24 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af84de7a4sm176247435ad.7.2025.09.07.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 20:20:23 -0700 (PDT)
Date: Mon, 8 Sep 2025 03:20:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aL5LbrPejURWELEo@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-2-liuhangbin@gmail.com>
 <aLxymFjpPjckFb2Q@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLxymFjpPjckFb2Q@krikkit>

On Sat, Sep 06, 2025 at 07:42:48PM +0200, Sabrina Dubroca wrote:
> > +	dev->gso_partial_features = gso_partial_features;
> > +	dev->vlan_features = vlan_features;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	dev->hw_enc_features |= xfrm_features;
> > +#endif
> 
> I'm not completely sure we want xfrm_features for upper devices other
> than bonding [1], but this will get overwritten immediately
> afterwards:
> 
> > +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> > +				    NETIF_F_HW_VLAN_CTAG_TX |
> > +				    NETIF_F_HW_VLAN_STAG_TX;

Ah.. right. I need more careful when change the order.

> 
> 
> [1] those lines in bond_compute_features were only added alongside
> bond IPsec offload, see 18cb261afd7b ("bonding: support hardware
> encryption offload to slaves")
> 
> but AFAIU hw_enc_features is only used as a mask over dev->features so
> it shouldn't be a problem to have xfrm stuff in bridge/team as well

In this case I will keep this setting. Putting the feature compute to
another function will violate our original intention of putting
the feature compute together as much as possible.

Thanks
Hangbin

