Return-Path: <linux-kselftest+bounces-18111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7EE97BC81
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4DB1F255D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2209E189BA1;
	Wed, 18 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr5kJXqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6424409;
	Wed, 18 Sep 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663926; cv=none; b=BVYzeCjD2IiXCDBKaZB6rfEehxGzDXtDziVbbBI7xhNY+mkhdsUet/Fxd2USFDl03jBYyAO+fGBKJDue1sbsMReJ6N5l3CITmPkovTPOm0iw2Encgxk7MgSeTHC0j6PebiYshfDTda+RhT4v76tQAAU1ge1RS/zX8I+YCh4IvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663926; c=relaxed/simple;
	bh=5u1zOtKAM5FNnstlmq5xaC2tZPa+di5tlrGcuD7I04c=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YQ9mkIZl9PeoE0P3InA0iaUhW79vcGq4/PPytEDEZefLCSjQYOL72Pe5CJF3yyl+QmmXsk2wZTZJXrh9KsNaaHKUpfS5u16KllK8+DSNbp8X4McdPXeuUDnXNu2xMqRsAJuetqUgsfgupKn/a0pLJMaqbAIvNSthBOZFdLFg82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr5kJXqf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9b72749bcso487887185a.0;
        Wed, 18 Sep 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663923; x=1727268723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OEoAasUTTYgmGLu2/+6ETqePrAGADXX0fzkTrJ1tjQ=;
        b=dr5kJXqfHsxo+rBCmVtG8spdEK77NmnAyVzdShZO3cd80maWzZwmv8kgDkqFSSon6E
         nqdc5HuVW98z3C3EaZwAOwpfUQprqy/Xu2PQwgonQrwsa0PjNRsYJOJ2Hr2YJvPaCYPU
         3wfSKa0sGqShijc1ucCTyTKs8WbXKeSLP7o3aqDCMQdRA0wcQeeccQZAMXlJ5SZ01FMy
         eKvxk8OTuXHCvUsAOB2ifkgsxw92QAJy2ezvhEC7IdNiqMnMusY+HxE2UrvFz28Z76JL
         bCpyaeWNHhxhWFrluClxfcM4Ihv2/chNCAl2dgrTRYq1cX4eFnEVMxyeNNpODiqN1Uob
         UIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663923; x=1727268723;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OEoAasUTTYgmGLu2/+6ETqePrAGADXX0fzkTrJ1tjQ=;
        b=XoDPT4hLlOvJTwwwqJYWvX5Yv9/mV5GTLC0/WJqIcB98ItdooMFdscFgeAtNQ2OIOg
         1ORM2Np2JGfqJKUc6cMMFECud2RscJ8Iv4h40BJ1enrmO/z3PX0HHBtp0Cye4DUKNSY9
         Y0MTogeik8+u6S9mupOvd4vh1FW+UWS2HfdMccTa/wj8nzmcFxn9h/CRIZfdAbMGLYLY
         Sw+/q67YBv0iJHudMH5vfyQBeVAqXl2gnbcZ+CS4yB74g5Q+2eWb1qvI97VRRCrQc+u5
         1tgc1BPHMH9lQMKeAgbECt5+kVO7965es+LyVzhy7WRbS178OR7kIjCLsXTYO03ahTgV
         vXTg==
X-Forwarded-Encrypted: i=1; AJvYcCUqHk+86y0NakelonKOSPLXVXmmk1DKfFqXtoxuSCONqAHYTh9TAEGCPXP7+r/dSnYtOxE=@vger.kernel.org, AJvYcCVQw5lsuv97/HxA0cCx/QBBKA3+hgH8ZqxLRt/VISAsjzsZksdSvdELg3056utEu9gNk/w3SAIQ/yhS@vger.kernel.org, AJvYcCW5UvFbvN0YUvn9hVIRuMH9rYip1KSUzQbkEBs5X/AT26G8XFTZ0BmZraMYqhsUqU7ESRrFMjVi6/glHlZG@vger.kernel.org, AJvYcCWFbQAlg8ywRp9eQWSqDXpO5B2WgW4K6U6X3FC4cCgm8y7JD83YcqFGisoTvw6cqmj/upnkaOZ0@vger.kernel.org, AJvYcCXSvvc+EeoTTii5m1uf0oDJ2AI5oEpp9SSfvA8ppWFPjo6cDteLkOpDTkOMTd3tl04nZ3tOY9q8AZuGZhlCkUwA@vger.kernel.org
X-Gm-Message-State: AOJu0YycerrrttLT1tWMXzkkRzXkCl8B83ZuvsmTn6MYlI45SOXjTmfA
	c6T6UV50PaT31PPQ2aNx8h3hrRE+gCmwKXxD5pIoafmC/OvhKPur
X-Google-Smtp-Source: AGHT+IF5yR4TSO8Lu46eN/XdtU9LOZKv1dJO+CJkJkzm4gfBDjBFjafucf890TMmBj2PAFVeO31T9A==
X-Received: by 2002:a05:620a:4088:b0:7a9:a0a2:1455 with SMTP id af79cd13be357-7ab30d2528amr3669192085a.24.1726663923153;
        Wed, 18 Sep 2024 05:52:03 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e964080sm453959485a.4.2024.09.18.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:52:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:52:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66eaccf25bc47_29b986294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-4-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-4-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 4/9] tap: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> tap used to simply advance iov_iter when it needs to pad virtio header.
> This leaves the garbage in the buffer as is and prevents telling if the
> header is padded or contains some real data.
> 
> In theory, a user of tap can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tap.

This description does not describe the need for this operation.

The new extension seemingly requires these bytes to be cleared?
Please make that explicit.
 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 77574f7a3bd4..ba044302ccc6 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -813,7 +813,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  		    sizeof(vnet_hdr))
>  			return -EFAULT;
>  
> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
> +		iov_iter_zero(vnet_hdr_len - sizeof(vnet_hdr), iter);
>  	}
>  	total = vnet_hdr_len;
>  	total += skb->len;
> 
> -- 
> 2.46.0
> 



