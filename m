Return-Path: <linux-kselftest+bounces-22366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7A9D40D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D08B2C66B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AA1537C9;
	Wed, 20 Nov 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaxbdP92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693D44C77
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119913; cv=none; b=A0CwcFIOU6yLc0RdDXxVNIIO0gsBvDrjzlewiz0P/rWnrHhzUgQWfa/CIezzAwP9CE4pohMP/pO3OB6GYBh8gHooxQ7adc428K8H72kd9WsHA6GZ9v4I4+6xL1BrB1tEvU55cfHTjVBakDniu21vi67ZosLXPu8n3dHWYBXMM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119913; c=relaxed/simple;
	bh=93S9b76DLfHg1j3hGUFKC6KusKfH4b9Sf6zjZ5dEV2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/9eza+65BUg0Ltzz3D3GW8UehWtjH6UBUpdUs+hJbKNA37X9DJ8pLsUviAwWiX1uwM5Rjw3iJr+cOf6upyiNGEY6556sszBUI2kg33o8QZvKIiCT4wBf52XgagtCZvEiG/hei15zcYg/+vTmOKe6+b4Nt10GbaO2UymAEd2ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaxbdP92; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732119911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnMkGleZIsu11xw1ZkKAb4+ieA42pt74OZ0CpBzWkW0=;
	b=QaxbdP92GW7Kjf9JPRsY4MrUhsG5l0ncHaJojpCul2Q+S3ph0tvJFbaEQ2K5Ww/7Zh79UX
	Il2ab+0LACUIpMuU2Rm9+gROVcpb0muc9pqgqLWnRE6IcpWefMjQ+1WcZW6jhLHfG6Ou8N
	SNfFi2LwlSN3DvyFCCOqODmOWYElVMY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-lExeTrXSOE-ICrI8vPBCDg-1; Wed, 20 Nov 2024 11:25:08 -0500
X-MC-Unique: lExeTrXSOE-ICrI8vPBCDg-1
X-Mimecast-MFC-AGG-ID: lExeTrXSOE-ICrI8vPBCDg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b147855414so110436585a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 08:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119908; x=1732724708;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnMkGleZIsu11xw1ZkKAb4+ieA42pt74OZ0CpBzWkW0=;
        b=aBvYlC9sAO1mc2lQPsXUTkAK8ABJeVwfJP/nwSVBAW8rL+hcQVACZ/BUeYldBk5TWT
         diaPlzMKpwmQSvCNCX+NI+L/5C0GO2hOz2o/iVmKdx9fIxf3bBzOCEAOK9TMtdfen6at
         0r9nnTluxx/o+97fPr83n27vJRpfo0sGlv1o+mThgDTyXmD8PUxKn03RyVlPNAukp72Q
         XbQiW9PCrROgP2vmfXMJdPZ0GpZzUkhIPjJ1x6KUHw86yTZJszOlUqX+GFYlp7YFnuf6
         Vzi0hx1cYaeULl/X9BE05w8n8n59naQk3HGgnt0cSXPR+0PrhDdbGiOVCrL9OfS98ZW0
         dJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWk+DCL82osf6jkkWUi2bSKccTuMbl0wdmx/0nxYCWaPUtNp2c67z/J7UnaI9XbXmrfTdOE8N1MqSGD3BzAfqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIEBohV7OwUeeZuQZWoiXzF6JLNF+/9D1j9ovdubJkhUYv/GO
	kehi7usulxePvq83Yw2XfVbWs7HgWPESN+URGH8JO+3xkkiajrCJGl8UHykKXrCkWXUtOXC843e
	2TqXf+1aeTKnAJjYcjvV4tybhmjKGW4aef+V93bmVwWOWPZuGT9mqcm9wO95pnxxQDA==
X-Received: by 2002:a05:620a:1993:b0:7a9:be53:fe3b with SMTP id af79cd13be357-7b42edcbc1bmr441519385a.14.1732119908209;
        Wed, 20 Nov 2024 08:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+5agK6i6snnGPwkWZs91MFHpm70SIo/e9jAKzDpAFTE1YXLtw0mxvEd1b9vUkNxYONzCDpA==
X-Received: by 2002:a05:620a:1993:b0:7a9:be53:fe3b with SMTP id af79cd13be357-7b42edcbc1bmr441510785a.14.1732119907854;
        Wed, 20 Nov 2024 08:25:07 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b4852400a3sm112207985a.96.2024.11.20.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:25:07 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
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
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
In-Reply-To: <20241119233902.kierxzg2aywpevqx@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
Date: Wed, 20 Nov 2024 17:24:59 +0100
Message-ID: <xhsmhy11dhnz8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/24 15:39, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about non __ro_after_init static
>> keys being used in .noinstr sections in order to safely defer instruction
>> patching IPIs targeted at NOHZ_FULL CPUs.
>
> Don't we need similar checking for static calls?
>

/sifts through my notes throwing paper all around

Huh, I thought I had something, but no... Per the results they don't seem
to be flipped around as much as static keys, but they also end up in
text_poke_bp(), so yeah, we do. Welp, I'll add that to the list.

>> Two such keys currently exist: mds_idle_clear and __sched_clock_stable,
>> which can both be modified at runtime.
>
> Not sure if feasible, but it sure would be a lot simpler to just make
> "no noinstr patching" a hard rule and then convert the above keys (or at
> least their noinstr-specific usage) to regular branches.
>
> Then "no noinstr patching" could be unilaterally enforced in
> text_poke_bp().
>
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index f5a2727ca4a9a..93e729545b941 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -200,7 +200,8 @@ struct module;
>>  #define JUMP_TYPE_FALSE		0UL
>>  #define JUMP_TYPE_TRUE		1UL
>>  #define JUMP_TYPE_LINKED	2UL
>> -#define JUMP_TYPE_MASK		3UL
>> +#define JUMP_TYPE_FORCEFUL      4UL
>
> JUMP_TYPE_NOINSTR_ALLOWED ?
>

That's better, I'll take it. Thanks!

> -- 
> Josh


