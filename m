Return-Path: <linux-kselftest+bounces-26391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8FA310A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8DA7A065A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901EF253B4C;
	Tue, 11 Feb 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YYXaCR1m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8B26BD9C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290017; cv=none; b=QtKtW0/GI9PAF0Aj58hdsuErUumuovB7VE13Mq49ORjEAlLcSA0IIeyHEe0WFRW4E1IyGNCS+3b/UdxkjTw32QKrEYOjHuiQ/iKYWd34xxvVpzXZvO8CoxT0Pj7r/jZ0al23WYNeLMNzb99GKtt908VfUgR9K4dc/DQSEx2psY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290017; c=relaxed/simple;
	bh=mQddwpdZ0Ihot9AmhVTSHKXOJUyVr2HF5eoyzuLjFVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsSZeTjc2LXqx/l/NBPTHZL0F0QZDYFux+wqaJRpqkDylx3EFC7gsztqFuyGSY0Krom7kxY/YZD54JIQF93Gc3NIzzsMTyMbyy6GfZPUnEMeth3YEEHcm3HiyBUxjvzIPKZagsYg/6gmUP4Qss1Ifqb1+KKR+DR8dfL2gp5LqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YYXaCR1m; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7b80326cdso444740366b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739290013; x=1739894813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1vf46oZeFoxOqLO50umpDez6jA5n/W8mYrcU/vkha/U=;
        b=YYXaCR1mcMyyy5FF9nMMSju/+INv7XuVwb6bPRDRKco8NyKe4VhQ047HIzdVuXfWU0
         u3k3S11tG86JpOgHkKfCreNZwuQGidkHz9OcdAR+fcx4skWcE6jZWcJIShuCHO1aP4Ip
         7ZdmFXyhhzr/AvDCUNoYjEJXya89oAieUeW+5mUCdU0zCua3RG9sFt7f3d0spkk7JJj2
         h7Z2Ac1bfRQYIg3DtQDUNAI0aZQpQ0LNthrzRt2Xw3Q/Hm9AD2+vM3CNu7ozMuI5b93k
         bzdFLrIWQ3PFestQPJgs5CKFpHOofFVH+8G9X9x9tHJKHsWf9NeQBP8lwOoAzMvWxmpd
         JcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290013; x=1739894813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vf46oZeFoxOqLO50umpDez6jA5n/W8mYrcU/vkha/U=;
        b=dPR4UUCJtydg1j+OTTjIQL/EYkRvPKlyfoGr92/mgUzzLuIp1Qsjd2G2td7YK+JdwI
         7GN6GR8p1ca4nJ/DdLSDhgeBVKQV/B09bc8AVEzJS3Ydpsu/16Ald5HlvWfPeVKgp+qE
         0aSfjIcaKFC6eKRR3aTJ0n9IyaQfZ+j5v+VRyrNH4xar2lHLDLRFHe3UGwmNAqaDmcFt
         y+FFQ1ou7MZ6i6KEQI3uffCHKE7u5/gD1Ry/JkLdQJE/yZmKGJBslruskNUtRh7y+kD8
         3nphAxC+kNfHD867aBur2/N8kOuO10j2DrU4L3gkumu90vvLbhCEh7FGzexYLAlV0T6L
         CbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkdwjR3iJRcIDjpkl+970d9XpEqOl0DbTCvqUq7EpNXNQsppb4SLMBDkpppLDVPklZGOP76HD7U10fk+ZEys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XevuDdvVtdquegsj+Udwy9gvRNhuNi29irCoix031LOVDFha
	0r1ksw2wQcP6zFFAZeXP1ma4EBDH+q6VPsvaiL9d1FS3lRVPG63UGnati0lsPik=
X-Gm-Gg: ASbGncsXAtPrLkljq37+gRxN3Jvulwza++8Hz/irn9YVNx31hGnKaJe7Pf3IsMP6beD
	Qj0oYWEcR7iqfhuX2LSFGYlm01SOgBrE7iDSetaWdc+PDV3YokaHR/6RS+9IwbszjhDHPqXt1TQ
	pOPz51/hPEIoFZsFM/ulRp98D2FjHdrDld7gmSF/ztY3SMz9b7bbPe2qFWRIKBtJK5G+Kq3tH2l
	e9HuLuHcnNYK1GhhzcXx8g1K8UQNiysRjdYdiJHZF9MKF5hFMN5cFd4upEatANZAh3aHO22dn+7
	mnyKRINz27RB82lx1g==
X-Google-Smtp-Source: AGHT+IGT0MfU9kXWXFZFDn3uHAWY6yl48r2PjzXtjG90l6qIEwpY73PJqLOJImHmqtLgQt0wfSLUCw==
X-Received: by 2002:a17:907:7f23:b0:ab7:e73a:f2c8 with SMTP id a640c23a62f3a-ab7e73af6d3mr242630566b.26.1739290013326;
        Tue, 11 Feb 2025 08:06:53 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ca66cc36sm342984566b.155.2025.02.11.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:06:52 -0800 (PST)
Date: Tue, 11 Feb 2025 17:06:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] scanf: convert self-test to KUnit
Message-ID: <Z6t1midEnp5q1Uja@pathway.suse.cz>
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
 <Z6s2eqh0jkYHntUL@pathway.suse.cz>
 <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>

