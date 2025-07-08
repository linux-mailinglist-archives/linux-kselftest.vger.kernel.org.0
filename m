Return-Path: <linux-kselftest+bounces-36759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EEAFCCDF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81DF7B1F59
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DF2DECB1;
	Tue,  8 Jul 2025 14:01:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE92DEA7E;
	Tue,  8 Jul 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983302; cv=none; b=BEz7cb7ayZwd2hkymfuv9Celf4aijiJsFg4YtFvozi/GK0sVINb7h0mMK7tkaJNNWHMAbsObxfbObzGoxl6ss8cPyWJ6YvCxjbrtFCOOjhcWlUSd+GppxuAKqPA1ZSeSHbu+iNE3c1TyFzcjb34O1YYQiMD4Dxg/Pxifm/WaU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983302; c=relaxed/simple;
	bh=S+3F+aWfrIAC2+z5kIgDbrNvhTuJkm18BLsnDm8MtKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8BlXMmrKX23Py3is3FkNo4ICBfjxaTfJRm4oKwy1npzmvYqwWonko648cLFdAbQPynfmfpjvOBoIwrlPAhFQOqXh8UTrOnbjkkHpJl14vxKI4hJyt6aaqNRVpTJ8FC8IJ+HeWVpIYDpGhtT9s2qlRsCDeEbeXH/kmswUcgH0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1113741966b.0;
        Tue, 08 Jul 2025 07:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983299; x=1752588099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/T6HLIaS53QaELzg/5d/XR8JJ9BwHZCN77mS2BbqpM=;
        b=Dan6iwbB9fA6y9yLd6APjWko52rcyvm61/BKt/TSU//thn0tqv9aVtIRVIi/I/fc0D
         q4IAc1ttPO6H5DeyMjyIt2wCa95utixt9qI2tfl7uwn+/OmY45TBUjxVhe7CFXB+e2Rq
         yCNZUKIk5+W+85jszrOLHtqZTsVCrbc4ncQEeWlzRgjpNYFe8zL9nvAiPVYYDeiJBClk
         pP+/UKceU1fLWSAVWKpAsVnXhstV8iBqSB7d2mYDM4qm1JQX6n6eqJcgWEEZ4USAXy5g
         kYcCvyCVBiNWqIxMRzcL3CO9JSxKeh/DeFrFutu8aJA7Uepe4cnw+9re4+IImDSInR6p
         ntxA==
X-Forwarded-Encrypted: i=1; AJvYcCVNI28xOipHhsLwOzCa6mI9sDfdD2LroQyvwjymP0dhbyGhi8dCfQENs8e+09NLV7MICsDDnAS3@vger.kernel.org, AJvYcCWgfnHgDsvZ5vWiqzS/kuaLUIJdIO7F3Ce+EeV9tVfiBMOQ1uakmD5IOXrswsZcWiFPbzY=@vger.kernel.org, AJvYcCXGZDkpjvFrsDjMzwVnW02/vZzsWMCkvqYrzTTraAEBk82nm5a3smL8LitEXCn7tgnnPsl1TqLuR9XSITVb@vger.kernel.org, AJvYcCXiHibYz1BA0FrgoN+Zv0re1Nkq9G5egvlEcNVcZrCNnm6HOdXLJyltS7EB7mwB3XpwNMQjP4P01UbGiaJxbAlq@vger.kernel.org
X-Gm-Message-State: AOJu0YxanI0iFbJp77y/R1Di6AIMzX+pQWNaK0WwXPdeqARVgL7PDKJC
	chpmx+G6U8tPD/awrLK9W5aoV795lxTQt24nD6vVHjvw74sAMm2XJ88P
X-Gm-Gg: ASbGncvqmlz48WCr+aiZsuEHcqUY5+aywjSiyW2+wsQvWXwG5JkqAGOjtX/Eye0xjft
	0Cc9rVt8Hxe9Wo1vMRGVFXjmHOIuqFbhrMIbKprv9wAOMNcRlqqgRzCt6gFFvbzr0a3DgMwbclI
	FJ84YpWD8ZZme5gm2dEN6RxA0G+X3hUzL+edHBG5+i9tmWf5L3hUbR3q2HQ3RrbbJJ7GDaOOMpW
	VjLEbfF2+ZkpG5beAp9oZhKNU98sl2/BE7BnlhxR3HcNBe5N0aNpEET4IHSEMVTDCgkhMIwdmxJ
	TxTKP0BTdVDT+QCg/jqaImni+K+Mnx/cYK3VHG3sdUlIarSDE3hldSXh+E6eMsOL
X-Google-Smtp-Source: AGHT+IEdk58U8JuBVqHJLMbcbtU64L159+mHXzi58SyavJ9NMLr/7SNkI39echbWqkBe73zw7i0W1g==
X-Received: by 2002:a17:907:971c:b0:ae3:d0fe:a35e with SMTP id a640c23a62f3a-ae6b2ab7063mr338234366b.11.1751983298757;
        Tue, 08 Jul 2025 07:01:38 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac298fsm900464566b.101.2025.07.08.07.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:01:38 -0700 (PDT)
Date: Tue, 8 Jul 2025 07:01:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper
 for bpftrace
Message-ID: <aG0kvwxT74Vo+itz@gmail.com>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
 <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>

On Tue, Jul 08, 2025 at 03:42:33PM +0200, Paolo Abeni wrote:
> On 7/2/25 1:21 PM, Breno Leitao wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > bpftrace is very useful for low level driver testing. perf or trace-cmd
> > would also do for collecting data from tracepoints, but they require
> > much more post-processing.
> > 
> > Add a wrapper for running bpftrace and sanitizing its output.
> > bpftrace has JSON output, which is great, but it prints loose objects
> > and in a slightly inconvenient format. We have to read the objects
> > line by line, and while at it return them indexed by the map name.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Does not apply cleanly anymore. Please rebase and repost, thanks!

ack!

