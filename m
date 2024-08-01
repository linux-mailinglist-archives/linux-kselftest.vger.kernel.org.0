Return-Path: <linux-kselftest+bounces-14596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E489440A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 04:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F482827C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 02:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4714AD29;
	Thu,  1 Aug 2024 01:23:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AC14A615;
	Thu,  1 Aug 2024 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475438; cv=none; b=ggX2XcMtVeKoVwuAH4HHDSeW9Z33cKwdrxagXkJxcCsuJGOzvz3c6V9QaCO3TTPmEhSTrxfc7IGcCUKt7SqIXVde5/nCwK0r4zuaWPJTQ9mk16K8q3bGBwp+4Yd2HmiLtnFPFuIxahoTa3mrQ2QmuKtT81XK+SXIEQK/yDgJAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475438; c=relaxed/simple;
	bh=7gKNExuJaLbKHqudrhoMB30SU3z2Hfw0CoP3Fh1sNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0qXmXTScSLnfQW+tNFHp/jzsxXpbb2mhgV2FF9clg3UuRm9VtzKMH++Ls9ut7KWhA7s/DoK8Oga0E+UsWz70dQp7qwbaU4uF94Q93YDLKE4wKe6HlGb5INgXeaMA00j/9tw/vM3U+BNzQu8164ALnoufrZQTZD3vWt2H2p4c6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso4719572b3a.0;
        Wed, 31 Jul 2024 18:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722475435; x=1723080235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8i9GP7nhcFbKM690bSVhwjZ922fix8UAoNWE6DVUwo=;
        b=sQ/pWnoHXwLT1/pSXVvGKRZeO7G0Y7GtU0j5HEULcAyF3zmgYmimw76rJI2/yLC9Gh
         Gfgl2fU3L+tbleKmc5bHosomMOdRvM6BfxXrQ+UJsdiL19UbrasF+u5JgJVmCvj6WkJH
         DSC8CU2Nb2n0UDQbkjF5FDBVvJYfiEXntUlf8Z8LgGxLAMDQtgV1wZTH+EaiMD+/K8Mj
         iJIzwrZn7skBfEGKHl8wMUpB7zWwg8OVNXHUtfiwv+TEWd0nG2SdsCXei3Brzmmje2xj
         p2vJ97X6SWnOXOXPp1108S6ayQMYghxbj9Ms+nSJAJCGZQogqkHcT9TMDb2fGm6xN5jY
         RcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgmDrw5eVZwQvBakHPUaoulegQaNID0Ex0qldiNfTcycMNMq4yODWLvzBXNe+c6KTpDMI/uDgdM9L7dk8T0G/IgLijPzybabMPr1SDLzNwVdQMUHfxlp9xZ6ppMMrnBUjqlz4xVvL2
X-Gm-Message-State: AOJu0Yyf62uMs9kX7NsjyAJgMMYuFAATTaIKq0lcQjKSNqmy5fIus79h
	n+mIjBAAtuRtR5Bk7jHV6jxtWUsOv8HvgHHLtlVUHsE+IwOdB20=
X-Google-Smtp-Source: AGHT+IEcXnLHBRC17MZ5D9MdnU0NytnyFeyo6X87DLLoWtY+0waRql4ttVvJfAZenZEYXie0ivaFiQ==
X-Received: by 2002:a05:6a00:188d:b0:70d:311b:8569 with SMTP id d2e1a72fcca58-7105d7da884mr1309849b3a.26.1722475435318;
        Wed, 31 Jul 2024 18:23:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81234dsm10540631b3a.115.2024.07.31.18.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:23:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:23:54 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue stats
 when the device is down
Message-ID: <ZqrjqpKJRgMhlvr2@mini-arch>
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <87cymt7pmu.fsf@nvidia.com>
 <20240731173245.2968988d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731173245.2968988d@kernel.org>

On 07/31, Jakub Kicinski wrote:
> On Wed, 31 Jul 2024 13:34:58 +0200 Petr Machata wrote:
> > > +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> > > +    except NlError as e:
> > > +        if e.error == 95:  
> > 
> > Could you do this as if e.error == errno.ENOTSUP?
> 
> just to be clear EOPNOTSUPP ..

That might be the reason it's coded explicitly as 95? :-D

