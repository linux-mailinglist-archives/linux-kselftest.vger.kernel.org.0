Return-Path: <linux-kselftest+bounces-27973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80696A4ACE0
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653F818972A5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568211DF252;
	Sat,  1 Mar 2025 16:33:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47451B3927;
	Sat,  1 Mar 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846782; cv=none; b=a764HfuQg4SRdR+3x3h/cHFu1d/Wu+OAyNELqv8pCXoGXaVC+tZmTkw38ixsX7gcUVWMFdiE/hUfzdYRPpx5yb//RLqPSoDl08dJa8mC2+dO6lgFY0gIdpwD3Re2XMKD6ungzgzUbv8Rk57uJUR2GPzjuTbladVaDMXB2TS72rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846782; c=relaxed/simple;
	bh=54hW+egiEXB+sL2tiSUc0YgU0BsvzKY+qeJO+swH59s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyfYatymjsP7jUklfZXxgOp3FviQ4Ne3qhB9T3/rbxYs124DDOIDq+mPRIuF9eDsXTpRo7ievfI+TFUOzYa/FNeK4w1/cA+tskE5pcFs+R+nvVeYRN/vbRSXhk1+mVR/ic9CfW9EpKUKs1uNi5wwynlA2gytheEn6dltqElrr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 521GWq0X015260;
	Sat, 1 Mar 2025 17:32:52 +0100
Date: Sat, 1 Mar 2025 17:32:52 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: add armthumb configuration
Message-ID: <20250301163252.GC13434@1wt.eu>
References: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Mar 01, 2025 at 12:23:58PM +0100, Thomas Weißschuh wrote:
> While nolibc does support ARM Thumb instructions,
> that support was not tested specifically.

Good idea! In my case (and most likely most users), it actually allows
to test the Arm mode, because I think that the majority of Arm cross
compilers are configured to produce thumb2 code by default since it's
generally faster and quite smaller.

Tested-by: Willy Tarreau <w@1wt.eu>

Willy

