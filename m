Return-Path: <linux-kselftest+bounces-45422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E075C52F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 16:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F02E8353DA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5C33AD90;
	Wed, 12 Nov 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZM5o36Lo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFD2459E7;
	Wed, 12 Nov 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960159; cv=none; b=VGbFIeXJoeJgI5Y52PiyG0h88l7wfwJ6gnz4wPdvIy5NmUaq2EBlWgdWLrNCzjElLtJtj8WVTTZ2GvDRRHmd4/E6nrViD7McEUwwJ6buPU33jAHlpvR0XZ1GYGLxW2tSZi/Y/bsH3Tkk1qFdlEvkxfVXbSTyu5wwlFV1YJkhbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960159; c=relaxed/simple;
	bh=EOsYLM4jkVuCd6Ab8SiFkYlb/lREZ5MG+YmePBrNKiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt6/qVr5ugpIPLhGKAx/QEpv5+Mi+SKSwSwsffZ0hH7N2LuAYgE6K5b4CHSUGMedqaLqK+HFrRM0cdJF9j0MwJntbWPiDYjNh/Ax2PwWx7QkireDl1gxOKwQyPbhgFGiqufpbqIobRdHYtckXbnVOQFjynOA1dfuMVZ+860jFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZM5o36Lo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACCt26S018118;
	Wed, 12 Nov 2025 15:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=szPLnR
	rWfUJugkl7thDyzM1czIHr4xo3z6y/Aijgk+M=; b=ZM5o36LodgJhj0uedvGUeZ
	v/L8VyjUBc6BngG89kfi4XYzB8fDDygW15s4Jo7gyd5fVUf4AVmsN+kuIHHXGERM
	Ej/4/VIEotEHFPcloBr/Cun4HqhmKYKCftD1w7rUfchDNn80MkaEbRH9Zox4eB2J
	KdaZGO3z6/KeiKAMhKibPO186Q5NssTeDqRriMRBSV8BXzgkFUhOOB40BQ1M/umD
	4TwP6LevUWFssJeiUNCwMtySooCUNwk+xd3CuLvBQGLK5p16KZxg0JPzrK7+MarZ
	gV5MicbHqf+ZuVinbgTMdMHjqbUUU+JTcEZbsRJv0bxhB/8RFUKHK3UYwbepK7xw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj9xuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:08:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACF8AIn014228;
	Wed, 12 Nov 2025 15:08:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj9xub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:08:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDMSpl014779;
	Wed, 12 Nov 2025 15:08:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk8t33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:08:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACF8glV31195614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4931F20043;
	Wed, 12 Nov 2025 15:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3F9B20040;
	Wed, 12 Nov 2025 15:08:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.96.111])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Nov 2025 15:08:32 +0000 (GMT)
Date: Wed, 12 Nov 2025 20:38:28 +0530
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
Message-ID: <aRSi7MADBZBoLLEP@linux.ibm.com>
References: <20251106052628.349117-1-skb99@linux.ibm.com>
 <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com>
 <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6914a300 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=RZxBdpj2Tgkvij4P3TgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX3g5Sr4ZsYzUj
 ZyTCt7di7cajeN5HFnRqCjdx43/tzCICbMtH1CaFA33mx+XABTNvNvOk/CAbnQhe2aK43fQX7OO
 A8dkMpYq1oJFdWtj6COf5Tga8hKH0n4v46F7WrgZlpAEO+XbQlykaUcAPdRjZeGqonnUg9nSFQ+
 CWflEtBM9MKxw+0kU2agFez6mNNGH6SB4ul1G+Xy3zWOZYOl2yCFybGQJcoMbVQGXEs+jD7Va76
 5uykdrsByqUy4b7aLvg/HOaQRArjKOGKMQSmgqj/MrZ7YfF42ajb4ZN517ap7CQ4byWXSUKjKSk
 1bQoLwWL5bSB7e7nBROwjVkbmvLee3ZasN0KZ9hClPphhdEUZquthR2+8niZEiglRoJ34jRBRV/
 7Gwyjy9e/BZLCn3hyINONVESz1opzg==
X-Proofpoint-GUID: pZ9jvzfCCL6Y7RuU6Udfz9eWqzX-CQpG
X-Proofpoint-ORIG-GUID: OuBY010cDRfZuPi7CvidCOtA-w3JWnVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

On Tue, Nov 11, 2025 at 10:35:39AM -0800, Alexei Starovoitov wrote:
> On Tue, Nov 11, 2025 at 6:33 AM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 9:26 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> > > >
> > > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
> > > > the updated path on re-entrancy now reports deadlock via
> > > > -EDEADLK instead of the previous -EBUSY.
> > > >
> > > > The selftest is updated to align with expected errno
> > > > with the kernel’s current behavior.
> > > >
> > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > index 2bc85f4814f4..98d52bb1446f 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > > >         if (!ASSERT_OK(err, "add element"))
> > > >                 goto out;
> > > >
> > > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> > >
> > > Makes sense, but looks like the test was broken for quite some time.
> > > It fails with
> > >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
> > > will return -ESRCH */
> > >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> > >         err = htab_update__load(skel);
> > >         if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
> > >
> > > before reaching deadlk check.
> > > Pls make it more robust.
> > > __pcpu_freelist_pop() might be better alternative then lookup_elem_raw().
> > >
> > > pw-bot: cr
> >
> > Hi Alexei,
> >
> > I tried for __pcpu_freelist_pop, looks like it is not good candidate to
> > attach fentry for, as it is non traceable:
> >
> > trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
> >
> > I wasn't able to find any other function for this.
> 
> alloc_htab_elem() is not inlined for me.
> bpf_obj_free_fields() would be another option.
Since alloc_htab_elem() is a static function, wouldn’t its
inlining behavior be compiler-dependent?

static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
                                         void *value, u32 key_size, u32 hash,
                                         bool percpu, bool onallcpus,
                                         struct htab_elem *old_elem)

When the fentry program is instead attached to bpf_obj_free_fields(),
the bpf_map_update_elem() call returns 0 rather than -EDEADLK, 
because bpf_obj_free_fields() is not invoked in the bpf_map_update_elem() 
re-entrancy path:

./test_progs -t htab_update/reenter_update -v
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_reenter_update:PASS:htab_update__open 0 nsec
test_reenter_update:PASS:htab_update__load 0 nsec
test_reenter_update:PASS:htab_update__attach 0 nsec
test_reenter_update:PASS:add element 0 nsec
test_reenter_update:FAIL:no reentrancy unexpected no reentrancy: actual 0 != expected -35
#143/1   htab_update/reenter_update:FAIL
#143     htab_update:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
Successfully unloaded bpf_testmod.ko.

