Return-Path: <linux-kselftest+bounces-41925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3EB88AC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B08B1BC631C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40C2EBDD9;
	Fri, 19 Sep 2025 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xc/La4vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6B24501B
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275751; cv=none; b=moWlmnb2rOAXqkdwe/tMlSbFmFZxfhWuvAbM1VOlKpQ1rHeDDNxYWsuNgDEhIOCwOMcJAPcj4gLTc3DfWTKaFx/bjAgLb4jUxXcq89WiVwnfongJy2xo4iP90BBmP+nLFvBNmANyP6H6WK6MAL/R/tchNKJI+IkrkWcSPfDnSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275751; c=relaxed/simple;
	bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5NKr6LqnWIwF/W9GMW2pODLod0RXwvPcfZrdJjU0RyOVB4PUn/Wa+8ICfIn9Hy1JSy3sQsBeAG+T1XZwSMF2IMRVvuq8EjxKT5V1R+tBysHdVcXTXyMeRQ5X8VqueKXEjNTf9QRuaUZ5BtkxQgzHqsYJtOXnXQNyEH88iRfj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xc/La4vd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so2071393a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275748; x=1758880548; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=Xc/La4vdrlq47g21xR53WFqRYbNKRxvRpqWMz3Y1dgypGl1GETmRRc1gSsMiQTe8QI
         mP2gRq+JA8FbBlEb0kGiImEGDR5zbzZQX0/DhqOOWDL2NLwM0ul1p9fVDB8K3UsxJ7Ae
         KN6gTCERtZvkcA3ABafQrmTwGKNmq83YiRQrYjIRkl4XxM8G9ZsVqpovXykhB2gC7PIl
         PktzFAR+Fwbj9960pFz4AxGATYKH1B+iZBoNe1+2CKKmGcoPf4wtUtXSpfyHsgrtdToa
         I5k7NWqEc1JinCsC4lOrsU/8M2/pguLxx07g2io2Av/VHnWZDYXV+roH84QDQDVjbvfe
         oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275748; x=1758880548;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=W5bZx49Ughq7XtlWJv4zJ8hk05km4Q9VeJcy13/hhfBDdVxAogyxlVTyv10AxoTAYr
         ODGAhWVQbJsLx2q37LZBU8puBh3rZiSUO9MP5QqYKljBlFtNVIdOgpqmeXZj9ge0jkVm
         kWfHODz1evGRY+g74IjIiv99Vy1U2nOGSqhSRZLI7GBm3y3cYq+b6kONdmOvz2bnqRHR
         ebWb8i63JzuMtVWkRIQuCryZUg6IXCx7oPwq+vtcuALzcg75JCaMyeFSs6x40xGKgcT2
         xRGevmPIVv1BOsT75aebyZQjsSOSqTBsE2+q9wqndNjMANQXeQA34sCQ7djiO62a7BN2
         FSlA==
X-Forwarded-Encrypted: i=1; AJvYcCW1XXHukwEtkvAcn02z/5AG5P6/yHBXdGklL1gUN36YwgX8j4viCYDpQtUM5LWiynwEJ1TNggfrSOs/aCfy/xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LsrOQgXqE2Isu9TFxCn/VkN/3Dr+BId2Vc578gf5s9PKNe8s
	trTkI2vYyUPkY7lmIGISnyferju3c39g3mp4XYGhPwcFVwQQLP5JXrNagrzbdRyX6zM=
X-Gm-Gg: ASbGncv6+JQasIWf2lPPQ37bIrjXheLp61oth0cxCceJbpHLl8abPK0VAeKAjIXxTSi
	Q99wpewOC1+zLXhUkHWhQrWyZavmzYUL8BXORUfed2+PLajTO16syU7mH7oWTJRgrlg4lFA/Mba
	xz9X0x4kNGT7duywq0u/OFziAuAPlqulHIHHFiqnjAXtGXePxO07ZQQcdYANXIYC4M73mi/dmO4
	F/+FSiIntQbzPZvmfDf8FBdCPrLLWSBZc9TEbl9r/rzoOgHhgUHrcz0DV8urE9Svn9ZxFbGGwl9
	2C8GdTBu0h1aYEMBItH87p3Thx7IeDlUY2dwA9nWRuUAciLlVMO8209NjdQ6rdARiRfi4sHskY1
	0FAJeV8bUcaDilxs=
X-Google-Smtp-Source: AGHT+IE1IHc5VP8kfmcFvlumd42kggIZUzh0BzhhNdnpQ5w+5s6AXkfMgZqLrpodiCERuhqWgn3oMQ==
X-Received: by 2002:a17:907:940e:b0:b07:8972:2122 with SMTP id a640c23a62f3a-b24eedb8c32mr282292566b.18.1758275748062;
        Fri, 19 Sep 2025 02:55:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm76152566b.38.2025.09.19.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:55:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: sockmap_redir: Let test
 specify skel's redirect_type
In-Reply-To: <20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:44 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:55:46 +0200
Message-ID: <87bjn6u5p9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support: allow to
> dynamically switch BPF program's redirect_type. This way, after setting up
> for a redirection, test can make the BPF program skip the actual
> bpf_{sk,msg}_redirect_{map,hash} part and return a specified verdict.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

