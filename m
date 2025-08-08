Return-Path: <linux-kselftest+bounces-38595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138DFB1EBF9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A33AA1EF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D92283FC8;
	Fri,  8 Aug 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cDJHYLNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC428135B;
	Fri,  8 Aug 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666993; cv=none; b=H8bKXdPbNntKeL6sFNDR8vq1yqC3jW38oqbQfzAb2zzLogIlJk6iZJDQ09Ub6sD5QanrZDBR5mpqv6pwojRRAGL5PWhm6RjYGFqFdebxiyLpMXt+ku25fA5txMFE46JxO9uxW23yj4nnxXWA4aJEAHugPgpSRD+scDFgTn0T7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666993; c=relaxed/simple;
	bh=ey4g2NUIT5aOcnVpF9N36Oho4Ou3AEO7IMDkcVbzPQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFs/IqX29vvD5B6wqwmbFWfksod2Kvky2YV+IQuOR7LWvZP+kReXGN/nR1mAvBlg2bgaMO1mQCkYIGq3rYFv9yQvnla49jZDI5IJcgn8mRBuvGvh2le+1zKf0Uoou3AW9k1m6jHzOn0qSmCSo526qQ47QZpcEka53C8Q4ljTzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cDJHYLNb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786Hj59012569;
	Fri, 8 Aug 2025 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QYMlFQ
	hXpmfuokHWvVf5Bs60oegYe8eR4kbTyYjeB8U=; b=cDJHYLNbxg0VpZdYahJ8/W
	lf7qGiZxTEpW1Si/x3nbaKX+GfL+h6TFzYV8D3MfVSfDZxvP7k/2YpfZZnoX9szc
	QIlKvHrCTZEqEwTADoOemOhhSyN2GMD3aHRRaug2hVY5d3QHj/HrffcmguT5zVjn
	lHqJkz+8jXS1SDtF7sk1QWMfudLgMtp+VOWlv/XIRyiAAHIl2fyjQRGhz4y0pQI+
	SknP7XSuSk4Ag3m1pd+GHVDfA5zIcMLKSOX7cVmIqw0+/t8ldZqwU9FvLf2HO/kB
	Jm6VwbCvPv7j2fWG9XgsqYR9woM3NXxDkOy3Gg4Yq7+YCQ3N6bDX7LXrnZbSLYBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63gt99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:29:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578FNWC4022993;
	Fri, 8 Aug 2025 15:29:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63gt96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:29:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578B1nHa001627;
	Fri, 8 Aug 2025 15:29:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr6638-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 15:29:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578FT8EM48365930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 15:29:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BC482004D;
	Fri,  8 Aug 2025 15:29:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2C3420043;
	Fri,  8 Aug 2025 15:28:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.53.214])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 15:28:55 +0000 (GMT)
Date: Fri, 8 Aug 2025 20:58:51 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [bpf-next 6/6] selftests/bpf: Fix arena_spin_lock selftest
 failure
Message-ID: <aJYXs90cMv/HC9A1@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-7-skb99@linux.ibm.com>
 <CAADnVQ+BoEMQ3i01YpzdNPAaL_mdNogkvHp0Ef73TBG8w726Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BoEMQ3i01YpzdNPAaL_mdNogkvHp0Ef73TBG8w726Zw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=689617ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=nYmg7u0HpnFB9MRoBxcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qKfQXE5FAe8uuZutzC0MDr-01ITegkEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyNSBTYWx0ZWRfX3apCaTCM4h3y
 RwsPokAhyXP7ixMNarr/CBrepDIuwmsq9+jR4B70iPGvRXdCVxJEUpVaMMLafw4C3/UGvOVaMeq
 WOhBC2NDh05Ruzvvt3m3ih57/C0WOULewt60QQ8ZKVUjW1n0Icu2TQ0sfRoWfLGNV3AvHmE9TR/
 v2nDebotBjqEdc+dzkj35cfp4v5bltm2jv+riVzvuCrHr1Yik7+RdueXkmW7qVMdVxV9o7sboeQ
 Q25zHhgUQKirmQYCZdTLfgTIlGWwlQTFRO9xY2vbpQxL7f86XDfih81Cs5tTBcKB9yWEjlSuNsZ
 uCNexkziYJhfyuvfUUv43/Wtml1l24/pipumrrxzEj32h/kpQbAnHqhUhV/8638K+/RkzrugSV6
 NnICziPSYHQOC8ADbXQrPUro4P9Qnk/7wK1GQNNdoravQDtPFGIjXVid0Q+qEwhCBVs64Gac
X-Proofpoint-ORIG-GUID: YaSGBnPJvQM5ai3WuM6YdLJpe-gH6QMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080125

On Thu, Aug 07, 2025 at 03:21:42PM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 4, 2025 at 11:29 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > @@ -60,9 +65,16 @@ static void test_arena_spin_lock_size(int size)
> >                 return;
> >         }
> >
> > -       skel = arena_spin_lock__open_and_load();
> > -       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> > +       skel = arena_spin_lock__open();
> > +       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open"))
> >                 return;
> > +
> > +       skel->rodata->nr_cpus = get_nprocs();
> 
> ...
> 
> > --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> > @@ -20,8 +20,6 @@
> >  #define __arena __attribute__((address_space(1)))
> >  #endif
> >
> > -extern unsigned long CONFIG_NR_CPUS __kconfig;
> > -
> >  /*
> >   * Typically, we'd just rely on the definition in vmlinux.h for qspinlock, but
> >   * PowerPC overrides the definition to define lock->val as u32 instead of
> > @@ -494,7 +492,7 @@ static __always_inline int arena_spin_lock(arena_spinlock_t __arena *lock)
> >  {
> >         int val = 0;
> >
> > -       if (CONFIG_NR_CPUS > 1024)
> > +       if (nr_cpus > 1024)
> >                 return -EOPNOTSUPP;
> 
> We cannot do this. It will make arena_spin_lock much harder to use.
> BPF CI doesn't run on powerpc anyway, but you can document that this
> test is disable by creating selftests/bpf/DENYLIST.powerpc.
Hi Alexie,
Sorry, I did not get it. Can you please help me to understand why it
makes arena_spin_lock harder to use.
Thanks,
Saket

