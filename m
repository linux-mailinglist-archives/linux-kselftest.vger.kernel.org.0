Return-Path: <linux-kselftest+bounces-24578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B8A125B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA10D16749A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A93596F;
	Wed, 15 Jan 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0qwFwK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BA24A7DA;
	Wed, 15 Jan 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950598; cv=none; b=XGYcIMHUdW1K89Om08IRm5YlPTmFTsNV/khvDocbeKDWytacshASrBamq/EvmhHos5LjGa0w3ypVLNI34Tq2C6A7aGm5gPvFKdoY+QuRHKaQMVOp0PfNkIF4KBtngrrbn8XjOt0oF7qXXVbbF1Hq3WTWxkISu59yqOcGjEQ2LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950598; c=relaxed/simple;
	bh=/04X4dIdhIE124kK9873SZ8LkdbZhgulsIhiS1iBbgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKcdJqzoYCCMgI01197oMyFVU3bIyKhfk0gDiNFR+kedXEru91VSZMeV/+WSuVKAb0uJQDBVFWK4a3r6417Nn4x+BhiFwzHdm/P7EDV0pA68BAAd2bH8GW/34w63dgV7JOvjfFowb8dKcHmeHUCrx42/yCQJJ/Sr0gSx/dwZEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0qwFwK7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FE6Q9x022512;
	Wed, 15 Jan 2025 14:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b0SJQB
	yFqvXEwAK4Lovb3DORnrDEgylVk7ZRdqv+y14=; b=F0qwFwK7stWXL1+plWaC0r
	tDYADOgpCQsAsxQZhcA6HWLaxaOexoj5iXGY/vtXL8tVpJS+W6mmb1h16Ml0M68z
	1xDSeC4DBTqtlpJQbnm8s46EpL0QPuXKhHyNnulsOkzHNjm5xLk1Q5ByZRvRbYuf
	5RGC7s0ql9nm1jYuZuZQGUl/XsFubGlvSsVGunfLDEgSSDvDcZTzchRzjEyqhC65
	KrTaMC9b0p5VUlfJ6FApXDzucdAok3egOWumZawNXthjEbuHm/GkK5qja66xuI8k
	AW06ta06uJFSZFI1M2N5AlM505SNUDONP28LCAUEHVPtkrVTW/aFpVK8dUuomX9w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446eg5r1wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:16:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FEG4uK012581;
	Wed, 15 Jan 2025 14:16:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446eg5r1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:16:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FAw57F017366;
	Wed, 15 Jan 2025 14:16:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk8m2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:16:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FEFxh934734436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 14:16:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D819A2004B;
	Wed, 15 Jan 2025 14:15:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDAEA20040;
	Wed, 15 Jan 2025 14:15:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.114.199])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 14:15:54 +0000 (GMT)
Date: Wed, 15 Jan 2025 19:45:33 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
        andrii@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: Re: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function
 names
Message-ID: <Z4fDBSvtJ+jgm05+@linux.ibm.com>
References: <20241104050007.13812-1-skb99@linux.ibm.com>
 <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
 <Zz33lM0rTJBZpaJR@linux.ibm.com>
 <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
 <Z4D7Qx6pQEZ/bHDa@linux.ibm.com>
 <CAEf4BzaEwvP-eVd=AWzvXPCfVCa5m0BKCe6q9tE5fT7VCAVDmA@mail.gmail.com>
 <Z4LMPn4u+l1qIi9T@linux.ibm.com>
 <CAEf4BzZbfc2o0hVnXVQ1vegMGhM8h76F2aGVske3wd8hFQeM+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZbfc2o0hVnXVQ1vegMGhM8h76F2aGVske3wd8hFQeM+g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s9vXFDqaJQryAHeuLLKu2YeaSTrwQPsp
X-Proofpoint-ORIG-GUID: InSNo0FWEWs24EZqM6ITwBVePUPBZiNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150106

