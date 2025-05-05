Return-Path: <linux-kselftest+bounces-32425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C07AA9B92
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128A616F348
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6F25E44C;
	Mon,  5 May 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="yW8pmccQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0B34CF5;
	Mon,  5 May 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469929; cv=none; b=mTbaXv/FVBmzD+k31Oo5aBYbgvE7uWPDz46rS7opVRJgs6DLUujC3192bQeZuDe0xRw8x1B6L1OJwoOJFGa8JdTOmkLeyOhGJ5agRnamacGn2RL7OBx1kXtO7iS1nDVg/nb/7rVlThFHy8OlOAXwXalzsZr08nWtSgD0fPKokdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469929; c=relaxed/simple;
	bh=ACllVkeRB54mPbV0n/ddahc+zIQT7n0unxJjD/9IsiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrR2gsaQKlh6ATgh0oAqGJyCJBO1mz1BzN6mm8eh3ecMKET0a0ccxHLzxrWFTzBh/fnke8022s91xnwluiGfFY02jGw+Lwk1GA1ytY7RFkoKsVy5TaDCvrhVEdyEQbqmYsk9HveBITkDMjx71rgfjCGK8gHrsq7MLhRdI4yCq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=yW8pmccQ; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1746469919; bh=G+rx5YkRQB2m3RpX0Dkv55899VOEaYs/uah1PbfJoNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=yW8pmccQZmfxN/uiui/GsNvYsuT03rI5l+mrjcdBr8Ba/sIQtV3vWyU7uepeyBqlU
	 Fv991SaO8f4A9H4Cs8LHYsaEcvP8iZRw+qZ9sYJmOzltJQexukPzSArDcZ7Rduh3cl
	 evsmAIf4OEVEGBDNIzUEWaCy2Dle4rlovBLNzZrCCWl+KbdfPIlLdK+eGkIvjVfNue
	 0ddGuOxWrA9BnMQxJI7zuSyzVSkw0f+S3FI4ONcmlBPsDt0TG7nyCgq44GGWwq9YLH
	 DV6JcUf0p1lcLcmIG/I/jjQJ6fj+56LZ4DZ+Ie6WbrtZmmetbjEfZhii7Gc6WQWMla
	 S8vi6tD+TLzsg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Zrqqy6XMDz8sgT;
	Mon,  5 May 2025 20:31:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:360f:4200:9271:67e3:d4db:9352
Received: from localhost (unknown [IPv6:2001:9e8:360f:4200:9271:67e3:d4db:9352])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18Yw8S/8gEWPxucUMHgztU2l/wqL20Lctk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Zrqqv4bwgz8t5P;
	Mon,  5 May 2025 20:31:55 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>,  Xu Kuohai
 <xukuohai@huaweicloud.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Hari Bathini <hbathini@linux.ibm.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>,  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
  Mykola Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,
  Henriette Herzog <henriette.herzog@rub.de>,  Saket Kumar Bhaskar
 <skb99@linux.ibm.com>,  Cupertino Miranda <cupertino.miranda@oracle.com>,
  Jiayuan Chen <mrpre@163.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>,  Daniel Xu <dxu@dxuuu.xyz>,  bpf@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kselftest@vger.kernel.org,
  Maximilian Ott <ott@cs.fau.de>,  Milan Stephan <milan.stephan@fau.de>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Move insn if/else into
 do_check_insn()
In-Reply-To: <15294d369d94cf005c9aa722967e5ddb1fa8cee3.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 01 May 2025 11:22:53 -0700")
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
	<20250501073603.1402960-3-luis.gerhorst@fau.de>
	<15294d369d94cf005c9aa722967e5ddb1fa8cee3.camel@gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Mon, 05 May 2025 20:31:54 +0200
Message-ID: <87tt5yhpt1.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Thu, 2025-05-01 at 09:35 +0200, Luis Gerhorst wrote:
> 
>> +		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
>
> Implicitly relying on `insn == &env->prog->insnsi[env->cur_idx]`
> is weird. Still think that `insn` parameter should be dropped and
> computed inside this function instead.
>
>> +				return -EINVAL;
>> +			}
>> +process_bpf_exit_full:
>
> Nit: since we are refactoring I'd extract this as a function instead of goto.

Both done, thanks again for the review and testing!

