Return-Path: <linux-kselftest+bounces-38738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D0B219AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C4E7A4DCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9892882B4;
	Tue, 12 Aug 2025 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JVwbMtz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3361E102D
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957335; cv=none; b=po5uZepreSWB2bNzE2tioid4ySQQ6hSKKYX++/jbIS3VY7ZWXACqwQQcwi18vHQlrJSz/DoMGW3FS048VltvxZmv8maJqUUVtnyENTNCU2Dsqe+2OEZgVu1IQv2RVa8faz7+3i2WOZDsRkBV84L7jGP1cUSHEUcAjwuSN0ZeGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957335; c=relaxed/simple;
	bh=0uSSgyFAERcvMxmuhvDaQFKHG8ePM7E8bC8yCm7T21Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcPZQraCCU8aE2kpNuDJ0AVKKsIrwHq9ErxGh+as9X4VTu3NSQKasWf4b1xsP0oNALEdNBVn6QBxrfHhoPcM79wzstCM7YzZTuYytXy8galqjHvLSG3pXAS/m3SS7U/1B6OYZnbn42V4GwLQD/ZIjXaM9FtQAFqeZuA4UfgX1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JVwbMtz5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2401b855980so35882215ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957333; x=1755562133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UJoVFj0ejQ3uX/IGEhsnvXF/6F029PsSD+iPN5zUso=;
        b=JVwbMtz55e9OlgBuhptBd2LIwhrhAP8BCBE9Ll7/981FgaDTifTa/W2NslSrW4FR+I
         Ioe6mKUjcG+wnTAd1dQAXf3I0SR3APWFOWE1ThYHUycXjjGC8gUlc8SNR0OsGXszhLWd
         ppBGBG7vFhbXxLKstJXL0IB+iL9WhINqKINYFZrcZMNNCsoFrpWmWsz4sPABBZ9IlwsZ
         +V2D1kFFWmsDJecI2mvuWppk6Q1fo6AGOB39VmEKFB1qFGQnFo82egmDLFPBBNAKOp3D
         4h9oF+Tl+lMaKtZ+rLD/wHT8smX6j2DYXxJXbDFAYy/JGw8vn4L+dmHeG790LwpyJtf6
         a2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957333; x=1755562133;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UJoVFj0ejQ3uX/IGEhsnvXF/6F029PsSD+iPN5zUso=;
        b=V+UR/VJAI1M6rYbtGx+D1tgcrqS2xSRNA8Ul8Q6Y8Slxj+oZCbmr8baCTAFKBJllGu
         O29Z+/NTJZ4jdpS0QMNvA7AW7j72x6GAw/KWC4R1wyKJeMOm6mBvEk4JAAHaQT1atFdQ
         xg8ZMTgME0HIVFvyk2hGAgIjuMWTpOpXOl4JgtuLFdAE01AOwB5JZEPNMnQRhpkmKT70
         Fcss4wuhhYzVq7rH2I2eP97Xmjt+BIwBWdrw+dmIxai3xww/JjDkmk5lAVjty7JH1jSD
         3vEE7mVocEWoSeiXlwz1dL+QutkdHeFlkPXIzl7Z1wwFgVcLNyGulIkyOaovu480zKKJ
         gQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsku8OjmfcgjlP0aXHc8UA89v3Lnwqo5aK+Qdwi9AtwZ8oAsLqG57q8MEXCkFczKqmWirb8ExBb5m7sFdiRgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJQKtZBhlhmYsOU1LxjJKj8TJHLKy5TEk2tFZQ2PLQMfGYGV7
	e20gRsqYMp0uWBvQq3Bqe+HmGGgpB6H4JjfTauXPymaS4dAcOz+O4hLcnAuMlUZr4s4=
X-Gm-Gg: ASbGncvDOwvXGVnSPUafXCmPbyG7wVEcRhfkCfAFs63bfDeYdH1J2iwFOxkvOto6NOT
	nOPCx0zTGr1eeqXWEYCxjFsBCGt0FLJKCYEuBJYmDE8zyyeg0fvgYz1ZFjW2UvHhjmfYoRYAceR
	J4rRDFsCXm9oOUQfuMCGYC9/kylv4clsYwnhIfF6pSlVsj83yKSs7TPDTbzGVnSSqaplqgB+Ili
	VqZJFVE+kff66zHnEcrHO2TNIce+cpudequJw8NZ9qufUj/JQpWRdl4E3ddeJdNxfbboTvF718Z
	MrlxjI6r3Yw/YnWnQBQzYlHZ+o2V0uW1UoKgVx0RxQUJJA3IgAhA6iL6jIqOJ6dmyujlbvoI34D
	JD1i1LR7Bqy6b1fFcmfxFnS+2J8VmFUuFOw93i21LKzAKMQ7aLuTjQNc+cMT9QIGsNDE=
X-Google-Smtp-Source: AGHT+IHKpcKLNIJaVKwMltOhMXMXlyeWwGFFHidaDoKw3udjWJkHoMZgcYXJGpncza0SxMnl/pWORQ==
X-Received: by 2002:a17:903:943:b0:240:6766:ac01 with SMTP id d9443c01a7336-242fc320833mr21315365ad.2.1754957333352;
        Mon, 11 Aug 2025 17:08:53 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242be41cc16sm98169005ad.52.2025.08.11.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:08:52 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:08:50 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 4/5] selftests: net: terminate bkg() commands on
 exception
Message-ID: <aJqGEvtKkIq9G2J4@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-5-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:33PM -0700, Jakub Kicinski wrote:
> There is a number of:
> 
>   with bkg("socat ..LISTEN..", exit_wait=True)
> 
> uses in the tests. If whatever is supposed to send the traffic
> fails we will get stuck in the bkg(). Try to kill the process
> in case of exception, to avoid the long wait.
> 
> A specific example where this happens is the devmem Tx tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

