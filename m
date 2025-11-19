Return-Path: <linux-kselftest+bounces-45935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1EC6C23A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23ED24E66BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 00:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5E1EF09B;
	Wed, 19 Nov 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpfWMvyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A51DE2AD
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512371; cv=none; b=dZiJI81zvj2TvLKYmkDPEmPf+kTNuk3HA8Lq5f+dm/6z5Ph9ahgOd6UlIFPBWF+AG1RFeqn5/LgExNTIw8gxAU97qpZCaFamFuxj1qkfJEZGzY0yuSKWl007FLfhfNIDw6IgE1IP1P2YhYPpVN0jlhai5Bz9n6shSi/LYsii1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512371; c=relaxed/simple;
	bh=b7tmMO0p4bVCq8zDAbJYSe7ln4nf+W8e2uwDHWvulWg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qtT652Do1R0RyYuFzShxhnTp6DdcXIHQPm6a7dEuruvNMIeBr7qhKcqei4c5jvsRFaJcwe3YYhj6LDJzOFGTq58JROPx3kbL70trTcD7H2WGfdrj7EWCs0ky2Ze+jsusbEmadmKbMdCBR33kBWlid248qq7SPCvjdpyBKtK+vKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpfWMvyI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786a822e73aso65026337b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763512369; x=1764117169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvE4I8Lym/x/DUvLFKeaWCiMOxUxjUBGPJiECvM7CqE=;
        b=DpfWMvyIt/2WnCdWcvdmhY1RSFwqUmmVAYeOiYqxVEUKMgt67Y6ogCq/I+mmZ49sD3
         Ht9HRmTC+UuC64mrYxVxsBRvfLEEj+4UyRmYH6/ypo5IW6fRIlDLRlhtQ3BNBQYKN0kb
         wmnFa4mUFxvvTaXFxVM0zoK5R3Ef5b6LGhUBr6sPLEVd9/sUTRscjaQwhBM/gEhuVu6R
         iQZPHliFErfsO+QK2GRlI5zETH0pzH3k5vshl8nMHz17i8QSRhABDYdo+ueg9ngTxVzV
         lbTQHurMvgeu1ZZb6RA44RW7Qa2J6zy9QH4miEegsZB/4GJEO1G/0/aZnwB6SYSeMHXE
         cMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512369; x=1764117169;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvE4I8Lym/x/DUvLFKeaWCiMOxUxjUBGPJiECvM7CqE=;
        b=I2hHuAVYYPcW1l5h6nMZsOStuddgYYGxtv/8qZi6jCgWkKH4je4kGAXxopiZk8qiyT
         6m5CxxbuRw6mmxoR282bZQYdSQSx94fvsUcPknN2etMTc4NKbUSzWQv86NEfZARtO9Ud
         M6o5KJkwl22PblzUbjTaKDulh1EQjhUDa3vLWoPP4Hkgq7TQmZFIoOZVNe1edh8ugudH
         r9HaibL+10hUl8F0PAFE2X0G8OIEzehg5MqzEsrjGKdV91DYsG6BF4+iETrbr6qx3tAM
         p2XoqHadmxzGqc6jp4tF/cyF6S77L2jCTKkU5oSbVNcJEDzpT68ShChv1Eo3wQ/BIqyV
         mELg==
X-Forwarded-Encrypted: i=1; AJvYcCU5IAvDcq2u0IrlJGWAZag2BZC2q0qTDhdfKxfIMpVTmwgM5eA/Ksa1EyV0lISdxOTzM6QzR5Ql43duh/G10QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6v3pmhKInR75RB4WnHGbs2yMFfWYUQj0od9Vww42nRuuWAiZ0
	lY5q4DWUPAVgnq9/uOZh8OlUYIkEAO/ruW4u5LXm+tlSVNoAsMMfeB/A
X-Gm-Gg: ASbGnctj5iBlxi9qIUjfuWtmO7QBHCxbqUNvpP9EeAcgDAqdOJKflaE2qt8fbrr80XW
	DBCFkjKkNY8UjA/Wz/3wQMQNJF9XDubEhGU9O6kLjAwYgEspkSfat95jYbtmVeL0EADtcepIHSR
	sFulaYeBL9EszhfRdFD0V+KJu/n/hCqsOvWuzvys7kfglpJrkFkkKhwkzKZny+tTHeWVUD0fXRb
	QjZh+fGs4YdKVIp91ObHVNdvUfTGCCNm61lVHGTnGcLoaNg2Gt4omMRXC9dFcn3lf2zwyadXITF
	Xy5G+RgpCETMnMaIcjRddUCboibwL6JWHNkJg4kja8wOSdtIaR94zH0w/3Fx9BcU770Va3/GMmv
	cDCT3f/PbyXQ6rWgkLhLqlPbPW1ikS8sJkMeP5CbN6A5LjiEKofa6+stOUd6WwQWo7BueIsg1qP
	e2J1ZOADZ2EaXTxJEu9NmGbJEaXMBVQuQFpRD2JXYbGiwBxQB24A81xzWAJlActjjbUtrvoNL5E
	AvKGRs9XmM255fl
X-Google-Smtp-Source: AGHT+IG7n+Q5NYSyI8NejaS4PVSekWHKgNJZTPy+ufa5QM22GmPdM5ZOcK9MEN93Ytw6XdKFx3XjNg==
X-Received: by 2002:a05:690c:6389:b0:77f:9dae:34f0 with SMTP id 00721157ae682-78929f397d5mr147190317b3.46.1763512369202;
        Tue, 18 Nov 2025 16:32:49 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-788221781e9sm58115627b3.52.2025.11.18.16.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:32:48 -0800 (PST)
Date: Tue, 18 Nov 2025 19:32:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 petrm@nvidia.com, 
 matttbe@kernel.org
Message-ID: <willemdebruijn.kernel.13c277ea2256@gmail.com>
In-Reply-To: <20251118162528.4a3f3169@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
 <willemdebruijn.kernel.27c628e67e858@gmail.com>
 <20251118162528.4a3f3169@kernel.org>
Subject: Re: [PATCH net-next v2 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 17:31:50 -0500 Willem de Bruijn wrote:
> > For the series:
> > 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks! FWIW did some more digging just now, with the indirection table
> read from the device and disabling symmetric hash for the test (mlx5
> defaults to having it enabled) - the Toeplitz test passes on all 
> the NICs I have access to (with the caveat that I'm not able to test
> IPv4). I'll look closer at the GRO tomorrow.

Excellent. Symmetric keys makes sense. Though I would have expected
the RSS rules would be the canonical format. Another issue on IPv6 can
be whether the flowlabel is included (which it shouldn't by default).

