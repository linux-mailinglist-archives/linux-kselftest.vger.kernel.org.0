Return-Path: <linux-kselftest+bounces-16690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CA964966
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14224281E4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76A1B29CD;
	Thu, 29 Aug 2024 15:03:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF31B14F6;
	Thu, 29 Aug 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943797; cv=none; b=CEZ8rJ4TDNgf8K5wAZL6Us6ygnkTXW5fSfBl9CkBrFYDJTu2rEmG55Vd00ZgvfJMPrDjsR4jjz5oalvwycx9WlPXtqn5WRpJxxHKsIOtPkFZH10szaEYK46OJn3dYhqoy7DcLMFrMKhZnrfyndG7DUSh1P9e9BQ7mm2+Swyr6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943797; c=relaxed/simple;
	bh=dr45XjTQ8FHb7CPbxsL5rHjPqCMMvoo4rwFxQtyYNz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxRXyewobxjZ1EUn4tzujZQybgG75cJKnuvmpxIDK9SX7+ZJoUtWGlw4YlNu8GUbOtr6f6TpCAEggZOlLeE5gZmK6q7tg38Mmk9uMMqPMinQLzDGAhNk1ag6h+p4tjtGdbeuhyclFl2A7lA7gikb8tKhTmzw1Mnge+L2ReFAL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a868d7f92feso89090166b.2;
        Thu, 29 Aug 2024 08:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943794; x=1725548594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/boQQ5nSp0lspsyalK+l9WbjfJD/McCNrO/o7qkR35I=;
        b=AZJxQlyidqo4xs2iPb5V1mnuwYypWTq+Zac7VeceXtkVhYHLbygp4UOplebwhkBoFB
         UuHaqyrUKN4PVum1hkix7TieWOgoU58EaY4tgJqQ85Bz/NTI73OBhXhjoHztwy67ckXH
         DN93l8RPi+i4FGJJF3yFvG5NDZNMEk8qNn0QHn/l5xb+9L8RUN2zzDGoHJrtuYhU85yg
         9c/Z2c/FTu45VQQ32TkL9rISHEB7gDV5MxMiiqX/PX5ibt6eSSMoXlSBH2qpEinxmlMG
         lfx7pMf3sVevkRfl7xaQ24NzpN1/XYi7ftjXX4PuAFc8ipztfwNFCjXwE/Pce0uKcVEp
         nNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5CAq2RmGA+k6Wh+7udqMgW7Mc6b6HMYC/IBC3D1pr97Vn/9DEaZuAbWTboyJMeWQ8elJ3DftLRGJ5LgocJaXD@vger.kernel.org, AJvYcCWEj/uzlwf3r4NqRcneUDFzoohH/Oju544VHTi+h6LaBYCACqWudCxmBuQadDaJxiwcaFXvul4EhZq0cH0=@vger.kernel.org, AJvYcCX42xvS9DnereH/W8ETpYWoPODnV4vuq/fFP+wAQtKTFYXO1ocQsHDYXaI28q499s+XBPI3ysFw@vger.kernel.org, AJvYcCXMvpk5QMIM5dAvY5y0w4Ldf/zhRLd/yZ0eqT2YzwI0zS4dzKH42utl+Q568MLeT4VDBWnedKD3Ff0ydI/V8fzp@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxlJ4a3HqAXJAZBodddxW/phjU7RkV7ublqafiwGTdtBryWpv
	6m9CWx+lFhFCrOtikiZ5EOs8OteYno584KQaa14TwiycyMdbEUg/
X-Google-Smtp-Source: AGHT+IGX0vjuiRrrF7Q4njAuRfTDg0gEtXtmJJt2CXIg/Fo8ez2WU8vK5t79ZjAVn5JzsszqFoh+Hw==
X-Received: by 2002:a17:906:7308:b0:a7d:3cf6:48d1 with SMTP id a640c23a62f3a-a897f8d50a3mr254539366b.32.1724943791598;
        Thu, 29 Aug 2024 08:03:11 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a2a6sm792032a12.7.2024.08.29.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:03:11 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:03:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	rbc@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <ZtCNrKwfPx6dhORU@gmail.com>
References: <20240827145242.3094777-1-leitao@debian.org>
 <20240827145242.3094777-2-leitao@debian.org>
 <20240828074240.2abaa74c@kernel.org>
 <Zs88pbEadxLWLLbn@gmail.com>
 <20240828114123.3c85a9a5@kernel.org>
 <ZtBIgekUyptmCqRa@gmail.com>
 <20240829075303.775fce1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829075303.775fce1d@kernel.org>

On Thu, Aug 29, 2024 at 07:53:03AM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 03:08:01 -0700 Breno Leitao wrote:
> > > There are various configs in the tree. Grep for the configs you convert
> > > from select to depends on, they will all need updating.  
> > 
> > I am looking at all files that depend on these Kconfig options, and
> > there are a lot of tests.
> > 
> > Thinking more about the problem, it doesn't seem to be a good idea to
> > change dependency from all NF modules to NF_IPTABLES_LEGACY. In other
> > words, the `s/selects/depends on/` is the part that is causing all this
> > hassle, and it seems unnecessary.
> > 
> > That said, I would suggest we do not change the dependency, and keep the
> > "select NF_IPTABLES_LEGACY", and keep NF_IPTABLES_LEGACY user selectable.
> 
> Good idea, sounds much simpler!

Thanks, I will submit the patch soon.
--breno

