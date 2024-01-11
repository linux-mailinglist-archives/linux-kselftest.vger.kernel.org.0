Return-Path: <linux-kselftest+bounces-2871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD01D82B678
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 22:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5578F1F2352B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE957318;
	Thu, 11 Jan 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m20FhbrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC958202;
	Thu, 11 Jan 2024 21:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C515EC433C7;
	Thu, 11 Jan 2024 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705007646;
	bh=KluFjsv67Zzv4EJRU7xqsvgiJikPQyze7Cf8ZgqSCis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m20FhbrGGOqwjqsNEt1pNssDuYEn/rXR5ntOE7yUlw8vd+A18DdEIgwGCmySqsWmM
	 HTwPiklqO90WP0flT96lpytIYRuz5r6zQQ8DR6byWK4Q5kLUJjTPdrmX5mgdu+005A
	 InqTak3NQpyZOm/ZvA2N5W9ZuESSbJDhonGj5ulU=
Date: Thu, 11 Jan 2024 13:14:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: mremap_test: fix build warning
Message-Id: <20240111131405.4b47521fb8884760d712e93d@linux-foundation.org>
In-Reply-To: <20240111082039.3398848-1-usama.anjum@collabora.com>
References: <20240111082039.3398848-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 13:20:38 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Fix following build warning:
> warning: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long long unsigned int’
> 

Looks good to me, but... grumble.

`i' is an integer.  That's just how it is, Blame Fortran if you like. 
Discovering that someone used `i' for an unsigned long long is like
seeing

	struct inode *page;

It is surprising, and readers shouldn't be subjected to surprises.

`i' is used in two ways here.  Twice to iterate across threshold values
(as a ULL) and once to iterate across dest_preamble_size, which is an
int.  It would be better to have two different variables for the two
different uses.  Ones with more appropriate names than `i'.


