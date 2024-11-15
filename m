Return-Path: <linux-kselftest+bounces-22110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F99CF094
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C110290F45
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598241E104E;
	Fri, 15 Nov 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J09PLWlb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2301D514B;
	Fri, 15 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685280; cv=none; b=dxBLyIw5Ca5ti4DNXGYrz/DQ8u3Zv8NWjDVNBQ8KE+FCK2njHFUpS9rSWPTKZ6fxkq2vqH1SIlQYez99K/F+LuYytZbH0/iinmuzn1HXeq6OdJJ2dB8EBiVcLyKmA62vRTFn+iUFyaW3H2mUD0mysRWgR0+UQTupJ7o1FgtjmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685280; c=relaxed/simple;
	bh=F0HrlOCDVc0tS4fkIk0rdPU7YPq64z4ioMtMs50nIss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK9MkuOMPrvpjhYzZsUmHQgRcWYZrjlhRnGLRZF4oXiTJ5cWSyu78sqYkrSEcr8TVAnPdkAiZ0J5M36wLr4hjNnrKsj3/9wv7gET7M0eJtpP6OTxnlwujw80GFPse4ZyEoIsZXK+G92feuD6O0itrlPm6yBj4/YCX5uk6bX/q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J09PLWlb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21145812538so16278195ad.0;
        Fri, 15 Nov 2024 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731685278; x=1732290078; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mad4SOqK1QCQ4o/oex/SlfSeha24kQsA2ic3rSWilNk=;
        b=J09PLWlbf62DCWJir0VuXSPzlwfs5QhZc2lwbS2bhnhkjlSKJwxpOCMPtMgf9U2tnA
         NTmADYoHUU+CakC4ToxLLZ2teYd64oAZ38kYjjMEzvO2R7Afub8oZGPd3CjDKSdZ1tWR
         MZDLA7iD+s1cjpv9EoAlPThABpnxCCnNlx6aWn2NnSK7G1Ay/hZqHsstmyUUccpueDwO
         4h2h4waP1UNflakJQkmeZYyAOtc1sgd3I8yE7LpQb8g8dpvAF4mIgA2WvkV2hTk+BOeS
         33Nzl8fsKfYB8E5oiiJ64qAuDhCemKP15KYOEknV8R61a5jBjTI/s55RjRDbtsbZvkf9
         MJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685278; x=1732290078;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mad4SOqK1QCQ4o/oex/SlfSeha24kQsA2ic3rSWilNk=;
        b=lr9uw5spI65kbFxW6Z5YrWn3XunTEvqzU4N1A2thpNnjaKUDEPmt7aItoyTjMvGFyA
         HyjspCF4zqwH6X/8ZjXozIO5qs2h7hozWKxLL/WsPc1TZWwhlny91/h2corKnBc6hfu0
         /xMmo9nTEiKy+FAlEBzoK1itsB2sOfhu/kG8KRyIk1/VQT6w+LgCr2OB84sSH4xItq45
         IBvTXMbxIywnkGC+4s2Gx8QXbZdg23qGCnC4Dm8z+G9qtKXXN2s7G97K64QQm8b9Pg6m
         psgMvV0/bIkj0TXRi22WHf5wJzz1NDYloXFm/L2ePCD/ZugLfCW2KEa9aQMc4FpZADDU
         xNrA==
X-Forwarded-Encrypted: i=1; AJvYcCUJI8BwFZ+J0vRiqKdiC4L0vdV6E8tV7xvseYbMcUbdRidrLVpoMtgcc/KSJp5ASC/77S04Pqnu1yafKKdYA9qb@vger.kernel.org, AJvYcCUsPpvQarTLuKhq5Z46t2ZCYG6RTpJJJc65kExRR//9XrCRNfZ39TrF0sQDCEW46A/H1eFoT579@vger.kernel.org, AJvYcCVwPxo1WOXA7LdhAx7BOxI2UAZ9uBRIQeW7lhiG20yE1JYqjDtsySNuVgLS0O7LaA0039YwkgAb+Ze66+Um@vger.kernel.org, AJvYcCXps6fV4m4IxDeeW2l6hajksWjUPaK9Cwl72P+6ghwHlcyu95/MFf1Z/W92MCovEjNLubk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIFmrIKfPnqbqBzbIbP1C1LTlsx20kSJ1vWAKPvYQqxORaUag
	4RdfoGooyKUyYyHrc71/vkez4gxOXt3EiMgPrs55PMFhkxYtRgM=
X-Google-Smtp-Source: AGHT+IFvSiKK5pXTnS4v7BMtZSxnBSDmRb4ts7GfpqHnQT1u8ZOxciaO6lEhrbKtEKbuENFeyhoGoQ==
X-Received: by 2002:a17:902:e808:b0:20c:e6e4:9daf with SMTP id d9443c01a7336-211d0d65103mr39412615ad.13.1731685277965;
        Fri, 15 Nov 2024 07:41:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f61372sm13526245ad.278.2024.11.15.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:41:17 -0800 (PST)
Date: Fri, 15 Nov 2024 07:41:17 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 07/13] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
Message-ID: <ZzdrnYe0Jf6VwEqB@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-7-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-7-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> Commit a11c397c43d5 ("bpf/flow_dissector: add mode to enforce global BPF
> flow dissector") is currently tested in test_flow_dissector.sh, which is
> not part of test_progs. Add the corresponding test to flow_dissector.c,
> which is part of test_progs. The new test reproduces the behavior
> implemented in its shell script counterpart:
> - attach a  flow dissector program to the root net namespace, ensure
>   that we can not attach another flow dissector in any non-root net
>   namespace
> - attach a flow dissector program to a non-root net namespace, ensure
>   that we can not attach another flow dissector in root namespace
> 
> Since the new test is performing operations in the root net namespace,
> make sure to set it as a "serial" test to make sure not to conflict with
> any other test.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

