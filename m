Return-Path: <linux-kselftest+bounces-27814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB685A48B64
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13093A4D32
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB827425C;
	Thu, 27 Feb 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVNGUWN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACF272903;
	Thu, 27 Feb 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694935; cv=none; b=lRNTc9m0Y/3Z/JDRj8+0hBSz+9uvU85pGmDmalDom8JYYmebswnG7c2PaUl2tTKdxoWNJBmFRtsOl/pg2tPPKBoYaqNARbee69n1sJQ8c2vvhWU9kxDDJ55Kungf8bf0wL2edZ7tP3VUxQDyfqirj9owsyeBXR4eYAHHeK85zNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694935; c=relaxed/simple;
	bh=IGK/iXqK3IHYN8V9O5CsUAmKE0u/8x6GISZSDFKsQVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8v7HWoXBXqzmW1S+1iyan07O0041rS2PPnKMx270Odxd/B52WPDRt6JNOgqkdlrlGMR8g2uM2l0Qvpgi3wipk5QWvP/amWXucBDzunoXHyXDP9SZKMEQN87sqjLSH1qfi3J0WhQjTvE7RJH9ZIwccLqIxwm8hmTWU2gUyTm8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVNGUWN2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235189adaeso21573965ad.0;
        Thu, 27 Feb 2025 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694932; x=1741299732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3A/YDU9wrynchhvD7yFxdTu0UQIFwqV0VZoVEq/GoqM=;
        b=MVNGUWN2G9JxQNALmZqUEbiO8qbW7uharw4bgta1zLvtqtOicztgfYV+umEdzPbSeH
         YXG8YeAoaa93PAAfEWrfAfBonXYBcVugGCfVxQPtCdzl+5bbgJtkulztSrgi0i7zp5mw
         ewi+146IcO5+MuI8zvXMYWAPBK4CP3GwQa+oHNvrH5P62Q8X+RhJEPBNl1zIWNC+C1y7
         k/HKn6itcU7NJ84OOrUeAm0EWlEEg7H5ro9ps9IN/C8e0pISIVXEYlGsNf8sH6GlFz+c
         ZkLFWg4hMp5wlhDubqkr5MruxYJ5xP5dCJxACQGjfK4eeK1bIq2KGWieXQcRs2B1cwDJ
         DAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694932; x=1741299732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A/YDU9wrynchhvD7yFxdTu0UQIFwqV0VZoVEq/GoqM=;
        b=g6m0V5/CZllV6qHFUEqAssQPUeHyxm25yr2OcKK68VkLGB7Ohw/EXcm5L95kI7WRHK
         E0cdJkFRwvj3Z5Q6o5ZxTREnbeCfhyh6yoT7P/giZoFDrDe9bcgkb+dSoTRBfORpXN74
         vTO8ABxkjQgr/Ev+fKWKkom18HHkb6DcOBll5y57NyZuzeGyv3NCG/EfQOm4QO2gu8wO
         4AtT59ThXJWVUVFK8B0OmGLvDMu7pJVD5kjMoRYwS9gm5lfsbzW4WuJ+auKQQ8Jv5+Wm
         HGzhyAU9WCE67SsgsPTqhBai9Aar93wLIjx0Ep3tMczKfeJ9ABSVXKGCsrkMRxb+X+01
         Ucmg==
X-Forwarded-Encrypted: i=1; AJvYcCVH0qcngbk6Uig7JAcr8JKFX8k5JNoqJzOfpHJ8OXYvgX7qfWGu7Tv8bMWTI2RpmUmxancLAI+POT8jKk9Q1TIx@vger.kernel.org, AJvYcCVnBxnKwiJGELUWhFITh3MhGKv12zxTpPibvsvTsOG6Hilr1Q/iY8uzbebnXw0yDY6o3s86VKnsUe8uE7NY@vger.kernel.org, AJvYcCW4cJqigF/TgwUhCgQrMuXVmA3T/03gLSqvpCt6TDxHWeCizMFMZ+/4xavd+8PQM3xavDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJYEJvg4x7gCmAtUL/7dOaVeFLJkw76NRtoYYlSeL/jWUriqv
	Lbmvvl/AjJQnhrHaIMxDuIVvTrPVDgzdC8YJxyZqdIOIgaEf0Kc=
X-Gm-Gg: ASbGnctfxS81If1ctaguarSOCpOmz8IDv8/uKa745j6GbGHSLq6xvpj0I+OSoHg7yA+
	FKAKx32Tzqce5rzAscgQOX0sdNVe8RCjNLw5HfZoHfNFTL/XX5VSOB0z1LTJvEpVUX9k0wzw76G
	r/GKcmMieZpVPbVnDcpVMJ9lM6/NTWTvSoFtZmvyLRbXLQMwUz9eiZqJsMAyeED1CehRxhwbiJV
	bKz28/bDgg52Ea4v7/pbgfOreg/cyLfBDhVP8Tr/2dvTVhw8dtSpAb+Lx4r704pWu/yDYUqn1vj
	bqRhPiVO0uWDu/YDThf8aUrkew==
X-Google-Smtp-Source: AGHT+IEpwV1ijof39CKBS0WmuWX5WdeZn4tgXBhdNnhYZANNQxoe3Xs2zw1eCMp/3m5XHqaUyaVitw==
X-Received: by 2002:a17:902:d507:b0:21f:6ce8:29df with SMTP id d9443c01a7336-2234a1603efmr82879825ad.3.1740694932421;
        Thu, 27 Feb 2025 14:22:12 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350533186sm20520565ad.243.2025.02.27.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:22:11 -0800 (PST)
Date: Thu, 27 Feb 2025 14:22:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: test_tunnel: Move ip6tnl
 tunnel tests to test_progs
Message-ID: <Z8Dlk0-hOmZ9Aigb@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-9-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-9-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> ip6tnl tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test ip6tnl tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_ipip6() and test_ip6ip6() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

