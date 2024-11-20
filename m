Return-Path: <linux-kselftest+bounces-22351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650499D3EFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD41B32B0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268411C9DFE;
	Wed, 20 Nov 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Swx4E8P5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A031AA787;
	Wed, 20 Nov 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114376; cv=none; b=IT5mCSC586jcq6/67s8ponBxdBni6r9PMnK06dKezAdZbwek5eOWOtUdwteFnQE9hZln0zLufSEkQkdjJgENfJ/fGZNAg7Y1P+1fmDp3oummeGCKbG16wvnKm9SmomQmOwv17EZyG4y+TBVIhfm5TKp+QXZT3D8C1EZ91g2jXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114376; c=relaxed/simple;
	bh=X34ee5n9/+gtBb8PlDw2cQhnKE5h7fWdxXOzRPPkWxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPxV5EVprxpzpDOFjVeFYRBSv4ElyArFAmRoDZ8sx+pfCd8FMLNs6+VfoP0jXgg4UFMiYKtcULc6osyVWnzZy7QSb5kzn5+eZPNq7MNMts4ua7SwmYiHla3Tl5ZPM9KIBTALVrMev0vSjjUUF1cUQ5rlJ+RWogrOkJkwpXLDsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Swx4E8P5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK7wIH2000600;
	Wed, 20 Nov 2024 14:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=emkmGp
	2HCpY+mPHTPL4s5TQYmY3I3fV6swkaW50As98=; b=Swx4E8P5STtw3xkB1dT/15
	7v18/1yTymlYyn5jfHIZcvslY/+X97Q4uloEsMQjoA5dRdKjcq/f/Ud9PrMWsBAV
	naPISTAhZaCuB+k5N/yQZj+0XnC7dH37Cx8mTdCLjfIU7bpbuNDfA0mHgHZ7o4vi
	KZw7U0mYeWYCGswBngFnh385Tkpxg7Ue+RAae5g7xejDCQ8GRViaQSuXq443Q3bm
	FJtQqhS0eNmsffbkTvEpBB1BXIgfVkbcgqGnUknqjZ/1rxMYGh+EmJ2XcjJ02xOH
	y2yKbExc/HiCSvFIwO9kHo5VfArQfRGcw+Txxt+XEFIdPs1/7JJTL97yVVgxbxQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2w6mrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:52:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AKEjaO5008176;
	Wed, 20 Nov 2024 14:52:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2w6mrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:52:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKDSlFO025841;
	Wed, 20 Nov 2024 14:52:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qmxsfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:52:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKEqK2c53608920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:52:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22D0520043;
	Wed, 20 Nov 2024 14:52:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4880320040;
	Wed, 20 Nov 2024 14:52:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.115.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Nov 2024 14:52:15 +0000 (GMT)
Date: Wed, 20 Nov 2024 20:22:04 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: Re: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function
 names
Message-ID: <Zz33lM0rTJBZpaJR@linux.ibm.com>
References: <20241104050007.13812-1-skb99@linux.ibm.com>
 <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JXoZnlqt2-ISr4LiE9N74CSxrNYz-_aw
X-Proofpoint-GUID: 8Y1VWVhX8SOfeQmnoWEnnjTozKzQrAjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200096

On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> On Sun, Nov 3, 2024 at 9:00 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
> > syscall entry points") drops _powerpc prefix to syscall entry points,
> > even though powerpc now supports syscall wrapper, so /proc/kallsyms
> > have symbols for syscall entry without powerpc prefix(sys_*).
> >
> > For this reason, arch specific prefix for syscall functions in powerpc
> > is dropped.
> >
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 219facd0e66e..3a370fa37d8a 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(void)
> >  #elif defined(__riscv)
> >         return "riscv";
> >  #elif defined(__powerpc__)
> > -       return "powerpc";
> > -#elif defined(__powerpc64__)
> > -       return "powerpc64";
> > +       return "";
> >  #else
> >         return NULL;
> >  #endif
> > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
> >         if (!ksys_pfx)
> >                 return 0;
> >
> > +#if defined(__powerpc__)
> > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> > +#else
> >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > +#endif
> 
> The problem is that on older versions of kernel it will have this
> prefix, while on newer ones it won't. So to not break anything on old
> kernels, we'd need to do feature detection and pick whether to use
> prefix or not, right?
> 
> So it seems like this change needs a bit more work.
> 
> pw-bot: cr
> 
Hi Andrii,

IMO since both the patches 7e92e01b7245(powerpc: Provide syscall wrapper) 
and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall entry points) 
went into the same kernel version v6.1-rc1, there won't me much kernel
versions that has only one of these patches.

Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPPER disabled,
and it the test passed in this case too.

Thanks,
Saket
> >
> >         if (determine_kprobe_perf_type() >= 0) {
> >                 int pfd;
> > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
> >                  * compiler does not know that we have an explicit conditional
> >                  * as well.
> >                  */
> > +#if defined(__powerpc__)
> > +               snprintf(func_name, sizeof(func_name), "sys_%s", syscall_name);
> > +#else
> >                 snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
> >                          arch_specific_syscall_pfx() ? : "", syscall_name);
> > +#endif
> >         } else {
> >                 snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
> >         }
> > --
> > 2.43.5
> >

