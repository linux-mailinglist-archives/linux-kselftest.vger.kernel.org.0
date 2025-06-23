Return-Path: <linux-kselftest+bounces-35608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11CAE39AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6978B170B5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E52367A2;
	Mon, 23 Jun 2025 09:16:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500421B19D;
	Mon, 23 Jun 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670178; cv=none; b=ENXQWYzU1bjNLvCsTxZAYe3KWnZPuDzfDgB0uybSxM2HjebVaQ3FqoDvAbjJHWZg//TsjsfTOfpPcSpqT//YuhBiMGXbsZncPH29/to6kF+mdKDPnGmuW/9Usr615a0LjqfIhFV3OBORdYRsQD5J/c/1iGz3TPMFpaJ6+McT5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670178; c=relaxed/simple;
	bh=SMTgouuv53WlY4KZjebO4g1qpffF1fKT28HWAjbsnQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7fDptwbsCVNZpV6SZwhpFbi3cPe7X8AGMS9VSOIiDbuCxKFPBcxNCeOMiqR69H/7lVZ0Qh1VuTsbyNwXrIqCgNv4Qoc1LFDNAv3NsgBnUZVOxg4t/WNBwjOkzy6OAhodJYo/anFMjEVS2t5ELGLqDKyQq9uYEBit9sq+59KY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so6119766a12.3;
        Mon, 23 Jun 2025 02:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670176; x=1751274976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIUxRz+rwH/i111WGtAAGmLwLNtTNZbhbtnk+ofryfM=;
        b=kpzF8a5DgpKnqbjb3ziNEBphrC/KqT4sAVFj0QVPrAquIUyFHd14Gu63vAMcT5UDsp
         EsqJ1ABT9FnfvS5b9oM7pFnT1dioObBHoXBmZRshjrSdjjz2adD1xeW9CBTgkK/3DISn
         hACnThGM/62aygAV9iVUheaTat/ZD1THdHdChYlXV0D0jQcFcZRrw54UMO4PU4DD+WMs
         0J+m5+uAWNtBwzy/2bO4B7EOvE0saOFjFDPHG7DSRomVRBvcuc9jb6aVP9gqV38H62nv
         Yw72LkKUDFjXT0KPc8kgdgSCkNaoqo1L7Z0O2CluyNlIs8c8zmVlNUC/2bUPKvAwr4oV
         af4g==
X-Forwarded-Encrypted: i=1; AJvYcCUsXQLuspBRgsrONNbTs6XKkk8f7VQWQUwMYwb+F6Aunhk8en9O08H2RaR41y3L/5swwb21DxfO@vger.kernel.org, AJvYcCVPOcCdyZE9qHqDBUnW1CrEPfhG/0v2SdmPqwS3Ag9ZJD3WWN0NNVntGd7ahcENPDszyGOWYHEnrKST0Z9tg6Lp@vger.kernel.org, AJvYcCVgnEUR5atHA3nMimnkha58THBTfchA6PNghQRRJ9xQ+RkR4gzZ2dhOagpYvPgRXS4X31vTB5r9PnnthyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAuFqddh97AtbfpS/RcYW3LVKl9gWpKuJyfPMtRjTX+FrESgL
	1MmLAW6Jr9eZDdT0+AJ3ySTZwIYZ1ScIU9GZlVVvdODeEan8/bm1PlRP
X-Gm-Gg: ASbGncvkJL1H6nIXXnhZzFGKZQ9D0YtgKZ0cjsEA3EgaNNAXiazPrNg5JHsQy51J6Hl
	wY3plgw0xFcfPfZieaisGRp2XCKL5UEEQ5dz9k7r9BwMzWGkUWBpMM9zeoOwqmQlItCUHyoVbB3
	oZ/fxNu5XKEZc6+uvHWGNBDny7a80lPbrYF/EeGkLMqM5dppP1G56tjJ1pPl/bjPGc55pbiiGwo
	80V46Pf+TSJ8I7ABZHJrd8xY6l5xYokh/BA1vv70L4Ps0f5uwf5wRKxtPm46fX8eTpb+qpiyYuh
	6rdXaK+5QYBYlchp/RpvzYifsW9ghmuqrbEy1pEEvUFJcbBy/rIS
X-Google-Smtp-Source: AGHT+IHcutTLwUezCuTJnBQkkQOqvdS07bhlRajR2F7YpX5joza2suS0WGlVmjXs+hoO/t3GNawO7w==
X-Received: by 2002:a05:6402:5c8:b0:609:9115:60f8 with SMTP id 4fb4d7f45d1cf-60a1cd2ca71mr9580805a12.21.1750670175440;
        Mon, 23 Jun 2025 02:16:15 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18cba49dsm5689603a12.56.2025.06.23.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:16:14 -0700 (PDT)
Date: Mon, 23 Jun 2025 02:16:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <aFkbXFvOKeMALwBg@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
 <aEwd9oLRnxna97JK@gmail.com>
 <20250613174233.0dd5e7c1@kernel.org>
 <aFUeT8HSPYiDyALB@gmail.com>
 <20250621065121.78701641@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621065121.78701641@kernel.org>

On Sat, Jun 21, 2025 at 06:51:21AM -0700, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 01:39:43 -0700 Breno Leitao wrote:
> > > FWIW you can steal bpftrace integration from this series:
> > > https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/  
> > 
> > Yes, that would be great. I think we can iterate until we hit the poll
> > path, otherwise we skip the test at timeout. Something as:
> > 
> > 	while (true):
> > 		send msg
> > 		if netpoll_poll_dev() was invoked:
> > 			ksft_exit
> > 		
> > 		if timeout:
> > 			raise KsftSkipEx
> > 	
> > As soon as your code lands, I will adapt the test to do so. Meanwhile,
> > I will send the v1 for the netpoll, and later we can iterate.
> > 
> > Thanks for working on this bfptrace helper. This will be useful on other
> > usecases as well.
> 
> Right, you're the second person I pointed that patch out to. Would be
> great if someone could steal that patch and make it a part of their
> series so that it gets merged 

I can do that. I was expecting your patches to be landed, and then
I would reuse it. I was not expecting to ship it as part of my patchset.


So, the selftest for netpoll is already in the mailing list[1], so, we
have two options, now:

  1) Steal your patch and make [1] depend on it.
  2) Merge the selftest [1] and, then, steal your patch by adding the
     bpftrace support in it.

What is your recommendation?

Link: https://lore.kernel.org/all/20250620-netpoll_test-v1-1-5068832f72fc@debian.org/ [1]

Thanks,
--breno

