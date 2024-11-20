Return-Path: <linux-kselftest+bounces-22367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CC9D4026
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246AB2819A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0914C5B3;
	Wed, 20 Nov 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJJgIYDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C113BC12
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120486; cv=none; b=X/e+NN9PSdQ86ND9pWrKL2DFtz8+T2Q/Ux+um3m3xh6F//uhpbemp0fZpsbpnhVhPrpzbtBCNmMGh+KO6v8ZT86rIP3ENS6X+h+mq3wN1eh0H993zrsXPar7eqpsvVF9Uuj0Db6R8i2bM2Ar1w1OUyFW2/wy8nJNaMxXP9Jy1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120486; c=relaxed/simple;
	bh=CnsBTMGWcf5M8NoeZ38IEeXK/Z4PUSA9a8D7eN7JuxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAlSbm/1gp4T0xkhWy3VwVMekeldFOeh0U/KQBuRU8rLYqI/W65kXw/4H0Cd0fVoQQLUvw0+UYBbDhdPe6X5p0WHrvoUUGq9QcPQucX7knsPUKm0G5R6SobEsoWLTqLczd/emouU8UdLebi3kc/NQxuSDJ//Q10nWHjMULD2JYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJJgIYDb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732120484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B86g3yeGl3bc8HkRs4Pts1DK7V5+9VBe3Itq07US390=;
	b=JJJgIYDbOaI7MKCBKKLsQzDN2al4/ppOnnVwBpVksALYQLHL0XMKuPon+NsWcGtg3Qr86O
	/VzRqnyzZAr7KtUuIeUX8DHToozMs0orAgosSDhfx/xUemXKKhREmkbY/nSrIo1MUH8BEl
	2SWAdChtfkA0KLnAqQEx7Qg+QVRK0bw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-ONT_MSoFOs2pCD7g1UJ4IA-1; Wed, 20 Nov 2024 11:34:42 -0500
X-MC-Unique: ONT_MSoFOs2pCD7g1UJ4IA-1
X-Mimecast-MFC-AGG-ID: ONT_MSoFOs2pCD7g1UJ4IA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14cb9f6f5so353520685a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 08:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120482; x=1732725282;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B86g3yeGl3bc8HkRs4Pts1DK7V5+9VBe3Itq07US390=;
        b=ZAXvApVhZ34VUpZwLl/Ffb0TNHtj0JfocQzYZZKvcTN2WscW+psVzJLsakztztM8Oj
         Aqxuj+oUpZEKrdZaxSKXfOI6FL5+N7EPex/3XHqbB9yFPTJ5AtHSpzw/x1P+TcD+dPvP
         aA4JxSqZQzZs6/fLb6tnTnhBjrjhZCWQPBwpmroTy0OIYJs9OStPt2c9QjH8OCLTsK0p
         9ox9Wt2112SB5qLj66dbch8aS3hf2k3tlwhGMfhLZyNX/EDHXOek0HMVswvjmjXNnaME
         c744OF2DfhhlrqbHp0hLOmVI7hK20voBD9HBkiXSqyqJZI2mVIwY7DSsYCqkrReW8EHi
         vhvg==
X-Forwarded-Encrypted: i=1; AJvYcCVJHhtGZAJzpujMuhPTWiFqUP4jb98Ro1n8S2NyPCi/jsUtRcdlnDfkV0dmSUfWllNcaYDDJhrzf7NM/p4PzAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrQe1hVzh5FBu+ncAHuH1d4I4iLNxjg+VgvnwivMuY+N0nlM4
	cMqXSwRRPXVZZfY4RJ52eiu2JzzyeUd9hXzuywivcYv7n6qIKk6q0tC21+PFNsjdzjenIchjUhM
	uzZuU9NmVd4ckN7vYCTjY+w11vE9xmUjqVwincQYuMt2+OVmNSox5hhM9fww12nKuXA==
X-Gm-Gg: ASbGncvsf49Xf4DMImp6JLBQux5cJtnlDLEuVkM2U9PvAqRhk0x2hVy/Pd+kJhGMrfV
	aL72Jjw0ktiXLVeSWPs6oYpfFixL3hiUf/SxL9/Jy/M1jJLSjpt9OUcl/cfBOXVkz6dgPG0neMV
	UNP+V97LqgwqFuwZUTiediTFw3Qi7Ou13svDS2Z20/h7YMecqF+WYQ3XIx8U5hIOcybWoF1fT6m
	IpswaRvOwijgiTisptNFe/mJf3oy4hpNeFv6WCy2v/TJKnOLKTEDJqpHo1CMO1f2gNhDIgRVmZ5
	Stck2jwb3VfLKWRniJ/U6miu2YpQGbCvp0A=
X-Received: by 2002:a05:620a:1a90:b0:7b3:7e5e:8708 with SMTP id af79cd13be357-7b43bed4bd7mr355531985a.59.1732120482239;
        Wed, 20 Nov 2024 08:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW1sR9A/+saR1lpfmvKEOVIZYurnawvss8FWysYqEx/qwbDy9sFoGDQpoH7d4xuTE1Ki3dPQ==
X-Received: by 2002:a05:620a:1a90:b0:7b3:7e5e:8708 with SMTP id af79cd13be357-7b43bed4bd7mr355524385a.59.1732120481951;
        Wed, 20 Nov 2024 08:34:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b48523f72bsm112716485a.104.2024.11.20.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:34:41 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
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
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 08/15] sched/clock, x86: Make
 __sched_clock_stable forceful
In-Reply-To: <20241120145904.GK19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-9-vschneid@redhat.com>
 <20241120145904.GK19989@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 17:34:32 +0100
Message-ID: <xhsmhv7whhnjb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:59, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:34:55PM +0100, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about non __ro_after_init static
>> keys being used in .noinstr sections in order to safely defer instruction
>> patching IPIs targeted at NOHZ_FULL CPUs.
>> 
>> __sched_clock_stable is used in .noinstr code, and can be modified at
>> runtime (e.g. KVM module loading). Suppressing the text_poke_sync() IPI has
>
> Wait, what !? loading KVM causes the TSC to be marked unstable?

Ah, maybe not, I saw the below but that's actually the x86 specific stuff
and IIUC can only be builtin:

  kvm_init_platform()
  `\
    kvmclock_init()
    `\
      kvm_sched_clock_init()
      `\
        clear_sched_clock_stable()

There is however this:

  kvm_arch_vcpu_load()
  `\
    mark_tsc_unstable()

So plugging a VCPU might do that.


