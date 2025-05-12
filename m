Return-Path: <linux-kselftest+bounces-32862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B39AB3CE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0634C3AEE4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C824677D;
	Mon, 12 May 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZmRysR/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7B246333;
	Mon, 12 May 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065733; cv=none; b=qs7UbJxUbbabn1tLU8F4PU6v3jFqhwIv/QtxPasrvE7K2sLKHabfBIPc73+L/nI/+XJTyUPhsncAAk+Ovk1XrRntjjaWjMqe51oWfViPh9VPIF44L6wy8nchLPDSDjoA8Q3mBN7dWXNtg+71nL3Ja2+BTJxGnpy9q/1UXiPKjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065733; c=relaxed/simple;
	bh=+dtNDq8JdWpoZSwzwIh6d8nZ0BLajzNUKA6ws+hcvJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8J9J4B8AebnIMVKifzKEwbSQvohqhTk6Vx/tOoFXJz7XKICG+RrZk1/aroGRwy/dpyTs17ELsEd1T1E/CUcqUiMRjuQtv++WbfolVNIcKGlYI1Xgo+ODNr/30M9vsKh5/QF7spAyD0FTk1znGxEhf0fZ37Hll1O4fXtRCMhTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZmRysR/w; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2bd2bd0-cb0f-4eef-896e-f1569b40243f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747065727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2zAFQNz0bghz2/85QYfjphfPosBf1kHql5f0jIwCo8=;
	b=ZmRysR/wKLdb7+g1mzsNpBR05OzJPFedyOjTHQDaX+CSf4XO5OaaDRMx9BTaPLzf+m5txr
	vqo+3HmYchHxiuFWPEXRFWimqTGOPHqVA4+nT7QBHboegUwkmx2rahPA8VGOsk5ilu2qjI
	epmBe0dsNuc/pMZtzzFUGeFnchzzBow=
Date: Tue, 13 May 2025 00:01:50 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kafai Wan <mannkafai@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250426160027.177173-1-mannkafai@gmail.com>
 <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
 <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
 <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev>
 <CAADnVQ+FANha0fO_BF+iHJ4iZSCPtDfoUkzR8mMFwOakw8+eCg@mail.gmail.com>
 <f1f23c1a-f4a8-4807-8028-87e247775ec8@linux.dev>
 <CAEf4BzZcuCrK4UVv2qpp7LAL=uXg+YqFopNW3EzCCpUBNPq-ag@mail.gmail.com>
 <16eafae1-5014-42a9-b6c4-8be40b26cf31@linux.dev>
 <CAADnVQJNekoXnai0VGOVj8Q3e5RPtTXhNRjdfxF_PxjoQLDYRA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJNekoXnai0VGOVj8Q3e5RPtTXhNRjdfxF_PxjoQLDYRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/5/12 23:25, Alexei Starovoitov wrote:
> On Mon, May 12, 2025 at 4:12 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>>
>> However, since bpf_rdonly_cast() is a kfunc, it causes registers r1–r5
>> to be considered volatile.
> 
> It is not.
> See:
> BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL)
> and relevant commits.

Thanks for the reminder — you're right, bpf_rdonly_cast() is marked with
KF_FASTCALL, so it doesn't make r1–r5 volatile.

Thanks,
Leon


