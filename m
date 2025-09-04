Return-Path: <linux-kselftest+bounces-40778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBAB438DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4431C207D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CF2D3731;
	Thu,  4 Sep 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RZeaEfc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198E2EE274;
	Thu,  4 Sep 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982115; cv=none; b=Qbsk0NikRM+A8OvxxGgbocnTIp2nKCTSLnv6stpD5+gavq9hHK2CT+PcmryQFSwGc0OhzzUqnLcwkEbijgw1RSeG807TfHMXnzvSYrDKQn7E+WVKM9d30IZKv1byFq7icGbnYCb/4syn84aTm7TknCVgkCdyAQ5rYltEGkWrcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982115; c=relaxed/simple;
	bh=MYw5hemXFsf9YkMivyrfAhanrM40245m2RvU8spXtIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJk63gBphwXmahmd/K62fgaXQCpq1SEqitjFya4quG+vDHIi7QghQjKEEHGSP3TDM3zU7KhOUkKkgzAewax1lznCFFgDoktIAxSDSI7mIazmvj5A4N8LoViEq4MgnpgnictdwObFVc4vMSnAHl7PvOh0t1it7eIs+ZahDdH0BXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RZeaEfc+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846XDBX005735;
	Thu, 4 Sep 2025 10:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OvDgBHL1QfReUGKYA4TnrNVX3xlVsu
	PP0C+YfIarv60=; b=RZeaEfc+QyLLLd1zPZ+nrjAJbmteGpF+7BUCrhbLCLa7pv
	qg4GXrJW6hqW5dcMxQn0qTwnCDQ9gH6f7XvIuYzF5tMN192PPfSBG0SDZIqXg5tj
	1fZIBiC4ujMcdNNfHkRYmPvzy86U1ud+FYKfCecZT7RJA6ddvlIZp/hW/v9QAkaD
	gAEWsryshCvlMASnhfVHC5pyHgmtMJLUmT3kPI+1Ab3TNOD5Ts26JmpGB9qe4chW
	vTb9j5p949w8iWPeTw6hrpOnb7JQvzKVp3akw6m/Zcst1j374xo4xPSgjRziGa7H
	Gyw+Fq/rboGYPThdTezKcPac4gfPWEVIBaPj94eg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua93bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:34:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584AYiaC021619;
	Thu, 4 Sep 2025 10:34:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usua93be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:34:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5846sw0g019925;
	Thu, 4 Sep 2025 10:34:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmuc916-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:34:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584AYdTh34669154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 10:34:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC3B2004B;
	Thu,  4 Sep 2025 10:34:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA28420043;
	Thu,  4 Sep 2025 10:34:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Sep 2025 10:34:34 +0000 (GMT)
Date: Thu, 4 Sep 2025 16:04:32 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Fix arena_spin_lock
 selftest failure
Message-ID: <aLlrOFzwRZotcpY4@linux.ibm.com>
References: <20250829165135.1273071-1-skb99@linux.ibm.com>
 <20250829165135.1273071-6-skb99@linux.ibm.com>
 <46243c40-8e5e-47d3-97bd-71f29eeb0127@linux.ibm.com>
 <aLlNBK9Zm+N4zarF@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlNBK9Zm+N4zarF@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9n8EctKyMzCe8PS3p37W_1wCfXqHauvi
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b96b44 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=hPZlYmIs_T5Z1BX5r4cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXyNkE/eE9EHWO
 mzrckl80bYebef7rCxE+x1P2GWjYiILUCBT/Q5NxUMLsjxwXCS68+NstCr87T44YyqAWg22C1Ow
 vIvQEbzfT6icQh23JY7FIolv+WkKvyrM2EsAr0iMYFbCKm5x6cXYS7e+hpHzCd/7c0PsjtqPNck
 zVk/WaXuSwRNpZOQG5adBjsfa0XocwxpbqhIqr5q0z9vBBf2ApaSEXqYbbY3FFGJHg4YQbtpqPp
 mQxeLXPktPz8uGMS7+41h6mQnPVfaA1VOT8o0vkJSveq9YbNXA2ikuJ+tnc1L0QNQcuUqUXgO9d
 yDuQzH5tel4jJp+0O7mPhUiy2ZZ9cL/WYoinTDgZ22x6OAuC9Uaq7+zf3CK1CiSubqYyQRHQAqw
 qQyXZ29O
