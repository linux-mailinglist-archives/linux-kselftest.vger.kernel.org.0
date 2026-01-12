Return-Path: <linux-kselftest+bounces-48714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31510D10A95
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 06:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9573038073
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D430F532;
	Mon, 12 Jan 2026 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o4kjtN8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07830F80F;
	Mon, 12 Jan 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768197174; cv=none; b=uwzrmAiuMB/oPZ0KBTDyqM0YVIabSTZMFzsEEeMG+bA3gddygi2deWU3dv7mfHipc1XqG5XA8hSMV+EkysCaSyis1WYfZnD26uC/STJqOHAu4ou8F3pXn+XL6qKMZ4ZMaXPPGrUu7/GI07lTQ80TQEVI2+klB6314y7sUANm/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768197174; c=relaxed/simple;
	bh=DIlgZ41C5DXD3qjouLC3u/aY7lWRHIKK4ScA2APJXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXMMIeggWH0LYnt1WccWXJT6fTgS2PI352RIvXqLJHtmK0qsEcQbRwX+dEUzUDjb6uhPors+LBi2LqEOoHJWqdOgVRFiLNsikEjyqtBvKutceHtdfCI6aT7jYYGlWqkvEmDzqme7bQGjDnpx1bpmG/XJKlZj+Povy8ZMEsWfAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o4kjtN8r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BAZi6h004230;
	Mon, 12 Jan 2026 05:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+Ua6pb9zOj2M4q9+0KWg2eiG6oHegv
	QJ8kdvcdM9eiU=; b=o4kjtN8r0vs6DVRx+xbFwkzsRT5dXR84L9TugWAUjUPyHU
	3SCLTinbFkzqqFJLSQ7hMH2RsdIFHtf5+8aR2ekZmGrptfcChyvr0KI1CVNo+fth
	kSLoDSFMrMaCN5NFzGoAEQ//L3+imBPXL8EJ48HZCsKRDgwgvgGYhwBEIGAMX/s0
	S46FvjbtQCZeTyOVNYKr+/j2EX9HIcHlKX+ciw/6T70Z90ZKJfnmkzYGtA6JLJv3
	1RVBkOMTWZS8spOtBvFdOqJzvXPUMvOpP3Hja6/MAgmeQL8VYzl3Fy/StaaSEEpp
	F5oLCEf2jokGj7TD4nFA2yg/Cl4XVYtTzE3s8kzw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92nnyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 05:52:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C5q8EQ027755;
	Mon, 12 Jan 2026 05:52:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92nny9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 05:52:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C2afT7031255;
	Mon, 12 Jan 2026 05:52:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1c1vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 05:52:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60C5q3Pl49349064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 05:52:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B76A20040;
	Mon, 12 Jan 2026 05:52:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93C8F2004B;
	Mon, 12 Jan 2026 05:51:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.207.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 05:51:57 +0000 (GMT)
Date: Mon, 12 Jan 2026 11:21:24 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: Re: [PATCH 5/6] powerpc64/bpf: Support exceptions
Message-ID: <aWSL3DlSf5WA20lf@linux.ibm.com>
References: <20260105105212.136645-1-adubey@linux.ibm.com>
 <20260105105212.136645-6-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105105212.136645-6-adubey@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: we4GdtOeD-dhZUz5j0NAl3H0r_dggRXt
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=69648c08 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DU0EyFXtAAAA:8 a=VnNF1IyMAAAA:8 a=7eL7mY7D3S2MA_tuV2QA:9 a=CjuIK1q_8ugA:10
 a=UCR5be5CC-YrbG9FbbB0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA0NCBTYWx0ZWRfX1WygZDgOZfq8
 se7HPSblEQrJUIta9i5pxpR8KEyDMyeZF31Dg3AyEFf6Gnu/OQJ+kRYxihBXtSpXeROmgLNRybv
 ZdyLBJxcnPHCdVeE21jaGsBWP3gF6Kb0WJtZC5h8aEBxg350TkcCQi3BnA8zuvRbn9nwCOQRb9F
 QKxmNR8hDTiazMZPOkeaFK42wLqeTB2YSzDPKOh4tbchQKayjNyRv4rKqHMt1uad1ecBtwMnYam
 P2HwewQy+7bPnN2W0yYsy0q7X9s+mJqQx7NgnXcYpKx3uVp7WavVLfOiBQ4i+ZKlvSlgUePTYOK
 rSOx0vlKQGw+bIxWU++rUTcwLi6cjg+GxwnppM0MhzUuZ1uUF39cVMTh+H0RAwxLZzg6Qz5lNOP
 Kovns+QMjhBYuYwbMzZzPymLo7zIsKqkY8TyFG4x4rWHuyG1IlGB3GOPVl7fzRHx2OB3zMxfydh
 0UVtH1cTio0hq5aFYzw==
