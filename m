Return-Path: <linux-kselftest+bounces-1312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438638077AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FE28216A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C336D;
	Wed,  6 Dec 2023 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUQINWTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A1139
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 10:38:27 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d68239732so7845ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701887906; x=1702492706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kHi+/x/yV8/AO54c41VfM0jyCOf9g4qLEuUxaryfSU=;
        b=PUQINWTZcuJ1Gzxm+DVf8U75wXjpYcVdMtpAoAD2Iw0x8aACAL/G89S72dNVxK7UoB
         wnVsTWUJiFM9R4kDT2yaDaBzg6PgTC2eK4KQZs/ZV/SMq2EX9CirM54Gihu034T0tsDS
         N7dNsYL+rzxUXWCBdBT2zecBQz1v3vGRd1WAVADPwB81EM0V1QX3JzGATe/2M2lEbeIi
         XgyW7nEhYX9SXPMsmNH3P38TjiPmEgJa32ggS+7YNfN08KbKuIVDw3tktcldndu00y0W
         2aMRtNUOjZhvDVJZ6u5KfyooWPwB3I6AVnC8Y3h9ETLim2MT6JXSrCLMDjEOFIkrR1P/
         iErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887906; x=1702492706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kHi+/x/yV8/AO54c41VfM0jyCOf9g4qLEuUxaryfSU=;
        b=SFLHCZC+LoQr9wgbwQVIbfQpZB2h0vP83LMI8scx9hD1FFkMO0Fey712o92s3xzjBD
         HF4+KV8UXwG0HEYb0WVwBNmYOqMdRMwMm6BZwJDnxL3ctc5x0Rth2ZCfzzEEUJ8rqU+q
         5KZZIhyOaR7quN2DJjxNoXkhfT4c9A2oVQKtD1C7EgWAz8PPERZ0CPkU+uHqhgOoxRXs
         CnKrIJwKi4VMb9QOrXHabT54aH8Zux/WYcueU8mOTuq0+sQjvSQP/rV744U3tiIPbLqy
         m/JjZ8tjlNTAqtSJoxV+Y3TqbRNPfwgcwNype5YTna53SCWe17BNMqYNNZnDBWbR0e7h
         56gg==
X-Gm-Message-State: AOJu0YzZw0O3n1yccmeAA5Q8DEuLCr97NJADMGqWJyvu1DpQkz+frzCX
	pO420fETc+Wu52Ajs5szM2cyPYe5gp1xt8syc0sE4g==
X-Google-Smtp-Source: AGHT+IECEzFpg3QWyp0E5e/eCQj0fEABYtZZmB0KvLMjY2AH2UAB7JCkJPuizEBMXLOu30ycJ+39VKwEyevubqWqV2U=
X-Received: by 2002:a05:6e02:1bc4:b0:35d:5fd7:b57 with SMTP id
 x4-20020a056e021bc400b0035d5fd70b57mr369567ilv.20.1701887906105; Wed, 06 Dec
 2023 10:38:26 -0800 (PST)
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
 <04c9eb5e-3395-05e6-f0cc-bc8f054a6031@intel.com> <CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com>
 <e4a77e0c-a31c-429b-9de9-3cadd704ca34@intel.com> <CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-cY5SvWQBg@mail.gmail.com>
 <101c0235-c354-43b1-afc2-1332bd8b453a@intel.com>
In-Reply-To: <101c0235-c354-43b1-afc2-1332bd8b453a@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 6 Dec 2023 10:38:15 -0800
Message-ID: <CALPaoCiLB99MDdMuVR=U6dA8hsnRJkdb2FrHvwXzQoQBHp_qNA@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 5:47=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> On 12/5/2023 4:33 PM, Peter Newman wrote:
> > On Tue, Dec 5, 2023 at 1:57=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 12/1/2023 12:56 PM, Peter Newman wrote:

> > Ignoring any present-day resctrl interfaces, what we minimally need is.=
..
> >
> > 1. global "start measurement", which enables a
> > read-counters-on-context switch flag, and broadcasts an IPI to all
> > CPUs to read their current count
> > 2. wait 5 seconds
> > 3. global "end measurement", to IPI all CPUs again for final counts
> > and clear the flag from step 1
> >
> > Then the user could read at their leisure all the (frozen) event
> > counts from memory until the next measurement begins.
> >
> > In our case, if we're measuring as often as 5 seconds for every
> > minute, that will already be a 12x aggregate reduction in overhead,
> > which would be worthwhile enough.
>
> The "con" here would be that during those 5 seconds (which I assume would=
 be
> controlled via user space so potentially shorter or longer) all tasks in =
the
> system is expected to have significant (but yet to be measured) impact
> on context switch delay.

