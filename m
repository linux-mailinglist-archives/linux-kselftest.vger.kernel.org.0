Return-Path: <linux-kselftest+bounces-21748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA09C3475
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 20:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F5A1C20C52
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B913B5B3;
	Sun, 10 Nov 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw9tsbhe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCA15AF6;
	Sun, 10 Nov 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731268351; cv=none; b=qD+Ou8K50WHa4u9vAzugxBQUG0g/zkBhoPsw9y/iWvHw8jnxubrWp5jjbXfTpJ+7tjHqR2inQXtL5bWcuePgxtcJnR86uPlsuW8zJP+pgK5mcAGdwp9+qoYlQaiB1CVtyM2noBrlauYlBa8oJPOCDElC4Vy6StO/7hsqdBy4CTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731268351; c=relaxed/simple;
	bh=Qn6ugCRq9iAJiGTlOvQ86KsjWexwsguL5eo8A23wSec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIlbyYsME+2BX+EWjsnB5GE9MZEK+q6x0E72gU2yzo1qJg/QV2NFhANddxHe+TsvKf2tnbtwipQfUUpdQJEfQrWAHHXjIAR6mw1Lqz7NlgT14RxfubYAg++dVTjl2QQjTmvj4XHSnwHFk7+uAKb+z6QGMwA8OYln5/BMJtMN7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw9tsbhe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d50fad249so2881915f8f.1;
        Sun, 10 Nov 2024 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731268348; x=1731873148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t19D38cHTZDSKKSN0zcjYdbOcIOVMY1UTGFX7Lm29YU=;
        b=Vw9tsbheavnuD4X4azApoupieNLZyMFj0OF8qTvhV+9u5TeojhnvCYYF0SbqiB28D1
         1QBmPFiXsNbk5Bq8DoXfPCqRupcT01Ect3EjxacvOVwOe1hgmeVvlJXD1czQUiz1YwBH
         jjcukB/ehoyyD5CyRuQwua99LL67OHq7uRQGl9cOcbrs/XpkDVpXWNFlwQnZJCgTHVps
         ux2ntZSXPE9FCs/hkRw5+MZSiI7X6OFGtyf5dmgc6h+3lhhgf/EEBRVCPmTBTmMDkdoc
         8UhmHjxTOIko5mCxl9vcQ55WNuCMkFWJsnGmKZtUCNwRw8K2kBiVs0vj3QWCQ+aX7g9t
         L5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731268348; x=1731873148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t19D38cHTZDSKKSN0zcjYdbOcIOVMY1UTGFX7Lm29YU=;
        b=X/3LofIwEUvQUtE9kzipZ4v/jcO8dR34dDWZ1EuDknoUcRVzbpbKciwj9jQv+m33UX
         IyOATvaKITMigH1R05MnzItskEtjHwdEWKhpB6BmB8XekZXvF5Wtb2AraIj+PERkjyuI
         9h+AqWmE/fhsLs0DeG5kd7LnmmjEW3mr1JrxRs7edADMfLL3KG4QpvaGPILXr8zW00hT
         T9EgksasGTj1RR5NvCqDIeq4OeUMO6owgO/GKNk55TA6q0jxBx7Fe42xsfVHs06OhezG
         ih3XxoDvSC28DXy0ibnAnjUsVdB8ovaxKU7LLk01x34YaLsHSIOQKoH5GaWVLD/tnIbE
         JHbg==
X-Forwarded-Encrypted: i=1; AJvYcCX7N9sdFsXeBPkU2rAtREq5eM1iN1iZV+yLjnnb3M2Tg/rxXZYayasmpHEweJZf8c7GBrtD9aBxjVWLW5VW2nYY@vger.kernel.org, AJvYcCXq/O/dsWZsMMvzeqICZsyaL6QFSQ2GGaFoxCe+nEqMZgJzCad7V1G9034HdViFFDaBsgpw3DJBkZMYsdE=@vger.kernel.org, AJvYcCXrMcNh02ryrrPkYCVIBTK81HLCh3BwksAlfdQLh9Tipd/azD9NZfsnEi2h7jYDU2PS4MQ+sdCd@vger.kernel.org
X-Gm-Message-State: AOJu0YxRv/ihjDR+q7/wrTqAgYyg6sKd6owmEPz7NQ8FTTPZMPU6heDA
	ICOLZE1UxtI/7+2vx5u0Pl8y+MoEyrH0u870UlcHIipdacoUFMI3DXB0p9QK
X-Google-Smtp-Source: AGHT+IEsJbE6ntowUKlGvBXLk1/QzHNi3ufUQn43d1AnyZnEoUyF8ivcefnKtaHWTKYxX4BMKmQQZQ==
X-Received: by 2002:a5d:6487:0:b0:37d:542c:559 with SMTP id ffacd0b85a97d-381f186cc55mr8879896f8f.18.1731268348327;
        Sun, 10 Nov 2024 11:52:28 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c18e0sm154130765e9.28.2024.11.10.11.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 11:52:27 -0800 (PST)
Message-ID: <03c0f957-c150-47b3-805c-9a1d774af03b@gmail.com>
Date: Sun, 10 Nov 2024 21:52:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:

[...]

> +static void ovpn_peer_release(struct ovpn_peer *peer)
> +{
> +	ovpn_bind_reset(peer, NULL);
> +

nit: this empty line after ovpn_bind_reset() is removed in the 
'implement basic TX path (UDP)' patch. What tricks git and it produces a 
sensless diff with 'ovpn_bind_reset(...)' line beeing removed and then 
introduced again. If you do not like this empty line then remove it 
here, please :)

> +	dst_cache_destroy(&peer->dst_cache);
> +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
> +	kfree_rcu(peer, rcu);
> +}

--
Sergey

