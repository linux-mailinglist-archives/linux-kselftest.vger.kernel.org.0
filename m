Return-Path: <linux-kselftest+bounces-14763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E29468E3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55792281F4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028414E2DE;
	Sat,  3 Aug 2024 09:40:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5712EAEA;
	Sat,  3 Aug 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678031; cv=none; b=vFVgssgwwG08GkHRPTlazok/lcM80OSc3OaApjVQqdH83H2xThUrTGjzzTpT7DJPjvxFYscjsgjaveLRcNHxitiinMhVzFg3inw28Xj/DPaUqERhW5sNwhanQQwN3OTzRdwBIwx9vWMtp3PWXH6M3Xh5+1RJYmNPV4TkzvVWWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678031; c=relaxed/simple;
	bh=JdpUm+MsI2Cq5Q0UNZ8MsHARNEcPvrAocvzO1vuiI14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyt8/e1vllenzp8KbpZj29UEw0dZJlPuydKHTruM7Qncxwae4e/IH9P6gMatX3m/kF9xM+9U2hAjQRwMoE1S4Tvdpl2xwizGJMj+gfQywtpWecj2jOzhP+Xl2iEOrtnGMEV22e0Dd6tTahvKrScqkqtpuZ7Z1bbVO81s5i1Svvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739eO6x029257;
	Sat, 3 Aug 2024 11:40:24 +0200
Date: Sat, 3 Aug 2024 11:40:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/12] selftests/nolibc: determine $(srctree) first
Message-ID: <20240803094024.GD29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-7-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-7-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 12:10:01PM +0200, Thomas Weißschuh wrote:
> Avoid needing relative includes.

I'm not opposed, but what's the benefit ? IMHO relative paths are
generally more flexible and robust. you could imagine a completely
made up example in which you have a symlink to selftests/nolibc in
your home dir, which works perfectly with relative paths when you
cd into it while it would not anymore with absolute paths (unless
you use cd -P).

Thus if we are decided to lose that flexibility at least it should
be argumented in the commit message.

Thanks,
Willy

