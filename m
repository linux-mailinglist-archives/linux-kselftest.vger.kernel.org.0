Return-Path: <linux-kselftest+bounces-28312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF57A50188
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC61894433
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04F24A077;
	Wed,  5 Mar 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1reZuOx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42824394F;
	Wed,  5 Mar 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184034; cv=none; b=OxY0Gj1MPd8QC0VgGmX2BHxG+y2cmEvqBKZ0mvmeqYbQG/UulZCCIjNEr5dVY3iUbb36YuIQGdDWSW9OGz2BjX5qeUutO+3C5Cv6IHxTRmuO6eTt39oWWG2GEKyk6HDxbjWdsi6Gg4BZwngSJ1D2BK/igT7TvDWxzSwQQtGKZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184034; c=relaxed/simple;
	bh=vqRrksxWjJzpRt2P7QRzxY2a8o64gwEGx6kR+lsudao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH4YuC9tw7iy3tYggia1dKSjmtWhNywhjXOU0yqy5PkdfuJ/IlDsLH9R5OW/V9sxctVOGql/XiUBSTtqZVi8UqRKCHPMQt9I7GS4t+zoj+YRPbTz3Ozst5Y0eMooqxNskfiSVo3f75GPrpZ7exlk7RE/CZpA5fY+7/NDkoxzcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1reZuOx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223cc017ef5so50337655ad.0;
        Wed, 05 Mar 2025 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741184032; x=1741788832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CX9pKsz4EYUoI2yHw+6qgIAXfkHRhkoto6+P8qmujA=;
        b=V1reZuOxk4T5fGO5Celvi30AZ+lzk7epLKWEHJQfNi55x2AcIhEjFptDnMkZs194PR
         ZDvTm79+lxKtL6gDSQbIvznxHSP4V+fmHOKeDCOH7qiltMi/zIK9m55wUDxPykwJVUo9
         zCYhpEFxD+5QlQgkmKMYQtF6e9Qj0kylmz6h+L9P3TfW1+6BY2wHohfweKOOJteJHlT/
         tWM47nmlbBC/kkHBskk10xg8Pwo7j9Ba68pGE4Iy42+J2ePeGuKa6dSxArf3KZE785Zy
         102vjBeKoaVt5Zcncg5p1RbA3HT3cj3nroqKt/D5KHrpqdot/4hBFQIb/PkyjHa+eIdf
         er9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184032; x=1741788832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CX9pKsz4EYUoI2yHw+6qgIAXfkHRhkoto6+P8qmujA=;
        b=aspdQ0hvOmUlgdXdxGExR/XnWx/iGdP0yW87rCQ+iAgEmrAqjZvMQkAcvCOo4M++Px
         8NXl7/8yyxww+MkI5O60Z8C/lNavmPNd1q38eZ5iPQJKlzwll4/3YyX8i21dZ5z5/USr
         LytvsxTsIrhLCibqAWHjglRZwF7Z7M+ULRbK3+PFOH14D9IotLDfFVqqKXnEyfaDAIQI
         ideAvZ5lAc3okgA6khseFfxVB7CVPufB4BvxlbhajaIQbBmWnBq1TFiAlwv5XPd6jlWO
         Y7uWezW1eNlAOzScRTndDAu6ihpTgJpnDQP58BNgJEVtSqplcfSZBUvfqcH+hmupwA/1
         bIQw==
X-Forwarded-Encrypted: i=1; AJvYcCV22oXJct0qHElKeHcduy1pDqRvMmLf2dEw2gKBtZmDpOtEe4vxkeC5RC7jIG5wEyaThSPe19ycfHW7EPg=@vger.kernel.org, AJvYcCXHR+HctgFX/Ukq2bUJJwhwLhk1ieK+cdY8H6+0FZaSk29aEJmQ6GQYn/CIasR51wgLVDtysBtet+O4xiF6Xw16@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzJD/uwr17XyGnvI9ifo1gLRiPy0OqnrLsT39XPAh3qv9BfzL
	JkwFG2uVLTvlfQlOL+l+0TCe3rlHzOKwV0vhOgEbepY2exRCHz8CdTzYwd820UavDw==
X-Gm-Gg: ASbGncv0HxpTMYvP1j+HCriH9iZ2B+zaSbbZkz2nfkI8au6ignSa2JkGCMYA0bnE3LZ
	FAbsKDHjIkBnVKobK/pIMgS2wAhUwK0QkHC//hzZ1tym3dnJZLeDwt7Ahymhapr0l2wcTA/3uAK
	g9CcDxSDwTO4bDuwCJQILYkiUbDu387oxe0XZhkYXdfdOp7qmtgsQSkmJSF9Fw03Yh3XmL/0nh3
	yVliBOzQCdPBA6d6iGN5CbTDTZhK0A8D4e0b3YN0cjQ4wvB6iGhfzxzn4U1g9DteD6KrLv+aGli
	aXXD8femfriEB4oCvPO0+pNckodx82igHMCoUZ7AiijT2wKEYA==
X-Google-Smtp-Source: AGHT+IF73abicY9+nvyU3EY376F9EK99tSA74sxVMXsRGs12/7ADb2qcZlm/uMZtJ+7cIbLmC7rLwg==
X-Received: by 2002:a05:6a00:2d0f:b0:736:4abf:2967 with SMTP id d2e1a72fcca58-73682cc41aamr4681631b3a.16.1741184031574;
        Wed, 05 Mar 2025 06:13:51 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec9csm13410743b3a.146.2025.03.05.06.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:13:50 -0800 (PST)
Date: Wed, 5 Mar 2025 14:13:41 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8hcFSElK7iF8u9o@fedora>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>

On Wed, Mar 05, 2025 at 10:38:36AM +0200, Nikolay Aleksandrov wrote:
> > @@ -617,8 +614,18 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
> >  
> >  	mutex_lock(&bond->ipsec_lock);
> >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> 
> Second time - you should use list_for_each_entry_safe if you're walking and deleting
> elements from the list.

Sorry, I missed this comment. I will update in next version.

> 
> > +		spin_lock_bh(&ipsec->xs->lock);
> >  		if (!ipsec->xs->xso.real_dev)
> > -			continue;
> > +			goto next;
> > +
> > +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> > +			/* already dead no need to delete again */
> > +			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> > +				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> 
> Have you checked if .xdo_dev_state_free can sleep?
> I see at least one that can: mlx5e_xfrm_free_state().

Hmm, This brings us back to the initial problem. We tried to avoid calling
a spin lock in a sleep context (bond_ipsec_del_sa), but now the new code
encounters this issue again.

With your reply, I also checked the xdo_dev_state_add() in
bond_ipsec_add_sa_all(), which may also sleep, e.g. mlx5e_xfrm_add_state(),

If we unlock the spin lock, then the race came back again.

Any idea about this?

thanks
Hangbin

