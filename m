Return-Path: <linux-kselftest+bounces-33874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E694AC5234
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4F9E1A11
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC5927F177;
	Tue, 27 May 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfgjiKv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B427B4ED;
	Tue, 27 May 2025 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360049; cv=none; b=fR6mShPz7eMHqggZbcI3p0IS6Gq7GFcwEkQIe+Ek6+wZnDmaUf5YPHyM5cxWVQtD7m3dZDiVySFTFlzWEpZAscprvIoFaBaIzuNy1uVEKXWrMVCDZvjmgi9Rr6Q74m0/jSKe/XrU4SNFUOTq4cKR7P6eNSB1MY/rYq9T5ygMxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360049; c=relaxed/simple;
	bh=onaH/5MC60OFhqM1bgahQ35C9Vl7BjT7urVOzH5hK5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieKUsWzwg1U0XhNtJpyvioKmHDrAecH5OizNgrWGdFFCNT/x+SrfbAQTHb39nYuZADofri8EmjzNi8eDAMGLqhKmXtV9rN4MnnQ7uUUH1QN4dMxowfqdfGqEA1oytPGo6RIxplpiUwLOkU/CfVcg0eTEflXCxV1auFUlG5qrR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfgjiKv5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2346765d5b0so20967095ad.2;
        Tue, 27 May 2025 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748360048; x=1748964848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvevDTIPr6tFg1Rf0RWig/FZOR9DAegXMR18mdtSb6w=;
        b=gfgjiKv5Xs++/nL1n26LDLxdCih+p9kSqVLDIEmlvB+EyYDHx0ZHnKuT6nWbUFv3r+
         uyfI8e7MZIE0Y3cE3seoM2+Rm/3tERnnIOZ75WfsV7K5TQWg20FimopPupX2TMacWS62
         eXZiMnROhZ+9VxDdv3I6K+XarHDUH7z8r9xWvcRm2X6bx7qv2AXHlm1CEUQMCXlR/IGQ
         XWDZwM93O5ALWD82IX0a7wMbCCikKxaJoyOgBEpIGfS1QlI86LW1ZdUXz25UykPMPemz
         CgJjOqZ5CnoTm2qcoY0biipnlprpzqEalm8qPlcf/frDtd7QnwahaJ9rXoR192TOwoPn
         uURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360048; x=1748964848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvevDTIPr6tFg1Rf0RWig/FZOR9DAegXMR18mdtSb6w=;
        b=fceqoxYcyGfkSzxB1VlQzi6gcPiSWTt1kw8qNI9PD+OecLkM3m6Qx0IFXSYPdWU+DR
         0SKiwJWItYFHglKrT7zo7z/u5vbpMcIbp2b5vr0GyJxr3klGzATFtWrot8R5disBx92q
         9jQtEWAI8HkZF6Pn2i5hpFSVQED7/BVisWRERJ2cvRuePoN5kwQz54/VDsd3QH4eadhO
         y7osUiNr6ros7PgNdVJdu1eMS8hve29V8GFWKeQAnT+9/OJf0kinAvlKNOL0AflB/TTw
         K/KLd4W734KN0MI5wGqVacQnbmTXVtSYPyVKhvxb0Q1YWMiWM1ZTB4L8O75JWy9oJ2Fr
         z2bg==
X-Forwarded-Encrypted: i=1; AJvYcCV/W+llFUy3miARebqFBc8z13dIAhQDkoYmNbfQXuG2s9O7KDqQvLCipspjwZ3wfTUwcZlKd9zLG2tpHOr4mtiO@vger.kernel.org, AJvYcCX25TOwtACdsWIadstF45TsgCa82Gsk6TUPPJKs6QLlijprqwwcnmolsLixPAMxS/Irkdqo2IvXqqwaZpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVZKWV9LoWz20FYvCBsDUQO9qCORC8PCYLsiWm394ZsUvCTat
	p5Zne1y5Hya6lNT1P48Xr9XeJWoi9WWmG3zZZ6JbjBUhSQd6MHl6XlA=
X-Gm-Gg: ASbGncuEhK5vjl664aRYwuM8x87nsNf9Oo8IJUBN15u/Hl0E5rsEdSkoLvBPr6X62ZU
	JxIxwUPKN41MWIjFQ7ZXUBwqrc0FxeV9+m4EUbdbgpJiWRU90dDkHDtdbiKX0W/TTYiDGZk5tpC
	O7Qb8DZ36kiLRSlrYVA1GBYQzxcGwqregnr9uzaaA1l8mIm35qFnfBpQh6covzSkWoRkbb8RON/
	DA9/08nehA7tj6iNNHQ4m6LYXuXk89DsDCUFv5pqqhyBoGRIvntu04m4lLShOc6JpYmJ66pxPH6
	yX0WbvR4KsHB75/KsljK/XQsoFC98MmXwVu2q4u+HJR9MUxBovWDRBXyVr83fTzQSBrvXkpzcUA
	oUeijj0qUSrfk
X-Google-Smtp-Source: AGHT+IES4irSncO6HEmX+TPu5SknROQcluBAUK1G1wkYFWTi852ToDrCuGmcDPoQDdssDReHGlm6Iw==
X-Received: by 2002:a17:903:3d0e:b0:22e:3b65:9265 with SMTP id d9443c01a7336-23414f3339amr172974435ad.8.1748360047574;
        Tue, 27 May 2025 08:34:07 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-233b1bf1cdasm109775565ad.181.2025.05.27.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:34:07 -0700 (PDT)
Date: Tue, 27 May 2025 08:34:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v2 3/8] net: devmem: preserve sockc_err
Message-ID: <aDXbbpY6VTWj9PsC@mini-arch>
References: <20250523230524.1107879-1-almasrymina@google.com>
 <20250523230524.1107879-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523230524.1107879-4-almasrymina@google.com>

On 05/23, Mina Almasry wrote:
> Preserve the error code returned by sock_cmsg_send and return that on
> err.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

