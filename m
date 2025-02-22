Return-Path: <linux-kselftest+bounces-27259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD9A4070E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393DD705114
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B32066DA;
	Sat, 22 Feb 2025 09:45:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3D202C3D;
	Sat, 22 Feb 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217516; cv=none; b=kX5BYGjwZll49dRz993c8OuOuyBfVv8UtaX6I1/gG8z8nH4LrdTf8kekTTPGtWMdnQdmz++XVz81ZmVcrmXJodGfPmVYVciZD0mdHTQzfAdbCnCHd5qrV9rADG9UetWzHJHzIlB+dNb7BllOTuN7abNpxeQduBhv6bJjCwIx7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217516; c=relaxed/simple;
	bh=x+IPeiDLCu0ehvKt7As1lm2Be8HxA1Uyzn0RpCxOApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQVKcxDV4mLPs9awyt+gXzSP8nldM1vMh8GTG5Wb87yGz+/rPOe+RNrHByABLZLE6X0otWAxyv9dazXdipikiL6tmogHeCJcJE1Ax5g5KnROaei9O8Pmf8oZJKnA360Kdtcvb5/Ut2OY652j866rI2GTdRxiIbU19+VvMZcpW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51M9ierc013314;
	Sat, 22 Feb 2025 10:44:40 +0100
Date: Sat, 22 Feb 2025 10:44:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/12] kbuild: userprogs: add nolibc support
Message-ID: <20250222094440.GB13258@1wt.eu>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
 <20250217-kunit-kselftests-v1-4-42b4524c3b0a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-kunit-kselftests-v1-4-42b4524c3b0a@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 17, 2025 at 11:59:24AM +0100, Thomas Weißschuh wrote:
> Userprogs are built with the regular kernel compiler $CC.
> A kernel compiler does not necessarily contain a libc which is required
> for a normal userspace application.
> However the kernel tree does contain a minimal libc implementation
> "nolibc" which can be used to build userspace applications.
> 
> Introduce support to build userprogs against nolibc instead of the
> default C of the compiler, which may not exist.
          ^^^
"C library" or maybe "libc" I guess here.

Willy

