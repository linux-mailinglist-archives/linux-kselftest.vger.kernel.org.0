Return-Path: <linux-kselftest+bounces-45320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B76C4E87D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186713A7C71
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B02C2357;
	Tue, 11 Nov 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AkfY1a/R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037F3AA194;
	Tue, 11 Nov 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871661; cv=none; b=GMbMpdp46BX0fr8kK0AIRaG5Kaf7FPgAYo2CdOjz+oqD8bqSfsoWFVEd4RvNATYFk0MUnkT5OH+fQnZnYNxyvHgAtERV8EwUE/cYQEYzP5pJjUpvwDBf60ww8GiuEpYaNteSAYg+OqPI2utPbKnMFaBou1wuCX0BfS6uq3699NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871661; c=relaxed/simple;
	bh=QRHSFphyHuUYSylpfEI4dKY66tc/70I55lMHxyfnGpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/VaeQCQFHnUJM83ossXorHr4qX4qVLGaMAIbZnZSePeTwDHw24IzohZ2LFQsHROAhRrrpNTt/1JKyghJ4bP6h3HYVnIOirxd6y9KRUXuqKncP/zz+isAQbYZbPqPXcaoaYouj1r6INaAsj5l4PwXogp5A/XSlg8FWmf3AfADrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AkfY1a/R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABAbSDj018118;
	Tue, 11 Nov 2025 14:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V89Tf6
	g0YV9pjIIxZUesAqO5uEP7tgPDp5nrZjIpuqU=; b=AkfY1a/R3eqdRs/RcLLkOj
	0nztdkEYPfFwDThJMVeWP8ZRFDBpYE1IUfEk9tAuoqZJiggv4KnsUosdmT3rGl9x
	jubG6oYwG+cTxI3Ju4CFLlazXcyHgiN9sk4qYh6/WE8lNGQfxDkO5d7rYgjP56dN
	ICo5Y5M77za4xFXv/H8NHo+zPG82wBtLL8JD9GrMxH88iT8xlkIyTTFRz3WLKLBW
	AFYj7Lf3i1YZGV4Ye/Ab7T5WxGvTzk2iTXkoNkvjapSydTAMCUTF0lx0DpL+rGIF
	X1/5NAacjbMUdcUTmWGVJ1D8EIhCjjC1IoEuaWRk3dOQg/gizDls/PQ1ovkIDadg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj4csc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 14:33:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABEDiB1023243;
	Tue, 11 Nov 2025 14:33:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj4csa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 14:33:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABE0dX2004770;
	Tue, 11 Nov 2025 14:33:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxu9fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 14:33:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABEX5KS13435236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 14:33:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43CD320040;
	Tue, 11 Nov 2025 14:33:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F80520043;
	Tue, 11 Nov 2025 14:32:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.66.101])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Nov 2025 14:32:55 +0000 (GMT)
Date: Tue, 11 Nov 2025 20:02:51 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
Message-ID: <aRNJE5GRUxdlJbZB@linux.ibm.com>
References: <20251106052628.349117-1-skb99@linux.ibm.com>
 <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69134927 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=LqaeoIZmStsDFBDhuGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX9AGXi2qEsKjd
 qDzXhxAmj9SVp3d2a0D5f39HoknUjaMaKWPUxdV9P4xxfaL2BMHLtDofjJk3bwQQBXsi9/Vx+au
 Zp4FHjbqQzUvc+3Olgy6EbZ6BNdt0uZXD3kYy6WuC8/u4yCGSypLFUDEP5AA7QORm9GWtCFUWzr
 Eo4GhO79zGpnIdfCffhi3o+WXY9j+qNoxncze/1moIkLsw7YTphvRxnWHVmlIZvJglwVQlO+7Xu
 K5CO/iIk9iAJVmtkUmRapiWJebgy7mLxoJLWrFODXywu9j8PjlADAg3zLjDri9dUoWyXvsdauTZ
 4fBExTsy02ywd530taSEVM+Msa0bHI2JcjifEdXik4JhMzQBL0Mp53rFr8NcFDTUJGvXgaTGGSU
 X9QnZw1kRtuz5fWIbxOU7ieDClWHtA==
X-Proofpoint-GUID: F6R7a6B_HyNo9riAeLXlM8vMbN51mwde
X-Proofpoint-ORIG-GUID: DwHQI-apnqWP3kBaZUiseLMPIV9cXMx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 9:26 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
> > the updated path on re-entrancy now reports deadlock via
> > -EDEADLK instead of the previous -EBUSY.
> >
> > The selftest is updated to align with expected errno
> > with the kernel’s current behavior.
> >
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > index 2bc85f4814f4..98d52bb1446f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> >         if (!ASSERT_OK(err, "add element"))
> >                 goto out;
> >
> > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> 
> Makes sense, but looks like the test was broken for quite some time.
> It fails with
>         /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
> will return -ESRCH */
>         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
>         err = htab_update__load(skel);
>         if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
> 
> before reaching deadlk check.
> Pls make it more robust.
> __pcpu_freelist_pop() might be better alternative then lookup_elem_raw().
> 
> pw-bot: cr

Hi Alexei,

I tried for __pcpu_freelist_pop, looks like it is not good candidate to
attach fentry for, as it is non traceable:

trace_kprobe: Could not probe notrace function __pcpu_freelist_pop

I wasn't able to find any other function for this.

Thanks
Saket