Yes, of course. In the worst case I've measured, Zen2, it's roughly a
1700-cycle context switch penalty (~20%) for tasks in different
monitoring groups. Bad, but the benefit we gain from the per-RMID MBM
data makes up for it several times over if we only pay the cost during a
measurement.

> I expect the overflow handler should only be run during the measurement
> timeframe, to not defeat the "at their leisure" reading of counters.

Yes, correct. We wouldn't be interested in overflows of the hardware
counter when not actively measuring bandwidth.


>
> >>> The second involves avoiding the situation where a hardware counter
> >>> could be deallocated: Determine the number of simultaneous RMIDs
> >>> supported, reduce the effective number of RMIDs available to that
> >>> number. Use the default RMID (0) for all "unassigned" monitoring
> >>
> >> hmmm ... so on the one side there is "only the RMID within the PQR
> >> register can be guaranteed to be tracked by hardware" and on the
> >> other side there is "A given implementation may have insufficient
> >> hardware to simultaneously track the bandwidth for all RMID values
> >> that the hardware supports."
> >>
> >> From the above there seems to be something in the middle where
> >> some subset of the RMID values supported by hardware can be used
> >> to simultaneously track bandwidth? How can it be determined
> >> what this number of RMID values is?
> >
> > In the context of AMD, we could use the smallest number of CPUs in any
> > L3 domain as a lower bound of the number of counters.
>
> Could you please elaborate on this? (With the numbers of CPUs nowadays th=
is
> may be many RMIDs, perhaps even more than what ABMC supports.)

I think the "In the context of AMD" part is key. This feature would only
be applicable to the AMD implementations we have today which do not
implement ABMC.  I believe the difficulties are unique to the topologies
of these systems: many small L3 domains per node with a relatively small
number of CPUs in each. If the L3 domains were large and few, simply
restricting the number of RMIDs and allocating on group creation as we
do today would probably be fine.

> I am missing something here since it is not obvious to me how this lower
> bound is determined. Let's assume that there are as many monitor groups
> (and thus as many assigned RMIDs) as there are CPUs in a L3 domain.
> Each monitor group may have many tasks. It can be expected that at any
> moment in time only a subset of assigned RMIDs are assigned to CPUs
> via the CPUs' PQR registers. Of those RMIDs that are not assigned to
> CPUs, how can it be certain that they continue to be tracked by hardware?

Are you asking whether the counters will ever be reclaimed proactively?
The behavior I've observed is that writing a new RMID into a PQR_ASSOC
register when all hardware counters in the domain are allocated will
trigger the reallocation.

However, I admit the wording in the PQoS spec[1] is only written to
support the permanent-assignment workaround in the current patch series:

"All RMIDs which are currently in use by one or more processors in the
QOS domain will be tracked. The hardware will always begin tracking a
new RMID value when it gets written to the PQR_ASSOC register of any of
the processors in the QOS domain and it is not already being tracked.
When the hardware begins tracking an RMID that it was not previously
tracking, it will clear the QM_CTR for all events in the new RMID."

I would need to confirm whether this is the case and request the
documentation be clarified if it is.


> >>>
> >>> While the second feature is a lot more disruptive at the filesystem
> >>> layer, it does eliminate the added context switch overhead. Also, it
> >>
> >> Which changes to filesystem layer are you anticipating?
> >
> > Roughly speaking...
> >
> > 1. The proposed "assign" interface would have to become more indirect
> > to avoid understanding how assign could be implemented on various
> > platforms.
>
> It is almost starting to sound like we could learn from the tracing
> interface where individual events can be enabled/disabled ... with severa=
l
> events potentially enabled with an "enable" done higher in hierarchy, per=
haps
> even globally to support the first approach ...

Sorry, can you clarify the part about the tracing interface? Tracing to
support dynamic autoconfiguration of events?

Thanks!
-Peter


 [1] AMD64 Technology Platform Quality of Service Extensions, Revision: 1.0=
3:
     https://bugzilla.kernel.org/attachment.cgi?id=3D301365

