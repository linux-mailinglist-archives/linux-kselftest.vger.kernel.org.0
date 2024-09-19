Return-Path: <linux-kselftest+bounces-18144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B397CEAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 23:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6482E284AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23F144D1A;
	Thu, 19 Sep 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnZe+Wq5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468C143880;
	Thu, 19 Sep 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779859; cv=none; b=bQCI8YW6IFqch80LKGS5tJ2vmM7an2nL0dpoD1w1QV/nLEC9/MgTV/SAehZQiKn2u4fQu0u9uOZvwRhSh7dQnpdoA/S5vA1A9Xht9ceyfpXDrU0RI78Vb8m/+L05v+q+QH2JYaSgXa8zvkG0sT8OjHmcwiq1DNp9knhcrDhuoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779859; c=relaxed/simple;
	bh=1gkVn4ff8puuE5qV2teLTcx6aR19qejl2QG+nUOWnEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjTF96GEncXFxE5XyKlHKjxs/dvjeYP2oLngiHSIztrLkv64etpHxQ79DGJKUFp/WnXPslA8nyIpPE9roCQz+aEaI0YlX9Re74jGY2JAcEXUBmY39lOkoBCjSDmEtmUqhQdWZMhpqcGzpTUxbITeP3NHqiRh29OvI9fXUN9L6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnZe+Wq5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so1130317a91.0;
        Thu, 19 Sep 2024 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726779858; x=1727384658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOaK9tRFSXXQEDDRTIJ5ejJmA1qugThVCUzQzfIByjA=;
        b=PnZe+Wq5/l6Fv8Nut3LNROAp3zZGiUqsCaGP1Zu9QLHhosASmMR8GYJtqU+1V07JZE
         wJe2oe2hlcJdED0eWp8ULnjLAFcip2Qt9IKzTKtIV4WlcTSZar5cAJ9kwTo//Tk2BxCr
         9IomrquzE0gOVR1WR1jBMs0bu7qhU+B+eKVmzzaRF8vtBzG0kwaFNbCNp0QKH/D2CXP/
         IpUWGcIsR3ydet5sbOIxTfAxpPn3XRA1VdWCmyZTgP4A3Hx57lKO25e0PX+Ozriw8XCx
         cEnYw+GpguD1pYQnvrTsPTMrtAzS39ICYmG4GXHzRbXT7EJs0LhzLaY2J+MU7t+Yfmdx
         m3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726779858; x=1727384658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOaK9tRFSXXQEDDRTIJ5ejJmA1qugThVCUzQzfIByjA=;
        b=Z2W1YO1oFrFJV4gyEBTvlKrucmA5io0ZmXxHMBea+p88R2RsAJ91ZnTVfXj+6gTUS7
         lm4KPobe4BzADE59Ie+sEJuPdnJUaodtijbhSuudC2zDQDJLZCO7G6LOnNMS1oYkRq8r
         BLd4bp/Mp9oa59Ku6Fq1RHb9ThFYu+SNL0okq4zb4jza/lF0b2N9lYUES/842GbBBmBx
         IKWjzhpawprNEuuy4+q6kKO9fz0nBhjEjbcMY6qiBuVSGglwXk88RQXi5tP3lIYjgdBU
         H6WYJ4a3m8wBw34RFDN50jBELPgDxX6UsScLmE5y3ovyyDoUOx8DTz05G6GEj8vBER4g
         graQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG60LKC8GdypS0fEA1WlEY0Ws2i5SA8aaW7g0VbT6i3hItHgiL6HjBM6gdua764IsaU9adLMM6/r1e4ml6FSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpeJ7YJN1tdSsC7U28fbLEpLZxamjuOdjK4/4/6ENg/lU1oZfe
	MiswWjjNK1tipAI1LrtlrldnItNViLod8awE0e8hhxBW/+jucoCI0jrQ
X-Google-Smtp-Source: AGHT+IGu1RpXQRrKi2eT3heqMTAPg7/r5/PTZByKkpzpYeUQj+ysK0SNeq9Mtl4G8fIhbXNGYHoGNg==
X-Received: by 2002:a17:90b:3142:b0:2d8:f0e2:96bc with SMTP id 98e67ed59e1d1-2dd80c06a9bmr523593a91.4.1726779857533;
        Thu, 19 Sep 2024 14:04:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3c643sm2417759a91.37.2024.09.19.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 14:04:17 -0700 (PDT)
Date: Thu, 19 Sep 2024 14:04:16 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
	matttbe@kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing
 tolerance in debug mode
Message-ID: <ZuyR0JuU_H3MvEmX@mini-arch>
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>

On 09/19, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Some packetdrill tests are flaky in debug mode. As discussed, increase
> tolerance.
> 
> We have been doing this for debug builds outside ksft too.
> 
> Previous setting was 10000. A manual 50 runs in virtme-ng showed two
> failures that needed 12000. To be on the safe side, Increase to 14000.
> 
> Link: https://lore.kernel.org/netdev/Zuhhe4-MQHd3EkfN@mini-arch/
> Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
> Reported-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks! Should probably go to net-next though? (Not sure what's
the bar for selftests fixes for 'net')

