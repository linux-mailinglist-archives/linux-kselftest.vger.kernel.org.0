Return-Path: <linux-kselftest+bounces-22317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CC9D3148
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 01:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A122BB23C2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A9136A;
	Wed, 20 Nov 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eksPcppY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15F193;
	Wed, 20 Nov 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061136; cv=none; b=F7kX5P7NQAnkk/Nb8fs5/PVJzf1aHedSQE+gJRlNUf0HDXnbsaGXuk3HO01GcvQXWgZt6GAnkDle6ZDxh0rguadKNSs8Qryt+Ikp9cNmLbO/Ud8gTPp8pW3mGGHH7eMSc2yfMqUDWRK2BVcS9ZX6XwOwJD1iMFbX/i3C4jf0vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061136; c=relaxed/simple;
	bh=NMnFX7XK6VdRPzGtpSRTKyvI+/r1fqrGrX48X5BBDWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3mjApGchXntPaTsiTun9YAMNpumBS37zjZbuy1gasVvNZcszphDac8Vce2dDoI5/6AoTrXWSwrcjfFt6XmC9QZtj2rXO7rrf6J6NBGMYd9S33A90Ma9C8QFMRaGGzP0wz0InFDoZzMm2+Whwp9ofP1fMertercYWT8znrmLmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eksPcppY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F7C4CECF;
	Wed, 20 Nov 2024 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732061136;
	bh=NMnFX7XK6VdRPzGtpSRTKyvI+/r1fqrGrX48X5BBDWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eksPcppYzPeSt6INt9TwqRvZ4lhbHTxdkTT3HfOrf73uMrdgSEcCiaBLbjbuEr7KW
	 KTtf0X/Xm113UupXPcdgtWqsbZTElfC3SS6AjmXWs7Njc7ceshzOwUlnMhh2jsa5hH
	 5OHCR/v0n3tWuWAQrg1DkVk8tW7PRGoTeRmRwkCdgz5FoLEnCrEjA+x4MkVxOrYs9g
	 tX6BNjcLJDxuXETMH5s7gDSEqB5HHNJFSx81pxD01l1XlEm7xGdkg4yKrWRdZOitj5
	 tSMfXDjRII5KS06JqDQP80Djvc0pHpcI447DDFOp/8729SCiqKnXDMrLwR5jZhA/7C
	 VKL7upp0zVLyg==
Date: Tue, 19 Nov 2024 16:05:32 -0800
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
Message-ID: <20241120000532.maqzgsn7m34lti6u@jpoimboe>
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
> +++ b/include/linux/jump_label.h
> @@ -200,7 +200,8 @@ struct module;
>  #define JUMP_TYPE_FALSE		0UL
>  #define JUMP_TYPE_TRUE		1UL
>  #define JUMP_TYPE_LINKED	2UL
> -#define JUMP_TYPE_MASK		3UL
> +#define JUMP_TYPE_FORCEFUL      4UL
> +#define JUMP_TYPE_MASK		7UL

Hm, I don't think we can (ab)use this pointer bit on 32-bit arches, as
the address could be 4 byte aligned?

-- 
Josh

