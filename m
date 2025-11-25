Return-Path: <linux-kselftest+bounces-46433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C4C85083
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676E13B237F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCB32142E;
	Tue, 25 Nov 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxbVjZRH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BD320CBA
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075330; cv=none; b=V/Fh8T2keWDmDDeka5pTbIiZPk9idDmIDkv8CP9fZk/mimbdsnTq8IjI/DxkQ5zxjvYVizkJi7hylAAOhKxz2W6IRmRJ3LsZQ079I6nuodxI9HJLlkgeGAVUVI8u+vjQlbpelwdO6zX40yl6zS3CVN7UDUJ0l58sPWfiwNecKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075330; c=relaxed/simple;
	bh=TcIehyyg9NOgFB+aqxQUl1XQcbzEAynNMvyg8CX0Iz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHfHUVbzj/3uB5PM+TsN0ns9PI5LlcTqlJ63tvEcpAAVjG5mHzxCO8pSXr4vSWTwHsF3bOMqcnQOKPVti/iYxyyNp5mGiLiYtQ36ENEWr0PbWiKew28CXwj53BhZxnjDjo/LmOhzd8WtGbk5vR721v1lbcc3A87PtnLsf+6UlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxbVjZRH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so39015485e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764075327; x=1764680127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=CxbVjZRHmdeNmVkpr656+7d2ejK+CRH5xbGN7WoQ1OQ6RSHHh4OemSB+Ts4ZVLydJa
         i+P2cmzrjX+PHuVDpSmB/Rm9YpkTSjr/pqoFg8pmTCY/FU1MR7Fkzv6of1c8WVTwAWZC
         135wz6s+2WNVkWja+VN3+41e2gX8oILAA+CmXxTzb2eCA8TN6kSPJSsa/CAGpSao6x/E
         366acJ67JjjaSN/7Qo7z6pX4zvh4Blwk1y6BDbdG83jvOAAFht2r91fp8EcdeKpQGh6W
         B8EslKrt8PU6/IWPUadQR1+AT7OaBclYJMHoYdCaXlDof4m/Z7u+f4TwtlnX1jH6KJW5
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075327; x=1764680127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=c23tx87mYVt1k1st/koD8gGJ6zKM4jg4FFDCN8sa+L2kbFMLbJmjhBryYaE4JkNVry
         Q4mI52DJtA9BY3/P2eWHbNC2/9/4DlOkF7tXHwjBydRxpvhfFvy21GhBr0kEEuOBcO2C
         0cM6RTDns5P2dvkfTCuWLRQ59WlfEhATlvqop8TBoWCH6P0Pd1+7Ar05y3XkIPBhmd5U
         er9xbrQzYWcvGAzU3FNdhVV2lWTFASgV4Qds84mjwtc6bs36nYR6jVwRnZyGBBQ0bjQJ
         SyqnB5A30YwhYesisxw7kUyMsCRDnDhWcyfhzBSMOVwGa8mXU7DBlitKbaFYN3qmi0x8
         H0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU88V1E3uMq4jxyoLAKsTwS/i5pT6ILJ7jBPIZSzP9BKbxh2ZVNABFN5HS53kOpwoTdBT4mhz1VFvAGFLSQWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6I+Q1+DqDerIPaFxzuZxWB76bqeSwOkZf+QhhNwWd402KRVwr
	FWuo44XK4CQRGLDac8xomK+lq6GAugllc9mItXVn2H3BD4JVKnthQHC/INcGIHDzts8=
X-Gm-Gg: ASbGnctlklnMTvBsKnM9/xWBKfMi2Iur4K/yQKv2hv1UkhIlnqOtBPOwbOlyNpE45GU
	wK+67uPN7Mmytj3JtPVwj+fEovX67WTv7jo8MGQpflQ6J+ZRCwlzaLDGSP6IndU1BFldNKB6INd
	Oz4HaaakmC9++HIPX458+zMQO2+AuL9gbQKJoJwmLs3QrDqo8m4hMusQBNEXpjo9ursyH3WO90U
	kkEHMOlGu++u6KGnwqNztN0/UE4TTovjX5TSZ1QklV688bUzRABiZ4FjNnBypTaMI9ulyvqqq6f
	zPJ0sX3SrTBN+ygSdZGh2lz2DAUdpJVrrp6zdYIjWq61OA1GFDb5Qu3L5WmrO84YrPB8MDBenMH
	OOd2R6VLPtBnJ8nlePZTX+o6Ddl9NNL9v0RW5v5gxWw3eREzCapC5mshfgkjugZkJ7zCgcIO2nD
	h7UO6+zPGfwGCL9W7LjM2SxQJV
X-Google-Smtp-Source: AGHT+IHeNFHz77PnS9U9y/LXSC6SdqMAwMHknNtAmvznPS8Yog8Q67/4L/1KHix1NRlDrhL8Rpv3qQ==
X-Received: by 2002:a05:600c:3112:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47904b2b2e0mr24822815e9.32.1764075327005;
        Tue, 25 Nov 2025 04:55:27 -0800 (PST)
Received: from localhost (109-81-29-251.rct.o2.cz. [109.81.29.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040bd209sm18794505e9.3.2025.11.25.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:55:26 -0800 (PST)
Date: Tue, 25 Nov 2025 13:55:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aSWnPfYXRYxCDXG3@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>

On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> My goal is implement dynamic memory reclamation for memcgs without limits,
> triggered by specific conditions.
> 
> For instance, with memcg A and memcg B both unlimited, when memcg A faces
> high PSI pressure, ebpf control memcg B do some memory reclaim work when
> it try charge.

Understood. Please also think whether this is already possible with
existing interfaces and if not what are roadblocks in that direction.

Thanks!
-- 
Michal Hocko
SUSE Labs

