Return-Path: <linux-kselftest+bounces-38749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B81B21C4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 06:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F095008A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 04:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91D2D47F3;
	Tue, 12 Aug 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUBTAPAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F817A2E6;
	Tue, 12 Aug 2025 04:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974129; cv=none; b=lzzAv8ZpWMVziAqT6+feuI1voQ2sVB0huzfqhN1upP2gt+vA/5xnH07vrsZHfXFyDkV5f9MmU/YI/GgNgJeBdGTGGoPyUTZkO+TbaPLNlkdKoqVFwipIVmkVnql0ertJcdg/iWMiLNJeTY3772JqcH4bi0ycaIASFbs6+vJnb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974129; c=relaxed/simple;
	bh=rd3l0x+u9gxrsAvt6wXIGSPCtQ9fjFS56ByUZRBtFvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Rl57GkGiV8LKHKtMy4teNEzTKWzDk2QKthpGwBZqHDaBf2vQK2WjnFGB8xigEOl6ypZ0XpwojSfg7asWfjRjuufyEXgq3YN/rR410BCzKfr6BzeOrc+PCfW1WQypNmbyxxHuybJZ4Z/fTm34bse1Q8Cmdkr9bMLez8ig4nH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUBTAPAz; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4245235a77so4279589a12.1;
        Mon, 11 Aug 2025 21:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754974126; x=1755578926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExX652zHf1GHUfqv+cm0zn7UYbTpQ3yVS+bG4tF/0so=;
        b=DUBTAPAzrQEndWJCNwRsrk1V4laqGBT5ql3fIoizFiqQ6DITK/zMktp9gZ4XX6JnP9
         KSbVu29DsoaglEQMi1Pq5mXbf50XOmtxg2YBYPEYAza/KQfkv2yU7Wn0WML4+gDk8YYB
         YpWr/zRlO5eC4dghoJFml2fcJZpsAiE+0eaefpIYKgg+fNMWZIq5YI6ew8+XsBS3DR5X
         O1b61rFFMSZAXMjK7pq74PiNrDpL4aKrtVxv1F7nBApOyhwQv1EyErf2e3ebQ0jZqpIM
         2Pd6yB+e/1XNOoMYU6bvU1zLABj0bRef+GmbpGsybmTL9pv9h8o5RkBUm/vfHeG9/RLZ
         4Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754974126; x=1755578926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExX652zHf1GHUfqv+cm0zn7UYbTpQ3yVS+bG4tF/0so=;
        b=Cl0LH8vjv/EA7S+YyB0YPZ/nwWu0sjvWm8M4PzmvhWf68I9frH8h/mvpFV86rPsc9J
         gZ6RJK8MMPZWeoAfjcG9ouoOVS2MQomSpR1XuWbL7LJIEIfnkOrYrHuxLcESUVPxjac5
         z96xresHbBzgaArymItIY/OGOSxCxtxxzXu28bFo2NEA1yvz9ynj01I8J5sx4Znp6N9b
         bN3SwJ4q2adVEddyX4eIa4GxTREK0h0Vz1DE40qTcC4SKrjs7QWqWJIb/YyFsneswCPO
         EFUtBel29b6b184OaWhFoCaR2S8UnKgKy6Sv1IDVete4Gxfmy9jLGhuFki9IAsjKf5x2
         7PJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/DDQE4yOMiKzSIRXjFtkRX32nD/tB48+nc8uum3uGb4/b7GnvnlHv0kVuPo36ARl79ZiJNz1tOoK5aJ415+tg@vger.kernel.org, AJvYcCX13R5CBHxf/NG8SVXgMCNBwptbu2R1TqF/dBvybObs1urV/LtJqdfbdgXCqh4V9ZLrkVBWPww64es=@vger.kernel.org, AJvYcCX9Rkg85GcXcKTbKvzp/qQ+ypsdUlNm0Yzdnz/R5OhfUousARsmhaG4Ao5mtnegdcsN7vtRyeYfwjiopYdo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7U+ButA4775mrS4QK7cxxPnw+H9AYKelfQgV9E1QusyS6uCFB
	lKhw4g3WIEONyMr2VjDwFgdbOEMp87bj+TyR3OgpEvy42z4+Ann2UB/5
