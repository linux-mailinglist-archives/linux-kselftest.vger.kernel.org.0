Return-Path: <linux-kselftest+bounces-23031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE09E9346
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E503161A49
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F32236EE;
	Mon,  9 Dec 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEf33gsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEBF21D008
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745894; cv=none; b=l/9Ufsz8d9oFw7MKHjYpXlvVsP7yq0FoYcdz2CBdHjNp3Zf6qi+Wwvc7jc66hSpKu1gfahnyvFOY5A4vwvXTYQuG3TZ+Eg237kSF96BkKxkK1P1EFx3m2sHn9NW4k9u2Y3VrzXydHDE6Zz1A4SmM7CceVsQgC9LgSQuecTItlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745894; c=relaxed/simple;
	bh=8ozULsLWQO+vzCljXTI+v97uJ+n9WOO7i0CyLv4/O+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNX6Gfw/GfKyXAv8NLuCl2UVoR/R7X54xS5QUUrrvLzoo6TrmpV/Ugy90Geur0Z4igMUHQ6KJysgZUuj9Pp3uhsgG8tcp1JuHs0Ie/2J09F2EChWmGM4EEGlWoKeWMO5iQ/XGeLvKV61xOf1lGKrrNjCNLk0lBS5OsN0ppV9O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEf33gsb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733745891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ozULsLWQO+vzCljXTI+v97uJ+n9WOO7i0CyLv4/O+g=;
	b=YEf33gsbQshdwypDwPxySygwDdnul1NwCoktrnlIw/sXsAkne6s5Q3jF73oWlLMD+EpY81
	6ZGzLwnLnYXbkXCjAiIyBV75tLrYnxXVUPyGh5giklVBRR6ChyEEfr+V9RtbL7X3moEDX2
	LN6Nc3hU9UylrHTMNlIfKu7SgT2kJE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-svPFEZ9xMTavVLz6Gb_Z9w-1; Mon, 09 Dec 2024 07:04:48 -0500
X-MC-Unique: svPFEZ9xMTavVLz6Gb_Z9w-1
X-Mimecast-MFC-AGG-ID: svPFEZ9xMTavVLz6Gb_Z9w
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e9c69929so758719f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 04:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745887; x=1734350687;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ozULsLWQO+vzCljXTI+v97uJ+n9WOO7i0CyLv4/O+g=;
        b=W6SQUsuxbQrpGVo1vgXvw9e9UjJESQ/AoKI8qp0pGV70pPZ5sqqr8rQKTr7w5XB6TM
         ggu73ToFtANx+D5JMGQIxTIEoIdmcf3+XGtxmRVo5kOo17WNIl3KKXyGLJlx2e0Xvwo4
         vfZIeqxnXXFd+HOCqrGFtBQolqIt0sDQrtIqtDUBBwWnGA0taOUedLq8/CAIPsvUYN+B
         qG3FFRWCzEL8UbmhH7y1VbSjx8knjAceb3iEO3ESVVI27WNscQyuzYwDEO0nbWNZ66za
         LvKxkBMdVwaK40p0kNoqgxSfaDWKtLPdg85hF1tscEeIypwEX/i3S4Q5mQlyMHO+tKaC
         Fx3w==
X-Forwarded-Encrypted: i=1; AJvYcCWKnHS+FMt8u4F1/nhbK9JcpqDeDGI3cofE3LGjvVIucUXqqok1C7oI2H09VC8nav3vc/1yKCseL/olwvL0qtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vAbbhxflo9Z9+DnBEVm/3WJMWD8MJrCq7tYfpiwQmoNsgOIF
	K4aGzbuq52qcCdpOXd9wN6e6RhVP+6yEOLhbUvkqo+WGiIIew2AfHCLjeEe4iL/ij7FUp0weiii
	CYU1ZsTroWZpITwy21DE1EPxnVeSGy3aszvejuH8ZU8zV/8Tvnvb2zcu6TXqaTzoQyQ==
