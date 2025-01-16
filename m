Return-Path: <linux-kselftest+bounces-24623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0DA1329F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 06:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A9B167102
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 05:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED958634E;
	Thu, 16 Jan 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dj8JKdiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB14C85;
	Thu, 16 Jan 2025 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005557; cv=none; b=V73T+F6UJy/xBMURAnTDLUZCAnOkOzPuX+HzaaUZVApS+hIYfIig0D/uoYRxkL7TsG3rA+XC7wxklI6PPzGa+fJ6iqkgWma504uBx7zd4Pdm4CyT2EgHSm/1LTsKRMuGpD2COtX4z37MuNjeTrwlvM+2xRLUreEGqefBiXWRGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005557; c=relaxed/simple;
	bh=xt1r3pGA2UzvaX0ebhgMidtfKhqJ82VXRe40hRf/fiE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qpvhdpAmBO+sOMRFCGWHMoNA6yyAlryPb+FqUqC6guluB8/cp6ao13KruTVz/eVuAsrEuZOQM54pNR3FXO54k/k1ErOz/1KIdQ+SbbvGGTaujVZXqHTAT4sa0yD9Bfky2igWwKvowf6ZgOfGwkOsWjTDaGEeQcqnv9IJIBh4SiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dj8JKdiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643DFC4CED6;
	Thu, 16 Jan 2025 05:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1737005556;
	bh=xt1r3pGA2UzvaX0ebhgMidtfKhqJ82VXRe40hRf/fiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dj8JKdiG9jR9ZMhzQwmKWscJBXSeRrJb8qn5VL1SjfLbj5bxH76RjFyRpgoGF9YOm
	 Sm6kTcS0+0ThfIeaLL38ybwxSRHD53M8qR7TBVaN8m24lpSaFlUg8fUf+cmJMg9rWb
	 nzYC665sswKgrJ1io2uGPZNR84YFbFGexfEIKMVA=
Date: Wed, 15 Jan 2025 21:32:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 00/16] selftest/mm: Remove warnings found by adding
 compiler flags
Message-Id: <20250115213235.713d0c5af3269c318740b66f@linux-foundation.org>
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 22:38:26 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Recently, I reviewed a patch on the mm/kselftest mailing list about a
> test which had obvious type mismatch fix in it. It was strange why that
> wasn't caught during development and when patch was accepted. This led
> me to discover that those extra compiler options to catch these warnings
> aren't being used. When I added them, I found tens of warnings in just
> mm suite.
> 
> In this series, I'm fixing those warnings. The last check adds the
> compiler flags with which the warnings have been caught.

I'm seeing a couple of unresolved issues against this series so I'll drop
v1.  Please let's revisit after -rc1.

https://lkml.kernel.org/r/20250110190057.2294fd5a@pumpkin
https://lkml.kernel.org/r/d9c290e2-f22d-41be-aa68-2aebd3eb1a67@sirena.org.uk

