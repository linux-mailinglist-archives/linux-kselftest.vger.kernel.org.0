Return-Path: <linux-kselftest+bounces-35636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3BFAE4C0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA21899AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB732D131A;
	Mon, 23 Jun 2025 17:44:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B629DB7F;
	Mon, 23 Jun 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700660; cv=none; b=Tox6V+4rluxr8Yuowu/ojGd5yDnbu2eIA1w0d90mvko/D2Ywrg8YvB6cbaoMbayVCh/wcBtEFU9LweGyHbEzr3KBeAL/gDSv+hsNS6ul0+k0/C0mDIfZw0wB3PdQT3Iojg7vf8h5gr4O1DoMO7yvs2yEafvpxgp8av2bvoY42Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700660; c=relaxed/simple;
	bh=eqbDTrNhH3Ga5rADjLewtUZYnOWnOhT3LTzWBlmBxrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMTBH/P0vLuE9MUV87sE1AWCGWHDqcrrxq7wAOtnPULr3HNRMUAWkB4mfy9+S9Ct+TKU4HmTbM804dcL4mRwGoW+l7fPbIMOzvXPCZ0dwXrSkeLdo4Qukn4ucDReliqSX2FrViwh12HHL3k0IayFPR62O6ZlLt6QB5YGY3sjF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2bb25105so718038666b.0;
        Mon, 23 Jun 2025 10:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750700656; x=1751305456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4bRP/S+Db6Of6rqVkIwesLZbL31FryAowDrp1i0DpY=;
        b=g+IiTNdv3HIfx1KGkyk611qNqQmaEdlqR31MQc1KmeD8XACdGeBM4KNEqozQcei/gi
         7izRpH/UrZhnheipW9lXflXV3ZFfl+SXdoaOsWWP0tspLYcjpRkKDa6LyFV9E09NCDlG
         c9KojJChOu+Tnuv+prDemNIFA2hvTswbNoUuknXIqy2++gALkYt7a4DNGd8kF6hQIUiH
         IK/fS1/KwC1YKeTcV6ou7TKVBEY5YFKIBhuXb4oMSnkLm2eeuRdWOLl19CtmVbNDwmoZ
         TUBim9we9iwyicjejngLeEUOEAYgjRY5ewD5IjDVRZhCfD+VRmPwSh/6dVRSr99G3HuB
         Jrpw==
X-Forwarded-Encrypted: i=1; AJvYcCUzEEV+z1o85/YO991ZK6I4c/I8euh3mfdhe7AVl8OEok4TvhspUp59B+RZqLy91MveoqcoOEW/@vger.kernel.org, AJvYcCXCFEGJVzoeF20ri2bDfmZaw6mQPt5E/vYO5tKbKMLOCYtpf8IPglfXKB5oXu26a7VHiUeX2Rqu626Vsac/f4Mw@vger.kernel.org, AJvYcCXkDcozP3nvm+76hlb4qf7dY2vbTwAld2ztRnsH1IJBsMPBu1SpaxTxbJxprFRjSyWdc3e7ntgRty6wvvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICUD8wkZQJSpGVzWMiYjcCmWrHowfuyCabuvAdN6vers/Sjgc
	MV58DBHACXh3DVgzYhnIJVq0Uc8GZm4NjcOgAe7tx4DMUbbyCpkM09lV
X-Gm-Gg: ASbGncsKSQ/2uvBuzMQ9iBf+7nlfSaAjRaHA2gXctrJqSQb6wSVfEqKfkSO3gBEC1tn
	YOdgnfcN2LljDwuSRDx4Pa/tRpmgGDQnrrAqiI8Ch4ab0cJhyWt/2yY6npjmRK0vbNV6aJwm2Z0
	SbGblqb+r42/DMIxqJZAhiBqSzklBxp6yHjC3dfOalyJjy2lCzb6YdtSqhLZpVO/u0OWyRjFeCF
	+IhRSXJuJmCpNW01+tPXtE6qTOTtCsDLnF6aIVjJxaE4lMYUQHwFeqYGrwTQ5FmdFJZZss279ZI
	ir/9mKcfLx0t3Itzb1ggoLZ9WeAQoDDYLafFYQcCAxDyu1W0aQ==
X-Google-Smtp-Source: AGHT+IHpdykKZOI4uNQNMVDha2ql+/5GXIDEaG4Hfw81Ci9Lb2ieFQFFkixRC8msGY5j5rpL3VKMJw==
X-Received: by 2002:a17:906:6a26:b0:ad8:9b5d:2c1b with SMTP id a640c23a62f3a-ae057927b0emr1189262166b.9.1750700655578;
        Mon, 23 Jun 2025 10:44:15 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7443sm740954266b.133.2025.06.23.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:44:15 -0700 (PDT)
Date: Mon, 23 Jun 2025 10:44:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <aFmSbLaY0411BH+e@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
 <aEwd9oLRnxna97JK@gmail.com>
 <20250613174233.0dd5e7c1@kernel.org>
 <aFUeT8HSPYiDyALB@gmail.com>
 <20250621065121.78701641@kernel.org>
 <aFkbXFvOKeMALwBg@gmail.com>
 <20250623102903.3a58842d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623102903.3a58842d@kernel.org>

On Mon, Jun 23, 2025 at 10:29:03AM -0700, Jakub Kicinski wrote:
> On Mon, 23 Jun 2025 02:16:12 -0700 Breno Leitao wrote:
> > So, the selftest for netpoll is already in the mailing list[1], so, we
> > have two options, now:
> > 
> >   1) Steal your patch and make [1] depend on it.
> >   2) Merge the selftest [1] and, then, steal your patch by adding the
> >      bpftrace support in it.
> > 
> > What is your recommendation?
> 
> Let's see if [1] gets merged as is, if we need a v2 let's add the
> bpftrace patch?

Sounds like a plan.

Thanks!
--breno