X-Proofpoint-ORIG-GUID: he6RjKqFBXFh-cUXmKn7R90-MiZdl3jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Thu, Sep 04, 2025 at 01:55:40PM +0530, Saket Kumar Bhaskar wrote:
> On Thu, Sep 04, 2025 at 01:39:31PM +0530, Hari Bathini wrote:
> > 
> > 
> > On 29/08/25 10:21 pm, Saket Kumar Bhaskar wrote:
> > > For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
> > > the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.
> > > 
> > > The selftest is skipped incase bpf program returns EOPNOTSUPP,
> > > with a descriptive message logged.
> > > 
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >   .../selftests/bpf/prog_tests/arena_spin_lock.c      | 13 +++++++++++++
> > >   tools/testing/selftests/bpf/progs/arena_spin_lock.c |  5 ++++-
> > >   2 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > > index 0223fce4db2b..1ec1ca987893 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > > @@ -40,8 +40,13 @@ static void *spin_lock_thread(void *arg)
> > >   	err = bpf_prog_test_run_opts(prog_fd, &topts);
> > >   	ASSERT_OK(err, "test_run err");
> > > +
> > > +	if (topts.retval == -EOPNOTSUPP)
> > > +		goto end;
> > > +
> > >   	ASSERT_EQ((int)topts.retval, 0, "test_run retval");
> > > +end:
> > >   	pthread_exit(arg);
> > >   }
> > > @@ -63,6 +68,7 @@ static void test_arena_spin_lock_size(int size)
> > >   	skel = arena_spin_lock__open_and_load();
> > >   	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> > >   		return;
> > > +
> > >   	if (skel->data->test_skip == 2) {
> > >   		test__skip();
> > >   		goto end;
> > > @@ -86,6 +92,13 @@ static void test_arena_spin_lock_size(int size)
> > >   			goto end_barrier;
> > >   	}
> > > +	if (skel->data->test_skip == 2) {
> > > +		printf("%s:SKIP: %d CPUs exceed the maximum supported by arena spinlock\n",
> > > +		       __func__, get_nprocs());
> > > +		test__skip();
> > > +		goto end_barrier;
> > > +	}
> > > +
> > >   	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
> > >   end_barrier:
> > > diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > > index c4500c37f85e..a475b974438e 100644
> > > --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > > +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > > @@ -37,8 +37,11 @@ int prog(void *ctx)
> > >   #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > >   	unsigned long flags;
> > > -	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
> > > +	if ((ret = arena_spin_lock_irqsave(&lock, flags))) {
> > > +		if (ret == -EOPNOTSUPP)
> > > +			test_skip = 2;
> > >   		return ret;
> > 
> > test_skip being set to `1` when the test runs seems counter intuitive.
> > How about setting test_skip to `0` when run conditions are met
> > and test_skip=1 if run conditions are not met and
> > test_skip=2 when operation is not supported?
> > 
> > - Hari
> That seems reasonable to me, but right now -EOPNOTSUPP is also
> returned when run condition is not met i.e.:
> 
>   if (CONFIG_NR_CPUS > 1024)
>                 return -EOPNOTSUPP;
> 
> So do we really need test_skip = 2 ?
> 
> Thanks,
> Saket
Also, when test_skip is initialized to 0 it is moved to bss segment 
from data segment:

        struct arena_spin_lock__arena {
                struct arena_qnode qnodes[1024][4];
                struct __qspinlock lock;
        } *arena;
        struct arena_spin_lock__bss {
                int test_skip;
                int counter;
                int limit;
                int cs_count;
        } *bss;

I dont have enough background here, as to if there is any specific 
reason to keep it in data segment:

        if (skel->data->test_skip == 2) {
                test__skip();
                goto end;
        }

Thanks,
Saket

