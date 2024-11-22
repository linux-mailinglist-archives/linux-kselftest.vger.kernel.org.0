Return-Path: <linux-kselftest+bounces-22449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3ED9D5F4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816F7281F56
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6D1DE3D6;
	Fri, 22 Nov 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMH2AqAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C41DDC39;
	Fri, 22 Nov 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280068; cv=none; b=MviE7MySKpDjMOo93E8gMLKRPjU70CksaJJlLYVZ4kloAorL7qXY0mON8swSaxPcdY1ZflbuL6mevzF/n4qjl5W7J20McHso08khL44Q5E/GUbz+C3Jnp1DSFFwXIO6qZ0fbU2zg4NBQ/W1fFMGvb5Km9CWa1E9b8BB+FaS/YXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280068; c=relaxed/simple;
	bh=q7YcyQKfUS/Yc6KiRK60PzTLFeFZNEjUOkUf4N39yR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTqVRkdPFY3B3VJ2RDAHzqER3T/rXJow/c/XhB32c8qJy0TEQy6VXRKxVVAMQxmi42zIpIQLOuCkDUSdgmYm4p5UXyq/i1z+CpjePI0w1gTHmhODuQMruylz70l4slQF5SwNUjh+OV5N+2skPJy7l5m+eENdkddkQ/OPOW0O0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMH2AqAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98308C4CED0;
	Fri, 22 Nov 2024 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732280067;
	bh=q7YcyQKfUS/Yc6KiRK60PzTLFeFZNEjUOkUf4N39yR8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GMH2AqAqtaCoStHWLn2AmWeJR9i83TZk2c5buPIOFVOM92A7d/KmHkkI0zxQ4LfHV
	 ujyBRqfnYjmmaIlzn5qxg5PbJEpIK9/JMgh+eZd0t45ixnhxv/o1L9mIzqc3kJ8Q4d
	 RYjns7moO+Ebkv4fy2HZdFKhgvip20ngbbZaOvKTvlDBydaBTLb7Ly+HUNcM8dTOS/
	 tdrinJzP6YySttxEc5NHsjDFgbnBjHE7rr3uQBcZ1BAsBSQ1XL/WwsbEaIbVtvVWkn
	 FlxfSfKsrKqBDIStIjoWaOE1Aj7/ikktyvyRxokClmSkZchRGlgTPn+L1YQv8l3aBW
	 2HaIDZ4vocDUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 530B7CE0BC4; Fri, 22 Nov 2024 04:54:27 -0800 (PST)
Date: Fri, 22 Nov 2024 04:54:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 05/15] rcutorture: Make TREE04 use
 CONFIG_RCU_DYNTICKS_TORTURE
Message-ID: <f9a3dc13-73cc-439f-84f7-ca0b86226e41@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-6-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-6-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:52PM +0100, Valentin Schneider wrote:
> We now have an RCU_EXPERT config for testing small-sized RCU dynticks
> counter:  CONFIG_RCU_DYNTICKS_TORTURE.
> 
> Modify scenario TREE04 to exercise to use this config in order to test a
> ridiculously small counter (2 bits).
> 
> Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  tools/testing/selftests/rcutorture/configs/rcu/TREE04 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> index dc4985064b3ad..67caf4276bb01 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> @@ -16,3 +16,4 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
>  CONFIG_RCU_EXPERT=y
>  CONFIG_RCU_EQS_DEBUG=y
>  CONFIG_RCU_LAZY=y
> +CONFIG_RCU_DYNTICKS_TORTURE=y
> -- 
> 2.43.0
> 

