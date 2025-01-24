Return-Path: <linux-kselftest+bounces-25086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0A4A1B46B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A258716885E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCDA21A424;
	Fri, 24 Jan 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8qJYU/p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A023B0;
	Fri, 24 Jan 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716841; cv=none; b=tf2QL+nsJUpZTZKff2FfnYklr63CGcWAcnx0CRAkTBZiA3DmEchO5sqnFGkhqAHOB73IyhywwS1zcQiMNotrlWBArG/wXg42bS1L/a5UsW5OurA6pkSvEhe9YBXbQUozDqU3p3he5W9lvYexVL6UoZm8MaUZiaoNcLejQbjSwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716841; c=relaxed/simple;
	bh=wSfyHXcmcOSuIJyW+bb7SIJC8asuo8BMjmJ6ZKag59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arKImoZA+tiZ/YxS72fmvsUyp8o9j/NO51BLl1hTYuhqhUqau9leAHVf8c+gu+GaJxKu1MxxQf2e/lNohCdpoIFlK+YI73gMg7qNVDsmW0OchNb9S5PkDF/7vQPJWq1yrWaKwIrSQzvX/0lLEC7qoTbkzcDtxdLhxuX8cxW2Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8qJYU/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FDC4CED2;
	Fri, 24 Jan 2025 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737716840;
	bh=wSfyHXcmcOSuIJyW+bb7SIJC8asuo8BMjmJ6ZKag59U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8qJYU/pXyq687Cg0zGfUkpXlGffvuM6D0jtxkliKJACp5JlMojm1GDrNE8vwkQHh
	 QhQ6ovm02lHCCSi4Q+bICN5Ri53ztGf22K3e0skaJ4pRVYXnu3siPiddwrn71c1YpM
	 keFYn5AIrov0gSoot4RZ0oOIf/s0nFcQ/mMYx6r53nKF2FyEV8e+apGJAN5yv5UYhI
	 nIw+SIrFrRkO/Gzpy0loesaORzuJhjgA3nl3p1C1IHchkGMB2VNwUZ4rQfDyfRcmKr
	 FqCOto/w0cN/rIRN+Pw1dI1+KtqsXHjMG2qvVSJC18R98+nJwFyTMBLA5ebT7cyqm7
	 eo4aCP4xXm6ZA==
Date: Fri, 24 Jan 2025 13:06:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
Message-ID: <Z5N0UVLTJrrK8evM@kernel.org>
References: <20250121095739.986006-1-rppt@kernel.org>
 <20250121095739.986006-7-rppt@kernel.org>
 <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ca024-fc25-4fe0-94d5-65899b2cec6b@suse.com>

On Thu, Jan 23, 2025 at 03:16:28PM +0100, Petr Pavlu wrote:
> On 1/21/25 10:57, Mike Rapoport wrote:
> > In order to use execmem's API for temporal remapping of the memory
> > allocated from ROX cache as writable, there is a need to distinguish
> > between the state when the module is being formed and the state when it is
> > deconstructed and freed so that when module_memory_free() is called from
> > error paths during module loading it could restore ROX mappings.
> > 
> > Replace open coded checks for MODULE_STATE_UNFORMED with a helper
> > function module_is_formed() and add a new MODULE_STATE_GONE that will be
> > set when the module is deconstructed and freed.
> 
> I don't fully follow why this case requires a new module state. My
> understanding it that the function load_module() has the necessary
> context that after calling layout_and_allocate(), the updated ROX
> mappings need to be restored. I would then expect the function to be
> appropriately able to unwind this operation in case of an error. It
> could be done by having a helper that walks the mappings and calls
> execmem_restore_rox(), or if you want to keep it in module_memory_free()
> as done in the patch #7 then a flag could be passed down to
> module_deallocate() -> free_mod_mem() -> module_memory_free()?

Initially I wanted to track ROX <-> RW transitions in struct module_memory
so that module_memory_free() could do the right thing depending on memory
state. But that meant either ugly games with const'ness in strict_rwx.c,
an additional helper or a new global module state. The latter seemed the
most elegant to me.
If a new global module state is really that intrusive, I can drop it in
favor a helper that will be called from error handling paths. E.g.
something like the patch below (on top of this series and with this patch
reverted)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7164cd353a78..4a02503836d7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1268,13 +1268,20 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	return 0;
 }
 
+static void module_memory_restore_rox(struct module *mod)
+{
+	for_class_mod_mem_type(type, text) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (mem->is_rox)
+			execmem_restore_rox(mem->base, mem->size);
+	}
+}
+
 static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
 	struct module_memory *mem = &mod->mem[type];
 
-	if (mod->state == MODULE_STATE_UNFORMED && mem->is_rox)
-		execmem_restore_rox(mem->base, mem->size);
-
 	execmem_free(mem->base);
 }
 
@@ -2617,6 +2624,7 @@ static int move_module(struct module *mod, struct load_info *info)
 
 	return 0;
 out_err:
+	module_memory_restore_rox(mod);
 	for (t--; t >= 0; t--)
 		module_memory_free(mod, t);
 	if (codetag_section_found)
@@ -3372,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				       mod->mem[type].size);
 	}
 
+	module_memory_restore_rox(mod);
 	module_deallocate(mod, info);
  free_copy:
 	/*
 
> It is at least good that MODULE_STATE_GONE is only set in free_module()
> past the sysfs teardown, so it never shows in
> /sys/module/<mod>/initstate. Otherwise, this would require teaching kmod
> about this state as well.
> 
> -- 
> Thanks,
> Petr

-- 
Sincerely yours,
Mike.

