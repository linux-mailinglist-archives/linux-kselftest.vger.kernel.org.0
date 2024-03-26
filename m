Return-Path: <linux-kselftest+bounces-6635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E18588C6D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C31C63C5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50B13C817;
	Tue, 26 Mar 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXEdNyE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B013C811;
	Tue, 26 Mar 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466780; cv=none; b=IYAhbJHSESRACGTzKNTTwmmkUs/+3EuMGD6dUAlXufgBjb/uy+gvnUv98zhLwM+Uetfls1zeC+RqCmN8PLW4wKv7nmYh9b3+O/1o7zsIiC3Uaonr4YcEGrrG2Z+UDXeLsqrLuNuA09hLnsYhWnEEBB9iz48bSR6cuc1IOmfS07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466780; c=relaxed/simple;
	bh=Ckyz2twrRXnR56ExtjrDRSyLO9aIY4Qub5CXIkSRb4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpmd1PzxQYX1bgrPLOXVgIZePWNwdZSBSpm6SKPW+CoUaD+Z6HsZb46smNlMD1U862HBqDXyKpKD/dY0kZVREJf0UIOWOsXrCuRG7Q6oDfoyHmc3jHiwkKOI7DYg0hGaqwetypMHEN16YfwymJtgBSm9/9ra92ZbuzvgLyO7RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXEdNyE3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148c95db1fso8615905e9.0;
        Tue, 26 Mar 2024 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711466777; x=1712071577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2YycBjyTiUOiiryo3u4Ap4HtYfv06gB/UF8S8KNM14=;
        b=ZXEdNyE33x7Duw5aQZ4NvfPrKm9SnfX/3ljYWjUBPjFOzcq2nGPdOHNuOui2vtU1k7
         TMZXRmLFg9qmCFNlLMA4qd+u9x9SH/89OAMyw1XQFCEVWK9k3iE9CwEI2m0nQFHgL51Q
         QwdSbgyEmnUBKmUimdkJgFu5swhVAk3ZyAaPkramul/KYXOWc8xMJAqkBD7haEXwjQey
         2/ho710D9XJdJ6R09A4fKBI/KxzXTUqCFYEZHssvJhNC8EFTO3N1W/d13bkqFuZyk1aJ
         lmjeZWK9j57nFVZkECM2fNoqzYOAphWIntcrOFOqEJDpeAkkCUFdKDaIMa2PLZ7dmztI
         g+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466777; x=1712071577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2YycBjyTiUOiiryo3u4Ap4HtYfv06gB/UF8S8KNM14=;
        b=Xl6Q0Pz9g/w7jr9fKCT5C4eM+SD7cs0H6kST2FZEypNx0aRlFBBUYRXpKwWeZ+8JfD
         yyERX05ker7CtUTmiKDFp+QULiwsmIylJGDqxRqTrdJTG7wOwQu+zrQTmgkJjTvwt0ok
         cj/w/KYPNoCCF0hY0jx2MQRxG6RH/j0Fbs8MD2xUO5RLAg4tTyebJHZeUcPt/YVP14l8
         lykbXxfg4s9txDsboGVoR7vcVSR6E0SQPGDGNPKdkQgY9IIQrm2rb0+jnzojlooM4sSq
         QJsLm2f7xGfCDD4OC2a9baxd2WGqgqcq2GdyBWcAJTc8tA7hrlhpPIvMQI7s9cPkS7jY
         QwDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBepCf9HdhO7vMngSKo70ZMDCU1u7V7URGoDSoeA3+ULbY0eA1H83a90IhLH0RYwBUyRtro+J30ECoDtFNoPagc+YgyLQ338HUbTpzOO+BScbIUltoqbX2WA9Sub0Yye2TTTiSm2PXPQ+bsZvkHHUAfZ6qczZfHcOCLNLZg1+kG7Yt+H1Y
X-Gm-Message-State: AOJu0Yyoypf/gxnvhnph++T9Ws3/cCZfvMWwHhafA5CHedaG5ZR4JDI5
	K+K5pUvSgXowuWY2d5p7LORYt9+AF6uCxVLByaVG8LTIJrJMB6rj
X-Google-Smtp-Source: AGHT+IHOvCb+DGe+wLPUVCmCDf0lWdqpnTiJwFZXG5xl9gecCid0Gu3et/U9D4goT8WZ4DQavsPOKA==
X-Received: by 2002:a05:600c:2293:b0:414:835:6ed2 with SMTP id 19-20020a05600c229300b0041408356ed2mr7286605wmf.35.1711466777187;
        Tue, 26 Mar 2024 08:26:17 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b004146bce65f4sm11791362wmq.13.2024.03.26.08.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:26:17 -0700 (PDT)
Message-ID: <b9b20257-74c5-4d77-88ab-99dfde1f4d7b@gmail.com>
Date: Tue, 26 Mar 2024 16:26:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
 <6602e56d7a02c_1408f429432@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6602e56d7a02c_1408f429432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:> One issue: if the do this move in net/next, then a later fix that
> relies on it cannot be backporter to older stable kernels.
> 

I understand. I can either add a first commit to this series which fixes
the bug by checking ->flush and ->flush_id in udp_gro_receive_segment,
or directly fix the bug in the 4th commit of this series in addition to
the optimization - which can be backported as a whole.

What do you think?

