Return-Path: <linux-kselftest+bounces-26483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CEDA32E04
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDF218831FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB325C6FE;
	Wed, 12 Feb 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LDw2stgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75825A622;
	Wed, 12 Feb 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383111; cv=none; b=rOkEyf3Y8xlqn6C11a9OFlGSeyedLtW4irfAZHBFwXE9h4tGLyNlkmi29ZubqNlv17wrvN0UdDzAEJa0FvXT3XnnKU9bXMi7DnkVSQzW0jGY8w2diqp/Wdc+q7jvm4AyHYvgBaKnq0YA+45ERuK9o4swr1W6iI9Lfjw+ibjzv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383111; c=relaxed/simple;
	bh=2bU8A6tid3BsI3raiGM96czITAPynVyTDtnRQKgP/9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWl5nKB+GAKJJllt+ZDoZYtr7a1/tY6urc09D4exNqvs9SZfelBCniYWVklgoRjI2IE89j9Gg+8y+CpnNIpctCZmvV2AMd+IKgYo9CBj06jmkJwrU8bi6O6rcLZyMCwYxZ8Y3mOeH2fnF+GhC9rSlV0XTwZI5UBN9vHvZky8aeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LDw2stgV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739383104;
	bh=2bU8A6tid3BsI3raiGM96czITAPynVyTDtnRQKgP/9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDw2stgV2keEOnny0RCUsswevWb+ToitUFUo5SPX+e9oJFERZKSCsquL91gxMGdep
	 KV4KylvaSixTK0RVHY+O3lXTGgcxM5K+1LhGfBLm9B8/qBKOEYY25SEraVdjIfgQhn
	 G1q1VGN9sNKHDckk9aIJ8qr+CcsAX9iQFZYtz4Lw=
Date: Wed, 12 Feb 2025 18:58:24 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: split up architecture list in
 run-tests.sh
Message-ID: <a1c291a0-fe8a-4005-a85e-eb0e2450a7e9@t-8ch.de>
References: <20250211-nolibc-test-archs-v1-1-8e55aa3369cf@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211-nolibc-test-archs-v1-1-8e55aa3369cf@weissschuh.net>

FYI Willy,

On 2025-02-11 12:03:52+0100, Thomas Weißschuh wrote:
> The list is getting overly long and any modifications introduce a lot of
> noise and are prone to conflicts. Split the string into a bash array
> and break that into multiple lines.

I picked up this trivial change already.

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/run-tests.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

<snip>

