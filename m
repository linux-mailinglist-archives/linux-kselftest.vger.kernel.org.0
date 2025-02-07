Return-Path: <linux-kselftest+bounces-26030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B606A2CC98
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9700C3AACBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1C1A314F;
	Fri,  7 Feb 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Cwtw9/D+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EB1990AB
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956551; cv=none; b=ZWazJf1AAWSpBfIL9SrP/jPRHPJET3FGIwE+fm8nuTgmKuKnTXH2TutMxqaTDuCPKSLLB3RwG9ejp2zTw/mdB7W+teqljDt4/Du9yaWQeuIx3feeOUvJslPtc04F0l7uR/AI/BNDfrzWFpYtnF1+Q7BdtQX04MGykhK9oFTTnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956551; c=relaxed/simple;
	bh=jGP5mFG9d1VkQT0Qx6S6OeAgqKqg5Do51TXFE7eo7e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZWpFnALngq6b034+DdCOiSP+kkSpqTa0T4dpkL6D2wiZkox5b26mlrPziXlp9QV6RKHyq+nd2b/GHicqej+WEoRnV/p29T/HIQi/Mj+++pjvZAgUC/Fk+I+eee+BbeupZCldISbTzrz5OR4JbyvvO2BvK5PQANBeNXJddZNkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Cwtw9/D+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f44e7eae4so34024195ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738956549; x=1739561349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1AbH5V70bHGz7mIe4cxxe7yGnWNMvz7BnJGz16vITI=;
        b=Cwtw9/D+w/rnBQal57ecAK9q2aYbRDWLtVvwHNrMbC0VaxL0+/iO4khqIOhbyiYji2
         Nxj57vrTZHGXLfDwxHwusa7aw+cL80soL/sgGqQd9sXqt/8ZFRU/KOs7mvTcheHGtOdf
         CNK+C7sQAhd9BirQFlFdfPQzconAshtH0oxW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956549; x=1739561349;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1AbH5V70bHGz7mIe4cxxe7yGnWNMvz7BnJGz16vITI=;
        b=HmAbCUeLERsMQsVDdY4Fs+NUiyDd3OK16BO7z9n7BBMiAtU1uSLBWiOgLwvdaNOQJL
         hKem9OPY2ihateSlIFuheShFBz0srYKPnGNSV3Dgdcvay4vbilG+lCHiZiMv+FmBHyz0
         CZwgcL0/n+i8tqN+vvERchj5oDw1U9CTelTEDT1Kerf68llFW9gTZF904Nng7Kx3Uedg
         qcAUCtVqgUSlW6aFAwbcOIGLFifqWojM6Z3RzLAbu3A2ybgsr6D+TZP8URM1XQ9et9qV
         QNPHvMclbbMupXWn0y5DJfddAESHdOWcCMkb98GgJ4pOZ1lYjED/weREOQMDDT9amBoL
         7vKw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Se18NagmfwA9/YY7DUVnt22tA4ElJP8jFsJwF/iunD//rS7971G8LqTqwL/mCg023mP7prbKw1DMNV8R3z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PVFY6eJ1YqgMQCdK8qf8Zb9Rijxi+iXG2iPkgpAtl9zluiVH
	EewgMD9YQJ2nrZtYb1SrV/i5cL0T+9TXqeMeJ5GrxRnDpXrO1Dxx+VKlEjluLJDKwvWjYlAyqmT
	i
X-Gm-Gg: ASbGncv6dGyIhvLvgY8Wtlio3BFDcID+Ew+xtUNiZe1hWW3/S2SLLeAJtIELf1R58Uw
	/m/z0nvi5ab0c7KGjJRUBeCmSsQ+SUpFrUKmAVy/aC9//K4+zbn6GZEADOy6ByGD85ZxnoXZeJJ
	f6d3kRzl5ueMj1AoOZLnG1pRbRiO1nXZxexxXi4SiCQh/Qv4Fd7UVpDa4tFzYmbg63rdOsDzNkL
	RNg+/8nrXgyzqpDsjQ4R1FMYzQK6cheIZ9GEMi6PRa5iCtWX0Tvnhie0Tzlm2bfi4hbrBsIvdGx
	ctf/Xeg0CW84Ui2Kf7oI+iYCcOYH9s81HzPZGUHvt7rRIoNbsBYMHcXYwA==
X-Google-Smtp-Source: AGHT+IGZNI13IW2GQmLhADOPb0VmGp1wsNJ3tV7vuohGReKlzYi1jCgh6LE/YHnSXl139yGF0c4pxw==
X-Received: by 2002:a05:6a21:3305:b0:1ed:753a:cfbc with SMTP id adf61e73a8af0-1ee03b4187dmr8541363637.27.1738956549412;
        Fri, 07 Feb 2025 11:29:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16292sm3505288b3a.149.2025.02.07.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:29:09 -0800 (PST)
Date: Fri, 7 Feb 2025 11:29:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] selftests: net-drv: test adding flow rule
 to invalid RSS context
Message-ID: <Z6ZfAr3RIyqGOrrP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
References: <20250206235334.1425329-1-kuba@kernel.org>
 <20250206235334.1425329-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206235334.1425329-3-kuba@kernel.org>

On Thu, Feb 06, 2025 at 03:53:29PM -0800, Jakub Kicinski wrote:
> Check that adding Rx flow steering rules pointing to an RSS
> context which does not exist is prevented.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

