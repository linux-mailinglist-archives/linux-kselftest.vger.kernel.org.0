Return-Path: <linux-kselftest+bounces-25429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19AA231D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A897A3B68
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251C91EE002;
	Thu, 30 Jan 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tY7tASqR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FE1EE7A8
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254564; cv=none; b=RBNlFZ9PZdaZUuzMb+qom6/g67tkNkSpqv6N4IS5cTxglX+T3F/ebviuT7MdyTcQUTlB/j57v1n3gDecjMvCChMyy0KGCVkBGznzjJKZ1nNLBYGTkpQ/tvutsSNrHr8/H9/hEPhvUUDZxdDajDcz58on6DahoYhpaC+5GSwvL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254564; c=relaxed/simple;
	bh=t83gBk3R1gJYHaKAAfvjNUShPqKhN3qh0uSgLbPTP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8aitm6JCjlAxJzt9+oSmEiSkA43AHOM7FqB9csN+8U87efm88T1JzHb9ceRRHijkevQwkfnVUZo7r7movV/jZ8RWNLC3w2oLNtg3c+7mwFeHvQmIuWJpaBmRa2vGiuPE/EWEURCpA0tbqRy4W7ApJL8EEgiWBYjp2+QIz2ZcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tY7tASqR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467918c35easo14297641cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738254561; x=1738859361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaELnFzz9aRPiHl2MvgwZe5wGfHA1Rh3SyrWRVQiS98=;
        b=tY7tASqRwmsVr0Dhlx1A8MFyV/JSYFFol9/Bes0rqSbY9GWcaUPkgNkGRpWEcPlo5B
         878X5HvRTANi1bsYLe16QeRnx8iNkiTevyzI9fEjA8b5QeGYtIdM1GbI5wr4+hi/Keyj
         2iZu1umLxJx+cXQ55F/Bmm2r7ALCuowRI7rjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254561; x=1738859361;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaELnFzz9aRPiHl2MvgwZe5wGfHA1Rh3SyrWRVQiS98=;
        b=uOzfL2G55h3WnSPqPC3YLz+jQYFHVpQHuBI8fqctTjzmLop7KMp03xIG+w30wspYym
         249E4ls6+6SMGEEIg91vDU5wcnExIRlDQ+hoGz8RfVJjiAJMzH7m3mlKQ8CRl3vH1X8L
         Epsf0nTCZ8cwSr0ShP1QdqokApO11bCS6Z0ozH0r9IHt9qBJN0BGoEc3BIFng41i5aro
         YefjviQtj3RnBM5SCPkEsPv+SwhxZeU/gaEIr4ZMr0LY1s+LqTGjWVUovH0huaRBKM8/
         wNB/XEkxV5ydX8/+tEvqI3QTehUk/ABlJ0WUjRqWNMnCdFEcKuYlBv2+v8590IHVwuIl
         jrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdpkAMSXgFeeuoMEMjAIaXgpQWz9LbNKPGWgOkEAwhrqySWz0Lbk5gUW5jeUZsMsRW/D72jWG5eTGHg/Zb9oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDiiu9OHVr0BNTT/IM3Kb2nAPx1sY/zVoSvD5eZ81HtWlQG0m
	cCe4wRogXidsqiwPPnVv+vDYMLa3YiqnN8LljW6QPi514sF6/AhP46USFy6lHvw=
X-Gm-Gg: ASbGncsveEufcaO51Chg0DpSV9gVRuVsMO/XAeji8B+uQjOetLTbRfgGz/68ObQmP8I
	xkvyn1AYcXPhIrJxxrS5olrMxX7MBBlpGbajuBA1XQHn0af8Vi1JQzPvRYvRxcd7s/rZi+tUAPE
	2sTDSkcJot9B90k1m7acDXIBElW/qbTnklgB0MsYrqfzboCCNHq7klRftbku8A9QqEbFxLs5++I
	ebSFXBw912MpHcNusqf6pwBM5x8CugC71ehBY3RdwCqSmt9BRGDFQn0KXVrnvfPIYJXHGYq1MPN
	K8gwkck4WhU9Mad2B0E+
X-Google-Smtp-Source: AGHT+IFMhjJxwdWrG2OptdCx16imUHT/yVI/4gwEFDkVKpzed2hScRedqGpI22WePJd4xDb4S84Whg==
X-Received: by 2002:a05:622a:114d:b0:46c:791f:bf3e with SMTP id d75a77b69052e-46fd0ba20c4mr121048431cf.48.1738254561168;
        Thu, 30 Jan 2025 08:29:21 -0800 (PST)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0e0d5fsm8544561cf.44.2025.01.30.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:29:20 -0800 (PST)
Date: Thu, 30 Jan 2025 11:29:18 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next 2/2] selftests: drv-net: Test queue xsk attribute
Message-ID: <Z5uo3ugZB13k1aKW@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, Shuah Khan <shuah@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250129172431.65773-1-jdamato@fastly.com>
 <20250129172431.65773-3-jdamato@fastly.com>
 <20250129180751.6d30c8c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129180751.6d30c8c4@kernel.org>

On Wed, Jan 29, 2025 at 06:07:51PM -0800, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:24:25 +0000 Joe Damato wrote:
> > Test that queues which are used for AF_XDP have the xsk attribute set.
> 
> > diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> > index 09e23b5afa96..3c109144f7ff 100644
> > --- a/tools/testing/selftests/drivers/.gitignore
> > +++ b/tools/testing/selftests/drivers/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  /dma-buf/udmabuf
> >  /s390x/uvdevice/test_uvdevice
> > +/net/xdp_helper
> 
> Let's create our own gitignore, under drivers/net
> we'll get conflicts with random trees if we add to the shared one

OK, SGTM.

> >  def sys_get_queues(ifname, qtype='rx') -> int:
> >      folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
> > @@ -21,6 +24,31 @@ def nl_get_queues(cfg, nl, qtype='rx'):
> >          return len([q for q in queues if q['type'] == qtype])
> >      return None
> >  
> > +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> > +    test_dir = os.path.dirname(os.path.realpath(__file__))
> > +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> > +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> > +                           text=True)
> 
> add:
> 	defer(xdp.kill)
> 
> here, to make sure test cleanup will always try to kill the process,
> then you can remove the xdp.kill() at the end

OK, will do.

> > +    stdout, stderr = xdp.communicate(timeout=10)
> > +    rx = tx = False
> > +
> > +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> > +    if queues:
> 
> if not queues:
> 	raise KsftSkipEx("Netlink reports no queues")
> 
> That said only reason I can think of for no queues to be reported would
> be that the device is down, which is very weird and we could as well
> crash. So maybe the check for queues is not necessary ?

I kind of feel like raising is slightly more verbose, which I tend
to slightly prefer over just a crash that might leave a future
person confused.

I'll go with the raise as you suggested instead.