X-Proofpoint-GUID: 1jrOj4XPgVEdzEJJUopexmaPWOwuRB1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120044

On Mon, Jan 05, 2026 at 04:22:11PM +0530, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The modified prologue/epilogue generation code now
> enables exception-callback to use the stack frame of
> the program marked as exception boundary, where callee
> saved registers are stored.
> 
> As per ppc64 ABIv2 documentation[1], r14-r31 are callee
> saved registers. BPF programs on ppc64 already saves
> r26-r31 registers. Saving the remaining set of callee
> saved registers(r14-r25) is handled in the next patch.
> 
> [1] https://ftp.rtems.org/pub/rtems/people/sebh/ABI64BitOpenPOWERv1.1_16July2015_pub.pdf
> 
> Following is exceptions selftest result on ppc64le:
> 
> # ./test_progs -t exceptions
> #100/1   exceptions/exception_throw_always_1:OK
> #100/2   exceptions/exception_throw_always_2:OK
> #100/3   exceptions/exception_throw_unwind_1:OK
> #100/4   exceptions/exception_throw_unwind_2:OK
> #100/5   exceptions/exception_throw_default:OK
> #100/6   exceptions/exception_throw_default_value:OK
> #100/7   exceptions/exception_tail_call:OK
> #100/8   exceptions/exception_ext:OK
> #100/9   exceptions/exception_ext_mod_cb_runtime:OK
> #100/10  exceptions/exception_throw_subprog:OK
> #100/11  exceptions/exception_assert_nz_gfunc:OK
> #100/12  exceptions/exception_assert_zero_gfunc:OK
> #100/13  exceptions/exception_assert_neg_gfunc:OK
> #100/14  exceptions/exception_assert_pos_gfunc:OK
> #100/15  exceptions/exception_assert_negeq_gfunc:OK
> #100/16  exceptions/exception_assert_poseq_gfunc:OK
> #100/17  exceptions/exception_assert_nz_gfunc_with:OK
> #100/18  exceptions/exception_assert_zero_gfunc_with:OK
> #100/19  exceptions/exception_assert_neg_gfunc_with:OK
> #100/20  exceptions/exception_assert_pos_gfunc_with:OK
> #100/21  exceptions/exception_assert_negeq_gfunc_with:OK
> #100/22  exceptions/exception_assert_poseq_gfunc_with:OK
> #100/23  exceptions/exception_bad_assert_nz_gfunc:OK
> #100/24  exceptions/exception_bad_assert_zero_gfunc:OK
> #100/25  exceptions/exception_bad_assert_neg_gfunc:OK
> #100/26  exceptions/exception_bad_assert_pos_gfunc:OK
> #100/27  exceptions/exception_bad_assert_negeq_gfunc:OK
> #100/28  exceptions/exception_bad_assert_poseq_gfunc:OK
> #100/29  exceptions/exception_bad_assert_nz_gfunc_with:OK
> #100/30  exceptions/exception_bad_assert_zero_gfunc_with:OK
> #100/31  exceptions/exception_bad_assert_neg_gfunc_with:OK
> #100/32  exceptions/exception_bad_assert_pos_gfunc_with:OK
> #100/33  exceptions/exception_bad_assert_negeq_gfunc_with:OK
> #100/34  exceptions/exception_bad_assert_poseq_gfunc_with:OK
> #100/35  exceptions/exception_assert_range:OK
> #100/36  exceptions/exception_assert_range_with:OK
> #100/37  exceptions/exception_bad_assert_range:OK
> #100/38  exceptions/exception_bad_assert_range_with:OK
> #100/39  exceptions/non-throwing fentry -> exception_cb:OK
> #100/40  exceptions/throwing fentry -> exception_cb:OK
> #100/41  exceptions/non-throwing fexit -> exception_cb:OK
> #100/42  exceptions/throwing fexit -> exception_cb:OK
> #100/43  exceptions/throwing extension (with custom cb) -> exception_cb:OK
> #100/44  exceptions/throwing extension -> global func in exception_cb:OK
> #100/45  exceptions/exception_ext_mod_cb_runtime:OK
> #100/46  exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
> #100/47  exceptions/exception_ext:OK
> #100/48  exceptions/non-throwing fentry -> non-throwing subprog:OK
> #100/49  exceptions/throwing fentry -> non-throwing subprog:OK
> #100/50  exceptions/non-throwing fentry -> throwing subprog:OK
> #100/51  exceptions/throwing fentry -> throwing subprog:OK
> #100/52  exceptions/non-throwing fexit -> non-throwing subprog:OK
> #100/53  exceptions/throwing fexit -> non-throwing subprog:OK
> #100/54  exceptions/non-throwing fexit -> throwing subprog:OK
> #100/55  exceptions/throwing fexit -> throwing subprog:OK
> #100/56  exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
> #100/57  exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
> #100/58  exceptions/non-throwing extension -> non-throwing subprog:OK
> #100/59  exceptions/non-throwing extension -> throwing subprog:OK
> #100/60  exceptions/non-throwing extension -> non-throwing subprog:OK
> #100/61  exceptions/non-throwing extension -> throwing global subprog:OK
> #100/62  exceptions/throwing extension -> throwing global subprog:OK
> #100/63  exceptions/throwing extension -> non-throwing global subprog:OK
> #100/64  exceptions/non-throwing extension -> main subprog:OK
> #100/65  exceptions/throwing extension -> main subprog:OK
> #100/66  exceptions/reject_exception_cb_type_1:OK
> #100/67  exceptions/reject_exception_cb_type_2:OK
> #100/68  exceptions/reject_exception_cb_type_3:OK
> #100/69  exceptions/reject_exception_cb_type_4:OK
> #100/70  exceptions/reject_async_callback_throw:OK
> #100/71  exceptions/reject_with_lock:OK
> #100/72  exceptions/reject_subprog_with_lock:OK
> #100/73  exceptions/reject_with_rcu_read_lock:OK
> #100/74  exceptions/reject_subprog_with_rcu_read_lock:OK
> #100/75  exceptions/reject_with_rbtree_add_throw:OK
> #100/76  exceptions/reject_with_reference:OK
> #100/77  exceptions/reject_with_cb_reference:OK
> #100/78  exceptions/reject_with_cb:OK
> #100/79  exceptions/reject_with_subprog_reference:OK
> #100/80  exceptions/reject_throwing_exception_cb:OK
> #100/81  exceptions/reject_exception_cb_call_global_func:OK
> #100/82  exceptions/reject_exception_cb_call_static_func:OK
> #100/83  exceptions/reject_multiple_exception_cb:OK
> #100/84  exceptions/reject_exception_throw_cb:OK
> #100/85  exceptions/reject_exception_throw_cb_diff:OK
> #100/86  exceptions/reject_set_exception_cb_bad_ret1:OK
> #100/87  exceptions/reject_set_exception_cb_bad_ret2:OK
> #100/88  exceptions/check_assert_eq_int_min:OK
> #100/89  exceptions/check_assert_eq_int_max:OK
> #100/90  exceptions/check_assert_eq_zero:OK
> #100/91  exceptions/check_assert_eq_llong_min:OK
> #100/92  exceptions/check_assert_eq_llong_max:OK
> #100/93  exceptions/check_assert_lt_pos:OK
> #100/94  exceptions/check_assert_lt_zero:OK
> #100/95  exceptions/check_assert_lt_neg:OK
> #100/96  exceptions/check_assert_le_pos:OK
> #100/97  exceptions/check_assert_le_zero:OK
> #100/98  exceptions/check_assert_le_neg:OK
> #100/99  exceptions/check_assert_gt_pos:OK
> #100/100 exceptions/check_assert_gt_zero:OK
> #100/101 exceptions/check_assert_gt_neg:OK
> #100/102 exceptions/check_assert_ge_pos:OK
> #100/103 exceptions/check_assert_ge_zero:OK
> #100/104 exceptions/check_assert_ge_neg:OK
> #100/105 exceptions/check_assert_range_s64:OK
> #100/106 exceptions/check_assert_range_u64:OK
> #100/107 exceptions/check_assert_single_range_s64:OK
> #100/108 exceptions/check_assert_single_range_u64:OK
> #100/109 exceptions/check_assert_generic:OK
> #100/110 exceptions/check_assert_with_return:OK
> #100     exceptions:OK
> Summary: 1/110 PASSED, 0 SKIPPED, 0 FAILED
> 
It would be great to include this selftest output in the cover letter
instead, since it makes the git log excessively long.

