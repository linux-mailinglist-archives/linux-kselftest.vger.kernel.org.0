Return-Path: <linux-kselftest+bounces-18108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBB97BC6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9951F233F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952B189914;
	Wed, 18 Sep 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnOu8vOI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8001E52D;
	Wed, 18 Sep 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663526; cv=none; b=KDnx74WMT5DEMq3GCw1OLQNXWhBrNIipAEaVAKJw9PZenI1ZuRtvtKlo2fQDUDaSZDgcYPsQrk8EWaCbSehJ7sevOqdeYbk5zYIA33xeKRQpAmIQMf0kAF48gwE0V51oQg2rJDdFbOIZIQfAXz4HKMjcAsMWjgSmKGP9Gt4nz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663526; c=relaxed/simple;
	bh=gJimK4u+OdYhTWerVC6/E+iKASyTSilv+ssIfa6bYhQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RpOTMre+r+KO8nf1eE6Zq7POrnC/YPuliIWcKBv5lqve7pabVREjPmfApfeIlg8smkyeNWntY0CBX5CiDQ12Zu6RBYcOvKYOlWyOcxgtBGMLy9mkggwwmcuJ9Zlqf/5Q6CFELYw0V5F6WAlyc36c8sAQm/lRbOGUHMi48CEbM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnOu8vOI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fde9f1dso582358885a.2;
        Wed, 18 Sep 2024 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663524; x=1727268324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb0czGNo2LUTVTshHsi9BPWPL/WT/rjZrenDHrVx5k8=;
        b=bnOu8vOIrCgjcQkPLUHdbqw3bSFeyCLkhnDJ/X6JozyL5Npj3lr3VPVPj9+KDsWeVH
         HrtPVSOBaGwPtZg0qovvOk8UFPv64WbMJ6TyqY+PFNN8F+b/QMgGasUQKkaKdoP385sg
         w5WDSxT+9GIcxW/ZknTYk7LUSEWuVmUAKmmSoicfbCQezo7sKBPpEReLM76GmoBaHcGW
         TQbAML7bRznkhuOb4TxRKPPnUGuse3j7u14OfuiPEuip/1KE3leG/ef6D2wcYnNiNf5+
         cA0tGNyMv4InfYcfR16PdNNm327+3j4WVlJDk0oO+jjDKvnX4BT2epvoYUCNcXFTbnwo
         6iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663524; x=1727268324;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kb0czGNo2LUTVTshHsi9BPWPL/WT/rjZrenDHrVx5k8=;
        b=n9DLcO8vQAmiz9ayfvBfo8xSVcOP6mavqnSDhkJQ+snU9KHjz7pKHU4Yv3KvkVJsGD
         D+yW1G54WUpq+vD+/orGf/nXKyQ82kogSV/CkBFkQku4ew7G7JZ4xXZMi46IsjOZ2bC3
         2rjbwsS9xge4e0ZYdN8wS7bHWe3xhA7lsphq8CMxWjHq4Qld5dekSgJfCBAVyYVWJSgh
         eek25dJDrT3dTzVdd/Xe/Hkf0EPuaDQpeJKZozZZnrvJxtCLnomZpFxyaujdi3VvNzth
         kDDWw0sBR7cCnVJLZBJGNP7YRjmyistHpq3+knFwY+DQtO4gx+cx4bh38XfF9Yx8CbFV
         fqsw==
X-Forwarded-Encrypted: i=1; AJvYcCUK8wqAZIb1uG+6kIa+PBima/71gJchsLxtVOG7waCas5RFfaOoSRGf4oWKB7ftnE6MiNQ0upIIOGX2QOiEybS7@vger.kernel.org, AJvYcCUUzoya7TpRnZc7YoXayZtD0URRpo/aoU1Wp0N3wS+oXR/sQuZGoRVPANrYYT2jWhVR6BDO3zwlNiD5Kx3L@vger.kernel.org, AJvYcCUnFTJQQMdnVTn0sPGdUZAWi1pqzQAG5BmKzkkcJLELujXGRk2ZdI8pmTLJx/c2eIglLvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+hHzyaB6DowIAOGQ5ojEckO67+hO6uuAapt6rNEOLnQXtXGG
	eBxeaIS2MKPS7xc7kqp5Id9lrzhdtwWBlADYm4OckweDw2sPfsqV
X-Google-Smtp-Source: AGHT+IEh6UyP2aN3CnMsNnG7FafI5FXjQHchefKtOgI9tdTf6facLpuLgwYrgSTl68bWYDC86xtx9w==
X-Received: by 2002:a0c:ed2c:0:b0:6c5:73b1:700a with SMTP id 6a1803df08f44-6c573b17119mr289463676d6.46.1726663524109;
        Wed, 18 Sep 2024 05:45:24 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c69190asm44082076d6.84.2024.09.18.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:45:23 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:45:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tiago Lam <tiagolam@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
Message-ID: <66eacb6317540_29b986294b5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240913-reverse-sk-lookup-v1-1-e721ea003d4c@cloudflare.com>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-1-e721ea003d4c@cloudflare.com>
Subject: Re: [RFC PATCH 1/3] ipv4: Run a reverse sk_lookup on sendmsg.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tiago Lam wrote:
> In order to check if egress traffic should be allowed through, we run a
> reverse socket lookup (i.e. normal socket lookup with the src/dst
> addresses and ports reversed) to check if the corresponding ingress
> traffic is allowed in.

The subject and this description makes it sound that the change always
runs a reverse sk_lookup on sendmsg.

It also focuses on the mechanism, rather than the purpose.

The feature here adds IP_ORIGDSTADDR as a way to respond from a
user configured address. With the sk_lookup limited to this new
special case, as a safety to allow it.

If I read this correctly, I suggest rewording the cover letter and
commit to make this intent and behavior more explicit.

> Thus, if there's a sk_lookup reverse call
> returns a socket that matches the egress socket, we also let the egress
> traffic through - following the principle of, allowing return traffic to
> proceed if ingress traffic is allowed in.  The reverse lookup is only
> performed in case an sk_lookup ebpf program is attached and the source
> address and/or port for the return traffic have been modified.
> 
> The src address and port can be modified by using ancilliary messages.
> Up until now, it was possible to specify a different source address to
> sendmsg by providing it in an IP_PKTINFO anciliarry message, but there's
> no way to change the source port. This patch also extends the ancilliary
> messages supported by sendmsg to support the IP_ORIGDSTADDR ancilliary
> message, reusing the same cmsg and struct used in recvmsg - which
> already supports specifying a port.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>

