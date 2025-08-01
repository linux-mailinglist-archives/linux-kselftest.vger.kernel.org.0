Return-Path: <linux-kselftest+bounces-38169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71283B17B62
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 05:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E121C24568
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1F16D9C2;
	Fri,  1 Aug 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4i9Ovht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F178F58;
	Fri,  1 Aug 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017750; cv=none; b=tAaGx25MNw7ziuQk+/Wf+LVlofRPShuIJA24cHuPvKWOKcBSPbSsnM1WXoROMRObxxUj7Bno3//09TuRr+xoeMMlEYhpNe8WORyp4C1BIhZQ1biLTQBMN20Cfs80SLNbnDuv45kM1aVl/2G05TtoFeUemze4Sc5ZkTnw5blXAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017750; c=relaxed/simple;
	bh=8Mfxq5dwPBUl/M7U36C3YDR2x59+cP9MPUOyH03QLIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdoSuQLPCnIAqSxKVraUyf6gTRrYk9RQUt93J/CLNIbevpJ3DGCf9/I3epwe88jiS/HEa/cc8qAOPSd+tAoyou54rQrIRoYjMFLvpaOA1I4Ti/ep0ROr9XRhIRCvLDI6EPH0G2Rrg2VRXD6yc72Atjb8Y8eRG0Ao6dCc5ZJlzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4i9Ovht; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49f21df7-5505-4ce4-9bde-4431bf97831e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754017736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBWx6QhC/Z3ipdqXrlpZTEvlWTyG1IuxqMS3NBan+/0=;
	b=I4i9Ovht/6ttZGHMwtaw4Df8LkCOT9MbgermS2L1+hAAHMbcPM0etP3ncjOxTwBiNuhJ1s
	mnXTlyElz3801w7trgPVOD6VJNoGAxLbq1yJQYo31xuf0bY4jQ+MjNsxKXMEeO1ioPf33p
	Y/7a1K65TGCJY7/8fVKsb0AJR4JDjjk=
Date: Thu, 31 Jul 2025 20:08:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: bpf: Add missing symbol declarations to common
 header
Content-Language: en-GB
To: chenyuan_fl@163.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>
References: <20250801025239.80595-1-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250801025239.80595-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/31/25 7:52 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Fix implicit function declaration errors in bpf_qdisc_xxx.c by adding
> the required kernel symbol declarations to the shared header file
> bpf_qdisc_common.h. This ensures all qdisc BPF programs can properly
> resolve these kernel functions.
>
> The added declarations include:
> - bpf_qdisc_skb_drop
> - bpf_qdisc_bstats_update
> - bpf_kfree_skb
> - bpf_skb_get_hash
> - bpf_qdisc_watchdog_schedule
>
> Using a common header prevents duplication and ensures consistency
> across different qdisc implementations.

If you have proper and recent vmlinux.h (with recent pahole as well during
kernel build), all the above declarations should be in vmlinux.h.
How did you generate your vmlinux.h? Can you just generate a better one
based on recent kernel/pahole?

>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> index 3754f581b328..4c896b3e0f65 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> @@ -14,6 +14,15 @@
>   
>   struct bpf_sk_buff_ptr;
>   
> +extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +			       struct bpf_sk_buff_ptr *to_free_list) __ksym;
> +extern void bpf_qdisc_bstats_update(struct Qdisc *sch,
> +				    const struct sk_buff *skb) __ksym;
> +extern void bpf_kfree_skb(struct sk_buff *skb) __ksym;
> +extern u32 bpf_skb_get_hash(struct sk_buff *skb) __ksym;
> +extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire,
> +					u64 delta_ns) __ksym;
> +
>   static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
>   {
>   	return (struct qdisc_skb_cb *)skb->cb;


