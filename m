Return-Path: <linux-kselftest+bounces-26207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983CA2F73D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB23A2BE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF8255E55;
	Mon, 10 Feb 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9KJjWLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AA192B84
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212596; cv=none; b=gaZyjRj3uTTV2twxWaa54V82eohgborClA/XeGU61o2vEAXwnM9W/T/NgKTxHMp4OLvn/oYJS0dDLKF1rJKZtua7o1LHwsn5Fk0Hto7bsCQnw1q+LAps6xr83mpoJ9JaIXfQBOXtkdH9xBK9pdWCvkDQvQdmwMpC4HwHUrX9aQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212596; c=relaxed/simple;
	bh=fiJBK34xYsYFUmPZtAh8Dtmq/EliyHBgVCGizBc5us0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJYewQJyjrxmkngWejxWtYMExKc0O6Tc9REgiQRF/bnm5ajQ+bspVYcVVdddHcqNvtCAS+9TLJitVAVKoE0XL6Pz8Ln0JX72jsquXY9395/HzzJ2ZdoR7D7GL0rOw67e4Y9lAqXQz0Jkjj8ZShsSWM7a6mssrkVp7xQnuL+G5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9KJjWLG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739212592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiJBK34xYsYFUmPZtAh8Dtmq/EliyHBgVCGizBc5us0=;
	b=W9KJjWLGstlTAMBmoNRiB7oDvsQUk172bJY5uy7hDgcJA8k+xoE5RExUIGIGIU3VXKi959
	efwantijcSYUw12SVyYQLPGpSa9Q121sHqlREUgl9y4mRtc67wZU7LjW72AIlJoIVBlK01
	FhLC6p/IVWVHUsZKpWtfrsDpE7oduxA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-w5GKQFYBNCC0UCa0cfxoJg-1; Mon, 10 Feb 2025 13:36:31 -0500
X-MC-Unique: w5GKQFYBNCC0UCa0cfxoJg-1
X-Mimecast-MFC-AGG-ID: w5GKQFYBNCC0UCa0cfxoJg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dc88ed9c0so1253172f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 10:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212590; x=1739817390;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiJBK34xYsYFUmPZtAh8Dtmq/EliyHBgVCGizBc5us0=;
        b=joEDe4chME4H/D+er/09jBNT5NoVGFfgORW4u9sPQ3vWqiOB2iO5OIciXTinIbNppb
         MakKVo5c2IYNb6+rj3q8RnS7oW+8jubC9lN6OW/fEwD6DX8w6nDC8xehryaohuMVW+Dj
         ZXPrwv8ihmKXz0PIl3Hbd/kxBns0XsHNKn0u2R0mYtzsPLU9mggjiM3QD4aNlZIO9U7V
         whle3Kp3LyZX5MB0ys5vXnEvvbbvAF0NgwqrdqhkDo45coAWbUxFizMKSpahDFBs7NjJ
         IKkafJ4i6h9N65SxzjeKz3oRcZtXdT0wlbwFoRi31et9lv1r1vNmKUxaKYTgnFcMfO5W
         bFuA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGk2w38neaOo2Xu/6ZNl/dpH4usUzasl8sZgPojD1bTbAd/1aTOqt4g2Pm8pBej8jM8lYkBNlUi9DOX6Husk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLPhd38st3/EuR/0xriHOY3qq0aTqkT1nrGHfaQVf/d2Oq3wx
	AkUBxbEJpoHpSckKveer2BunSxzxw7p/I3H8hsLB8nk107JIs7kCxhAhKL64r6Ld0hP/gKtOMdo
	q4opmzvzkvmLn4umHEFG4j/NyP5wwEzTM7YhkGM22OgfsP8QmblEI5VN9EZVHLDG3YA==
X-Gm-Gg: ASbGncuKlgdJJXyjRa5ztQf4OUkde/bBIv3baw62jLwrofi/ZKwOT5pexXnLeuPBneS
	fcTOkPmRGDQzMEQhEs7xL83Dttj03zeFqEHfxlqCkZK4NY3jLARDbQ8wREHJpYJkx7iRhDLEpgd
	WuaVDTlpE5HZgEPloPq6dMSn+MVzxs8MP+m7POEB44MY6qi4RKEykDoRWGw3gGqmSkd79D/qQQ8
	SRKBtn3DzdtfOEkN8kUZGw/rQxhjYcdQKBJl81lmtBIHVKG9BzIEr+FqO4vaKMdK+oET3XA/vh+
	m3EmOpsDM7kAgzHAVgyyEmVQeeovCRxK/Tm1dPqYJh9sx/Ee4N3BKAQ4h5G7uCoHag==
