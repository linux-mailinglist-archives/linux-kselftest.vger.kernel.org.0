Return-Path: <linux-kselftest+bounces-23810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12D9FF59B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 03:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167D73A27FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88980D299;
	Thu,  2 Jan 2025 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn91vxzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B694C70;
	Thu,  2 Jan 2025 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735785904; cv=none; b=R8ZQBsmq+CjUHTlkI3L39T4aNIxlmPjhhwNexPXIN5JOcKK8Uub46EyWWnruzpJkQ1iACp1b1tspYwfZIU1qo3YGlj23rBf2ajq6yESKiCZzv7HdUk+R1Cv5CUWMAN4GD7hB4ua+6khmvc17cU+GQsYZiQjrz6iDX81hdIbvO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735785904; c=relaxed/simple;
	bh=b+udHYxmnAWh83Ndm9I2k1MeSwhvbE1pnhaSL35u+Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoO5Yh/vN7Dl1I1s1NQUL7+DO1b14obH2tDBYYr7Gk5OnlatHCEmBWsSIvNXL5m/n0EtwnjdEs+of80uoYELUTuHLGPxcbUT3eHHRohv2dg6Oj6l7UlKNTeZPNHYF5BWWmvuz+HWgOOSJdVThzv4ZPmriixBgoT6WSkZVBNWi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn91vxzr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so106327815ad.0;
        Wed, 01 Jan 2025 18:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735785902; x=1736390702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NV+H7z8d5Oed173rvGxNf9WBhBaq1lMGljWmWtTw8qU=;
        b=Rn91vxzrMKFD+p5ZKBwsyoFZ9Ch9H19BCKlz1dtb/jVoTqNKJDf69b3c8ShzOke0HF
         6wqtCyysDdVOAjb4wIb4PgFJgPfhifAMrR7TTeb+lM+svxEpddfj/qOo8sHTtmIFBcB9
         SelvNkMHF+eYiR5jnu6Sop7WG2mf94yMqUwziAhfStHXAvEyaHK3fTj13RegH8t+B7HY
         hTctGhjGAUtbJH7qMeykpj+niklYoEvwpbyqxyoweRwM0XYznPPC03uZ0amVr6UJHQ16
         eKKOKN37osLmTrgwV7zSlXYeIt5dT0d59STF0MB+1G93dYZURA+7p+FNOAKtETcoOzOr
         rBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735785902; x=1736390702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV+H7z8d5Oed173rvGxNf9WBhBaq1lMGljWmWtTw8qU=;
        b=q8uN7kZrScjdM8v2aRSkj7VXdFUhh3+vvNup/BxOv393IN1o1qCrva+HDtU3s9Angd
         PaJCdmCATRztb3AivnwneIoZo58mC0oWtsRgAjxLZgL6jnc3W+WiOcCYvVypgtOogvs6
         0G0e/kqeuzQ+w1DiR1xKWewiPL0mPblXxmUfhqrRU3ud3FG7tedZQLceeJAwkthmfY95
         QNtk/Da/NARQlNDWTv7269I1AtkyuX8xusWrHvcSo/+3u/N3YcPwK4r09ZwWUZOMQzVx
         SIAtyY6kIhkh8hLpWkyWSf0pciPkB1a8opbQpY4U96KIdQoVEpp3vwjWIZO8CCXr0w4E
         vhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vFNGNZbD5CIJAZxHXSMecvW9r/c10YL4ulPYPupYbVCnBzjy8f3Gai1UDTFiRYE1kM9or2OqF3Lb5qs=@vger.kernel.org, AJvYcCVa8vUeKiG1SBPFJnroLxWMvAsZm26MrgAeSTj9nUatPZyhNVJHXShMuRDxGdtZ1sETwuzPa0wMM5bsjVVUeLMP@vger.kernel.org
X-Gm-Message-State: AOJu0YzafPertDu4mVGuFMMwX6qJw7HTZ2YftrURm8b6PL6CzN15TVnO
	GFLw5NNerfTptIy11QZ7kHuZlxGDNM4FSe5F5EfgpMkdi86hr/Aw
X-Gm-Gg: ASbGncsridZqJVfqAa6Dfg+NpnQpgtNdmsYOOBmGpkCEFyMo+HMh633oGUe9EMmLIsv
	6gOHU9uJb1tpbRga+fQwD6DPdkfUJsS+Wn4EFX101tt6fZmuQh4I+FQZ3nC4dBtMdpC9ZGWzC79
	gYBM4Z75PioRhTq5jvFgARPcDO9FEMvD0CoSwpGd5fmzxes3cF1VQvD8ZKb2v0HCtVH7mn77vm4
	NPhFKTKlcAT103LPy6nUT5gcQ+xKTXcIFjxRFZ8J/F6vrX9eS8FV1tStykyxw==
X-Google-Smtp-Source: AGHT+IH3rf1kcd0vrNYGIZA/SByquhhX1V9Kp53NNGLWfIEamjc9Cv0r+C0SbulHDdaTKfQ4pUT83w==
X-Received: by 2002:a17:902:c40b:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-219e6ebb6e2mr592607825ad.32.1735785902284;
        Wed, 01 Jan 2025 18:45:02 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm24991003a91.51.2025.01.01.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 18:45:01 -0800 (PST)
Date: Thu, 2 Jan 2025 02:44:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z3X9pfu12GUOBUY6@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213193127.4c31ef80@kernel.org>

On Fri, Dec 13, 2024 at 07:31:27PM -0800, Jakub Kicinski wrote:
> On Fri, 13 Dec 2024 07:18:08 +0000 Hangbin Liu wrote:
> > On Thu, Dec 12, 2024 at 06:27:34AM -0800, Jakub Kicinski wrote:
> > > On Wed, 11 Dec 2024 07:11:25 +0000 Hangbin Liu wrote:  
> > > > The first patch fixes the xfrm offload feature during setup active-backup
> > > > mode. The second patch add a ipsec offload testing.  
> > > 
> > > Looks like the test is too good, is there a fix pending somewhere for
> > > the BUG below? We can't merge the test before that:  
> > 
> > This should be a regression of 2aeeef906d5a ("bonding: change ipsec_lock from
> > spin lock to mutex"). As in xfrm_state_delete we called spin_lock_bh(&x->lock)
> > for the xfrm state delete.
> > 
> > But I'm not sure if it's proper to release the spin lock in bond code.
> > This seems too specific.
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 7daeab67e7b5..69563bc958ca 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -592,6 +592,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> >  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> >  out:
> >  	netdev_put(real_dev, &tracker);
> > +	spin_unlock_bh(&xs->lock);
> >  	mutex_lock(&bond->ipsec_lock);
> >  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> >  		if (ipsec->xs == xs) {
> > @@ -601,6 +602,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> >  		}
> >  	}
> >  	mutex_unlock(&bond->ipsec_lock);
> > +	spin_lock_bh(&xs->lock);
> >  }
> >  
> > 
> > What do you think?
> 
> Re-locking doesn't look great, glancing at the code I don't see any
> obvious better workarounds. Easiest fix would be to don't let the
> drivers sleep in the callbacks and then we can go back to a spin lock.
> Maybe nvidia people have better ideas, I'm not familiar with this
> offload.

I don't know how to disable bonding sleeping since we use mutex_lock now.
Hi Jianbo, do you have any idea?

Thanks
Hangbin

