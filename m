Return-Path: <linux-kselftest+bounces-24705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C4A14C8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C087A17BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E757C1FBEB9;
	Fri, 17 Jan 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE8U3DmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEB1FA8F1
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107663; cv=none; b=j1WFoIoykS+7pVZ6HlUsx3RjbgCMNEYHae/TrNNgLxDjAZoFUjCPvTPZquCdq3CbqyYVbnqNtem6ff8dWHcOfpVPBwmMjmoITSuV2FIU//k1s4KOMc+bWmsmo17fiscVOi78lwkoWZxyIkhUq3RPstUCj7k494FqJ5YN4MtkjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107663; c=relaxed/simple;
	bh=dfiy2R/0rK2WNQBFJ4B8wz0dhd7gEAJUhvpkWIIsvfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyENGnqfZBd6J8qWNijJOlQ/dZ/fjWqj9Z/9IL3UgxRm3nw7B7drLSGkTXf1FE34qcsIEwImKfzFB2WJnr1SS8hIQtCNeDnZTxv1yaTsRgGuHgU9VykFjQe0wMZ+z6wS5RISvcbPWxUhf2HEF1jbLU16qcRT4gepV8C3h3L959g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE8U3DmT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9Oe7BkLz3ZQnhnrUC9eWHjE3nyj6wgCJoWV2O/5t40=;
	b=LE8U3DmT3gzpsSVFq0G5WDH9SYgbFj6TVLii4ma06aBuEWYVYd2eJNuxPkNLvfsYiqJuu3
	SaD/zTjPzp/QiCEAsfHKsreZ/8YCg/VmwgRRQJ/eh+c2PIGcZaqG9z/hNRVmWS1ohVGyie
	d/a/zXCy9UjF3/6QPXwk8EnEFj9v3vA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kk-3G1grMVymR6Ifz0EOOw-1; Fri, 17 Jan 2025 04:54:16 -0500
X-MC-Unique: kk-3G1grMVymR6Ifz0EOOw-1
X-Mimecast-MFC-AGG-ID: kk-3G1grMVymR6Ifz0EOOw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43626224274so9700625e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 01:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107655; x=1737712455;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Oe7BkLz3ZQnhnrUC9eWHjE3nyj6wgCJoWV2O/5t40=;
        b=LW+2SHp404yHGFBCXCVuMWygoJKYbBKyNuaVCirrCoGxutH9AGLbRS4rt3BBztqMGr
         RDa5gwviyotB5NT8ol0ZsxOeaS+HXitBb0gREuKx5mVvs9g932FmKOHI97oQ01QB31iT
         AwI5KmjV4IqJkdFSD/h7YANrz2PxuVkDZa8rfXbkI0NfwKHZ/phzyTTNeCdd4XSSmHUR
         0dabwMYnlW4X3f76M5N0F8EnImSS/dUsQxyV6KiXNOEXTygMGqtfJVELwypOXv5l4j70
         uk6XS5cDiWO6VfYsY1ENiIYfEykRzBEmmoIkmA/gS9nPMxtoi1RJTgLhgNsnWxLL7vne
         1Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCUpx7UK+NOyzKuJHUt3PxNWmCGGIxwSmxatvo8BpWi/W0fQ333PjOGeGNWq2/I8Sajqi4wl2aUaKkozniGO6kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0m4mOZ2YBFP3BMY8PAFlWhmJhaMzQSIbFFtIesBMNA4lvg5o
	0DHBA/m75RlwFE1HipXaNQtg3QNn+EGOKdlDV6rGCyAqXAjsnf/p5ThNCHe3Wnmw89N0UVw/veL
	nb4PqMDin+dYjGeqXVZMZlDAodBY4PGi1oaSu1uPhTz7ySleGgowSgksNM44XHeHgsw==
X-Gm-Gg: ASbGncv6OoY/6rWVvgtiRIksxuCbeVBfsPzrLN1lbLlJH2+1nsSvPNtNYmnVTG+a5KH
	Dt0AcNpxfn8I3HJpgR8Fzck3I37ORqMFwCLjMvhi/UY6AkbCeddJ5CPekhszEDZuDJvRDgCFRwr
	YnDTaXbXmBTD8QufxOYlrWNqg+rQJ9x1en7rm4yTkLfKnYC/PIqC/VGiChe/C2smN0TQpYSkPDZ
	yAnYbZsOGWupQgtGQgWcdqMXcmppaSeieJjI7zNSUjosQZqYsSbhYpg/c9pZbw3IQ/+sjBK/Jck
	GuFbWdb3zeZRxt3uqFbR84F5af9iQO0d9C/wOC4tyg==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr16339245e9.19.1737107655071;
        Fri, 17 Jan 2025 01:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuw6rUkDZiEIMePly7ic4RGfvY46wjcWihk2kMpcZz3D30VqRFOYeHlJ+bekZM5WnBbSAhfQ==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr16338925e9.19.1737107654599;
        Fri, 17 Jan 2025 01:54:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890420412sm28393455e9.18.2025.01.17.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:54:14 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra
 <peterz@infradead.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
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
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text
 patching IPIs
In-Reply-To: <Z4bbwE8yfg349gBx@google.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com> <Z4bbwE8yfg349gBx@google.com>
Date: Fri, 17 Jan 2025 10:54:11 +0100
Message-ID: <xhsmh8qr9hikc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:48, Sean Christopherson wrote:
> On Tue, Jan 14, 2025, Sean Christopherson wrote:
>> On Tue, Jan 14, 2025, Valentin Schneider wrote:
>> > +/**
>> > + * is_kernel_noinstr_text - checks if the pointer address is located in the
>> > + *                    .noinstr section
>> > + *
>> > + * @addr: address to check
>> > + *
>> > + * Returns: true if the address is located in .noinstr, false otherwise.
>> > + */
>> > +static inline bool is_kernel_noinstr_text(unsigned long addr)
>> > +{
>> > +	return addr >= (unsigned long)__noinstr_text_start &&
>> > +	       addr < (unsigned long)__noinstr_text_end;
>> > +}
>>
>> This doesn't do the right thing for modules, which matters because KVM can be
>> built as a module on x86, and because context tracking understands transitions
>> to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
>> being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
>> or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
>> patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
>> use the wrong static path.
>>
>> I don't expect this to ever cause problems in practice, because patching code in
>> KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
>> actively running guest code, would be all kinds of crazy.  But I do think we
>> should plug the hole.
>>
>> If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
>> assume module code generally isn't allowed in the entry path, even via NMI?), one
>> idea would be to let KVM register its noinstr section for text poking.
>
> Another idea would be to track which keys/branches are tagged noinstr, i.e. generate
> the information at compile time instead of doing lookups at runtime.  The biggest
> downside I can think of is that it would require plumbing in the information to
> text_poke_bp_batch().

IIUC that's what I went for in v3:

https://lore.kernel.org/lkml/20241119153502.41361-11-vschneid@redhat.com

but, modules notwithstanding, simply checking if the patched instruction is
in .noinstr was a lot neater.


