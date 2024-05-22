Return-Path: <linux-kselftest+bounces-10564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392C8CBCC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB41C20CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB067E58F;
	Wed, 22 May 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ae3AipL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09577F30
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365876; cv=none; b=tvOrt9wHHq0DZip9NUXJOPVgTcch0U8C6QQpxjLqwp7cHnILPePSOzDiLbxORv2diitdmvaOvXAroB1Z+jgFUEwj672QwpRDd9aA5J58gq5l3YcOp7skWjZpCJItsAZktd89BEvyqyfeYLYxdGGuRtQ11cYkmxUBhPi/+p2pMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365876; c=relaxed/simple;
	bh=KRBeh0DdzrLvU7l5ny5ENlQMSYfiQWMjqFDiggLGPn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxUuxWky6Y8L0lR5R5pgQUBqoTIRtKjcPdGnCNSb+Y1NLJ8XISXyQEJM6F/HCDshqilJDN0rBCrJn1w+aD3lM8T7ZYga1grmfbi6VP1HZZ4i/rmQ4P4VOxtKyi7sb+qMGhw2xtBAAbORiNmEXIHQjwl0h8ObMk4fqDej1gfiQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ae3AipL7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso1003371a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716365873; x=1716970673; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZX+gUjvefttmyDfynhRPtuaQ62yDGI7HlZysTaOMc=;
        b=Ae3AipL7vM4KWmKtyt07bPyr7/Zfq9ZshsEvoeJLdaXYRVYGzJ9NxTrD5aSGaApbIy
         fuMPVdz65r+LED5HW/CmANhnqTMXHJIgt3hWNVjnqgm/sODMcRLybiX3Iv59lr5Ze26m
         FLAwCSZaZyeMahwB61RX/OiGLbHyXUW/mwUxuQQ2hinITDIvRA7N4skMrl004LXyOs5P
         8HdeJ74VTKGStpIclTGkETdld5PiUw35uelhnTh4GwnPr4sL2BEYp+HIWn79Qju5aBkE
         sw5JM6EhYUryCalqVBCrAMQFTKejyeTkqc7BYT5FEEEqj8B29MSl51KDZbDlItwy5HQ0
         Gp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365873; x=1716970673;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMZX+gUjvefttmyDfynhRPtuaQ62yDGI7HlZysTaOMc=;
        b=TaUEbYodJyuAp9bySOWVAObbFT6CectTlHgXIpEfKYvBV0RUlVTrXNHsxzVsyFRupu
         pjmSjuGNIdN6RxvQuWi27y4AT7ZDwbmDbTRKBT+9pP96L1f9S8Wg5TfW4qtpZ5ch0EdL
         wDDqTYrAZc+Russxig6u/U2HqGhlNH9fA2Zt74gL5SqJ+DkIKeu9s04IGO1DASGkB4lh
         WJa8HlkC5zL8as2/sCkw0aaGVUA0gZpEGS8cewtcrPvOdrCgLilkNBHZXqbKYdJHJ6eS
         Xn5Tkj5BajXliaITr8CMmPYtM/kbP8JB7t1Dx7dtZ0VyhwCL6tzGoqHwelVVzD6YLbxs
         Xffw==
X-Forwarded-Encrypted: i=1; AJvYcCU+4GEG+12InYGMch/JaRlxn2BYhsZCUh6n6iTTFpv1Y+XpXv4vYOU+aeuLds48pe1anoJmDaSjK6FGql7wF75LfWTaOpLyIOhxTPbbNkBO
X-Gm-Message-State: AOJu0YxLYMSGAPy75Ill68JTKqV8/5pRq6qTl2abwMN0rxiCbeBCrnW3
	eardtUeTMIRRI/cIsu6n4jbjC2jj/JKQtSWQwIeKpxhvxVd9xHndw6+jjvpeJ3o=
X-Google-Smtp-Source: AGHT+IEDc5zZ/BMuk/6O/B8g9U1NqatChVZfiw6B2VP0OFFSX7TPukAxT+LyMOUNoDWUaW+9sE0kAw==
X-Received: by 2002:a17:906:497:b0:a5c:d4b2:6a44 with SMTP id a640c23a62f3a-a5d59db36acmr1077008366b.16.1716365873228;
        Wed, 22 May 2024 01:17:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm1729610566b.111.2024.05.22.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:17:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Geliang Tang <geliang@kernel.org>,  andrii@kernel.org,
  eddyz87@gmail.com,  mykolal@fb.com,  ast@kernel.org,
  daniel@iogearbox.net,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@google.com,  haoluo@google.com,  jolsa@kernel.org,  shuah@kernel.org,
  tanggeliang@kylinos.cn,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
In-Reply-To: <171631563033.25358.8200564796951629702.git-patchwork-notify@kernel.org>
	(patchwork-bot's message of "Tue, 21 May 2024 18:20:30 +0000")
References: <9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn>
	<171631563033.25358.8200564796951629702.git-patchwork-notify@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 10:17:51 +0200
Message-ID: <87bk4yxntc.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 21, 2024 at 06:20 PM GMT, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Fri, 17 May 2024 14:21:46 +0800 you wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>> 
>> bpf_prog5 and bpf_prog7 are removed from progs/test_sockmap_kern.h in
>> commit d79a32129b21 ("bpf: Selftests, remove prints from sockmap tests"),
>> now there are only 9 progs in it, not 11:
>> 
>> 	SEC("sk_skb1")
>> 	int bpf_prog1(struct __sk_buff *skb)
>> 	SEC("sk_skb2")
>> 	int bpf_prog2(struct __sk_buff *skb)
>> 	SEC("sk_skb3")
>> 	int bpf_prog3(struct __sk_buff *skb)
>> 	SEC("sockops")
>> 	int bpf_sockmap(struct bpf_sock_ops *skops)
>> 	SEC("sk_msg1")
>> 	int bpf_prog4(struct sk_msg_md *msg)
>> 	SEC("sk_msg2")
>> 	int bpf_prog6(struct sk_msg_md *msg)
>> 	SEC("sk_msg3")
>> 	int bpf_prog8(struct sk_msg_md *msg)
>> 	SEC("sk_msg4")
>> 	int bpf_prog9(struct sk_msg_md *msg)
>> 	SEC("sk_msg5")
>> 	int bpf_prog10(struct sk_msg_md *msg)
>> 
>> [...]
>
> Here is the summary with links:
>   - [bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
>     https://git.kernel.org/bpf/bpf-next/c/6c8d7598dfed
>
> You are awesome, thank you!

We don't need prog_types and attach_types at all.
I was too late too comment so here's a patch to address that:

https://lore.kernel.org/bpf/20240522080936.2475833-1-jakub@cloudflare.com/

