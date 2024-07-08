Return-Path: <linux-kselftest+bounces-13318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5E92A5AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BCE28149E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EF144D1F;
	Mon,  8 Jul 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EQm+8gvE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2714431B;
	Mon,  8 Jul 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452596; cv=none; b=T8rlZIotmYVnXJoyzxvNC2vjoQOQwQA6U1thCs9e2HjlmQFB/FqZxtVgS5wtl/axtIwKRTN8b0hz0RcucRKf/DuZ12fvRhsdzaWYzdgDQDa957vMHoycI8xdWorSR5e7d89DOOgaWsCldhS56xOPstZMU0Ea3VA/6YzLRG9PQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452596; c=relaxed/simple;
	bh=+WbYP/ASZE0Fc29CvTr3L/Q+sOkCaRxupWDJeEoQrBU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rD/Swy9KADzCosphZF5ZWjM7qZ6AXIPN0exzMM9joxXj6nOUev6lYK/VdgZvzanL22AafBrjiEABlO8Y4ryox9I4Zhy3MVroMPBUkK+BNoRhX/lJtDwW0x7bU7Avf3XpYOW6Gi4wFyS0unE3LXnxwcgpViY+/FMa6XEC1xraclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=EQm+8gvE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=p34bz90eb2CO67g2ifIO9gi0Uadhuo4uIRkThb3fbK8=; b=EQm+8gvE2upzrKgSaRC8+Uu1US
	wrBfoPqGX8PiU+6uFPY9MVtD4jfnM0eUDnJ/NBFIHzHKfTIdpTTKiEfPjDmSLNmeDo3hKM9i+ZKRu
	eMTFr4ENi/T0mLeosoN1uECMjO8e9xXayvS4sKDbMZiKFjbykYe5TEbqmCdj09KOmw5rzFDybhRH1
	za4PxzRqHgFfr06cDEgfwcjNnGKEqBWbD5TCQ95Au6KQANwWq8TStqGiJv/npnTYO3VwavX6YRqgp
	u4KN5PSO4ofTucwotclAEfy8sRenZnoReb6vl7ESjd14Od7JQdBeRSgKMBR6ztn0NRhM7WCfKiK3y
	0k14XJqw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQqJB-000Cue-U4; Mon, 08 Jul 2024 17:29:41 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQqIg-0002ra-13;
	Mon, 08 Jul 2024 17:29:10 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: KP Singh <kpsingh@kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>,
 Florent Revest <revest@google.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
Date: Mon, 8 Jul 2024 17:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

On 7/8/24 5:26 PM, KP Singh wrote:
> On Mon, Jul 8, 2024 at 5:00 PM Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>
>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>>>> fexit_sleep test runs successfully now on the CI so remove it from the
>>>> deny list.
>>>
>>> Do you happen to know which commit fixed it? If yes, might be nice to have it
>>> documented in the commit message.
>>
>> Actually, I never saw this test failing on my local setup and yesterday
>> I tried running it on the CI where it passed as well. So, I assumed that
>> this would be fixed by some commit. I am not sure which exact commit
>> might have fixed this.
>>
>> Manu, Martin
>>
>> When this was added to the deny list was this failing every time and did
>> you have some reproducer for this. If there is a reproducer, I can try
>> fixing it but when ran normally this test never fails for me.
> 
> I think this never worked until
> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.org/
> was merged, FTrace direct calls was blocking tracing programs on ARM,
> since then it has always worked.

Awesome, thanks! I'll add this to the commit desc then when applying.

