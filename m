Return-Path: <linux-kselftest+bounces-35872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9882AEA409
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCB1C439E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9492ED164;
	Thu, 26 Jun 2025 17:10:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111652ECE88;
	Thu, 26 Jun 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957819; cv=none; b=dvwdlQHzi6bJS+sCsQ8M+kbLFGYrbU66dfSUxtFH2n/sX8711bQo4swnsUb58DCBmR8N2fpzSELsI0kfgT83QYYkmO7Szgmw4Vk3mkPBnpY51EQSbhH7AkzaNRNX6wXWUyJrva2W5gp1AnM6xvC87CU9+9YKywB/xjduQMEf97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957819; c=relaxed/simple;
	bh=dFE7wN6V0AnDyFE1cvo/wrWMzfKaPnVu9t9IoU0obTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMfTw35iSm6HQ2JAQ24C3efx9ReUNBP32EGWhp6FAnZqrj200ybT6mi/dZdci6BsOyxEmDWJdEDs4WhfaNkMy5wOnZNUgcJKv6UFzRwoBsahZj1Jd5XyGe+Wo53AQw9Gn17wT2Pe648Y8SukvePGcdWL4+TXG3AYq3/W2vd0kAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso1946542a12.1;
        Thu, 26 Jun 2025 10:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957816; x=1751562616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuOcGODFJxLIsNTIxNnE68hhtwcbQnl8mVcIvSCtqqs=;
        b=jspNK6mfshrc+9k3R63m1h2U4n+y1ijSu8GWC5X80iUcKba55TEnaEDtA3WgrH9hB1
         jtzHqGMidsy+rwQGK0EadWa7g7eexXgTQX6G3Rv3r2iBPkgyBFRTBubwSlJRfoxaNuWU
         ggcNt9HkltAX2c/eEHCy2WrhJFyuXgw7ftIDQvNk1epJTtcVtuRGpZw12khQoODxmeCl
         fCw8scpJdJ9XtQKgupp+DYmIb37vD6OVC0i6s0TuTxUm/SpFvfi3Vp6+oOe8BkhapmAh
         D3EPv3JF7ugnJbfvwedSiCg4VuZhMTB/zPC90Qr7QMI5VXNQEbcfoSL4k1XIGShM60L8
         rzfw==
X-Forwarded-Encrypted: i=1; AJvYcCU3wxzY2mclXt8qkYbUvYBDifto2nC1Jg38CCEYt9WJxGmLVW5NitC6PcI9GtklYF7FRElhnE1/P75MqNHbn2hx@vger.kernel.org, AJvYcCVNeEB0NUouwcVmxU+IYoKYLkCP3D0SOIjBnzUqMJDcCC67UlasVdV6TQexT3o13PIAij3qSanj@vger.kernel.org, AJvYcCVUB4fn3Oz8ieD9ek1/NxK1WhcCrDCklQhEOugE3Hv1e2EyFbysTUX++0w0X8jOT2fNpq4=@vger.kernel.org, AJvYcCXc/imh6KtJ4dboyEBxRPjhd6jYBXoMAsW0jBgqWC8SdoLbNRTptgEuneonYDvtyBsG7C7wMiWZv7UCPtQv@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ59nZ6nq8VyLoCuv3JMUT1agb6ytEDyenTJ5i3P22WVSs2SeX
	k2awnD+S/HhQJT6+Zt3fzgOw4gVZ0HEcHZkxfIpgywXA60lhodtzvRrgasIwkA==
X-Gm-Gg: ASbGnctLi/PgdI/2qMxLmM7LZAWhdXT0BjDUwYEX6FqZRHusqxilcPNqUlKXt75mYIu
	+uA0jO1Jyoa3ogmdx6BYowmQd1dywgRSJIpJTK1gIu5djgP7NUUKpuUL+sff2D01y50UqkxX+Wq
	1Uf72WBgnGCXVxzwbJV/n7ba1LwjoRCrPZ15QCAoYgu1mwg4wS1nc2QipyRg9vYjEOV69hI8kks
	LbQMg41v4yCej/NKipydqn7JpB8ZvarhbVvmQD2eUqaelmzekEx07Z7aQx1D6LJn9m75HTcJGRD
	ZHvk/bZaECWx6FhY1IApRCtRN0vTFOIrkYzYfD3AnLUoqHAH/9Ys
X-Google-Smtp-Source: AGHT+IEwLDfOp5oX/3SNm58CDYQiNOY0hlTx9tedUeDwZqfaqJg+QqJC2Nvn58GQUJIoGBLUCj341w==
X-Received: by 2002:a05:6402:42c1:b0:5f8:357e:bb1 with SMTP id 4fb4d7f45d1cf-60c4dd426aemr7706601a12.22.1750957816002;
        Thu, 26 Jun 2025 10:10:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c826f6788sm255272a12.0.2025.06.26.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:10:15 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:10:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Message-ID: <aF1+9YlFUF8vWH4P@gmail.com>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
 <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
 <685d75ceb113c_2e676c294d1@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685d75ceb113c_2e676c294d1@willemb.c.googlers.com.notmuch>

On Thu, Jun 26, 2025 at 12:31:10PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > Add a basic selftest for the netpoll polling mechanism, specifically
> > targeting the netpoll poll() side.
> > 
> > The test creates a scenario where network transmission is running at
> > maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> > 
> >   1. Configuring a single RX/TX queue to create contention
> >   2. Generating background traffic to saturate the interface
> >   3. Sending netconsole messages to trigger netpoll polling
> >   4. Using dynamic netconsole targets via configfs
> >   5. Delete and create new netconsole targets after some messages
> >   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
> >      called
> >   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> > 
> > The test validates a critical netpoll code path by monitoring traffic
> > flow and ensuring netpoll_poll_dev() is called when the normal TX path
> > is blocked.
> > 
> > This addresses a gap in netpoll test coverage for a path that is
> > tricky for the network stack.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> > +def bpftrace_call() -> None:
> > +    """Call bpftrace to find how many times netpoll_poll_dev() is called.
> > +    Output is saved in the global variable `maps`"""
> > +
> > +    # This is going to update the global variable, that will be seen by the
> > +    # main function
> > +    global MAPS  # pylint: disable=W0603
> > +
> > +    # This will be passed to bpftrace as in bpftrace -e "expr"
> > +    expr = "BEGIN{ @hits = 0;} kprobe:netpoll_poll_dev { @hits += 1; }"
> 
> Is that BEGIN statement needed? I generally just use count().

If I use `hits += 1` then yes, but, I've learned that I don't need it if
I use `count()`. So, I will see something like:

kprobe:netpoll_poll_dev { @hits = count(); }

> > +
> > +    MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
> > +    logging.debug("BPFtrace output: %s", MAPS)
> > +
> > +
> > +def bpftrace_start():
> > +    """Start a thread to call `call_bpf` in parallel for 2 seconds."""
> 
> Stale comment? BPFTRACE_TIMEOUT is set to 15.

Yes. I will remove it.

Thanks for the review,
--breno

