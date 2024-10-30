Return-Path: <linux-kselftest+bounces-21063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7ED9B5869
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AA728646A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB5D2FF;
	Wed, 30 Oct 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTF2lMJU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D24414;
	Wed, 30 Oct 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247310; cv=none; b=TRySUcVD34r89RWI+itI0mBsBoSyeLD/ZxHAO9niFXFbfjhKWAPCchCgG9u2f3CYc4aeoIVTVMPZPdR0frk61suTYHqq2QD7iand/p3R1hnBvKd4QZR1vsf8+0jppcRTqH8tTIby5L9rc2zyLyJAt9Lf0XP/HcAe5o1n9HAhIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247310; c=relaxed/simple;
	bh=0+e7ilh8HymKKigTxSdlsR8wtsFtEe/lAPy+9W9Bhl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNrwkfvwBOV+67ZGDXhaA1eKPR9qnJU3fM4h+kugAy/e1yllpf9k0p5FCRnA2aSEJcnln7uxLRgV83BVi1FDD1HPMsh1UREG5lZPlnUyfXtcVMVyIqvkwR9jqQ6/wzWB5zkinrklfIbFYpDDF3WKEUnzTnoyvBIQbEoUcPC3CHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTF2lMJU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ce65c8e13so54948105ad.1;
        Tue, 29 Oct 2024 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247307; x=1730852107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XsWA5tWFIFPnRxk22c3AL5Wt7lgDsltigBwEQmWd6jg=;
        b=OTF2lMJUTmXvydgr8ppbz+sYfwOPbcVpNh6411LHYuS8DM1QRN9qDGmy282RvaKXS9
         u4kKw+fAWBlKgmzllnIutV0so1+Xlt+CxGJRdo6rtta8qIJZ4o1Hvmbu78xqo67yuAwF
         XEBR3lNbbQ5O6X+4E959GlgWvSmu4PKbv9gfWCBipuePqnmvJU45j1awbTUfIx0Ah6yQ
         WylyWBD93x/G9BV7gYKeC4VUZH/MTBLIjWDQnNMzJ09kvROe7xVBcEY//VwIpsf1tBWi
         FaloHYZ3ef4OROmq0Mv+vZuHOIQI8LRfM0UnNQPZMu/1LemhPNNP3CNeIrbNn0RPQChx
         pJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247307; x=1730852107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsWA5tWFIFPnRxk22c3AL5Wt7lgDsltigBwEQmWd6jg=;
        b=D6qijlMAXLP3DDOg2uu1DD6axNDnKqsQhahSqVJpyQ7FaRPbHRA5lt6/XNk9+1Wdz6
         CiDDy+V6XbEjPf/RtO+0v6zJnQM8wkrbhNlIHBhQazITggtGOrsA905lIx3Rl/0gYgWW
         /2FMVH+RjoT6KZUyK8LyQJRcUg543GkBEJ+DUiXiDxgp1M2xQiIYLKU3UHBll2LX7tUA
         a+PnLGHKiiQKR0PEqwb1d39dWe3+3cJaFVmP9U64dC6xQtV8ViAKxq09OW8MqulUXDrQ
         zjQoFRM5kbHo2+mwyA2k08+90nxYCInXAWmabIe4Lg12uOolVXifkzwZSfv0KP2kpu/4
         DlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIGlwvXL1CQQm1tvRQRwDNmXyupZJuwzugAPeUuYG+yOvu6eNJQl+0KhSNwOeCSVM/6lDNhIQ9TxL2HlYp7n0+@vger.kernel.org, AJvYcCW1eqtYvco+ZFWNDI7ztAWAEuAFRyNWGIzktNu8y9wvEVo/RozKFapNdWhw8mOiVe76YY5hk2om/T3rRhw=@vger.kernel.org, AJvYcCXYSTicC/OXaiFk0BxCK4wWrUfLVmsD2h4sSJSC8a+S8ASck+dt70km5mgk/JYhXbMpPzWq593a@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhSCqRRd3MsR2bRKw5MQMNGOC0LSFD2gMd20YuTOXg2lxrcmv
	LmaNLvpVPR8vXZE0zdeRUcXaDM2Btui6VrgFGn03R81SL3ZTxxk=
X-Google-Smtp-Source: AGHT+IEsXPNkvxEY4JaeJrSlHWnv5ERgiC0VPIenAWzH8vrp8VuRuP8CeAIBDbJHOE/IEtGXqi/iWQ==
X-Received: by 2002:a17:903:2451:b0:20c:7898:a8f5 with SMTP id d9443c01a7336-210c6c3f55emr147046435ad.28.1730247307510;
        Tue, 29 Oct 2024 17:15:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013681sm71183855ad.129.2024.10.29.17.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:15:07 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:15:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch, shuah@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v5 03/12] selftests: ncdevmem: Unify error
 handling
Message-ID: <ZyF6iggvCbr32TOv@mini-arch>
References: <20241023154402.441510-1-sdf@fomichev.me>
 <20241023154402.441510-4-sdf@fomichev.me>
 <20241029170129.75e29323@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029170129.75e29323@kernel.org>

On 10/29, Jakub Kicinski wrote:
> On Wed, 23 Oct 2024 08:43:53 -0700 Stanislav Fomichev wrote:
> >  	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
> > -	if (socket < 0)
> > -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +	if (ret < 0)
> > +		error(1, pton, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> 
> Looks like sched_ext broke our build_tools check, I think I pushed a
> fix, but I also see here:
> 
> ncdevmem.c: In function ‘do_server’:
> ncdevmem.c:343:26: error: ‘pton’ undeclared (first use in this function)
>   343 |                 error(1, pton, "%s: [FAIL, create socket]\n", TEST_PREFIX);
>       |                          ^~~~
> -- 
> pw-bot: cr

Oh, thanks, will double check. This looks silly.

