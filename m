Return-Path: <linux-kselftest+bounces-14765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A824D9468EB
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41E31C20A59
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E474040;
	Sat,  3 Aug 2024 09:50:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAC2C6AF;
	Sat,  3 Aug 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678654; cv=none; b=fGPqwYb60zh5Mn9DntolUX1U0WCJS/zf94YtPKO5ibwsyNqye+k+TeQG8jfohM3393CXznofNJPwT0nxZhs4TXLsW4AJ8Zt3RU48KOQrLtLB2VrsoyE6yNN1B7lw3VYgnFosq6Tf0DyMU5/6zwopdTGG7G7tO1xlTJ/kEMNBf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678654; c=relaxed/simple;
	bh=oHaZDL+kicwIp53ZIcTo6KgpNmfzXztQ4Ut8xnb2aKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSMPMCP/nNAzcpR3Uu/BcUPqhwdMUn0VmT72NlRajSnkoVPF3+7avBJs4wxDF0SqwqMZ52v9CipP+dG/SIpCtNAJnqh9hSCLZbFfq/wLp2VuSKfwOXVWlOgzHz5+E3JxarnmH6pmhYEK/qysO0LeyjooaInZlz+g3EVA9cB+1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739oiDb029286;
	Sat, 3 Aug 2024 11:50:44 +0200
Date: Sat, 3 Aug 2024 11:50:44 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
Message-ID: <20240803095044.GF29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 12:09:54PM +0200, Thomas Weißschuh wrote:
> The current support for LLVM and clang in nolibc and its testsuite is
> very limited.
> 
> * Various architectures plain do not compile
> * The user *has* to specify "-Os" otherwise the program crashes
> * Cross-compilation of the tests does not work
> * Using clang is not wired up in run-tests.sh
> 
> This series extends this support.

Overall Ack on the whole series once the minor comments are addressed
or discussed: Acked-by: Willy Tarreau <w@1wt.eu>

thanks!
Willy

