Return-Path: <linux-kselftest+bounces-8168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F738A6F53
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E370F1F21B04
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949EB13048F;
	Tue, 16 Apr 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsnagsIi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078012BE89;
	Tue, 16 Apr 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280031; cv=none; b=EhW2zcArsAOsN4VmYxErf5RVKSbn4nF/zYmEUEQHO+Ft4xduq+Xe8yg5NaBLd9jsgg5SV892il5Q50PjajX/I+3r/wpEbhFSI/Yo6jMVx/TibLYGWhVwyJt4U4yI0olV/uQlkBTDZL7AHthmhkHe91lTrAmCbV/IpEu/Ua/zqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280031; c=relaxed/simple;
	bh=mC/jsNpX5MnBPd7kR2QFY+vojjYfFxqMjCx97ST+IG8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YoYbRXeVghb4N789zrpcn9sdSe9vKZ14RvAUI0X0+rv8JKI9kNdDe7arv9TsKykI3u5Pqx5ErjnJTiIr0mNJm20IJufBz+TutkhHrmVU2Hw9B50ldp7tA4C903K3tJ1Tsy8SU3o8w40o1jxDBS7moStdWlsyYFotvxotFptxq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsnagsIi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-437610adf96so30901cf.3;
        Tue, 16 Apr 2024 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280029; x=1713884829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFykPUTEhbVsEUuDCk0tmzN7JTj9JbV3teTToBP7ACI=;
        b=YsnagsIinrgw33yhII6EzcLCo/f74gZE2AJ86pUu4ky/Y+grYkIoSJYzTyoEtDtX0V
         myk2R37ITwBbPIJ5OxDngNJ47G6OJYJSOTdPy0OcElI5EMm8xvnzJSkK6wyi7P/e0TFg
         z/cAouYjMD68ptkO3qcsRC5w4YDwW3ymfiXI9nNnZ6HAn8wvUZFaGbVXIDuRnxkqvR8g
         hC2JXDQbf29yshpYzh8UlMhdykBhRXTZY4iX6AAIT+y5RwuxCtlugJuHGCPmb4gUbV/s
         CTlx26op+HwdjclRLIsHrlzSEyz51IEb3ARDXkhW+cP8LzT/jCTqUejDm7rBKGkYnJQW
         ZH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280029; x=1713884829;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xFykPUTEhbVsEUuDCk0tmzN7JTj9JbV3teTToBP7ACI=;
        b=tZqg5RBGCke7o/brkKLANw1Om2McqBEj03K9aLMLnh4Lb5D4K7YvxHMoCfUSXgs+Nz
         DvReRaXYyIP8pkxMt6DvNht/rxotst+/U6fkxw/yXg0076YrxqibC5CuFbzs2tiA4u84
         UQzKJyjJP/oLdoN6a91oOq+xjTiH0GARpEVuhJTXJN15OiwLJqWqtEemkHfk1UyzQmkV
         YgPrk2XZbBieHT7m2fV7x7OFy7tM1cEx1dPnoNprxCxeKZdQxZu22PV4RJ6CXYWFBDTL
         lieUF+HYHgHuQKnnvL5uBTsQJoexTX31TZcw9SaR9OO3FXFbwWgkjnYla4uOHKm00Iyt
         Ni6A==
X-Forwarded-Encrypted: i=1; AJvYcCWsngbR/0MEPkQb/Pjk3ZfbRA8xaQQaMRxmADi8s9+sFuVtcTCF8zv857VuL/dO2QZnXArz0KMNiwTcxtNvqS6SEc8qGNXJrUui/gBtKaR9
X-Gm-Message-State: AOJu0YxztlIYVkai9GnC6Tb4LaQwiPFT4w9ArHW6ZOYz8iOfNdKB8u1O
	1UmZVRiRWaziH9C8Gs8t0xTlny3HafIPBqU5bOD857OV759lzgCd
X-Google-Smtp-Source: AGHT+IGllGTmBMC/arNjIiq835lAEYPzhIL47M6o2ZgZ9hfaQD7EioUIV5PQBuyRHSx1Ft83jLSt2Q==
X-Received: by 2002:ac8:58c8:0:b0:436:d3fb:e84c with SMTP id u8-20020ac858c8000000b00436d3fbe84cmr9498143qta.11.1713280028775;
        Tue, 16 Apr 2024 08:07:08 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a084d00b0078a04882ac2sm7517526qku.53.2024.04.16.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:07:08 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:07:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <661e941c3e250_5279f29470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
References: <20240416004556.1618804-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 0/6] selftests: drv-net: support testing with
 a remote system
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
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> I'm only adding a ping test. I had a bigger one written but I was
> worried we'll get into discussing the details of the test itself
> and how I chose to hack up netdevsim, instead of the test infra...
> So that test will be a follow up :)
> 
> v2:
>  - rename endpoint -> remote
>  - use 2001:db8:: v6 prefix
>  - add a note about persistent SSH connections
>  - add the kernel config
> v1: https://lore.kernel.org/all/20240412233705.1066444-1-kuba@kernel.org
> 
> Jakub Kicinski (6):
>   selftests: drv-net: add stdout to the command failed exception
>   selftests: drv-net: add config for netdevsim
>   selftests: drv-net: define endpoint structures
>   selftests: drv-net: factor out parsing of the env
>   selftests: drv-net: construct environment for running tests which
>     require an endpoint
>   selftests: drv-net: add a trivial ping test

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for humoring the naming suggestions. Exciting to have this infra.

