Return-Path: <linux-kselftest+bounces-22886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7279E5EBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 20:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A2716C03C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005D22D4D9;
	Thu,  5 Dec 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWG5Ftnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E582C60;
	Thu,  5 Dec 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426738; cv=none; b=eCgqlfKSiQ7+ttQ447n+LbrWgwM08QXNRPA4t6eVf3fSUJHWFE2yxEFJrP2SJrtV7ye2yw2B0zgYn+sap9dUXBAHh6Oi6XBH9mR/A6ozuYstHNXChoxdY6hlGcrt4klIj5o4tnSdKDX294UfaPhhL4Rwc8MxqGsOXDwUc7EoJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426738; c=relaxed/simple;
	bh=lzRObk1OQda7uwxIVMTX2lnVJNKKZqxd7bc76bx7fwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np7DK+yWuLkdQGecoGoTc3wzItkafztoP2w8YOTYMzIVAyLfkRKLzhbQ+HsoSLOhBzwSRwfhbjp4aAS65ucAF4oxjwSA2HDwu1lleY4CecKJFKH99PLDf0LlR1NVoxKA5ZnOWPAcbRn3W0vHIyqTbQmrfbBqtP6eS4tiMlV8VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWG5Ftnz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215c54e5f24so12124245ad.2;
        Thu, 05 Dec 2024 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733426736; x=1734031536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9jjQW8IdRZWXe/1Rghl+cVLFwOuY8dBG/5fqWQmio8=;
        b=HWG5FtnzKePLGWU5vl5gwIqaCBw+zz540iZrjCC9Sq8XeqnwZ1gkk+mfTExIbevMMV
         WvaDOcvxr96GnFXQZHTne8dFhmuvcwcPTu0E+MYEqY8Opqdc7hgB+Xfp/FMCxg94NSL0
         kysKj9C6sD4wWfK8O5/WeV6zZMZrsDPsFY533sKIMlXHQBc8IY5eGtpXmI7674N3SpY4
         1x/4M/KSkXBcAz9LfZxS74Ksqa6x2WhlMm4xWzMNc/Pw4Zt3C2eQHrMJ2GUsYbXrUvlY
         RNo76Vk73yYkZX4wAP4ONWqCqPxOjYwArASK0AhCgNdRpxZ9RQM1tl6sMYc+TjNcWnq7
         mzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426736; x=1734031536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9jjQW8IdRZWXe/1Rghl+cVLFwOuY8dBG/5fqWQmio8=;
        b=IXSn4GlDPP3fd7t3yzj7PkjqpVc9X7LbyJwStWe7mVFT2EgRVXbr4X32Qnwc8QsRBT
         yZlpe5CIgJaB6QOkfNbuSg0Etg2q6LQ9nDUg7UU2oSL5PO2GyP98j2+4FL05OTlCnXHW
         8LQ0sBg+m5uZtsu6XPGXxQZMuP4iXH9JAsFo3AZsBfPi6IYig6iXwwkJ0WmWe7P3clQc
         sVrgqmLhjVz5PiKmGfC42S3ZjJtYDDxe9Q7BNaiWrt8ASkbWwZiWH9fO+9pzekoX+Ggq
         +oY9C0mIW0bt6eLaYt7fsNK62yx5pvWAByBw1w5jRFazWiVMOqi4k+DjGbgYSoC+YniQ
         vfsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWwfdw9I4Rf+y3Zoj2wKA8W2xZaRoUqbHUvgUhF0y8zt85zdOUKsAM4ZSzQvTGhInJOZAHhiqcJXNSSvsnxWCn@vger.kernel.org, AJvYcCUkNvyca9M71vqd9MDDIfa4AM3e74TxB4ozzqU+nupCJmeKb/UsJxQdt7uOGmPXRdbpAi8=@vger.kernel.org, AJvYcCV+bwuslJ7yBbVFId3PkPsFH6vJyU5pFWiV8MGJku0UwsPOs8i9rSzMlnxvY9Ihyhd5qHlnJMGj@vger.kernel.org, AJvYcCWNR5h/Vr5Yq2DU2IqBiNH7VmcRWc1jcDxZ5qQMI/mfcOs7dBonFCmju2s21uUx6i74xmN9FMimRCgEaTy6@vger.kernel.org
