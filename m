Return-Path: <linux-kselftest+bounces-18609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E738B989F92
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8944280FA2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF518B472;
	Mon, 30 Sep 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGL8qN5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127417C9AC;
	Mon, 30 Sep 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692776; cv=none; b=h4EzW+wT0FsGmKLFVNFmKd2gLPdN+G5V0U38ue/fl9jytg4/hlIFAT1bMupTus/Sno75Ix5UwCOoHX+LGBXisDB0jcv9OSTbie653hDZRrOm18pNyfrM1YJkzUVEB3RfXbL2Mk7av5jHoARukHUN6TORK+0QSLEa5rVg+hJP/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692776; c=relaxed/simple;
	bh=iRE6qd+fPTj6qWD0TUuyXKQ+8vLttCtCxVLEAHwXftc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WOgcWeY7YcY32GdC7BCtrPPLorICiaDaFgTyk3mpwCzGcH852bI1Pd8vXbihi4wTt5L7G8CgurHc0QWZmnzxybfv5+jnSHORpK5fjbQGeV4K49ZzVW4ouQCeXrr0VYQiZAK6khCPQ1SFDIEXMoVXuCmyU0hiM1rwcF/K1WlIudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGL8qN5o; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb2a6d3144so20034956d6.2;
        Mon, 30 Sep 2024 03:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727692774; x=1728297574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIKXBj+zmQGtAA4ABQHpEplBfgquw+jn9zoWrzbR2J0=;
        b=jGL8qN5oNAiPBVUwgQsNQ8GOlwLMlLl+jlb/Q0OdCIndmqK77VmPcTEmW2AZpBUf54
         was1FwuGvqKHxFzrTvzad7zzjjAJ5ID6mpmFLKc8dB62yf9l4Pw71jPJ5ivPzJprsVF+
         YlgS3Izca0lMixELzobE8RXIJ4SfCItlDn+94KlXNsjhRGwkvxqYTznWn3UfSq+hC+ci
         f/gWPYDqcZs0Q8ScxWwpUdw+qiv2+/sVTvuSgu/tpKix45rR311cQvJwnyXYjuJO7aV0
         9ivtrbWdHJHh13oH4npk/pYgDINeax+BWSw/+iJhKYaodLlVvuNAHGxzzo2CTBBQfUs6
         Y6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692774; x=1728297574;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIKXBj+zmQGtAA4ABQHpEplBfgquw+jn9zoWrzbR2J0=;
        b=qZWxsiI9eW2EqV4jIde2Nrki38qnrqI7MeKTrG+Nt8dVuxqsHogrX7XxwYmFpcRrf5
         LLjpo+RRRyy0UZ54I+TW65r1E7zTJbf9n+AHeTkuoRf7GmluVCoKhcfDv+vOrr8w+Eor
         9C7uS4hkDCZrpSA+QW3FRR/ST4Q5WVsmLjzDUh4Ey55gFioML5TPEC6oa95sctkpu9aP
         Bkh7QAtlnsWEr2bUd0bPfecjHegA49dK9qa65dHPqp1zapB6Ja0CTEKu1jmdvbQNfOpH
         dyfk9AnEftYhwOv7CBdMGLd4udpD5PBtHwXdVq/JE9mFutnxWbaaU/zt8mWM8aRFVowm
         jPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSTA2as9Z/O+nVoFfrcw2JolRT6fHyQh2EKzViwLIjqzmdNYYyXVT72aih18ND8Y4l6qaQ26I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aTgT1sIjAx+F7XFXwHYiGsGyjAfFcbV8mE0GiSIUwb7U45Kb
	eeTA620xCy7ZFYMnVxah6IRAW05TaCJiwIgOSEjwaJFcvQYcsI/c
X-Google-Smtp-Source: AGHT+IGIrhHFU0jl+/miYQWHPcogrK23ormkwaesiN9Ns0f4C+kwOUgVy25OaVFkC0C1bHN83Cx7bQ==
X-Received: by 2002:a05:6214:5549:b0:6cb:2ab7:56df with SMTP id 6a1803df08f44-6cb3b64deccmr161694126d6.49.1727692773727;
        Mon, 30 Sep 2024 03:39:33 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6320f9sm38733326d6.73.2024.09.30.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:39:32 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:39:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 willemb@google.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930092416.80830-2-kerneljasonxing@gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Even though this case is unlikely to happen, we have to avoid such
> a case occurring at an earlier point: the sk_rmem_alloc could get
> increased because of inserting more and more skbs into the errqueue
> when calling __skb_complete_tx_timestamp(). This bad case would stop
> the socket transmitting soon.

It is up to the application to read from the error queue frequently
enough and/or increase SO_RCVBUF.
 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/sock.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fe87f9bd8f16..4bddd6f62e4f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int optname,
>  	if (val & ~SOF_TIMESTAMPING_MASK)
>  		return -EINVAL;
>  
> +	if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> +	    !(val & SOF_TIMESTAMPING_SOFTWARE))
> +		return -EINVAL;
> +

This breaks hardware timestamping

>  	if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
>  	    !(val & SOF_TIMESTAMPING_OPT_ID))
>  		return -EINVAL;
> -- 
> 2.37.3
> 



