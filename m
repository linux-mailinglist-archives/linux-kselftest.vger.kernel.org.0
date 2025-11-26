Return-Path: <linux-kselftest+bounces-46469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D58C87C24
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A8F3B3793
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A832F28F4;
	Wed, 26 Nov 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UMcgR9gD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130214A4F0;
	Wed, 26 Nov 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122472; cv=none; b=nfRouYO1VH1e2ac/HGz/cmtJIx/ZIM+sFZNdFGiOxlGqUpp64lq6fACn6AJq2MiIW7RZ4miFtPeTCvorYqVT9T0Qus7s3T1vcNWq30qrTLRVFsKEhjjAEjm22QDLI6tvVh/hyzSYQM4XPl9OQFV/cnbG1tjNKQktBZr5OnvkukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122472; c=relaxed/simple;
	bh=hWsfBNKNIQFbuEV/ia17BdoQXai91qBsEH6IWXG1IE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbZIGzmnT+WTQnjkFdRRW9uc9yrJYP9I2eo8e/V1yvQxEhFomXkleU3BO7ohlTMFK3xZ+99QLyKS4gwvUvAmM4lmTdwQxXn5HW3bZ9yPQf+MdwSh5+j52ADOMhxa/tC78pmwbv24iScSnsteXWC3bs4lqacYV3TSzyrw1UACbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UMcgR9gD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e764e95-2a50-4a48-9b89-808334460c95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764122457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt3CT8Hp1GWembOoYZy/LhdfSJJK86QtDg+mPBJJITY=;
	b=UMcgR9gDfCKC8wDQj9+S0+yDsRRLRBykEWXwdYuL2JHDG2Q9q4w0rPYgu8zBX0GaB68ZMd
	EPQFUH8dxqZKqsb0Mrt+K4l+Ng9VOxVi+XK1IjTr4JoF+C9kkfI384fCBDk6zbcNeDGG/O
	a41ouvWnMgmNOfj+j7hgbW61wND0fw4=
Date: Wed, 26 Nov 2025 10:00:44 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 4/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>,
 Paul Chaignon <paul.chaignon@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tobias Klauser <tklauser@distanz.ch>,
 kernel-patches-bot@fb.com, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251125145857.98134-1-leon.hwang@linux.dev>
 <20251125145857.98134-5-leon.hwang@linux.dev>
 <CAADnVQJMM+PSq_nDL4rXbC42D+yX5iRo-G_y8qma5+OepcAESw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJMM+PSq_nDL4rXbC42D+yX5iRo-G_y8qma5+OepcAESw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 26/11/25 07:11, Alexei Starovoitov wrote:
> On Tue, Nov 25, 2025 at 7:00 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]
>> @@ -1342,7 +1360,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>>          * to remove older elem from htab and this removal
>>          * operation will need a bucket lock.
>>          */
>> -       if (map_flags != BPF_EXIST) {
>> +       if (!(map_flags & BPF_EXIST)) {
>>                 l_new = prealloc_lru_pop(htab, key, hash);
>>                 if (!l_new)
>>                         return -ENOMEM;
> 
> It's not in the diff, but this is broken.
> You tried to allow BPF_EXIST combination here, but didn't update
> check_flags(),
> 
> so BPF_[NO]EXIST | BPF_F_CPU combination check_flags() will always
> return 0, so BPF_[NO]EXIST flag will make no difference.
> 
> When you add features, always always add unit tests.
> Patch 8 is not it. It's testing F_CPU. It doesn't check
> that BPF_EXIST | BPF_F_CPU correctly errors when an element doesn't exist.
> 
> v10 was close, but then you decided to add this BPF_EXIST feature
> and did it in a sloppy way. Why ?
> Focus on one thing only. Land it and then do the next one.
> 11 revisions and still no go... it is not a good sign.
> 

Yeah, you're right.

The intention of v11 was solely to address the unstable lru_percpu_hash
map test — not to introduce support for the BPF_EXIST combination.

Given that, the approach in v11 was not the right way to fix the
instability. I'll investigate the underlying cause first and then work
on a better fix.

Thanks,
Leon




