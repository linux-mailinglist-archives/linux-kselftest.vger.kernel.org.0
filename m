Return-Path: <linux-kselftest+bounces-14874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A2794968C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 19:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4816F1F24A3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9945481A3;
	Tue,  6 Aug 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JR1b56KC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F06CDAB;
	Tue,  6 Aug 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964733; cv=none; b=rHY+PAzDked48wBLfQ99P1YkXOW2BQrPGjoxEeH+OEHeO4N5sOb3tHlf5aBIzJo0BV1dxKXL+9A2ZFTKaSiMhF7sfXjNmqREz6470l+7tQaKXf1E376pyXRI8mOBBzTEVeaokOeVpgi3OIAMpW7GZTZ/dMAIbrJnUr90bv61SnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964733; c=relaxed/simple;
	bh=j3DGyvOeNVMM+Y9VVWgxtCrnbBPpGME3Ho2HGmDrCEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJ+CccAPMLt0EKh5jCKlyanh0DVpPZbqy+UvcYAXel+TbDvBRzhLk/C/xhFdNpySvmsYjOFSLIn1vEHTlWiDF7JrDq232KSk5WuZQRuQB0cHPHtSW5T6xuSgbFcvgSj/WWrr5wHyVrpEJNSTwExHRwwn4VbQdgB0WO+zOAB1mIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JR1b56KC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sbNpb-00DnzD-7f; Tue, 06 Aug 2024 19:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=VnDLyf1CoCKPnIiXg884K4FKs8mkGHdtW7ZAbL3tcYw=; b=JR1b56KCeYNC4kTINMB59OA9bH
	bFv3oy7D6acjV92lEq1yIBAJQSB77xF9WXvqlrJ4iU7SsNL8fLXhM0w6Hc4RBdveMQwjxKOXG+hH0
	0hNyZjYPG+iRQjkmcxqRrR46IRwCSNIC2eWruZE76AePwjqJkmzrbDNiAlJszIyb9JYN5KooZYZD3
	vGsk8aqwAVPi4P3rw4cOiLzQZxyI6rsvYJXCBhnW7Z2mvg77KAaRpS7RuH1fmW2LLQilXL8dzsH6p
	6ixkUeRDf4YUEJ0qhHryfmcQLazlyocsq5kNziHV2p7dpe18sEohP0RLRxWcJcmboryvCtTl83tF/
	xi7wwmNw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sbNpa-0007Hk-FH; Tue, 06 Aug 2024 19:18:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sbNpV-002PtH-Nf; Tue, 06 Aug 2024 19:18:37 +0200
Message-ID: <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
Date: Tue, 6 Aug 2024 19:18:31 +0200
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
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <87y159yi5m.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/24 14:01, Jakub Sitnicki wrote:
> On Wed, Jul 31, 2024 at 12:01 PM +02, Michal Luczaj wrote:
>> Series takes care of few bugs and missing features with the aim to improve
>> the test coverage of sockmap/sockhash.
>>
>> Last patch is a create_pair() rewrite making use of
>> __attribute__((cleanup)) to handle socket fd lifetime.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Changes in v2:
>> - Rebase on bpf-next (Jakub)
>> - Use cleanup helpers from kernel's cleanup.h (Jakub)
>> - Fix subject of patch 3, rephrase patch 4, use correct prefix
>> - Link to v1: https://lore.kernel.org/r/20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co
>>
>> Changes in v1:
>> - No declarations in function body (Jakub)
>> - Don't touch output arguments until function succeeds (Jakub)
>> - Link to v0: https://lore.kernel.org/netdev/027fdb41-ee11-4be0-a493-22f28a1abd7c@rbox.co/
>>
>> ---
>> Michal Luczaj (6):
>>       selftests/bpf: Support more socket types in create_pair()
>>       selftests/bpf: Socket pair creation, cleanups
>>       selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
>>       selftests/bpf: Honour the sotype of af_unix redir tests
>>       selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
>>       selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()
>>
>>  .../selftests/bpf/prog_tests/sockmap_basic.c       |  28 ++--
>>  .../selftests/bpf/prog_tests/sockmap_helpers.h     | 149 ++++++++++++++-------
>>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 117 ++--------------
>>  3 files changed, 124 insertions(+), 170 deletions(-)
>> ---
>> base-commit: 92cc2456e9775dc4333fb4aa430763ae4ac2f2d9
>> change-id: 20240729-selftest-sockmap-fixes-bcca996e143b
>>
>> Best regards,
> 
> Thanks again for these fixes. For the series:
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

Great, thanks for the review. With this completed, I guess we can unwind
the (mail) stack to [1]. Is that ingress-to-local et al. something you
wanted to take care of yourself or can I give it a try?

[1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/

Also, I've noticed patchwork still lists (besides this one) the old version
of this series. Am I supposed to tell the bot to disregard it?


