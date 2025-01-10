Return-Path: <linux-kselftest+bounces-24206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BFA08E77
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E63A13D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606920551E;
	Fri, 10 Jan 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SK5M87Rq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5A205518;
	Fri, 10 Jan 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506227; cv=none; b=XPDlE7rMxDvQT4iY1l4luc7alFsjo2xBAdei6uMHpKfbi0SbEV0Wi8zIL1Qipe6hUvyCrJleO8wvQFcnBuvSZ0OX3vGa33SVEgK51G4VRVPXczX3FeZWkdvl+3asFCWKnnKybx01d5kyLHYQf+A5jcaa6n8zLpTg+mEb0PVrxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506227; c=relaxed/simple;
	bh=l9ObgbxqXIT3r1GP++2d3ibpYuTubcJWUeiNWvhZGU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFd41V2euF0oSifEFflg0tcFVvxvwVqqyEwY8+igJC89ymsYnVuus17Qk8ccFJ4nSIXvr+Zp14VvNglpybpVt5p78Wg0Mkj/ei8uQashnohxZuoHe4qNZPWrjCbwFjKzzW9WepJWixtDB29IMTcrEdrPOw1SueTnJ/ftWpvX/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SK5M87Rq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509NbOb3020642;
	Fri, 10 Jan 2025 10:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xLCnIa
	QSRFVx0+1QdBz6TDmGxf0p9m21F+ppq+ltZEw=; b=SK5M87RqrqWXSSDTfc74Qn
	E0pObZ0GrZaI+d/CzYVaDqhO0D9jRx6MNwTvhzUTUOpbbOSckjZnYD26A+Fy/haJ
	AX2DvWgks8nZmjnADwMEu8usQxvarEp9JRdD39/LzONqgXS0MwBlm+xb6cUR/1XB
	v6Ff2Xb0cCW2+Ujk2clyP3yn0IVyD3HPvY0W6jwjxRFMY9PR1soEvwlRvxbdpmip
	4l+np8xGrhRBOo633yDGBTAjGklQ2UFh/YGNysN2vRiCF21JTGKYLze8PzfG24vF
	/gduOnfaE1eCOnfpC0OoL46SS/q1/d1Nl9MO7YK+2VtLv4TZRnKDJ0TpjHY0UM8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9at623-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:49:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50AAllnV024783;
	Fri, 10 Jan 2025 10:49:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9at621-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:49:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50AA2F3Z013648;
	Fri, 10 Jan 2025 10:49:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap9t3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:49:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50AAnrfG39256328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 10:49:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC992004B;
	Fri, 10 Jan 2025 10:49:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB99C20040;
	Fri, 10 Jan 2025 10:49:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.104.43])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 10:49:43 +0000 (GMT)
Date: Fri, 10 Jan 2025 16:19:39 +0530
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
Message-ID: <Z4D7Qx6pQEZ/bHDa@linux.ibm.com>
References: <20241104050007.13812-1-skb99@linux.ibm.com>
 <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
 <Zz33lM0rTJBZpaJR@linux.ibm.com>
 <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aPAy5z_Ih2s1DQUeRqNK86qSVWvODn0-
X-Proofpoint-ORIG-GUID: Eklc1R9ZEFhJD0PuJcsTXu-41x2cIdyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100084

