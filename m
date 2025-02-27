Return-Path: <linux-kselftest+bounces-27737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D55A47EF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDE2188FFA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4822F3A3;
	Thu, 27 Feb 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTLi7iSH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740B22A7F6;
	Thu, 27 Feb 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662529; cv=none; b=PVgQiePCpG60yudTFg8Ep4jJnwGoRoxys3tvZIUmYpyuh7ivC1G/8GAknuGujco9nfXSiv3czPBNIv9hMXBX/YE7bHXPv4Ym/abcKGPRbfFZmGTEIV4K8lQWyG5nh/C8Dms/aEaYaat4cJ5k3s9qVy+z2gqGcOdozeFsuISI1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662529; c=relaxed/simple;
	bh=r/CLzxCZ5FYGCMymFFiFdSPlgQsWDLWMufpnP3S+8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZpmV4kouiGhtIUEOyve6w8qgSRsOD+D9PoHAN3aCiFM9dEjUtdM+ZBkQRKfHXlu9pvYBEzalRGyQXpaNXivEI6ZXJPBXZygzLl67DQvaPLjQh+iEXLEEKwbccLl6SYD/yPb5IYtPfuj7HHa8ESYtTSqLKPUIlVSINHkVXGH2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTLi7iSH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso1479825a91.3;
        Thu, 27 Feb 2025 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740662527; x=1741267327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTwlexDbSiKgA71dqOMrXjGZFVAtedcpmBJNTgk17lI=;
        b=dTLi7iSHMLtX9WG36V/GcYlgWeAVKHaWwp95FxhS5JFdxsZm1iTTB5YhaULC1Gv8SG
         B8XKdRBlBHATO5d2Y32SezV65j7cmsT5NqFodoIFjb1IjBhXOIwFtgaMK7Ci+evjyuZW
         uTXGhpUs8/jWxumRBAvdIGWSJmiNwqcY+NEsLGVqTV92hScCjk81sj6bf4zX4pkCR1aq
         TmIV8uvivXFzeQB4qzzjb1qFQT1daltne7lV0C5iLwuk3l8c7A/D6jIKvbMWngD+8LtQ
         SmQttyz9R4YVVS3l1KqfXmOYzb8ZDZGiAgbrl6FMsSn8TkpZIQc7enkKj8tpyw9MFu+n
         cc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662527; x=1741267327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTwlexDbSiKgA71dqOMrXjGZFVAtedcpmBJNTgk17lI=;
        b=dxCEoaqBq7Qt+b8FsOywVYLO7Kh+c18Yyk/IfCIDNtBtj5gb+XQh7+h4ejGFJWh1cA
         3WAFTjv3p7fJBO+bnGu6dFOBZSlm+iyAR7KNVaM/mnJXTCtq3jpKDAIiMXsZKTHg3rOQ
         HjRdpK9hSijSTKKQiiBMnL2g2eBWrY4KBxOhnlSCsTo2kdJia5a/YArrNRoajjx5p77i
         RWrU19Wyn4H0VFXf4j/8sKtgN1q/aq6WeTbaj7mFvUkSn9xkcV4JJ5yRhGAiK2uo4BZh
         FNBRbTo7hpQifrY59O6s+usLed84yZcpDlJncCWCkE/UnvdkfBlVlQBIUr9BQ4obC8R5
         fraA==
X-Forwarded-Encrypted: i=1; AJvYcCURn0QC3wd1ZAFMBzPh6AyzrNwa4otVL0G7OViEdHA8QvRWYB8hqMsyzmGECDz3JFNL8PD/p8Z3QaFbNXU=@vger.kernel.org, AJvYcCW0T4bPhMXD4gIbXiY3BkmzwQOJ5tTcmM/CN5lbkqvCR0qQpf0ZfOV8kGjohvIJsO8CZxPPwQJoRw59+OqXp19p@vger.kernel.org
X-Gm-Message-State: AOJu0YxOM6w0hREAoEan1d2cv/pFPPUPANMQjIWsz88TJoJW7xIsxvDN
	2GXqdZ9zDg3DWPmXjFoW83rpdd8x8qi4VITWEAyJ46In7HkdBrGSfVWSe6gqZC5HOA==
X-Gm-Gg: ASbGnctaZNkQHfjoaNyGTF4nrRS04ubV+ebLSK1pHVSweeS0ZV8jB/TM+qX21zAi78p
	svcQOJr2wfSIipHBZ+mPSfbrO39yCMcB5V7GTrkNCo+zFqApr1AL0crQPFyvR/Krp/WHxMbIOSi
	iXiC3CYOs/ZJycdopnKPuHjUzevKszZWfHR+8hRL3auhdeT+/GVM+Adb+3lJH3wm67U9itUBt4x
	jFyHVXwn9H0EqprAVtsvg4ougvKOyITCHFk9fYTFwz32UnQtTLuqK49jHJ3QL1LOpIUUPakVAZS
	OassrdRBtHV9Xkq3tajTp7mUd+HwsrI=
X-Google-Smtp-Source: AGHT+IHv8UFqqZlp9xxiAF3Mld0xObzcFjK0O2fQo0lYaCrVgqtD/DIuA9W8ExAUSaRUUAIHzpeO8g==
X-Received: by 2002:a17:90b:1808:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-2fe9e6cb035mr6345024a91.18.1740662527388;
        Thu, 27 Feb 2025 05:22:07 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696e40csm1536583a91.34.2025.02.27.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:22:06 -0800 (PST)
Date: Thu, 27 Feb 2025 13:21:58 +0000
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
	Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8Bm9i9St0zzDhRZ@fedora>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>

On Thu, Feb 27, 2025 at 11:21:51AM +0200, Nikolay Aleksandrov wrote:
> >> @@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
> >>  
> >>  	mutex_lock(&bond->ipsec_lock);
> >>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> >> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> >> +			list_del(&ipsec->list);
> > 
> > To be able to do this here, you'll have to use list_for_each_entry_safe().
> > 
> 
> One more thing - note I'm not an xfrm expert by far but it seems to me here you have
> to also call  xdo_dev_state_free() with the old active slave dev otherwise that will
> never get called with the original real_dev after the switch to a new
> active slave (or more accurately it might if the GC runs between the switching
> but it is a race), care must be taken wrt sequence of events because the XFRM

Can we just call xs->xso.real_dev->xfrmdev_ops->xdo_dev_state_free(xs)
no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
xdo_dev_state_free() every where may make us lot more easily.

> GC may be running in parallel which probably means that in bond_ipsec_free_sa()
> you'll have to take the mutex before calling xdo_dev_state_free() and check
> if the entry is still linked in the bond's ipsec list before calling the free_sa
> callback, if it isn't then del_sa_all got to it before the GC and there's nothing
> to do if it also called the dev's free_sa callback. The check for real_dev doesn't
> seem enough to protect against this race.

I agree that we need to take the mutex before calling xdo_dev_state_free()
in bond_ipsec_free_sa(). Do you think if this is enough? I'm a bit lot here.

Thanks
Hangbin

