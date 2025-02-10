Return-Path: <linux-kselftest+bounces-26263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600DA2FC9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA491886C23
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299C24E4C0;
	Mon, 10 Feb 2025 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Er4k8Jgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAF24E4A4
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225377; cv=none; b=DidMMQIULDiE6iRz1a4oDWV+aiuAsmW5Ss/sqSVs8JlMyrD7cVf+EiWz+bsHgVl52PgKG0fxhiM/71GLt+UFbDek8hLKVbh5Nv5oCh/DrPgMvlhan4LzU8cqvoOv5mjJnW+Aa1An5O1oCHbafQH4lInKlriprEfWNUULkae2SCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225377; c=relaxed/simple;
	bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6Nfu8VSCAlVE4W7gyi2cIVys0tfzsAr9MsL9DQgIF4J6EbULm12F9oZYXJQTqqi/2VZis6AFUXEhbPfZPV0z8C/8x54UV2TBG2vIaA1rNka2xYajvW1synGqxiY9NdUJPUAC/vuQlGsfik/p7dFM4VHDizLxG4HemJz1QfRsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Er4k8Jgg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de6d412ee9so926a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739225374; x=1739830174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=Er4k8Jggi+SM4CnJwm27bFFKeQkowgsaqOyOh89teRf+uRTV8W9l50Gr/9vDaBFO2l
         DdtALmmisHwzd0PONwPMwil4vpdlJoTeTDFTI3ixQL7x7X8vLAV4839xH0GVspld/V+6
         96JBHWoYyIJDLDlzGZC/6SyFOwuKXU6qjZY/YzEQ8WeXnGJ1AsmfW2qXHUaA2we5g0v/
         ArIgVC/8Sq4RykAHj7LkOYAzsNPoLcj/bsq01O5TmO1a6pxI+7SI8q9/zDIrXXSR8D6Y
         AZAXikH7tZA/LJrwUl9A5DHiVLl+THQrcU87unLFsk16627Gmr4dY3LrCGoj8FQzh2mc
         KLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225374; x=1739830174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=aTJ0V0QxwwOinD8PLC75mgPkr3n5kznN3IHP3KCFDNZz5ciOGFH9nh2+mrsGisd8GU
         3aJoUSAKRwGfVQPDTIZyXCE2WWSUGAH0IbORgY68m8yFaZ9qnADDU+e7l3lyP6YAyyms
         QcDB9N0i2vgRfgJtrefzRjOfyULWh8yskRY4AoJn4I0e8KcindvFIXImZ9t2uCW4tPf4
         q7hfb+OjaNOvrOl3ZxBjE86OD3h5g19W9zQb6SfFD/P/f+RiLcGhlV6HH354P0gQ209r
         WE8vZaArGrhHG7I596eJ/Ef/9I0Wc309BhpkqPa8PZ8Hj2nQ3TSDDBi215DMVfB6KXh5
         d7uw==
X-Forwarded-Encrypted: i=1; AJvYcCUXEktf8S0FdNMTU6/k+gH1poZHVuHxdghASLSYN2cu+FE2PCr3Pbx/JsrTZ+2H+9m98RB9VL/nY7D1s5/qoIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy823w5ZCVWCl8pmRT45fOVSjPbIrSZ9Cx9BYMESPZBayaMnf1v
	jCCrv9/Zow13TZuumTBPTNiqHQbehF5chTZzDUfNPhAQXqj3eZdPJlI1GVibHLg0LVtMTix53Xg
	O3S1IfRfV2hcm4TDi7B5yAmh5H50RKOhgv8f2
X-Gm-Gg: ASbGnctc8Vv0FwqEIcwqu8uErx9PbSiqBAEONF3AuJonnuDPGB6nV8C2BHIcOnR/f9O
	6hA5PMtZxIrFGkLy/vZf8OLvN05BusMWEwIo85xcGg2VlNbOINYD83A97Y9otJyv6VE7UfzIRgK
	H01q/laC6v9kmwMZr2iposZIE=
X-Google-Smtp-Source: AGHT+IG6JmQxBrqAHiHQy9r7fd0aAn9Heiw/iaJpJbhcsh707Pq8kG+sl2h6STthD8Ujnt3Wdn5OEmJdDMQ5PMlBL9s=
X-Received: by 2002:a50:aa93:0:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5dea05e7838mr1520a12.5.1739225373121; Mon, 10 Feb 2025 14:09:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com> <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Feb 2025 23:08:55 +0100
X-Gm-Features: AWEUYZmtdNVDV_xq3vvo5TVQ7aaS79EFzdycTCfl72XGpztchND9QHjN9zcxWNo
Message-ID: <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:36=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> What if isolated CPUs unconditionally did a TLBi as late as possible in
> the stack right before returning to userspace? This would mean that upon
> re-entering the kernel, an isolated CPU's TLB wouldn't contain any kernel
> range translation - with the exception of whatever lies between the
> last-minute flush and the actual userspace entry, which should be feasibl=
e
> to vet? Then AFAICT there wouldn't be any work/flush to defer, the IPI
> could be entirely silenced if it targets an isolated CPU.

Two issues with that:

1. I think the "Common not Private" feature Will Deacon referred to is
incompatible with this idea:
<https://developer.arm.com/documentation/101811/0104/Address-spaces/Common-=
not-Private>
says "When the CnP bit is set, the software promises to use the ASIDs
and VMIDs in the same way on all processors, which allows the TLB
entries that are created by one processor to be used by another"

2. It's wrong to assume that TLB entries are only populated for
addresses you access - thanks to speculative execution, you have to
assume that the CPU might be populating random TLB entries all over
the place.

