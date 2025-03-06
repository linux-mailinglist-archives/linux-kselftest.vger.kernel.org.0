Return-Path: <linux-kselftest+bounces-28403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36448A54C2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A0718970F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB720E334;
	Thu,  6 Mar 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/3cMHPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647320CCC8;
	Thu,  6 Mar 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267767; cv=none; b=UwFd68M2KAqoam39zGLdNKbuflkFyXNCbAZVQ4SQzz20/X9XBhqPY+b6hI+feUvHPdI8B7iV2BzJRMqL9sXq30f3FX9CljePbKSQWS1LnQMbRQF+Nc61pugg/XI7gUzpGpIEXg2kuPZZ5IMASwENoWI+oXpnDpSIyNTo2VrMd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267767; c=relaxed/simple;
	bh=NpTgRj4T32Kir8hSGmXbmVcavENIjzDMEGc/xFU2qnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYLiP8CNv0g3eNcP7EBQHI46HCOhDIL0JEQgNNAAMPLbbuoXShXbCY2BhRsYMlOvIxyZEk3ZeUaB6di2ZFxH2rSmlUkMuYcAmcAbMse1tFVmpWwtZx+8R5AM/0LPSFyRoDfrHLaFGyPI8KkiAixR2kfRcPi3opZ6009iRfX04M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/3cMHPp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234bec7192so13605145ad.2;
        Thu, 06 Mar 2025 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741267765; x=1741872565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPmmVqolUe14kI3ULJzdQmwFUK3yVpwsyWJQGGs0vwk=;
        b=O/3cMHPpFY6JYIkGs+8Gihmg55cd7b5Vr7hkhJuC94ssw80QDj5ekFUtQ/MkAgd00/
         TODulRrrHspqlw1s1GujxnmBpoH9ufSPi7Tf3zeYhlSQd12pOaqYTe6+wfPF0av1Bsj7
         V3m62ayxs0P2ibmNNMG2A7vAExB/5ZxqPXRL1U/wc6V+yQfnGQfyqHC73RLhcBnYVMDK
         A1jecn9mQw6G4bR7fvvvAJkiDphRsWZwgy//FeHQu54IsZ9IXdhHJYYyMV1kyfdksaZG
         SVJl7rqSf1ZhiWXvJJgwjRRJnE8hrqY02KepX4hx8UkOrLTQGfe2XF2zEX/lZOvKAnoB
         KWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267765; x=1741872565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPmmVqolUe14kI3ULJzdQmwFUK3yVpwsyWJQGGs0vwk=;
        b=Za2NA85S/R4OFzZkpztnQ58pz+wWXpWxhcIZflXk7KxWo4rQbquRCxzOg+iP2uOXUS
         sn0lE0so9CPeIRbK6lOUX1lvN+vNR3hpTMfCEcBP4gIXURnwZFC43axUD62PlaQobL+1
         c2zp5+TPuEONNQQgcFMdhfIh4iu82UQqalBQ8u0JCGoVnNq0LKqq+pYnKncV/wM1nhuM
         sd76uWF5pvBNu/6oHAxrZLZwO54zKgP+U8HVOo89W1XuwGdgbPJshy2cLLZ0XwRWqzZG
         gWa+sXmXKO6FkvClDCNowWyGQeTLXY/BASMHRbo2THqZObNsqk2ZJ0sfr9sJC+tUw3Nl
         +4tw==
X-Forwarded-Encrypted: i=1; AJvYcCWzUwJ/RONsnpH5nyRxeCBFgeVgByRfH0+wFTT5XS/NVJX5xROrL5wJmeHrTbcc0FtpkX2TpQ4W@vger.kernel.org, AJvYcCXLDLkwz0g3pBFJTJogqFR59J9y9LIyr9mqqlUPRMjuJpY1DSxbPXpUuvlEtmOD1icyjWiSXTsgKmtduvDn+WvK@vger.kernel.org, AJvYcCXNyJHq7vc1FEN7FJM7R8nkmWoPwDz+x4KSqWq2uYlDFEqMxJo87C71l2wdLaea2TC2OQtucPII7hqpt6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwRdaiDhHmhHkFbbEdKa1iodwyJxDa9SUj+1/24pfLkN38gDA
	S3GBM5kK+SDaPpx01o4xdV0DNSf6C8v26jdNLxXd4gEBO5Q6/unq