X-Gm-Gg: ASbGnctwTkV05vGd89kiMTPkiZVmPIEiTVlZ4kN/Yv+bCjRzib/FMI3BTWIKOE93Vs4
	ZPpeSYUrfjwI2IIfeYjSaDnY5zJl7aSkJSAFujwqZ7UQ+Nu/2ZES1JARxzqFxHlI1DPPgm7CldV
	KWJkrPJsdGKQSfmzwe0Hy7scSJRnFgbBucgMYy84Cgy1ZY3Gp/ZvHnbF5N7MrRo1sIBZsZh3sV6
	uQTiIw+67yOjvTicNfA4pZKK8sNTWktniueFFjcL9a2hNop8dork23N0xLSPD9P8JDHFbXg0MxR
	okWzifIRai2SFVUIgH7fxkS1ziYPjr12ccY=
X-Received: by 2002:a05:6000:184b:b0:385:ed20:3be2 with SMTP id ffacd0b85a97d-38645401effmr26601f8f.48.1733745887068;
        Mon, 09 Dec 2024 04:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7+TwyI4hfJQ4uZRNXBuUPLYNSzp/LJUZ4222u4bGFUZ10ecblUvGELIouY8pa5AFUG5gJsQ==
X-Received: by 2002:a05:6000:184b:b0:385:ed20:3be2 with SMTP id ffacd0b85a97d-38645401effmr26553f8f.48.1733745886668;
        Mon, 09 Dec 2024 04:04:46 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386408549b9sm2359972f8f.89.2024.12.09.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:04:45 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
In-Reply-To: <20241205183111.12dc16b3@mordecai.tesarici.cz>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
 <20241120153221.GM38972@noisy.programming.kicks-ass.net>
 <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20241121111221.GE24774@noisy.programming.kicks-ass.net>
 <4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
 <20241121153016.GL39245@noisy.programming.kicks-ass.net>
 <20241205183111.12dc16b3@mordecai.tesarici.cz>
Date: Mon, 09 Dec 2024 13:04:43 +0100
Message-ID: <xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 05/12/24 18:31, Petr Tesarik wrote:
> On Thu, 21 Nov 2024 16:30:16 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Thu, Nov 21, 2024 at 07:07:44AM -0800, Dave Hansen wrote:
>> > On 11/21/24 03:12, Peter Zijlstra wrote:
>> > >> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
>> > >> and it correctly uses the non-deferrable flush_tlb_kernel_range().
>> > >
>> > > I always forget what we use global pages for, dhansen might know, but
>> > > let me try and have a look.
>> > >
>> > > I *think* we only have GLOBAL on kernel text, and that only sometimes.
>> >
>> > I think you're remembering how _PAGE_GLOBAL gets used when KPTI is in play.
>>
>> Yah, I suppose I am. That was the last time I had a good look at this
>> stuff :-)
>>
>> > Ignoring KPTI for a sec... We use _PAGE_GLOBAL for all kernel mappings.
>> > Before PCIDs, global mappings let the kernel TLB entries live across CR3
>> > writes. When PCIDs are in play, global mappings let two different ASIDs
>> > share TLB entries.
>>
>> Hurmph.. bah. That means we do need that horrible CR4 dance :/
>
> In general, yes.
>
> But I wonder what exactly was the original scenario encountered by
> Valentin. I mean, if TLB entry invalidations were necessary to sync
> changes to kernel text after flipping a static branch, then it might be
> less overhead to make a list of affected pages and call INVLPG on them.
>
> AFAIK there is currently no such IPI function for doing that, but if we
> could add one. If the list of invalidated global pages is reasonably
> short, of course.
>
> Valentin, do you happen to know?
>

So from my experimentation (hackbench + kernel compilation on housekeeping
CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
occurred from vunmap() - mainly from all the hackbench threads coming and
going.

Static branch updates only seem to trigger the sync_core() IPI, at least on
x86.

> Petr T