Thanks,
Saket
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit.h        |  2 ++
>  arch/powerpc/net/bpf_jit_comp.c   |  7 ++++
>  arch/powerpc/net/bpf_jit_comp64.c | 53 +++++++++++++++++++++----------
>  3 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 98e8b1f9c2f9..b9316780a501 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -177,6 +177,8 @@ struct codegen_context {
>  	u64 arena_vm_start;
>  	u64 user_vm_start;
>  	bool is_subprog;
> +	bool exception_boundary;
> +	bool exception_cb;
>  };
>  
>  #define bpf_to_ppc(r)	(ctx->b2p[r])
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index b09d294084d4..3c030a7d8e73 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -207,6 +207,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
>  	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
>  	cgctx.is_subprog = bpf_is_subprog(fp);
> +	cgctx.exception_boundary = fp->aux->exception_boundary;
> +	cgctx.exception_cb = fp->aux->exception_cb;
>  
>  	/* Scouting faux-generate pass 0 */
>  	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> @@ -436,6 +438,11 @@ void bpf_jit_free(struct bpf_prog *fp)
>  	bpf_prog_unlock_free(fp);
>  }
>  
> +bool bpf_jit_supports_exceptions(void)
> +{
> +       return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>  bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return IS_ENABLED(CONFIG_PPC64);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 0f3af67914d6..5ec8e3654098 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -85,7 +85,9 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
>  	 * - the bpf program uses its stack area
>  	 * The latter condition is deduced from the usage of BPF_REG_FP
>  	 */
> -	return ctx->seen & SEEN_FUNC || bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP));
> +	return ctx->seen & SEEN_FUNC ||
> +	       bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)) ||
> +	       ctx->exception_cb;
>  }
>  
>  /*
> @@ -180,23 +182,32 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>  		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
>  	}
>  
> -	/*
> -	 * Back up non-volatile regs -- BPF registers 6-10
> -	 * If we haven't created our own stack frame, we save these
> -	 * in the protected zone below the previous stack frame
> -	 */
> -	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
> -		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
> -			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
> +	if (!ctx->exception_cb) {
> +		/*
> +		 * Back up non-volatile regs -- BPF registers 6-10
> +		 * If we haven't created our own stack frame, we save these
> +		 * in the protected zone below the previous stack frame
> +		 */
> +		for (i = BPF_REG_6; i <= BPF_REG_10; i++)
> +			if (ctx->exception_boundary || bpf_is_seen_register(ctx, bpf_to_ppc(i)))
> +				EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1,
> +					bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
>  
> -	if (ctx->arena_vm_start)
> -		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
> +		if (ctx->exception_boundary || ctx->arena_vm_start)
> +			EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
>  				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
>  
> -	/* Setup frame pointer to point to the bpf stack area */
> -	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
> -		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
> +		/* Setup frame pointer to point to the bpf stack area */
> +		if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
> +			EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
>  				STACK_FRAME_MIN_SIZE + ctx->stack_size));
> +	} else {
> +		/*
> +		 * Exception callback receives Frame Pointer of main
> +		 * program as third arg
> +		 */
> +		EMIT(PPC_RAW_MR(_R1, _R5));
> +        }
>  
>  	if (ctx->arena_vm_start)
>  		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
> @@ -208,17 +219,25 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>  
>  	/* Restore NVRs */
>  	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
> -		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
> +		if (ctx->exception_cb || bpf_is_seen_register(ctx, bpf_to_ppc(i)))
>  			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
>  
> -	if (ctx->arena_vm_start)
> +	if (ctx->exception_cb || ctx->arena_vm_start)
>  		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
>  				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
>  
> +	if (ctx->exception_cb) {
> +		/*
> +		 * LR value from boundary-frame is received as second parameter
> +		 * in exception callback.
> +		 */
> +		EMIT(PPC_RAW_MTLR(_R4));
> +	}
> +
>  	/* Tear down our stack frame */
>  	if (bpf_has_stack_frame(ctx)) {
>  		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
> -		if (ctx->seen & SEEN_FUNC) {
> +		if (ctx->seen & SEEN_FUNC || ctx->exception_cb) {
>  			EMIT(PPC_RAW_LD(_R0, _R1, PPC_LR_STKOFF));
>  			EMIT(PPC_RAW_MTLR(_R0));
>  		}
> -- 
> 2.48.1
> 

