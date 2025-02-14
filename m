Return-Path: <linux-kselftest+bounces-26602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E802A353A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B9C3ABE9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EE86337;
	Fri, 14 Feb 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtMCl4ON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432A70831;
	Fri, 14 Feb 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496163; cv=none; b=kvp1geDeHGT1/hmf69GILjTXdj+1m6Wlnc7vNX8oLZzrXFsPT5ArbSDT4VYAdWD3WcOklDeQ0Zuknpd6MA6ZfvOcjzg7NJjzfvcuyyXJrBkdMIVFSC4tDWftzUgOs/Mz4ZBc5O4RqqeUhnRuU15gvsSlRP+0E3LEBBUKT6jwhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496163; c=relaxed/simple;
	bh=HKtCsVI3P+B6Gx69zLkhJXX6YJUETgO4lClDEJQtLGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA/9RJVJZ7Yw4w6sxEzlr6bm0dE7IXJOf3R7hXqUK/tPWxcp+gaEHPlmh3mmLETs59RNeq1MFLw71AwSuEahCkyAZKCZYSEOaVhtNE4XXkk4GE/9UwN8ixB4g9jxJtDZwWV57DZyWPQs1cSMP/UOnMDz6J+jKAofhKC7ygricOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtMCl4ON; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f7f1e1194so37951785ad.2;
        Thu, 13 Feb 2025 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739496161; x=1740100961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoGZ2nbNCqpuk1a2KOC1Wh+Mauc+R8mLO4uJ6ZuYEdI=;
        b=HtMCl4ON7juiHZwOgJWY1LRy1tzymcOIGsrpEtZ2x9udwgjOC32Hv198BIaySGT0SM
         QxdxJzb0CYtlSPHroijui3YAIDtN8W3Y6UTRWlSqpWttxjhME5zwZgofdSX/F37Up0cB
         3Bzzd3nh1QAE3r/lRokDKVw/Ks9p2rM4gp/Di3sFZQGS0HBPkvmBuFDuuWX+G90M4afd
         xYQHybRK6BlerLibMnZEppZFU7n0MBL9jzewWMzmBXMWYABNtXASDyTzdKL24YsMnXXG
         ZfQAiv2awUR2PjPaXpHtAjCY3KOjkyT55rQv7krS+5UBaXne8LkJKtlVo36E8jUsJ44X
         U6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739496161; x=1740100961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoGZ2nbNCqpuk1a2KOC1Wh+Mauc+R8mLO4uJ6ZuYEdI=;
        b=Q7LEhHcNHTPPSGzT22wcnHSxa8CRY+OEWp/ZJxjAzC38wzKgHc8otCdSIG2Rr6qwIg
         sGxh5AfgauJvyxktxASDKQvpGprsQt6i9aYFtNQyrlNijjt2h0alY31wR3iGQRGqlCJh
         6q5Fam6ULP7iY9RrQ3wTweyD0gxvqFjfyHV+YOqrPLg5Ds6wqHmrPeIhiMA21tzYYhQM
         xdM56JFOkm8blxyKhXBd2PR3/DalnpOsVlUKvH81ooo6uSfNxNjIlA7iQRoqiegQ3+nN
         pLOhDUiaffY6c8ARBTW+5OW/KfUrD3DvfKek5ZKDcRI78k2qfaCwWhqmoi+dPWBCG3+I
         MyNw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQH4k627skjOjWOeSqAzS5FBa9Yb49E2Sq6tScAL7aStAYoGHi77gO5x6+C8PfJyjMMnYcuIZwIYvWypJe9Kz@vger.kernel.org, AJvYcCXCE9B6eSi7A7WWGmolF8SiUwrR2W4b8Bsh6QKK9vtS9qj62ggP+wT/66n7PUjriQwXRram4nldgS9cDQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu333/5tXIYk/lJmJcx93ye/zgeIQHe4PtXBcDHeDW0LFLu9E9
	mBpwGNXvIuHCq0Bjq+F2Wzka8mliQH9NXk8H76xvWS//H0ULUC6T
X-Gm-Gg: ASbGnctB9fB0w+0gZfpSH6rV3d804jm289vtPtQmONle3FyWXYEHLXQQkePeHBFHtS2
	tu9i3kYzRBGdjDFXzIbaC7KKThJKoziP7I3URJMhOFStr8a9mLuNA/6uGN3h/sBznK1F5ks0dXY
	8IijLP2o+rZ/agmwA7x6zRdNwlCWsKFM4lAGZpSmcLpd1rCHaIqVd3+8tcjDowjn6Evs276cAO+
	CPQucvd4gTyG6qYOVbvNnnJtB0mN6RLuXV+v2As5MNfXmczCn68mGuflw9RCeQggQF89bRidgiU
	3X3dfvtGa2Ji/dcFaOHF
X-Google-Smtp-Source: AGHT+IG4mCcZ2fxv9ulKkHnSy7iZvJ7eKTAqqtS2jCvEPVFhgCETVfE2TL8lwGbtUfThOvRKIYDTjQ==
X-Received: by 2002:a17:903:230b:b0:21f:49f2:e33f with SMTP id d9443c01a7336-220bbb243c2mr157553825ad.21.1739496161133;
        Thu, 13 Feb 2025 17:22:41 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53668d1sm18831085ad.75.2025.02.13.17.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:22:40 -0800 (PST)
Date: Fri, 14 Feb 2025 01:22:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Message-ID: <Z66a2Mgi6jkHvoVV@fedora>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
 <Z6b67YBbERi5v9gt@fedora>
 <Z6r8y1U4C_s1-3jV@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6r8y1U4C_s1-3jV@fedora>

Hi Jay,

Any comments?

Thanks
Hangbin
On Tue, Feb 11, 2025 at 07:31:32AM +0000, Hangbin Liu wrote:
> Hi Jay,
> On Sat, Feb 08, 2025 at 06:34:21AM +0000, Hangbin Liu wrote:
> > Please hold on this patch. Our QE reported that with bare NIC, the
> > backup NIC can't receive the NS messages even after joining the multicast
> > MAC group. But after remove the backup NIC from bond, the NIC interface
> > could receive the NS message.
> > 
> > This is weird, it looks the backup NIC dropped the NS message somewhere,
> > even using tcpdump (the NIC will be in promisc mode) I can't capture the
> > NS message on backup slave.
> > 
> > I need to debug more.
> 
> After debug, I find it's a driver issue. The issue exists with ice dirver NIC.
> I tried with a mlx5 NIC and the patch works good for me.
> 
> So I think you can start review this patch when you have time. I will debug
> the ice driver later.
> 
> Thanks
> Hangbin

