Return-Path: <linux-kselftest+bounces-33334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C02ABC29E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2847A158E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C0286421;
	Mon, 19 May 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXeY2WEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C228540A;
	Mon, 19 May 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669064; cv=none; b=KeODzBfw4/88iTUe2TT9+3/ea/oyAKGfWdVXxsdp7P2ecBDwBFN1QWpVCHMFiR709vbiTIagkpojE0ucAoNwfnCqCO5UXrHztMOAaSCS1z0rdoNh1tGONUeaQWgjytvJp4Rjw17aCP3ZXxkAHNPaMpsrVFvt0ctlUUdtWOQBsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669064; c=relaxed/simple;
	bh=mDhdcfFCKPmFBEWNxq5Z9s2isUkHamgeW8nk5pJ0tCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljoxP2PMz1EAPVoeejIsWzOs1MbXYJwOSi8iAIaR5O9BCUNdzvKh/jieBc8/nyVdGAW7QaHoyZFLqPJjJzr3DzVYgQTUZwb3q/i0cPd7E5UoCW+ZZu+kkfGc/tGW+BTV+oUFamaVOt94CO/jscHb75esiNiiuI+glbgYquHtjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXeY2WEm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c3d06de3so1929430b3a.0;
        Mon, 19 May 2025 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669062; x=1748273862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9hmUGaxmIAGxkrY0fltomo39V4YLpF7TI+YnFcY+ko=;
        b=FXeY2WEmvv0r25eM7D//bznOOW4ptHywX4KwWA2rTOATYGPDyc6BRZIqD5sG+vBCYG
         2hnFhgwTLAt/FOz1Z2/wIm7MVbbze20jHV2ZurXR8fdzVvo3FYs6602NZVd0+iqfvep5
         OflI5DahDgnQmZ6BemHWirOmFHgbqCG61scSTNZyFMJQDvo1UAgOM0YzC384igesBQYP
         rd3zqhfbqRct/VsU4yaQ3dfRfyaD9/hVOr4NEya4lO90P4yLnU7W2/Lkkc/GEjWqf1Eb
         FkcK4fZi7s+tn6mVPW5IqgxBenJhACSWU5O0gpD3z8J0xlopli2cshK/tjtGqIpCs/DH
         6WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669062; x=1748273862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9hmUGaxmIAGxkrY0fltomo39V4YLpF7TI+YnFcY+ko=;
        b=qAa8ZUPChs/fWllEPEd3iqPAFFRjzw6Rz3bw5n2H7tMy+peqHwJybXWe9qDLgAUPaj
         rFV/3Mel8DM+bJJ++B+iKfxYThim2k7S5uUkmC3EcmoUPvid/RYPK/KeOhjicoOp86I2
         lcGkxdTJeVxgc04l4S0GMQ521Vl9xhavR2MsEzgcDH+SbSDlvna/2y42gZAvi7Zw3Lk/
         K/1FFAw21LnsXvGFGmZRUKNTXBxHVc38kVUL2d7rQQAxiTUF+1ssPI4g3aUq/D9/LHYH
         vZtqqd/LXha/AQDalnSRg9TWkepOCvE9ekpaF68eMdcKUTjaFCLl+anj56NykN961Njr
         rlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT3MfhCLQK3lAh6QnUA7IqNTed2Ex2k6JlxtoUuJWPH3dj7aocXHbEgvjBpqkCefVLzTMZL/CpcgcHmvc=@vger.kernel.org, AJvYcCWoLY3oSoo9PS58wVPAKKUCMd2vqiSY9FUW1uTkDgJ3pFDbVB8KVH4GCQ+vPjYRBqwKfVQa6jD16CPjVqkheafr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbwymTAnFlZnlwEXxD6U+wAu+utTxPnzKCRj0gs5qcqlBiCTK
	D32bJb8dwFx4yWQT9vGP0gpPb5eXU1SxiwDnSSsX/yBZ1+OR+qm65gY=
X-Gm-Gg: ASbGncs/7zFM428oYPMwUgNQQfh8zVU3RxhWEuXNTDvxAXBYtezjm5hNo+k6r4+BVwh
	5LXTI55RfBqH60p8PD2ioVeWprvllQ0+2hCMmEuZMOQyhLINajznif75inejuAgu8Fh3OL3hcjL
	b6+vjgrfYCykRjZpm8i6Tyty+dOFWb4hMpzVkEE1ujRxUU6EdinOGwiS9XC697IHZPEyEJjSjda
	PEj77yjK9leLsJTiPEW4yp/JCo4Cb3gVCUzKixvCK6V2whD1oz7BStYg/2leXngpTa6yhJUkBcs
	wYzHRu2CSoJHEAZhFvuJYPmjCGCT2RwaKuXDdKMGG90wyMBKp79lUS4x0dyS32DPv6M53rDRDBS
	NjV8v4Wc+yK3xuR+97mF4Z5A=
X-Google-Smtp-Source: AGHT+IEzXTm4mqeVvIinlmF9I/Nrafq8fSRTiBUOOCESsdbgKcfuQ6Nj7BYOM6AIZTGav6VLiHNKzQ==
X-Received: by 2002:a05:6a00:4fc2:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-742acc906ccmr16975194b3a.1.1747669062194;
        Mon, 19 May 2025 08:37:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970d75csm6612617b3a.69.2025.05.19.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:37:41 -0700 (PDT)
Date: Mon, 19 May 2025 08:37:41 -0700
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
Subject: Re: [PATCH net-next v1 9/9] net: devmem: ncdevmem: remove unused
 variable
Message-ID: <aCtQRXzWSEQth-VK@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-10-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-10-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> This variable is unused and can be removed.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