X-Gm-Gg: ASbGncsI6ksgQpM1xallMrrBrd8Z9YtH/94lQnBDBdvwnoe2zK6dEsjZGD4dRu/bhIW
	v6c+i1FR9Khuc7yoytjNAViPnBpKm87QxaewLB5P3igQcddCys/CjB7EWSClTAESUGsfos1S6Jd
	8hGkJSyEwgnrxCh9/Q/fBK/G6J5CSjmjQZFlTE5CGlSjcS/MDgZ33oM6L/bCnr4AZs7NJCsHijH
	gUZTIx0JoiERqyCQE0JjpYjg9xOtnwvn27PlE8lYRVEbWgHIyo0oljBYBCI7eCBP6khvFYzMIDl
	dSNQyAbbA4Gn/HZBn7G7lLAmfdHUIogxIT4zvAuYnXdnygMH0A==
X-Google-Smtp-Source: AGHT+IFY+cYCkzaiTLX3WEbwqeJCHIk9o8qrMibv0hyFPF5zYRWNTVoXpBXKn61/ivsfKZdrnq8KwA==
X-Received: by 2002:a05:6a00:4f94:b0:736:3d6c:aa64 with SMTP id d2e1a72fcca58-73682cc533amr11194009b3a.21.1741267765508;
        Thu, 06 Mar 2025 05:29:25 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369820687csm1297266b3a.34.2025.03.06.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:29:24 -0800 (PST)
Date: Thu, 6 Mar 2025 13:29:16 +0000
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
Message-ID: <Z8mjLEx37F-zaE0i@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
 <Z8hcFSElK7iF8u9o@fedora>
 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
 <Z8ls6fAwBtiV_C9b@fedora>
 <Z8lysOLMnYoknLsW@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lysOLMnYoknLsW@fedora>

On Thu, Mar 06, 2025 at 10:02:34AM +0000, Hangbin Liu wrote:
> > Set xs->xso.real_dev = NULL is a good idea. As we will break
> > in bond_ipsec_del_sa()/bond_ipsec_free_sa() when there is no
> > xs->xso.real_dev.
> > 
> > For bond_ipsec_add_sa_all(), I will move the xso.real_dev = real_dev
> > after .xdo_dev_state_add() in case the following situation.
> > 
> Hmm, do we still need to the spin_lock in bond_ipsec_add_sa_all()? With
> xs->xso.real_dev = NULL after bond_ipsec_del_sa_all(), it looks there is
> no need the spin_lock in bond_ipsec_add_sa_all(). e.g.
> 
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 04b677d0c45b..3ada51c63207 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -537,15 +537,27 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	}
>  
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		spin_lock_bh(&ipsec->xs->lock);
> +		/* Skip dead xfrm states, they'll be freed later. */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> +			spin_unlock_bh(&ipsec->xs->lock);
> +			continue;
> +		}
> +
>  		/* If new state is added before ipsec_lock acquired */
> -		if (ipsec->xs->xso.real_dev == real_dev)
> +		if (ipsec->xs->xso.real_dev == real_dev) {
> +			spin_unlock_bh(&ipsec->xs->lock);
>  			continue;
> +		}
>  
> -		ipsec->xs->xso.real_dev = real_dev;
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
>  		}
> +		/* Set real_dev after .xdo_dev_state_add in case
> +		 * __xfrm_state_delete() is called in parallel
> +		 */
> +		ipsec->xs->xso.real_dev = real_dev;
>  	}

OK, please ignore this, the .xdo_dev_state_add() need xso.real_dev to
be set first. Then I'm still wonder how to avoid the race before
.xdo_dev_state_add() is called, e.g.

 bond_ipsec_add_sa_all()
 spin_lock_bh(&ipsec->xs->lock);
 ipsec->xs->xso.real_dev = real_dev;
 spin_unlock(&ipsec->x->lock);
                                            __xfrm_state_delete
                                               - bond_ipsec_del_sa()
                                                 - .xdo_dev_state_delete()
					       - bond_ipsec_free_sa()
					         - .xdo_dev_state_free()
 .xdo_dev_state_add()

Thanks
Hangbin

