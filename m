Return-Path: <linux-kselftest+bounces-3503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303C83B66E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC2E1C23355
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AEA3D;
	Thu, 25 Jan 2024 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giMitBrp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DF7E1;
	Thu, 25 Jan 2024 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145283; cv=none; b=rO9ZCl/JkckeHZqssS3f0lwyjjNPd/teO6RvZX/hi7mAtIrV2ENc5hs9xTAuHpXmiLt01LOL4WUfDWoLXh30kxJTr5RaIVke1D+q7febatcuyjIlp5olD5on+NgRj8xxyO70GAcBQx69imq0zkXl7he+ii31b0oWHbZeOGDy3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145283; c=relaxed/simple;
	bh=4eJDk7SCyhBAWsspn3WX2rYSinm3641zxcsUTAczkr4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KDKfBHq8kAnIXJla6T4knsUeCMPJNaNaZTKvrFzqCK7iQ1klCyLFO4xIS38oVXck+Z7RDP/HgdlXESL/6KQ/0XRdWZJMn3Wgd05MowokIV5tILmgP34eWRKnJk3QFU/znl2AkvVKxRIgiZDEmkUF5XCwPhXf3SP5Es8CnRKIWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giMitBrp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783293278adso484239485a.3;
        Wed, 24 Jan 2024 17:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706145281; x=1706750081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEEoV1vBb0TIK2qwBs8KyfYWP/kHbN2hQHqURDl2Ve8=;
        b=giMitBrp4/L066jHbINcRWAdfDIqAKeqQkMy0B/8GwS7Jxl+iczVRxW32Y5EqIMXJj
         KKg07olJsQZiel9jVYKa5twudxAHV9f3iWmHiEwzEJrfJC/4vaCCbixeAAislPvBPgvI
         gXuf8kiYD47PgG+Jyk5khegkH5jlsgMX/adBQnfrfB2OcUPCxbB1e6Zyk9S7BumpxHpi
         +N+KZOY1Uy7o188WSY5/otq/XN2zY0Vb7UYSqZ80yOiPOBldYNiZTN2onjNvyA5kT5fm
         2+3iZlLYAdkInyr+lfJKb53Zz09bV3Z6R7XQqT9yU1JaqjWkBr4QNuBqLXB2KmcRbLAr
         ehOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706145281; x=1706750081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEEoV1vBb0TIK2qwBs8KyfYWP/kHbN2hQHqURDl2Ve8=;
        b=WMs0p2CqL4todYcNpNtx27ixsfjBtEqy7/ggWmVW+EyzdBY5oJApGrFaOzsdkRgXdT
         31JP5XvmHrftNtnq9a0cGEmlXBNS4M09ZrJfaPl5Z8lH78En9tsEVk4hAa6ZdF0BlPcv
         dGO61Cz6vjH7hPEFmD/Azo+DjH6d6K6wwBGttrNozOyiRylj/fx14QBtVKlXAv/420NZ
         vVd7KYbtPe9v5dV/6Qs/t10yzZCbrYvguXG5YaP+mCUhArjbVy9azCUO9pIza4u8NEs1
         u4Cb68uK3Pmw8lY/tW069izr/D45jcP42CjmOXxY3CE+qWClwYrALkQsDGSVkqABrg6O
         gCiw==
X-Gm-Message-State: AOJu0Yyn5p1VKTQVWNNHaVa2fHksnWzCDGbxQYNgtvo4XlpcR/h13WV7
	QtutnJ8UsNdIjbn5fc3FR5x2uId997HbL6RSQJGk+U6+XVy7Wp8t
X-Google-Smtp-Source: AGHT+IE91R3HP6pxlPwZbdz2PFmfKwP6xuMZE0pgA7VFdNMjKkrV/6imuKfNuaVwanfDRJ96AMoyQA==
X-Received: by 2002:a05:620a:b01:b0:783:afd1:3e71 with SMTP id t1-20020a05620a0b0100b00783afd13e71mr340897qkg.38.1706145281157;
        Wed, 24 Jan 2024 17:14:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYndJkIn0XrLvIMs0cq075xtJEBXCojSZPxocMjqxq85HeqLYk9BEUxwQ2FVn8vnR2XBeuCCktzgAi6awKir64YTO+T81lEfInrsiW3hAJmMtEdaYsCxefy0mWFKRG+iCRjOVBYjBRtNBIztzvjOxvSl8Pqpirz0o8LTTdDAu214QMoRydJsw8Q2WlwqgjpO1FbE3zEGponHZcWjZNslTzC36JBGIh4KsGjxJWSkS0HmJWAQc2taI34JD+Wbjah4Ny6FDWs8qQPw==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a07e500b00783b74d9456sm833299qkk.9.2024.01.24.17.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:14:40 -0800 (PST)
Date: Wed, 24 Jan 2024 20:14:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Lucas Karpinski <lkarpins@redhat.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65b1b6008b6e9_250560294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <076e8758e21ff2061cc9f81640e7858df775f0a9.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
 <076e8758e21ff2061cc9f81640e7858df775f0a9.1706131762.git.pabeni@redhat.com>
Subject: Re: [PATCH net 2/3] selftests: net: included needed helper in the
 install targets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The blamed commit below introduce a dependency in some net self-tests
> towards a newly introduce helper script.
> 
> Such script is currently not included into the TEST_PROGS_EXTENDED list
> and thus is not installed, causing failure for the relevant tests when
> executed from the install dir.
> 
> Fix the issue updating the install targets.
> 
> Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

