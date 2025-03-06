Return-Path: <linux-kselftest+bounces-28402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03BA54B6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 14:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FB83AA05A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E21C7017;
	Thu,  6 Mar 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajpCiLQl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE56BA4A;
	Thu,  6 Mar 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266277; cv=none; b=jjZAc9Zhz3UlLYLcJQYI5MSfshMt3b9bGXbui04fDud4lrIC5q6I/cTCBKo58yMdjATNnWO1Vpm1vNAwwe+v3jSJn9N9+HsRXFEcmUXIKkdwJl4vg1gnxz5JTFnL/PRohC4sk9QGVBjOsmCEuPIAhc0uiZJBtfiJiK1HM7QXcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266277; c=relaxed/simple;
	bh=ceTk5ZjC2+nhScZyfNEEyeEXW2EalroQXV8HXca9qJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFyi+LaMCn7racqor/vM1ai/Vd/susJVR3Yy6OOvLpLiC7TLvwFDzithEOJfmxagKRhandd5UxfrB32FQzokmN7eMOLn7SFm9+EBKcY08ZDyy3RaUszvaLfT4+G/j+9B5fafeyGKZWADZv9DRKvA3FNwFiI/KG2jEsqTrZRysA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajpCiLQl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so8117285ad.3;
        Thu, 06 Mar 2025 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741266275; x=1741871075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWxKAJFVHJylNyI9jtxBrquI/a//krrQE7gMaAA6tWk=;
        b=ajpCiLQl4v6HGKYk3GxLI8HFgxbUmgeixiOcstDvyKCJdi1La0lfgIEl4OjCWeeGR0
         KlcyHpK3nT3W+ughyOnHmImEU3rm2VoHmg2HVKHBoMmZRQlJVtYmGfxsrUg5IzZ1VWDU
         +2W+D+vk1iccTlxFOHpz0EEIqULxhap1BJilmpfRot3lmPDPCo9fZuo0IKZETSyyibjQ
         6m6UVRt4n0S1udnyWNBx+pzMpgsG6X51VJPFKrwRUNrW0AUDodi62PNI+P6BgDxs4f8w
         u+AnmUFAvVgIzfZ+qd33GKkSDjPMwcBfvXse12cANYXEv/s1mUNv7bbBN/CFwXoLmOnL
         UJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266275; x=1741871075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWxKAJFVHJylNyI9jtxBrquI/a//krrQE7gMaAA6tWk=;
        b=qpd/jMPnxN0N8gaeRQ3LMCf6xmfwnUhGwHCZEVusPsrlbqjkJiXVw9XKZ854U6JjKH
         GiCVpsKMq9Ch2UKBB1AAFtP4Z4i4myHX0dRNbjY4OjN1TZE0JmSopm9b5h34qnJZ4mah
         3jK7kKqkQvFHW5lwNWsE6ofnMWxdZrAqiPZmCizn8C+uH9Z9fwQKCiA+SJUp+VFv4QFT
         knKwuNV3DbfyvFdj1CT6mXdThx9FUmqpMxkvLmgjPfZ53k58TUq3jde7QPcdHVSLiIv1
         eTWfEF4e4DfaZo9k5u+UaJzeFPZTEJmGh1spU1IanhXrFWdZ//el15wNZ2GQlpptbFsS
         xMGg==
X-Forwarded-Encrypted: i=1; AJvYcCUqEgqwmYQQtRPJcooKco39tEwlrxUWDw1Jk9fKzfIvrogbDJUTzRHnwVcW7IA6rKDsxY/RRtfIZluYJtgD6r2w@vger.kernel.org, AJvYcCX9Rl1LT1nPq69qLbtcZCIP2Q40fjigHOES+kqKwVzqz/bd1T6IHWrapgUz/5O68WnK2zF40rTt@vger.kernel.org, AJvYcCXs4TdyWiFXoCTIZRIhLEF+svm1QSCYlwG1WDKLpMkOrkccVS8FOBRsLrc5H4lcggvVouC7lVSsStdQ3gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2MhPqBw85SLAGZptShrm4eSkqPypq9FDyGanTfAO+7vGmKsQ
	MAf68bjQSqj9jsMzYNebpa940hn6Mc8E2PTLbrSDVwTS/HTMdmib
