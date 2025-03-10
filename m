Return-Path: <linux-kselftest+bounces-28587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB79A58D4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 08:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BE16A729
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFE22256D;
	Mon, 10 Mar 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCK1k8nU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D5221F37;
	Mon, 10 Mar 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593243; cv=none; b=g1RSfYkSuQqMZFbw1cIE5lj3zkXM8CNe6MMmRG4EI2UIxtzA05/LgddPIQwAVHvwMIY4lpgDqomHYIgGt5V5NHZLL14fYsuDE6+jDUzgFs3EZJKc3IzqTJMr9I6b/Reka3tULZoyaKnqW28S9uQVtC7FAy9XULIBSV98pCrJXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593243; c=relaxed/simple;
	bh=8u9bTpRC8vwrAXHOBmiomGuZHpPRkdWB/jUqDJsUpV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyNse2gAR8wnp13hLs1+AO5q9fCDa0pW7qC8f7mmFeCTMdeedwnIBUgY6UVXDW1Ac3FSwZ3X6BiU0kno86olU5rEv43i4b4jkqgk0HdzxVEmmmbHW9DicUeW2bd89QXjN0q5VJJ6I9s1MDkcdtiH5FJx7rFs6dl3/sFdXguVFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCK1k8nU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224341bbc1dso37507235ad.3;
        Mon, 10 Mar 2025 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593241; x=1742198041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g17W8Q88S1+ydonLQeAiUH8wTpJ04haNMcacIgw5wbs=;
        b=WCK1k8nUBUBlMC9Eu/+Hg3k3U9+lQP2pCRb8LAKVHoP/wPZjNgkZ+LcjiMFUWcNBfP
         bmxs7I1hu4a5srgmpsofKrXLQBRbl0AMbpeDm4XXvdKG6rg/JFRxi35D4wKQrkWysZJo
         F5V1Fpvi41iqleD2bsL3m3n+XrUODapB+963g7CS9bmUvZaF3QDV5yU7fcx9m16slDYx
         CpcjcjUz781Xwp1CxOn077s4xUggZvttf/BAJwaJA4RW4+x147lyqjgdUJk6d79xp7kB
         LbyhkSpJi1AgSmPvY7kfqNIe3GdWcWK81mgnsrv9g9rCY+/1Ig3zH8VW03HzXI0XVUb4
         wBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593241; x=1742198041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g17W8Q88S1+ydonLQeAiUH8wTpJ04haNMcacIgw5wbs=;
        b=bZQSfw91s1j/SRI/cy05ZstBDkUrMAkPFlIt5jkv69OkDTFDm3BGi+LPiTICKFVeIn
         J1cORHKn1ATzEppS7WE7UvxNltpzaT4bi9TvW86C1sBYsagOcbcmLAKslQiiXxf3KrNY
         9acu+ZxVPkl1X61+i9+Tj3s3FCAQnnnLPKRGkzRY9vvb1bNRCAdLkcKvim3ajEpXPMX+
         uLmwPqf0J32nxBm/BVFlrq5RneayLZvkN1kf5owSgJ06dNPk8aqugnweyQRGUnvpXWXD
         KW3MtTB7hJKaDFk0YM+dmQHnA5OyDZjBqaFzAHcL68iEizZ/m6nHNCpZj9K+UCTtKSjP
         xbYA==
X-Forwarded-Encrypted: i=1; AJvYcCV48xLpnAg2ykU49CW3zIUfuRfwMRgchsMM4CFD7DsdQzbLN72H8Xji6LBFEbATX3HaF14y7Pno@vger.kernel.org, AJvYcCVLCGjL1xWYqTLLjJJZILJWlcHSAqLyCA2yu+H8QPhy1QMoawPYHm66uS921VBUv69KD+VyQ25sZWpWed4=@vger.kernel.org, AJvYcCXRZQzFS1INjyd2vhGLB5vqVG2KFetRw8lH4LkkWdmfePvwzKg0hkWMaboRlFZHiAXiytNaF9XNL0R0UAlyuJ6+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3d78MjPy7VTw+wZf02KZdhlMApi13cENgMlrerAWfsaF5ou9K
	KCnAbRE0f4dJ4iO/a1IdW1nmB2lQFgPcNWDtyWC/g9nCERFMJdoX
X-Gm-Gg: ASbGncu28UhL7WMqQDvLGgu46H0Gd9TilZ5U3VQgasgMv/W+zhM33kiEkx96Hsqkq5N
	wYUazzafs0DvDw2flIrjVy9aaCdYP05vh8MO/vrY9WMzFOBbFxQzT3kDBckzihYKEYcueFPSPk0
	gCJcNC/qc0IWEJ3U1qOKWxWzqifTz6pzNrncQrP7c57YpvNRhVshscKpEdAfdbF95EGQ6ci2amV
	VL37ZaUHHh4rBxjrbjPoRYhCs3SobEox1KKm/t/LUqu6oIoJ6Me4m5souAnRyyQj/c6C6/og+G+
	bonjbBhW+VdS8CNICXSmuS3LeOeH9k5lcTX/KwP68sHwdkSbdsFTvG4z79oz
X-Google-Smtp-Source: AGHT+IELjOpTUigHILgdFjagDMCE+GpANqCPFvcMIx7S81xyOuSggy9OfJH7R2oRU3Nec/MVXWtwNA==
X-Received: by 2002:a17:902:e802:b0:223:5e56:a1ce with SMTP id d9443c01a7336-22428ac94d5mr206973975ad.32.1741593241323;
        Mon, 10 Mar 2025 00:54:01 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f93esm71065895ad.142.2025.03.10.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:54:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:53:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Message-ID: <Z86aj4Ak0ksyTrmo@fedora>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
 <20250307090332.5b556ebb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307090332.5b556ebb@kernel.org>

On Fri, Mar 07, 2025 at 09:03:32AM -0800, Jakub Kicinski wrote:
> On Fri, 7 Mar 2025 09:42:49 +0200 Nikolay Aleksandrov wrote:
> > TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
> > support than tell people "good luck, it might crash". It's better to be safe until a
> > correct design is in place which takes care of these issues.
> 
> That's my feeling too, FWIW. I think we knew about this issue
> for a while now, the longer we wait the more users we may disrupt
> with the revert.

Steffen said we can't sleep in xfrm_timer_handler(), which calls
__xfrm_state_delete(). So I can't find a way to handle the race condition
between bond_ipsec_add_sa_all() -> xdo_dev_state_add, which may sleep.
And __xfrm_state_delete() -> xdo_dev_state_delete, which can't sleep.

Hi Jay, do you have any comments?

Thanks
Hangbin

