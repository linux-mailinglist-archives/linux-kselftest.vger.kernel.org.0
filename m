Return-Path: <linux-kselftest+bounces-26402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F7A31368
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C816406F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318A1DF99F;
	Tue, 11 Feb 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XH1xgEOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF46261564
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295962; cv=none; b=e+DDZqH54IbbgjUAVdLyAVYBD/1xNqcm2Qkjkq7lmtLRq0csjUCIwIpUZKxUnQfXTuziLIwvcS7SQCSbk67N6Q9OcaNTu+8hogPiRyythjJrbOiazMmiZqrmZss9pwjG6qtGPPr6NcM+ne4ZwUWhl3T3IIJVJotK1jr+HzUTOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295962; c=relaxed/simple;
	bh=u0XrVF8iTTm5UaCKcKl+IQNCx5OX+tUX5xKCetplVyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktdGQE2wVNY2fQJwkXyKduFxph6T0NxNgocnFOrNHY7T6LLKi92UMzsvEDwCKcEkj/MaNgAaY3PbEf9oxTrqPHdw0D/wPl/5bWZxjiGSWpQg+aeYYq1jge1aDWnj/ky79uR2d4fQRcvCqp6B5PESHpMZCR0ObWZ/hbiqEAaEoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XH1xgEOh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f48ab13d5so98479755ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 09:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739295960; x=1739900760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU0k36QB1XU8Cts/gsb6V0Pakg2qWpL/o6Sf1GbitsM=;
        b=XH1xgEOhDENpheNQveaJb4KLCeCzJm9EjxEHmPPgRbHIlriRz0vak7hBRdxK78EmDE
         QknjrOid6eSGRIryu48ME5qnumlV0sB/N5AE3QUuKPLmeH0IlkIe6/zUn7N15Vqa56wj
         rPYydxek/8UkSZLtb1IWkvb1MByGX9M7ORXjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295960; x=1739900760;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hU0k36QB1XU8Cts/gsb6V0Pakg2qWpL/o6Sf1GbitsM=;
        b=gY4Eewpd6OQpipYibawneZtUCg/Qszs5ZbIKQ+jgb3Ey37Vj3gdi5pYQgZGNogUTR1
         joUWHyd6Yq8UYOrP9hN645/d7I7mO8sS6wZMyGf1hLM9vlG73482mySpiMG0YIHtdOfC
         /OkLqsPLRL2GWebGkdUoOAkohBHTLHXVMOj3bhSTrtKfwGXtRPiMTNBq90CE+8NVFcLo
         8WnXBwHnsxd0aHtrfuM8OfRJ8wWcQSzocdInTuySq9Mg430KqEjjF3AMms1JWBL/TYEj
         tr+j38NA2DMvPfFB3827FzlLMWo3yMM4HSVpZSuN4YAWwMEYr+6iYjfa8PNB5yZHye8z
         hDGA==
X-Forwarded-Encrypted: i=1; AJvYcCVAt4JeZ4U/CPc2J6ZSJ6S1d+rp0F9nyBm+W8sRDwMUsQDEBc7uB05+d5mQKFaxC+mSvb8l/UGzKdhvqIjqivo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TuC5xN6h3wnl085nxgIjjNhd9t5UbEHvXINgo+g1YWys+ydv
	WIhD7ytAamyDfiKdiuIrababCuEdo2ylQ0va2gYcBy818SL229kLmYc/AFy1X/c=
X-Gm-Gg: ASbGncvTMA02Ieuoe9WcxWqpav9z80LkdX5E87SsR+Z8jlgJvk8D4+jmayNW/ay2DEW
	TF+V84TMWmzic00CCecW2PPgAx7Q7q7kCQye6AE/ejZJ3t3OVV/GNsY9UR6F1coG5lF6++3jBGb
	5eoRuQnYS23t1NYQt30NSLkoyHJVvWrd4ModViCWC2IZTOlvRq+j8+2uNaMoB8oodCbFLkxGsUR
	sPXvtDz+nSX8UXdZWA4LKHMDxNzMnwxyCeE64KQUcZJSCrcZFiUofbYcDbCFyLnagj9lC9n33lJ
	FTa/wkGGCjBFVzUFiilITX3K6FF4yyy0Ppd+uSgku7CdCbqtAX09U474Ig==
X-Google-Smtp-Source: AGHT+IG3/CAcTS3CiCjU9yipQAdPsOj3aLbPkEZBQL3ZsInksDgw155tgyytgR1Oc/LgBs+GNy+uXQ==
X-Received: by 2002:a17:902:e846:b0:215:9470:7e82 with SMTP id d9443c01a7336-220bbb112e9mr2596865ad.4.1739295959965;
        Tue, 11 Feb 2025 09:45:59 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecd55esm9673581a12.29.2025.02.11.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 09:45:59 -0800 (PST)
Date: Tue, 11 Feb 2025 09:45:56 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, stfomichev@gmail.com, horms@kernel.org,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	stfomichev@gmail.com, horms@kernel.org, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250210193903.16235-1-jdamato@fastly.com>
 <20250210193903.16235-4-jdamato@fastly.com>
 <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>

On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> On 2/10/25 8:38 PM, Joe Damato wrote:
> > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > +                           text=True)
> > +    defer(xdp.kill)
> > +
> > +    stdout, stderr = xdp.communicate(timeout=10)
> > +    rx = tx = False
> > +
> > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > +    if not queues:
> > +        raise KsftSkipEx("Netlink reports no queues")
> > +
> > +    for q in queues:
> > +        if q['id'] == 0:
> > +            if q['type'] == 'rx':
> > +                rx = True
> > +            if q['type'] == 'tx':
> > +                tx = True
> > +
> > +            ksft_eq(q['xsk'], {})
> > +        else:
> > +            if 'xsk' in q:
> > +                _fail("Check failed: xsk attribute set.")
> > +
> > +    ksft_eq(rx, True)
> > +    ksft_eq(tx, True)
> 
> This causes self-test failures:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> 
> but I really haven't done any real investigation here.

I think it's because the test kernel in this case has
CONFIG_XDP_SOCKETS undefined [1].

The error printed in the link you mentioned:

  socket creation failed: Address family not supported by protocol

is coming from the C program, which fails to create the AF_XDP
socket.

I think the immediate reaction is to add more error checking to the
python to make sure that the subprocess succeeded and if it failed,
skip.

But, we may want it to fail for other error states instead of
skipping? Not sure if there's general guidance on this, but my plan
was to have the AF_XDP socket creation failure return a different
error code (I dunno maybe -1?) and only skip the test in that case.

Will that work or is there a better way? I only want to skip if
AF_XDP doesn't exist in the test kernel.

[1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config

