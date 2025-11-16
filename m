Return-Path: <linux-kselftest+bounces-45707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5FFC61B1E
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CECB24E0245
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8730FC27;
	Sun, 16 Nov 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwTqVY+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24230F922
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763319588; cv=none; b=mpEnJuvAY2CNHnESSsQdMvRQfaYWsyglz2LLh2QS8Zvt3wVsWK3ZhTwQ2NlL1AFAtGD71fmePjjFX5AmfH4YFZbvMnOws2Qn+XazoKHrcWpRo0pXguuXuX4s7Lu5NBvLn7FpiXwREk3p6n6cNowYSbURbH6AMi0aWedTzPdAoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763319588; c=relaxed/simple;
	bh=yu2NuTuEzodbOyf6RgfGdHkSvgHznx9Ba89qNX7icrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AavneAAeX+UX6jyjuY5Uz4o0IhczD7VkHHA3SL+soyxXGZoPpuYpG95bK6SEYGCxMhpBryyTxnGhFJYAAJdzKtoxu4lIZjk81Su/raDLIpzK7ZpchoQCNqfd/WS6KqGRiMonL2hOyDHe1woo4Zs8KDm9Nd5Vyh55FKO7ahIiz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwTqVY+V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so7437515e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 10:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763319586; x=1763924386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0QOGpOREQFi+91a4uGctnzik47SA2nu5lAp/EQKXvs=;
        b=VwTqVY+VZRBe6TvA6ifnb9xHnepyxKdBfLOoKffKGN91um3YMXkkNmWUqZHKI4JzM0
         EMLSKJT97KD7hKf8xlWKCFw0vUxRiL5ZwqpCihj2W/4bPuQymlxccU9g6Wq/HDmG1y5o
         ktklE91lGD0NwAY9v0NuDZnpR3sGnefZyRuOl6PelzCTC2s09beK7kpj+dXmz28I4TgL
         dryHfht8Nafzb7W6DO4uIjPWwVNiTKR5a91VciSGPZJf3F2nKDx+/5gcI5zIS1ScMF7V
         RegHbAa607IPiGS/xPiUzHnnjLjn6GsUJ+4UnElIqhpMYZXtoiAnNVw6qdHWpd+P2K8T
         +Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763319586; x=1763924386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0QOGpOREQFi+91a4uGctnzik47SA2nu5lAp/EQKXvs=;
        b=uhoVDE+HjnuZQCiVrKh5S/8GRg2wp1EevflFXhFnb0XMCQHVpyT4I+rWGmviqqXPQI
         lLbBiOMk2lAswee2/HgeZGqhO7LbajV11HGjDrrh2tEZU8HgfHgLZBGw915jmYbpHSrd
         GLYA7L/mHbzSLgwtLpTSWsT0y+KddZ0S9nOJvweYUZXA+oe4gwTQfROmpBCjjhyq9+TT
         YT69hTgpIQTi5GjSES8n4k8+XgsEugFVHdCzeU5/mgi3GcwvFLgGzEDJ1YEa4WaWI+ah
         eEX93cRNOt8tKpL9/BaWFQQRu8IcZFbDKgJgK1hyct527/rH3GvwaiW+vtCaO3XmutYd
         c5bA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNoPdLei/ju/mOPSJPBPCkyurs0vc8GpSNFokNpXEX7KgX45w3gMVVT+9y+YtQ2ELgaPX4hJtzYRNy2NAdEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSWM9gZ/bgAybhXS4Hot/igP3RtHiOh7RskJNyChf3kjFCwCY
	zZAMJWYsEa+xjPrzGTj8pWMaH2i8GycnG+NyNBN8iEEieJBajRYnSmM5
X-Gm-Gg: ASbGnctGNTZdLjAHgZ6Mp5GzwD8QfPyLD18oRrvEByEUg3YRsZgGq2Gzoqj9HVkSrau
	bCtoPGEq+nMrFcb1GseFyA3DYJDOombPYKuImHXJvH5RzWC+yAG0Oa1EyPmbGqIufKgHQKHw/qa
	aUjbBlXv6arRL1Q2wL+jSQ4YAntrJt130Zi/KCfRJtQPvZSFIgBB054Junvb/ESC8TbwU4n5o4T
	4hhzKO/n3b3raqFAWWTY/icpQqio3pQy7jrjPpTnSp94XKQMeRCidvjoT1/QuWWqAiVfQ6O5kcR
	1dq5PBWoef98FbC5rhOSQZtrDuSptfu8VrfmtGiBCEt/yiQ1HDfa8spB0cMvq4OeM4THbB7cP+h
	jmBlUJ32PgQdbJYDzbPlguUCm0hMH9iHZwGNf9g095FdYr7TbzTI82iRqBVdGiraBe0TOL7WewH
	5RfcSMeEkQH/zOhlYXug==
X-Google-Smtp-Source: AGHT+IERb+y1n1bO8T8kzXWc/3DtiyzEfo/UYelcHhco5aO8dlNi4yPNrpOSOP12nWwlJD6g83oUgQ==
X-Received: by 2002:a05:600c:3546:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4778fe60310mr104243275e9.8.1763319585467;
        Sun, 16 Nov 2025 10:59:45 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b14bsm21804372f8f.9.2025.11.16.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 10:59:44 -0800 (PST)
Date: Sun, 16 Nov 2025 18:59:43 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] selftests: netconsole: validate target
 resume
Message-ID: <vt5igunw47u726ty5romoycbibjbbjgtv5cz53cyq2uh6mtnw7@dvehioj2kkiw>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
 <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>

On Sun, Nov 16, 2025 at 05:14:05PM +0000, Andre Carvalho wrote:
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup
> +	trap - EXIT

I noticed a small mistake here. This trap line should be outside of the loop,
right before exit. I'll send v5 fixing this after the 24h cooldown period.

> +
> +	echo "${BINDMODE} : Test passed" >&2
> +done
> +
> +exit "${ksft_pass}"
> 
> -- 
> 2.51.2
> 

-- 
Andre Carvalho

