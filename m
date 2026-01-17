Return-Path: <linux-kselftest+bounces-49229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F975D38DC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2164B300F9E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EF125FA0E;
	Sat, 17 Jan 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQKF1MUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DE4C6C;
	Sat, 17 Jan 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768646062; cv=none; b=lju9q/dIV7F3hrdWfFwhr/ZUf8vlpn7ePQjHx/5hWGaDAp1NA3EZ4Frz+FE+7F47WWN3W/1Sw5pYrSMNps1smhQ57CHh9SkIdKip8MwX0Fdvg7SM5hpdm8wMu1ELPvcL3lKDnkQqxJuq9HCd9BYx00c0js1braG3BN+7rOqIQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768646062; c=relaxed/simple;
	bh=0cMT2vSK0RhUem0dweksjVn5KFYNPKzX3fBEA5/PWd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT8/3OmbYXvzVPv69/P+OuLso9LTiaG6WKDoFH4SjgXDIRCJtvTndtBhMMDZUuBgDSe9jcu9FWhM0/cguqmnNj2shEJl9DXNlrg7EHUgcmFWuCwXj8DMb/jjfHtEVYImt6p5hPLyXWwaArXjSPbV///FXVM0J2H5zV97Qn+6bkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQKF1MUw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H9JW4I002346;
	Sat, 17 Jan 2026 10:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jfz96V
	8k6SSMjW81E9XKE7AhlPEOa1KiwbJI+Du/Lxk=; b=gQKF1MUw4Xi6iV4ZiL7k4E
	qVqJy54/E68gid99cWcAFp4mx4IzJAklWu4fViOfxq97tUPUEfXiVCUy793Y0WXf
	zB6NVhqaUN4fdBqewLlq3GZi9gZvFefhfQAKPydybq63otus+JuJM7TmtfiDGN3g
	S5iKnTMwbAcaRNZCrBjHW7pMJB7JKYXHxgKnI0Za00oJvvI9o85WiOBWG7F5HaD3
	tirEwOG0VsYVJlkE6ZvnegG2u3bFjc/Cwr3NrhuHbGNviXNFZlTEr1SDda1kXGUM
	oRm+Ewmrrx9Gen4DAZRKvlK/hExsfYNH9eX2dUFPqf+GSVI1myBiwaHg3SDRlM1Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255gxj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:33:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60HAXdUi026277;
	Sat, 17 Jan 2026 10:33:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255gxj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:33:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60H5UhU6014083;
	Sat, 17 Jan 2026 10:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bqv8utm14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 10:33:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HAXYMD22937992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 10:33:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF41320043;
	Sat, 17 Jan 2026 10:33:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBD8420040;
	Sat, 17 Jan 2026 10:33:28 +0000 (GMT)
Received: from [9.43.67.105] (unknown [9.43.67.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Jan 2026 10:33:28 +0000 (GMT)
Message-ID: <7c2b6544-8a40-418a-81d5-b74494a36944@linux.ibm.com>
Date: Sat, 17 Jan 2026 16:03:27 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] powerpc64/bpf: Tailcall handling with trampolines
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
References: <20260105105212.136645-1-adubey@linux.ibm.com>
 <20260105105212.136645-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260105105212.136645-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDA4NCBTYWx0ZWRfXwfQVznBx6oy6
 MuvGNjPyLKXQXbdIL2c7kq+kWBgf/j6PRXrpZIDcntlyK+KZkgGY3Vbi5pxra/d0V1CCZNomr4M
 H19dVc0L7DQhy0n4y3eeGN90BNh0ui8VePlfVIhQElhoglIrvrjvzP8tZQEFR1CwDnAuNdXHox7
 U2yy/ZMllDAKN/W8igSbLZuce5VkaGf2nIW1oH20CE1EtcCvs3UVxMDoiWrW4sE0z1VTwxfbeaH
 8kJOy0oyB7pvDbvjoT6FSHNIFkYtCsmU2MxDBmwKOGUbvQQ5IjGtd6MMtijC6Jzy4XcRz9Ig0k4
 8L59be+9E/En6BJ+PPNoJbWVE7KjuhgYAQQua2fTnOXkTbwBiRpRf0qJBRMJSxfRxoUQD+BTL1w
 /V9stI15fJ7DIruewuULMSvDRh9V0kzCcAZV99dIY2MeXrRS4LkJEQDIx6T9CrKlbyxnyb3txhw
 y/UuBvHMM3Mz1PJJSgA==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696b6584 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=v1dMKb2XkRFja0Z4mHIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Lv2punErfHDXv5-vECztRtoPeAYi2K7L
X-Proofpoint-ORIG-GUID: KPye0R8VwpD9Tmf02LIm7x4Eqc6UrH0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_09,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601170084



On 05/01/26 4:22 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> The trampoline mechanism sets up its own stack frame and
> an additional dummy frame. We need to have additional JIT
> instructions handling tailcall dereferencing in the
> trampoline's context.
> 
> We don't add the two stack frames pointed above, rather
> add space for conventional 'non-volatile register save area'
> and tail_call_info in trampoline's frame for ppc64. This
> makes the trampoline's frame consistent with layout of all
> other frames.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 48 ++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 069a8822c30d..4aaa0a287a45 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -606,15 +606,42 @@ static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context
>   	return 0;
>   }
>   
> -static void bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_context *ctx,
> -					       int func_frame_offset, int r4_off)
> +/*
> + * Refer the label 'Generated stack layout' in this file for actual stack
> + * layout during trampoline invocation.
> + *
> + * Refer __arch_prepare_bpf_trampoline() for stack component details.
> + *
> + * The tailcall count/reference is present in caller's stack frame. Its required
> + * to copy the content of tail_call_info before calling the actual function
> + * to which the trampoline is attached.
> + *
> + */
> +
> +static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_context *ctx,
> +					       int func_frame_offset,
> +					       int bpf_dummy_frame_size, int r4_off)
>   {
>   	if (IS_ENABLED(CONFIG_PPC64)) {
>   		/* See bpf_jit_stack_tailcallinfo_offset() */
> -		int tailcallcnt_offset = 7 * 8;

This offset update should be part of patch#1

- Hari