X-Gm-Gg: ASbGncu0Y8k/j0yelTfQiGAEhHv7OGp1RhPVFQq+phGkPUbMNauxmHy3662ciE4k4hC
	MOoA0CVRfB2E6pteGoegm3EzDMN4u3EnZVv0ftl/T6E94oabcRlS7k6o907wS+kTFY3x6ZJFfAV
	82Sa/H4dWZxL94AMopDOpdOuNtVMwvNKOVEfe7hyMOiW7c1mUMOhHmGuAICeW8tO2rpSh8sMJrB
	Fi7UgoZMxEPIRazWOLinrZNJcMVOKrQH4BU6M09roin36ub7Ad78sWvfKL+rOPiipt6uiYPl/Hz
	A0hLZLzkXH6d/rGfIsY0aiBtTwQ1kKdnNbRcLEhFJJdKootxpQ==
X-Google-Smtp-Source: AGHT+IGD16J71n2Pm8M/1w+CsWPpwyYkkyi0HZeHzeB7F2JGPIZw/+hZkqnjgVPWS8nCVpuo0RhFLg==
X-Received: by 2002:a17:902:ef06:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-223f9a45826mr93414255ad.11.1741266275014;
        Thu, 06 Mar 2025 05:04:35 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91bd2sm11371635ad.193.2025.03.06.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:04:34 -0800 (PST)
Date: Thu, 6 Mar 2025 13:04:27 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "razor@blackwall.org" <razor@blackwall.org>,
	Petr Machata <petrm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"jarod@redhat.com" <jarod@redhat.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8mdW_PnpuOeAQjA@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
 <Z8hcFSElK7iF8u9o@fedora>
 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>

On Wed, Mar 05, 2025 at 04:12:18PM +0000, Cosmin Ratiu wrote:
> +++ b/drivers/net/bonding/bond_main.c
> @@ -613,8 +613,11 @@ static void bond_ipsec_del_sa_all(struct bonding
> *bond)
>  
>         mutex_lock(&bond->ipsec_lock);
>         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -               if (!ipsec->xs->xso.real_dev)
> +               spin_lock(&ipsec->x->lock);
> +               if (!ipsec->xs->xso.real_dev) {
> +                       spin_unlock(&ipsec->x->lock);
>                         continue;
> +               }
>  
>                 if (!real_dev->xfrmdev_ops ||
>                     !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> @@ -622,12 +625,16 @@ static void bond_ipsec_del_sa_all(struct bonding
> *bond)
>                         slave_warn(bond_dev, real_dev,
>                                    "%s: no slave
> xdo_dev_state_delete\n",
>                                    __func__);
> -               } else {
> -                       real_dev->xfrmdev_ops-
> >xdo_dev_state_delete(real_dev, ipsec->xs);
> -                       if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> -                               real_dev->xfrmdev_ops-
> >xdo_dev_state_free(ipsec->xs);
> -                       ipsec->xs->xso.real_dev = NULL;
> +                       spin_unlock(&ipsec->x->lock);
> +                       continue;
>                 }
> +
> +               real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
> ipsec->xs);
> +               ipsec->xs->xso.real_dev = NULL;
> +               /* Unlock before freeing device state, it could sleep.
> */
> +               spin_unlock(&ipsec->x->lock);
> +               if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +                       real_dev->xfrmdev_ops-
> >xdo_dev_state_free(ipsec->xs);

BTW, with setting real_dev = NULL here, I think

> To fix that, these entries should be freed here and the WARN_ON in
> bond_ipsec_free_sa() should be converted to an if...goto out, so that
> bond_ipsec_free_sa() calls would hit one of these conditions:
> 1. "if (!slave)", when no active device exists.
> 2. "if (!xs->xso.real_dev)", when xdo_dev_state_add() failed.
> 3. "if (xs->xso.real_dev != real_dev)", when a DEAD xs was already
> freed by bond_ipsec_del_sa_all() migration to a new device.
> In all 3 cases, xdo_dev_state_free() shouldn't be called, only xs
> removed from the bond->ipsec list.

The if (xs->xso.real_dev != real_dev) should never happen again.
As the real_dev = NULL, it will trigger 2 "if (!xs->xso.real_dev)"
directly.

And in bond_ipsec_add_sa_all(), it will set ipsec->xs->xso.real_dev =
real_dev, which the active slave already finished changing.

Thanks
Hangbin

