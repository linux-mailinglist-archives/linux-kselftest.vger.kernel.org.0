Return-Path: <linux-kselftest+bounces-37205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F48B0313A
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B9189BD32
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C6278774;
	Sun, 13 Jul 2025 13:42:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83330278772;
	Sun, 13 Jul 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414156; cv=none; b=cYEBeUovQp95Xg5AYFrCRS5JZW/8RFeZ83i6txxNfz0qaBCB/htjBqnSMyW3sCNaScyJM5Ne/chDQMJ7z7qh2pdZvO6qp1VOIKXEpz3Vxm4+MJEmhMJjyF+IF222lxhRWVoq0QWr5FwPfyOZjvVCQ5597VdcWbvssw2AGHxVphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414156; c=relaxed/simple;
	bh=A47skBCl1urS0CjnqOHX8z8xhzPgaPT/8d4JesjpOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSRw9I1m5HSI2CezTCnDd+cJJTIgXdKH15RZ1r5NdwWNhl02gf+6ZVYtcCBIYN961hYOIi+tNXH5gtQB2ARJJLtZtQFC19Qap63yefECkxIAoNNgDREMzIEmozLbQnqeu6Vdfb+iZ0DbpWVGVulkd5OjuwI5JSrPt7vM8LQKzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56DDgJtv025713;
	Sun, 13 Jul 2025 15:42:19 +0200
Date: Sun, 13 Jul 2025 15:42:19 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: define time_t in terms of
 __kernel_old_time_t
Message-ID: <20250713134219.GA25665@1wt.eu>
References: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
 <20250712-nolibc-x32-v1-1-6d81cb798710@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250712-nolibc-x32-v1-1-6d81cb798710@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jul 12, 2025 at 11:00:55AM +0200, Thomas Weiﬂschuh wrote:
> Nolibc assumes that the kernel ABI is using a time values that are as
> large as a long integer. For most ABIs this holds true.
> But for x32 this is not correct, as it uses 32bit longs but 64bit times.
> 
> Also the 'struct stat' implementation of nolibc relies on timespec::tv_sec
> and time_t being the same type. While timespec::tv_sec comes from the
> kernel and is of type __kernel_old_time_t, time_t is defined within nolibc.
> 
> Switch to the __kernel_old_time_t to always get the correct type.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Great! I didn't know we could support x32 and thought it was phased out.
But if it works it can be convenient for those seeking smaller binaries.

Both patches look good to me, for the whole series:

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

