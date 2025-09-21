Return-Path: <linux-kselftest+bounces-42015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438FB8D74A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024C53BDB8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533B239E8A;
	Sun, 21 Sep 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="RwDQcvJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8F1A9FB7;
	Sun, 21 Sep 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758442406; cv=none; b=DQH6psWokVQaoOO2R/YBqRKZzR5UCWAPzfkdPgTQRxs+SAOZs/gNf8JgjztmHbxwyclLNwHaYbZdstPahJahkbsKx8uBVTY4797YdsRlvbR/yDAUkBI4XJf+ueK8mhfjWrAf67Txt6D0v/NPvIe6Swn0Mm1DOhQa0sDLfhluRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758442406; c=relaxed/simple;
	bh=D2aLbrLZ2VyNRIhd2HXR7vAP2zBEuhbh0wSJx/M4gbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VptVJHq2XAC9RcnouzZxsPPq7gUm3OZKqCBjtRCq8GyJwdaboU3T1EKzx0QxlUXgln5en/Mf1r/CgzIWxO1wi98Thyq7gX/37TjPtdh55Jz6EDS2VkZah/3179VKACGHWvZsctYuXXsPj4CqsBZn5Yad3yAuh4bBlQyzRDMX+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=RwDQcvJC; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758442398; bh=8p9taVRq2gq6tcyh60hYEpVIty1zhg9EsBjjZQFZvkY=;
	h=From:Message-ID:From;
	b=RwDQcvJCSqKgPtEE6Y6VTFKihOev/aZftmf36tAJ9ZOnkk6TQwj0dlDYNKYJsbQyJ
	 z2vcZHaD7LPaDbCTDG/qkbvBkflWietzyd1oO0XS1G8aFhpCNZ4NVTUcsZSR0G8oi6
	 BlFXEgQXbKoR1mGqKwaOVuNQwM81tEjPkHvF4nd4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D0D8AC072E;
	Sun, 21 Sep 2025 10:13:18 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L8DIKA016800;
	Sun, 21 Sep 2025 10:13:18 +0200
Date: Sun, 21 Sep 2025 10:13:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 07/11] um: add infrastructure to build files using
 nolibc
Message-ID: <20250921081318.GB16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-8-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-8-benjamin@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Benjamin,

On Fri, Sep 19, 2025 at 05:34:16PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
> than libc. With this it is possible to move to nolibc in smaller steps.
> 
> Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
> simple and cannot handle threading. nolibc provides sys_* functions that
> do not emulate the libc errno behaviour and can be used instead.

Just for my understanding, in case we can improve portability, why is it
needed to disable errno processing here ? Even if it's limited, it
shouldn't cause trouble. I mean that if a program works with it defined,
logically it should also work without since the only difference is that
the errno global variable will not be defined nor assigned on syscall
returns.

> Guard the syscall definition as it is a macro in nolibc.

This one is interesting:

  --- a/arch/um/include/shared/os.h
  +++ b/arch/um/include/shared/os.h
  @@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
   /* tty.c */
   extern int get_pty(void);

  +#ifndef NOLIBC
   long syscall(long number, ...);
  +#endif

In nolibc, the syscall() definition indeed looks like this now:

  #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
  #define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
  #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
  #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
  #define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)

Except by mapping all syscalls to _syscall(6, ...) and always passing
6 args, I'm not seeing any easy way to dynamically adapt to the number
of arguments if we wanted to move it to a function. Also, a static
function would still conflict with the definition above. I'm wondering
about what extent the documented "long syscall(number, ...)" is valid in
fact, as I doubt it's really implemented anywhere as a generic function
taking the maximum amount of args.

Thus I think that the guard is indeed the only option to reconciliate these
two incompatible approaches. By the way I think it could be more future-
proof to do the guard on the syscall macro definition itself (which would
thus also resist it being passed by "-Dsyscall(x)=(...)" or any other form:

  +#ifndef syscall
   long syscall(long number, ...);
  +#endif

Regards,
Willy

