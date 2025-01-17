Return-Path: <linux-kselftest+bounces-24703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC1A14C6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5611A7A0657
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4A1FBC8C;
	Fri, 17 Jan 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVdqlreT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8A1D5CE5
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107457; cv=none; b=Qh4QwC3fYVrozqTKu+6oW/bXk/PCgvbTFyxm727ToUQV26v2meB558HhHwGrN5PCPJXc5EzOJUK7ai6FkWG83dMzZ6pxaZuX7E5adnUkULqJ8W+DmHRQcHQBBh1YkRaqiYrghHmQvtGGn7d7U+sEE21zkqLX3DWN2/YZgDx428c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107457; c=relaxed/simple;
	bh=YDQmnZNuWDRDpTPs8hGbe0u4gXPeipncYfFhncsjtPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tn9U4evyQtJG0libwZvciiAFNOwSEig23AGxtvu2GfB8gpmeD3v7WJ94gFCQwc5/BbsHB4G2ZYUEv9j/TrWa3+hKKtxLS2OC3GfUpvdXSEiCj6xZo/0oM0r8OWiw4Dkhxgk46bMIhWdMpJbZjRG+J8OrbkGhfXxWE33vTQzUjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVdqlreT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDQmnZNuWDRDpTPs8hGbe0u4gXPeipncYfFhncsjtPs=;
	b=aVdqlreTlnpK+2RTrcwE4DaTtJS+ek2ryISZ3tPlCtY0t29vRV0cpbr3S0CZRKNPqOVZm1
	hy79orohjho9m6FtdB8OoknoWKRdXEGoSNn+PegiA8ipJyTdtZbDF4lM7j4gBa2S4u38DQ
	IosSQ1Qj7KXFlQN4TndtxZwbpCZ6ue4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-KvSlOSVAOIK3nIdHPNUiww-1; Fri, 17 Jan 2025 04:50:53 -0500
X-MC-Unique: KvSlOSVAOIK3nIdHPNUiww-1
X-Mimecast-MFC-AGG-ID: KvSlOSVAOIK3nIdHPNUiww
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43646b453bcso9307515e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 01:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107452; x=1737712252;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDQmnZNuWDRDpTPs8hGbe0u4gXPeipncYfFhncsjtPs=;
        b=X0RourgHy/JUNqbp/6AtJzRXWe8sD1L2dc4ZpGfkIi3p7Gm5rXmfJ5Mh8ECKG6P4+1
         79+0GJDmOF+mp/n7kDMc5XmTltCBoxhVRL6V6kyihGSFjcC07kXP3lEJRl2ELiScDuyT
         3NN1nqN0QJNzhBPDHTOfjCQmPTkvBXJ1hAlGnJzH7bTB78oZ0eV1LMS2IgeJW7msVFAD
         bgl0SxcNTXo7s22blBoOLSj+f8nQC/YYNzBTYNGoLbKYyxyuhoCtBgFIjUr9AHEFp/iH
         7sO6gmbnOSnPWp3NnOv7xWkcbUKfdZNBng5bkwVZ0uHAuRjpG/8mBHgPFa1kQqKpNktO
         JhXw==
X-Forwarded-Encrypted: i=1; AJvYcCVLHiCkMLSxynXf30P7TXbQ3qTXBg3uYNslgrZaHNZWVO0bttuCPy6A+bxDc6uTDbfC3unGm5AZaOLEttFAw5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLwvwcwEaEDoKtOzNiY+vyPc1VpxCVZnVPXsJeXuNCaGu19er
	EaKojiTCPWTt5z5oJIXEumbsT2pkC0SVjc/0ahRSKk44liAcF7xe8ZnE7mlcBEHzW2O5NtIKEQw
	B/6z9amzDngDDfuQQHvort8uV7GejP3FJrQLjh1azHhCZ02V41rR9ajPq4nxXkFcsIA==
X-Gm-Gg: ASbGncvOYtcZqrlllVzNNoPgdMaN6eGDfnM734s/m1Dnw+CMYN/raLslnOQufDCkPfm
	YVB/tfj1mFq53wKPq5KPxcLzmR2+U0Ua5DU4OEZZZMx/fF0VqWaxyOt7PboYeIBOdv2UDqnzikR
	MhcTJDEhQ7gtNlmqywFkyJcofa47VDYg8fbyMbAPpHtAIZiLwg/uVxt7F4ZHBVVOuubc3RKCcIK
	NRmzvjfQwzeR/qta2rXkldkUJ+0BZ3ngqddaMBCqV8e7s3NPHL+7WhlAejQSNby3AI//kWNkot8
	HNqdhlCSCzKF1TXdSziZNn1jo3/CytWi9skX9FoxTQ==
X-Received: by 2002:a05:600c:4894:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-43891427762mr17119625e9.20.1737107452060;
        Fri, 17 Jan 2025 01:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIrTJfr3xbQQG9oIc57+hAZrhxLTFv7PUY9ukHOiTt7KK/CefEP4sOd+O4YFea/uwaauu8yg==
X-Received: by 2002:a05:600c:4894:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-43891427762mr17118965e9.20.1737107451685;
        Fri, 17 Jan 2025 01:50:51 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046885esm27213805e9.36.2025.01.17.01.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:50:51 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Josh Poimboeuf
 <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov
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
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
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
Subject: Re: [PATCH v4 18/30] x86/kvm/vmx: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
In-Reply-To: <Z4bU2xlZXh53lgH6@google.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-19-vschneid@redhat.com>
 <Z4bU2xlZXh53lgH6@google.com>
Date: Fri, 17 Jan 2025 10:50:48 +0100
Message-ID: <xhsmhbjw5hipz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:19, Sean Christopherson wrote:
> Please use "KVM: VMX:" for the scope.
>
> On Tue, Jan 14, 2025, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about static keys being used in
>> .noinstr sections in order to safely defer instruction patching IPIs
>> targeted at NOHZ_FULL CPUs.
>>
>> These keys are used in .noinstr code, and can be modified at runtime
>> (/proc/kernel/vmx* write). However it is not expected that they will be
>> flipped during latency-sensitive operations, and thus shouldn't be a source
>> of interference wrt the text patching IPI.
>
> This misses KVM's static key that's buried behind CONFIG_HYPERV=m|y.
>
> vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x241: __kvm_is_using_evmcs: non-RO static key usage in noinstr
> vmlinux.o: warning: objtool: vmx_update_host_rsp+0x13: __kvm_is_using_evmcs: non-RO static key usage in noinstr
>

Thanks, I'll add these to v5.

> Side topic, it's super annoying that "objtool --noinstr" only runs on vmlinux.o.
> I realize objtool doesn't have the visilibity to validate cross-object calls,
> but couldn't objtool validates calls and static key/branch usage so long as the
> target or key/branch is defined in the same object?

Per my testing you can manually run it on individual objects, but it can
and will easily get hung up on the first noinstr violation it finds and not
search further within one given function.


