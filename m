Return-Path: <linux-kselftest+bounces-22365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252BD9D3FD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A473B1F21A78
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8E1547D2;
	Wed, 20 Nov 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1uz6jPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C213BC39
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119339; cv=none; b=QrITFDpWez/WJlJJbIC2mx522lq0zBa3J2mAlTpoozbmvHBMA7e/Qcmyci8OpA1qXyWeZPiG+KAATotoNUuyCZACjBw+x9xQy25T1eDp4YXAFfiC79vgX8j+6F52Ta5sWCf8HNow5iLolzMOlVO/URmCIqb6TU5+cFiow3QvFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119339; c=relaxed/simple;
	bh=VNWYPyllDhn6wyHA8vHCBZcrdTpypW9KdBxrUGgTSiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASSf6V66TlpxjKMP5BROhf0XXPdYf9/1a7C7kpUXcS4VLmOHGGeKl7uXYNhCfndYAtlyF5VGBdqtOmQ8aw6XGw5Y/REkj1HeI3hWCyZFR7H4andhF4Lv3dV8BO3mwUQUICce2/dSma8yvkuidgrnt6OjD7Tl8pjRDIBKb/F5r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1uz6jPL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
	b=G1uz6jPLbm+WxV/Bc/TO1dGFl1/vH/4Gq5Cak83jnxAo5uKcVe+ZRSQyqtm9aFV/YgNZ5i
	jxrsAwRjFox1c3aoHLM0+w6tCQLBVwSHptoLD6lLc/yXQPSXA+kYIlRCEj97kDuj489p9p
	Hud7K6vFOzUitKjnC2z1RH/yitCJKYk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606--_SYUfT0Pz20HkSEZDolWg-1; Wed, 20 Nov 2024 11:15:28 -0500
X-MC-Unique: -_SYUfT0Pz20HkSEZDolWg-1
X-Mimecast-MFC-AGG-ID: -_SYUfT0Pz20HkSEZDolWg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d4189482d8so32440416d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 08:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119324; x=1732724124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9neiNV5Ecw1Rm63FFkLc6Zp+LPvspTbTCjcardEBqA=;
        b=hQ1ll2rXa1pD66MMn4v30aTCvUXlruVdShYHg4rNT4IrClWytDsMsxwP26pAbb9/Mn
         qUChyesDBSdHBCDVoTtOHEqY0Wq8At1Lx6y9w0vB4zSzmQNAJfPRVe/pKlxAcpm+cU1T
         ZmUpfnlDSgPN/m7Jd3DYEJyL1ETTzm2dd3/FUjvHGZyRPqjuyPIs7cM//+aPrOcJsRwk
         TNxQC82Ns21R/uccw6oFzMHAC2ShtJmE/drOsCZuM2fgWjuhawJ10c5BetCCaJodQqWZ
         am9Wkc/pBhMdA1uUZ6JYVKPgOsVU6zyk3kIWVFC2qn4xh9ui/T4NluKoiGZCkmK7G3xG
         twzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgjfgP+oAck0DwFfQO4XN8V0kqCaPmTDxJHd/HG/A8zi1VZ7G7p52L/aDcmKt70vOgPEMNs3xrN1EnIeMaibE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnG9jbtfplgGPbdd+e48owg9lRfXCfUdqrUMtHUxaRjJII/wSX
	5F5QYzl9Ilx60FNvYIoOBz84xg9VyWUjui1vsrkNv7eBSsmstU7QBJOUPoVeV6v8arffmBEJdnM
	YK2X9Eg8Wocu1CzeWZn5/MBWLqXTINbFpyJkf4XLkw9Eb3TsOpTZugqE1WWcyt/RisA==
X-Gm-Gg: ASbGnctZ/DfhA9EMyKruMMp8Zz0IZhaN0GlX4j/yujU1vTfSg1jtCIR01jR+8wwJ+XO
	MCNB90zOnzOqscuDa/H4oku3eGg7fd7gPgRDNps1qsM3s9XVmtI4uRjrGxBntAUntROJYSIimAB
	tPqwwCRJhdHE2XiC2skgZpV7vUBo9QiMF7jZzjRzoAk9qlr3IoUREjCEm/MazO/zyN9cJYXxN+z
	YNO4ocVPbmu8cw8j6R+AAByw0dzmmgSB7dFxmn5q0FYkZXAkaWtwLfcyMcyNB+BXC7LlO0uw72a
	p4ypot0Rzx5YoiidS8X+1nnXng82NKPWLLM=
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43340486d6.11.1732119324041;
        Wed, 20 Nov 2024 08:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErytLY/ydBtG/c68cV9sB/Rs0q2MHssCkf2mLl/ZoHSY4DaUVm1Hfo6p7yhhfkcknSTmK2WQ==
X-Received: by 2002:a05:6214:2aa7:b0:6d4:1f86:b1f2 with SMTP id 6a1803df08f44-6d4377bd8bcmr43339716d6.11.1732119323729;
        Wed, 20 Nov 2024 08:15:23 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab67sm12352206d6.88.2024.11.20.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:15:22 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
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
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching
 counter debug option
In-Reply-To: <20241120145049.GI19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
 <20241120145049.GI19989@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 17:15:14 +0100
Message-ID: <xhsmh1pz5j2zx.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:50, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
>> A later commit will reduce the size of the RCU watching counter to free up
>> some bits for another purpose. Paul suggested adding a config option to
>> test the extreme case where the counter is reduced to its minimum usable
>> width for rcutorture to poke at, so do that.
>> 
>> Make it only configurable under RCU_EXPERT. While at it, add a comment to
>> explain the layout of context_tracking->state.
>
> Note that this means it will get selected by allyesconfig and the like,
> is that desired?
>

I would say no

> If no, depends on !COMPILE_TEST can help here.

Noted, thank you!


