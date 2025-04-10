Return-Path: <linux-kselftest+bounces-30467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB66A838A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 07:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4519E542B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D920103A;
	Thu, 10 Apr 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkXdP2/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F532AEFE;
	Thu, 10 Apr 2025 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744264230; cv=none; b=IGw7PpCYYnpv/cq10uxdgMrT61Z9OK3SM+7qtP5p29kZmdQpDIfAysz9o2lONu3E+HYp6rRogH4mVn5Z5n1NyMXgoohLqGC4XimAGVsWksA8ue20JCTpKwHMcwWUG6mtV7GGHIhglk/uOI+1Ma39CD1FFEp+Amh3P3NfFXaLCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744264230; c=relaxed/simple;
	bh=GLy2Y5AGxoPWdVo227sGdBc4RBWTQJfG42DMlt4gnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIpLU4TMwlo/k9is2xdj9KlN2uwMW1AVyR2z1mT25bAxXbFiK6vTBEpEafB12B2eqx+wSOMzuS8a7UW2WnFMhs7GSTkt1TCZh26gOI15aaQtpxnCc7j7m0PQP0HXxNxNX9qKspE2KZkX9/Iq2IPsLzd9PIDEFQCznSbMEkr0vgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkXdP2/b; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2295d78b433so4248825ad.2;
        Wed, 09 Apr 2025 22:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744264228; x=1744869028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj8tyCRZ2dYPmrI7KzgwMrBluJ4nn78a0lxOtb4a5CY=;
        b=NkXdP2/bTp7/GRmRsceyu4nbFP+Iio35LFnlI6whBlarNFpuSs5JA32056oBVXMyp7
         Hi/wswF6dUVFNMYZAw5ymuG0mfzt0gEeqIOS6s5XNM2WfOXXAo3TccJDVaNP9UmrjbFv
         DJT13g8LOjrN4t9eD/mCRGAKBdVvcXGIIvmIAPsjLQt+v2YjB3aHOa83Qu1Bz4hHpIx2
         +AtSDmqAuzo6tyrsi+ulS/ZD6nLHmrLzw+TvUht2F6FHTlzelWKp81d2y757zInlCi2z
         uY3FsKRczH8uG6NVYKIgnbkY/2po7qXeYZ+zmKcaHgmv2zUy+btj+14r3CIqGmqBS/9w
         XEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744264228; x=1744869028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj8tyCRZ2dYPmrI7KzgwMrBluJ4nn78a0lxOtb4a5CY=;
        b=YhCUN/QWQVQMpdNm817Ie26EA+lDN685A/BRKYwgJnMUIFPghOMZTh8llLzYtBl/fc
         wh2tGgCkGbcr1A+jheHbD5EFMwwFJYDYyJgYrEyo14N+Qb70K1PykdDoTBZaPdJf1TzE
         nMezpLScCt3hfdLGWvZFy8LIKOUWiqU2N+1DPZ5VnKuvy8ZwUNaFo2T4oezA37DJKiMR
         8XiOCxT0f6ZRPFqnmabsv/H9+oMbLGG6igo5p10XY47DLnoJF8/BvP5zmBnqn8KA3nG0
         G96sPQNFbBE/eqM1F3e/6dqarEKFFUtE2HtIBe2Jvho7jkkF3GwwoF5wwOpKdFgnbFhw
         U+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUIssmkMSF4Pg3JcYz1tRGgt5YcSunZaj2XSIV59Tks3+szZMsyi9uPDDSCw3Z53jPW5DTGc7GG09D7PAYI@vger.kernel.org, AJvYcCUOSEUpzrC/YYgGqiuEGEmVBSWn8qpCaPhxZeBpZ6NdyYPeUISy/e2YADzmzCd35nezQpQ5P8qR@vger.kernel.org, AJvYcCX2UfTAhRdOL0ryq5mtAu60lvoczCi1CNrdZeQavr5tq9/a4h7YwAWZ2F6MFygpe6VxRARF4F8a+1ms6gYCtFn3@vger.kernel.org, AJvYcCXmLQyD7B0/AvAK87ST9OTHaaavz97t3wydYwCnjvZye+KWtlURk2LmYrDAPihMI3glQrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMJa10p9g+afkos7ihgLGuPTggj10MeSRSJGxKqBx3uweQsvC
	eMPVhFq6h8y5QU6XaTrPEescmCMpGhuRO0RPuAgpjS0urwCCFtjH
