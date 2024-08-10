Return-Path: <linux-kselftest+bounces-15113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C8294DD5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021D61F21755
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C341607AA;
	Sat, 10 Aug 2024 14:55:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61BB1C28E;
	Sat, 10 Aug 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301703; cv=none; b=RKCHbKTa/qjjs3U+imj3aYC9JubBJCkRU7j6eMvJRvc6QhPxClAtbylrYum2PMf2LCZUw6MVDwdGCv+rqGLRH00twbQ1XaeVPNbJfRrB4x7oimWGp2Nx/+DZA7HBcI2Z7n+JGMp9fjBQ1bZpau7vsFi/rtfSgA5c8DY10yf0mGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301703; c=relaxed/simple;
	bh=iMZWVpmxqC4k6ncowCRwpVtJFaCpMtGDRC4fmbcPtac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgGdq14pkv4P6oDMFLr1Qbve7Pkf4T26mEZkFqRSEgSzxzBBNgWP0O0VTAjRrUpwHY5K+trUdRgEWyl0FqUG9fsv/WNpjVeC8+KlwRSqlw7dWsjOapAhzXNhw0IEnNBh8HM1FGbNRc7aZuWMZNQgQ5UJPvfB1/nCLQFYFVodIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47AEsoWP009489;
	Sat, 10 Aug 2024 16:54:50 +0200
Date: Sat, 10 Aug 2024 16:54:50 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 14/15] selftests/nolibc: use correct clang target for
 s390/powerz
Message-ID: <20240810145450.GB9168@1wt.eu>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
 <20240807-nolibc-llvm-v2-14-c20f2f5fc7c2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807-nolibc-llvm-v2-14-c20f2f5fc7c2@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 07, 2024 at 11:51:50PM +0200, Thomas Weißschuh wrote:
> The target names between GCC and clang differ for s390.
> While GCC uses "s390", clang uses "powerz".
(...)
> +# GCC uses "s390", clang "systemz"
> +CLANG_CROSS_FLAGS := $(subst --target=s390-linux,--target=systemz-linux,$(CLANG_CROSS_FLAGS))

Based on your successful tests, I think the "powerz" in the commit
message is the one to change here ;-)

Willy

