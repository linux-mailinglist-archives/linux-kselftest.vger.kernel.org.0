Return-Path: <linux-kselftest+bounces-29020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3368A60D20
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 10:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA363B497F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E491EEA46;
	Fri, 14 Mar 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBGuYlJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5E1E5701
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944123; cv=none; b=nq7XYO5fvEu23PF9zRvp8j2Da2qU7SfYh16VbPs61L6NJWAwRhd5aFm7A3E9fxz3FYCwT1oqXJxUM2vOBqkOrGfaIN/4/OyfYz34IhGmRRhPMk7NzOUN5jKl8LIkrdXcZYsW0A94EBZGN38KsvsrxrNSSmCL7J2y/VzQsBGWVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944123; c=relaxed/simple;
	bh=WzAIVsamvsqiiRqt4lty9wTGIar3adKdVJo/UWq6ZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gssbck+IiUL4SRtpANLT2ti8bGFUx2jueO7LHnAylglOhpBO/hUrtk0qkBfqF1dKKKbvee/rND7P3rUl5CGSal47iUaYvk7WXO+dqJtMdil+EzU+PY8HJz5ZSPQd2Qw4xAXTdvevDSdMJNwfSDkXn4Eotm0IyOP8EtYOuxFU2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBGuYlJ0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390effd3e85so1602707f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741944119; x=1742548919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJrUGm+I0VeL1o2Iw4igeaLz8LtSBUgkIJ2qa7hBGGQ=;
        b=gBGuYlJ0EfCM9PahybbNye58pgBqOtls0E1P9Qo6NDpmhNiSOl5LmXdbGd34gM0QhH
         13w4WG2tEKlOp//LTRI0MePFeQ/qonZnE7zL1vuEJC6UffwBPbx1spRHQi8a5u94X0AV
         +CFahoWyNlOsQaA2wqDbKyQ6Gt+mLfWRgt8yzeDf5b/N+c+XixAcQtLkO6Nw/DNygv2K
         /XhSj97XZcXLe8/BGZKMtP+kSrLdZ/wc9DbeX6EW+STWKF5G1m28G1FATUWiU4+E9Mtu
         5xFcIuXO7G0BVdGNWEB3jNXRZreAphSAly1c97S4s92juI3+j6Et0zLBRxdYLeXIyoIo
         cu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944119; x=1742548919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJrUGm+I0VeL1o2Iw4igeaLz8LtSBUgkIJ2qa7hBGGQ=;
        b=fPJAZDIHVTOYBdyqusTXkwo8p7Y6ffgwN1EWYCZkblaNQLlTqa/j/WnstGsHFZf0IF
         m52UYqF0vO1eGV24IK2KzwxyJ73frlfK8neHjS01YvcQpndss/nNM/RhWL3BL8NNMI/x
         GQs7+ZSwXwqBBIoPYfyf1LQEsHyrxyKV5Zb1HOFSXzvHaMOGr6IFIPLl1Ap44jVqZBy1
         MQy3Q3vXhxzjFxRa1W2yjTm6rPPqrTpHHXl3QaeRoFPdF/kxoRZuOOuz33w1vJ5B4FZQ
         kmnj6C4nlCysspU5Rpn4DozvEqb706xY1/xwUIV/Jzj1M7XtQFt5061PepQb0zuYIFlC
         0YVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJthgi39B/LfIuTwpdc6Wz3KxSSmKMbr3xZijgpuEegYVzKHwWlzRB5ed4Bo4VczHlq8RUc/BX98HTM1g4A2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXJkhOreSNgtqs2GavK6HjGqP1vfogVTV1rG+Oxe1vDkM2/eu
	J9jjap82CwetaLlImLnuFMXvFSLL5FXPD8pWWGI2+Ja1H5E6hAHLezl3OOQfQF8=
X-Gm-Gg: ASbGnctapF91kqx4eQ55oBoSyTuQaV3qyR4bfdLQvjHGTdN7ICKQIPV7EGOf4r3QrBE
	ad/iQ2PaqN0ZeundsgQ4R0rtuN6FY7uoG3ecCFvo8lwWs6Ui0BxVP0lEhofLE63vIZ5pmTJcW+7
	UJrZBPO4iedcxs9MP7FmYRA9zs7piXakTyntxlY/+i+94EON2Qyvrya/ItjsxHs3i9lxY0e+dmp
	fNpNZpDZefSoPDMn5Pp7fppGQjHjvYJq5SCngUBIaR9VCkaPmX/t3q61O4K4rBSSMfaAR1rAJ4O
	PyMr4nByhlw5EI6v2eFBGZS/bvhcOsfqIcm+Y7gnDQX+52TyJg==
X-Google-Smtp-Source: AGHT+IFFPCKVtvQ6CGKlDDaxAhRZu9swSbTZM4Im7uWc3KAoJGx39LZyY5gIccrMjFgAH1WXoacnJA==
X-Received: by 2002:a5d:598c:0:b0:391:1473:336a with SMTP id ffacd0b85a97d-3971f4119f0mr1912619f8f.36.1741944118769;
        Fri, 14 Mar 2025 02:21:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb3189a0sm4996922f8f.67.2025.03.14.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:21:58 -0700 (PDT)
Date: Fri, 14 Mar 2025 12:21:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: zfigura@codeweavers.com, shuah@kernel.org, wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in
 wake_all
Message-ID: <1111e313-18b5-42c3-9e53-ba46c3826fc6@stanley.mountain>
References: <20250314071454.201697-1-suhui@nfschina.com>
 <20250314071454.201697-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071454.201697-2-suhui@nfschina.com>

On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
> When  'manual=false' and  'signaled=true', then expected value when using
> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> index 3aad311574c4..bfb6fad653d0 100644
> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -968,7 +968,7 @@ TEST(wake_all)
>  	auto_event_args.manual = false;
>  	auto_event_args.signaled = true;
>  	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> -	EXPECT_EQ(0, objs[3]);
> +	EXPECT_LE(0, objs[3]);

It's kind of weird how these macros put the constant on the left.
It returns an "fd" on success.  So this look reasonable.  It probably
won't return the zero fd so we could probably check EXPECT_LT()?

regards,
dan carpenter


