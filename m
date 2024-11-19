Return-Path: <linux-kselftest+bounces-22316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F819D30FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 00:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E50B218BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2B1D2F64;
	Tue, 19 Nov 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVwSwoDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446FD1BD9F3;
	Tue, 19 Nov 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059546; cv=none; b=MFr0GCZX8vp5744bM1mFd3BweJesG8WboEqgBnKqWScwkmOM7vZGWjlRMudL+CQ7ytnq5zq/EqmdQJAKCoC1XPp64AHegUdIWcgN0rmyoxVVhovX/A3ju9MNIbwM7ottApPbSoFGNeHGF1upX1iLNe99qdYVgsNis0M2J6Q5mLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059546; c=relaxed/simple;
	bh=MJi3Fv2/1QvfWr/LiwMdd8vo0kHoZwkP7YNG7EQREfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoig5TnPxVlZh6uu3DCTcpWYZESUUUy2LC+rtDstKR3/KsE9uoL4koFpJKip7wDYo4md4bSKuQwydwYC979hAybvUSMKrHYevHtXYf5FETuTW6gUY3rKKkGXrYtCVB5AIVatJsmSBkJkjfKgP4WqlqckyD49hGZnnFzjPcPnhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVwSwoDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9B3C4CECF;
	Tue, 19 Nov 2024 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059545;
	bh=MJi3Fv2/1QvfWr/LiwMdd8vo0kHoZwkP7YNG7EQREfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVwSwoDNu1TqMFW15ochzl8vEFTrIMSh2sexLA6XSHJ6qClpYzQmx/p8q0+V/ICdK
	 QcTGJLa+7qQQT24Pg/o/ujB9zzGyzPLCSBycIpzaqRQmmnJgp8Bmm/Asv7c/PmvwiR
	 hos+7CVCbsa55k1mc7GHNj+kA8fGiX99G6or+53fRDs2TtOHAVH3KebnDSKX5Yyt/J
	 L+g+8gDhlLq8+G9Zy9kb7DEd1lIcrJQYolbFdsAW5Kbk4+ktaecXpi0xWOSpdFxTtO
	 qI8NUGX2AHe6987zz7E0iSHgJlM8A9RAr5kj/WxICexja0uizSdnkHYiGVUCbPB9TB
	 izDxUiUHmBDCA==
Date: Tue, 19 Nov 2024 15:39:02 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241119233902.kierxzg2aywpevqx@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-7-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
> Later commits will cause objtool to warn about non __ro_after_init static
> keys being used in .noinstr sections in order to safely defer instruction
> patching IPIs targeted at NOHZ_FULL CPUs.

Don't we need similar checking for static calls?

> Two such keys currently exist: mds_idle_clear and __sched_clock_stable,
> which can both be modified at runtime.

Not sure if feasible, but it sure would be a lot simpler to just make
"no noinstr patching" a hard rule and then convert the above keys (or at
least their noinstr-specific usage) to regular branches.

Then "no noinstr patching" could be unilaterally enforced in
text_poke_bp().

> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index f5a2727ca4a9a..93e729545b941 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -200,7 +200,8 @@ struct module;
>  #define JUMP_TYPE_FALSE		0UL
>  #define JUMP_TYPE_TRUE		1UL
>  #define JUMP_TYPE_LINKED	2UL
> -#define JUMP_TYPE_MASK		3UL
> +#define JUMP_TYPE_FORCEFUL      4UL

JUMP_TYPE_NOINSTR_ALLOWED ?

-- 
Josh

