Return-Path: <linux-kselftest+bounces-49538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAuvK9DPb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49538-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:56:16 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231749E01
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B6617651DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC144E044;
	Tue, 20 Jan 2026 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kJx9a01k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719E44E03D
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924105; cv=none; b=kFAfR8HY3lzqijop7oZmOc0YMAl9weappYRp5JPzmD2AUIZga4yC2YjOXih236vaRb1FNu5NVdAOhNkJVmVPq97gpQi+no4Gk0AClp1J4pUJmRW6LIjD9n7sl/8KCI3cXMUAwNJMuQuAxfWv/muTj+IH8QDa3mZ699cdSzD9z2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924105; c=relaxed/simple;
	bh=Efu9caATgXLsnG+9j/C3/ytQq8Ix1LHJrzl/rE9RVPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCURYQsCnCFUmHgwX1PQuYEbPNp2wZBCd0Af+YOQFTUrFmhQokr25gjj8gwXxOM14AQaz5MjVBuKOvk0iPa1wHuBUZ5BdfefK27ePf9Hd8zhneQMOIi/wblor8RAGFqbGFVVlkgizrkg06sisEfstrintXDMCdIoVBYDe0iOvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kJx9a01k; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <922f96dc-9093-4f7a-9cbb-32c230856247@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768924091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGRMdJEJX/Nxz+Z5wRxBL43/VPYWLg/rSnSKU0WFCrw=;
	b=kJx9a01kJWJL99iS05+GEUVKQ/5c9+C+ZkwVXqC/NwfY5jzLJ46ptOWwl9jKpemOTOHJnu
	T+K3b3ys0xEat+CzayH7K6zQcTppoa6C0naJJWzzpfXTuO15rxZ3ImhpGv6WZ9byKQPEzo
	XlHH5kdssIR4zLTRibdDQbpxfFULq10=
Date: Tue, 20 Jan 2026 07:48:04 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: wq: fix skel leak in serial_test_wq()
Content-Language: en-GB
To: Kery Qi <qikeyu2017@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, shuah@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yatsenko@meta.com, bentiss@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120091201.1718-2-qikeyu2017@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260120091201.1718-2-qikeyu2017@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49538-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,meta.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yonghong.song@linux.dev,linux-kselftest@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4231749E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/20/26 1:12 AM, Kery Qi wrote:
> When wq__attach() fails, serial_test_wq() returns early without calling
> wq__destroy(), leaking the skeleton resources allocated by
> wq__open_and_load().
>
> Fix this by jumping to a common clean_up label that calls wq__destroy()
> on all exit paths after successful open_and_load.
>
> Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
> Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index 1dcdeda84853..b32e22876492 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -17,11 +17,11 @@ void serial_test_wq(void)
>   
>   	wq_skel = wq__open_and_load();
>   	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
> -		return;
> +		goto clean_up;

This is incorrect. Just doing 'return' is correct. Probably
rename "wq_skel_load" to "wq__open_and_load".

>   
>   	err = wq__attach(wq_skel);
>   	if (!ASSERT_OK(err, "wq_attach"))
> -		goto clean_up
> +		goto clean_up;

Your patch is not on top of latest bpf-next.

>   
>   	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
>   	err = bpf_prog_test_run_opts(prog_fd, &topts);