On Thu, Nov 21, 2024 at 04:00:13PM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 20, 2024 at 6:52 AM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> >
> > On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> > > On Sun, Nov 3, 2024 at 9:00 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> > > >
> > > > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
> > > > syscall entry points") drops _powerpc prefix to syscall entry points,
> > > > even though powerpc now supports syscall wrapper, so /proc/kallsyms
> > > > have symbols for syscall entry without powerpc prefix(sys_*).
> > > >
> > > > For this reason, arch specific prefix for syscall functions in powerpc
> > > > is dropped.
> > > >
> > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 219facd0e66e..3a370fa37d8a 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(void)
> > > >  #elif defined(__riscv)
> > > >         return "riscv";
> > > >  #elif defined(__powerpc__)
> > > > -       return "powerpc";
> > > > -#elif defined(__powerpc64__)
> > > > -       return "powerpc64";
> > > > +       return "";
> > > >  #else
> > > >         return NULL;
> > > >  #endif
> > > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
> > > >         if (!ksys_pfx)
> > > >                 return 0;
> > > >
> > > > +#if defined(__powerpc__)
> > > > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> > > > +#else
> > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > > > +#endif
> > >
> > > The problem is that on older versions of kernel it will have this
> > > prefix, while on newer ones it won't. So to not break anything on old
> > > kernels, we'd need to do feature detection and pick whether to use
> > > prefix or not, right?
> > >
> > > So it seems like this change needs a bit more work.
> > >
> > > pw-bot: cr
> > >
> > Hi Andrii,
> >
> > IMO since both the patches 7e92e01b7245(powerpc: Provide syscall wrapper)
> > and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall entry points)
> > went into the same kernel version v6.1-rc1, there won't me much kernel
> > versions that has only one of these patches.
> >
> > Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPPER disabled,
> > and it the test passed in this case too.
> >
> 
> Keep in mind that libbpf is supposed to work across many kernel
> versions. So as long as there are powerpc (old) kernels that do use
> arch-specific prefix, we need to detect them and supply prefix when
> attaching ksyscall programs.
> 
Hi Andrii,

Sorry about the delayed response, I have started looking at this after
a vacation.

There are unlikely to be any old kernels that use arch-specific prefix
as syscall wrapper support was added to powerpc in v6.1 and 
commit 94746890202cf that dropped the prefix also went into the same 
kernel release (v6.1-rc1). So, is it worth it support both sys_bpf and
__powerpc_sys_bpf cases?

But yes, there can be a kernel without syscall wrapper but having the 
sys_bpf symbol. So, how about identifying syscall wrapper enablement
with __se_sys_bpf instead:


diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..ff69a30cfe9b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11163,11 +11163,15 @@ int probe_kern_syscall_wrapper(int token_fd)
 	char syscall_name[64];
 	const char *ksys_pfx;
 
+#if defined(__powerpc__)
+	snprintf(syscall_name, sizeof(syscall_name), "__se_sys_bpf", ksys_pfx);
+#else
 	ksys_pfx = arch_specific_syscall_pfx();
 	if (!ksys_pfx)
 		return 0;
 
 	snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
+#endif
 
 	if (determine_kprobe_perf_type() >= 0) {
 		int pfd;
@@ -11176,16 +11180,28 @@ int probe_kern_syscall_wrapper(int token_fd)
 		if (pfd >= 0)
 			close(pfd);
 
+#if defined(__powerpc__)
 		return pfd >= 0 ? 1 : 0;
+#else
+		return pfd >= 0 ? 1 : 0;
+#endif
 	} else { /* legacy mode */
 		char probe_name[128];
 
 		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
+#if defined(__powerpc__)
+			return 1;
+#else
 			return 0;
+#endif
 
 		(void)remove_kprobe_event_legacy(probe_name, false);
+#if defined(__powerpc__)
+		return 0;
+#else
 		return 1;
+#endif
 	}
 }

Actually, all architectures could use this '__se_' prefix instead of
arch specific prefix  to identify if syscall wrapper is enabled.
Separate way to handle powerpc case may not be needed. Will
wait for your inputs to send v2.

Thanks,
Saket
> > Thanks,
> > Saket
> > > >
> > > >         if (determine_kprobe_perf_type() >= 0) {
> > > >                 int pfd;
> > > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
> > > >                  * compiler does not know that we have an explicit conditional
> > > >                  * as well.
> > > >                  */
> > > > +#if defined(__powerpc__)
> > > > +               snprintf(func_name, sizeof(func_name), "sys_%s", syscall_name);
> > > > +#else
> > > >                 snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
> > > >                          arch_specific_syscall_pfx() ? : "", syscall_name);
> > > > +#endif
> > > >         } else {
> > > >                 snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
> > > >         }
> > > > --
> > > > 2.43.5
> > > >

