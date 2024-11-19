Return-Path: <linux-kselftest+bounces-22312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A99D2F9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3E728387B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006561D47A0;
	Tue, 19 Nov 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBH85DfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17F1D2F55;
	Tue, 19 Nov 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048704; cv=none; b=d6k4ysVExK5UsNmKpykzoXQNcV3XFQNoTV/VJFHyB5OdUZ8BQuPbYqSjUmQUqSsFZ2SuZ2vYsEb3ibJex/A9xMgVglr7GSYYwP8JhxaWYWX7KFcHhBCEUDQ3OWQiyRds/WPmgBm2vCqHpUu88fi6qzkDwLzIusMFA2q4sE5XhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048704; c=relaxed/simple;
	bh=rjVoJmCLBKMrTjoTUUEHxVM/UnztlbpL+xP7QMoxqk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbWNDKYKd38gcnKFmjy8hWpJA2V/YlZpaOJKJIqI7VA6690ctd9SxHr0m4XOLZ3m6+ZQwIQ9Wka5e19uug5mJk7Fzz+/uYOiQCIb6Ql7ZOHWqCKuy7zqLCeGf8QE96uZbsus3LM741bQNTLVl9/gnWEQaZHCR4ANsoCSpag6ZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBH85DfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550B2C4CECF;
	Tue, 19 Nov 2024 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048704;
	bh=rjVoJmCLBKMrTjoTUUEHxVM/UnztlbpL+xP7QMoxqk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBH85DfCt45DGJhgnvfqpnLBhuEmAbdXxVtRC4qCWKCE4/NOOJbE1ypM5DQdkwOmM
	 OiYCtISGvaIiyUrpNoYfW0v6OoTILYEzgRea68LrXJ9qtXMdRbrfHGMNwH6V8hYFKY
	 iGz2sVElFA9ax5AijVcILvMsNVmqyRYc9BOntRaV+NowA1bxnCD5qeToakwDt6CIMz
	 2DGPzxjWkE5Kft2S+fWW07TNO+BHEOy2GjnOZEXB+x9aXsX/xU9KTuEtVLNJ4irUGB
	 dbjVidBmUIpK0uOjUM/alv26mDhcIby6ExBaO5xrXY7QXaJvVTWoE3/tfzgW6TWDMH
	 mReOEyOZHsjWg==
Date: Tue, 19 Nov 2024 12:38:20 -0800
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
Subject: Re: [RFC PATCH v3 02/15] objtool: Flesh out warning related to
 pv_ops[] calls
Message-ID: <20241119203820.kz4p7isbolwjmpl6@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-3-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-3-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:49PM +0100, Valentin Schneider wrote:
> I had to look into objtool itself to understand what this warning was
> about; make it more explicit.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

