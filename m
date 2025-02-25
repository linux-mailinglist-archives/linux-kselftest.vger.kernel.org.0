Return-Path: <linux-kselftest+bounces-27539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E7A4510E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 00:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F517FE23
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1723A9AD;
	Tue, 25 Feb 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Iv1V3kpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA501A2392
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527714; cv=none; b=VaO+iyZLu/Ud51vCcgUiYFxmvIY8kmPttKN0YItLc+i43TptgpkFsZWEvFT0CKT+2CHmamr5gbVEVL2iwqlymaOIdAZtEZgVclxlPRdAwWSpgnpSXQPtYxGXPCmGlGPVvD7+Bz+w352X1ZJrED7/4yoFhMrjljwCO+LonWxiQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527714; c=relaxed/simple;
	bh=sSju0BgS5fdbP5bJXxnI1mhD392jojs14xjCr3USU/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4QqkUh3T3gKxxJybrGcbsT2d/a9Gu5wsZLQhfuNg9gzVNDipevzrxdXkYG7O1JKQoBh404SOCjuqXaKteoN5zTULScgvFJ57Uj/Cfu1taThvH5OtYtUBoUY18U5Ceb2t9JcdcVUOXG+bBUc2Nn5sr3HJocZccb+QB+CI3gZyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Iv1V3kpe; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0a4b030f2so804873485a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740527710; x=1741132510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5dMDjXKxu+T2AG0RdE1FsQr1C+kvYp4sA7RFoC2U8Q=;
        b=Iv1V3kpePGOsVJPR7iZTZrUFxHJ2K2LyvzWbKGW5ufieDLZfh7Nu4Z2E/LW6E5qVvy
         NYlSFeYNl3FyZS/k70vXLG0xzN5i2Z5GOa6Rcmpr0lu8fXkNstVG3U2/SK3U1y88FhDL
         eEfHi/hdcqNJMF/tpPVafnNQSh4tPJnfHxsnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740527710; x=1741132510;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5dMDjXKxu+T2AG0RdE1FsQr1C+kvYp4sA7RFoC2U8Q=;
        b=uDRyVfePpSrzQZ7Ukhe8FcoIqOlErIrZGyu28YaBAet0XcDW9if7e9cc3FXYS+s/FH
         KCBZhYpKXtEDW1tnedbu5bhn5fk1UbKiVk8m5ttcHntizCjon5CG2PpWiXu6+TDu+3Mg
         YwxxHvJ38cEYX2hMEC7nEz2kJBPidRxjLZKvn2XCFu3lOfm2+JDNynA4I1/JVowmobMJ
         qKz5y6gJYvwJYjfMlbXDWNezM0bqwN9VlJpo2Xxc2rmI4gjzM7cDv8f2WNS8h0RSCcte
         VsrWzb51bLFwlpZqsVKqQ4cvKGEbfrQua+NC3O9aCT1Vz+IdNkCR9YK+CbcJGwb+ukb3
         F+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVYwp+8lyYP4tkj6sqTtNaqcxkbw1LPhAIX11BMMyixn3cFm1KcfqSIcpyTlDzsKuVY3dQUFAHz5T7dDMryFXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjp0wGg+eJu5L0tIJ207yb7h0hWdbsOVufpscqI7Vd/e4mMaFN
	ezneJhQgH4VGLfVH0RHPwbTuiFxwIvW9Bpj3jR2dsZPpeg4lJRxIDeE2Zmcii58=
X-Gm-Gg: ASbGncsG0k0C/lhyBDXiHtyg2vLkbcMAb9ZcbfGW1ERK7zNXGKpd+5qjwo7PZiewlzE
	EBSLEW1hOBFXbaBmAq7PzvP+nfz/AtEQLAPYKDxoB27Wah4tdoK6+qRRUd5bQaDsd4uE3O9HP/o
	/5Cp2ADYBz3sPVhpZ5eyj6PAWOwE+uxJprvJfxb7roth4WhJS0tfxT+C2no+/6g27ps40cixbFm
	F7/DgF069L/p0HLLlw2q9vbgqp5ppYFbjCDlsa2uVUk/u5/FEfxtxngb64FIqcc0QNpfy4YisJT
	tCzUobaH6EszTE9u35IhRS4/O6HrviebiJg67LEcvhj2G+DNn094LuTovwn8dUb/
X-Google-Smtp-Source: AGHT+IEQKPLVcj2d7UodbbPtUnNi2hKgmOPHZLs2IO/LLKJ0Sxi9MIUzhinnLH5GAtqXty/lewDjdg==
X-Received: by 2002:ad4:5aa8:0:b0:6d8:848e:76c8 with SMTP id 6a1803df08f44-6e6b01d78ddmr267840586d6.42.1740527709979;
        Tue, 25 Feb 2025 15:55:09 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b08857asm15479706d6.49.2025.02.25.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:55:09 -0800 (PST)
Date: Tue, 25 Feb 2025 18:55:06 -0500
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: Check if combined-count exists
Message-ID: <Z75YWvDcvzsMlVHK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225181455.224309-1-jdamato@fastly.com>
 <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c263479-43a4-40ec-94ae-987c7da7d43d@davidwei.uk>

On Tue, Feb 25, 2025 at 03:11:24PM -0800, David Wei wrote:
> On 2025-02-25 10:14, Joe Damato wrote:
[...]
> > diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> > index 38303da957ee..baa8845d9f64 100755
> > --- a/tools/testing/selftests/drivers/net/queues.py
> > +++ b/tools/testing/selftests/drivers/net/queues.py
> > @@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
> >  
> >      netnl = EthtoolFamily()
> >      channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > -    if channels['combined-count'] == 0:
> > -        rx_type = 'rx'
> > +    if 'combined-count' in channels:
> > +        if channels['combined-count'] == 0:
> > +            rx_type = 'rx'
> > +        else:
> > +            rx_type = 'combined'
> >      else:
> > -        rx_type = 'combined'
> > +        rx_type = 'rx'
> 
> Logic is good but minor nit in reducing nestiness:
> 
> rx_type = 'rx'
> if channels.get('combined-count', 0) > 0:
> 	rx_type = 'combined'

Thanks; will fix in the v2.

---
pw-bot: cr

