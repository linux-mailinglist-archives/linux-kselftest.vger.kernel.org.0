Return-Path: <linux-kselftest+bounces-27807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463EA48B3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9F516CC1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDF271298;
	Thu, 27 Feb 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxzPfHti"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACC270EC8;
	Thu, 27 Feb 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694717; cv=none; b=Wpe7eefSSWBab9W9uHbqsJ7DgdPspDHPPdWQUdsKnog4ZZvJ2lQcCJaxKWGtwnJ54iRU6QZcNlFjId91HdnmwuIikXV05eTCAUCcn+1GJX5ckDgyojY+gZWyn4lLU3UBOdBseoRYxvN3HbcAxX4jvZW3zDVU5BrFACDgxyqTkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694717; c=relaxed/simple;
	bh=3yponD+CiJwDA+nxNRj1pPskZgBxg0bhUnaZKgP1MOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTxA7glKjRHV1UwMlad/J1MGI1vHMTVvK+2HH5smFvjb8VraRr/67VxcMKOgdxH2KQwzmTiXxQXQcL0TOb6k4q0l9skIufjhevWBSqu9ZNE5+JM0OUYdf+KDhAPYEP39e0//O2BrzRXApJlR75YbnRpEu87HmQAxf+IlPQ33HZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxzPfHti; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22334203781so38403505ad.0;
        Thu, 27 Feb 2025 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694715; x=1741299515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlJns6J71zIa/bPLqRLBXvgjI74JYz0SciR5Tq+4TIM=;
        b=WxzPfHtibi9SSMXFtTrkO2KwrqM0wx+bm2+GWUCbrV9X1UjI9mCWul3LIBpbmoOkOZ
         7yvTPszH8pgnbx7i/4oovOYM4suD8QGHEnT496pt8o2Cwc0lykapJdNeUwVMUI7nzFLv
         Mo+ZK2dqCyAOsmzqFO3daGFLbRZBcedcuXqcZ0SIbbvWrKcdDPt8Wjk4B3gLHWG2K24t
         /RaN/wp7W5kDjKUcnuWjMhme2s90Iq2PDB24NAtff31/Je6yDuCxhRzLeAi4n1Wp2Iim
         nibKtl9FgHuSbv6fZsTk11OFDfCEeiUOQwKW4Bvb6hZ9pkzhVZhrx+KcSKEpBSG+JVw4
         saDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694715; x=1741299515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlJns6J71zIa/bPLqRLBXvgjI74JYz0SciR5Tq+4TIM=;
        b=OEPDYHsZwgBcEZlih8v6Hq1jal2NpmzFZeZ0jBglchtoLEcIShjxAs3Qf+wR0bZpZH
         cxApRQ4UcbLYOaO7YvlTM12k8RhTGYczlqoIylJmCS0IssuejyX+gK66QwxBVBrjXaxa
         If2iroEpi3H+yRb1JIvSm+y4i9wgW49TCQ/kTHnKS0tdBz9LKNI+LCySOasgIIywGFdQ
         9IkuwqAxMgQhUlapnXfT5DZkUVWkK9bgL9ol2AlGbiQaCI8pxu0vVjakjBbJci+/6/pT
         +D4WL7ZB/oGXUlClC+C70ooXH/8ebApIZJjdRRiPame/pxuGJqX2jkqH0r4NPnVWV4mC
         yHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2W7wTbgnFWwujxzSskKbYmCveNrqeBIkNxjj+/AyrrtMAtJbRYAIZhA5+RoBmxVgqcxM=@vger.kernel.org, AJvYcCVdQpL7Tpp+wAbGOqXYc68HH4KdaBmFsJaLQLrHoKrFTvzN9wlMBYI8t6GbgXWUQgjvfGrIjQ4F5o25kdcR@vger.kernel.org, AJvYcCXHJBf0KWGakks5WGBFQBqcUbs8mJt/2JjJTMxce08mthLzOv/Zo8OJ4HHJBVIUNovii1b3oJKo@vger.kernel.org, AJvYcCXIZwBtk/1nMgOFWAnHkBRXxhWa3vpzlTbRDa9/DcsRkF9qEPfftzVgM/INMqWoiy3uUAoAki+UHjsEZpx/I4PR@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbemmZXw+99EWpu9zLOkU+Jjzgr6pct9frywN4bmUv7/A4uHr
	8aU/IzgAtktm+fiX9MiJyxHMdiFARyAbAYN3ejDtQr2OFsW9wK4u
X-Gm-Gg: ASbGnctItoq0fQXYNTqh1lEt0Ir2f5CQpdikkOap6z1BkBxktjW71DfbjX5QJZbKC11
	gjyLV3yNhRdUBUEyrzO+6I0VGhplS0BtDA0aYAUdf3dvEt7GbNQXLBisy6XcOb1bmTpvq3rJlDx
	jHEBKV/Dg9eq3XZ8zyAepUXeaTGMM/FREoajqqo/7MgvZeWTipm0iThAZc/NGZXP3UsVAdyESzG
	jtv+FqNbG50voHIyzMOsxN2/6i/Ay0L7CWSXyvfKAaTwGkjz0N4sLwc08bEYuva4ZSqOSDmNs7q
	j3YeCAK9r+v4OfE5uYI1mPbx
X-Google-Smtp-Source: AGHT+IGzZMBsgdbKVV5FmDa83vBtCX6XOQiQ6tfElBlkAjb5jJQbD4pqlBLxu0+RA82taM84mxDquw==
X-Received: by 2002:a05:6a00:c86:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-734ac428955mr1938550b3a.8.1740694714821;
        Thu, 27 Feb 2025 14:18:34 -0800 (PST)
Received: from gmail.com ([98.97.44.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf244fsm2048390a12.16.2025.02.27.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:18:33 -0800 (PST)
Date: Thu, 27 Feb 2025 14:18:24 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cong.wang@bytedance.com, jakub@cloudflare.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Add edge case tests for
 sockmap
Message-ID: <20250227221824.m3jhsvydk5tb6l2n@gmail.com>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-4-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226132242.52663-4-jiayuan.chen@linux.dev>

On 2025-02-26 21:22:42, Jiayuan Chen wrote:
> Add edge case tests for sockmap.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 57> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -1108,4 +1163,6 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_vsock_poll();
>  	if (test__start_subtest("sockmap vsock unconnected"))
>  		test_sockmap_vsock_unconnected();
> +	if (test__start_subtest("sockmap with unix and close"))
> +		test_sockmap_with_close_on_write(AF_UNIX, SOCK_STREAM);

Might also be worth running these with other types? No bug was
fixed there but still testing close while writing is useful
for testing RCU paths in TCP/UDP.

Fine as a follow up patch IMO.

