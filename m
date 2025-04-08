Return-Path: <linux-kselftest+bounces-30367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD7A8133A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FDE8A0880
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873822D4FF;
	Tue,  8 Apr 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/1JgHNx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36439191F79;
	Tue,  8 Apr 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131977; cv=none; b=TxrbAbRfgMi0ikMsxheqnc/JrCTBIA/EYFFGntGHAVJ17mUDoyOnN6GVysYlwMoU+l2zWz10dmQTAX2vcISysSloNG5au8F9NJ9uF+eJWWV1YF10AOfXJSM4fewxMBHIf6MJttkVSnJ2s4HsMdoN3XoPKjFrbZyO8yjNcwDTEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131977; c=relaxed/simple;
	bh=yg8Q+fEiwdUlvQz508ND+obDpVahFI5i6bIssELHUWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GX2S3IwnkmJCSosRb9BrSKD7avw+/FUQxe1gsBsQiqw1qmEJ7noxhe2TTT6ynKLD8zRum0g9pK9ORyErz58L0db0Opgq95fCzat2V1kO6dXEDW7C4X5Ba4ImTzGH7wB+EoYijmeAi46DTjnyRbTB5rEpC80Z8cO82zFIPDYh258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/1JgHNx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so5003773f8f.1;
        Tue, 08 Apr 2025 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744131974; x=1744736774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVSW1j9sW9KcetgerHbKmVEbcFODFc+WKhghSHuNKnA=;
        b=L/1JgHNxN+AG0GJY/If+024P7B68PU1XQq0qeyhg0ttP6uu5/v0vImS+jmRycK+iao
         VSC4SK21AS7GSo0J30LEdPZB9VvqERdnhmJs745QG8XOZbMgtgTBts/8HlPyqEGZQj7+
         PDLZMA8bQ9uzZE4YhzA1Q0pIBGqwv8GU0S7N9UuR0zyLeB04ZFgWWfqjsUXktDrjhF+M
         OPhDn6kRyEAj2TaP/4y4ggyq4pume/zQBymExgS4lJZfA3xwL+01yaD33+uMo7QsPc3m
         2NmbgUrxNfC/aNtg+8d2mzcdDYNL2W0P8Gvu6gdC7IQI6N/3WJWGeqKbCmS1FrXw/LQp
         hGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131974; x=1744736774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVSW1j9sW9KcetgerHbKmVEbcFODFc+WKhghSHuNKnA=;
        b=iBMqRakFsML2E1eriw5y/B+z5raPayxR9NXaje/xClh0u7dPPMtSqq8JJRBrQDopO2
         9zn2z37HQ7CZUG0/11SHr6Fk5X3jYO0FYZa9sqY2+Xt4LwAV9hflqauSGllMWyRvzIzV
         s+9K0kg1inqbwc6hJC50WKMnX5abnmVX3yUmUUjOmxqK9QzNy1i8Hd0DVFcUvz4QvsIx
         OYi5RL5OT6lM29ky65u9x+71Q5uSISztY0h9N9AVjANCozhngnZ8gd9oHd0bzqy/5i12
         93c8p4Kn+fzuTm7Pu0Uk3RvLrkYsKDbPq7enJ25tY49ghJPPPPXcDMwN+BqDouWybRIt
         PxzA==
X-Forwarded-Encrypted: i=1; AJvYcCXbFoHBMpR9JgM+YfxM/lCzAX7ZnA+wRTFRANvEEtp1gLC/sKXLtplm1zNihWEsZ7BCT41xCpr2PoCSbFbbDgM=@vger.kernel.org, AJvYcCXtOZt6q3oZf7yd701/KrGFe7/LYIrAaFxoXAXJuY3lXsI0HfHUhkCE14e4MPm21xk1zYNpMN+t@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fMRXwvJCxW527adls21S4vSfQPgU9oG3E/8ksZrA8srZfxov
	wvOzA1wBZqbYqZ35tyWworJGDj8a07WmLM9uPdyYPCRX7DmG5arXXbKWfQ==
X-Gm-Gg: ASbGncvCXUkgtRY7CfJ7ctc3gJbld3pkRNvJKP2JKPhExJp4SL440ExOPFYWSIO3Web
	lis+u14B4TL0bBi5c9XD34QOwuKUqm29wSzawuPnMlv6ZVQHMFkmtfvL8ZPub5s4XXhvws3nZI7
	Qq5QhtuMQFACVQIQ6GQKPYlQhTjZYDS9WLzlkNz0f2hF3WMbu0Rai7TxUchrwVLmz/UHZIAGusL
	jNoGAlDEjqixhWiyFqaiAzvAHNI6M/aJw0fih0QM3AbL+vCmADFuIzWjG8QaDLbOVXN0CzZbNA0
	VVhPhyNxiJ0cawS1vBJJ+HOy88meUoqE1rexd5AHmWxJcqiQH+hYJ0+iLDzs0zyx
X-Google-Smtp-Source: AGHT+IHIATDhMUQX/Pg95o2L3J7jOrSGkWtrg9ahAB0g3lLYbWvYXwbyI8C5zr/IZSnKeRXWF65znw==
X-Received: by 2002:a05:6000:178b:b0:39c:2678:302e with SMTP id ffacd0b85a97d-39cba98288fmr15120629f8f.45.1744131974074;
        Tue, 08 Apr 2025 10:06:14 -0700 (PDT)
Received: from [172.27.62.62] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d943sm15664627f8f.74.2025.04.08.10.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 10:06:13 -0700 (PDT)
Message-ID: <bdd16b2e-13eb-46de-99bf-68a500c960c0@gmail.com>
Date: Tue, 8 Apr 2025 20:06:08 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net/mlx5: Avoid using xso.real_dev
 unnecessarily
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ayush Sawal <ayush.sawal@chelsio.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Louis Peens <louis.peens@corigine.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-kselftest@vger.kernel.org
References: <20250407133542.2668491-1-cratiu@nvidia.com>
 <20250407133542.2668491-2-cratiu@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250407133542.2668491-2-cratiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2025 16:35, Cosmin Ratiu wrote:
> xso.real_dev is the active device of an offloaded xfrm state and is
> managed by bonding. As such, it's subject to change when states are
> migrated to a new device. Using it in places other than
> offloading/unoffloading the states is risky.
> 
> This commit saves the device into the driver-specific struct
> mlx5e_ipsec_sa_entry and switches mlx5e_ipsec_init_macs() and
> mlx5e_ipsec_netevent_event() to make use of it.
> 
> Additionally, mlx5e_xfrm_update_stats() used xso.real_dev to validate
> that correct net locks are held. But in a bonding config, the net of the
> master device is the same as the underlying devices, and the net is
> already a local var, so use that instead.
> 
> The only remaining references to xso.real_dev are now in the
> .xdo_dev_state_add() / .xdo_dev_state_delete() path.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

