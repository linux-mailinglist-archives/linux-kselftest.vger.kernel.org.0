Return-Path: <linux-kselftest+bounces-32293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87503AA8938
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB833B0474
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207924887A;
	Sun,  4 May 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLE6C/nu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943F1DED42;
	Sun,  4 May 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746389961; cv=none; b=UmryOoTne5nw1jfdImfM4fW8hpDM/xgxJsQ2kOuj6HBe/OdJ+S6w8w/2V6rJL3QZtmxV9nF39isUtmTWqjsFBDrWsTlOgKACINlHD35sDH3qCHdUcAmTfoKv1fy9j1RtSnk/Ar6I62w80nn2Gdg2rAuON0hZgvSZgWaJ33gxcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746389961; c=relaxed/simple;
	bh=kWouH9PcHn1yDE6oVME8ha/Tnp5GTGTxgWeh4wVEHCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaUNUFxtCAN592y8MmxLPdTtUD6WoFKZXKCe0nO4BU9PUel5zKGwlKVFs22hXxilcu0a57TFBX35bdXhH1xTXeI5boVKr3jjiKCugcg/78kekX4Zqg4m+uilIGZNVTJn0wT5dQ9gRN4MRZRU/rOfXdlcTFW/Jp9K0OOnu61lpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLE6C/nu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74068f95d9fso920667b3a.0;
        Sun, 04 May 2025 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746389959; x=1746994759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UvegomJiMh6nIQI/2J4Ao0uKJD2zSYoWW1qFQAs5Yg=;
        b=ZLE6C/nuGxEesrvb+tRjV9caO4+r+wCxv25dmc9DJ6Syjtl8gnsFq7eXZXXwl6Yk8J
         DA62ySssVw+UrIYHsTnqE2ezldav7Gi2bERRr4fLC4xNd+w0DuihmsR5fJmPtXmNMCgG
         N6PrNoQbIe2Q2mhLHhYsxCo4hNvADQBzJlkdbcgF0ztpN8Gm49a5SYYLwA2sZs4RmooN
         a7iL9AVK2uh064dgXy4VPPDuEGoPI52WPcGYsKZEc/fnroK6guuHyHlmbT/A9b/B6szh
         qHjHm7qm+2ijrudBamNK1j15jzkmETPc1YUDqTYe/0V3xR7x9LGd8n+3AS83131Gyoso
         De6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746389959; x=1746994759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UvegomJiMh6nIQI/2J4Ao0uKJD2zSYoWW1qFQAs5Yg=;
        b=RQk83kqtxPHmxzB/PZ9omCR0ohrkdPmGgunwyNnmv0omTHsyNrIswmfpiBiS5Qya5O
         2G3D/VlTGsiZdz8Qj5ntQ6Qsx74gVV2S5DQj9m+gXCjBNcEHzL4M0+gWQOTfhmmZtjZ6
         WfKkY6IIj9RXanVsqTWgLRsAJiuOAkG+vLaqcln5A0O0OF0A/DLOofGB0L4hjloD7KbE
         //tx8+Y/rXkxGOo7ZzWAkkOFVBI7ZY1HDEm+fMiH8xQMEj8Dp5OrMy/xkB13xUHG6Uow
         JbsM0NedvmktfKONaM73sYmo95uRvt0MSmFIPdoe/JSinVj4Am1gWL/KiGkjA2pNan4K
         pVPg==
X-Forwarded-Encrypted: i=1; AJvYcCWNUpTjp8ZftkwdSwLltaBVYU6GWxqCNmWEd/lry1QxpKg/JMGOS0+fxDLSEH7mFlO8apzwmcDV@vger.kernel.org, AJvYcCWsnYmFJyl6JC+Ap6uSH3WDXgzBI3M/thT1ggRX6pVYH9b3D6L84GP5UJLHxYYe2CIr4u1oitCg3RSD1fs=@vger.kernel.org, AJvYcCXQa5YaVvzmjBdvNJ8Pad+lolwy3AGZPrNoXd5klkgzNlSVavtmHJtcNNaeEOI3M76EFhB7ipkoTcxIU8aFZUnd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4u36kFSs2szty8uKH/P40iaqCyjW/2zRNn67FzxuPFTZt1MV9
	utLLYhO/UOVnGBeUk4VJK8UtBdMgQ2pK2tOeBO7fvW112Hf7y69M
X-Gm-Gg: ASbGncuWeyCfRxI8UfTRmV8RVP7dLDWfxG/ypIPVz1jb/Ze8sa0NNmRf0Vw+ZdYHE5r
	l9CREvINfFSBdUplKl6lmjERmm2ua02RZlAuBHI1m3sHqsUf8GG/x1eFRZ0HPluYENoV1cqn0Sv
	viwl7Je7KlpdaLkb+hXzEciOkyCQHHyO9yeWxaUb1znsDN+qYClqmsxVI+DFA9hLY+W63aBojS7
	kAknxq+Y8O07h29DFHH1VDKZANsDb1ZJSAGWQZ/7QvFEQ4YfMMNQULF8PVkWDQcr1WVwtU9Fd8w
	wmDs9tkSxpasIY4BiGZQusw+mCINCNMR6pvVdjNxSgc=
X-Google-Smtp-Source: AGHT+IHjm56528yNjjRibNiMtXVYmxhFuk9RepbfihANhB0sy0XIXdsZY6QgN882IXegmTERmbZiTw==
X-Received: by 2002:a05:6a00:ab0d:b0:73f:e8c:1aac with SMTP id d2e1a72fcca58-7406f08a579mr6611979b3a.2.1746389958935;
        Sun, 04 May 2025 13:19:18 -0700 (PDT)
Received: from localhost ([66.205.136.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a47esm5246607b3a.29.2025.05.04.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 13:19:18 -0700 (PDT)
Date: Sun, 4 May 2025 13:19:16 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] ktls, sockmap: Fix missing uncharge
 operation
Message-ID: <aBfLxMus8jgK7JgU@pop-os.localdomain>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
 <20250425060015.6968-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425060015.6968-2-jiayuan.chen@linux.dev>

On Fri, Apr 25, 2025 at 01:59:57PM +0800, Jiayuan Chen wrote:
> When we specify apply_bytes, we divide the msg into multiple segments,
> each with a length of 'send', and every time we send this part of the data
> using tcp_bpf_sendmsg_redir(), we use sk_msg_return_zero() to uncharge the
> memory of the specified 'send' size.
> 
> However, if the first segment of data fails to send, for example, the
> peer's buffer is full, we need to release all of the msg. When releasing
> the msg, we haven't uncharged the memory of the subsequent segments.
> 
> This modification does not make significant logical changes, but only
> fills in the missing uncharge places.
> 
> This issue has existed all along, until it was exposed after we added the
> apply test in test_sockmap:
> commit 3448ad23b34e ("selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap")
> 
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

