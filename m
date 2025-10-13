Return-Path: <linux-kselftest+bounces-43022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277FBD5831
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B903E4BCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D0305051;
	Mon, 13 Oct 2025 17:28:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF242D1F40
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376498; cv=none; b=dPJ7vuTFUcXyz+d9ZmTFV1O5OQ4vy8B/4zTRwkLzjK48AmYMlFzZkitv3PS5c1fUws/uOb6Yw+2SzxdaLhuSyVcAfQfFIcRV8TMG3o6Vlw9ok7Y7dNnz75RE9bQT8E/UYx4Wow5oi1M5cI2CmtL5lINNvpZdu64Hu17sCnio/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376498; c=relaxed/simple;
	bh=KQY1hataPeuBtpGwZ6zSDU3DH0WtfgAwetJ9z7XB0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpia29Lt1PfolGqnpLWpHO4jxJq+nKCdb8qDGURKB8/M/boN57IYwd4hVMf04qHain4kAXnH1d3d8sDEEEU4VE+toXPv4Z4e9ZkOkA9o55RhhJYlkrJyFOjBhrcSjaLr3vDflHl2w4rrfzyl5VpQstTqw2QwxYiiUSGTfyCqcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b50206773adso998325266b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 10:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376493; x=1760981293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp7iPh/+dWBwTL1akrhieR7+Yb8elv0601JNgSVEhEA=;
        b=Ukv+TpJ+3dbdwxGwm9JVbpdH6Al8H2C6et3XUK38g7ynDwsuKt2JqFz3lu091zncuS
         9536jL4Fj7lCvV5SQFmvbNunuQnHy5aao4gHnWwE3xDxk9nXPWsf7m5c0rTwWfWOZ3XZ
         STDV6QLdb+OAe03CNy88X4q+tfL+2P6t8t0hS+vkOKOVdHfgg6JzeMroFRJ1r+8Wqrkb
         TszpMXgwXJwYNRQkqYbDq3WNN3dMtsjGmkW0XOvS8FVBO5nobay/dz01od5UAosqpHed
         7dv8KCGZGrX8kFEv9Tu/jkbhhxIAA4HmOYpxem7vs/RvjxjCPJ4jpPQJFev5oe0b0wzK
         b5SA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHqZl1cYXRTH82+ZBudb8J57rdyA1LE5MkL2jTj3qnBE8ZiX63LVlGHWm2LvlzQ/xdn4VA8xq0m3n0dsHzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrw9Pu84h4RKEUwsCRvnjaRC6foSKDbTPB7REjO9UIMqCdx+tC
	5NJguKmQ2GIyt96EGOsoCi9H9YVv0vv1WpnRM4LfCbuzGMtMA07sSJVC
X-Gm-Gg: ASbGncu3T5zoImjR0RV2O1TR8yMSZQOLmaer5NKxtX3aeyhdNo1x6iKWnzxegOG/ZVC
	R5o20nmjjzeJEn/q5gODM19WM+Z4RkLZFTIavs2s9s+XfdHr5mfooYxBrglEDzEWe6O1tIFixgY
	Kp5L4f7Ql5DdfBg4HlvliAbjWalZnt7P7lezC51v1yMR1xpbWqi0X0x/JA8lFIlHp84o/K/PdWc
	VRnZGf71tfVUmcmFolq1NMbnT49006vXXo8iv4KgtdDPlFlH1zRzzjrfnYKJPAe8QqBhemgDWgl
	8kc1C7kxE/2LEk1BoV+tRGzPJf/ZC6yTAPAIzcSnSo/eknREOXs42ZsAQnKkQ8H7wRA6A5Hei27
	kDeKN5OxtUL+DCCyi7kAScRKKEfSjDlYUwrI=
X-Google-Smtp-Source: AGHT+IE1dNy8sZMQ1etsuqp+Iq7aHMYbaFTc/gwrBE/njgDpnk152KciCb7i5X233OmPpKSNbCv8bQ==
X-Received: by 2002:a17:907:d48d:b0:b4d:71e9:1662 with SMTP id a640c23a62f3a-b4f43730a39mr3130006766b.30.1760376493324;
        Mon, 13 Oct 2025 10:28:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm967025666b.35.2025.10.13.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:28:12 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:28:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <poknlppzfnzkaxkiz5schua5tuwbssaimihaht3ebvxzwxgztg@jfkdpdri6n4r>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
 <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>

On Wed, Oct 08, 2025 at 06:02:56AM -0700, Breno Leitao wrote:

> > Note that with the create_netdevsim() helper from
> > tools/testing/selftests/net/lib.sh you could create the netdevsim device
> > directly in the target namespace and avoid some duplicate code.
> 
> Awesome. I am more than happy to create_netdevsim() in this selftest,
> and move the others to use it as well.
> 
> > It would be probably safer to create both rx and tx devices in child
> > namespaces.
> 
> Sure, that is doable, but, I need to change a few common helpers, to
> start netconsole from inside the "tx namespace" instead of the default
> namespace.
> 
> Given all the other netconsole selftest uses TX from the default net
> namespace, I would like to move them at all the same time.
> 
> Do you think it is Ok to have this test using TX interfaces from the
> main net namespace (as is now), and then I submit a follow patch to
> migrate all the netcons tests (including this one) to use a TX
> namespace? Then I can change the helpers at the same time, simplifying
> the code review.

In fact, I was able to isolate the functions for the isolation in the
self test, and now I have a test that relies on create_netdevsim() and
have two namespaces, one for TX and one for RX.

The problem is that it hits a bug on netdevsim that doesn't allow it to
run properly. Basically create_netdevsim() put the interface up, and
I need to get the interface down in order to enslaved it, losing the
carrier.

I've propsoed a fix in here:

https://lore.kernel.org/all/20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org/

So, I will send a new version for this patchset soon, but, it will
probably not pass the CI, given it will not have the fix aboveyet. But
I will send it anyway, so, people can further review the patchset.

Thanks
--breno