On Tue 2025-02-11 06:45:07, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 6:37 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:
> > > Convert the scanf() self-test to a KUnit test.
> > >
> > > In the interest of keeping the patch reasonably-sized this doesn't
> > > refactor the tests into proper parameterized tests - it's all one big
> > > test case.
> > >
> > > Acked-by: Petr Mladek <pmladek@suse.com>
> >
> > Please, remove this. The patchset has changed a lot and it is not
> > longer true.
> 
> Will do.
> 
> >
> > > --- a/lib/test_scanf.c
> > > +++ b/lib/scanf_kunit.c
> > > @@ -15,67 +13,49 @@
> > [...]
> > >  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)               \
> > >  do {                                                                         \
> > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                              \
> > > +     kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);  \
> >
> > The switch from pr_debug() to kunit_printk() causes printing huge
> > amount of messages even when the test passes.
> 
> I'm not able to reproduce this.

It is because the loglevel filtering, see below.

> pr_debug expands to printk(KERN_DEBUG,
> ...) which is also what kunit_printk(KERN_DEBUG, ...) expands to. Can
> you help me understand how you're testing?

It is more complicated, see the following in include/linux/printk.h:

<paste>
/* If you are writing a driver, please use dev_dbg instead */
#if defined(CONFIG_DYNAMIC_DEBUG) || \
	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
#include <linux/dynamic_debug.h>

/**
 * pr_debug - Print a debug-level message conditionally
 * @fmt: format string
 * @...: arguments for the format string
 *
 * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
 * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
 * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
 *
 * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
 * pr_fmt() internally).
 */
#define pr_debug(fmt, ...)			\
	dynamic_pr_debug(fmt, ##__VA_ARGS__)
#elif defined(DEBUG)
#define pr_debug(fmt, ...) \
	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...) \
	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif
</paste>


It would be nice to define it the other way around. But it would
require reworking the macro trickery which might be tricky ;-)


> > [ 5780.664377] KTAP version 1
> > [ 5780.664891] 1..1
> > [ 5780.665376]     KTAP version 1
> > [ 5780.665765]     # Subtest: scanf
> > [ 5780.666104]     # module: scanf_kunit
> > [ 5780.666112]     1..10
> > [ 5780.667354]     # numbers_simple: "0", "%llu" ->
> > [ 5780.667371]     # numbers_simple:    0
> > [ 5780.667923]     # numbers_simple: "0", "%llu" ->
> > [ 5780.668321]     # numbers_simple:    0
> > [ 5780.668803]     # numbers_simple: "1", "%llu" ->
> > [ 5780.669175]     # numbers_simple:    1
> > [ 5780.669624]     # numbers_simple: "18446744073709551615", "%llu" ->
> >
> > [... skipping 7500+ lines ...]
> >
> > [ 5783.157777]     # test_simple_strtol: simple_strtol("0x7fffffffffffffff", 0) -> 0x7fffffffffffffff
> > [ 5783.158229]     # test_simple_strtol: simple_strtol("0x8000000000000001", 0) -> 0x8000000000000001
> > [ 5783.158683]     # test_simple_strtol: simple_strtol("0x8000000000000000", 0) -> 0x8000000000000000
> > [ 5783.159131]     # test_simple_strtol: simple_strtol("0x8000000000000000", 0) -> 0x8000000000000000
> > [ 5783.159586]     # test_simple_strtol: simple_strtol("0x8000000000000001", 0) -> 0x8000000000000001
> > [ 5783.160048]     # test_simple_strtol: simple_strtol("0x7fffffffffffffff", 0) -> 0x7fffffffffffffff
> > [ 5783.160506]     # test_simple_strtol: simple_strtol("0xfffffffffffffffe", 0) -> 0xfffffffffffffffe
> > [ 5783.160957]     # test_simple_strtol: simple_strtol("0x2", 0) -> 0x2
> > [ 5783.161467]     # test_simple_strtol: simple_strtol("0xffffffffffffffff", 0) -> 0xffffffffffffffff
> > [ 5783.161806]     # test_simple_strtol: simple_strtol("0x1", 0) -> 0x1
> > [ 5783.162564]     ok 10 test_simple_strtol
> > [ 5783.163145] # scanf: pass:10 fail:0 skip:0 total:10
> > [ 5783.163537] # Totals: pass:22 fail:0 skip:0 total:22
> > [ 5783.164052] ok 1 scanf

I saw the above messages using "dmesg".

They can also be seen in /sys/kernel/debug/kunit/scanf/results
when CONFIG_KUNIT_DEBUGFS is enabled.


> If you use one of the kunit userspace helpers, you will only see the
> output when the test fails. Having said that, in my local testing I
> don't see the KERN_DEBUG prints locally. I had to run with
> ignore_loglevel to see them at all.

Yeah, KERN_DEBUG are for the least important messages. Consoles usually
do not print them to do not scare normal users and also historically
because of slow serial consoles.

Anyway, they are always stored into the internal log buffer. So that
they can be seen by "dmesg" even when they were filtered on the
console.

BTW: The log buffer has a limited size. The oldest messages get lost
     when are too many of them. Which is another reason to do not
     print the debug messages by default.


Best Regards,
Petr

PS: You are sending new revisions too fast. It is hard to follow.
    I personally prefer to send one revision per week at maximum.
    It gives people chance to find time for the review and provide
    some feedback.

