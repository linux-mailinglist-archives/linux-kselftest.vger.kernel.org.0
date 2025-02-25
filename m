Return-Path: <linux-kselftest+bounces-27443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F7A43D3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892EB19C0CCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0361206F22;
	Tue, 25 Feb 2025 11:17:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670B1A239E;
	Tue, 25 Feb 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482260; cv=none; b=TvQViiDLZIeJlGsnApVsY9pBxLhVYWuA1GQfo9qFsGh1tN5VyE0KzjSb+zUysklgXTOl28ar1feUq/cUaKJJ0yUrwSR7WLWPMNdOBcaVXczOw90ihht3AgwnNmErJ2pBxtC1FakbaLg0Wr9rPr46MVGk4Pb1YuJbWgnGWhmYtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482260; c=relaxed/simple;
	bh=Y4qrHsZ4YlKYiMw1liY09TYi5suU2srUrdPV71CkQiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTxMbz0RPtPbdbYhm/sYFzh34FU0LxdJ1OgGLQQEjcaBjWMLxyJQ2h02lq+SCfu4llqH32+g0BuRcDZ2HQua2MSV8ccvbyrLrPWRSSm6KN+MrvPskXrC0BSbk/J09mAOd+7YPH2j+aQUpmyijD9QCiFK6tllxZ8sM+6SmtYDmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb999658fbso681915766b.3;
        Tue, 25 Feb 2025 03:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482257; x=1741087057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j29+YwywkVdnOwJpODDXLXoxVQ80C41eZ3nGoHPbf4=;
        b=Df+K/BVTSZ/FqgrWjulI3eyLIxO3aIZSwXCw7zluU+nT/HVEYg/RgauJAOlO3VdhBs
         4EuASt3XFlhFLici9PYpIDVpDmx/AwFiGdoMQWsN7jywrlHs4SE0N9Fc9akwzhYeqgTy
         Aa7n0u7ykIIHlN1H3CFaCIUekzXRoKthjz2jdvqFFSIA9CCGe14q6AaeON07tZRpmvfr
         lOuDsw98ERZqM4wpqDYk/wxb1uAa4jhjy/R6AiA6US9hoEgrVDHxTwoQ6YO20qtrZOkC
         ypvR2v9wXeLJtJVgAm0Kwx8SR06+JqQivFSRPlCVyd3w7VojSkR+MqzLWPpooAFG3H8k
         TFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP7juvDNcZzQZiHBW78+8HwecbW/lnEA9GsQBn/Waem2Nw+gN7P2RKvUk/n0cIYLVC3GOYiRFI@vger.kernel.org, AJvYcCW4CTCPWntj3TpSgI8TVXiAJePaiuYuk5E+JEGEDOxI+E3WFoinpGjdiZQ3tGhXV66Or45djW8zJjU=@vger.kernel.org, AJvYcCWmt3hUi4jRx8f+ECaUOkHXx23MegENHGHMoIo3rHPqvRKZIeaypcTsPXGeIxIi8CbjjnAQy9tii+vCjeM2@vger.kernel.org, AJvYcCXLDJOa2USegPdllpZWmNmd61QVJnq8KYV6pzzpKQC7iEa9wsnY6MkW2iH+LlT7N7b0ZEx1n0p5vm3/LbEUK3Ho@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4EXn6N/vDmUSKbK1BPoylpZwMMy/U39h+RNo9rZqv2gPKsx7
	qy8XiCfqTUHDCX2qNBYaaA2uJSk+Fvbkr7jZor4aZFwSQpqNC1pw
X-Gm-Gg: ASbGncsrBl0ISsRmfKyFlDO1sPyve6HKgiNSWNjMl4L4idsaRs9CMyUMCWXhEcv/Mwp
	4OOfGFn/ZyP+9Ouq+46hQ2KPnsVKBS+lJhYHNxvAVpldQqN9K7KlyG9DSghM6PJxzsiEfe1vsA9
	Lt7AzD9uHE3vF77CQEEzXYPg2SJHnY5gRh/J1RYmkNP2OnywQrg/7HMGVugSwGnoVnWJ5p4h04t
	hpn4pfCFvCn1Q5lPQqqchXN5hcXUoZyRLFoJRbAYreGFJWU+jO6llSGidlHqmvWX2dtIxTlZfwp
	6xcyvglItCaqEFugGA==
X-Google-Smtp-Source: AGHT+IF9N08H7jTMLFCvTUzvTml6TjwoMntNUKf+GwIhdyS7gvhSXa+0EhXsIhy4Y/1NGXa86oTn0A==
X-Received: by 2002:a05:6402:34d0:b0:5e0:818a:5f4d with SMTP id 4fb4d7f45d1cf-5e44bb36997mr7209455a12.28.1740482257036;
        Tue, 25 Feb 2025 03:17:37 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45a8b8b48sm1069172a12.20.2025.02.25.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:17:35 -0800 (PST)
Date: Tue, 25 Feb 2025 03:17:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
Message-ID: <20250225-doberman-of-scientific-champagne-640c69@leitao>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225101910.GM1615191@kernel.org>

Hello Simon,

On Tue, Feb 25, 2025 at 10:19:10AM +0000, Simon Horman wrote:
> On Fri, Feb 21, 2025 at 05:52:10AM -0800, Breno Leitao wrote:
> > This is the core patch for this whole patchset. Add support for
> > including the current task's name in netconsole's extra data output.
> > This adds a new append_taskname() function that writes the task name
> > (from current->comm) into the target's extradata buffer, similar to how
> > CPU numbers are handled.
> > 
> > The task name is included when the SYSDATA_TASKNAME field is set,
> > appearing in the format "taskname=<name>" in the output. This additional
> > context can help with debugging by showing which task generated each
> > console message.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
> >  			 raw_smp_processor_id());
> >  }
> >  
> > +static int append_taskname(struct netconsole_target *nt, int offset)
> > +{
> > +	if (WARN_ON_ONCE(!current))
> > +		return 0;
> 
> Hi Breno,
> 
> I gather that theoretically this could occur, but it isn't expected
> to happen in practice. Is that right?

That's correct. `current` isn't expected to be NULL in practice.
I've been running this code on several servers for days and have never
encountered this warning. 

While the taskname feature isn't enabled during early boot, netconsole
might be active at that time, which is why I exercised extra caution
here.

If you also think this is safe, I am more than happy to remove this
check.

Thanks for the review,
--breno

