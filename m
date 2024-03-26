Return-Path: <linux-kselftest+bounces-6625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAD88C4BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBA11C61577
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F6D12D1F5;
	Tue, 26 Mar 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foXo01lS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F057641B;
	Tue, 26 Mar 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462192; cv=none; b=C9ElihkB5nEIHFk/TosQABbh0/QL/ehLDoQSTqXUR7KzgMmX2a5xDWVgt6BXZrUDADLU9wVcWpira0hIIrglatl1s00T4ZmkyMf+g2eBFhIZzIzlYJu6QvXTTathCs+OKC08mXrOHqkaXg8GUj1GyaFhJXVSp3iOfDst/WTJpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462192; c=relaxed/simple;
	bh=q8UnXfSeM5UVwmqgM/TReDYUEzDHA5y4BulPyK+wuG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eyD3Yv5sGLPsohGAf5Xp2ypc0b8yDsq1YOBNbq3uvwnImiyJo+Ywl2vFjgLjJHC8shelF3LjtgZD5QZ9U9K5mt/mYo30li/Vu+TZeW2PcIjTriDK4832VigLTDew0nkbqXNp8aTjRMW+tE8/vfZXyIJ3rilGhqdnfrcos6N369w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foXo01lS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41490e42c74so1623855e9.1;
        Tue, 26 Mar 2024 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711462189; x=1712066989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8UnXfSeM5UVwmqgM/TReDYUEzDHA5y4BulPyK+wuG0=;
        b=foXo01lSD0Z74P68Ei4WXpHlPCN2xLTDq3h8IfGutL+jfF0VszhMoyUpymDHOW6Ubu
         hRk6Q3ed0nVdi8RKGLRxOPUJlTMAgcVynPfWcURMMEUEJE5Lfm51F9bPzVdbvHbPBYpp
         +HInyPvGGU2i7hRcQBJQDzmAK/2pBpI6UjgN6M9QCuQ844IEca7lsnYK0D4hyw/I8X2w
         UKEZoCT5FlTAoZp7AqM+mwIaXo6OQqCx/CpkjRq8a/YjvcvujwtC8Dn/KATc4NHhqquz
         dmUXb912XurknWBLsT/+8D6+h6c3ekBUch+Y57zzvhYsKGD4QxCgWfrfFg6BHg7QUGMG
         +T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462189; x=1712066989;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8UnXfSeM5UVwmqgM/TReDYUEzDHA5y4BulPyK+wuG0=;
        b=en/7QRcIoEVJEe5QY/ryhRaTT+YqQn4ZD7BSEkrqWcaToF1oXxhg47ArKufIBogtla
         F/KivqtZNHM4U/BvhXH8Le8q//ttJ8J1NzufLnSr1SpXuzbekgYzds6pXSkUQSjQES/I
         bHkl5fT40bngKWbcMaO/uUiC6JsiKX/h0F/sVxRkuL+Nn+6zTa6tN5TSYuf3YEvIrdBe
         JHnWrYVCAOmyqsIyAKl2eqDaU/MpPnDkAtrKU+Wk/bcR3g5dT/4HvDyIVFysjWW3YPaI
         2hv2S1PPAQg2kWhG73X2G6CDNWhTh9rn2c4h3bFlcmAVjXVNM/yG8/hv3zF/4V9kRUJI
         zw9w==
X-Forwarded-Encrypted: i=1; AJvYcCXV8Fn9awoVBvNpQt0N229YUpRfzecWH39gyBSeCBId11lf9s8DZWSxx1jX6Wpyospnwha8d/MCYf2eM+b4k4FZyXqfuz1T8PHXFLmhmgemHbZd3QWEWWnniiFwUQIK4qkj4ZSrJr21yYhCpeZJbL5KclzG4i3XfNMf/EPxXPMI0Z0Zv3H5
X-Gm-Message-State: AOJu0Yx9x3mZ/laT4iILFIRQ3gGiURt20taPGAL23FFMAiD619+q4irr
	lZ7Sx9LVUyhvlme1JwfVuSMbjUi8xDJEmLvaUXk+qSEfB89F1S5A
X-Google-Smtp-Source: AGHT+IFlBQtNPV9GdJ6LTZiznVIgb+47RYLTK8nn5fmx1xecoWVMyIeFPcKV2ouXDFh5PrX7p/uNvQ==
X-Received: by 2002:a05:600c:510d:b0:414:7bf0:973f with SMTP id o13-20020a05600c510d00b004147bf0973fmr1483318wms.9.1711462189436;
        Tue, 26 Mar 2024 07:09:49 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c445000b0041490a83f8fsm820290wmn.31.2024.03.26.07.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:09:49 -0700 (PDT)
Message-ID: <5ecf0c85-5435-4371-8201-6a5a322298e3@gmail.com>
Date: Tue, 26 Mar 2024 15:09:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <6601c830c1daa_11c6072943b@willemb.c.googlers.com.notmuch>
 <494e8cac-e87a-4bc4-8a77-1801a703fd86@gmail.com>
 <6602d05046526_13d9ab29498@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6602d05046526_13d9ab29498@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> My main concern is moving this code to tcp_offload.c, if it likely
> soon will be moved elsewhere again.

Got it. I'll move these functions to gro.c and post a v5 with Jakub's
requests as well.

