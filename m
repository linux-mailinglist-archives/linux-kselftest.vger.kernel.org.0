Return-Path: <linux-kselftest+bounces-33313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D9ABB578
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 09:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FCC162B16
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086E1DDA09;
	Mon, 19 May 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKQdyONK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14235946;
	Mon, 19 May 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638098; cv=none; b=J/85KtcdgSNJupknJP+jcpTRhekrIyPP9xGHm9n3xXUM/vai5IrH3jwWxlSgUcFLiwcNeS+urIPNKzhQyUpElkc3KZTRYiqQxrkxCr1MEorgwZfZZc/l/r+5q/JdV6DG4KD/kgKBiHMPJxP0ZBmgkw3QR8c+etM+pZX8xxjUxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638098; c=relaxed/simple;
	bh=vNiVoVPUTkOn1R4LseP9nX71xPo9fi1vp1PJ/rn869k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mEtW4tHG2NQldGbL/v9YI+R4r8yWkU7J0YwXMtimXLNAky3psnwIF2bT0g3RQl8bY3VpZNj+Qu5fgqe818Oy/oN/QEBDHqnAcda4jpK0rDllU8rJH8OHOqz92/g/30rsiKh0xq6YjYs3Hpfm6yjOmJ8jpCH3QNIbOBmByV0NzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKQdyONK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IJeeaL016000;
	Mon, 19 May 2025 06:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AEChRQ
	3cYw3UCjbb1oqD8moO8IE8jgsVGQLNpG14ups=; b=aKQdyONKXhvLaSdtRuI+hW
	3aICkAwbfw7NGqKY/BEuL00JwX6dds14qEM+U0P+pXnahdbG5gn90+8v4/ejCL+Y
	CKBwzMRSv4uC+wiULVKiuwd9s2u7oJ1PTv7PlzJhTs4+rmfyauTf4rRpDSZ0Cvxi
	E2FGGKacYI8jj4Kug9fn5JyNzD3QwQgsNQLCoM+tceAayafdVj6+efy/pOUGmss1
	YK65md+G/RuvZlUg/2YcjNTPJJlBRGzkPMdy/cuvao1LhY+W4u3hiXgDrMlM0X15
	v7SQW06S0clVvIy8YSkQE8liUVeZVZxDsfNO1R/BCqm4p4PGH4RsQ/My+zEm6b0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qn68j3xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 06:59:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54J6xsuX006177;
	Mon, 19 May 2025 06:59:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qn68j3xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 06:59:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5GrXj014262;
	Mon, 19 May 2025 06:59:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4st5kxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 06:59:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54J6xnjx56295862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 06:59:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02A6A20147;
	Mon, 19 May 2025 06:59:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11A6F2012F;
	Mon, 19 May 2025 06:59:42 +0000 (GMT)
Received: from [9.78.106.42] (unknown [9.78.106.42])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 06:59:41 +0000 (GMT)
Message-ID: <6dde4d2e-b249-4fb8-a8f6-359cb7c8b0fe@linux.ibm.com>
Date: Mon, 19 May 2025 12:29:41 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 06/11] bpf, arm64, powerpc: Change nospec to
 include v1 barrier
From: Hari Bathini <hbathini@linux.ibm.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Henriette Herzog <henriette.herzog@rub.de>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Jiayuan Chen <mrpre@163.com>, Matan Shachnai <m.shachnai@gmail.com>,
        Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
References: <20250421091802.3234859-1-luis.gerhorst@fau.de>
 <20250421091802.3234859-7-luis.gerhorst@fau.de>
 <d351c0ba-04fa-4764-a3a2-c4a8727aa582@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d351c0ba-04fa-4764-a3a2-c4a8727aa582@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GMw36QXQwyRthu_VuAnZZSFrlc5efPI5
X-Proofpoint-GUID: zh71TRuKhrMTzlDgqFOcRXTquRP3iToP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA2MSBTYWx0ZWRfX7qotaP9KBzNW IUL/DbUBW33FBjqSdwgPTeWvtZTtI0/q2QhlZMADKwz+DiSMh5oZkgFiIrBC576tk3ZilTQ/2No w+Ly+CJltLUwVzFyAaU1ZIDC+qfFyMTzoOVXD2mSNMgpdqrWAiHY7NpKjr/UJoV+JCRpedwDzLZ
 MIwatIryHVrrN/7WhqGYsmSy2K4ZLzxuyVD4+DkIWYjuIw3otUdZqkYSc6vRJ97OjYJY8zz3aD+ blVaTRECvfIh5UUZLVnFSi7V44N5wIV3vBs880uZEvhm5H5LfiL+Ff3mgsiGc6O+7/8SkMKTw62 wPfL7OlrG64cmsi+FaVdwEa8vqKFwrD5YY1r4Nahw3OC7ttXFKKViUitng+Mxl353W20OJnY7u7
 kPcYUe/M1+db99i9pJr3t71w9xExnHnXQvfZrPjGxr00PWVWsSoCwPB+PqVFO+N15ImPXIVX
X-Authority-Analysis: v=2.4 cv=CN4qXQrD c=1 sm=1 tr=0 ts=682ad6eb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=KxtnHP_eebYsle0CoksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=886 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190061



On 18/05/25 4:11 pm, Hari Bathini wrote:
> 
> 
> On 21/04/25 2:47 pm, Luis Gerhorst wrote:
>> This changes the semantics of BPF_NOSPEC (previously a v4-only barrier)
>> to always emit a speculation barrier that works against both Spectre v1
>> AND v4. If mitigation is not needed on an architecture, the backend
>> should set bpf_jit_bypass_spec_v4/v1().
>>
>> As of now, this commit only has the user-visible implication that unpriv
>> BPF's performance on PowerPC is reduced. This is the case because we
>> have to emit additional v1 barrier instructions for BPF_NOSPEC now.
>>
>> This commit is required for a future commit to allow us to rely on
>> BPF_NOSPEC for Spectre v1 mitigation. As of this commit, the feature
>> that nospec acts as a v1 barrier is unused.
>>
>> Commit f5e81d111750 ("bpf: Introduce BPF nospec instruction for
>> mitigating Spectre v4") noted that mitigation instructions for v1 and v4
>> might be different on some archs. While this would potentially offer
>> improved performance on PowerPC, it was dismissed after the following
>> considerations:
>>
>> * Only having one barrier simplifies the verifier and allows us to
>>    easily rely on v4-induced barriers for reducing the complexity of
>>    v1-induced speculative path verification.
> 
> Fair enough.
> 
>>
>> * For the architectures that implemented BPF_NOSPEC, only PowerPC has
>>    distinct instructions for v1 and v4. Even there, some insns may be
>>    shared between the barriers for v1 and v4 (e.g., 'ori 31,31,0' and
>>    'sync'). If this is still found to impact performance in an
>>    unacceptable way, BPF_NOSPEC can be split into BPF_NOSPEC_V1 and
>>    BPF_NOSPEC_V4 later. As an optimization, we can already skip v1/v4
>>    insns from being emitted for PowerPC with this setup if
>>    bypass_spec_v1/v4 is set.
>>
> 
> Agreed.
> 
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Applies to v3 too :)
Let me send for v3..

- Hari

