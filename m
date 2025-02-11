Return-Path: <linux-kselftest+bounces-26394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D9A310D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E452A167A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B525A2D2;
	Tue, 11 Feb 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA3qzVxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CB254B0F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290199; cv=none; b=awg74DyFh/OUSuCSWuemdmzAHZKToQQBMqfWsP90BwdVmjEOoQyw72mOnwQfeGuwdVs/elGBaOrOLRTARKCRwESb3wd700lSDojbxVKsZM+/4IV5VryCXij+KlAhNiagO7HOJeMCLMDEuyztSvj67lZSc7ri2nX5dbjnb6wBPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290199; c=relaxed/simple;
	bh=8XsCTn2SryIUrEwNpM26f2V1tVQ1i22m7UgmNeeQpq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hlnz1htTvH+To6WeZCmM2SKiw8Xuy9t2T4/06rsLTR5lQHa2S/nFtyyWZBZlj4D/9O7VS8xuhgQxIMw5NnZWT3VuqZm1TUw6ZeFh3xM0JESbLZCkDpLXEUbW3GIFP7yYcUhnJIBSvsCvGGz+/H1bDN8UHl25innlgFG/zm5W/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fA3qzVxh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739290196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqBw0fvuK6HvmV212DNXANVYi4ije8UDstIz77BqBKI=;
	b=fA3qzVxhZJANrGgZg33N0GUr2U0438VEMc+KaHyn1wTzBUZYIf9Hw58WC+7BbMl1Cyna5z
	EG0wYVPkN3YDHxdtRNqDSQ97jnaSzmYd/yLonNhfKzOb3rMhsgEM2IC2jMd4BaAiCFCuEE
	c52l3/+/MuQohXiTSceKeQ2FR6y3XJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-zbuHOpYQPOqF2sliARi9kw-1; Tue, 11 Feb 2025 11:09:55 -0500
X-MC-Unique: zbuHOpYQPOqF2sliARi9kw-1
X-Mimecast-MFC-AGG-ID: zbuHOpYQPOqF2sliARi9kw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd533dad0so2017808f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 08:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290194; x=1739894994;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqBw0fvuK6HvmV212DNXANVYi4ije8UDstIz77BqBKI=;
        b=NZ/mB5LnMNsZDBuExk3fQEQe2A3y+ChhNUWpdEO7leOnrfXMYp4cw3EH/rZj6/nnlw
         9w8dR7z77WcchWg1mtBbDfppTeOyfaRTcrc6/LL77xLHA1ET0MAVBL7u0fZUPA+baa65
         OVNwG4L9VQw0G2vibyzHXQwzLpDhjlEYOiwQM0hLcUDPJaWB5BIVaE/gvNmp4ix9QyV+
         /b2z4+/kP+SXqmKinSUk0PC7pbeajgXukLeufn2A3TmvqAPktZOsl4c5Kw3AMqUzbjNq
         /6PRztQDuny/BV+41VaFxstMgDu0IKq/ENXZYAEszrVALr4dXJmYDdxnvB60Uc+qiubi
         mIBg==
X-Forwarded-Encrypted: i=1; AJvYcCVcvoQtOvRNmEbxKrYQ++GGdNrUbhwTQYFXd2nw6imRBpw/xLYtCGeLd0eKOUklxm3jG72I06wxDBEDQ8wfV64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnBV6v2gZEjNo3ui/7EKIWLu1LkIyHiT+J/Zb1zXu8o2TiTAN
	PE/PNXQHIb3KB0hQ4xBisl6zPBN1heCKqNPifJIIomd89cjPkw81hfcDva9Gz+pSU3iyLJnpO/q
	PnY8m4zWRGkAAEKdJ9knp2TFfWhiO7oxcFbzk+hd1R7wmYX3P+7okn1G4wUbtq6vniQ==
