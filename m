Return-Path: <linux-kselftest+bounces-24789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596DA16B6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412B9169A52
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0F1DEFF8;
	Mon, 20 Jan 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnlhrV3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAC167DAC;
	Mon, 20 Jan 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372074; cv=none; b=d6RvIrFrkSzFW1j6jXdDTWHRU8VDAhe8m+8z16ieLboO/AZiFpUOfzgnb74BzEFZs20uPqpkWKc5BnZqhzlPxJhSfCyI//u8f3R8OvqvjX/lg/Vj0s5eSK7Ul0u1CNEGxPL+9Na6SkVPLk1RwGlMa3joezQLz+7wD4m/+it6DVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372074; c=relaxed/simple;
	bh=FFlF49Ndcu7bSY/WqS5XDeOlTqds0cZQy8nZ7PQMmBE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mtgoAvLGT1xIhoddQ0yzCL4STQAhMhyP3xVVasESaJdSzF/B11QMVf3R6K9vsX/i8bU3/hdS83QiA7ITFxcsH8ksazm9UeGNnDO6InXW2daN/wAX2ID41+Lgs0A6czLMWruaIHD5sLA+VkDNPq/gtgmA5rzOlMytSbBLaEu17+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnlhrV3i; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b9ad0e84e6so510471785a.0;
        Mon, 20 Jan 2025 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372071; x=1737976871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMQYJiNSDjtYISDtLQzbnRXfj/hyY9kWIt5FzEKX0e8=;
        b=JnlhrV3iUGu2jxdi6150z9QchhJX+5DRoFm3elsHtHNoR+9Th7qw4lM9cAzafuvEv3
         d6m1TY128purcClmbN5gXBzylbiOUpa+xHcqds2iVyzuC22h4OrsudhIBiAMb9Q4JJ9Y
         BvX3Yr6W5ZXBK6EhY8wdvsSO8x+4NssHL/Vhm/DGi9OhbGCnRPDnhGvYZKHy5LrzvRVQ
         sgDA4BhUAot3kmb64Cd+reQ3DS8Cu0bQyfxvxq+4sVRC12/1o6rr3VMR+eD1m4nRJzUO
         c3Z5BE2PuuT9yZPW6hBhN9ICd/NskcdMfonuav1bFIlB+jG3ihcGIadVVM0/NVmZw+Fv
         87Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372071; x=1737976871;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMQYJiNSDjtYISDtLQzbnRXfj/hyY9kWIt5FzEKX0e8=;
        b=HMMjh9dKQ/Jm04bCFH+pomufOf2Cg0g2FPFeRpP5Eh63vRDJyLZ88OJZy//J2YMOmx
         SYOl8UT32ghcZvbidHOUYunE2Xq0KaRWSuoZKabOvTdiWrdgV7QvqAzry5AG25sE/JEj
         p5su3izhmwbto+f/DVTowgn6j8bUClbetbnbEvJr9GVT+LaO96XrHDKwnakSVynwoAfZ
         NGbF8Y/oEcPnKQcAl0h9vkTaIHUaWybFATXH8x7Fd3k8weTuiONSpCsVwBJngAjwtNgR
         J8yUKXk9iDxiur9NmefLnK/AiDkAx7GnHJt/oNuWFZl5Wm8TSL1YUx1pAQf5Dy6IoDkb
         td1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBedVjJByDEHXT8Ec69v2yYf/jG7ppP9FO9V4MPlSHUDqs/ZWE4TU/DG3Fh399Py1eWaJWU2AyZ6uiStxno9cb@vger.kernel.org, AJvYcCVBnT93VFPavlJhDYu9OwbbXIhiervAWI7lSQB0WurnHbqNYlMpksVoZRfZmsowJnWhj0A=@vger.kernel.org, AJvYcCWP63IWpDalAt0U2CnjUtr4ZWLvSOSde3DhL1zPVzHtuLKalF7uoBomsyUfbb5+vhKvIo5TxOAz+esG@vger.kernel.org, AJvYcCWkSBwzSrQYInA+EalbZdQ286NFm4YobxCfNY/5NdfBUvT/c1v98yy0Dnj3hLA36+nmDTpmDKtRMVn6VFdM@vger.kernel.org, AJvYcCXUZsjMSzdek7rJnigTroGHY54BXObdo3dA0Ze+m7E4Lgx1ZXqFhwxZFWq94P+3VurROialScm9@vger.kernel.org
X-Gm-Message-State: AOJu0YyGoo/foGSSdowoVMMJLoJnEQjmT+DUyeqjIHXJUiIaoyCvfn7A
	+lc7AlOS8YbD/qnBI8vxWRtlkGisydggKqHuzgey/2nuBI9evRsk
X-Gm-Gg: ASbGncs8NEo8xq4e+6RN2QvoIyfAgckFnPVP+rl/RDxJ0rGL8873dLK0sbeTKDblkzj
	7Z5g4X3hFaiMMgTIlFpB4a8IgQiEjD6UpfO0hzcyHSlm5rF9Lbd+6FbgCuBpVVt2ZhDvuQ5QYGb
	btFdgLty3O0pwzdLzTEmiLfnyrDlw2PruWqjgeKZSVsXZxkCUx0S/XhoKmdRVK4w6ccK/sLn/Lh
	ywAa+t0VvrN05mLLrFb5Xb1+J6JzC2x2q76X6KfqdeIrWU+brI0iAh0gklijuL+A1KHaaSoPMZw
	Li3aoX0Cpx17ZuY7jNGp4He+4Fr0JQ99hDxkStiDaQ==
X-Google-Smtp-Source: AGHT+IGvsCFrFHwRRgYBN5w8OcJpAZzq676HslkeBClKtRNI69dAi2O4pLRADREXBOwAOfvNQkHoFQ==
X-Received: by 2002:a05:620a:43a6:b0:7b7:142d:53d2 with SMTP id af79cd13be357-7be63248004mr1940175185a.41.1737372070030;
        Mon, 20 Jan 2025 03:21:10 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d98ffsm430581585a.85.2025.01.20.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:21:09 -0800 (PST)
Date: Mon, 20 Jan 2025 06:21:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678e31a4aa4b4_19c73729488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-5-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-5-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 5/9] tun: Decouple vnet handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Decouple the vnet handling code so that we can reuse it for tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

