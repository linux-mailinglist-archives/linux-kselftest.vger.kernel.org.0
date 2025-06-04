Return-Path: <linux-kselftest+bounces-34300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA02ACDF8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6EB3A5A87
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA9128F51C;
	Wed,  4 Jun 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6FsGBAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331EC1E3772;
	Wed,  4 Jun 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044872; cv=none; b=k/qadl0vgdP6g/UFfkIqaddPfs58yBWvT8pL52RsjX4hSsRfQufcmMX4stWY5ML28O/cwPTT/7Kh60hFAP+auGB7iEtw/1Zstl351mWz4hkUcBnQIG8Z5Q9LSaC6wwbQEbTnBlazmLVe+chw7olQzQTggIEnkG2JxvqiMi+FXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044872; c=relaxed/simple;
	bh=0G8UU1agy40sQ15RpxFyA4fLtuPP3oXd4HA/fPjVkcc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AQ5GMjjFmK9zWxWwjyLZR/VIOBJgvkbRB1De5DMDLrc9bFqxRaRovSNtvW4Clse8XaCot6OikwoE+iXhuYmby6pMxnFHB8SG6yA2MeaZvhGXJoHD8l4BQDOCwYVy/vZKP8ShjMQneFR+O6a+DAzpw9ZEtmqDHwAllc/JXNFZ71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6FsGBAT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e447507a0so55942877b3.0;
        Wed, 04 Jun 2025 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749044870; x=1749649670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R7gIEg7vqARLNaHy6N4L9lQJXDNwAcxzooCzUhMW9A=;
        b=P6FsGBATf3Vxwgj9FVNQn2Hu3CVBhw/OYurOX3XvQXq6+pbtzRt0+8P9XhiYqDrRhd
         /IS4NDYHBTD8VW/RMZ7cFeolP0uMa5EZObYlxHr0eye4tRgfeBzdxmgoMC25sgo6pfrQ
         yfpCmdO0o/oyNNNdSJpJuExYrRWzdnZX6bjuzfy3B4rWjj0TAxM0oxE2zSiGEMTmNysr
         tKEYGcEw8IBZv2PVqAci/K6S4K5WDAbpnegxmlJKICHcXHc87sHbOKiePXs8U81HsuZc
         KpG+KGwXdAK/wD9c7omwlBO+oaSEHsHFdgsU3+bsBwruKaOCpdKTFViZfj5vs9eLsOe1
         Rw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044870; x=1749649670;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8R7gIEg7vqARLNaHy6N4L9lQJXDNwAcxzooCzUhMW9A=;
        b=hxZC24X1KI2vSwmlzQ7YqrqmUvnMWVB0re5USd0BASmSCj6rENVxjks+sUKTfgoqiA
         zLvnjl57p9InBGZsgAQK6vQThPQ6g7/uPO4vFp9LQn6o1gN9aXuXIMzyv9akwKE35pMT
         cGXXPbt3QqC52P4bPY99BeRAv0bdBzi0+i8XO6yOAghebYHfD3Tr2ILK8z/AGEsBf/gE
         stBuzDSzcjgh6a9y6pcjMZCZfvvlENhUU7fWlD/N6eK35yuzYSWG3+BhE8TU6Gq5x0eh
         x9OTBR1yuJA7nNc6tK/TTukerHzwX5/aqBuMqBXjmSkB2FlNpNhi+RLslVyYEabLqLtV
         oPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZjc0wlAnRUMAJcsojGSAZgAXMSdDLp8g96B+47AeL1ndCHvBxcidZpFF5D3xKgVDKXaKeOyMOOfzZFmzcTYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLI/Sr+J4SnOs5YX0VPmPMz4ZtVTpMfqgPRrY16M0zm9+X8rgP
	EYetH++FNIhvsz0Y44FUVxZTWG/ScjN5H5QpmEQnmdy52ioKlf7KL/MU
X-Gm-Gg: ASbGncsAdWhOYWsoPMVzCnsIRRcvHnIXILbdR837nKka/01o1p2+mXs9P6rygHnPJrC
	glPHVvA/grtvXHz7iaS/8sYbO+kQ7ZBDRSnHTxtpkzWdmjuGqWGKvSDF8m2g9n3rnDF/sv6+GOr
	C6JzUNBCL0zxR9Iknvmf2wZSXUqq5jmw+trplDManVfv0g94Wc3NK0ZoH5birqRhGUvT5VoKvjB
	Xc3UtEFXDrA/NbbTkRHI2MSEl0nseTWzVqKOIWTNthWL+IC86eoodz9RTt3Uwe4ByyzOkBZRqQ3
	PLpwJOi6sf5QXYKbAx5IdIfj5A+Ib96r/YFzqKJpXEXzi7cYzllYFHc09m+DlwrkvfxxleOQlOP
	in2G0Pb+YcQ/hwc5Ag28Qitcbh6jBZ2V8Cg==
X-Google-Smtp-Source: AGHT+IEUau4LsGJ/DOOs6BPaOxwoLLaYY0pcwIZWdPrKh8w68DnNqgeND+LnDw3IWauDala6WSz0eA==
X-Received: by 2002:a05:690c:23ca:b0:702:52af:7168 with SMTP id 00721157ae682-710d9a51bd2mr40862247b3.2.1749044869911;
        Wed, 04 Jun 2025 06:47:49 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad00dafsm30287197b3.113.2025.06.04.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:47:49 -0700 (PDT)
Date: Wed, 04 Jun 2025 09:47:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <68404e84d0f58_1e99f529441@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250604001653.853008-1-kuba@kernel.org>
References: <20250604001653.853008-1-kuba@kernel.org>
Subject: Re: [PATCH net v2] selftests: drv-net: add configs for the TSO test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add missing config options for the tso.py test, specifically
> to make sure the kernel is built with vxlan and gre tunnels.
> 
> I noticed this while adding a TSO-capable device QEMU to the CI.
> Previously we only run virtio tests and it doesn't report LSO
> stats on the QEMU we have.
> 
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

I wonder if we'll slowly recreate tools/testing/selftests/net/config.
An ugly hack, but maybe let the Makefile just copy that config here?
Or append it.

