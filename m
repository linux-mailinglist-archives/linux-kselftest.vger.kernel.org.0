Return-Path: <linux-kselftest+bounces-37064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BDB01391
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEAC763FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 06:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74F1D6DDD;
	Fri, 11 Jul 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7KZVhBi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/C1yBrC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7661A92E;
	Fri, 11 Jul 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215350; cv=none; b=Qio8YcBTZl6npyS0l+R1zDqhc01Ip/bNhQ22zdvZ5wbyb0HbPMB4XmLTg5JjLjkDgErakpkYsXT7/7Q8YvcGLbKh1XI1U9/OViuf4URbXgbWfmICS54QPWfkCsoZOeX22GACs0FcMANOzuW2ntOEVxIGh9ygV4MUJYtiLnIMUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215350; c=relaxed/simple;
	bh=WYOIK6GVMqapmq065fCiDBgTvxy0j7JyBvG8D0bAQ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD+bHogYafJ/OupMkacLy+IV04Uts1WwA100LuZ/B/YMbIsXkgHrS2MIJMRy6w6qeN/Kua/mlDUzQoJW8qcazZAA6lcNTb07T8dSLdPBrJ7ifYOGfZIgFsPUlkDKpm2O14FcQe+DxQc8GP3RHWuSZMUSWK7Wk9ckNKtCghL3CyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7KZVhBi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/C1yBrC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 08:29:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752215346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LpGMm1o7zQgu78tbfllcqNpB+021zUZQxffxbGNBeE=;
	b=f7KZVhBiKW/ToUXjyooJTXextQQJ1lbQBw+ZGZ8NX+EAH5LWrFE9zm7xsP4sGNgotWZD9/
	kzw+eeJJtnCw+sqj9fHtS8307S6NbRSYjg8Gq35VdYZG0ofiKwEyJJAdgILjT3UFBn/pV0
	By1/SdnbGOtR5Ug3A31ZtwIGeBZzDKpEUMw5qzj3UeXOSaal1jPPgnPWs0gCubdLiac3pL
	yWC6LkDfxngXPd1VHKvqsjiiybxdw+/6d+uffb1QvGJKW9Yv67ffN2W/tlWVefUsc98e2Y
	koZu3cqQ4dQ7KMAeekcIcJiQXJZHQnNGDJrOm/59qwu/oTZnRY/0VJLFa7xPLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752215346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LpGMm1o7zQgu78tbfllcqNpB+021zUZQxffxbGNBeE=;
	b=P/C1yBrCppCXTk7jTRetWspPADUr2fAtZz2Bj24U1MK3CIWcRSiDC/TdXzNMrQktssn6/b
	Hi2u9PJZBAoQyBDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
Message-ID: <20250711081047-ea2c1e83-1b87-4331-acad-cbbfe6be67d8@linutronix.de>
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
 <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>

On Mon, Jul 07, 2025 at 09:11:05PM +0200, Daniel Gomez wrote:
> On 12/06/2025 16.53, Thomas Wei√schuh wrote:
> > To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
> > it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
> > The code will still fully typechecked but the unreachable parts are
> > discarded by the compiler. This prevents accidental breakage when a certain
> > kconfig combination was not specifically tested by the developer.
> > This pattern is already supported to some extend by module.h defining
> > empty stub functions if CONFIG_MODULES=n.
> > However some users of module.h work on the structured defined by module.h.
> > 
> > Therefore these structure definitions need to be visible, too.
> 
> We are missing here which structures are needed. + we are making more things
> visible than what we actually need.
> 
> > 
> > Many structure members are still gated by specific configuration settings.
> > The assumption for those is that the code using them will be gated behind
> > the same configuration setting anyways.
> 
> I think code and kconfig need to reflect the actual dependencies. For example,
> if CONFIG_LIVEPATCH depends on CONFIG_MODULES, we need to specify that in
> Kconfig with depends on, as well as keep the code gated by these 2 configs with
> ifdef/IS_ENABLED.

If CONFIG_LIVEPATCH depends on CONFIG_MODULES in kconfig then
IS_ENABLED(CONFIG_LIVEPATCH) will depend on CONFIG_MODULES automatically.
There is no need for another explicit IS_ENABLED(CONFIG_MODULES).

> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  include/linux/module.h | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
> >  
> >  struct notifier_block;
> >  
> > -#ifdef CONFIG_MODULES
> > -
> > -extern int modules_disabled; /* for sysctl */
> > -/* Get/put a kernel symbol (calls must be symmetric) */
> > -void *__symbol_get(const char *symbol);
> > -void *__symbol_get_gpl(const char *symbol);
> > -#define symbol_get(x)	({ \
> > -	static const char __notrim[] \
> > -		__used __section(".no_trim_symbol") = __stringify(x); \
> > -	(typeof(&x))(__symbol_get(__stringify(x))); })
> > -
> >  enum module_state {
> >  	MODULE_STATE_LIVE,	/* Normal state. */
> >  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> > @@ -598,6 +587,18 @@ struct module {
> >  	struct _ddebug_info dyndbg_info;
> >  #endif
> >  } ____cacheline_aligned __randomize_layout;
> > +
> > +#ifdef CONFIG_MODULES
> > +
> > +extern int modules_disabled; /* for sysctl */
> > +/* Get/put a kernel symbol (calls must be symmetric) */
> > +void *__symbol_get(const char *symbol);
> > +void *__symbol_get_gpl(const char *symbol);
> > +#define symbol_get(x)	({ \
> > +	static const char __notrim[] \
> > +		__used __section(".no_trim_symbol") = __stringify(x); \
> > +	(typeof(&x))(__symbol_get(__stringify(x))); })
> > +
> 
> The patch exposes data structures that are not needed. + breaks the
> config dependencies.

If we want to expose 'struct module' to !CONFIG_MODULES code, all it's
effective member types also need to be included.
With my patch these member types are actually still implictly gated behind
CONFIG_MODULES as they depend on it through kconfig.

> 
> For example, before this patch:
> 
> #ifdef CONFIG_MODULES
> 
> {...}
> 
> struct mod_tree_node {
> 
> {...}
> 
> struct module_memory {
> 	void *base;
> 	bool is_rox;
> 	unsigned int size;
> 
> #ifdef CONFIG_MODULES_TREE_LOOKUP
> 	struct mod_tree_node mtn;
> #endif
> };
> 
> {...}
> #endif /* CONFIG_MODULES */
> 
> After the patch, mod_tree_node is not needed externally.

Can you explain what you mean with "not needed externally"?
'struct mod_tree_node' is only ever used by core module code.
It is only public because it is embedded in the public 'struct module'

> And the mtn field
> in module_memory is exposed only under MODULES_TREE_LOOKUP and not MODULES
> + MODULES_TREE_LOOKUP.

As mentioned above, MODULES_TREE_LOOKUP && !MODULES can never happen.

> I general, I see the issues I mentioned with LIVEPATCH, mod_tree_node, macros,
> and LOOKUP.
> 
> >  #define MODULE_ARCH_INIT {}
> >  #endif
> > 

