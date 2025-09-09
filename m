Return-Path: <linux-kselftest+bounces-41063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57303B506DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133C03A4B8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B7241CB6;
	Tue,  9 Sep 2025 20:17:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4D2222CB;
	Tue,  9 Sep 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449054; cv=none; b=WL8hb2F7nxwvmZygzGtllEF+L4SelE51xQDG4fB3Eps4OLnrvKi6NFCCcdng0N1Si/Guj8aukmDmTWPI7h+R59zOFNfwpzfhVPOOYj/YEnXUh+Bnrs4asY1SBkutRGO/q+pAW4S7QzniYRfhSiG6ZuRdGwlEY5cXjWNI3f8TKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449054; c=relaxed/simple;
	bh=wC/CbOJ72UVbeJAbQqjNs2IoxTeIAOgQrzqhM2eyU7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOmeAX8+J+bI2E6EZkftrHvnkuLHsaMLhdgSigv6z/7duYZ0Vk3cIUqHez0dwW+1pTx541mwLVQTxNe3aU4wzstqHlX7F0uPW3pBlwPvs8AZ7tn9hw2GAgLRzC9dl0wm0W9m7N9sINgcNpbVWZIFksntISYbReRRKSRwvMgO9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so8604422a12.0;
        Tue, 09 Sep 2025 13:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449051; x=1758053851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ous3mP2p8adCZ2Wa9WhDA9KVTHw1CaqTv41/zoKiID8=;
        b=KWPvkdWk4v7iCw+L0QkTlyuN1WkLaGRlrbgOfrtikG4v+eqmtKjxmeg/9wPaUE+4n7
         NCV8NT710WQ+Uk3r2ZDxQ240fyjPA9yyCKsnEzYxYNmLEXOpvpaJ3A2cXov4bJlQLrqe
         B3rBQy7JgEP4mDkl/oiQtsLf1dIU/7FGwRl08f4UAi0AA6PQnORIju3OA6uKGXg/jDbN
         N4i2Lhe8HRNWMtJ3vVIDB1phyj56w3cjIxhnp6BFn8s7aVw75TtueCtbHGud6XqJg1vb
         NfkJ7tZ3nmtM/s5DLsnPqqueHywMi/fMWgWGpDurK6rjSHVpvbUusNax/AiWsslwEFcz
         4MCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfbX6VQOsIjzRBbHt4dQVGKCeAKSk6Iq0nGdY/28PKqa+FUqRQYhAr97e53sCqK8FOnpNdipoUI4Ll412zelca@vger.kernel.org, AJvYcCVr5eg2CrTL9DUZfO9Os3POlzrk/kZRxbBfPjukJGAuXUSxGuMe9rJa2LHGXVcjpitc0EP1/55+@vger.kernel.org, AJvYcCW445OfgR7zujU5XZc8vOl4rwX7sbXnLtdRt8dHNtu4ZGSqrnw6yj1rf8TED/kmUC3mFq5WW49oe9mqyDQ=@vger.kernel.org, AJvYcCWOQ1J8WnKdJiEzXsIn/4curiy23RHTzL4Hj5zynf4U+stW1q5q5lkvKJjucT6ssZfDp9aNVumj@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxoSmDYD8jmMLNzAwKf/V7sooogLfAXj4lWYf3ZJSO6hKN+vu
	fTGeysrDTN9p+uL3UeXEV62mmSwQl0usfn+pu0GT9ERPzIlZDXiX2nS4
X-Gm-Gg: ASbGnctoiGMr1y/vqRIkQP3sLFO/ncWkSRT55LVCXNaiPMcBkpveDjHBODmfvZpZdoN
	2RTgt4792tj+BaM5oomrakelnfoZO4FMjO1q8QKsEKxdM7ryVVZ8Mjq0ZF8IlIGzGalV0ckZV9k
	W/P42Pk0pDivZqEMNnrTjufPv40q1X5LCZHvAK3sqRn5JeXPnu2Bl3GfHr2mR9J/yVRFau3gITd
	OlENZ6MmcxtSBQDy5J88uSamXXKc2hUSHftRqj2B7Ab29SBHURvComBn5sPYJ+qrQeoLo5XVjG+
	sOoD1ES419jUO0+ZRgGqJCZj/+c+t7JM7zw306KJyygkrWEmwZ+qN8T/m7/3bVpqimo+D+lOFWw
	xWMX3x+ivstN6watMYYn/ASw=
X-Google-Smtp-Source: AGHT+IFV5CRFWEp2fMevaM+6ovBkmyV3H9l9vbdnrIuK+4x4iQB7+nUypI7RMhnSsqpmtnAljijbBQ==
X-Received: by 2002:a17:907:9305:b0:afe:ef8a:ac69 with SMTP id a640c23a62f3a-b04b16dd3ccmr1243959566b.43.1757449050399;
        Tue, 09 Sep 2025 13:17:30 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078345426fsm44716766b.106.2025.09.09.13.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:17:29 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:17:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com, 
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <20250908182958.23dc4ba0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908182958.23dc4ba0@kernel.org>

On Mon, Sep 08, 2025 at 06:29:58PM -0700, Jakub Kicinski wrote:
> On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:
> > I wonder if there might be a demon lurking in bonding+netpoll that this
> > was papering over? Not a reason not to fix the leaks IMO, I'm just
> > curious, I don't want to spend time on it if you already did :)
> 
> +1, I also feel like it'd be good to have some bonding tests in place
> when we're removing a hack added specifically for bonding.

Do you prefer to have a separated bonding selftest, or, is it better to
add some bond operations in the torture selftest?

