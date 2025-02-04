Return-Path: <linux-kselftest+bounces-25644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F84A26C52
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D841F3A2D4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231320371F;
	Tue,  4 Feb 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fz91ovJN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842E202C34;
	Tue,  4 Feb 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652322; cv=none; b=QgDK5jwTNfFB46sd2unbPWayWWL5Ge4a9ishrxxN3rMD7DtNXfKNqEvlIKgArCkyK3s4D6IuESYdjpucnCO151Jl2s9/rQNOQOngk7dbAaUd2swKcYjl9bU0G7JrGV6XC4g5HkynLEJWkQ92Iyyr80anMp+1s8arrdH1u7pwgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652322; c=relaxed/simple;
	bh=uYYn3yWenve6vSHmsNALgGhHM4uN2l/TES2qIuxFWD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE9xv5iA42MFrCFY6E9MpCIP2GKci6iUJKeT2crfKgLph5XZo4QDlhawWh9bJq9MReFXKUbeG85D5lCoJmli1WuTl29KH0cdnMPB380Od0hf5WJ7IBq4YOgCaLnOZMqJ4RmGUqIQip3ZI/AszrojC0yaNW/vr3OK1/AwzIfaCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fz91ovJN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5145O0hI008510;
	Tue, 4 Feb 2025 06:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=htx4Rv
	+keElb9RwgJr3QR/rdU3QPcKXTK9WVFcQ5974=; b=fz91ovJNKs4Nam2Fg7puYW
	dqOoqgoOXZmfrg8KtAsfnYVtbj1oMOhpfKy25qjjgve8En+FfYUN7FWGE5h0UXfQ
	1/tJkv4RfxF+4RK/roWiALFIuYv37ROZaoSyLH+oPLVk6Lo8nKxR/RPF3VLRBh4r
	6751SgzmbMq2rSw5lx/FSHeNObbGZ6tPj0SGkvZthLwiFqHDEdUx5NI8J9df7UMD
	19Yj7sZu/uflw6MTN3vHOoR6AybRkv6z/m69cbVKUWJ4HIFWwa8kf68LZRzHOOK0
	MB80XneahhkkDZEoZ11BW5UdQF9VRmTFLlzXSGhftlwJ3YspC09Y3LQgjwdWubhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7rc1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:58:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5146wCbo014943;
	Tue, 4 Feb 2025 06:58:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kcq7rc14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:58:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5145Sr5Q021486;
	Tue, 4 Feb 2025 06:58:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n19vtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:58:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5146wAar19726652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 06:58:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED6E320043;
	Tue,  4 Feb 2025 06:58:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D846320040;
	Tue,  4 Feb 2025 06:58:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.126.219])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Feb 2025 06:58:00 +0000 (GMT)
Date: Tue, 4 Feb 2025 12:27:52 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] bpf: Fix mix-up of 4096 and page size.
Message-ID: <Z6G6cBP2YPmNyk+s@linux.ibm.com>
References: <20250122183720.1411176-1-skb99@linux.ibm.com>
 <CAADnVQJcmyMmxPfSaKgqMiCDZP=Pe8-Jf7NnEdfgxejvZr+44g@mail.gmail.com>
 <332c50f5-3c68-4fce-8bb3-161f76f2119c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <332c50f5-3c68-4fce-8bb3-161f76f2119c@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2V72CNMvNzNWjZ3BlCbLSCPbtFf9ZaM
X-Proofpoint-ORIG-GUID: EMBRkge-YUeRwsg-y_FrW5b1pY3uSvVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040051

On Tue, Jan 28, 2025 at 04:03:11PM +0100, Alexander Lobakin wrote:
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Thu, 23 Jan 2025 21:14:04 -0800
> 
> > On Wed, Jan 22, 2025 at 10:38 AM Saket Kumar Bhaskar
> > <skb99@linux.ibm.com> wrote:
> >>
> >> For platforms on powerpc architecture with a default page size greater
> >> than 4096, there was an inconsistency in fragment size calculation.
> >> This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
> >> to fail on powerpc.
> >>
> >> The issue occurred because the fragment buffer size in
> >> bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
> >> the fragment within the shared skb was checked against PAGE_SIZE
> >> (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
> >> accordingly. This discrepancy led to an overflow when
> >> bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
> >> could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
> >>
> >> This commit updates the page size references to 4096 to ensure consistency
> >> and prevent overflow issues in fragment size calculations.
> > 
> > This isn't right. Please fix the selftest instead.
> 
> It's not _that_ easy, I had tried in the past. Anyway, this patch is
> *not* a good "solution".
> 
> If you (Saket) really want to fix this, both test_run and the selftest
> must be in sync, so you need to (both are arch-dependent): 1) get the
> correct PAGE_SIZE; 2) calculate the correct tailroom in userspace (which
> depends on sizeof(shinfo) and SKB_DATA_ALIGN -> SMP_CACHE_BYTES).
> 
> > 
> > pw-bot: cr
> 
> Thanks,
> Olek
There is a mixup in kernel b/w 4096 and PAGE_SIZE and all selftest seem
to be based on 4096 as the size, so I changed the PAGE_SIZE to 4096,
but if we have to use PAGE_SIZE we need this change in kernel.
In place of PAGE_SIZE 4096 was used here:

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249..6b7fddfbb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1251,7 +1251,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
                headroom -= ctx->data;
        }

-       max_data_sz = 4096 - headroom - tailroom;
+       max_data_sz = PAGE_SIZE - headroom - tailroom;
        if (size > max_data_sz) {
                /* disallow live data mode for jumbo frames */
                if (do_live)

Assuming that change in kernel we should also update the selftest to 
64K page size for ppc64:

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 53d6ad8c2..037142e21 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -226,7 +226,7 @@ static void test_xdp_adjust_frags_tail_grow(void)

        prog_fd = bpf_program__fd(prog);

-       buf = malloc(16384);
+       buf = malloc(262144);
        if (!ASSERT_OK_PTR(buf, "alloc buf 16Kb"))
                goto out;

@@ -254,12 +254,12 @@ static void test_xdp_adjust_frags_tail_grow(void)
                ASSERT_EQ(buf[i], 1, "9Kb+10b-untouched");

        /* Test a too large grow */
-       memset(buf, 1, 16384);
-       exp_size = 9001;
+       memset(buf, 1, 262144);
+       exp_size = 132001;

        topts.data_in = topts.data_out = buf;
-       topts.data_size_in = 9001;
-       topts.data_size_out = 16384;
+       topts.data_size_in = 132001;
+       topts.data_size_out = 262144;
        err = bpf_prog_test_run_opts(prog_fd, &topts);

        ASSERT_OK(err, "9Kb+10b");

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index 81bb38d72..40a0c5469 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -27,8 +27,8 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
                offset = 4096 - 256 - tailroom - data_len;
        } else if (data_len == 9000) {
                offset = 10;
-       } else if (data_len == 9001) {
-               offset = 4096;
+       } else if (data_len == 132001) {
+               offset = 65536;
        } else {
                return XDP_ABORTED; /* No matching test */
        }

The above change is intended for feedback. The date_len and other 
values in the test cases can be adjusted to be based on the page 
size, rather than being hard-coded, to ensure compatibility with 
different page sizes.

Thanks,
Saket

