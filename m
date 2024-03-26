Return-Path: <linux-kselftest+bounces-6637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9788C8C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012F91F81720
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39F13C9DC;
	Tue, 26 Mar 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgavmBFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2D13C9AF
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469661; cv=none; b=kS0olMkAzMXmWPX656LJZlGJgat7DhYGjxqGx0HeJCVpgzy78bkLzyZgyhxG8VLe6JriUjN/uzNZR/vMZb9HJegtvwCu64HU4yK8i+4FHp6QfLOJAJkjR+oC7zIB79TuEvvjq27uhGIH7V6DN571TOb0If3xMVgbpRhuwX696q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469661; c=relaxed/simple;
	bh=7SawbmnWI7rPJsnre2a+4vB+2de3J0Bbtlxm2lwABJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTz+wSPBaGXBQQBG6iHMORI+W12ZZ4+d537UWNoH1HQ5cx40AMZNk4ci+xLJofKdt0RDhq4hqIYWmCU3k53mXm2jzgWvpvPLyqsdF1M4dL9zpW0oEMc73jDN+4rt4XwrH0HZ3TQBwPvnxYM2Kd4luneYKb8KFd4w+EK6WWgOdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgavmBFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711469659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7SawbmnWI7rPJsnre2a+4vB+2de3J0Bbtlxm2lwABJA=;
	b=bgavmBFY4MX9cZ7ZJMWsfhJCXbypcrMmyiFYPRieQi+rqEqreXDOEO4xrAgcawec/Nnray
	wChPyxFhQwvp9BO37MbJrref5321ODwj7ELIzKn9KbQnacXn67bH37+JzM2PCLgI/GzqAR
	ZUX0t7Q50KAscAawXV4WlRcEKTLp4/M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-NN-YainkPQWqjv27Y2-dLQ-1; Tue, 26 Mar 2024 12:14:16 -0400
X-MC-Unique: NN-YainkPQWqjv27Y2-dLQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-341d0499bbdso415370f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 09:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469654; x=1712074454;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SawbmnWI7rPJsnre2a+4vB+2de3J0Bbtlxm2lwABJA=;
        b=rGHTOVLSNfvEDlZYYw5C7LMmTOwPyc+qGaNDH0nf9sh19D2fBc6t0t6+5IbeCvexRe
         +mYYYiXwgvj2Sn2VmnQ8fLne9kpCG00HvNXxDbe/hSnCJjPfp7wYQPlUV9cju7qW07vk
         DNuYCbaXuRBe0M7FPIGP0Twi5Y3GjyPpYsUzfuqD71UgC1uGRl4A8H3d0HP1bmtjirJh
         lJWKRjng1xOkbDxXQ9IYCUJosJvXHalcc3kNSpFJuaanITMC5noiOYT4/9idFsf+skGA
         hcvihK8dz0Mg2gA9gDGzsGHcqdezXYUwH9Qyrha0oDhoUNMIgTYAbzHfpVX1wHE9pXOY
         a+5A==
X-Forwarded-Encrypted: i=1; AJvYcCXE8vLQhUo8dmQbVx7b+NDML03OTYS2Stbf/r7338FfUbqz9KY47Zy9LPDr0EEPbF1AEvnydo2Yjh3lWnH2aRHmXSwrl3dh6TFfh5UOwOIy
X-Gm-Message-State: AOJu0YxnVh/VjZyQ+pdWFW7ZCCH07LZOYidzQS4ca4NAFexVGBh+zK6M
	0hzXipFJGMwt1BNbadZljK5uU9u7Ep0c5dFaAVLbY7trxLte2WYHhHchahGVPW7h0DG5I9wOmii
	BJiIFooL7CVfpuL2Nv2vgsp7FaIt1oqNKjs+cMeiZYDUrWpyWtukad+PO/6aspkg5vw==
X-Received: by 2002:a05:6000:1d8f:b0:341:cf6a:9edb with SMTP id bk15-20020a0560001d8f00b00341cf6a9edbmr5122117wrb.1.1711469654757;
        Tue, 26 Mar 2024 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjShKKyWXmkUtgp7SlwTyVgwVrWoywvcERPA7AbkHbHielkBEJwiDiyusdfK4L/qlc139cWw==
X-Received: by 2002:a05:6000:1d8f:b0:341:cf6a:9edb with SMTP id bk15-20020a0560001d8f00b00341cf6a9edbmr5122103wrb.1.1711469654383;
        Tue, 26 Mar 2024 09:14:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id bf12-20020a0560001ccc00b0033e745b8bcfsm12550390wrb.88.2024.03.26.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:14:13 -0700 (PDT)
Message-ID: <d60c6185b8394da02479100981fa3f1306d9c81f.camel@redhat.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, Eric Dumazet
	 <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 26 Mar 2024 17:14:12 +0100
In-Reply-To: <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
	 <20240325182543.87683-5-richardbgobert@gmail.com>
	 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
	 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
	 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
	 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2024-03-26 at 16:02 +0100, Richard Gobert wrote:
> This patch is meaningful by itself - removing checks against non-relevant
> packets and making the flush/flush_id checks in a single place.

I'm personally not sure this patch is a win. The code churn is
significant. I understand this is for performance's sake, but I don't
see the benefit???=20

The changelog shows that perf reports slightly lower figures for
inet_gro_receive(). That is expected, as this patch move code out of
such functio. What about inet_gro_flush()/tcp_gro_receive() where such
code is moved?

Additionally the reported deltas is within noise level according to my
personal experience with similar tests.

I think we are better off without this patch.

Paolo



