Return-Path: <linux-kselftest+bounces-28537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E604FA57959
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A86B170261
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79E01A2632;
	Sat,  8 Mar 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5oOiuDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC66322B;
	Sat,  8 Mar 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741424097; cv=none; b=aJ1n7KJ2buXeDD1NqIpQKL5+BSa1lKzqba9DXY0y8fCmxc6CsIkaUBikSAY84VsVB4W4+mj5AUsIXbKgxmpOq8Mwh5iq1mYOeHGm4ZQoNex7lRN4GrRtXu5JmWCtloE6g3yv5WqobONptx9XGoOHF6lscZoeq51y1hw9Il6cBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741424097; c=relaxed/simple;
	bh=9hUfcwgc9NMp39VZsIy/9tZ/bsjGfe3p3+gbAqS06HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TehFpcsdvjgeNQFSQCQvqlEx4esJGF9PWhgdl1ct4+wmWiYagB3Uvi8mliVKAcryzK4Ln+5MhpYqUZV9mxHAxzmJYcZ8hB+GgdNowhiab2uSd6jpQm84wc0jcKpI/QprKQ8Vf1iZImwk1IHfWYXlzte6oMjR/7vjsvyYhIjMsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5oOiuDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E40AC4CEE0;
	Sat,  8 Mar 2025 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741424096;
	bh=9hUfcwgc9NMp39VZsIy/9tZ/bsjGfe3p3+gbAqS06HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5oOiuDnV7YwOgHL38/5uSUO/+Sg3d22jGakLTxTXe724I4ACInErw/3tBSjLn8mm
	 t+xSeuOcPeV/PG1sLLls2OvfDNlUFdNlp7pI8ZYnw4wiBOtrPJqfG7Ex24ueSnpIzH
	 b+CHHofzLdwI0cYRKmjo+wSWAJMWiGhNZ3AxzK8Qo/y4E9EdvTg5hrl5ve2c5lnD3t
	 NMZ8d9xMWlViaqUKLUTFvCV+g6+X9iYu3NHcA7vw/cJ91UiGvNTPk9GoI3UtrWFbmY
	 GPJBHLDH5uiJ/AdDLtLMHxgof6AMO6Ae2QazaDB5BLS14UgX3wBx3OT1AxrvlKECVR
	 Vf8OK1rrDGPDw==
Date: Sat, 8 Mar 2025 08:54:51 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>, Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Message-ID: <20250308085451.GL3666230@kernel.org>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307031903.223973-2-liuhangbin@gmail.com>

On Fri, Mar 07, 2025 at 03:19:01AM +0000, Hangbin Liu wrote:

...

> @@ -616,9 +615,22 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  		return;
>  
>  	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (!ipsec->xs->xso.real_dev)
> +	list_for_each_entry_safe(ipsec, tmp_ipsec, &bond->ipsec_list, list) {
> +		spin_lock_bh(&ipsec->xs->lock);
> +		if (!ipsec->xs->xso.real_dev) {
> +			spin_unlock_bh(&ipsec->xs->lock);
>  			continue;
> +		}
> +
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);

Hi Hangbin,

Apologies if this was covered elsewhere, but ipsec is kfree'd here...


> +			/* Need to free device here, or the xs->xso.real_dev
> +			 * may changed in bond_ipsec_add_sa_all and free
> +			 * on old device will never be called.
> +			 */
> +			goto next;
> +		}
>  
>  		if (!real_dev->xfrmdev_ops ||
>  		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> @@ -626,11 +638,20 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  			slave_warn(bond_dev, real_dev,
>  				   "%s: no slave xdo_dev_state_delete\n",
>  				   __func__);
> -		} else {
> -			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> -			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> -				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> +			spin_unlock_bh(&ipsec->xs->lock);
> +			continue;
>  		}
> +
> +		real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> +
> +next:
> +		/* set real_dev to NULL in case __xfrm_state_delete() is called in parallel */
> +		ipsec->xs->xso.real_dev = NULL;

... and the dereferenced here.

Flagged by Smatch.

> +
> +		/* Unlock before freeing device state, it could sleep. */
> +		spin_unlock_bh(&ipsec->xs->lock);
> +		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +			real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  	}
>  	mutex_unlock(&bond->ipsec_lock);
>  }

...

