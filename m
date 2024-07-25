Return-Path: <linux-kselftest+bounces-14212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964E93BF1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B0A1F255DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56717196DA4;
	Thu, 25 Jul 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="F6e9yuw0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92D2746C;
	Thu, 25 Jul 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899886; cv=none; b=b34z9i/Pe02X8VioP8QfAC1g58LdWBP98/Iy3qR7TMLbKac3yah1dVqtcMuHFcj2+YrK+GN2qUHlAOiW8NrBUBF4UnQS4PmtJG3FBMwecGn7Mfe6YgcYn/FVLEvQQMPhnxw2kHTk0HaSbKXZYqOf10bXck0l4Kb2YlAtYh39LU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899886; c=relaxed/simple;
	bh=S515Rp4aO9NR9Mhpii9h5FGmHF3y2s7v4/62ieXiZxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoPScVImpDSwuiNkkARSnRz/DqHXx1pw2vmIuRNveHLbkudV+Au+AxYtdDyyb5bnpwyGIgfKPx6A5Ki+MSMdg4awxPTfBlRxZLInMFZ6kFp+9eOunytJdQAQXFtst3K4pTTA07P6Xc4G/l02qFIIdGcZFGgPoFHCg0YCUABEY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=F6e9yuw0; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1721899323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S515Rp4aO9NR9Mhpii9h5FGmHF3y2s7v4/62ieXiZxA=;
	b=F6e9yuw0kiFlGCKFgQWLhGP6McJBu/kWmMYnD5xIV51IQxTbaLVimOb1g6iY2nZCQw72GI
	pefcvVUSch/1+UA5RwQZEVgfl+LSy4oJnXCEokEstHvO70HSI3qVOpEJ30IrigLxChYvmT
	+D1O8n66RrYeM+Jt9tcc4RUP5KC1g4I=
To: kuba@kernel.org
Cc: arefev@swemel.ru,
	davem@davemloft.net,
	edumazet@google.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kselftest@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	virtualization@lists.linux.dev,
	willemdebruijn.kernel@gmail.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net] virtio: fix GSO with frames unaligned to size
Date: Thu, 25 Jul 2024 12:22:03 +0300
Message-Id: <20240725092203.26366-1-arefev@swemel.ru>
In-Reply-To: <20240723223109.2196886-1-kuba@kernel.org>
References: <20240723223109.2196886-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I checked the patch on three reproducers and all three DEFINITELY broke the core.

There are two malfunctions.

1. No flag skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
 If it is not set then __skb_linearize will not be executed in skb_checksum_help.
 sk_buff remains fragmented (non-linear) and this is the first warning.
 OR add skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG.
 OR ask Eric Dumazet (cef401de7be8c). Is checking if (skb_has_shared_frag(skb)) so important?
 in the skb_checksum_help function, is it enough if (skb_is_nonlinear(skb)) ?

2. The skb_segment algorithm and related checks, this is where you need time to think ...

Best regards Denis.

