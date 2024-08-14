Return-Path: <linux-kselftest+bounces-15335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFF951FFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04705B2E3F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768761B9B40;
	Wed, 14 Aug 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="sQ5edDfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A41B32A2;
	Wed, 14 Aug 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652456; cv=none; b=ZZ/oFFtOtNfKCv8q/hk4OYQMB4hdwB84krTbi5FTlrLwskark5TWQ5FLdTa/VWk/A5CZINAALU/uNXEE9dQtPChG+WzmJOW2j9AXOWKyi/eWbGhOGGUt1mnLGiUXagmVGFrIpefWqKOv3IGl2bmbtvBYgrHqPYjNWK5Qzl3ga/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652456; c=relaxed/simple;
	bh=w6DukgVdh/SeaYiuJZwiSsb19olegSRrDqb9Lls4kO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM6iB/QAt6fJJEAywv2lzfLB4F4cWFXCPN2IEaFjpfJld3oum15y1j4/bhPPTBLPWfLjpe0R/lh97jI+DrFf/F2ER2amIok4v6Ze/6F2rXf0MdaLKz8b1HE02RHJvI4zvN6x+7361DjTFXulc+2J3i1+7RaiwmOY2aQpJ6cnGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=sQ5edDfk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1seGeX-00GwGz-Jl; Wed, 14 Aug 2024 18:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=8gEuZoqquS008o2flgsV7w+43AvF3jk+PJRlBs+g2p0=; b=sQ5edDfkRzc9YUM4Nk/REh0Inu
	f9DlCRgI9C1WcPcuDVa3dOe+fflSCNMCq4Y7cBkeFwBKas6iQCWoBUKkHBV0twXBtYw1a8C3UHYUW
	uSGqZt80FwF3nFxwMq0F9VaQ4qBJ+SxcTQ6ax1+FHFwp5eTi/rq/j23cx1CZG7z4rv3qFhrh0b5zT
	S/2zMG6l5YIzOqUXJMlY9IbRiLYBHtCLFY5VMK3Sj9wwd3gPCbC8jtbl3LcpoeGRWlu0Nmxtuk00P
	ogGYsU8isI2SSBEfsU5PHrczKZbt79pqBDPaF602HapFg9iHTeUTUWxZGq8xlXs6hNa5VzbkmFbRr
	EmNnS9fA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1seGeR-0003LT-GH; Wed, 14 Aug 2024 18:15:07 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1seGeH-00EOaa-Nw; Wed, 14 Aug 2024 18:14:57 +0200
Message-ID: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Date: Wed, 14 Aug 2024 18:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ttfxy28s.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/24 19:45, Jakub Sitnicki wrote:
> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>> Great, thanks for the review. With this completed, I guess we can unwind
>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>> wanted to take care of yourself or can I give it a try?
>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
> 
> I haven't stated any work on. You're welcome to tackle that.
> 
> All I have is a toy test that I've used to generate the redirect matrix.
> Perhaps it can serve as inspiration:
> 
> https://github.com/jsitnicki/sockmap-redir-matrix

All right, please let me know if this is more or less what you meant and
I'll post the whole series for a review (+patch to purge sockmap_listen of
redir tests, fix misnomers). Mostly I've just copypasted your code
(mangling it terribly along the way), so I feel silly claiming the
authorship. Should I assign you as an author?

Note that the patches are based on [2], which has not reached bpf-next
(patchwork says: "Needs ACK").

[2] [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related fixes
    https://lore.kernel.org/bpf/20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co/

