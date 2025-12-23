Return-Path: <linux-kselftest+bounces-47911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D976CD7F5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 04:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09E8303A084
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96512D47F6;
	Tue, 23 Dec 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOJs8TTA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A2882A7
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460169; cv=none; b=upkaMISHyANLY7oxRkpUwtQ6NrS6aZ2YBuATcTBoID5z+sWwDAAE9JJZObsfBQR5t20XJBfBAHhHa/3QraQhzU3ozx9czK6Zo1ZVO0LPXZCAYZwnRBS7uPP1ULznDkjaiQ/6XK1NRenpOw6GN/BfLSxufCJA4v4yxabZMJyDUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460169; c=relaxed/simple;
	bh=nXx4iU/G89xerhbNe+u8rqRV/ooGUpUr+zBdOwqNUIk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WuSTggxN5yHVNbzPfc9wFc/j2NZCV2HojnQEEHvanSzrEnFKmLPPLG+uIUUc4NxtoXPypAz+/IW0BFPuhpVZWXpPWQaBC/kcFVs7lCQS7px2SO03K2sDHdSHll3dnEs6fu0JDJlCvuGpcCgl7ME3lfB5kEeNqKDD+uITTRwUwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOJs8TTA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4005872b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766460166; x=1767064966; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=OOJs8TTA9zmASvFlalfZRRHcw7yjthb+sktasAWSRJyLbmTTDv1yaZ7LIbgFhJYnZT
         nfUzuSnWLKv2q1ygvKeNTVKLf2wR5OBafiWucKTrG2UYbw8+y0peq9wZxuPrhDKLvptO
         gnnmC/8tur1l8TywRFHit5z2BnmOEzuCgYE8TtrdChDS9mqecZrUwIdOxWT1U5vyKSMW
         kTResLiGzZJtxMkhmWAILe55gGIXsVFEvuiBNWDV00YqEnySMmjDxKIFhcCPF6IBJXqb
         /0cDYRXtyIIq5GKcd4JK9xw7mCGR/WvmKV0LRzKwaGQ6xZ8IOUYVhuxEAIMj8Yk4mIIp
         8/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766460166; x=1767064966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=ZqCGndTGL2QcgBh5T3AyAJkO1idzey0ewItUXTkuCwNhXJaf32wOGiowxVXnJHsO/k
         J2q/8aTgEWwqCy9Z122QrQai1toh1nEXgiZ16HPvXUfFBRmngXLK4cBJEzDWiR4Ncrsk
         zEtbwYmViTdbE8WvvOmmAP1qzDcS9TEFyRf3vdniez+gOiIaX5Y0OmMNVY6kc0FCx8Q7
         jkPkvHBeq+qeBVzKizfRi8PjcFIuXQwrupK2SeMCwJ5xlVED+cUSV6swFEJ9QYjEPGBo
         9Gd+3RZZesPsTnCg7yngLS9tbZ2LoPy+3mBJD33wY6/6G7+KNq+N7eYLrfE4V4uFckkh
         eG1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCtXBHJrlJ0127BFRfWvRXKkZ8hnD1umf/3OMvTg+jwGzf6dVSHGOPzqrXiFbKBHP0BuwgWjxSmMwrnmHJYCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyit9dCKSkfFSozGnLMBiZ44d+Xr8/B64iEud6sm6joKUVy6OZC
	Rg1flusB5MwXwXJfvaLdUxH/nnpOOTvmoL5iIenn2qEb/bp63/mHwCov
X-Gm-Gg: AY/fxX6GhwXUApoO/QAmcs1+Nc4Yr+vKenu4CquBuSWZ87zwKIvkrNARmTOnELDfqP7
	/kzQrHpd5K1t+zcbK/F9oXTu78fds0rVR2nFt2IHN0bC6SIvx4ZL6s/DmEbMuPrrgVn//SQdbmI
	w/GFFGXrZJevD4j8Ds0s1k9Eaz101pI+UXti5uDJ+G3xb9sbhdj6FAQf/TYlSsUAQOTmNNutb2g
	Yryp3rC+YprP1BeLg+hlSzEUGU8rpVpvYYmfDbYqPyTPx60IMtew+TTfJ3MJY7tbkyUc22kaGhH
	imAE6mGD/yqbHnx7XuzVCa/WLwNpmax0sOfZT1f/o8Ju34abv65EJ70CE/COhpwnGUkfLuzRg/G
	Pny9kDkLm0CBBvtwprZm0Xm9Y3A52G8tji4TaP4dTBEZwXzyWGCcXsPr/xhmnIJ3XsqAahIL7K5
	a6jJAIKqYm60RPNDtS7g==
X-Google-Smtp-Source: AGHT+IGyFG9HgVkid7kCIt03WV3OP+yzvzYv8vgTEUV5lnnwd8VTxqHvW5riW9AUU8KdGUm/0KVsJA==
X-Received: by 2002:a05:6a20:7291:b0:35d:d477:a7ea with SMTP id adf61e73a8af0-376a7af69f6mr12887207637.19.1766460166103;
        Mon, 22 Dec 2025 19:22:46 -0800 (PST)
Received: from smtpclient.apple ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a13f95sm10355774a12.9.2025.12.22.19.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 19:22:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC PATCH bpf 1/2] bpf: Fix memory access tags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:22:26 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0C2A0E4A-F35B-4247-B0C4-42C52C6786B7@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
 <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
 <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
To: Amery Hung <ameryhung@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


> On Dec 23, 2025, at 03:29, Amery Hung <ameryhung@gmail.com> wrote:
> 
> I did a quick search and there is one helper slipping. We should also
> annotate arg1_type of bpf_kallsyms_lookup_name with MEM_RDONLY.


Good catch, thanks! I will address this once we reach a conclusion
on the ARG_PTR_TO_MEM semantics.

Thanks,
Zesen Liu

