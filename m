Return-Path: <linux-kselftest+bounces-22371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0774A9D40E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06772835C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE5156F21;
	Wed, 20 Nov 2024 17:13:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F924B28;
	Wed, 20 Nov 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122808; cv=none; b=kim9MTD8L4XTKsagwPeTFRXLT6254tnQvBapFHAby5cNfmH5zOUaksS+c6o9FW7yMvtU2duBqoVBXRMr6r/IqGi2ZAuNmQNE5k/5sEiIvTya/BVacXvcGhp31XLg+nvbRzDc0Uf4GP0NfNx4lE8UjJR7cQdK9U6XTxv81/pr4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122808; c=relaxed/simple;
	bh=jz3HdoluyP/zpxZDP2VMKKAfsXgettCvfGsGqVKKJpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpMZSqjeZFuVU87Qxz4a5ZY7GhzH8++b7o0zsZBxmfc++moNGH3zg7P38sT0Hmb6AekR3VJfoh3REVHJH8cDcQQd2EO2SbZclrJ/2WaXLPMJREdVPMuwk8r2jToR0yXg7qcr+bHukADxrKKRNEfRaXRPlK1E25CLRe7ceQAgnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEAEC4CECD;
	Wed, 20 Nov 2024 17:13:25 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:13:24 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
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
Subject: Re: [RFC PATCH v3 09/15] objtool: Warn about non __ro_after_init
 static key usage in .noinstr
Message-ID: <20241120171324.a4yteg2mhkdeyymf@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-10-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-10-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:56PM +0100, Valentin Schneider wrote:
> Later commits will disallow runtime-mutable text in .noinstr sections in
> order to safely defer instruction patching IPIs.
> 
> All static keys used in .noinstr sections have now been checked as being
> either flagged as __ro_after_init, or as forceful static keys. Any
> occurrence of this new warning would be the result of a code change that
> will need looking at.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> offset_of(static_key.type) and JUMP_TYPE_FORCEFUL would need to be shoved
> into a somewhat standalone header file that could be included by objtool
> itself.

static_key and JUMP_TYPE_* can be moved to jump_label_types.h which can
be included by jump_label.h and also synced to tools/include/linux for
objtool to access.  I guess objtool would have to "#define
CONFIG_JUMP_LABEL" before including it to get the full definition.

> @@ -3605,6 +3608,41 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
>  	return 0;
>  }
>  
> +static bool static_key_is_forceful(struct symbol *key)
> +{
> +	if (!strcmp(key->sec->name, ".data")) {

There are some configs (and more coming in the future) which compile
with the kernel with -fdata-sections.  So this may need to be something
like
	if (strstarts(key->sec->name, ".data"))

-- 
Josh

