Return-Path: <linux-kselftest+bounces-6621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAD88C235
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5744E3019DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DC5810D;
	Tue, 26 Mar 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZDK5pEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08B5A0FA;
	Tue, 26 Mar 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456526; cv=none; b=b9ln6Nu8dURopnmYGf+yhejfz869SE2sHpsiIXwTG0BwdOyPsmwbAD7P8uKDSREuwaD8ef5BsLpIh8EBva1jlB3ynE27HrtSdZBzqJQcyIpWC7+uIH1Y+Le3OAIsO4c6abhPd67jb79or9bK43YSviG5UP05jGqE/gfaCZJiCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456526; c=relaxed/simple;
	bh=6XTjoV9ZlDTzN5vXMrcYGZJGcOhwU6OBWtS33uI0Xvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i3D892kvvGPZn3PMrpNsQ1xmwt6EpPCa3qMfj9/xXWwuiMKiDhN3W4a85WrS5wYRMXhIVbYZSiFRK5dUOBnEsblZRrj19jASyX33mHiJaaZfa7GmhmHI5J+5WrfLVZAtgRMVaSHdd3WQV53X1ql5FKSpTd9l6379IbytP6LG7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZDK5pEn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41488f9708fso14299805e9.3;
        Tue, 26 Mar 2024 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711456523; x=1712061323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qj9viDkJqyEnEMoMdMZBdgZRhxl32v2W70TF8U83dEk=;
        b=PZDK5pEnvwTucdkr4k8C4bCT2abBZisAuVojqflJm4boyzwQPnok9tPXFRGZBeukkL
         85n+jXA7cmS+pWZwUxZ4M4wKMSeVHGF5Noc1At5Rmw81kmCJZwB0xBOFdRme2SzGkJ6Z
         ageo9SYOJb1OC5PcZxkUQ9pdO0MeMM+hJRnLqVN8NzgYX87df9ddhsR8Xc4w9CfgHTaQ
         JkQuvJ/t99pW71Q3Lv6vwRrb2gdNbbwfEadNZJOGSeTkfYI55q7AmCnT7vagk9d3pu/r
         8TbsElkLZZW6Wka82JTGD5gmqVRpgC7OxiDX4CuyvyE+UaeLFhEjBj6pZRYldLsBC7gW
         q0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456523; x=1712061323;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qj9viDkJqyEnEMoMdMZBdgZRhxl32v2W70TF8U83dEk=;
        b=dh5iQ1nkcuuTDVZ5mYS+vfnbuUD8Y0YZ2eDvr75/8RGdzxdhDd0NgM9MGymklcQXcS
         OG+SLTCFKn2EOJIaMWKWzFuTj5ZN5rd+oVATdUVHn6g9HIpdnjhnmeKHjTj1n90NVCJ2
         XYSnYq960ayi/sRhANS/2/4AAFaO012R3dOchAZUNT/xx9km/gNGclGoYhnXg+2k7lc9
         WADGUzMXL5HgFAtlcEcGZhfcdbsPE4LPTqGeKLjnaV4foaic8BA59UOJLWCHBGTu4LFW
         4GPnpeWqYBINHnqFsA8FlbN+8022G8i9vGFKP8YDG6gLxBejBPFsPbyT5zmYd2IauxRX
         dwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7AWQhzGTUw3MO+eASSaNk3C7gGvMBshvhV1N41dSqm5mwWBCWa4Okei35XMyfs1e3EGvsSE/AbOLUW8tRkhBg4G+BU1jpZiZRm+xcV3cCTOtxcrkRqwDTsl+vkjLUlYBtpmc2u79MMtdx9FvKgw/hs3uw0RtaDwNqIdiU+hREBNKP6mEt
X-Gm-Message-State: AOJu0YwUyWE3qZSL1Ek8n/He4JqxlxNp1kruHDjV5WT7dTuVr7YlTSYm
	mL+7ZvBxzeZH9hTul5eEE8Ob9w8NEvLH+2nDL/PkdvsflbxobJWT
X-Google-Smtp-Source: AGHT+IGwgyBsaN7Ms+0IYQV0NG9hS1YRmOySH9NZ+A+pwuMXCxDaV1ICp2UXSJ+LiXZ/6OR9OQynaQ==
X-Received: by 2002:a7b:c7d0:0:b0:413:fc09:7b19 with SMTP id z16-20020a7bc7d0000000b00413fc097b19mr5846747wmk.40.1711456522630;
        Tue, 26 Mar 2024 05:35:22 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b00414807ef8dfsm11144822wms.5.2024.03.26.05.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 05:35:22 -0700 (PDT)
Message-ID: <494e8cac-e87a-4bc4-8a77-1801a703fd86@gmail.com>
Date: Tue, 26 Mar 2024 13:35:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, amcohen@nvidia.com,
 petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, liujian56@huawei.com, horms@kernel.org,
 linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <6601c830c1daa_11c6072943b@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6601c830c1daa_11c6072943b@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> In v3 we discussed how the flush on network layer differences (like
> TTL or ToS) currently only affect the TCP GRO path, but should apply
> more broadly.
> 
> We agreed that it is fine to leave that to a separate patch series.
> 
> But seeing this patch, it introduces a lot of churn, but also makes
> it harder to address that issue for UDP, as it now moves network
> layer checks directly to the TCP code.
Currently the logic of flush_id is scattered in tcp_gro_receive and
{inet,ipv6}_gro_receive with conditionals rewriting ->flush and ->flush_id,
so IMO the code should be more concise when it's in one place - in addition
to not doing checks against non relevant packets.

With this patch, the fix will probably be simple, most likely just calling
gro_network_flush from skb_gro_receive or from the relevant flow in
udp_gro_receive_segment. Since this bug fix should be simple and it being
not relevant to the optimization, I'd like to solve it in another series
and properly test that new flow. Do you agree?

