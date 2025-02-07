Return-Path: <linux-kselftest+bounces-26022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394AFA2CBA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41B87A6508
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12F1B0F19;
	Fri,  7 Feb 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IXSXmcek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE121B0438
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953676; cv=none; b=kPi0JD/7PfBl2TyNaj4eaDON9TS+9guvNbPaCjDennsNNHWwZYb4Aki44VsT0RiLoBGVlOcM8ThR8FsCl5fSqgua2X2z0Gm3MHta3CX8/D/8NPazGqtIXNGn0usJ+YWunLaay0rd0Iy+YmqR0w++4Dx7I3r6GctHjv6XD+iW9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953676; c=relaxed/simple;
	bh=oco0Lqf/fb+pkzZei0VqH/EhA1GrCF6qBt/94yWHles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+rMbYbnihTa/5DDpqokAFlsHWpXSQX6IdSeKUMRYNBaEv2/fnyTLDSOThdMRmj1LZqEqig9lj0BplZhSgdbOj8XHkWVpqXdbWKQI345ipQUcDoUsZ2WgjpZZSZbccVBCRy+k/oE/5cXL8qtZifagwMVnmHOr4v6j8DyYKq1LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IXSXmcek; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so348650a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738953674; x=1739558474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX6bgDb7LMFYhcZSyq50FIVZrkoehDFKY62VUhrMl80=;
        b=IXSXmcekg4S4dCIjTAIHWjK5tmEsQi998IJ9+5Mzl0510nZO8PZ/IrWcxOx7uJkcZh
         g9mAyrxnzAyynH/vpp+9wXq1FM6AQdZMKm04IYahf4x/5NGc9POTuGK+uDijGbZOWZix
         CfS0felIAcy03J5PJEpxgs89WCWuEkT+0lV/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953674; x=1739558474;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX6bgDb7LMFYhcZSyq50FIVZrkoehDFKY62VUhrMl80=;
        b=hvXfQyoz3vAYmP7VX7DdW+BzhWeP2vtWDWOufidcm6qxRnVGAFpt4xsRnDKSmDNvEm
         p8xjkALWVgWHBFJP/hJSwX2ZoGztPHJoGn1Q0BlS1c/MIQw9+1tzoxRtHaz9tgYOdBFw
         tHGh89ovJRp3aGqo0Q3EBOE+NQ4uk7dMEWvvP9tJAt2Q+EcsG3u4piE1BwN/jfIS3TVy
         lfxs5fTRnPIXWVl+pBbrU31s86k9cWKSJtkjt/C/+CCMuA5OqBp9y36pAL6TR+UoZSTH
         ezUVaq+7E81tuRumvonDSOKNeIXj/hboTuqYp0cbjILOWZ4ITI6aczzdzolkGoH8OU49
         hfLw==
X-Forwarded-Encrypted: i=1; AJvYcCWrhp5ewowlIAqMNSr+HFIuBuEX9jjv1oZgMLHUsWJ+jlCKGB1vFH6ZCJKAtjSdfD9Vc6NgdZT2XBmfbu3QEFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM85ZM37kUf0vTb4TF55867m6XpIxbD5fkRqbzHh0IMO3Rttqi
	zXJrb91Lx3bVNhjsp/RDdTV83Qg1kQ4/i5aOJ21oB6Gk1IFKkFbBti+yyt6Rx8Y=
X-Gm-Gg: ASbGncul/wEs9n0Mh92NaGr5crjV0DKB3y794udTiTNSq/KCdUC33fLwcQMC5Em7och
	okOuwHjj5VjEl0DeKLJCUG9QblehwQcRKQXTPN8/3UMDsL+wCHeMlHnyZpi2sjH/WMEvnHE3yun
	gU/XxNYJX+gGu2RGytvmcSJMuKQcTCY/q3ANuBCDK3F5wU4F52sIa31EU02x+oV+6tFIJPg0vqq
	3O1mkNuAf9wswruc6Eg43gwjj82EKETtbX9a56Gy55Ivx3XRSWhYjYGPwORifxxhpY8Fn1t2eih
	CuWK/yMtOGrgvE0GO0UB3SFR+BaREA0G3kMHrviiNoHcY6CM9EY50bPC6w==
X-Google-Smtp-Source: AGHT+IGxLV+iaxkN+MqLINKOhTitdwb1FvV0w5srDzBYBBMluFope5BhU1ALTENRSG9snyb4tqVknA==
X-Received: by 2002:a05:6a00:1d25:b0:727:64c8:2c44 with SMTP id d2e1a72fcca58-7305d4ec73emr6979465b3a.19.1738953674036;
        Fri, 07 Feb 2025 10:41:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecd813sm2948474a12.26.2025.02.07.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:41:13 -0800 (PST)
Date: Fri, 7 Feb 2025 10:41:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, almasrymina@google.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: remove an unnecessary
 libmnl include
Message-ID: <Z6ZTxyDzzK4OQmyZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	almasrymina@google.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
References: <20250207183119.1721424-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207183119.1721424-1-kuba@kernel.org>

On Fri, Feb 07, 2025 at 10:31:19AM -0800, Jakub Kicinski wrote:
> ncdevmem doesn't need libmnl, remove the unnecessary include.
> 
> Since YNL doesn't depend on libmnl either, any more, it's actually
> possible to build selftests without having libmnl installed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: almasrymina@google.com
> CC: sdf@fomichev.me
> CC: jdamato@fastly.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

