Return-Path: <linux-kselftest+bounces-32524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7506AACCDF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5543BDF89
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86F2857FD;
	Tue,  6 May 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5YkwNDJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0A54739;
	Tue,  6 May 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555235; cv=none; b=ioSJoOu/xetERwOgx1g3p1y21aKt3OevxFVW9k19tzxVK/ijcY70DDLOKN8X4hlFQbMgDp4BX1c0bEMaOblC+9YHgwvgp3MgZ9eTB7BbVCuwmmh+Klo46I9DFo/uLQXFyVcSp8fKxqgO3IT6Y0r7inrl8n5uQTmzIbrg3U8DD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555235; c=relaxed/simple;
	bh=3volgLCmuZoDMz4OH8QV34QZgJEt6k7MmgJw5oIOJlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK9BL9PZAKALp8WGqy+jMKO/th5sHNG0AQzuC9Om0Sa3ulN2e4sUiW7dRt8cn1a+7H/hzvaX9aNZncyG+OjBeO63f/LAeEIWPU/Y22sbpwLaOQwXemS1BW6sU7e8RhQPozP+AiMlWS/KDE4KeOlaud/OdpsijSQI25pUO/niF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5YkwNDJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so69516235ad.2;
        Tue, 06 May 2025 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746555232; x=1747160032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVLaLzwoqkfef/86QPa8ovNCi2iMqUB8a+W7JzBtWhI=;
        b=l5YkwNDJ0A25c/fh9BnV2afi2GJWVHOER/gUaFiD6SSlu+x7jEJ1kEl2kMyRv4DTFt
         r1dCKcPWBrve36RIIcWbYFuKhyHqiUpTWpJj53ffJK1B1S+AzgcxKYY9MUo1NX7I9uVv
         9ZoRZj8+64LPz4zqn3HmWq6SkUC2Fakt2TuHU2WjnhYvpLRSTXNPEE4jTaLFuL2IVez7
         F10uzxcPjvwLBfWExgb9W0aElCvjESCwk/n/gMHdEoMSB8N8IwK6d+PDcKStFUahJVBv
         KMCRpyZkieLpx9ZqEBbhw0HHRg6PXDP0983DZKVjmPseldEs3nOC73gbwep9ATsMLnI6
         d9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746555232; x=1747160032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVLaLzwoqkfef/86QPa8ovNCi2iMqUB8a+W7JzBtWhI=;
        b=EkFMCJpqySbjZZLSZOZJCOVNUtqIFTbgkMK+gjYUUSdoFchQgk3iGBciRg6XHn/KwJ
         tbM42CFXEZTpFecfSq8pYWM4nrUrZtmP17hRPjHU3RaZC8ONNg6Cm7XrroUFuWOYLSl6
         RRSPnfOEsKopCW0G/j3KtuQjVocW/5/1B+kg2phdH62UdcbhXmr8sphlLTdQ94mG6AkY
         jUEVvBowW0lzECRcwai1w/EKe1oPadDXlaeCpnB/36oX8PLMUYL/ZubvOMqlGVp5VSbb
         LqrEzvKHGxFaMOnIjqJXwgacDqRKK7W2N/2HwOJblC9/JNQ6k4MM7QH6f7lpNv8ahH0n
         +WPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkxS1dsjmSX7RLkmr8ofpaw0NNMDRXMuEI007+J4fFeag5yVN7YRiDJM05uj/mcQp139noJQy@vger.kernel.org, AJvYcCUWjJo/CJvRPNzWnC37CUooR3b3XeQoKqVGKhV3uZW6kZT7+5lkGhJkckb1YY9PECh0Pe8o+eoXVn9C8NpmUkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMd7O7jUUn4KTCxfWOo5DFjKyWBnLNqbBiKGRtvTg5ip9Y9ZS
	5B7ACE5YDaXTzO5cbWgwkAAGwnUuudrxsnLGRDhJLELk9qs48E2Q1UAEFHE=
X-Gm-Gg: ASbGncshG3XUDDQ5VlB7T8eqWvoDGFqjKtpRzCAtbgsG7rE6+nc92bPL1AOvunRboqm
	hrNQSDkw20dHKmglZyf0K6EiGxwzhuiEE1h5PuNdveLedloBZGAnJjlP9AylMWN7b79bqwD5lw9
	WfS+5YQ4DqJLlzxXi2HVsRki81T/1lH9oMulY3TCPG5OjZVQPdgY/V/DCtusjEHGu5dVpxkPTVy
	UKA7PL/3tg/6wBG8hbrXHycZj898xvQTDRM9zmDxVgq3DVZMJofRcIT//7x1xUjQFf2Ci/Tblfv
	6MWChFy1EqHnF1hjRX17zwmST2cHT1zZn/OYzYVSR+AT+oJM4Qp9lJwk2rnDJpqj2Qj5D2b4V8M
	=
X-Google-Smtp-Source: AGHT+IHQiKS9aCUJ2cD9oZ0bzD4eDVVvzAWHlFkUm9Wat6qsbv5uHgKLENS0E0j6EcKV1ukTzM3xwA==
X-Received: by 2002:a17:903:990:b0:22e:39f8:61fa with SMTP id d9443c01a7336-22e5ece3f6emr3221945ad.34.1746555232252;
        Tue, 06 May 2025 11:13:52 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e15228a1asm77220195ad.173.2025.05.06.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:13:51 -0700 (PDT)
Date: Tue, 6 May 2025 11:13:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Message-ID: <aBpRX_afG5X_rT_J@mini-arch>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
 <aBpC9_SgUaAA2P0f@mini-arch>
 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>

On 05/06, Cosmin Ratiu wrote:
> On Tue, 2025-05-06 at 10:12 -0700, Stanislav Fomichev wrote:
> > On 05/06, Cosmin Ratiu wrote:
> > > __netdev_update_features() expects the netdevice to be ops-locked,
> > > but
> > > it gets called recursively on the lower level netdevices to sync
> > > their
> > > features, and nothing locks those.
> > > 
> > > This commit fixes that, with the assumption that it shouldn't be
> > > possible
> > > for both higher-level and lover-level netdevices to require the
> > > instance
> > > lock, because that would lead to lock dependency warnings.
> > > 
> > > Without this, playing with higher level (e.g. vxlan) netdevices on
> > > top
> > > of netdevices with instance locking enabled can run into issues:
> > 
> > Mentioning vxlan is a bit confusing here; it shouldn't let you flip
> > lro (I
> > think). Which upper are you testing against?
> 
> It is vxlan, but LRO is just a red herring in this case, 
> mlx5e_set_features calls every feature handler in turn, and this is
> just the example I picked from the sea of stack traces.
> 
> > 
> > Trying to understand if we can cover this case in the selftests.
> > netdevsim also doesn't expose F_LRO feature... (yet?)
> 
> I see you found a way with teaming, but I think in essence a sequence
> of commands that makes __netdev_update_features call itself recursively
> once on the lower dev will trigger the netdev_ops_assert_locked on the
> lower dev.

Right, but netdev_sync_lower_features calls lower's __netdev_update_features
only for NETIF_F_UPPER_DISABLES. So it doesn't propagate all features,
only LRO AFAICT.

