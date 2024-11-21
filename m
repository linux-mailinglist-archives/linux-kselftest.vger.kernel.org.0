Return-Path: <linux-kselftest+bounces-22412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421449D501D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B39C283899
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E317C210;
	Thu, 21 Nov 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4SSYZ8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9B16DEAA
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204283; cv=none; b=Qnu5p3c9wJeyybxp2A+fEVOpQT6vPbPqgixd/3rCbHPK1oZxpm7oYni7MQDzUTa3QzYr23aANH832L/iVKR03x5YMzHk84zcYLyAEzxzrVp074RKTshJcYt7mv8t+lY1eU/zz/PEtd9/dHwv0njNa3AXDosxJST0vTMhHZbMteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204283; c=relaxed/simple;
	bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eb1S402yUo3KVDaNvQL09JnB/PC9885R3+k27flfxzaUgyiV8HXXErXWBhrghITS/HqlC5NSuvVDfjMT1DhlZ5/jCaJm3a95HmOGRViZYSJIIbwnjSSismdg+/xtDLiuwNnl3HVbNS5wDlbs2b7R7aYqzO0Fc5Lh/7vgepxjLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4SSYZ8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732204281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
	b=g4SSYZ8RPW3XHuknO3Zn3A5mDDKlGH9JTZLz+0TD9XLedn0oySxuE7qrqJxr7Zl0HBzwqJ
	G9bLz57WgCKOiaiqn38MNqK8DFlRhUnPLbwc0zRlkKlQCr8NEWVAhFwwKTLKSzyrjuXsJB
	iZ3joCCbETAl44D3ARVsbnFia/IYZFU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-W1oKt18IMxO4DQjiWvdsqQ-1; Thu, 21 Nov 2024 10:51:19 -0500
X-MC-Unique: W1oKt18IMxO4DQjiWvdsqQ-1
X-Mimecast-MFC-AGG-ID: W1oKt18IMxO4DQjiWvdsqQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460ec6fd8a3so17866681cf.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 07:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204279; x=1732809079;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
        b=YSf4IqkzxLnH9MWmt+t2vfUlaSqS1kP/wx73GfsIbwAJK9OwO+SygFZ5ZRQMl3XeWU
         Xc8/SaLi67YgdV4W8fS9pEhiJuMWLItYAnacKwM67Odb57rYkMn2F4QOrUwz5WZSChIs
         RDAeuVOEuBrewjPudrFuofLa8JACoY1fgH8pja86649FpFR5ftTA30MzH3ybI2V3Esgz
         e0ePp8xWugT5PjTorl61wikLI6SftTuXi+FYPIDqloCg3M+QrUDy/hB64th8x6NP7RLG
         Cn6jd2NUz0z/rsHezdRjnXsVeRcXtiLo0FRC8BCVQOqV/aNJBANCZWJCDD4nkopY7GHa
         xLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCT562VHCEcsbN/6e1kvWxCWvc4R0lIgtF0IFYa/30MtykS0Eec3nlytP/FfvmbRaY4RmCpT/SLKxLMbwuuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7SB61XT7c7FLUPH3nzGbSOtJuP6S6wIiSv3d1cuTTanpWs4j
	OW1Wiy7+BkYTL60J9dckF6nh1Bv93UtN3q320tZKC84UE4IIAqlWNyUw0aoogvN9FNXboLAJXMP
	wA02HdySULdvzGGqYKg2g0Au8pphgD28lRzHApI4WjPbM+hOkdXFiaR3zDkkzTWoz0w==
X-Gm-Gg: ASbGnctxLyrh2XG9Q3cWBTyg6UF4SpnIxO2mHRC57Q3mqyuCtn4H8G9igCIlAvze//7
	9pFFqp72EVoD155fOUWCRYQTMHVtJbg0N7+vIW/8rXagkdWkJpbE3nyeNp9ssKsJVuDk1ZlmcPh
	6B4EYnUqsaoOKsIzmPpaCOT7jGtlZfFFAePeQ3Q7k1DWEU5kanKlMewnLDoE4UDubhjJYf3cMj2
	Jn8Jqzas/uCpzkmmym4HaMLIHSX0ULR/GYp5SLeyz3pbxL3vm/45GStFUwJuckyJH8wg+W4RA0C
	1POFM2DPdYn5O5uvZMMgwfYxWQGTuf9PfeM=
X-Received: by 2002:ac8:7c4b:0:b0:461:4372:f2b6 with SMTP id d75a77b69052e-4647965fae7mr111015051cf.39.1732204279368;
        Thu, 21 Nov 2024 07:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhhGvXxNF9YG7Wn8RkZZVe3HUI8vO3AoWFe5rp5bueN6AbTjXI6+VbxkAuh2ulevplAsAH7Q==
X-Received: by 2002:ac8:7c4b:0:b0:461:4372:f2b6 with SMTP id d75a77b69052e-4647965fae7mr111014101cf.39.1732204278637;
        Thu, 21 Nov 2024 07:51:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21371sm23699431cf.76.2024.11.21.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:51:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
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
In-Reply-To: <20241121110020.GC24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
Date: Thu, 21 Nov 2024 16:51:09 +0100
Message-ID: <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/11/24 12:00, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 08:55:15AM -0800, Josh Poimboeuf wrote:
>> On Wed, Nov 20, 2024 at 03:57:46PM +0100, Peter Zijlstra wrote:
>> > On Wed, Nov 20, 2024 at 03:56:49PM +0100, Peter Zijlstra wrote:
>> >
>> > > But I think we can make the fall-back safer, we can simply force the IPI
>> > > when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
>> > > but at least we don't violate any correctness constraints.
>> >
>> > I should have read more; that's what is being proposed.
>>
>> Hm, now I'm wondering what you read, as I only see the text poke IPIs
>> being forced when the caller sets force_ipi, rather than the text poke
>> code itself detecting a write to .noinstr.
>
> Right, so I had much confusion and my initial thought was that it would
> do something dangerous. Then upon reading more I see it forces the IPI
> for these special keys -- with that force_ipi thing.
>
> Now, there's only two keys marked special, and both have a noinstr
> presence -- the entire reason they get marked.
>
> So effectively we force the IPI when patching noinstr, no?
>
> But yeah, this is not quite the same as not marking anything and simply
> forcing the IPI when the target address is noinstr.
>
> And having written all that; perhaps that is the better solution, it
> sticks the logic in text_poke and ensure it automagically work for all
> its users, obviating the need for special marking.
>

Okay so forcing the IPI for .noinstr patching lets us get rid of all the
force_ipi faff; however I would still want the special marking to tell
objtool "yep we're okay with this one", and still get warnings when a new
.noinstr key gets added so we double think about it.


