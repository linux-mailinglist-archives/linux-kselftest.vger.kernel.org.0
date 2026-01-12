Return-Path: <linux-kselftest+bounces-48716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE9D10D5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 08:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADF893014D67
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CB32E68D;
	Mon, 12 Jan 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMZIqTAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0ED32A3F1;
	Mon, 12 Jan 2026 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202399; cv=none; b=SsaxkYgKFUuHvAUxqqBKzlOR+4E3U5RVt1ZP0ihHn2K4qj9IKUl2EsnsS9usl6UwARWWaqMNC9FuRIgzHTv5zsdNqmMxiGLJ3hbGC6H9+2BpN5OeZc+XTWjRaelknbyB7ZAShemJgTJz4JvdNUlnLPu2DknFulJ2DzmZgJe1X6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202399; c=relaxed/simple;
	bh=k5ZWMJroAH9X6RMhuRdisILf2c/lZu6r5O2cLbbc4Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELHRPeFRH3sWjaYFIJaimzXRmJ4vyJn5D6Az2QWKXYL3eMCxzLhJuaQoFdWVrAo1kOjo9xh7wI9vN/VkEC8YXE1KSRrnQkia6vp/hbaUyy59V/CvnQVyTnLHV+HRCKSMWqmdJ4RbUDSVgUu5uNQCuzYiQC/f4yPbi34cNLdgNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMZIqTAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB10C116D0;
	Mon, 12 Jan 2026 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768202398;
	bh=k5ZWMJroAH9X6RMhuRdisILf2c/lZu6r5O2cLbbc4Cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eMZIqTAGXMeBkdP6Gy3xxqAiJKHoBTxBJQXTWn9y/8FxBAap2QqskH4pr73a5dMPZ
	 OKmeOens5OeTThblZDu/hh3vE41wZpapG/hnfDE008cNcR4xUGA+TN35CMn29x0qbG
	 zUE9ciRE8A6GwLQh+PwFS+FGPiH7U2w7ypJOb/4OMTfvU2NOQVuKM0a7fxV3keNtbr
	 /8131lnWyKJIcyWR2plaZcvyV9f230+l7rsrw4Q2tUilCCfj8KfTcFli2QGBef0td5
	 TII2sZa0ebgND5CNNWv8iXtGtC1G+9KDJ9Vy3O/7xWXfyWwbOsMHjWQ+HiirzDkRR7
	 6DB1Sx9+w1zqw==
Message-ID: <d22105ed-01e8-4abd-ade9-86686f48d221@kernel.org>
Date: Mon, 12 Jan 2026 08:19:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] powerpc64/bpf: Support exceptions
To: adubey <adubey@imap.linux.ibm.com>,
 Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20260105105212.136645-1-adubey@linux.ibm.com>
 <20260105105212.136645-6-adubey@linux.ibm.com>
 <aWSL3DlSf5WA20lf@linux.ibm.com>
 <9102a4504413501f382cf3e22118e88f@imap.linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <9102a4504413501f382cf3e22118e88f@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/01/2026 à 07:58, adubey a écrit :
