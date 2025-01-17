Return-Path: <linux-kselftest+bounces-24741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD5A15524
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807E3169C15
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057319F42C;
	Fri, 17 Jan 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZlk6cCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04025A636
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133239; cv=none; b=ixwUXcMegDRy75UaILdU5HMESLAPPswUb+Yu4CYv+BnqwoAyc3N+iWH7C3eDzbToLMjavEFkUkDXTWTmfoGFKYBqsoIjuAtErbTyGLzy+5haO5kFscp0gS6RFKRPD5aV0bZxbN1I+E8IqQ/M17aHbJdSEYowGG+q/1tSd7obG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133239; c=relaxed/simple;
	bh=XGvTpyNczRvA62kOrzrUa3TgLdL0aqoCD5BBfkghzOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g348yt1e7JlZn/hVxIjMk/aSpKTXYhUZoO9x3K1Dx+GLsujKaTjVYv904vcZO1pmKFjRlKpROO+z1EuFd1RXN/2tiYij1ef2BgkINHCjaF6SseiVgAAo0BlS3o9VdIktmAuxxn4D+vu66yTgUCqSBds+5vawIuVztMEL3foTSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZlk6cCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737133236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGvTpyNczRvA62kOrzrUa3TgLdL0aqoCD5BBfkghzOs=;
	b=KZlk6cCLkfdus45rkWNvnrGFl2IsQ106CLyf1nYlta6bxWH65shiImKnvWzlkR6L0qJxJz
	nBICr3fYWHOEwCJ8YDuUkCX8Ht4djV7ETnjAqlX0nRiJsyU4ieOd3IFJZHXSII01jYaXJf
	xBHqeTvdxkia6aDTh13LxT3WDt8+y8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-VRYOi-8YNmi6GEsNIvFlnA-1; Fri, 17 Jan 2025 12:00:35 -0500
X-MC-Unique: VRYOi-8YNmi6GEsNIvFlnA-1
X-Mimecast-MFC-AGG-ID: VRYOi-8YNmi6GEsNIvFlnA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so11215245e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133234; x=1737738034;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGvTpyNczRvA62kOrzrUa3TgLdL0aqoCD5BBfkghzOs=;
        b=CeE3P7Ae7PdOfNylcbVS++1PRZXnV/W4Saf8Ot/BcmSpu8vV9+iasDULNu7Rnpo7lC
         /jnmEajucwgd0UK9mxLrMO9wT2fPkk3yxQP0e1rPSqbUBU7zcnseImzWiihMqJzHIhbs
         b2lkQ7WwXiYOLIK1jGE8uceS0Agjtzn0/xqX5/8uemSjWbtbXeIAYtk7cb7BB06AQYGz
         HADW5TotpyxhXwGZGZEbQFqBq0aUIDY8IR3LZGaKdPVjK2g/XPd0APIhGqYvX544uEUo
         WetLV4vunmpKWGbn038szUFTd7zE+VupvmOAebhE3z53nuZZ3mxixiEBtjg3hgvhdvkK
         cY9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVI+nInCvx4qOpKhB2abuiqQ7o+SLxf6hkxhszEz2knlQJabXrq7tTAUKCbw8B3PZDOCxNHezmvcE80DlQ5+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QCKS+QEcEyu8decqAi69TstFk84clCm0/GDV2Dhr6HQm3jrw
	FB8ZhPRV3S2TJZWLLz0u+fQKeKxHGHqRo5JHv7LhZPL3IvVxdvYYNVrurMHvRZj0OhbPW4TMc4o
	BeJ0LtkG/KPpYj5tlxAJGhYZ5Cl6X38KKCXhiQhrTR3Qh1amO2tO38d8pY4dNhfB8Bg==
X-Gm-Gg: ASbGncuyrJLU9gZ3JED7tQFRSoziiVJhqd6zGh6eWIvOzxvmsBwzJAPhmOcqU0spKPh
	bDQq9Wibzr+VWNO7T6+u77s/fXZjANFZjv9p7D/4Ks6iau9w4mBfFRUd7S2aeLpoNd3XvoBkHG6
	1JmmdE5/+2+Oy3vH1NL9NRC4EHaYCYjlknucWrnSP4DeGbRy4D2FcHkvaDyntm9EPwtIIr/rqbf
	4OxCQHQWNmCrmDK8ttREb4Ji4S/wp4tihzCUclaaxRcZXweWVihg0aY8KGrLeUceT1Zr5loqAaw
	TtYSC6/ISVMNw9y/8zReNpLu1qRxtPIDibppmyqdzw==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-438913ef6d0mr38316795e9.18.1737133234096;
        Fri, 17 Jan 2025 09:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFagDashmtCONr1e0mPjwxw78kvxvfLwflTa5M+wz0yje22vE2jx/prTk0zBbNIWdtqILag4w==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-438913ef6d0mr38315575e9.18.1737133233397;
        Fri, 17 Jan 2025 09:00:33 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499932sm99166875e9.7.2025.01.17.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:00:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
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
In-Reply-To: <Z4qBMqcMg16p57av@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
Date: Fri, 17 Jan 2025 18:00:30 +0100
Message-ID: <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/25 17:11, Uladzislau Rezki wrote:
> On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
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
>>
>> So after vmapping something, I wouldn't expect isolated CPUs to have
>> invalid TLB entries for the newly vmapped page.
>>
>> However, upon vunmap'ing something, the TLB flush is deferred, and thus
>> stale TLB entries can and will remain on isolated CPUs, up until they
>> execute the deferred flush themselves (IOW for the entire duration of the
>> "danger zone").
>>
>> Does that make sense?
>>
> Probably i am missing something and need to have a look at your patches,
> but how do you guarantee that no-one map same are that you defer for TLB
> flushing?
>

That's the cool part: I don't :')

For deferring instruction patching IPIs, I (well Josh really) managed to
get instrumentation to back me up and catch any problematic area.

I looked into getting something similar for vmalloc region access in
.noinstr code, but I didn't get anywhere. I even tried using emulated
watchpoints on QEMU to watch the whole vmalloc range, but that went about
as well as you could expect.

That left me with staring at code. AFAICT the only vmap'd thing that is
accessed during early entry is the task stack (CONFIG_VMAP_STACK), which
itself cannot be freed until the task exits - thus can't be subject to
invalidation when a task is entering kernelspace.

If you have any tracing/instrumentation suggestions, I'm all ears (eyes?).

> As noted by Jann, we already defer a TLB flushing by backing freed areas
> until certain threshold and just after we cross it we do a flush.
>
> --
> Uladzislau Rezki


