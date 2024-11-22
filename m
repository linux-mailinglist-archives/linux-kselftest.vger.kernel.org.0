Return-Path: <linux-kselftest+bounces-22445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13479D5D21
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 11:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5EC1F21B09
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD61DE4C1;
	Fri, 22 Nov 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRlUIQmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2B1C9ED5
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270668; cv=none; b=ojWlLiQN3PQ3kFYWilxnXLs3Hkffrzd+8kIKe/0nyMEhQ/KPH6KxHeMbuaxbovNtjNr1NWOn5h/SUdrULQo1CCdG5c+ntbh7fRcbkyavaRVooIDYbOhF7ZQtIEPqiM8i7mXhFsaFQGWvDvoxl9BR7BIPhAjWh81ODcz0ikIliRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270668; c=relaxed/simple;
	bh=XUuo/u7cK5K5gY/dFgAwCjVRAIBZqBeX+BIxJiAEQkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p08nN17gSLM28aSF4fLc9sB+yxHJ6jb/lDbtClN6rk9KOn5wkRqtIs5REWdygfWDHVhwnc4GfTqCD8txC/6Al6ibIDIKu2Cmu/E7qeRpL6RqQ+zHD4sIxkiJ+y9kLt96Kdvs+b1Q0PedInvXn7DH4XY5bVmjOnPjxPKy/PYIYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRlUIQmd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732270666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69DVKh9DUZx0Pn4NM7TlxBgCo8xRovdMM0JkhaNwI8A=;
	b=WRlUIQmd8OKQQu98F5VZyKjCuL57HYnguwPJlVbhOQldps2mH+8AnQYTtZ2NtaMqyS969L
	HlcAxl4sxdOTyCVtQMjFM7Fa3I4jvsSQdl1W9jPVUr44Z1IE6YVTezKvSljQsJw2a5Yf1b
	ktWrwbdbnNwDSoL5L9gvCukQBzYzBqQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-xJAJeWFXMq21rOZXnL_4QA-1; Fri, 22 Nov 2024 05:17:43 -0500
X-MC-Unique: xJAJeWFXMq21rOZXnL_4QA-1
X-Mimecast-MFC-AGG-ID: xJAJeWFXMq21rOZXnL_4QA
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6eeb9152b2cso36457407b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 02:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270663; x=1732875463;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69DVKh9DUZx0Pn4NM7TlxBgCo8xRovdMM0JkhaNwI8A=;
        b=Srmp5i3Gokc7Kx1AQWZSq5Vm5oRujuTR/ZnhppGCkL3WXJb4U0AudNAag7sUiEeM8Y
         bJ4Bc2ejokK+n3ry6ivkD5RQizUuNvcEtHxWVYpntSnRotJYwjvzUHMKzxOCwViBv1Bx
         C4YdDrdZsfNujvWHotj8IypaU4LJ6Z4H9WmlQv+3Od17jkGGFBc730NLNoENv8XfHbUp
         YSiaA4aQpo5tvD2nM4/4Tqejwa5yGjkoz4mPgVrftD1M6/2ODYUsuuxAaUZo15dNX8YB
         KkHWrHVANWDoPNziYlB3lHUdAqmsVn8KehIxeZnbiIRsKLvKD3p6daSohGBs05OvLv/Y
         XKdA==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ0roUoB5c/wBt6FPHKtZStnksZmKEP/9xNHzTpJkJs+IKWxmK05l7EwrboBWHIJNXmi4o6+c0FWzLxXnLBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWT2aTevhkQWrsIuA2KaT4eEqVROPs8drn5DQIfCB8164VJW4
	t6oEWaQzD5h1qMhvnXdNklHa6l4PlVIbWwa54ScZ+/+vyxdBRAYU1zOyiRWcTMqpc6WvU+Y9O/D
	ijWNs9PsFAKMc5qiH8JlfKpBwRp0UmWwVtx3R+SkiO4LCihJsV+q5lqaNZ46vio2OaA==
X-Gm-Gg: ASbGncs4L01aBcHhF6NFwvLg8bjQ9knO1r4zhPsUQMDAjI9dzwKUdLFI0iynIOzvAPl
	blAO61U9cTIpccZhK52VaMRyv6LnL5d0m7232U5ydzF1Z7cei4XeuBHQEX4kxv/p1NtJzQQ6mpe
	ENQOCdz1g8OVrQAjJpgwvkH3E6o+tbWzBz1MGn3E7A/hLt1xl/gbbdL1y941ektbKxl2ZJ0LJxd
	RdC6AXsODX0GezskKUx6vvwWR/DXk+ay9EJGq2yxy6ps8AgbkDIS7XkV9lR+LSblArPpjaVd4Pm
	4poOLb3gUbAoUfQ2WdMUp1BrlRKNhrXc6UU=
X-Received: by 2002:a05:690c:4b8f:b0:6e2:a129:1623 with SMTP id 00721157ae682-6eee0a4e7cbmr23805697b3.38.1732270663049;
        Fri, 22 Nov 2024 02:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzjL7GOb26N8xVdZoDD0aeetdAAWaPf+1MRvyDFWpPzlOuVttoePPk8DAQ//wEdbZj+zzG2Q==
X-Received: by 2002:a05:690c:4b8f:b0:6e2:a129:1623 with SMTP id 00721157ae682-6eee0a4e7cbmr23805387b3.38.1732270662779;
        Fri, 22 Nov 2024 02:17:42 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f91e8esm72637485a.2.2024.11.22.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:17:41 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Dan Carpenter <error27@gmail.com>,
 Chuang Wang <nashuiliang@gmail.com>, Yang Jihong <yangjihong1@huawei.com>,
 Petr Mladek <pmladek@suse.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Song Liu <song@kernel.org>, Julian Pidancet <julian.pidancet@oracle.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze
 <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri
 Lelli <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Daniel Wagner <dwagner@suse.de>, Petr
 Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
In-Reply-To: <20241121202106.nqybif4yru57wgu3@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
 <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20241121202106.nqybif4yru57wgu3@jpoimboe>
Date: Fri, 22 Nov 2024 11:17:33 +0100
Message-ID: <xhsmha5dra7ya.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/11/24 12:21, Josh Poimboeuf wrote:
> On Thu, Nov 21, 2024 at 04:51:09PM +0100, Valentin Schneider wrote:
>> Okay so forcing the IPI for .noinstr patching lets us get rid of all the
>> force_ipi faff; however I would still want the special marking to tell
>> objtool "yep we're okay with this one", and still get warnings when a new
>> .noinstr key gets added so we double think about it.
>
> Yeah.  Though, instead of DECLARE_STATIC_KEY_FALSE_NOINSTR adding a new
> jump label type, it could just add an objtool annotation pointing to the
> key.  If that's the way we're going I could whip up a patch if that
> would help.
>

Well I'm down for the approach and I'd appreciate help for the objtool side
:-)

> --
> Josh


