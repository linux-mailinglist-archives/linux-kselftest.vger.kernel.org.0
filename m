Return-Path: <linux-kselftest+bounces-37888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B61B0F851
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8DF586DF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25641FA272;
	Wed, 23 Jul 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbSs6it0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022325D8F0
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288978; cv=none; b=bRRVOwS8h1Aqy13KguI9dw9Mx7JXTEOl0nwwhD1C4VB6ObbEqis8VOCUCEgXAOF5f6U/90ZT0RRw088BEzVHNSR6iJ3xsJqga3wEUKUW0w0V7gKAZRYVsBOlOkwyMy8V49JTVO7sUFruyAqPOInu12yv5ekBUPCOrMubKapXlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288978; c=relaxed/simple;
	bh=weu515HxAHkuURPK86yXG/FVJJzKF9VdctGDpT2Tfw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GeQguI4a80mTm7XRp1Z3QnKEiFat174xSMbLAeSYw9+DmOGOiCFV/z2951HUR8+BYJJYcUvbrcyMPw2gpOpUETCNOKz75ruQ2D5jtuZjUBWbR9tNhmdEXtaJL++CLOaILIDHNQO/ewHwriFo2w7uFALow7uc4bFl6lL5TZ6WUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbSs6it0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af8ceac7-851c-438d-8112-c1586427f58a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8p3PgGx5kkSzSoyRaIEX9Hr5sjraoOmV1Zy/tziPlHM=;
	b=PbSs6it0tQ0Da21CUeFQxpFuNARhw1hxqMBnxLncorDOABNrr7lxhH1tJzV8wQ6RTpWUhk
	HL23U4KCEowdH3tCkS/AT8txUd9Py0VO8x/IHn+QAYAdRBjWBFVNCR/oqql+sbPPYsXXmM
	DMsH4LyH20OOAhb7raU0WJbHae4NHAo=
Date: Wed, 23 Jul 2025 09:42:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add selftest for attaching
 tracing programs to functions in deny list
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-4-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-4-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> The result:
>
>   $ tools/testing/selftests/bpf/test_progs -t tracing_failure/tracing_deny
>   #468/3   tracing_failure/tracing_deny:OK
>   #468     tracing_failure:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

LGTM but see a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../bpf/prog_tests/tracing_failure.c          | 33 +++++++++++++++++++
>   .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> index a222df765bc3..140fb0d175cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> @@ -28,10 +28,43 @@ static void test_bpf_spin_lock(bool is_spin_lock)
>   	tracing_failure__destroy(skel);
>   }
>   
> +static void test_tracing_deny(void)
> +{
> +	struct tracing_failure *skel;
> +	char log_buf[256];
> +	int btf_id, err;
> +
> +	/* migrate_disable depends on CONFIG_SMP */
> +	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
> +	if (btf_id <= 0) {
> +		test__skip();
> +		return;
> +	}

There is a discussion about inlining migrate_disable(). See
   https://lore.kernel.org/bpf/CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com/

Maybe trying to find a different function? Otherwise, if migrate_disable
is inlined and this test will become useless.

> +
> +	skel = tracing_failure__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.tracing_deny, true);
> +	bpf_program__set_log_buf(skel->progs.tracing_deny, log_buf, sizeof(log_buf));
> +
> +	err = tracing_failure__load(skel);
> +	if (!ASSERT_ERR(err, "tracing_failure__load"))
> +		goto out;
> +
> +	ASSERT_HAS_SUBSTR(log_buf,
> +			  "Attaching tracing programs to function 'migrate_disable' is rejected.",
> +			  "log_buf");
> +out:
> +	tracing_failure__destroy(skel);
> +}
> +
>   void test_tracing_failure(void)
>   {
>   	if (test__start_subtest("bpf_spin_lock"))
>   		test_bpf_spin_lock(true);
>   	if (test__start_subtest("bpf_spin_unlock"))
>   		test_bpf_spin_lock(false);
> +	if (test__start_subtest("tracing_deny"))
> +		test_tracing_deny();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
> index d41665d2ec8c..dfa152e8194e 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> @@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
>   {
>   	return 0;
>   }
> +
> +SEC("?fentry/migrate_disable")
> +int BPF_PROG(tracing_deny)
> +{
> +	return 0;
> +}


