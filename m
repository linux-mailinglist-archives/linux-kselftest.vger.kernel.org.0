Return-Path: <linux-kselftest+bounces-29903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F077A75342
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06B33AF2F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116401F4619;
	Fri, 28 Mar 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eKKomaXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25591F419C;
	Fri, 28 Mar 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204164; cv=none; b=gxOGVCagHwYtTZ9kVpwwCpLany4RocYkPQZ1wzrkx6OQTkyiRnzn1EthM+JV89NixSftmJEjXrLvaji2KtyL6ryRUrxkLzQqI2dheDT9MI/zn5cPM2JfrorDEMysV1HauaJdrwszsC6tvAl9B9xyt6bnUdF97W/SVx0uUlwrc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204164; c=relaxed/simple;
	bh=Gw8j7vbtBV8cOx3P6MxuxBcJ1K1VyJvT6sET6jo8Bfo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NM979iovxxRFqKw6bJcT6DgyM/1Hd0MklsQYCF+NOb6zBUuQAbBKUOSqa1/O0scR0GovCwUh2DSDkmKYRWNHpBoWwEB5CN3PnAQ4Xc0pPrRXUnGEkIE4VaLueFo1BIPuB7Dw8yJwGuqfRD50d+1GlZBVDJF6Sgyv69mGrWmhnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eKKomaXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C84C4CEE4;
	Fri, 28 Mar 2025 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743204163;
	bh=Gw8j7vbtBV8cOx3P6MxuxBcJ1K1VyJvT6sET6jo8Bfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eKKomaXEwp5zWIJm6Ia5naY1FQNEmL7jJTFw7rVCwvwkddfj/l7F1DU0713kSpQXK
	 pfDWHfZSp9DEcZN7JnBqG+nBFwS3LazekPyx9o6qNYiM8y8dKD9vk5eNvd+9KS+T+z
	 IJDjMz4MG2dmgBB8Yf42fSysibJ+/f6qg+Y9r/LA=
Date: Fri, 28 Mar 2025 16:22:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Siddarth G <siddarthsgml@gmail.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, David Binderman
 <dcb314@hotmail.com>
Subject: Re: [PATCH] selftests/mm: Fix loss of information warnings
Message-Id: <20250328162242.3f7d3f0223efb9a20889b67b@linux-foundation.org>
In-Reply-To: <20250328220037.149763-1-siddarthsgml@gmail.com>
References: <20250328220037.149763-1-siddarthsgml@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Mar 2025 03:30:37 +0530 Siddarth G <siddarthsgml@gmail.com> wrote:

> Cppcheck reported a style warning:
> int result is assigned to long long variable. If the variable is long long
> to avoid loss of information, then you have loss of information.
> 
> Changing the type of page_size from 'unsigned int' to 'unsigned long long'
> was considered. But that might cause new conversion issues in other
> parts of the code where calculations involving 'page_size' are assigned
> to int variables. So we approach by appending ULL suffixes

I think that approach remains preferable.  Keep changing things to
`unsigned long' until the warnings stop?


