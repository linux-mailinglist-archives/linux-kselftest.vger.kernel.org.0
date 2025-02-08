Return-Path: <linux-kselftest+bounces-26078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90309A2D445
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 07:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2544F16C68C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC71990DB;
	Sat,  8 Feb 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS/1GPw7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB734155316;
	Sat,  8 Feb 2025 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738996472; cv=none; b=SumH4vUtRz6ELIYTZcDM8y54vz8CZylOimuAbTLDlRMDjmi6L63zc5PGOkqI3ifluh1qWsV7daIOPBFIdSeKK7u5dh+mNfxZ83s2LzIggTJTMXIX0HKz5ayJrnk9gAw1Ll+Vb2pykHtA/t1+xfVOQITuXLGRRdQKfEV4CamTA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738996472; c=relaxed/simple;
	bh=tW0+Lr2QBZHrrpEVFfIMsDHMzu3gMifdnEelPOfNlFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL6kiIIu9DUMtG6zmOcVkBhUZUbA7h5DyH5XVPaX4s7YUF0MtPKj66WhY1+iPtstuogWTtMQ7NDOUGIM0HhbTwD/18YvTyojQKKECUapa+OUc6rSQ/rpdriojM978cUknPmzCCnTi7/w/bUuIdxy2mE7JJURIj+x8dhF6GWyHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS/1GPw7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f55fbb72bso23847415ad.2;
        Fri, 07 Feb 2025 22:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738996470; x=1739601270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2W+B51lt0Lph92TfGDjy3Nv60PpTC1Kx1fbVhEsxz6A=;
        b=eS/1GPw7ZCiJi0d6qIej30qLQH/rD6KQH2dhyMqbSPDoMdZsCOnJhb10+1ooKjir37
         MHoqmScMuoZ2x3zCNIF5/avSKKei6ggoGAt7CiP2AY0qf+NueYFFir+9GVwICN3qeHbF
         4pAZaQ9jhhNAJHu6/Eqkkh5582k5HYD5d66NcOMwUl24pav8j+952BTHd/6QQjgIiJtt
         +dKZgKpdEz5Z6+o0EjLfYm+Cbh96j58QDu6bnszH4TKQk5DzLcyzFXnvw2HAgxodCO7i
         a0VjXyKsXNYSY1j3tPyKixvPYo5Pzyj2/3oO6hsgiLZA8nrW6lWlQZBaSwRZ9agPtMd5
         JJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738996470; x=1739601270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W+B51lt0Lph92TfGDjy3Nv60PpTC1Kx1fbVhEsxz6A=;
        b=mBLxIL2voPB/xLL6wSBBJssLM7YlI7/qV5v+/y/Sb4UajpwAAs2YINgyTp97fQLYet
         uzBLaZz60OfNq96iAoDNhklKJoGjvahtenUcgRfPvMd5p9nznZDdPu95uhhowN9zD+1S
         DX/06wijgNa/7Jn3IxK9tnWfofDHtJPu6jBGBb7MJrCdbBTwQ+XfQA1tq/pW9s07+ndm
         qeB/DVtbV6Qs7IRDQGUzRubUdWuRjvzRxs4i/4O+cXajlKpQjR0PjgGyyaTQ1CxxYOmo
         Il1kHmQNHC7rYzFXqhgwyCB78aiGDiZRzmKUdZNk4J9HJ9JS00wZFl/FZ/Ua0hQaJipx
         ReDg==
X-Forwarded-Encrypted: i=1; AJvYcCU54rWGizMI0L6XvxRUSPgjOZn3uaZFg1ndS2M6VOAsDlSByLa6cI6X8ICaswe0WKuLb+0gjzfq2EPGxfHsglSB@vger.kernel.org, AJvYcCVlWWcwIpFZCCfydfwaAD/Cq1gg7a8n+XV/JGGvJS+FOpsrFE3pI9aDxSCHsm3oKHkHXclKiu4hcHImksA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmwOUsezTwiDxnskOdIKJ/POuHormkU5Du120VJ675GGUAdko
	HY6HSu1gVpTJyXkiwzCTEkyhvmLS/xcpRi+IDnSlHhuL/7SDDkUjtReXhZ/4eU0=
X-Gm-Gg: ASbGncuEjfNCDW9DitUTjZAN0pXcyKHYh/sIkGEjzRxZR6lH/dLBP7Rj4H/j/SI5Pvi
	XKYbv7ghwAxwvpw518VoxiP3qobgsvIHNNWvE5w4WDvRgAiY1VK/73jRVS3krzKbptX9C6morSH
	TuXUtE6R1Yrg/Q86G7QqeZWoqIni6KPM9EHSlVzAs6L2AOx5TSUWIQgtHiMQ6pFvmC5mAJToiOZ
	n1Jii0n5X07Rhbg44Z8ry1/DTdpA38uIWf20Gtg6AlRN3UQvWmANC7KB4rNuZgfHAyDp64qAoAC
	fLQo+9We+JZrcy2oJtnT
X-Google-Smtp-Source: AGHT+IGxDEdmYorBuzvy1xm/OAuvwxfLLCr+4DZX0PWuc9hzXBVQeJvcQ4in8LfTo0YLP/yKJiQXig==
X-Received: by 2002:a17:902:c948:b0:21f:5e9c:c349 with SMTP id d9443c01a7336-21f5e9cc5bfmr58687075ad.43.1738996469608;
        Fri, 07 Feb 2025 22:34:29 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f64a67488sm11037835ad.244.2025.02.07.22.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 22:34:28 -0800 (PST)
Date: Sat, 8 Feb 2025 06:34:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Message-ID: <Z6b67YBbERi5v9gt@fedora>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>

Please hold on this patch. Our QE reported that with bare NIC, the
backup NIC can't receive the NS messages even after joining the multicast
MAC group. But after remove the backup NIC from bond, the NIC interface
could receive the NS message.

This is weird, it looks the backup NIC dropped the NS message somewhere,
even using tcpdump (the NIC will be in promisc mode) I can't capture the
NS message on backup slave.

I need to debug more.

Thanks
Hangbin
On Fri, Feb 07, 2025 at 09:29:18AM +0000, Hangbin Liu wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> Hangbin Liu (2):
>   bonding: fix incorrect MAC address setting to receive NS messages
>   selftests: bonding: fix incorrect mac address
> 
>  drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
>  .../drivers/net/bonding/bond_options.sh       |  4 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 
> -- 
> 2.46.0
> 

