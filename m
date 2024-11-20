Return-Path: <linux-kselftest+bounces-22370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630759D40D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D976B1F220E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3718A6A8;
	Wed, 20 Nov 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/zgbcaf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B315697B
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122663; cv=none; b=hEsLBpx0K+iWtPfVCAp6oa5vmgMG8GyQu6yT0fdYinMLDQtpUsi8nGcKx6D3PqB/c60wgYKIx0+1VhERVBFi9v6fbRXwt0WHYlDUC/cW+Gaga9E+1tkRHP2mrIzsoZ4H7+kA75YW8G+zsz309o74HQyU3bRE2xer4qWx/UW65W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122663; c=relaxed/simple;
	bh=bD2+PXc5yOVf78h3sEDBO2zFlBtAaawUxdecGEXQBRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SoFb5Jz8T4gHE6speORxZ5zOEpP3cDshc3youtUyvcwEvextJ+NwvK8C909/afCdS4LwOg5JNVUk1OpGzXr+7/V/RYlPHxIg00YCCTIa3aHM/SI6MbXW46JuS2SSVEVb4YXbuYmmA3FHTrE+JX7xx0+On4vY7/VRz/6oYXnMA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/zgbcaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732122660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
	b=Q/zgbcaf/1mlQjV2f/sqUERRENB8xwgm1BWOlKVa1vusNEe+aga+qLqh0cMHkHInSIO1aV
	wIqtVejR2WUHeAhzZm8Rkf2ok2ucQ24/BlPAqeh9STHIH6zwRvzX9Zn4NCGTlFD9pCIrHi
	PC4r35K/Lf28FgaYC3bqkCwO2vL0HOQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-IMNpbcSUMk60BX_k00OlyQ-1; Wed, 20 Nov 2024 12:10:58 -0500
X-MC-Unique: IMNpbcSUMk60BX_k00OlyQ-1
X-Mimecast-MFC-AGG-ID: IMNpbcSUMk60BX_k00OlyQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d40df31c3fso326256d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122658; x=1732727458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
        b=BNeISWOOV1PwysvleDvHqZAE3/s2TQ+wP47J0XYzIsv3yYKJDlrrlDH0anfJpNbbyn
         eyP9SI8ahLOhuFO/9mR8RUfHbMJS81U0NfAv09Pd7yIdaix7/nv/pseU2uNCkWkcJsbD
         eFhQzzbxZLxrhCscQYqqTc1DobJscVBA1cG8xAwjxnl8/R0YfSbTppKose/jnSfZkaGW
         3UgHCdMBNLitPXEndUAoeV+zmocAzQ5A/xrWdcK+S+aLlOgOh3dm3iy1DjI4D+7ZLL+9
         55hkZSKKa2MUPfsJYNO7Ifhld+z9epLUqNWPUPJH0IWdoWHaZKR9Wu7MAmSgZAUHlvvQ
         VFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVmIbz7rfKyLoeQ1YisKDfxds9/oxVR7Q0qGqz5YndATUWj3Rv38DK1Wa5ZcsStJ621Z1EfexKn6pafRMqYwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyajp+uw65eapBPoRHNVi3RMLdQdwoirTu8nYaEO112b58zKrms
	dNxe5GbzzVdMuchfVppi89cSWeCSfYBq0FVmMufSkqUqgxG8fQowsCBmfmZO4eVCkqE5xeGfy5q
	Nx/l1G6apsI8uZm6he3P+Ims6+hNP4mYI7wxFb8pzslOOemjH8t/sLg4HdXTwTEdnfg==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503516d6.18.1732122658285;
        Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv9CkwhZjIaA2k5+ZORakSpYnSngvWk8FXITINBTOVrkhvREcruWPODJNNTMgDJRVDzvSyug==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503036d6.18.1732122657909;
        Wed, 20 Nov 2024 09:10:57 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab11sm12976636d6.94.2024.11.20.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:10:56 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
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
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <Zz3w0o_3wZDgJn0K@localhost.localdomain>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home> <Zz3w0o_3wZDgJn0K@localhost.localdomain>
Date: Wed, 20 Nov 2024 18:10:43 +0100
Message-ID: <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:23, Frederic Weisbecker wrote:

> Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
> CT_STATE_IDLE.
>
> So that could be:
>
> bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> {
> 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> 	unsigned int old;
> 	bool ret = false;
>
> 	preempt_disable();
>
> 	old = atomic_read(&ct->state);
>
> 	/* CT_STATE_IDLE can be added to last patch here */
> 	if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
> 		old &= ~CT_STATE_MASK;
> 		old |= CT_STATE_USER;
> 	}

Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL check,
but we get an extra loop if the target CPU exits kernelspace not to
userspace (e.g. vcpu or idle) in the meantime - not great, not terrible.

At the cost of one extra bit for the CT_STATE area, with CT_STATE_KERNEL=1
we could do: 

  old = atomic_read(&ct->state);
  old &= ~CT_STATE_KERNEL;