X-Received: by 2002:a5d:47ac:0:b0:38d:db7b:5d7d with SMTP id ffacd0b85a97d-38de419476bmr505877f8f.32.1739212590299;
        Mon, 10 Feb 2025 10:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWifeCshW6jETL9TuYLjadqG7dtdSXfyo+9LdDhlWGx2V5vqBUb9lSHZiG4U0YoCHaPoMeeg==
X-Received: by 2002:a5d:47ac:0:b0:38d:db7b:5d7d with SMTP id ffacd0b85a97d-38de419476bmr505766f8f.32.1739212589672;
        Mon, 10 Feb 2025 10:36:29 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394328fcb8sm43783895e9.32.2025.02.10.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:36:29 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
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
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
Date: Mon, 10 Feb 2025 19:36:25 +0100
Message-ID: <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/25 16:52, Jann Horn wrote:
> On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> On 14/01/25 19:16, Jann Horn wrote:
>> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> vunmap()'s issued from housekeeping CPUs are a relatively common sour=
ce of
>> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> flush_tlb_kernel_range() IPIs.
>> >>
>> >> Given that CPUs executing in userspace do not access data in the vmal=
loc
>> >> range, these IPIs could be deferred until their next kernel entry.
>> >>
>> >> Deferral vs early entry danger zone
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> >> This requires a guarantee that nothing in the vmalloc range can be vu=
nmap'd
>> >> and then accessed in early entry code.
>> >
>> > In other words, it needs a guarantee that no vmalloc allocations that
>> > have been created in the vmalloc region while the CPU was idle can
>> > then be accessed during early entry, right?
>>
>> I'm not sure if that would be a problem (not an mm expert, please do
>> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> deferred anyway.
>
> flush_cache_vmap() is about stuff like flushing data caches on
> architectures with virtually indexed caches; that doesn't do TLB
> maintenance. When you look for its definition on x86 or arm64, you'll
> see that they use the generic implementation which is simply an empty
> inline function.
>
>> So after vmapping something, I wouldn't expect isolated CPUs to have
>> invalid TLB entries for the newly vmapped page.
>>
>> However, upon vunmap'ing something, the TLB flush is deferred, and thus
>> stale TLB entries can and will remain on isolated CPUs, up until they
>> execute the deferred flush themselves (IOW for the entire duration of the
>> "danger zone").
>>
>> Does that make sense?
>
> The design idea wrt TLB flushes in the vmap code is that you don't do
> TLB flushes when you unmap stuff or when you map stuff, because doing
> TLB flushes across the entire system on every vmap/vunmap would be a
> bit costly; instead you just do batched TLB flushes in between, in
> __purge_vmap_area_lazy().
>
> In other words, the basic idea is that you can keep calling vmap() and
> vunmap() a bunch of times without ever doing TLB flushes until you run
> out of virtual memory in the vmap region; then you do one big TLB
> flush, and afterwards you can reuse the free virtual address space for
> new allocations again.
>
> So if you "defer" that batched TLB flush for CPUs that are not
> currently running in the kernel, I think the consequence is that those
> CPUs may end up with incoherent TLB state after a reallocation of the
> virtual address space.
>
> Actually, I think this would mean that your optimization is disallowed
> at least on arm64 - I'm not sure about the exact wording, but arm64
> has a "break before make" rule that forbids conflicting writable
> address translations or something like that.
>
> (I said "until you run out of virtual memory in the vmap region", but
> that's not actually true - see the comment above lazy_max_pages() for
> an explanation of the actual heuristic. You might be able to tune that
> a bit if you'd be significantly happier with less frequent
> interruptions, or something along those lines.)

I've been thinking some more (this is your cue to grab a brown paper bag)...

Experimentation (unmap the whole VMALLOC range upon return to userspace,
see what explodes upon entry into the kernel) suggests that the early entry
"danger zone" should only access the vmaped stack, which itself isn't an
issue.

That is obviously just a test on one system configuration, and the problem
I'm facing is trying put in place /some/ form of instrumentation that would
at the very least cause a warning for any future patch that would introduce
a vmap'd access in early entry code. That, or a complete mitigation that
prevents those accesses altogether.

What if isolated CPUs unconditionally did a TLBi as late as possible in
the stack right before returning to userspace? This would mean that upon
re-entering the kernel, an isolated CPU's TLB wouldn't contain any kernel
range translation - with the exception of whatever lies between the
last-minute flush and the actual userspace entry, which should be feasible
to vet? Then AFAICT there wouldn't be any work/flush to defer, the IPI
could be entirely silenced if it targets an isolated CPU.


