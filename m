Return-Path: <linux-kselftest+bounces-24799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319BA16FD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9A77A205D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC321E98F3;
	Mon, 20 Jan 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9Zkp+Gw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BC1E570A
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389383; cv=none; b=DhYOZOJg94bap1gsVQGEUnqecAbSh4yxbXQnswTo1uXsbvwqDaLt/qiUVtAX7feAXCaBbtBZN611E3JdelYC89+wsQzLvfWIuXOrrUKAenq4dduNMCxn4dTxr0zIa4NRMorUfLootniIZvdPm0SHxUvJFOz+Q6QzAHayzt6B3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389383; c=relaxed/simple;
	bh=uPYF3/ytKmNcBW6xY8UN6OXUapKiaxgyBXzq3dB0L9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5fPA9DJxYg1kpjhZnh9k0jrmW5ccOaILjvMPEoKmhDGcceObbNz79Bgr/+zjmsCTZFFEqpm1hFrLnoJ/ARaj+HEsfDyshbRHuq63+FVfvvjpaZ/P6/yh0bsZGGO9tBPmb0cbx+fzJloZeTp3OgameEwdtchbY3uROETV4cHHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9Zkp+Gw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737389380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPYF3/ytKmNcBW6xY8UN6OXUapKiaxgyBXzq3dB0L9c=;
	b=Q9Zkp+GwceVojjS4SOXCccMB34guFvuwLnb0svs197dYIFy/XY3+UQkhNLYSGTo8byTs2b
	SkMiI7VZJBs1WJKE9SxkvLgfEOEzZq8OCyASX6r9r0Fcp4q+BO3F5CSI+yx57sT0guFZZs
	eelW9xiIUI74Duj5cUzT0JAMAHi6GIU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-s2yPcFsENSSxQa8JlVjHeQ-1; Mon, 20 Jan 2025 11:09:39 -0500
X-MC-Unique: s2yPcFsENSSxQa8JlVjHeQ-1
X-Mimecast-MFC-AGG-ID: s2yPcFsENSSxQa8JlVjHeQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dcadffebso2044222f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 08:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737389378; x=1737994178;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPYF3/ytKmNcBW6xY8UN6OXUapKiaxgyBXzq3dB0L9c=;
        b=axKiOmnSA5ssz+kHB2aPosg3xz3AqcHZcWPAslx46eXlZDrSRSg/QAt8cp3YZEoDxl
         rquQaG5TyGAeKgvgFf/822cjv4AW7rdh1/6GdtccUV/SC/pCCi6D+Iu+Pm/h9CGRZq3g
         kVspwJWw+LKn5+a/LMblng9R2QlPV+s4Tdaj19kn99OytNURkD04J7dJSVkI2fIm2Axo
         ZZjXU4h/kZWDgmJZZJc5fvo8IglUryfzYwc3lADz9SpruCzE7XRDERajViGs0de10c9S
         rBytRuUc1ysUPSiqpKpcAltGmN4SSADVYJ1lDzb9JGr6cdYA7Wwmk67V6qqU/deuktvG
         xY+A==
X-Forwarded-Encrypted: i=1; AJvYcCURPfaRfiQwfiQTuxvQjMLwTd2cR7c6jPIiciIyvjGRVnu8E/GypDz4WTBledeDf07R5NQF30TV4h1UVbRt504=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3056FZD39iCe5nzg0hw8XuYWIdGCd03BkBtQoHCqocBrXQRCL
	rSeA5yb8CrmTaePMGUmcCwHRtK5M2bhl6JJZm8ehmJUtT3u7eE08SxVRKzN8+HiqDfiqsQtcszT
	5EyybFlkapLdTF2EqBISpbyPWeO/TwHRqtGT+O+klLcabE7c/uPxsku9jA3RPH6sK0g==
