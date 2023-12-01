Return-Path: <linux-kselftest+bounces-988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B488014D9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 21:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC890281D56
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779D55799;
	Fri,  1 Dec 2023 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7UQPML1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0199A
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 12:56:18 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35c6cefa872so22655ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 12:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701464178; x=1702068978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDU6SlWRVKBiv8MHZWR7PalVXO/1RHV9RChrnpMyBqo=;
        b=p7UQPML1UjIqAibtSyQvnHjq4VunrlInVJZsvT+8KsePoEZyp3M/rOHs8xCl8zDJWr
         kjsGphDLzcMFs/dWMcuIfr4ut0fpFWIELV3qxSVLt0mBrIzA9Nit0ohlEhW0fNAI9qkq
         ZulJOLOLuL6gYrKobO06kpXND1uKZLfcbi6RusLtI038BO2ye6xUpLr85lYE5RusgVYv
         BdfKZ4ZxNV1KGGF7X7wC6PmMM31HLGhJ1WFbis6WdtryF4Uddyrd1UJh+WxJ9XrLGZ1d
         MTnnpfLuRtkqrYd2bLg/kAeLhpy2P6FyLl19GBzPggPwsKZA5ZOLcV08dOhc1llaKwNf
         VS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701464178; x=1702068978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDU6SlWRVKBiv8MHZWR7PalVXO/1RHV9RChrnpMyBqo=;
        b=ShCcm+MnP65JJ41fd3Z163bcmLC73xjWmlR7KHBy9Ft4NwmyRCKGe8OzVYexTm8pk9
         m9acjPqeIDjmToc5fzCSRbxM3lSnbFn8Xoc56sMnbIU56pgFt2BiQsk2FUox5iCQ68Kj
         MjjIDh9W6pQEonzHqwRtb2+3dtIS3FhDvZETFRViIozrfAdlcRnW1foWPbZ7GWoXVtlW
         ApxW/Nk2Hwfkpk5VqfzKO6Pqxsj2s4z5wfa4UX++oLeCIpEnjiZ/ys+3wusA/nUBamb4
         B4KSFqBorgUT70woxW86AtOwpD5Wv26P5ccmRMx31kZlnoJS663vt0ca0+tvLblw0/pv
         vYlg==
X-Gm-Message-State: AOJu0YxXtbo1RM7xaOGiv9aw7SSJDwu29wJaAbpJnHqxA59nOvDjt1Cu
	1EwskZzBupPGGrur45zGMJ/8AdvAkL79Uu2YbRYeRA==
X-Google-Smtp-Source: AGHT+IHv+vjOPkfAnQO7BH4FNl96FBQtAS+iXk6yc2jOVypvrwLn0XkkQewUIMd8xQ35p4x5GUBkCVa52rVxJFU6goU=
X-Received: by 2002:a05:6e02:1c01:b0:35d:3785:71c6 with SMTP id
 l1-20020a056e021c0100b0035d378571c6mr214742ilh.26.1701464177957; Fri, 01 Dec
 2023 12:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-4-peternewman@google.com> <38b9e6df-cccd-a745-da4a-1d1a0ec86ff3@intel.com>
 <CALPaoCg76nUsJ7eYcU61gied8WBuAAmqy0Pqpsq5=Z-S52Qg6w@mail.gmail.com>
 <31993ea8-97e5-b8d5-b344-48db212bc9cf@intel.com> <CALPaoCiPCxUeGKjZytxmse2oNs=qDBbRY9kH7AZGG6iXf1qtJw@mail.gmail.com>
 <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com>
In-Reply-To: <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 1 Dec 2023 12:56:06 -0800
Message-ID: <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] x86/resctrl: Add resctrl_mbm_flush_cpu() to
 collect CPUs' MBM events
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Stephane Eranian <eranian@google.com>, James Morse <james.morse@arm.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Tue, May 16, 2023 at 5:06=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 5/15/2023 7:42 AM, Peter Newman wrote:
> >
> > I used a simple parent-child pipe loop benchmark with the parent in
> > one monitoring group and the child in another to trigger 2M
> > context-switches on the same CPU and compared the sample-based
> > profiles on an AMD and Intel implementation. I used perf diff to
> > compare the samples between hard and soft RMID switches.
> >
> > Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz:
> >
> >               +44.80%  [kernel.kallsyms]  [k] __rmid_read
> >     10.43%     -9.52%  [kernel.kallsyms]  [k] __switch_to
> >
> > AMD EPYC 7B12 64-Core Processor:
> >
> >               +28.27%  [kernel.kallsyms]  [k] __rmid_read
> >     13.45%    -13.44%  [kernel.kallsyms]  [k] __switch_to
> >
> > Note that a soft RMID switch that doesn't change CLOSID skips the
> > PQR_ASSOC write completely, so from this data I can roughly say that
> > __rmid_read() is a little over 2x the length of a PQR_ASSOC write that
> > changes the current RMID on the AMD implementation and about 4.5x
> > longer on Intel.
> >
> > Let me know if this clarifies the cost enough or if you'd like to also
> > see instrumented measurements on the individual WRMSR/RDMSR
> > instructions.
>
> I can see from the data the portion of total time spent in __rmid_read().
> It is not clear to me what the impact on a context switch is. Is it
> possible to say with this data that: this solution makes a context switch
> x% slower?
>
> I think it may be optimistic to view this as a replacement of a PQR write=
.
> As you point out, that requires that a CPU switches between tasks with th=
e
> same CLOSID. You demonstrate that resctrl already contributes a significa=
nt
> delay to __switch_to - this work will increase that much more, it has to
> be clear about this impact and motivate that it is acceptable.

We were operating under the assumption that if the overhead wasn't
acceptable, we would have heard complaints about it by now, but we
ultimately learned that this feature wasn't deployed as much as we had
originally thought on AMD hardware and that the overhead does need to
be addressed.

I am interested in your opinion on two options I'm exploring to
mitigate the overhead, both of which depend on an API like the one
Babu recently proposed for the AMD ABMC feature [1], where a new file
interface will allow the user to indicate which mon_groups are
actively being measured. I will refer to this as "assigned" for now,
as that's the current proposal.

The first is likely the simpler approach: only read MBM event counters
which have been marked as "assigned" in the filesystem to avoid paying
the context switch cost on tasks in groups which are not actively
being measured. In our use case, we calculate memory bandwidth on
every group every few minutes by reading the counters twice, 5 seconds
apart. We would just need counters read during this 5-second window.

The second involves avoiding the situation where a hardware counter
could be deallocated: Determine the number of simultaneous RMIDs
supported, reduce the effective number of RMIDs available to that
number. Use the default RMID (0) for all "unassigned" monitoring
groups and report "Unavailable" on all counter reads (and address the
default monitoring group's counts being unreliable). When assigned,
attempt to allocate one of the remaining, usable RMIDs to that group.
It would only be possible to assign all event counters (local, total,
occupancy) at the same time. Using this approach, we would no longer
be able to measure all groups at the same time, but this is something
we would already be accepting when using the AMD ABMC feature.

While the second feature is a lot more disruptive at the filesystem
layer, it does eliminate the added context switch overhead. Also, it
may be helpful in the long run for the filesystem code to start taking
a more abstract view of hardware monitoring resources, given that few
implementations can afford to assign hardware to all monitoring IDs
all the time. In both cases, the meaning of "assigned" could vary
greatly, even among AMD implementations.

Thanks!
-Peter

[1] https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com=
/