X-Gm-Message-State: AOJu0YxSs0mChE6Mr9UK77ud2T/VWXaMBZioL8X0wPYAyMBuOfmHNT7C
	it/Pwi2IT969jI+S8ETdFpJeCQJt3f0UUwkeugGR6v+tZlVJ+YE=
X-Gm-Gg: ASbGncvGlGPgwTfQD9S4B+gVXapo1RuMRiAL+PadMA2TpAoqjUfevOh6MrsQ1dFtTbu
	GSd5+816giNz6q8eEmP46j1NnXYFkzff/8NrZgi1K8YMFJFW4adS8sv4+XMc31kLPRPWJloYbOX
	xXmjk5ZiAaKpLsLnhRkgCo7pr3xToMyf4ZFyZWaneqhgw+2aNmxcSo4qzUdOkov4Z/32r6DKWCw
	lU+lAmoHRuwJ2OMqk2aCUWz2KhKRGNZgaHB9blo10bCKBJnqw==
X-Google-Smtp-Source: AGHT+IEPVDXET7pdSwy1/WJhUkp6RadfluLFGLOsExuVjvgUir+tZD5xuakR6jagV/Zw7Ox1Fdi4JQ==
X-Received: by 2002:a17:902:cecc:b0:215:b468:1a33 with SMTP id d9443c01a7336-21614d1ed2fmr924575ad.4.1733426736147;
        Thu, 05 Dec 2024 11:25:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9485sm15926125ad.157.2024.12.05.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:25:35 -0800 (PST)
Date: Thu, 5 Dec 2024 11:25:35 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: Enable Tx hwtstamp in
 xdp_hw_metadata
Message-ID: <Z1H-L3BkxnjVr5Qy@mini-arch>
References: <20241204115715.3148412-1-yoong.siang.song@intel.com>
 <Z1B50w1jzHFt-LuA@mini-arch>
 <PH0PR11MB58309455A6E72493687D0515D8302@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58309455A6E72493687D0515D8302@PH0PR11MB5830.namprd11.prod.outlook.com>

On 12/05, Song, Yoong Siang wrote:
> On Wednesday, December 4, 2024 11:49 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >On 12/04, Song Yoong Siang wrote:
> >> Set tx_type to HWTSTAMP_TX_ON to enable hardware timestamping for all
> >> outgoing packets.
> >>
> >> Besides, set XDP_UMEM_TX_METADATA_LEN flag to reserve tx_metadata_len bytes
> >> of per-chunk metadata.
> >
> >XDP_UMEM_TX_METADATA_LEN is missing after d5e726d9143c ("xsk: Require
> >XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len"), so that make
> >sense. Maybe add a fixes tag?
> >
> 
> Sure. I will add the fixes tag and submit with "PATCH bpf" prefix
> in next version.
> 
> >And I don't see mlx5 looking at HWTSTAMP_TX anywhere in the drivers,
> >so I'm assuming that's why I didn't need HWTSTAMP_TX_ON during my tests..
> >Which device are you testing against? I do see some hwts_tx_en
> >checks in the stfmmac at least... Can you add these details to the
> >commit message and respin?
> >
> 
> I am testing on stmmac and igc drivers.
> You are right, stmmac needs it for hwts_tx_en check.
> Besides, igc needs it to set IGC_RING_FLAG_TX_HWTSTAMP flag.
> 
> Without this patch, user will need to manually enable tx hwts using
> command: sudo hwstamp_ctl -i eth0 -t 1 -r 1
> after start xdp_hw_metadata.
> 
> Therefore, adding HWTSTAMP_TX_ON is not a bug fix solution.
> I will separate this as another new patch to "PATCH bpf-next"
> and provide detail in commit message.
> 
> Btw, is mlx5 driver always enable Tx HWTS?

I don't remember doing anything special to enable it. And looking at
the code I also don't see any conditionals on HWTSTAMP_TX_ON.

