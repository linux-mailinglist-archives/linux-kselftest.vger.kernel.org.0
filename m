Return-Path: <linux-kselftest+bounces-42238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95FB9BD88
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 22:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65351BC28AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744C32857D;
	Wed, 24 Sep 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfPJE5UZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86F323F75
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745272; cv=none; b=JdEEpVzoIR/mY1AuaP45lNXZXdy/aJoB0AFOeAN9SLBGWXBA6yULfgBlRpz9rkj1adYipBoPZvyky7n+yXttkAGrJ8e9gJ+QEV2KKm/a8nxIqkbRjZ1JoBqZJX3ygLltazLxGNCWr/nJwppWCRqAX+gCIA4lXWwxjAw759zCVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745272; c=relaxed/simple;
	bh=i4tepmVLJF01K2/9GNZdWtMm6Bdzo/yVQxDSsWRN+Jg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XZgJn5pG2X+8ToFMtdWbYRPBd56CirMMhtWErPPX9cPR10GzxO0kc8jbr1wHP8N5Gvx7qpAB/Wh+XC6iTcYE3oIctAAaS61Clznzq/7FgXMCgyiExCP4wmOIfyRL2sBUNeC8HO+SBDA4EYJksb4jVqVmeygs8Fbc65Cc323L9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfPJE5UZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-791fd6bffbaso1771946d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758745269; x=1759350069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=CfPJE5UZ0/qSDB1EhduAsLKwdjWvTYSjaio8Opmyd18r/+jw0e697R+mz90h83AZjo
         SRLJtuFHbewoUXxeViJhRLmeA+NHziVTsr2ZQ+7Wai81y37sJUEvN7GRyHo2BhOHUWEs
         FgR4mBkMTUtvENcQCYI8pNQOYUjVKm3rUkK0O88URS5YzecZ9CFvMCIcuyBK9Z0F1gq1
         5MU+k2xXerYvD3rSZ6FynmeSL8vQqP4NhkIEVs/GWrsAdmxg9Pe9H7s6uTfKga9FdyTh
         CTnM3LoFed1pSb9McS94N3j8OW39LabAGRSILM9Z8c6koyJ0M3PByN20hUeq5ZhP1lB9
         P2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745269; x=1759350069;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wlEDUguwj3kgwA2J5nd0z5PycLVbQ//dyWrS4QjJvE=;
        b=Uq+Cq3kASfsaBt+pFc5EzotdH1xV/wefXpAmfXcXUQRBX9ZZEnqrrc2lwNJ/y7PnW3
         w25CbpuOcnv2s+DsMPfxbCuZWbHMqlxUZKyEQW2eXNEMyRYVM5ztOmXsjunMiJnwjTgz
         T0VN6x+4thW94vxmFZ3r6H45oJGTDC41ezq12Kw5ayHgFzstetZzBOERXPc10i0O04pl
         2TD2dEzTLnSYO7HhYrF3gV9KNjng7SMu3yZZcf08S4yAaRPP/Vc21Okrh8tfTt9Io9aT
         aDa9iiO4gXDF5OL8Hdqzj6IgVcMhJ1voacalZ5pJuDW2mANzM+iNKAPtJDGvUQ3tadR3
         JxUA==
X-Forwarded-Encrypted: i=1; AJvYcCXXOduxVq0G30Mw7GFmiVnWIJWFtAE8RX3SJyFziDnMy9RTCKoR8sym/IEj2MO+fYDIWqeHpZYUC3wKOGm2S40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMQfNl85vaKC90xUqGEMjv58hCwxjgArsoC7NF01V/2NyLY1I
	UYYIiC2CWwVn196eVxpcfsdlaRNEBmU1ynRQHoAw9+W0lS/7BZMDGO8SyWTdQw==
X-Gm-Gg: ASbGncvy8U0kULRJC76xw0MV7BHjYdt1weDW+AtE8Uclo0cJD2Lb5aVUOTVHzd5T+uU
	YzUvwHv4LqP1qol2wXyuq90y6OzpK4tGo+gR5jc2zmfIacJy2wGGnkqwmlnKw9U+b9WVYi7VdWi
	ck89+HVdXqf+f/RBN1BSShOR35HZBA7da9BkjbrtbAi8lefSEzDymp6tslofpH6udvGDdEyvXnJ
	DYOJiB56OnoiklD8rNib+ilrC5Sh/ghPIEBAH3MHL8Vt38eXm+1Jx/SKLvGAbYqpRmkRpXRAFXE
	YS5Mw2HZkg/0Xv4HXm2ucRtyVm/frUJccPoynUh9Ez3kCwaO6TQx+fleW5gEROBrGm0/Vd0Y0KF
	bjicTKpM9n9+Dqdrcxnqr7hu5BYNQhEMQyFGwG+OWusxy4cT4miCsWY0yhfYh9bY/17yHJ41czf
	LDdqAW
X-Google-Smtp-Source: AGHT+IFibZxWZirLt9Olg9HUXAjXOqN7fGVG5ACXJFneXFmMLHtLcJNCl/n29OHLI2egwWYfcrXagw==
X-Received: by 2002:a05:6214:5295:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-7fc443d9de1mr18600436d6.63.1758745268685;
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-800fa5f6dd7sm733946d6.0.2025.09.24.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:21:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:21:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wake Liu <wakel@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, 
 Wake Liu <wakel@google.com>
Message-ID: <willemdebruijn.kernel.2b5618e3b2d34@gmail.com>
In-Reply-To: <20250924044142.540162-1-wakel@google.com>
References: <20250924044142.540162-1-wakel@google.com>
Subject: Re: [PATCH] Net: psock_tpacket: Fix null argument warning in walk_tx
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net-next]

Wake Liu wrote:
> The sendto() call in walk_tx() was passing NULL as the buffer argument,
> which can trigger a -Wnonnull warning with some compilers.
> 
> Although the size is 0 and no data is actually sent, passing a null
> pointer is technically incorrect.
> 
> This commit changes NULL to an empty string literal ("") to satisfy the
> non-null argument requirement and fix the compiler warning.

Which library defines this argument as nonnull?

I'm not aware of this restriction in the POSIX standard.
This pattern is quite common.

> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  tools/testing/selftests/net/psock_tpacket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
> index 221270cee3ea..0c24adbb292e 100644
> --- a/tools/testing/selftests/net/psock_tpacket.c
> +++ b/tools/testing/selftests/net/psock_tpacket.c
> @@ -470,7 +470,7 @@ static void walk_tx(int sock, struct ring *ring)
>  
>  	bug_on(total_packets != 0);
>  
> -	ret = sendto(sock, NULL, 0, 0, NULL, 0);
> +	ret = sendto(sock, "", 0, 0, NULL, 0);
>  	if (ret == -1) {
>  		perror("sendto");
>  		exit(1);
> -- 
> 2.51.0.534.gc79095c0ca-goog
> 



