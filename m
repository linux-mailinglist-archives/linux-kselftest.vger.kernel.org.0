Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5142580E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 18:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbhJGQiL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 12:38:11 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:44516 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233594AbhJGQiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 12:38:10 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 12:38:10 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id EAECD1810B56F;
        Thu,  7 Oct 2021 16:27:47 +0000 (UTC)
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8E76932068;
        Thu,  7 Oct 2021 16:27:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 1F152240237;
        Thu,  7 Oct 2021 16:27:40 +0000 (UTC)
Message-ID: <86b05929e5aa8fa6e975c59cf523ad84498351b6.camel@perches.com>
Subject: Re: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Thu, 07 Oct 2021 09:27:38 -0700
In-Reply-To: <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
         <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F152240237
X-Spam-Status: No, score=0.46
X-Stat-Signature: gosseop3rb95z89swki8e9bzmog67jrw
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX196qwUvlrD61uEpXpW7FIgH2TG8JPkatj8=
X-HE-Tag: 1633624060-492939
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-10-07 at 18:44 +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt cleaning it up by splitting out container_of() and
> typeof_member() macros.
> 
> For time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

IMO: this new file is missing 2 #include directives.

> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
[]
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

And trivially: I'd prefer GPL-2.0-only

> +#ifndef _LINUX_CONTAINER_OF_H
> +#define _LINUX_CONTAINER_OF_H
> +
> +#define typeof_member(T, m)	typeof(((T*)0)->m)
> +
> +/**
> + * container_of - cast a member of a structure out to the containing structure
> + * @ptr:	the pointer to the member.
> + * @type:	the type of the container struct this is embedded in.
> + * @member:	the name of the member within the struct.
> + *
> + */
> +#define container_of(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);					\
> +	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
> +			 !__same_type(*(ptr), void),			\
> +			 "pointer type mismatch in container_of()");	\

This is not a self-contained header as it requires
#include <linux/build_bug.h>
which should be at the top of this file.

> +	((type *)(__mptr - offsetof(type, member))); })
> +
> +/**
> + * container_of_safe - cast a member of a structure out to the containing structure
> + * @ptr:	the pointer to the member.
> + * @type:	the type of the container struct this is embedded in.
> + * @member:	the name of the member within the struct.
> + *
> + * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
> + */
> +#define container_of_safe(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);					\
> +	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
> +			 !__same_type(*(ptr), void),			\
> +			 "pointer type mismatch in container_of()");	\
> +	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
> +		((type *)(__mptr - offsetof(type, member))); })

And this requires

#include <linux/err.h>

> +
> +#endif	/* _LINUX_CONTAINER_OF_H */



