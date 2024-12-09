Return-Path: <linux-kselftest+bounces-23047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1529E992C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D86918886C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F411B4234;
	Mon,  9 Dec 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="REDpF6dF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5C1B041F
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755381; cv=none; b=NN6VlWpLNbfAJCdo7kpPKGrhDWkhaNc5vvWM2pAvQuh7If0xEfrWeqxYqk1Hzbr1MwUdRWAssb5pQZSIl+oZG7ihsG9ECmvviEXrskj+e2q5cOnRvtEXRFC5tvhyqz6k86CvlXAEGOAbXp2eXnJ8w+E61Xwr0wIuZLXPVEbYLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755381; c=relaxed/simple;
	bh=Iiqbjto+vb0aXpNcZOFiu3NWNHXQsyJ41jNpYdodkL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKqpyZZNbHlhC603ieU+OKDwfrTWq6sdYI29PCWi0vAq/C3psBxI4N86qVR+kvAhns4kA+18A1DCRnhJtI5bmmmRYqbxAuAv/GMl+V9AyZuMW/GIV4G45LKhfSAHVGrWb1hxwSXgkpWby1/fMLFG5+h2cywo4ilOToOWNeL/4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=REDpF6dF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862de51d38so327687f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733755377; x=1734360177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkwsX/4Xva/aw3/I8I2kwIJd9M/PGmCc4Ypj6qQ29AM=;
        b=REDpF6dFhXNy3Vc5phYvhf0EusEPJbM1EBVwSgBXlV6eBVci5wLzMrfgwFHdHkquZa
         22+/z3lfJQhNPvCH2+JpzR7RaczfQzOq2L8iDNFDDziwMSoeL37Z/1ma2jPXs95p4quy
         jJtkjP3/Ck0bVWvFEOOZN19ZLM27x/gxXkV1Q+9nyjbepnX2BYeo+accdUWPnU1RxIN+
         /ePs1EnonFTVgWTOa0FSxdi3Sc44yNHFtPaZwFNqjDpuYmMiDdtKKnnWtPcBowJ7AAHq
         HEyHPt3AM2jKmI4M3C1k/8RSJjGUHUVOEggFuoCsjBgdBtp6BnBV3S8MAa7BuyH1CDsx
         zLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755377; x=1734360177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkwsX/4Xva/aw3/I8I2kwIJd9M/PGmCc4Ypj6qQ29AM=;
        b=qkGt9qInI7ueHbLqpEZkE8lTNLRYs0V3uxloDTCLGv4McOwEJmHdG/aG6HSDBVMMVo
         z8msf3cKBPnmNYypzGyIZ6j7WQPIDjzzy37vHz8DSxIxIvju4Ia4zBsTzFzAEsHa12S7
         cZIrQ7aVFkY6vVr7VwZabJzlQCDZRVfEd10NKQCZWojMajTYlynb+BQzcjJ7bFOaMJs1
         OejKixVPmUI5flBVagBNhR03m/QApc51kJSIJAMxetcfQDR3AlM5wd60blCflv5DJCOi
         w64IL+vEu2ip7Fh7qAT06yvuHqxOrcBEqDT0QLEPwyLnWdDXllS3trwio0b9oRZG+wKF
         RQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRMGPFR8/kf8eIrZJo4ogqAnfRC6jXAKX2s409WDugm6clKRuqG4IYtA3UxGlhSlxL8NEWa3boPlMbV+rUUKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyOOfhEUC4QRE7lgsuWq+GGoPuoPTyrqu28I1m73Qo+kCFXGD
	muyKK6hlRS26T3WnfJtCYs/QY8qjRT7dfMoaXDe6jCAZpkzi5qK+Vh8Q+rFelvU=
X-Gm-Gg: ASbGncsDysWUM+qTpYK2O7rg/XRv6urpY8PiXstoqhONGVgiSL22FO95DpsdIjLIHqW
	QfAABlDjDURRTNaLey0rS9DaTIsCExMJJHFIvqtpDScb1TX6BhWp7mjGhStgJnj3DgAjoOotdFp
	GQXAkBZv9eXtbhX3vMwiruuEXnm/q81OXG9pVOpMGFvZckpZ25r98gcjT4zyS8rgLwqmPw1UZae
	eBjyGumJvav9jWJPjmI4p8/MihalQfsCH/uHN9fYly6c60z2bu/OGtGRLfLEWUIaIarGaLbkmTU
	xr3JddRPPzFrgrCr68CkvdGJxo4dZ07bQY5wrWismGfmVJsf6X8cXZk=
X-Google-Smtp-Source: AGHT+IFS9ZOU0lVFyWUQ84y6baV41ONm7JGT6TkRTJEtzq0JeBL9l/n9rsr90siOB4OTv3dodfZukg==
X-Received: by 2002:a05:6000:1846:b0:385:fd31:ca24 with SMTP id ffacd0b85a97d-3862b3cea6dmr3365934f8f.12.1733755377482;
        Mon, 09 Dec 2024 06:42:57 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636e05568sm7300809f8f.39.2024.12.09.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:42:57 -0800 (PST)
Date: Mon, 9 Dec 2024 15:42:52 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>, Dave Hansen
 <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
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
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
Message-ID: <20241209154252.4f8fa5a8@mordecai.tesarici.cz>
In-Reply-To: <20241209121249.GN35539@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
	<20241119153502.41361-14-vschneid@redhat.com>
	<20241120152216.GM19989@noisy.programming.kicks-ass.net>
	<20241120153221.GM38972@noisy.programming.kicks-ass.net>
	<xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241121111221.GE24774@noisy.programming.kicks-ass.net>
	<4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
	<20241121153016.GL39245@noisy.programming.kicks-ass.net>
	<20241205183111.12dc16b3@mordecai.tesarici.cz>
	<xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241209121249.GN35539@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 13:12:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 09, 2024 at 01:04:43PM +0100, Valentin Schneider wrote:
> 
> > > But I wonder what exactly was the original scenario encountered by
> > > Valentin. I mean, if TLB entry invalidations were necessary to sync
> > > changes to kernel text after flipping a static branch, then it might be
> > > less overhead to make a list of affected pages and call INVLPG on them.  
> 
> No; TLB is not involved with text patching (on x86).
> 
> > > Valentin, do you happen to know?  
> > 
> > So from my experimentation (hackbench + kernel compilation on housekeeping
> > CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
> > occurred from vunmap() - mainly from all the hackbench threads coming and
> > going.  
> 
> Right, we have virtually mapped stacks.

Wait... Are you talking about the kernel stac? But that's only 4 pages
(or 8 pages with KASAN), so that should be easily handled with INVLPG.
No CR4 dances are needed for that.

What am I missing?

Petr T

