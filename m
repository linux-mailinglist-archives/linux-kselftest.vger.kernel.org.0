Return-Path: <linux-kselftest+bounces-27522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742DA44A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351461895463
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED2B1A23BA;
	Tue, 25 Feb 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKcrpguM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51BB19AA63;
	Tue, 25 Feb 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508004; cv=none; b=DBBvUUpnqyPOb5l1yBx8q5xqIJDjfrYf/FIPPR7jYUauf6beABzdO0OPxnR3L9+LvgX1aHoAoA0DYeJ+jWek2EwROCCfN3woHlrvDmJHEosBcWWQ4KFmvZUZ3gpu+zZTBYZ9CXSXA0LZucj9HC8H9254Y2x9VN4atnDUIuyuJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508004; c=relaxed/simple;
	bh=Cu9wG7ZBz95WikpGH7F6FGb1NfH0hS44wFnRTG8v2IQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ISe8RbGzlx5kzmsccG6KrwLJDjOzLpRk/SZTNGBzik3/WrqMyNM5swz8yJ/LmaPpzsB25SnmZFjMIZyJp1veaKVTahtjlRp2OdgCzj9S+3SGM/NmYYRvH29GJgekFMcQW43fvotf1ZfVcPHAyMfHrR/w3SHirePr9y1SqfqZpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKcrpguM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0893f9aa6so536213585a.1;
        Tue, 25 Feb 2025 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508001; x=1741112801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gDZQ9BD+kFiQmfLAnOLzXMn4KMvNYmUm2rUCj72UEY=;
        b=GKcrpguMMD+310ykZ5Ww4kbbHZvJ/KrMgKgQERf2BtgG9x4l/14NQS8oHH9ZJ90LjH
         rEhGHnj71Jorc1tzjOTAOEx5x14JZOyHCUdnBC8ByBn7QZD4Q9Z1Y88s9ZgQQagz4GHC
         2JXVLZJqC7+kdLky2Wh3B2ng9/ypElCUFtOIzlmVp8C4iUADdeLqFnEIJaqJux/xYopj
         ENJ90ZQ00jK981a4llc6puUXKHZATjA8d2D33GmmkpbfyTnGnc9UNgdPZVcHxMFZ7a2y
         80s+mVt0acCvXHC+fGUob8p5kOhFjgjenyTxJZvcAerLERW7qd1tD30/mBS4T3cXmQAF
         u8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508001; x=1741112801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gDZQ9BD+kFiQmfLAnOLzXMn4KMvNYmUm2rUCj72UEY=;
        b=J28JBqDykbLBbzjBxNaQMePJcMBbX173fZU+Ku9XGFjKQ4Ybc0PH3WgOFGMH7QN48+
         BKAaqbKGjzEKOu/+z54Fd9CFBtLewpNHNBRvLLQxpEPZTzol86/hE3tFKvF/I7SwDnzk
         MaHIsgmJDv/WbpIe3Jkpolui1xwPcSKnRADxyoFK9W3rGr/giaspU5/l5Z5wPLX7X8Ky
         26MudEkbpuAK2aGRc5VVE6z1WZWcTJVd5iD94Y1TAdrmlaU6MflPbVwtIx4UxCNjLC8/
         WWEctd23J1pn+gNkcMGntRfOzxFgFKfbmXJqNA/GASajlUlaEFMphCmtvyADJZ87svKb
         FSvg==
X-Forwarded-Encrypted: i=1; AJvYcCUSOaW/mrECTAPLR0touTQz4mGBh0hDzgXzGA4PA2nIMDKMxXIbqqipp6xDaEwwYVZrU42tWiCfCWE4jbXR@vger.kernel.org, AJvYcCUksNmQLBhuyoHG40bADrHPFdieD4VaiX61VEuOu8Ww6IHyOGFXx/XcDhQknmBRJPwbJRmrYKC1@vger.kernel.org, AJvYcCUtbNNuyybmNuxoGgbsH2E1PH6WJopeOx2P2tLRSYvBrfOGG+Yzw3uV6y2cjuRx4a5bR/M=@vger.kernel.org, AJvYcCXSwUC5NXf30qzTTbX9Jy6rTp0LvgUCw1sLpQbRYpOZYlKhd2MvUhZHBQt+yGpghHA4CArv6ZJZGrswVj7Sj5oI@vger.kernel.org
X-Gm-Message-State: AOJu0YyicsegMFSxlhRctqSJSV3bCk6ZwgqTc840zz0T6SaQ+YezlbJi
	tXdgTBIoaZ99D7JM/Vg9QTULvD22FrWfFS9tg7JXRMM9vjyWnt/n
X-Gm-Gg: ASbGncs8hyZME7reeoJLunRAtyz3ZeXSm889fRpDqqVSKz6yBhy1xkBhQilaKtHQsFB
	KvPMlTlYy9ci2eSRPzl6WZhBk7BVl6yUWdF1dMXgPeitJ5vTLaACdtFxhpQxtAJ213jx7mZ+74Q
	fS5j7tnBOBAkGJStEk2oeNH2tSoTt9IWJIxFF/Jt+xtZMaJGP8C8MMnIqE4/p4zqXmhCduuThfa
	rjWopIefnuwlm+k3oDArsMrFyN/dBa3w/iwbHhZN5DFJREqHx+2VDJlB6ix7Pu88MZOCQj9Lw3H
	BpVa4MnD/E9sTDkDuJJXJFQxvZs6lbQBOvhw/2iiCiUyNzsDuLNQ0WNy0niNvwBNsoNsNzaSuEr
	5jF0=
X-Google-Smtp-Source: AGHT+IG2L9+/QnRBY30Z5GQpQaOCH6qq9WKM/KL20ZK9jkyMwUHw3tKODUV92fSWRpapIs1d3AUtRg==
X-Received: by 2002:a05:620a:4552:b0:7c0:a46d:fa87 with SMTP id af79cd13be357-7c0cf8e624bmr2664114485a.27.1740508001598;
        Tue, 25 Feb 2025 10:26:41 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc0esm12237956d6.22.2025.02.25.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:26:40 -0800 (PST)
Date: Tue, 25 Feb 2025 13:26:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67be0b60a6b36_25ccfc294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 2/6] net: tun: enable transfer of XDP metadata
 to skb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
> 
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta == xdp->data + 1).
> 
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