X-Gm-Gg: ASbGnctuwNsmpQThXZMSuZJhf/RdD/3GA1xoTlGaHsI2Hk6ku5MZrt+QANMXgs+E/kn
	otUkgtFziGmIcwEih9qUEm78hl3+dgiFHW+B+wpI+o/jGD07YVZliNpWdkp52m9GKVSs1SCGL53
	460YToWxPiz6jS/lDUZn7aBCphBBvObZRCcbuSSOG2z3jNJ9cQsfIWbu2vHFUY1mEj7Gnd9ut1m
	cJ54mDwM4fZpiQP4gNjBzIXNJQ9PCFOUXhf/I2Cc7BOV6KD1lY8ikeXNT/3g+mlEqBnwp3oaIgx
	c4v1p/C2SacxGQ5elFHy5TqBlDQlmhcB/svEPGGuCzs07w0BGb07JS4=
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38bf566c314mr10592141f8f.25.1737389378238;
        Mon, 20 Jan 2025 08:09:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7jMmKmijGDhYJpj3v2AzDeWwh7lxfHaye7x+JEw9SklvyOVZq+Wb4Niy5wxwqRIeZEeA2rg==
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38bf566c314mr10592030f8f.25.1737389377661;
        Mon, 20 Jan 2025 08:09:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b70sm10695813f8f.26.2025.01.20.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:09:37 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Kees Cook <kees@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Shuah
 Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Nicolas Saenz
 Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <Z44wSJTXknQVKWb0@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
Date: Mon, 20 Jan 2025 17:09:34 +0100
Message-ID: <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/01/25 12:15, Uladzislau Rezki wrote:
> On Fri, Jan 17, 2025 at 06:00:30PM +0100, Valentin Schneider wrote:
>> On 17/01/25 17:11, Uladzislau Rezki wrote:
>> > On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
>> >> On 14/01/25 19:16, Jann Horn wrote:
>> >> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschnei=
d@redhat.com> wrote:
>> >> >> vunmap()'s issued from housekeeping CPUs are a relatively common s=
ource of
>> >> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> >> flush_tlb_kernel_range() IPIs.
>> >> >>
>> >> >> Given that CPUs executing in userspace do not access data in the v=
malloc
>> >> >> range, these IPIs could be deferred until their next kernel entry.
>> >> >>
>> >> >> Deferral vs early entry danger zone
>> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >>
>> >> >> This requires a guarantee that nothing in the vmalloc range can be=
 vunmap'd
>> >> >> and then accessed in early entry code.
>> >> >
>> >> > In other words, it needs a guarantee that no vmalloc allocations th=
at
>> >> > have been created in the vmalloc region while the CPU was idle can
>> >> > then be accessed during early entry, right?
>> >>
>> >> I'm not sure if that would be a problem (not an mm expert, please do
>> >> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> >> deferred anyway.
>> >>
>> >> So after vmapping something, I wouldn't expect isolated CPUs to have
>> >> invalid TLB entries for the newly vmapped page.
>> >>
>> >> However, upon vunmap'ing something, the TLB flush is deferred, and th=
us
>> >> stale TLB entries can and will remain on isolated CPUs, up until they
>> >> execute the deferred flush themselves (IOW for the entire duration of=
 the
>> >> "danger zone").
>> >>
>> >> Does that make sense?
>> >>
>> > Probably i am missing something and need to have a look at your patche=
s,
>> > but how do you guarantee that no-one map same are that you defer for T=
LB
>> > flushing?
>> >
>>
>> That's the cool part: I don't :')
>>
> Indeed, sounds unsafe :) Then we just do not need to free areas.
>
>> For deferring instruction patching IPIs, I (well Josh really) managed to
>> get instrumentation to back me up and catch any problematic area.
>>
>> I looked into getting something similar for vmalloc region access in
>> .noinstr code, but I didn't get anywhere. I even tried using emulated
>> watchpoints on QEMU to watch the whole vmalloc range, but that went about
>> as well as you could expect.
>>
>> That left me with staring at code. AFAICT the only vmap'd thing that is
>> accessed during early entry is the task stack (CONFIG_VMAP_STACK), which
>> itself cannot be freed until the task exits - thus can't be subject to
>> invalidation when a task is entering kernelspace.
>>
>> If you have any tracing/instrumentation suggestions, I'm all ears (eyes?=
).
>>
> As noted before, we defer flushing for vmalloc. We have a lazy-threshold
> which can be exposed(if you need it) over sysfs for tuning. So, we can ad=
d it.
>

In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
single userspace application that will never enter the kernel, unless
forced to by some interference (e.g. IPI sent from a housekeeping CPU).

Increasing the lazy threshold would unfortunately only delay the
interference - housekeeping CPUs are free to run whatever, and so they will
eventually cause the lazy threshold to be hit and IPI all the CPUs,
including the isolated/NOHZ_FULL ones.

I was thinking maybe we could subdivide the vmap space into two regions
with their own thresholds, but a task may allocate/vmap stuff while on a HK
CPU and be moved to an isolated CPU afterwards, and also I still don't have
any strong guarantee about what accesses an isolated CPU can do in its
early entry code :(

> --
> Uladzislau Rezki


