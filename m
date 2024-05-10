Return-Path: <linux-kselftest+bounces-9982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270488C1C8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EFF1C20F89
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102B148831;
	Fri, 10 May 2024 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB2xuJxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD947E772;
	Fri, 10 May 2024 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309394; cv=none; b=CJfPltjyuicFE/YK/fxoWcTnEBtNDlU0YVYx5gnSbw0HTg/Zi1M0mhCflrxPcw12VdMejd0jR9WKdEscIuZ+hJgNdgP3xGMR3tKQuCmCjAUUXR5qc4Gks5arwTrZh0bm893TphURD6bHVKCv5xcgJxr7TzR8sB9pnJXwqn/LiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309394; c=relaxed/simple;
	bh=GnJC4PLvjx0VZBgDE/5mjabEdUo37zBXJrVtiGRKDEo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Af7C1ZMqziKkigqfNWz6JksWMNZi2HfeW2N59ZIX5Jit1VE0CmTDavJIW3upOiPiHXu0pGZdIX4e8JUyBxlnrYt7dKfGwrI0Dq3R5LSsHTLzu4ysc9D1Kx/zTtIHOdyPgM9YCQ8noftSuyyIYWPJxj/2qVWb0eYEbdKAI26fD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB2xuJxH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43de92e236fso10360031cf.1;
        Thu, 09 May 2024 19:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715309392; x=1715914192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3onagFLN2mYzD4EPdbnNwmEaJeqd6Bg8DZEmO6Epr8E=;
        b=JB2xuJxHe1GusfE8/nL7uhf2E/kSbVtU2CzfEiUjbAoIu7M8V6dcejeEEQYWtcHHw9
         wyyBBINaVQyt5Sm4b4qQ/khawomIYR9WPEt16MuaSDhW57q5jG1cU82++R+dMQVM5hUr
         4TrgGIHnP15HfP+D5vUFkL1DQSC/+hDNl4HMA25hq/5L67IDQS76u5dTAWe9+NBnqEWt
         OBM238NNN4GB6aBHgnD3fV7RgP5ikz75AeubNzaIqG9ZijTbiXru5hILLG063LKbygDs
         99eNTwssGllLVIl4wxWrDMcLBUtbuj77FnAhb7h4i8xEnATSLb9PhXBLxSgiZe1X4tzk
         dxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715309392; x=1715914192;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3onagFLN2mYzD4EPdbnNwmEaJeqd6Bg8DZEmO6Epr8E=;
        b=j55iO0VH8PCJdp/078A5bLWSDxls2scLMCainUgeHCTeLxmKVGW5B+XyazrD9u9e4L
         w8TLk53uM2te46iIs+pRJzPswOBcJDS8jwoWKyijypZrV9fxQzZOJ42PSlDAoZ1pDv+7
         vsePwqV43uh12qxU1KZlBLGegAOO+uPrHq6vdGr7MhabrSG0GYUrMhDpVE6yMMI0q3jL
         4b5VIvjmMMJML5tsESWiuLqGL+rkdMjbhrpmd8H36vP/QzPqhiZa2jfryYCLRTZLretB
         ZMEfOj3jMz9VUdwJTW9YA+LhQ+pkqKshg7o2hOHiKi6+WqL/wJDhitwcD+3nP7r2/B73
         xQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXF9eUazmw28xmVNrSU1qHhOQddN1gYHe7kBhZ+pN5193lw2kS+TRND1koTd8rmhrmSoO6DZrdEX63XOsCm52NnRjMuiGyBUCjXQ/xAXi1D
X-Gm-Message-State: AOJu0YzQUZkTXgyZjoYV+LvWxQQ71URWBNOCRgZp5Q1Rch7n4nQceOt9
	RTdnTLfx1tEx7pbN0krqRuWlWdRF4Ns4+MaPjBcyX5qH0+WdCjfJ
X-Google-Smtp-Source: AGHT+IEymeHKCs6FrJjR+hh5p73qZF0w4HdjaIV1karPRlmNnVUNQ3EaInpGqA3Hyn36fYZR5T7EZw==
X-Received: by 2002:ac8:58cb:0:b0:43d:d971:98a6 with SMTP id d75a77b69052e-43dfdb549f8mr14697021cf.35.1715309391786;
        Thu, 09 May 2024 19:49:51 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b5927sm15729951cf.2.2024.05.09.19.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:49:50 -0700 (PDT)
Date: Thu, 09 May 2024 22:49:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <663d8b4e19c1b_13d894294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510005705.43069-1-kuba@kernel.org>
References: <20240510005705.43069-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/2] selftests: net: fix timestamp not arriving
 in cmsg_time.sh
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
> On slow machines the SND timestamp sometimes doesn't arrive before
> we quit. The test only waits as long as the packet delay, so it's
> easy for a race condition to happen.
> 
> Double the wait but do a bit of polling, once the SND timestamp
> arrives there's no point to wait any longer.
> 
> This fixes the "TXTIME abs" failures on debug kernels, like:
> 
>    Case ICMPv4  - TXTIME abs returned '', expected 'OK'
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
> index c79e65581dc3..f25268504937 100644
> --- a/tools/testing/selftests/net/cmsg_sender.c
> +++ b/tools/testing/selftests/net/cmsg_sender.c
> @@ -333,16 +333,17 @@ static const char *cs_ts_info2str(unsigned int info)
>  	return "unknown";
>  }
>  
> -static void
> +static unsigned long
>  cs_read_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
>  {
>  	struct sock_extended_err *see;
>  	struct scm_timestamping *ts;
> +	unsigned int ts_seen = 0;

nit: mixing unsigned long and unsigned int

