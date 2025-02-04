Return-Path: <linux-kselftest+bounces-25655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C3A26F67
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597371887617
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23120AF69;
	Tue,  4 Feb 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqLPdWsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C183209668
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665629; cv=none; b=aVb6Hk60CFqMwyXkB54p1lMoEdTacHOzZMswBu/vX0vQFebhg8SRk1DF5rSA0sfs1MCyigf9TYvEFMBKZUQ8EPsTIKWNGW8qiiTj0EmTSIMW6o14zd45qil+MNoBzaGZPagIv9SxDoCjiWVd6W86CqI0CUsE83rKUCp7v8+rlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665629; c=relaxed/simple;
	bh=172cUWlhoQgNf/Z9lM1RjxC+OqlWmgKCVShfli6QUsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTgFUwcrSfdHHxYfI07HC9iTWzWNz/gnC7PacSyF31hhtjWJncUE7TU+uNYfa5P3qIBVlBv4PG1RKXTOxvhKhp3SUdAR8omwmI5U0+JT7ggeK3TnENaumCYZgjBg1lXUq1FQWq9ibG7cbPpe1/eec+80TtRft6xYoXq+CiIKLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqLPdWsf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738665626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCFgA/QhpVNocdNIuyeEH/cghaHxUWNYBCCDRrHvU7k=;
	b=NqLPdWsfK3F7oivtsfrFEnM/TwvDMsadOk+LGpRDGQXPOY6k6cUN8FpDMmdCN+MZifR79/
	RsAuAXg3QxyH0vW/WKpKTAB9ZFcAyubScTQhR2VB+xf0s5Z7zw+vgpf7EWvOlXwHugkp6X
	w45UQYLctpWLjR7YT8OimQFwiQH54TA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-NH7lrrLGO9yQHgSv6l8tqQ-1; Tue, 04 Feb 2025 05:40:24 -0500
X-MC-Unique: NH7lrrLGO9yQHgSv6l8tqQ-1
X-Mimecast-MFC-AGG-ID: NH7lrrLGO9yQHgSv6l8tqQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38c5dcb33a5so3564540f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 02:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665623; x=1739270423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCFgA/QhpVNocdNIuyeEH/cghaHxUWNYBCCDRrHvU7k=;
        b=dQ7jQpHDysVcPGnXeO5XXlPHKf+xfaslefx/xzmDKgZWJCgnbCMe3TmDjGGGaQh3Lh
         8hHkC/Tu8nvJHRi7m+NqBn4IH8VS/q39FeHe6ykR4ZiUaB+pISkMWkIXrle05Qb6Y8cd
         0cwP2I9wXl7pHCopPs/WOz0Fxg0vNvy5EcKjZERnKkBrY1bxAnMhkmSd3kxlKTeK7MLQ
         XxRR9ayk1fx9Xcp5rQ0vHhDX+NrbpNJQysfgyU7F1J4VzTCSbUn/VkqSeGCYZEWW5a+m
         RN5c8mdnWpQT2H5gyAZwANIDYXlXKMQzDPWhM2ZU7HxTivEhidmBoP9p+4Cq8JjlEhHg
         X4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU7UsLL6CHnBQTJWYyAIFifY+qer9tTRfsaY1jaTwQMLHWR2GAUEIrjsyLFCRBQx+lWgcplx2yXsEHXHZDry6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3fJdWgzesTt2L6qiK/g39MHXWuS0WYobL3ov5306Yd8Hg9BC
	PMBtpwUe0G19rFhB1Ofqf00pPVskBugFqG9N/+ulwERNBNk+PJu7qsEttL+GqudSb8NIfehGpmW
	1yFXDrvIb04nEFCaOW8pPqcvobvWU+6RG7Y4dcVKZeEp3IdnQeG7Ck134VMEhCVsGCQ==
X-Gm-Gg: ASbGncvWy7pXPurZ8OWb17E9VYOK/X2Jtkat4v9LTg2iNL0j/wrrj+/yrRxnLtvh4ya
	3JYDU4+x7F9VK9B/tfUKTPRkgsvCUp2ZEAuHCy+UD1kvrC+6RfqOiuU6BxMTFqeq3/MD7yIRAff
	4nH1Uc7Bsbf3x9jg1DojFXfdWPue/M2kwmcIZKodeYOT2lgAvLGHrvKaeeUnkd+T8bkg8eLJejx
	DcMMu3K/IcWW+rTHEqmf583yvKZdzoaLREZyILzHjcITfD1+md0JT8tBT5a/Fl+/WF4Fu0i1q/p
	5FutC1yhVb5Jm+8sZYMsun12I5wPAfk85n8=
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id ffacd0b85a97d-38c520b0b23mr22055231f8f.54.1738665623488;
        Tue, 04 Feb 2025 02:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUEIF09zz2Q0ae7dPZVMSCm1S5VnN6t28UpOZM4XPVDSCDcccMxy8E1ydHF9KTDFcxhKre4Q==
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id ffacd0b85a97d-38c520b0b23mr22055210f8f.54.1738665623166;
        Tue, 04 Feb 2025 02:40:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f1b570sm12259835e9.1.2025.02.04.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:40:22 -0800 (PST)
Message-ID: <914e488e-af7d-4301-8be2-410db5325f14@redhat.com>
Date: Tue, 4 Feb 2025 11:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: pktgen: fix access outside of user
 given buffer in pktgen_if_write()
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-9-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203170201.1661703-9-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/3/25 6:01 PM, Peter Seiderer wrote:
> @@ -806,6 +812,9 @@ static long num_arg(const char __user *user_buffer, unsigned long maxlen,
>  		if ((c >= '0') && (c <= '9')) {
>  			*num *= 10;
>  			*num += c - '0';
> +		} else if (i == 0) {
> +			// no valid character parsed, error out

Minor nit: please don't use C99 comments, even for single line one.

> +			return -EINVAL;
>  		} else
>  			break;
>  	}
> @@ -816,6 +825,9 @@ static int strn_len(const char __user * user_buffer, unsigned int maxlen)
>  {
>  	int i;
>  
> +	if (!maxlen)
> +		return -EINVAL;

It looks like this check is not needed? strn_len() will return 0 and the
caller will read 0 bytes from the user_buffer.

> @@ -882,39 +897,45 @@ static ssize_t get_imix_entries(const char __user *buffer,
>  		pkt_dev->imix_entries[pkt_dev->n_imix_entries].weight = weight;
>  
>  		i += len;
> +		pkt_dev->n_imix_entries++;
> +
> +		if (i >= maxlen)
> +			break;
>  		if (get_user(c, &buffer[i]))
>  			return -EFAULT;
> -
>  		i++;
> -		pkt_dev->n_imix_entries++;
>  	} while (c == ' ');
>  
>  	return i;
>  }
>  
> -static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
> +static ssize_t get_labels(const char __user *buffer, int maxlen, struct pktgen_dev *pkt_dev)
>  {
>  	unsigned int n = 0;
>  	char c;
> -	ssize_t i = 0;
> -	int len;
> +	int i = 0, max, len;

Minor nit: since you are touching the variables declaration, please fix
them to respect the reverse christmas tree order.

This patch is quite large and mixes several things. I'll split out at
least the strn_len() caller fixes (possibly even the num_arg() and
hex32_arg() ones) and the refactoring in pktgen_if_write().

/P


