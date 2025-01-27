Return-Path: <linux-kselftest+bounces-25226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0EA1D5BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 13:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99152164DC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1B1FE467;
	Mon, 27 Jan 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h61i4lJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FF291E;
	Mon, 27 Jan 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737979363; cv=none; b=qnowoi9UH9MF7xF0Td5BmfgPdzL0cREg1W3gBrgsN7C8iwLoSWf0iEouHj+mrWkiy3vexcBqknYkHe7EVGhzjZ/9by6BGpOY7RoFy6vF2VJNO50M87eqzYSbeZTYoTIqgIGcCXtdCc5bJLFQ/rfnbNg9mHlYDB1+my/BsFlBy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737979363; c=relaxed/simple;
	bh=bBw03JKfcoEjUQ6Z2Ps7Vygh7/Ijlj4JWPZaf+0+Pmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhFoDYzA/KW/gNtACM7ba/XcVAvLOe0wflAgNsdPznpWu3D7Hb1Q6tholITX00ZiXcaygdraG019h1TQECf3lohIYZkWAI0/SbhUkOkZwUqJ8pARyzHS9ljf+Q4ZSrbjgCeoOvXxJ6mi8ZnAKSUDmDKmAHLLwWDOXmUy9D/6u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h61i4lJj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R7X7k5029948;
	Mon, 27 Jan 2025 12:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fCKYra
	ItNVni16k7D3kFhuJZQG/VGwhn9zNnr+WJJO0=; b=h61i4lJjONayLBtErmdWwS
	jMPisyi1pVkCSRGAvMJDhBzOPv4WLe8YbehQvtghV1T2fKtV2o/hbqbodW0YeqRN
	Wo7JIJS0jBtdq4ACII1Dq0kr9iYs2jVB5KG06ZX/mTbYauHSPSQVyUlLOXHsqV2X
	u5/k/oPnt5JXWJ2+ObphHZWSZ/8MRu72//vtJiwnolteEFB0+PzNe5G0QfLpuWYx
	fkXpSPsoobSPjSyVGBvxTHm8LdvcGP6NuWX/IZZB44gUlwU0IaNAqhFQKPnwrV7F
	XUgut1nvCT60wtTDCX5dlDd/q4pwyGkt5/02xx888EdGd+UxRuWaKFHPp9/HE2bA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5un94uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 12:02:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50RBsfOY025313;
	Mon, 27 Jan 2025 12:02:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5un94uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 12:02:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50R81Pxr019213;
	Mon, 27 Jan 2025 12:02:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9mp3hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 12:02:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50RC2Idv56951086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 12:02:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EDD201DC;
	Mon, 27 Jan 2025 12:02:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2D58201CE;
	Mon, 27 Jan 2025 12:02:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.25.97])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Jan 2025 12:02:03 +0000 (GMT)
Date: Mon, 27 Jan 2025 17:31:56 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
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
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/bpf: Select NUMA node of current CPU to
 create map
Message-ID: <Z5d1tJvKsVlMFySQ@linux.ibm.com>
References: <70fb07e980196ced9fc3e5e4dbeededce2e36fdc.1737816475.git.skb99@linux.ibm.com>
 <e9240414068ee83456d01d2bc71735705df8b36f.1737816475.git.skb99@linux.ibm.com>
 <CAADnVQJWs7Dq3E8shXNwG3tOsmRJ5YYjMboGjzeueg+uMKo+rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJWs7Dq3E8shXNwG3tOsmRJ5YYjMboGjzeueg+uMKo+rw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D8kZBlK-lyONyRJajy8XTy_3PRy8P7s1
X-Proofpoint-ORIG-GUID: kag2PHhLpi84cIexEsQ07f_D7eRj93zy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_05,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270097

On Sat, Jan 25, 2025 at 09:02:37AM -0800, Alexei Starovoitov wrote:
> On Sat, Jan 25, 2025 at 7:25 AM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > On powerpc, a CPU does not necessarily originate from NUMA node 0.
> > This contrasts with architectures like x86, where CPU 0 is not
> > hot-pluggable, making NUMA node 0 a consistently valid node.
> > This discrepancy can lead to failures when creating a map on NUMA
> > node 0, which is initialized by default, if no CPUs are allocated
> > from NUMA node 0.
> >
> > This patch fixes the issue by setting NUMA node for map creation
> > to NUMA node of the current CPU.
> >
> > Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation")
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile                      | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 0a016cd71..c7a996f53 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -47,7 +47,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic                                   \
> >           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> >           -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
> >  LDFLAGS += $(SAN_LDFLAGS)
> > -LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
> > +LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread -lnuma
> >
> >  PCAP_CFLAGS    := $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
> >  PCAP_LIBS      := $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> > index cc184e442..d241d22b8 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
> > @@ -4,6 +4,7 @@
> >  #include <sys/syscall.h>
> >  #include <limits.h>
> >  #include <test_progs.h>
> > +#include <numa.h>
> >  #include "bloom_filter_map.skel.h"
> >
> >  static void test_fail_cases(void)
> > @@ -69,6 +70,7 @@ static void test_success_cases(void)
> >
> >         /* Create a map */
> >         opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
> > +       opts.numa_node = numa_node_of_cpu(sched_getcpu()); // Get the NUMA node of the current CPU
> 
> let's not introduce new library deps.
> Will NUMA_NO_NODE work ?
> 
Yes this change worked:

diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index d241d22b8..527825939 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -4,9 +4,12 @@
 #include <sys/syscall.h>
 #include <limits.h>
 #include <test_progs.h>
-#include <numa.h>
 #include "bloom_filter_map.skel.h"
 
+#ifndef NUMA_NO_NODE
+#define        NUMA_NO_NODE    (-1)
+#endif
+
 static void test_fail_cases(void)
 {
        LIBBPF_OPTS(bpf_map_create_opts, opts);
@@ -70,7 +73,7 @@ static void test_success_cases(void)
 
        /* Create a map */
        opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
-       opts.numa_node = numa_node_of_cpu(sched_getcpu()); // Get the NUMA node of the current CPU
+       opts.numa_node = NUMA_NO_NODE;
        fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
        if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter success case"))
                return;

I will send out v2.
> Note c++ comments are not allowed.
> 
Acknowledged..

Thanks,
Saket
> pw-bot: cr

