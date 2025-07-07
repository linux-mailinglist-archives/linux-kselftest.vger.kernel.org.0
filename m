Return-Path: <linux-kselftest+bounces-36726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D3AFBB93
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA87188AB60
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28D233133;
	Mon,  7 Jul 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHHW0nmM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08E19755B;
	Mon,  7 Jul 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915473; cv=none; b=JkHt2Ov3T5RBgB2eGXX0Twx8GHTi5ttIWQwy2xhATF9hALRMTOPowW9ifOvjEBZzVWfCsVRxy93KITc4RJQbuk/vNGm1iyXU9x1zPlWRSvq8XZhCJlQ2WeCIKG5MfBTG6LIKoqPZwj1ICTRp40xktF3wqSU4ASxSmULBPEDOJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915473; c=relaxed/simple;
	bh=jyeQQgJy/kgZ+VcJ2KuOWLRT94HaQ85k1BKEOhxnP8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/9AYu2wmCy8T1ZI6NX4IDvhHfRC7OCFRU1d9g0v4AqZOA0SAPDZ39Blu7iNWI0RRYKC+poBQrWB5fiDEE02q1qWv31HpE9sTvKIt/8IIk45Qw4/gQdeSPt+e1udWHZ7Qw5lhGiEawz5hH24EqyWQzUn1jOVPYuvsudjqXkKq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHHW0nmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4FC4CEE3;
	Mon,  7 Jul 2025 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751915473;
	bh=jyeQQgJy/kgZ+VcJ2KuOWLRT94HaQ85k1BKEOhxnP8I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHHW0nmMsBwv8rMX00PuOEcDw/lS8dryl6B3FKbBejkZocyYBzl+ji4mMx7loAAzR
	 ziMU8QyiZPlxlEUTwi7HfPIJ9CwgfE7CWj0C5+tHL50z+Wdjsvd8BitF8pDD6b2UuA
	 TaLn4NsTSzc6ztgsMFCH2y/OiZf6FKWruiCs8kMzqdh+NZCEzeyR0Twk6oUey7tHiC
	 Z5x4c095DaXtudKYGi/zFUbAwRkpVa4zdHW9JRHlcW5q/4loDYaPG1CCsr3Z5fxpzH
	 Q5a8aQfam0AuXLQg758xvMTYFdpGDQJsrb4Do6W61i9/289vF1NQwxVVQnk+kIR000
	 5wsH+/w7CpG8A==
Message-ID: <a9eade27-9b77-431f-b7c8-24c3fb891673@kernel.org>
Date: Mon, 7 Jul 2025 21:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2025 16.53, Thomas WeiÃschuh wrote:
> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
> The code will still fully typechecked but the unreachable parts are
> discarded by the compiler. This prevents accidental breakage when a certain
> kconfig combination was not specifically tested by the developer.
> This pattern is already supported to some extend by module.h defining
> empty stub functions if CONFIG_MODULES=n.
> However some users of module.h work on the structured defined by module.h.
> 
> Therefore these structure definitions need to be visible, too.

We are missing here which structures are needed. + we are making more things
visible than what we actually need.

> 
> Many structure members are still gated by specific configuration settings.
> The assumption for those is that the code using them will be gated behind
> the same configuration setting anyways.

I think code and kconfig need to reflect the actual dependencies. For example,
if CONFIG_LIVEPATCH depends on CONFIG_MODULES, we need to specify that in
Kconfig with depends on, as well as keep the code gated by these 2 configs with
ifdef/IS_ENABLED.

> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/linux/module.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
>  
>  struct notifier_block;
>  
> -#ifdef CONFIG_MODULES
> -
> -extern int modules_disabled; /* for sysctl */
> -/* Get/put a kernel symbol (calls must be symmetric) */
> -void *__symbol_get(const char *symbol);
> -void *__symbol_get_gpl(const char *symbol);
> -#define symbol_get(x)	({ \
> -	static const char __notrim[] \
> -		__used __section(".no_trim_symbol") = __stringify(x); \
> -	(typeof(&x))(__symbol_get(__stringify(x))); })
> -
>  enum module_state {
>  	MODULE_STATE_LIVE,	/* Normal state. */
>  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> @@ -598,6 +587,18 @@ struct module {
>  	struct _ddebug_info dyndbg_info;
>  #endif
>  } ____cacheline_aligned __randomize_layout;
> +
> +#ifdef CONFIG_MODULES
> +
> +extern int modules_disabled; /* for sysctl */
> +/* Get/put a kernel symbol (calls must be symmetric) */
> +void *__symbol_get(const char *symbol);
> +void *__symbol_get_gpl(const char *symbol);
> +#define symbol_get(x)	({ \
> +	static const char __notrim[] \
> +		__used __section(".no_trim_symbol") = __stringify(x); \
> +	(typeof(&x))(__symbol_get(__stringify(x))); })
> +

The patch exposes data structures that are not needed. + breaks the
config dependencies.

For example, before this patch:

#ifdef CONFIG_MODULES

{...}

struct mod_tree_node {

{...}

struct module_memory {
	void *base;
	bool is_rox;
	unsigned int size;

#ifdef CONFIG_MODULES_TREE_LOOKUP
	struct mod_tree_node mtn;
#endif
};

{...}
#endif /* CONFIG_MODULES */

After the patch, mod_tree_node is not needed externally. And the mtn field
in module_memory is exposed only under MODULES_TREE_LOOKUP and not MODULES
+ MODULES_TREE_LOOKUP.

I general, I see the issues I mentioned with LIVEPATCH, mod_tree_node, macros,
and LOOKUP.

>  #define MODULE_ARCH_INIT {}
>  #endif
> 