X-Gm-Gg: ASbGncvKw9J7+a4PxzxssWRlRAwR/AjUD99YICcOp93ctpTe8GRowBzGYF45ep+jSyv
	vzdPTPbjGU8iKmLPPOro1nmTya+olqhlTxOs+9cpHekwtIFYdOfx6I7b3Br0zS1Q5Dba42+hrkZ
	A1/FJjgSHuGalKMlqjpV8FWwmPs8eTPgG1NF9MEF+SkivitzoqrK/FFBmu+qGEgAtg5nG1285Tj
	7RLW9d6qTQcqKJAxrBx955tIG9P2kL3pdYubDXSjCxML4cXLoIA2S5OHWWd7aA6FQM/osHHmuEq
	OaWOI8J/wzc5PQfGgi5U3rAtF92yDkf7FxKIUMnapDOkGl59KMHjhckevYxCJBAv3Oz8gFb693T
	202ftMQqV6D3CeDMqM9vEsQITjfxkHoQydyGRTA==
X-Google-Smtp-Source: AGHT+IH4bampa00vZY2wn4ikjgxtDmkLgf5+sXi+LEPPRG28R7ojBu8w1mILEa76tO4L5ruhfLwAgg==
X-Received: by 2002:a17:902:cf04:b0:240:7308:aecb with SMTP id d9443c01a7336-242c21ff8f9mr274922235ad.32.1754974126159;
        Mon, 11 Aug 2025 21:48:46 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243031afd94sm2644655ad.113.2025.08.11.21.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:48:45 -0700 (PDT)
Date: Tue, 12 Aug 2025 04:48:34 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] bonding: add support for per-port LACP
 actor priority
Message-ID: <aJrHomEWwIn8a1Ql@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-2-liuhangbin@gmail.com>
 <a1f88a9d-14b8-4547-a6c1-b880633775a5@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f88a9d-14b8-4547-a6c1-b880633775a5@blackwall.org>

On Fri, Jul 25, 2025 at 11:55:54AM +0300, Nikolay Aleksandrov wrote:
> On 7/24/25 11:16, Hangbin Liu wrote:
> > Introduce a new option ad_actor_port_prio, allowing users to set the actor
> > port priority on a per-port basis in LACPDU.
> > 
> > This priority can be used in future enhancements to influence aggregator
> > selection via ad_select policy.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  Documentation/networking/bonding.rst |  9 +++++++
> >  drivers/net/bonding/bond_3ad.c       |  2 ++
> >  drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
> >  drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++++++
> >  include/net/bond_3ad.h               |  1 +
> >  include/net/bond_options.h           |  1 +
> >  include/uapi/linux/if_link.h         |  1 +
> >  7 files changed, 65 insertions(+)
> > 
> > diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> > index a4c1291d2561..5e105e7ac8e6 100644
> > --- a/Documentation/networking/bonding.rst
> > +++ b/Documentation/networking/bonding.rst
> > @@ -193,6 +193,15 @@ ad_actor_sys_prio
> >  	This parameter has effect only in 802.3ad mode and is available through
> >  	SysFs interface.
> >  
> > +ad_actor_port_prio
> > +
> > +	In an AD system, this specifies the port priority. The allowed range
> > +	is 1 - 65535. If the value is not specified, it takes 255 as the
> 
> 
> Leaving this as a note: it is set to 255 because actor_port_priorty is initialized to 255
>                         and port_priority is initialized to actor_port_priority at slave
>                         bind time.

Hi Nikolay,

Is this a note for you? Or you want me add it to the doc?

Thanks
Hangbin

