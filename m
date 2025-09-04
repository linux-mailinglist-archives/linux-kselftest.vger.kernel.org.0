Return-Path: <linux-kselftest+bounces-40754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665CB435B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF97D1BC5A50
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2E2C15B1;
	Thu,  4 Sep 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AatXNMpd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC012C159F;
	Thu,  4 Sep 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974398; cv=none; b=ZVRGwLaPHmtW1KpqtNghw5vjCAOFOgZRwdX408+P2dYRG2H4/txuGnXnGZ0hymp/Gm2Rk4+X3/zvLR9f53emz8YyLwy7y9a+2p2dkiF1kXA96Yu/inLBvekAz4O0wmjdeQoq9PiMdaCSoyuerI6XOhF7ill8TFSlfDObF2/GLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974398; c=relaxed/simple;
	bh=KiOh2uBTfc1uSnmgSJDFnlxePjzNJJmQUIgDA/MModc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNlOpkAew+Ld895VJTDuDu/LQxBzFmRImPEdcMc9FcdJ7YFBgAmVenkx8Xk433SuuOPuw9p4YbGhlB7ogamwyB09RBwSXTI50BKKrRZx/VYP6NtA1aM2HJQZXmaPoOoxafzfEjH9O70Tl8dhFSD1gujsrW2LqhYNRrRz82yGT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AatXNMpd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Lo3cE001416;
	Thu, 4 Sep 2025 08:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SeIWyYthFKXTM+YzvniBzV+/iCysms
	58rjuwsZBdr+w=; b=AatXNMpdEkN2p+2NFIfEo7YsQ7blIS/sOV5zwIS2X0/ANz
	LoSCKWXxbPVBg0YTCW4eiz5+ev5IT2oa/HGeWFtnwMpkgBeZZkLyPQvItkpXTvvn
	+Wnw7rH4H5pzf+q8MORGeI2EievntsBqq1ik9EaCFDF4gkUYiSJvbu4k2oXsg2iN
	iLYme5ChMH4sP+HRd64Jw3Xsjjm96r9ChUUnfp9eWP6KSbYe7Lk8v25oxiHtJTNU
	I5eoEUV+IbLxdPZHecvIt+KcqH8HrWVwRMbCu99KEVq1fw7aEPr3q5zz6wlttws6
	Ql4JckMAVL9WcwJDhfnU4RFxrvKRaFCVDtrhb/ug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf4q7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 08:25:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5848NHHr015391;
	Thu, 4 Sep 2025 08:25:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf4q7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 08:25:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5848NBpc009015;
	Thu, 4 Sep 2025 08:25:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumkbsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 08:25:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5848Pm9t50594086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 08:25:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E20320049;
	Thu,  4 Sep 2025 08:25:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C60B2004E;
	Thu,  4 Sep 2025 08:25:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Sep 2025 08:25:43 +0000 (GMT)
Date: Thu, 4 Sep 2025 13:55:40 +0530
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
Message-ID: <aLlNBK9Zm+N4zarF@linux.ibm.com>
References: <20250829165135.1273071-1-skb99@linux.ibm.com>
 <20250829165135.1273071-6-skb99@linux.ibm.com>
 <46243c40-8e5e-47d3-97bd-71f29eeb0127@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46243c40-8e5e-47d3-97bd-71f29eeb0127@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RIaLeL1eD_hlIa3O9svCbxgdhcOrJBBE
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b94d12 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=0I_jKKNEayZCK3l2YkoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xVaDW9JNJ5EePgooQO8eO--XqDgpJDEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX93lrJIM42Ssl
 C3RH4XOSoegosRkEX4fFsX4JVD5gltG4+WPHFeK+qfPumk0lWzGPZpEICFLx/x76ysgw9kwvbdQ
 tGZ4V/Oi9LLwT7SpaWBiu0Nk1rP3mls3ogGmEbORkg0tsu77h5Vgz6Mnk3QTY0CyMem688nwADH
 HvFI2xRn0CIEadsQ0Y1nH0MVhc9lfh6a3hNusd/iiNFuP+fScJErQTEkgjxKM+swLcZ29DIpP27
 nNc7cRTeQ+/ymm75jjn90Ls3cWOfk+/gEq8P2yPzCNjsIkksFu5FD6ruHgFhFQQNn6sXtjtH7mH
 iqmwZLhZUlWewGFAQ86cQlv2IXx2a3ljwPWIR2bdIpMinQUl176vtwQbrn4R1SdKzZyWFfOuzUO
 B9PiPMgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

On Thu, Sep 04, 2025 at 01:39:31PM +0530, Hari Bathini wrote:
> 
> 
> On 29/08/25 10:21 pm, Saket Kumar Bhaskar wrote:
> > For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
> > the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.
> > 
> > The selftest is skipped incase bpf program returns EOPNOTSUPP,
> > with a descriptive message logged.
> > 
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >   .../selftests/bpf/prog_tests/arena_spin_lock.c      | 13 +++++++++++++
> >   tools/testing/selftests/bpf/progs/arena_spin_lock.c |  5 ++++-
> >   2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > index 0223fce4db2b..1ec1ca987893 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
> > @@ -40,8 +40,13 @@ static void *spin_lock_thread(void *arg)
> >   	err = bpf_prog_test_run_opts(prog_fd, &topts);
> >   	ASSERT_OK(err, "test_run err");
> > +
> > +	if (topts.retval == -EOPNOTSUPP)
> > +		goto end;
> > +
> >   	ASSERT_EQ((int)topts.retval, 0, "test_run retval");
> > +end:
> >   	pthread_exit(arg);
> >   }
> > @@ -63,6 +68,7 @@ static void test_arena_spin_lock_size(int size)
> >   	skel = arena_spin_lock__open_and_load();
> >   	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> >   		return;
> > +
> >   	if (skel->data->test_skip == 2) {
> >   		test__skip();
> >   		goto end;
> > @@ -86,6 +92,13 @@ static void test_arena_spin_lock_size(int size)
> >   			goto end_barrier;
> >   	}
> > +	if (skel->data->test_skip == 2) {
> > +		printf("%s:SKIP: %d CPUs exceed the maximum supported by arena spinlock\n",
> > +		       __func__, get_nprocs());
> > +		test__skip();
> > +		goto end_barrier;
> > +	}
> > +
> >   	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
> >   end_barrier:
> > diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > index c4500c37f85e..a475b974438e 100644
> > --- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > +++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
> > @@ -37,8 +37,11 @@ int prog(void *ctx)
> >   #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> >   	unsigned long flags;
> > -	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
> > +	if ((ret = arena_spin_lock_irqsave(&lock, flags))) {
> > +		if (ret == -EOPNOTSUPP)
> > +			test_skip = 2;
> >   		return ret;
> 
> test_skip being set to `1` when the test runs seems counter intuitive.
> How about setting test_skip to `0` when run conditions are met
> and test_skip=1 if run conditions are not met and
> test_skip=2 when operation is not supported?
> 
> - Hari
That seems reasonable to me, but right now -EOPNOTSUPP is also
returned when run condition is not met i.e.:

  if (CONFIG_NR_CPUS > 1024)
                return -EOPNOTSUPP;

So do we really need test_skip = 2 ?

Thanks,
Saket

