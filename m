Return-Path: <linux-kselftest+bounces-27367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B691A4294E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938BF17B087
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DF263F4B;
	Mon, 24 Feb 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy6jSQb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98470263C72;
	Mon, 24 Feb 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417334; cv=none; b=XMFAsg3YqebMz3OOJiVejwswaXCUMm8N9pCqr8o1pSy63+EdV5n8cIdcRwDZ8c5pE8gymyTj7lTjul1PEm2ltm6RUtc1Z458kEzY8I3wJ3RMTrM7NfcHHN5zm+hyE8Xl8aO23cm2HqqE2/+c6Yh8irqbuU1guP8Sw+FqpEs00+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417334; c=relaxed/simple;
	bh=7zX5aWXKrLXXfHIknWWq+MssxzWYqqZPISFTHBTePAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+kGUvEgOZ68yNHsyon4WL63tJJgo8VkTg6oCiYYeK8cxJktXwf1bkNn4r7en7J8MfERLt62dVBC71++eJbYCud6duA5tl8p1WPVcN4ocvYjNAjSgR8W7wV25szmjs1Vpk7i3d5GnvAQvDXtjnQ8xVIqpyft9eVxxMJ3B5s2CJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy6jSQb2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so7296428a91.1;
        Mon, 24 Feb 2025 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417332; x=1741022132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSwmMkmIgLqpokeXm1Oy2RMQPP6UHGDY7f3neUmxahM=;
        b=Jy6jSQb2ke7CzY6l9eflfyDKMjNQXyizH/wdsR6CQSYjgM5V1GAmjuuSz95ij89cCV
         zzIxkRyQCB64TM22djdKo0dJsWUnJ5gDN6PsZ56vQV2LLY1+v3gnHfQ+Jy1fxwgMqeFg
         8jMwDS0K906JCXQ0ajmTtD6gQ+5GdadUCaBLmpdPbOlhbb2UKQEXzNWw7IiPJs/Zhe1J
         YvEdPW9jJph7sK4J0IDvvGuNeXabJeidF20M7oeqXJaM6+aiwO9yf5hhvC05VU8aJ+2x
         zQ4rI6idpft2yDEf3MNUcfl1Xe4MSziW6smr3jQHFSxKR+3V0Gs6JmLkfeGG5vatNU9K
         2lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417332; x=1741022132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSwmMkmIgLqpokeXm1Oy2RMQPP6UHGDY7f3neUmxahM=;
        b=LbeB7Bo/Bo59490bnqjjB6U+2PxZwi7GGDAtpSI6Dqih7/T428Sn2HnGUFuoJ9j+Jn
         djsVIMlqCBDdw4oL4h2b4t+MWERZs0DXTrjNPP+nMaZn1R86pNvHgcuPNla7jw9PYQgR
         Nvq8UN5dCBsi2yepZ6yahsmy5W2w5emg8E3HP2BScRPxHYARrHkqmm34mM8YKrLoLzA9
         PkvwbMWpexTHES3KIeybJRFw3KfWOLyZehrXNz9OJVYhnpp/aPT0y1ar3hfuXDzL503H
         Uj+yFcBsyggwdNUOKp06Gx23ba/eD5eip6NIySRaZfB4gin26p3oVMPW3QW6EBpiJB3A
         T6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUkLl2SfdpMxHq16KK63d/MQh/WlK7ZRUpACftw7r2dywthqZvSbi7XckJwZ5MPjsZLNZs=@vger.kernel.org, AJvYcCV32FVJREuFTWXH97VROK6InwF3/RSW29rlqTRbvJovHyZTUTQ7wjuJpWXAx06IuC5oaauJWR3gR1DAjPPOw0d/@vger.kernel.org, AJvYcCXKTTnIFWBNXm2zWImnENG+ZsOh159NHr0NaR7cVNZ4XZ7sinZlGhfd7l+14yplrsixB2O9J6O5O2YbHFEC@vger.kernel.org, AJvYcCXMycuzWFmD4qhs3k1hrFu2wakDYxG939SC76HEZzEc2ojGxbs/pUzoyWObwMg7iglyJVq+Jrp31oFA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UZ6SqDn9JIkj3CLsbUJdy4uSD7gyOaJ1LTFD0JjZswAjEYMK
	PYAy6i86X5R65vU623IXyygO+SWkvFCVLq223wa3iFYO2sJ+CtY=
X-Gm-Gg: ASbGncsD2+QxdHhJDek9vrV/rALNgIY4W6IYju+nRw+OYagunDhdbsCBFMlByiFeNwn
	zSvZyiPI6IqFmsLNBXqhP87hHhEWMopCAbrdQ/j6W+/9j37oomwgn79gubpaQehAtqLWxK6npNf
	xih6NmK8chRINyu+gKIU0dAnYTJheIWp7Iql71A/SLNqmSI8IKNwfsmJKtQjfpr4OL9rQzn18iB
	AQsSIyGVXrPDnGQ/JThojiPIQs8MhgEMXG5owLRTnU2+RfqUG3oHrR7JXDUCE/tcreh/2/h+x0s
	/oo/Kg6pAFEFwsjMMJWd+fh4NQ==
X-Google-Smtp-Source: AGHT+IFWarbUxrrczcIr8TarroVGKxHwHMvRfgBRrDRlPG93ZRUc7qqfwewXv5vW5TnFkQrdpVqUBw==
X-Received: by 2002:a17:90b:1f91:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-2fce75f1e43mr28310275a91.0.1740417331691;
        Mon, 24 Feb 2025 09:15:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb10fb5bsm6766211a91.33.2025.02.24.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:15:31 -0800 (PST)
Date: Mon, 24 Feb 2025 09:15:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7ypMjORvm99q6L0@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-10-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-10-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

We need exit_wait=True for check_rx as well, but I'll send this change
separately.

