Return-Path: <linux-kselftest+bounces-21421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8639BC1B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CD51C20C12
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D281FE0E6;
	Mon,  4 Nov 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XdGVBH6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803C139CFF
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764604; cv=none; b=nNXH7ovocKduWeGpvMkc59+FcfUhk0PnoWstVJibs8+4IqlI24huuzqeHm0zFFS9gn6XjR7HnTYCaFVO0o/HENnjXbc07ltCs0CcNo56t/xGiZWpzkMRNC2arGCz6lQkc+HR37nhVUZGQYz/CTRhnHeUnVPykrl9qLDY4oALJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764604; c=relaxed/simple;
	bh=GyiMXQlBq6qvZrV4GoHO1EgraZe6/DObPT0hriIoVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsoAx4Wv5qTJL8QR91clh7ptz8j/OOBVjUIxNPkA8nn73Dp9qHHEqnYVta8iziCjEA3IuYhL6S76jluadanenpSn8gPdxY83ZYS6KtCsA0+wrZ6qXDoysYk+9Yer3xBiXjyOPEaB6a4qWP4zqxl0a9FjN8fGKzbyjon1WO3FZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XdGVBH6P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2113da91b53so14968205ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764602; x=1731369402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=XdGVBH6PIFblysFLRyTEqNwDBLYOa5M0nUUmCCUygzetbGDFPB7BNdNqe+FUANvPwv
         iI3Sv1mV+Jju8r0kaW3NxSIMmTCS5eIPdhMbt8DtvnRjZs8zFgPObJLPqqfzovWtbNDa
         lq6LgQU7VlhxdDnb+HQo5gpsLFU51nGMuZ4TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764602; x=1731369402;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=nyph2Tpqjuq3nsL4FZtHl5ceiXVFCndThWQlMKmb49Ym/1Ds17v7PRr23IJ0UZloeS
         3nr03FuPGQFBpMVn8OwUiIZmxL+JF6IFa+rIAOZt3pGwxRylSAkoYuQPmecqDoMBY2RZ
         b2hD/vHnVxVM0ee+NgeWaeoefZihEYOgenzqXWyinQXRfo+kOcRMPLx1S+nbDWZxiTmO
         gRwH7QBc3VJeRKr6z45Drz+ecaVZ7smSNI+M1wfnEzDYlvG4872g9eiQfKO4Zoz9H34B
         PSXdwhWK5ucAiMKjZT0MQb7tPBET2Ry9voJc/19XbcBvAz85G3b2OWaFjDjmdatOHnL7
         Zt8g==
X-Forwarded-Encrypted: i=1; AJvYcCVo27FmV5rcAOaI687LCdH9uRCm5tDaZehxPdsQAvS/q5cVrz0Q8Sv3Dwb4ajTKueU+nE+mpBXXrW010HotmwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer6zxFaZlwu1bAXJ+eUDudOL71q8IUk3/RGd9ihpmr2cxt2j+
	/GZP4szHIGuSpwQ3YSFpDoDSKgBzWPYBSq1Wef+OUtEjOzgYvBvpYb5bKDKvNvs=
X-Google-Smtp-Source: AGHT+IFXrKScWi5lR1AqaeFnOC9rvxSoVe8YOCE1enP0wNblmedq/YRlE7wtDuDZ1oTXeTsAa9yTLw==
X-Received: by 2002:a17:902:e80f:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-210c689bd32mr446173145ad.15.1730764602405;
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c49sm66855305ad.253.2024.11.04.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Date: Mon, 4 Nov 2024 15:56:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 07/12] selftests: ncdevmem: Properly reset
 flow steering
Message-ID: <ZylfN-YE0-dz5eVl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-8-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:25AM -0800, Stanislav Fomichev wrote:
> ntuple off/on might be not enough to do it on all NICs.
> Add a bunch of shell crap to explicitly remove the rules.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