X-Gm-Gg: ASbGncvSqSXW7XkBOx6SJ76SEJas7B2NItCOwtZPHbvPj6QP/VM9jCdg4EiBKJ/D/IA
	wQp9c9aUm/0gQwSZWwuHAzH+u09Q1W3bRr9qYfL8Bex5MEYH9B0nx+0DsFkAycVcG2nX4XuBxic
	Ijlk7CLoZYAaO4ZmLY7jt0o8lM9oNjXLxH9otxBzLoTkc4YutNgMN5fw/olJnq1J6d9+HsFJ6qU
	LJD69k7dn+o/AiGQxJBfnqmiJ/ZcbyWvuc9kg/KwI1ov1RTZNXg+NB4pXyrNnxkacDjC7wdd1ae
	aqoQd9Lb6oCuEpEDa4cadeY+3A4zCkvNb2Qc9q6R
X-Google-Smtp-Source: AGHT+IHhGUypkvLr1iZEMWjwiXcb6G3gfkM3dbA/hFQODsPXnBha9vkkBeEKuS4KAcywKVBuOORx4A==
X-Received: by 2002:a17:902:db05:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22b2edad412mr18045245ad.11.1744264228467;
        Wed, 09 Apr 2025 22:50:28 -0700 (PDT)
Received: from gmail.com ([98.97.34.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb536bsm22091005ad.201.2025.04.09.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 22:50:27 -0700 (PDT)
Date: Wed, 9 Apr 2025 22:50:21 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
	mrpre@163.com, jakub@cloudflare.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	mykolal@fb.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 0/4] bpf, sockmap: Fix data loss and panic
 issues
Message-ID: <20250410055021.sdwodrag6rdf6lfw@gmail.com>
References: <20250407142234.47591-1-jiayuan.chen@linux.dev>
 <174425463772.3131897.3560283890937950515.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174425463772.3131897.3560283890937950515.git-patchwork-notify@kernel.org>

On 2025-04-10 03:10:37, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
> 
> On Mon,  7 Apr 2025 22:21:19 +0800 you wrote:
> > I was writing a benchmark based on sockmap + TCP and discovered several
> > issues:
> > 
> > 1. When EAGAIN occurs, the direction of skb is incorrect, causing data
> >    loss when retry.
> > 2. When sending partial data, the offset is not recorded, leading to
> >    duplicate data being sent when retry.
> > 3. An unexpected BUG_ON() judgment in skb_linearize is triggered.
> > 4. The memory of psock->ingress_skb is not limited by the socket buffer
> >    and memcg.
> > 
> > [...]

LGTM thanks for the fixes Jiayuan. Good to see someone working through
all the cases.

already merged but ACK for me.


> 
> Here is the summary with links:
>   - [bpf-next,v1,1/4] bpf, sockmap: Fix data lost during EAGAIN retries
>     https://git.kernel.org/bpf/bpf-next/c/7683167196bd
>   - [bpf-next,v1,2/4] bpf, sockmap: fix duplicated data transmission
>     https://git.kernel.org/bpf/bpf-next/c/3b4f14b79428
>   - [bpf-next,v1,3/4] bpf, sockmap: Fix panic when calling skb_linearize
>     https://git.kernel.org/bpf/bpf-next/c/5ca2e29f6834
>   - [bpf-next,v1,4/4] selftest/bpf/benchs: Add benchmark for sockmap usage
>     https://git.kernel.org/bpf/bpf-next/c/7b2fa44de5e7
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