> [Vous ne recevez pas souvent de courriers de adubey@imap.linux.ibm.com. 
> D?couvrez pourquoi ceci est important ? https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> On 2026-01-12 11:21, Saket Kumar Bhaskar wrote:
>> On Mon, Jan 05, 2026 at 04:22:11PM +0530, adubey@linux.ibm.com wrote:
>>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>>
>>> The modified prologue/epilogue generation code now
>>> enables exception-callback to use the stack frame of
>>> the program marked as exception boundary, where callee
>>> saved registers are stored.
>>>
>>> As per ppc64 ABIv2 documentation[1], r14-r31 are callee
>>> saved registers. BPF programs on ppc64 already saves
>>> r26-r31 registers. Saving the remaining set of callee
>>> saved registers(r14-r25) is handled in the next patch.
>>>
>>> [1]
>>> https://eur01.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fftp.rtems.org%2Fpub%2Frtems%2Fpeople%2Fsebh%2FABI64BitOpenPOWERv1.1_16July2015_pub.pdf&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdecf1943ac9949608edb08de51a7f357%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639037978954052961%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=uCfpmnY2bQT7yD3esp8nkyLPGfEzpK9UoCgV2sm0j80%3D&reserved=0
>>>
>>> Following is exceptions selftest result on ppc64le:
>>>
>>> # ./test_progs -t exceptions
>>> #100/1   exceptions/exception_throw_always_1:OK
>>> #100/2   exceptions/exception_throw_always_2:OK
>>> #100/3   exceptions/exception_throw_unwind_1:OK
>>> #100/4   exceptions/exception_throw_unwind_2:OK
>>> #100/5   exceptions/exception_throw_default:OK
>>> #100/6   exceptions/exception_throw_default_value:OK
>>> #100/7   exceptions/exception_tail_call:OK
>>> #100/8   exceptions/exception_ext:OK
>>> #100/9   exceptions/exception_ext_mod_cb_runtime:OK
>>> #100/10  exceptions/exception_throw_subprog:OK
>>> #100/11  exceptions/exception_assert_nz_gfunc:OK
>>> #100/12  exceptions/exception_assert_zero_gfunc:OK
>>> #100/13  exceptions/exception_assert_neg_gfunc:OK
>>> #100/14  exceptions/exception_assert_pos_gfunc:OK
>>> #100/15  exceptions/exception_assert_negeq_gfunc:OK
>>> #100/16  exceptions/exception_assert_poseq_gfunc:OK
>>> #100/17  exceptions/exception_assert_nz_gfunc_with:OK
>>> #100/18  exceptions/exception_assert_zero_gfunc_with:OK
>>> #100/19  exceptions/exception_assert_neg_gfunc_with:OK
>>> #100/20  exceptions/exception_assert_pos_gfunc_with:OK
>>> #100/21  exceptions/exception_assert_negeq_gfunc_with:OK
>>> #100/22  exceptions/exception_assert_poseq_gfunc_with:OK
>>> #100/23  exceptions/exception_bad_assert_nz_gfunc:OK
>>> #100/24  exceptions/exception_bad_assert_zero_gfunc:OK
>>> #100/25  exceptions/exception_bad_assert_neg_gfunc:OK
>>> #100/26  exceptions/exception_bad_assert_pos_gfunc:OK
>>> #100/27  exceptions/exception_bad_assert_negeq_gfunc:OK
>>> #100/28  exceptions/exception_bad_assert_poseq_gfunc:OK
>>> #100/29  exceptions/exception_bad_assert_nz_gfunc_with:OK
>>> #100/30  exceptions/exception_bad_assert_zero_gfunc_with:OK
>>> #100/31  exceptions/exception_bad_assert_neg_gfunc_with:OK
>>> #100/32  exceptions/exception_bad_assert_pos_gfunc_with:OK
>>> #100/33  exceptions/exception_bad_assert_negeq_gfunc_with:OK
>>> #100/34  exceptions/exception_bad_assert_poseq_gfunc_with:OK
>>> #100/35  exceptions/exception_assert_range:OK
>>> #100/36  exceptions/exception_assert_range_with:OK
>>> #100/37  exceptions/exception_bad_assert_range:OK
>>> #100/38  exceptions/exception_bad_assert_range_with:OK
>>> #100/39  exceptions/non-throwing fentry -> exception_cb:OK
>>> #100/40  exceptions/throwing fentry -> exception_cb:OK
>>> #100/41  exceptions/non-throwing fexit -> exception_cb:OK
>>> #100/42  exceptions/throwing fexit -> exception_cb:OK
>>> #100/43  exceptions/throwing extension (with custom cb) ->
>>> exception_cb:OK
>>> #100/44  exceptions/throwing extension -> global func in
>>> exception_cb:OK
>>> #100/45  exceptions/exception_ext_mod_cb_runtime:OK
>>> #100/46  exceptions/throwing extension (with custom cb) -> global func
>>> in exception_cb:OK
>>> #100/47  exceptions/exception_ext:OK
>>> #100/48  exceptions/non-throwing fentry -> non-throwing subprog:OK
>>> #100/49  exceptions/throwing fentry -> non-throwing subprog:OK
>>> #100/50  exceptions/non-throwing fentry -> throwing subprog:OK
>>> #100/51  exceptions/throwing fentry -> throwing subprog:OK
>>> #100/52  exceptions/non-throwing fexit -> non-throwing subprog:OK
>>> #100/53  exceptions/throwing fexit -> non-throwing subprog:OK
>>> #100/54  exceptions/non-throwing fexit -> throwing subprog:OK
>>> #100/55  exceptions/throwing fexit -> throwing subprog:OK
>>> #100/56  exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
>>> #100/57  exceptions/non-throwing fmod_ret -> non-throwing global
>>> subprog:OK
>>> #100/58  exceptions/non-throwing extension -> non-throwing subprog:OK
>>> #100/59  exceptions/non-throwing extension -> throwing subprog:OK
>>> #100/60  exceptions/non-throwing extension -> non-throwing subprog:OK
>>> #100/61  exceptions/non-throwing extension -> throwing global
>>> subprog:OK
>>> #100/62  exceptions/throwing extension -> throwing global subprog:OK
>>> #100/63  exceptions/throwing extension -> non-throwing global
>>> subprog:OK
>>> #100/64  exceptions/non-throwing extension -> main subprog:OK
>>> #100/65  exceptions/throwing extension -> main subprog:OK
>>> #100/66  exceptions/reject_exception_cb_type_1:OK
>>> #100/67  exceptions/reject_exception_cb_type_2:OK
>>> #100/68  exceptions/reject_exception_cb_type_3:OK
>>> #100/69  exceptions/reject_exception_cb_type_4:OK
>>> #100/70  exceptions/reject_async_callback_throw:OK
>>> #100/71  exceptions/reject_with_lock:OK
>>> #100/72  exceptions/reject_subprog_with_lock:OK
>>> #100/73  exceptions/reject_with_rcu_read_lock:OK
>>> #100/74  exceptions/reject_subprog_with_rcu_read_lock:OK
>>> #100/75  exceptions/reject_with_rbtree_add_throw:OK
>>> #100/76  exceptions/reject_with_reference:OK
>>> #100/77  exceptions/reject_with_cb_reference:OK
>>> #100/78  exceptions/reject_with_cb:OK
>>> #100/79  exceptions/reject_with_subprog_reference:OK
>>> #100/80  exceptions/reject_throwing_exception_cb:OK
>>> #100/81  exceptions/reject_exception_cb_call_global_func:OK
>>> #100/82  exceptions/reject_exception_cb_call_static_func:OK
>>> #100/83  exceptions/reject_multiple_exception_cb:OK
>>> #100/84  exceptions/reject_exception_throw_cb:OK
>>> #100/85  exceptions/reject_exception_throw_cb_diff:OK
>>> #100/86  exceptions/reject_set_exception_cb_bad_ret1:OK
>>> #100/87  exceptions/reject_set_exception_cb_bad_ret2:OK
>>> #100/88  exceptions/check_assert_eq_int_min:OK
>>> #100/89  exceptions/check_assert_eq_int_max:OK
>>> #100/90  exceptions/check_assert_eq_zero:OK
>>> #100/91  exceptions/check_assert_eq_llong_min:OK
>>> #100/92  exceptions/check_assert_eq_llong_max:OK
>>> #100/93  exceptions/check_assert_lt_pos:OK
>>> #100/94  exceptions/check_assert_lt_zero:OK
>>> #100/95  exceptions/check_assert_lt_neg:OK
>>> #100/96  exceptions/check_assert_le_pos:OK
>>> #100/97  exceptions/check_assert_le_zero:OK
>>> #100/98  exceptions/check_assert_le_neg:OK
>>> #100/99  exceptions/check_assert_gt_pos:OK
>>> #100/100 exceptions/check_assert_gt_zero:OK
>>> #100/101 exceptions/check_assert_gt_neg:OK
>>> #100/102 exceptions/check_assert_ge_pos:OK
>>> #100/103 exceptions/check_assert_ge_zero:OK
>>> #100/104 exceptions/check_assert_ge_neg:OK
>>> #100/105 exceptions/check_assert_range_s64:OK
>>> #100/106 exceptions/check_assert_range_u64:OK
>>> #100/107 exceptions/check_assert_single_range_s64:OK
>>> #100/108 exceptions/check_assert_single_range_u64:OK
>>> #100/109 exceptions/check_assert_generic:OK
>>> #100/110 exceptions/check_assert_with_return:OK
>>> #100     exceptions:OK
>>> Summary: 1/110 PASSED, 0 SKIPPED, 0 FAILED
>>>
>> It would be great to include this selftest output in the cover letter
>> instead, since it makes the git log excessively long.
>>
>> Thanks,
>> Saket
> 
> Major contributors in the community routinely include test case results
> in commit messages, and this is not viewed as problematic.
> Eg: bpf-next : e59997d9052599feb17419289f2a57ed300e1dfa,

This is a merge commit, the message comes from the cover letter of the 
series: 
https://lore.kernel.org/all/20240201125225.72796-1-puranjay12@gmail.com/

> 6c17a882d3804dce1c66e1fec25f96d39a184067

In this one the list of tests is rather small compared to the entire 
commit message.

So I also recommend to move this big list of tests in the cover letter.

Christophe