On Tue, Jan 14, 2025 at 02:40:20PM -0800, Andrii Nakryiko wrote:
> On Sat, Jan 11, 2025 at 11:53 AM Saket Kumar Bhaskar
> <skb99@linux.ibm.com> wrote:
> >
> > CCing Maddy and MPE
> > On Fri, Jan 10, 2025 at 02:29:42PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Jan 10, 2025 at 2:49 AM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> > > >
> > > > On Thu, Nov 21, 2024 at 04:00:13PM -0800, Andrii Nakryiko wrote:
> > > > > On Wed, Nov 20, 2024 at 6:52 AM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> > > > > > > On Sun, Nov 3, 2024 at 9:00 PM Saket Kumar Bhaskar <skb99@linux.ibm.com> wrote:
> > > > > > > >
> > > > > > > > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
> > > > > > > > syscall entry points") drops _powerpc prefix to syscall entry points,
> > > > > > > > even though powerpc now supports syscall wrapper, so /proc/kallsyms
> > > > > > > > have symbols for syscall entry without powerpc prefix(sys_*).
> > > > > > > >
> > > > > > > > For this reason, arch specific prefix for syscall functions in powerpc
> > > > > > > > is dropped.
> > > > > > > >
> > > > > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > > > > ---
> > > > > > > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > > > > index 219facd0e66e..3a370fa37d8a 100644
> > > > > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > > > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(void)
> > > > > > > >  #elif defined(__riscv)
> > > > > > > >         return "riscv";
> > > > > > > >  #elif defined(__powerpc__)
> > > > > > > > -       return "powerpc";
> > > > > > > > -#elif defined(__powerpc64__)
> > > > > > > > -       return "powerpc64";
> > > > > > > > +       return "";
> > > > > > > >  #else
> > > > > > > >         return NULL;
> > > > > > > >  #endif
> > > > > > > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
> > > > > > > >         if (!ksys_pfx)
> > > > > > > >                 return 0;
> > > > > > > >
> > > > > > > > +#if defined(__powerpc__)
> > > > > > > > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> > > > > > > > +#else
> > > > > > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > > > > > > > +#endif
> > > > > > >
> > > > > > > The problem is that on older versions of kernel it will have this
> > > > > > > prefix, while on newer ones it won't. So to not break anything on old
> > > > > > > kernels, we'd need to do feature detection and pick whether to use
> > > > > > > prefix or not, right?
> > > > > > >
> > > > > > > So it seems like this change needs a bit more work.
> > > > > > >
> > > > > > > pw-bot: cr
> > > > > > >
> > > > > > Hi Andrii,
> > > > > >
> > > > > > IMO since both the patches 7e92e01b7245(powerpc: Provide syscall wrapper)
> > > > > > and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall entry points)
> > > > > > went into the same kernel version v6.1-rc1, there won't me much kernel
> > > > > > versions that has only one of these patches.
> > > > > >
> > > > > > Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPPER disabled,
> > > > > > and it the test passed in this case too.
> > > > > >
> > > > >
> > > > > Keep in mind that libbpf is supposed to work across many kernel
> > > > > versions. So as long as there are powerpc (old) kernels that do use
> > > > > arch-specific prefix, we need to detect them and supply prefix when
> > > > > attaching ksyscall programs.
> > > > >
> > > > Hi Andrii,
> > > >
> > > > Sorry about the delayed response, I have started looking at this after
> > > > a vacation.
> > > >
> > > > There are unlikely to be any old kernels that use arch-specific prefix
> > > > as syscall wrapper support was added to powerpc in v6.1 and
> > > > commit 94746890202cf that dropped the prefix also went into the same
> > > > kernel release (v6.1-rc1). So, is it worth it support both sys_bpf and
> > > > __powerpc_sys_bpf cases?
> > > >
> > > > But yes, there can be a kernel without syscall wrapper but having the
> > > > sys_bpf symbol. So, how about identifying syscall wrapper enablement
> > > > with __se_sys_bpf instead:
> > > >
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 66173ddb5a2d..ff69a30cfe9b 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -11163,11 +11163,15 @@ int probe_kern_syscall_wrapper(int token_fd)
> > > >         char syscall_name[64];
> > > >         const char *ksys_pfx;
> > > >
> > > > +#if defined(__powerpc__)
> > > > +       snprintf(syscall_name, sizeof(syscall_name), "__se_sys_bpf", ksys_pfx);
> > > > +#else
> > > >         ksys_pfx = arch_specific_syscall_pfx();
> > > >         if (!ksys_pfx)
> > > >                 return 0;
> > > >
> > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > > > +#endif
> > > >
> > > >         if (determine_kprobe_perf_type() >= 0) {
> > > >                 int pfd;
> > > > @@ -11176,16 +11180,28 @@ int probe_kern_syscall_wrapper(int token_fd)
> > > >                 if (pfd >= 0)
> > > >                         close(pfd);
> > > >
> > > > +#if defined(__powerpc__)
> > > >                 return pfd >= 0 ? 1 : 0;
> > > > +#else
> > > > +               return pfd >= 0 ? 1 : 0;
> > > > +#endif
> > > >         } else { /* legacy mode */
> > > >                 char probe_name[128];
> > > >
> > > >                 gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
> > > >                 if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
> > > > +#if defined(__powerpc__)
> > > > +                       return 1;
> > > > +#else
> > > >                         return 0;
> > > > +#endif
> > > >
> > > >                 (void)remove_kprobe_event_legacy(probe_name, false);
> > > > +#if defined(__powerpc__)
> > > > +               return 0;
> > > > +#else
> > > >                 return 1;
> > > > +#endif
> > > >         }
> > > >  }
> > > >
> > > > Actually, all architectures could use this '__se_' prefix instead of
> > > > arch specific prefix  to identify if syscall wrapper is enabled.
> > > > Separate way to handle powerpc case may not be needed. Will
> > > > wait for your inputs to send v2.
> > >
> > > the problem is that __se_sys_bpf is not traceable (it's a static
> > > function), so it seems like this won't work
> > >
> > >
> > > it's been a while, let me try to clarify my understanding of the
> > > issue. The problem is that powerpc is special in that when syscall
> > > wrapper is used, then, unlike all other architectures, they opted to
> > > not have arch-specific prefix for syscall wrappers, is that right? and
> > > that's why all the dancing you are trying to add. Am I right?
> > >
> > Yes, you got it right. For more details, you can refer to the
> > reasoning behind the change here:
> > https://github.com/torvalds/linux/commit/94746890202cf
> 
> That was an unfortunate decision to deviate :(
> 
> Alright, so where are we? We can't do __se_<syscall> approach, but we
> need to have some reliable way to determine whether powerpc uses
> syscall wrapper. Can you please summarize available options for
> powerpc? Sorry, it's been a while, so we need to re-page in all the
> context.
> 
Hi Andrii,

1. On powerpc we are able to set kprobe on __se_sys_bpf, we are thinking to 
   use this to check if syscall wrapper is enabled.

Snippet from kernel where syscall wrapper wasn't there for powerpc:

# uname -r
6.0.0

# cat kprobe_events
p:kprobes/p_kprobe2_user_events_osquery netlink_ack
r64:kprobes/r_kprobe_user_events_osquery audit_receive
p:kprobes/p_kprobe_user_events_osquery audit_receive
p:kprobes/my_probe __se_sys_bpf

# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 20/20   #P:64
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
      test_progs-1971    [034] .....   532.732614: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.732843: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733120: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733485: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733499: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733507: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733512: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733552: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733577: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733581: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733586: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733592: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733596: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733601: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733606: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733612: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733622: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733658: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.733740: my_probe: (sys_bpf+0xc/0x40)
      test_progs-1971    [034] .....   532.736043: my_probe: (sys_bpf+0xc/0x40)

2. The other is sys_bpf, but this symbol exists in both cases(kernel where syscall 
   wrapper is enabled and where it is disabled).

Kernel with syscall wrapper not introduced in powerpc:

# uname -r
6.0.0

# cat /proc/kallsyms | grep sys_bpf
c000000000383630 t __sys_bpf
c0000000003844a0 T bpf_sys_bpf
c000000000384510 T kern_sys_bpf
c000000000384840 T sys_bpf
c000000000384840 T __se_sys_bpf
c000000001030c80 d bpf_sys_bpf_proto
c0000000014a8bf8 d __ksymtab_kern_sys_bpf
c0000000014eac1f r __kstrtab_kern_sys_bpf
c0000000014fa53b r __kstrtabns_kern_sys_bpf
c000000002151e90 d _eil_addr_sys_bpf

Kernel with syscall wrapper introduced in powerpc:

# uname -r
6.13.0-rc6+

# cat /proc/kallsyms | grep sys_bpf
c0000000003d7750 t __sys_bpf
c0000000003d83ac T bpf_sys_bpf
c0000000003d8418 T kern_sys_bpf
c0000000003d8734 T sys_bpf
c000000001243328 d bpf_sys_bpf_proto
c0000000017776b0 r __ksymtab_kern_sys_bpf
c0000000021b7520 d _eil_addr_sys_bpf

Thanks,
Saket
> >
> > Thanks,
> > Saket
> > > >
> > > > Thanks,
> > > > Saket
> > > > > > Thanks,
> > > > > > Saket
> > > > > > > >
> > > > > > > >         if (determine_kprobe_perf_type() >= 0) {
> > > > > > > >                 int pfd;
> > > > > > > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
> > > > > > > >                  * compiler does not know that we have an explicit conditional
> > > > > > > >                  * as well.
> > > > > > > >                  */
> > > > > > > > +#if defined(__powerpc__)
> > > > > > > > +               snprintf(func_name, sizeof(func_name), "sys_%s", syscall_name);
> > > > > > > > +#else
> > > > > > > >                 snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
> > > > > > > >                          arch_specific_syscall_pfx() ? : "", syscall_name);
> > > > > > > > +#endif
> > > > > > > >         } else {
> > > > > > > >                 snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
> > > > > > > >         }
> > > > > > > > --
> > > > > > > > 2.43.5
> > > > > > > >

