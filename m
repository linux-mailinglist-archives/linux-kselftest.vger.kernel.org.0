Return-Path: <linux-kselftest+bounces-26426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D03A31630
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6EE168F9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB2265627;
	Tue, 11 Feb 2025 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wYsvPKyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E526561F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303853; cv=none; b=BiVO/+SHLVHHY5/Oqh3QBiWIDmjO0vc84zsLcnjRwJtdoA//bx1WvckG9TKvWlu209NV/5zyCOMs8hmTR++XqNFz0PTAP0eDL2YPPc3OW/gDF0YJtHR923UoOpUI8QgDzWnZCCYhulaAlPHCJPqIJ8iwAp9lliCK2nKleK5l6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303853; c=relaxed/simple;
	bh=4L1l3nbsQwxG4dhopMpRTZTo6TywqvNfWe0By30mxKA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwGui/mIQfgtnvMuJ6sfId49tMq7k3X8e1DZay/4rmuQZysG1FBA0D9W6POV1zShMvP/gZlOujd7CW8IJ0MkCqPrSZVNg4+SEQLbMpK73OOf6jB1iBd19wD2mYkDXXUaaw94/BcYzFw2Q9z6dwe9IgIJiOjLun9l8rgzWjkSKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wYsvPKyB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f40deb941so129835325ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739303851; x=1739908651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZz21PoK7ESpRyCP00gJn2627gqZOHRBJZHWL/EIwBo=;
        b=wYsvPKyBkoDXAYAkV39HQmlK8TOoSuLUE6ER8pM+sKGn78lxAmujZPT9cYAIlhtZDo
         o1z8M1XBvBIrRDEmndONT4C68fO8Xyl0V4BjRVs3xfyI0eLoxQfVNJX1yfmfNi8uzNMB
         Z7MptZhHeLUgnv0bJeXlV0/5rhe6vHGoFdBYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303851; x=1739908651;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZz21PoK7ESpRyCP00gJn2627gqZOHRBJZHWL/EIwBo=;
        b=OpWWHjDHD80+R2E8evi+CSolrLcMWXDFuWAXF4TjxYsvtK/SxDDTidToylWgCSz0tO
         g3De7wlDr1dq4s88bopw6u71R9JflIuFSHOep0oAcWvgMFJkWGxe2jVGlZZRE65bnimn
         k7xGT4MvqsZLC9WJ0Nx1mH5aL2hB58s8zoYz5DoV0eOx9lsBfn1KWt0N+lB6NZyQDRa3
         ninl2zD4GRjE0KdLtaCzj+6aHz2euG9ioXOP/ud3pMIuvOat82qP+JtdvioNwA8ZUeqM
         OEflI2Js45KBxrTzNNQ6CRmC7H14RNIN3LkC3487wfRdP6m0BNvFlovcUA40AhCmZ2+W
         oXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXUxerR3l04wf0xT7tDe4ZCDBuhReB+NLvePF5qnDIl/F35H/TF724Y02kIcCPKfxTKfZa2h8u04CclId9Yus8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Pi3KxG6Ixl2vPvjjQNOgMKSZVV6QBbnNtUQJjAXG0Dy9YFel
	GXRIhnMMd8S18MRv21VBdSKycK2PCNvznADfwDbCInVrAeocjQzSdS1XKUPniqE=
X-Gm-Gg: ASbGncuRRQPgLNKvC12uoaoXHDCNm8UQiR/TqGzxAGpLxzhD7/Ji0vlgI2J+F6lWr7f
	lt0jDb8h67081zkDMc3PnA28n1Cun6AUB3VO1aGH0Cm8JAqWodyguc4hfdSxHTz6E8GX0UuYXjy
	V++wb4sx73c1nnv9w0pYr3QXOeMti1M0D3jUwrPxVNDP4iH8efN5R4cUL0tvjQcQvEDaE01AM5a
	u4ag+C4po1u7qoJrMJA3v1hYnb4YBlRM+3+Hf7rtYrroEGs5NjToplai2VeFGUDEu+yxrbzamQK
	V90HtOpXonyy7wpp/Auhjmygs8pCz77AQV06FWu1DWvMRBKJxDlPSxB3rw==
X-Google-Smtp-Source: AGHT+IHGm6N7udAh5kUmRKYI+y4WUkbVC6Seg2Hl1n1knL0KkTOJXLUEmjJNH2ogtVLi5OCw8cUlqg==
X-Received: by 2002:a05:6a21:7001:b0:1ed:534e:38b1 with SMTP id adf61e73a8af0-1ee5c85fa2cmr1060630637.41.1739303850821;
        Tue, 11 Feb 2025 11:57:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f481ec4sm5371235a12.9.2025.02.11.11.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:57:30 -0800 (PST)
Date: Tue, 11 Feb 2025 11:57:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
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
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <Z6urp3d41nvBoSbG@LQ3V64L9R2>
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
 <Z6uM1IDP9JgvGvev@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6uM1IDP9JgvGvev@LQ3V64L9R2>

On Tue, Feb 11, 2025 at 09:45:56AM -0800, Joe Damato wrote:
> On Tue, Feb 11, 2025 at 12:09:50PM +0100, Paolo Abeni wrote:
> > On 2/10/25 8:38 PM, Joe Damato wrote:
> > > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > > +                           text=True)
> > > +    defer(xdp.kill)
> > > +
> > > +    stdout, stderr = xdp.communicate(timeout=10)
> > > +    rx = tx = False
> > > +
> > > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > > +    if not queues:
> > > +        raise KsftSkipEx("Netlink reports no queues")
> > > +
> > > +    for q in queues:
> > > +        if q['id'] == 0:
> > > +            if q['type'] == 'rx':
> > > +                rx = True
> > > +            if q['type'] == 'tx':
> > > +                tx = True
> > > +
> > > +            ksft_eq(q['xsk'], {})
> > > +        else:
> > > +            if 'xsk' in q:
> > > +                _fail("Check failed: xsk attribute set.")
> > > +
> > > +    ksft_eq(rx, True)
> > > +    ksft_eq(tx, True)
> > 
> > This causes self-test failures:
> > 
> > https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/4-queues-py/stdout
> > 
> > but I really haven't done any real investigation here.
> 
> I think it's because the test kernel in this case has
> CONFIG_XDP_SOCKETS undefined [1].
> 
> The error printed in the link you mentioned:
> 
>   socket creation failed: Address family not supported by protocol
> 
> is coming from the C program, which fails to create the AF_XDP
> socket.
> 
> I think the immediate reaction is to add more error checking to the
> python to make sure that the subprocess succeeded and if it failed,
> skip.
> 
> But, we may want it to fail for other error states instead of
> skipping? Not sure if there's general guidance on this, but my plan
> was to have the AF_XDP socket creation failure return a different
> error code (I dunno maybe -1?) and only skip the test in that case.
> 
> Will that work or is there a better way? I only want to skip if
> AF_XDP doesn't exist in the test kernel.
> 
> [1]: https://netdev-3.bots.linux.dev/vmksft-net-drv/results/987742/config

I'll give it a few more hours incase anyone has comments before I
resend, but I got something working (tested on kernels with and
without XDP sockets).

xdp_helper returns -1 if (errno == EAFNOSUPPORT). All other error
cases return 1.

Updated the python to do this:

  if xdp.returncode == 255:
      raise KsftSkipEx('AF_XDP unsupported')
  elif xdp.returncode > 0:
      raise KsftFailEx('unable to create AF_XDP socket')

Which seems to work on both types of kernels?

Happy to take feedback; will hold off on respinning for a bit just
incase there's a better way I don't know about.

