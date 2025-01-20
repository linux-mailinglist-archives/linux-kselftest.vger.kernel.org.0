Return-Path: <linux-kselftest+bounces-24786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA1A16B41
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BC18819FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C431C5F25;
	Mon, 20 Jan 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL/Ohk4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85733981;
	Mon, 20 Jan 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371326; cv=none; b=U/xXLsy1kqCdl3kWdPyxnPsGAlBWeAfO0OWbFonk6ey0TumF2KMcL7XRn6Z9oMJb8juJ1yulcs5EyGtdjyTIScDQGYWkZbHcqCmMdUeuoQ6rnyODCnZJq6BjacEGTKqITEY0PljhIVZeuWpcprJta1p/JRUBnoXDeQghd2lP/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371326; c=relaxed/simple;
	bh=ULAlyrVB0EFv5QHnlkeU1h1uFDt8QM0/aVvEPlRZ7/g=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j1Oo3XRbMzwJNVEtpam13WPvZcOjmJXdjyScKN6BNeXNoiQOsTM9uqMeGLH78Rg0WXCwYgEKBOsXUit8+3YlvXrqbjKhWuD+lXkkBKHPrVZ6ND01U6dcCdDIAfjl0Xg8y79RKAZhoVzeRYJrf6C3nvsMc0+OK8JsrxmMnHTqSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL/Ohk4v; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so364008085a.0;
        Mon, 20 Jan 2025 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371323; x=1737976123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG6TkAlGOMMNyymPZxnF0C646p7JeQya5BAnNmWiF0g=;
        b=kL/Ohk4vAEYEihC/tDXxNRZsAKAZOtzMC2aQwOsobf9dHKmxT6EmxloC5gKRepeut/
         2oIGXjkVkiNECqfeK9ZoLavJfDQoD+QOJ2az0PffkCuDjuMmNk2usphnEx0TmSqiP/kC
         ZlAlQEbV59okWi5wo53Rf6E2XBKx2Ju8mQplJwnKTl92M6/pmSf1qvLXbONwlQ8DhZLO
         q5QBaWd+L/XmqiNoGKb+Z9alcl8sg8xnRM7J9nI9QSXnK4FcfUA7Ky8l+A08cm2MDha8
         JY9LHjmKbgw5PDvOLYYcnu3tdpvrClE22CAG5gIPsxmnIidcp7NpPakPQWHlXWCEmwtM
         QaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371323; x=1737976123;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG6TkAlGOMMNyymPZxnF0C646p7JeQya5BAnNmWiF0g=;
        b=fXSdI7MJ5fZCuZ4vokXXenJLAeegn+f18lb+Q+vmCHom38W0shek3fisDQNBos3ZOM
         sT02Rcaadwjh5cC912qzauw3f4OZIAdQJlo/mgXAwhm6p/HjgfjTvz1JrxMJ+nmHirQi
         j2ZvV5LfC+g23rKk+Lcy8dfuHT01Hbxni6VlmLUrpL3fKo5ZxgcZWp9pXFoqbMZzx0Nr
         aQn6w7z+at6i6MVReuLAnx7dfSL4Zg24ZK7LVCNdJW7efY9nhK/W9PDkdd4cWs5kkvqg
         a+tJpl6qJrzHbmYZwM28nCozDIv1Wyl+rwax0V6dfVgGeqlkmk7VjiNYgcWnVSQhFnmw
         0MqA==
X-Forwarded-Encrypted: i=1; AJvYcCUAMVAbYiE3PIzk8zBQZbvZm0GF4iURUY0HCfXcw0kvI7LnkmwOwZcluix9+dpRomxYF/eh0pU7ROhjfKmC@vger.kernel.org, AJvYcCV0AUsvG/6GZPxcqKhrgUZHe8aGPFNMDtv4d/+jmVxk0n6l5BlrOKy+bQOm12lsGuXYr3xgs+VMMZfAd0xqAJYz@vger.kernel.org, AJvYcCVjNZmX4MkmrUtZ7ilofQaUwyGvbhhy4h6Q7HlPnAzUsu689GsaH9fAQIaqm9rp+GCAXeZEngpn@vger.kernel.org, AJvYcCVs4ShzUmUsF4Al4gkEPAGsdDnw9WSiHkPK94shoat6YVkcdsKBGI8kaf8wHWpFaExTHD0=@vger.kernel.org, AJvYcCXDokO4inTmLwt764UT2Wfv1hWakFBra4X0fqM2jJwBMGRY+OLbfpHip0aBDeEc2MxXhtI/QIvXs8DK@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxNWsWWDwYKJjRHNN5hFwmqy0PyfRGlYaQ09emq27FqRhw0KM
	fzRl1Wke7AqN72sSkGGgn6n7CqCPVH815h5E/mDzN6fqKZ1ViFbY
X-Gm-Gg: ASbGnctcm4yldjEUp4EIMaw7PnCspK/U4+RMXk6dBkN25FSnSnd5SGOE57JSkpdj+jU
	VIP6hmPg5qVJhRGiiSQ4EIrr0k8MisGPc8SnyVf/3RjizKu2zytLE/lXVRmVJ5yTu9vb4LUgMIv
	GozxFc+2wCe2qaHLwj6rq2GyyLK51gL62H26D1ks63u5TA+PFbgHlI5ykT4s0R6LkGL8CJlZUos
	aMd7q9xuFIFrfDXgcu8M08/D6aDPOaET9kFtdwvZz6LgLO9rfJf1EhIYXkbKAPwuX+FVYL55drP
	0E0q++6T/tLuVXwF6m1X5ORabOhv8NhEPameHT7h3w==
X-Google-Smtp-Source: AGHT+IHjrEflT7QkveiACsrNZZlggSGNB2s6/3h0lASWTfvZOXb0je20GxWRUnjZ5D+Xc5ekfo7iMg==
X-Received: by 2002:a05:620a:24c8:b0:7b1:56f0:e09f with SMTP id af79cd13be357-7be632898c9mr2729938885a.54.1737371323433;
        Mon, 20 Jan 2025 03:08:43 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147591bsm433649385a.4.2025.01.20.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:08:42 -0800 (PST)
Date: Mon, 20 Jan 2025 06:08:42 -0500
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
Message-ID: <678e2eba905a0_19c7372943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-4-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-4-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 4/9] tun: Decouple vnet from tun_struct
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
> Decouple vnet-related functions from tun_struct so that we can reuse
> them for tap in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

