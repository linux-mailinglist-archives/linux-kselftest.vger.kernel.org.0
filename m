Return-Path: <linux-kselftest+bounces-44839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC4C377CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C3F3AD25F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BD2686A0;
	Wed,  5 Nov 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVHMKpND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D733033E
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371104; cv=none; b=CYHAGGfNlnjLXx2p1Rgh1crtwgi1fVnMDLEjT8ppxYiCDEjAaba64XO9z3ETUsO4DILuBsFhmrhV/Jo2RdN+Gt2EWPTagjUHHUbW3ilSa2WAqDPzZAKpV/O7A6KTp96/wr7iY6cdUIO9hYLNqEOxNSB4TE4Ih9BokiQZ4uRpF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371104; c=relaxed/simple;
	bh=BvZxN+1EqpzRPr7jqFQiw5OdyZE1dX/t2SHsJ7q9zL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3V181IK1QEItaB0Nc4RIVo9PNCZ8RgNWwZkaEohMFNKmmKcBgADXviqviiEEXnx5JNFNlK3riAPqvNjlq2VwvjBJhFEixSId/XA79jEEjPZdalXHEi2N787TgolMm8cT8DekDzXczQsC06d6375UZg+DUvkvjvsyhaFxOubF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVHMKpND; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34101107cc8so253520a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762371102; x=1762975902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJvqN/FYXoVwh6qr7l1fAEtmzEXDgIxcL6pBMQi85sc=;
        b=PVHMKpNDXBXBBKh+uN0m3KjZqSa9Uv5n0wx352eXSIOmPP8jzV0iWy4J3fPnJlZoom
         YqazFJ7CfUUqMeWvWPmdEDiUmpmKQ5LL9DiyT/7KP65noPSjIyZy4LTk3qXRr+DP37L5
         68yLirvzehtLIukIWnRKD1FkNqQscweVK86fPUZbDnHawfAuNCuITCGNXmqv7MudiKqd
         VNGlI4ls52+5tuWGSxvW1kXyniycW69hel6krbJa4P/oHuKSQsBkfgEGsppDGs6YQP1g
         JIiXbU5Xh49VE9RpSCeBeZ9Q5xjS7FalXewNIsuQ8JKGSPwh5wm6vioWGiJz6td0WucD
         lUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371102; x=1762975902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJvqN/FYXoVwh6qr7l1fAEtmzEXDgIxcL6pBMQi85sc=;
        b=rJq/8rTVecis+A53Pro1vvgna5UoXjcL70+DN+L2FAGotL347UeiV6b/oSZGH/6VoA
         MBJazk1Hhcxysv+UI6O4Zl/WzcCJpq9XrEIXkMJGNUq2iHtvahG2BO8pAqxvHPIMW1Sy
         uk6fLLTaXmeEAKHqkhbIxsj2x9msD5uUya2YQCTGAy2I3V9r2kSX+UBjJFGSqxxafu2E
         A5HeGHVwT7R2q5MGf0DCAmo6gse5Q83iQZlz1Kw6jY86sVozTBh/9/ToDrSqXOiuqIAh
         e7eXnNEdHUsr1luSaMdkSSfkqBEBSrauCpV5AIgrKAp0xEBjXQvSnDBDWCqe0v0g3/8L
         4cQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZWEmleuobYgFP9BFCu+jNx7YUOuGQvXNd4RWU28vZl7IyPbC6LrPFnpd0Is5zV62KK3fqW47vhx8sImbRu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfFzygYlEuZa7+x2FaMOVHiChozTma5Xp66NgVCPYN8Ku4eNw
	aHJdb2Xv5/2PNZkWanX96Cu8n5rY3/INMjb52/EPyboIO7RxzqSXCe0=
X-Gm-Gg: ASbGnctpDjibnu50Tc8ZsDiqfQBJzhP52ohaBh4k1I5tiVvSFct9mxHDBtCd+00jznF
	uTlLjrUo2phqFBoRtvpJV39VA9+xkA1kOesi1AVH5zM0/M94Ped75gFXFj7riIUpbnJkw1r3GnJ
	Eeh659igHotryp2A+l+L6DUqJH1VDDBR/0fPAFIr8AgdZX9/r976+tfBgrbP29JAv+5prh45oc1
	nvQRf/0ikQckcj18hM9bU9F18BC+nqVvzajq9gOL0e+U2TlU5x2QCG8RmmRwBbb6GhwwfKERFgW
	bUKZdcX+1hMUkxklkUDv1YfK/FscM97tJmD4XCOoHO9uWjvrCflDa9tsw3X+CRX0sRUIEzZfBs1
	syaODzmcRkVOVojuCNqziDXKq6YBXEoXpW5BCxyox4UilR1ORtiGQvNSN0CAaqkU7DdKPzDCNQh
	kxHYpp/DFXsyXJdaZXpCZ/7OX2oIG7u91Zq7bc+f2Pg5p1U7dxetHQETrpEUE3pdCD2RqdQNYtY
	bA3NlOchpUXzNXtZTRF5oOI59+kfqh5c2NZRYphV+KRvCj4eiWUMOH/
X-Google-Smtp-Source: AGHT+IHEYHxkSKq31loBRy7lG4iYoi42JRRNozm8w4t4415/PWn971C55dwcIWM3pohgDfObZu6u1w==
X-Received: by 2002:a17:90a:c107:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-341a6c428damr5429218a91.14.1762371101999;
        Wed, 05 Nov 2025 11:31:41 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900eab130sm102335a12.25.2025.11.05.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:31:41 -0800 (PST)
Date: Wed, 5 Nov 2025 11:31:40 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQumHEL6GgxsPQEM@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>

On 11/05, Mina Almasry wrote:
> On Wed, Nov 5, 2025 at 9:34 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 11/04, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> >
> > [..]
> >
> > > +Autorelease Control
> > > +~~~~~~~~~~~~~~~~~~~
> >
> > Have you considered an option to have this flag on the dmabuf binding
> > itself? This will let us keep everything in ynl and not add a new socket
> > option. I think also semantically, this is a property of the binding
> > and not the socket? (not sure what's gonna happen if we have
> > autorelease=on and autorelease=off sockets receiving to the same
> > dmabuf)
> 
> I think this thread (and maybe other comments on that patch) is the
> context that missed your inbox:
> 
> https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.com/
> 
> Let us know if you disagree.

Thanks, I did miss that whole v5 because I was OOO, let me take a look!

