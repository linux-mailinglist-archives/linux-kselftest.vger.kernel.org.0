Return-Path: <linux-kselftest+bounces-36577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95551AF9515
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254753BE3DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B317A30A;
	Fri,  4 Jul 2025 14:11:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242C1684A4;
	Fri,  4 Jul 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638305; cv=none; b=W4pk6LRjDBBs64bpbfMaB39DUJvxv4t2+mOnh1W/EJm+E2Vlp6p+zVrbZT137mmsslqvQ/sbGSa0NlVqxdWq6JE4ANC1kE86hXU36wrmULGGgrzECf51dFn84+emfjkgAIMLbbCDl1gt1tUy5Q3AFFXKtU09kPRnZnt0QGkLBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638305; c=relaxed/simple;
	bh=CmkVX/AlHdUGF7EU/UxJmy6pvZPFn5DsGlx8vOgCsfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFmup4ypfzsd3dBwsV1/RlPKsCVU/L6tZq76QfBPzmE4TI2HpOGU3EFcnlHhCiSHWLPMU5FIa/FilPgRWuVPjybrAybc43uBMwXQBw8vFfXz+0jN6385uN+xMVQsaqfjzTAZVVcMB41302LKxWfSCk0WPnhnJjf+nnf5o8v82C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so203629566b.1;
        Fri, 04 Jul 2025 07:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638303; x=1752243103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRAa0g9PO15koKX/YxHxS7CQNRrTGUND0RW5OSavxc8=;
        b=P5QHo03HVA2D22SFmfL6Ox0sBqXyvAVQji00KXhCdBe8gDG/eunE12x21X5Q8ZopZH
         9LgIkDRfZIz0DLaQMXimVYQ1qowEedCLY9oRKk7UVrF5H/NzEBLa8653kda3Mzx3Ch+F
         KP7JqaVNjyjKWZ3L0Lpvjw+UWxYPVQUEpf15Am7Mxk0YOcl881W2nj/GB/dqqhh1OFQ6
         T1gmnI3bKLitToj3iVKBdxHLh+H20T0bnDZ8GFZgWMxRQSDGa/u6tExOGtZjlpR0wTO1
         FSyC054bCUrcx99hwm5lj/iGf+bghF2yHRpv8CD52KLsSYoS01yI/IdpMFuH2E8MjrRN
         eyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+lDJZrBfomu6HCyXZEFJf+F8+TzxlX8eTNQ/01neUINwsJhX9EDnMXOu4uhgm97zIwh8jpjX0@vger.kernel.org, AJvYcCUTRvyc8w2BfsfMmpJqAU9jqf4b37k0lNefBP0Tv4Ky7oVGdsbbpnjjlLk5DODJQjp/ZXcwFpb3u+67zjwDoRF6@vger.kernel.org, AJvYcCUecceFV6FN8kCTLaw/c96mp7RCHWwJ+Zye8ZhtIJh+VFuksEP8Eygy7RveIu2Ha0yHQ+BoezltuAK4WM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZuqhbWem/TeHibbn6YjaE/pKI/PUhNG4CcjuxjyGxq8Hkhff
	rSDTorKU2/YYcDFpWzJgwzzxd+vmd0H1GLf15RPKhy/oQPB5bMJUXPyB
X-Gm-Gg: ASbGncsZzPFdgl8wHdsHIAZ5pdGqHXy2yfH8Ihf7j72kWWxyZ2XSpEjQqHBKI3/j5zc
	hjnCTk6TW3GhzLLBNgBtOONT/bUSMe5093cotH88o1gHW0zbQu1FqdcrM5ush/Eerbsnbw5pDYF
	u4xKV7VYsXM7dw4jt2K2i4jsN9J+3ocvXh/YOenRwzJMrZxbaJL4/e3QisNKNQ+Z5KHMg07ee3N
	jm+yp7KnEp+EkdoXNLZFYNlJF9f3i4GmZk+bH+1DTEaqYnhAjSDRz92b1Fk2FGPVEEcfsTXpfct
	93sasiqgwFiN/XC02IZFsE7PDXaD/BtX5drhxPl9wJYWHJc3E40Y9GP4NoQ=
X-Google-Smtp-Source: AGHT+IEQFkFVCz/lGhudJIPIvzROBvQcXZd+oF2zG6r2GV2a5CpOncQy6IOY96+a7ZBK9i5iZBHZKw==
X-Received: by 2002:a17:907:72c4:b0:ad8:e448:6c64 with SMTP id a640c23a62f3a-ae3f833e2a3mr318002266b.24.1751638302274;
        Fri, 04 Jul 2025 07:11:42 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:400::5:c915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6640e9sm1411534a12.2.2025.07.04.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:11:41 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:11:39 +0100
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 6/7] netpoll: move Ethernet setup to
 push_eth() helper
Message-ID: <aGfhG_E0Mxk8zPdB@gmail.com>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-6-13cf3db24e2b@debian.org>
 <20250704135450.GT41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704135450.GT41770@horms.kernel.org>

On Fri, Jul 04, 2025 at 02:54:50PM +0100, Simon Horman wrote:
> On Wed, Jul 02, 2025 at 03:06:38AM -0700, Breno Leitao wrote:
> > Refactor Ethernet header population into dedicated function, completing
> > the layered abstraction with:
> > 
> > - push_eth() for link layer
> > - push_udp() for transport
> > - push_ipv4()/push_ipv6() for network
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I note that Jakub's review of v1 has been addressed here.

Thanks for the whole review, Simon. I appreciate it!

--breno