X-Gm-Gg: ASbGncsLDCPIvNJQcUI68LrnC5dW65kUpQdVulWchqLuA7Qh+VRkkVIZBRbUPFcwkLs
	A3Nimah2pEFvn7TVN5d7/Haw7WxYx6aSIWRGTLf3DrA967dp7jxAsqKNgGN4gnOdU6Bcq89uDYj
	5i7iW+SMayLDhPrPs8IwBVB5CdQusXQuDZVY5zbL+1Vma/ObKTIZzAArIrZ49OPmVZxO/2uwUry
	aSWrovMW8E2vNIEDqxQK/S/1OrP///LqiqvUmxO2lsKi6Q0QAKYIvSfsU8gPa7pfubJTDDmasGS
	yj1P9Xm7gxwsAj80ssugPaAUpuc3wWW+EzHVDPjbKV5QKpId2DZIKO01sqfgofS75Q==
X-Received: by 2002:adf:b60f:0:b0:38d:b113:eb8 with SMTP id ffacd0b85a97d-38de918b920mr304840f8f.20.1739290193758;
        Tue, 11 Feb 2025 08:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK1ASMUo9/0VqOa8FhznHehFcHh+h1fB2eK6UH8SCGRKzMX4fpRgybDSM9A1NmLLMyPAzxtg==
X-Received: by 2002:adf:b60f:0:b0:38d:b113:eb8 with SMTP id ffacd0b85a97d-38de918b920mr304770f8f.20.1739290193306;
        Tue, 11 Feb 2025 08:09:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm15387623f8f.90.2025.02.11.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:09:52 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
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
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
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
In-Reply-To: <Z6tYnOEBkOlT_ehp@J2N7QTR9R3>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z6tYnOEBkOlT_ehp@J2N7QTR9R3>
Date: Tue, 11 Feb 2025 17:09:49 +0100
Message-ID: <xhsmhwmdwihte.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/25 14:03, Mark Rutland wrote:
> On Tue, Feb 11, 2025 at 02:33:51PM +0100, Valentin Schneider wrote:
>> On 10/02/25 23:08, Jann Horn wrote:
>> > 2. It's wrong to assume that TLB entries are only populated for
>> > addresses you access - thanks to speculative execution, you have to
>> > assume that the CPU might be populating random TLB entries all over
>> > the place.
>>
>> Gotta love speculation. Now it is supposed to be limited to genuinely
>> accessible data & code, right? Say theoretically we have a full TLBi as
>> literally the last thing before doing the return-to-userspace, speculati=
on
>> should be limited to executing maybe bits of the return-from-userspace
>> code?
>
> I think it's easier to ignore speculation entirely, and just assume that
> the MMU can arbitrarily fill TLB entries from any page table entries
> which are valid/accessible in the active page tables. Hardware
> prefetchers can do that regardless of the specific path of speculative
> execution.
>
> Thus TLB fills are not limited to VAs which would be used on that
> return-to-userspace path.
>
>> Furthermore, I would hope that once a CPU is executing in userspace, it's
>> not going to populate the TLB with kernel address translations - AIUI the
>> whole vulnerability mitigation debacle was about preventing this sort of
>> thing.
>
> The CPU can definitely do that; the vulnerability mitigations are all
> about what userspace can observe rather than what the CPU can do in the
> background. Additionally, there are features like SPE and TRBE that use
> kernel addresses while the CPU is executing userspace instructions.
>
> The latest ARM Architecture Reference Manual (ARM DDI 0487 L.a) is fairly=
 clear
> about that in section D8.16 "Translation Lookaside Buff", where it says
> (among other things):
>
>   When address translation is enabled, if a translation table entry
>   meets all of the following requirements, then that translation table
>   entry is permitted to be cached in a TLB or intermediate TLB caching
>   structure at any time:
>   =E2=80=A2 The translation table entry itself does not generate a Transl=
ation
>     fault, an Address size fault, or an Access flag fault.
>   =E2=80=A2 The translation table entry is not from a translation regime
>     configured by an Exception level that is lower than the current
>     Exception level.
>
> Here "permitted to be cached in a TLB" also implies that the HW is
> allowed to fetch the translation tabl entry (which is what ARM call page
> table entries).
>

That's actually fairly clear all things considered, thanks for the
education and for fishing out the relevant DDI section!

> The PDF can be found at:
>
>   https://developer.arm.com/documentation/ddi0487/la/?lang=3Den
>
> Mark.


