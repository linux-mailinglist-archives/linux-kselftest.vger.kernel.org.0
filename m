Return-Path: <linux-kselftest+bounces-44834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C185C372D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB33625D3C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AE3370E8;
	Wed,  5 Nov 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caKRYsdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587B334C18
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364046; cv=none; b=XGr0iwdATGgk2A9HIMIeguFJ8Kid9p2yaiVRLMU0+WKNnjo3y0h7yIsZfG2Zgd1EEUrGCAgrXxxsfvfOPiHyvOg5O1F2jLBgb8LBDVsl1HcD4nDmAQ9jY9T4WyqV42dicPTFyRsrGie/K9KRYAWi+34IQaXJAOmQnXbqquHoulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364046; c=relaxed/simple;
	bh=6xrOD9swTEvrak0LhMfPK5DhY7OUNnrkGwLHcRPL30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4m/VdTGxq0keNxCrKjtKpDNSoJrVrKHBJyTQMVlehI32aaEgQCWOGeBDkHmzWyPsHxw6z4rWtRTr9YuOozgJvB0MOuUrPNF1DzPteSiBeB5rGm9G6rs66IADgdJ/SFTC4ggQtHNREy8dSjHday+P+hzkZffrBIMNwpgHOpoA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caKRYsdt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a1603a098eso87032b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762364044; x=1762968844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=caKRYsdtvKllX8CzsiFUc4zpvhzFGohX2iqu8C541hMlaAlV/GArvWcuIUYcNzqtFF
         iZsHa2KgnDOjipZbTsQBxz70O3SdbGvGjErHJFacdd81mG28AvBExOrrIYqB5rnQayHn
         Wlp+5I0CQOH51sTOzZtXst6d/KqjDDh1X2QbZ8V7+8o8slZTSt0YSBChAZC/EWTvN8Xc
         /1bOn/adVeZxgrjzguPfyLMpPT00DAZT15nxWOuBBxWcT1Wo5M5hagVt+GO3LNGUEdqt
         7a9vvGBNhOBjTjs742uZ0lKVPnpPTnpKMyYukgbYWlYody/AKXX+XGmmQPruLqbEEbZD
         mgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364044; x=1762968844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=K9k5z+i0BbAYpWmAFHhBFZLizx10/osZsamscZkdhJdMlcncY/+Km2n/+3xZR9iAGh
         rSgOlXLDvP0Fy7mVDtnE2sXgBogqxSLT7aISa4ouV9v/iEqWp05YYCyLK4CEKrDLZTuy
         zdPqI5ssttfR/4BM8XjoTQhi/dSBzTE5PTaeT0bYEe4vNJQKtxgAIRaUjD4TutXwkzGJ
         bnaY2P1NfzZ0UKEq3JxYgWZUofEfhMXK1kKZWYsIMw4UVID2QxkZkIJ6Km+pNrwakmXM
         0V3+We98pKw844f5yvjIE0Q8jLvh877rOevLJOk3S48ucTD9J6vq3Q3HVK4mFVVDvCpr
         4bRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKo3A8Mj8cpq6mz+ihXf7qejHYLA4qExCWLyszIh5f8tNiSM82qzMk+rKLQz2swLy8OI6pmeQtIBMc01X63l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz87LsvdlSN600/J9qkTLKs+z4Dvgw+oD4ScUxCC0PUx67Zyyx
	ajUFoVrHzoHpA4svuURcgHxuTMDfLfHD91eFxDzTNUai89TBKgXSkF4=
X-Gm-Gg: ASbGnct9ZlPMRLgi0FCpSjZBvLY7fPeHUYS4ueTZWm0rAF2/WYCSXHvV+tYL6Iuh1ZO
	oYNR22I0KHkazZO1t0v9Io8ZJE2rFJ5+fNB3o6gHBj1SwZHigUm2zald6TDw7Cvd1AgVoN/Sa5V
	s6aPnrPGJ20hqPivKGf87u0XKch8AVZV0SsC8KlPzpazg/CC6FV878b/uyyp/XaPub0DCPv/nmm
	4HBBtDagJ5tnferxqNU1C6xxhEVRIeluUxA7WXOVybRYYsG24JZ4zlKJDwdJoKnrdcii2uSi4Rp
	S+iRmGNdmnsS2MTVW9zh43EgX06OY/dXBkQYU4KOmiNwb9rgIEzZaoT1CqsivAt5RIGCJuVOJZg
	lxmFUXRAAP4E3TSRG3ilHHQLVvy2uEK0Wa1J2z6N+P+2HXrwnDIRLLtN2IgvTBThDfEP/blZZkw
	KtBNQZobhN4PPpJBt6jSCWvN7XI6tKXL+Y1iPXGPKNK8eDw3xycqRLO2Iu2NjMNGz1TX5T0Dc46
	VbV3N6sOPgiPgVMRWxuqrPcC6KtmxA1j4r84+We4J9uglZnDcOFIS9E4xR1RUjM+k4=
X-Google-Smtp-Source: AGHT+IGfpYym/+ciEUpgLGEk2Uo4k9tfz1NW01FXx3zpjWrnBawbwhix8S/o00+hWVYZ5LW7eOMiOw==
X-Received: by 2002:a05:6a20:7d9e:b0:341:262f:651c with SMTP id adf61e73a8af0-34f84afbef9mr4621605637.25.1762364044019;
        Wed, 05 Nov 2025 09:34:04 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a8044dsm6027302a12.16.2025.11.05.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:34:03 -0800 (PST)
Date: Wed, 5 Nov 2025 09:34:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuKi535hyWMLBX4@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>

On 11/04, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 

[..]

> +Autorelease Control
> +~~~~~~~~~~~~~~~~~~~

Have you considered an option to have this flag on the dmabuf binding
itself? This will let us keep everything in ynl and not add a new socket
option. I think also semantically, this is a property of the binding
and not the socket? (not sure what's gonna happen if we have
autorelease=on and autorelease=off sockets receiving to the same
dmabuf)

