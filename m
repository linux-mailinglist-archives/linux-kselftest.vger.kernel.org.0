Return-Path: <linux-kselftest+bounces-29194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0AEA647CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B137A70E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D003225A32;
	Mon, 17 Mar 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF+IwOx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80922253E4;
	Mon, 17 Mar 2025 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204513; cv=none; b=IQXN186D4772MQ5R5KogOFTE0OQPjXMl3koHnC2Os5obh7sxz5eSi08rp0RLhf40TwCv2sa93GUGwSt6Z9AxA1Us7KwsFdzP7XfeIx1P+l0v49gZq8j1t+1NVCfmb+P+ECTP7mqykNIp7WFo/PlQczoDfesDQxlYXxljioA5D8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204513; c=relaxed/simple;
	bh=WgoXdLJiBNEJMMeoeNJzawp92D0dkUqgjc8b4u8OfM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9wxpiKsL29o361GBkg/2Yk2uPhWAjKE4Y+iZ+FIPwVZsQiYYZ6HPDQM15u3bNH1tQQEn0elqFQ5y3Vb3t+0uzntCnTA2MBAvCFnitpIq31IlcO0OmvQtLrO2M2yuv6gV5VejvFLMGNiqmAGF8O3s7OUln96JXUCc3EAtMcl4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF+IwOx/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53a91756e5so3793288276.1;
        Mon, 17 Mar 2025 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742204510; x=1742809310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XfnRDuFPcGv3nyYq3wNZc9i5NYc3wanimznJNeWrG4=;
        b=XF+IwOx/m2sYkrMeLquRAchocuwXUhK/YnCufhRuN2Z5tBC44LgtXd5E5gmywesk84
         gF9alZEvXFBZThyntOxGsFcMY72ODlFXz61nEA0Dd+N7euDZw0saL9N5jHNqihoDXR4v
         H6zpORRRaRZZ+Ic75MQAvAFjNWeelCRePck1wDeJYwAWwzPvkpCqUx+e16WI8pXLZk8K
         hFr+2JgfopBDXSwPalDMK51Q+swkiszXwA3VSULycmlv/FwLILPWc8TS/xYsDRDBEiex
         3iYA0C57rDhOg5z0Tkj8uHy06agdubDXO7iKnyGb8zlIrkeiocM41ERmozZ7Qr+3VkzH
         Fupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742204510; x=1742809310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XfnRDuFPcGv3nyYq3wNZc9i5NYc3wanimznJNeWrG4=;
        b=n71dItC+DjJpMZXYrgWr51m3x0kaclKXsOWa8dE1m109R025agttRjKoEIVoKBInhn
         Zp+8uAzD9vvLcllAx/Fr2SaZonZ+7iVvFnZ9nC39RZPtIpcb7oxdXwLtAVeIcUfdPBkA
         ORZTRKiv9g7OGZlt8ROqJxxksS9IpnR49R9+TC1ARl2DBDM/K0oOhA/VZCODG2jcGEzi
         Ec6bCMKG3gk3dM+wTpaSW02/fDx6MLEOddZsxyQ4xFM8BVynJPC1I63bkffW7pdvzC5e
         bJnZWmr4/4ZuptJAh6LBSBXrTF0DjRapB/Wv41PTEBF2dZGl7p77ozTNv3YALKsQ/rkA
         seyg==
X-Forwarded-Encrypted: i=1; AJvYcCV70dcVxXw+dMa9lL3m+Oxco1R4lQT00qAZjprT6fp34tzGSbyx9LPUjPrpERiWqrkRE9WOWVE2uIWDQibGhY51@vger.kernel.org, AJvYcCVSI6xtjPzzFeS8XDFW55h7qAjnXvH2eUrS2A7TGHOf678bDEOSrMYJaMckiq9Y0lx9XijMqowB@vger.kernel.org, AJvYcCXHieT9LkXcPWpH9OSKHN+ItOBIbeGMJSG7Swlblf6rtfI8TJGEZdNz5Kr/9ntxrZJZso4crVpRJo35Vqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I4j9S82V42rXFoK/lcGM3d5bsnDOPA5R1MpD0d20qC2wVTMG
	WrEGfgaFoF2NPshssnPmNB6UFYa2H82A3+dU8wp6DuyOj2CdSb5UcSmgwEBwD/vk7foXwcmIvcz
	dcCRa8R36jH4TF4rOzn91/BUgdBCrJKEaaWw7Dg==
X-Gm-Gg: ASbGncsFMy2tDLIu14scUB/Km3pTK1lRSgsRvKUgrzywiYEq/Fl8koPmTGZvbxuu9zv
	AzRpNnjD0n2f+8zyIaBvRh1Ax4q3QIpUvtt1pwyAuyJH01H2MTHCMTwEZsBTYWJm/mrk7FvxmOQ
	RvvcczOQsNZoYEfkH7te5PF40aBfIFMqxqd03g+mQ2sw==
X-Google-Smtp-Source: AGHT+IHecUoXKGAeLJ4sKHHMSQWvvRkqT9levx35XDLPlH6rsi48/CowlJANQ7a2C4L6J9CWmMAeDZfnMSiJVxYp+ig=
X-Received: by 2002:a05:6902:208a:b0:e5b:3823:4176 with SMTP id
 3f1490d57ef6-e63f64f855amr14527392276.13.1742204510491; Mon, 17 Mar 2025
 02:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
 <20250317060947.2368390-1-dqfext@gmail.com> <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
In-Reply-To: <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 17 Mar 2025 17:41:39 +0800
X-Gm-Features: AQ5f1JptaNz1J3kvfSOyKipGWiLpaJWangM2TfyyVpkqlY7egoQOh0qGwq6CYZQ
Message-ID: <CALW65jZe3JQGNcWsZtqU-B4-V-JZ6ocninxvoqMGeusMaU7C=A@mail.gmail.com>
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: andrew+netdev@lunn.ch, donald.hunter@gmail.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ryazanov.s.a@gmail.com, sd@queasysnail.net, shaw.leon@gmail.com, 
	shuah@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On Mon, Mar 17, 2025 at 5:23=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> >> +static void ovpn_setup(struct net_device *dev)
> >> +{
> >> +    netdev_features_t feat =3D NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F=
_RXCSUM |
> >
> > Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum i=
s
> > not handled in hardware.
>
> The idea behind these flags was that the OpenVPN protocol will take care
> of authenticating packets, thus substituting what the CSUM would do here.
> For this I wanted to avoid the stack to spend time computing the CSUM in
> software.

For the RX part (NETIF_F_RXCSUM), you might be correct, but in patch
08 you wrote:
> /* we can't guarantee the packet wasn't corrupted before entering the
> * VPN, therefore we give other layers a chance to check that
> */
> skb->ip_summed =3D CHECKSUM_NONE;

So NETIF_F_RXCSUM has no effect.

For the TX part (NETIF_F_HW_CSUM) however, I believe wireguard made
the same mistake.
Your code both contains the pattern:

if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL && skb_checksum_help(skb)) // ..=
.

NETIF_F_HW_CSUM causes the upper layers to send packets with
CHECKSUM_PARTIAL, assuming hardware offload will complete the
checksum, but if skb_checksum_help(skb) is invoked, the checksum is
still computed in software. This means there's no real benefit unless
there's an actual hardware offload mechanism.

+Cc: zx2c4

>
> I believe wireguard sets those flags for the same reason.
>
> Does it make sense to you?
>
> >
> >> +                             NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
> >> +                             NETIF_F_HIGHDMA;
>
>
> Regards,
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>

