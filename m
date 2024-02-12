Return-Path: <linux-kselftest+bounces-4541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D1852130
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 23:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40677B25C9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D834D9F1;
	Mon, 12 Feb 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lg8wZKjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3434D584;
	Mon, 12 Feb 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776091; cv=none; b=lzirXJ6kshoTXFdlLyoqxi6RmGSGel5nLCZmlhEMcbJ5acOX79ZbHhIpdn3EZ3Uzc7WskSFM+5vhmjYs6hS2cY+pxi7ZHBvoRJwYrA+LITEOFTgzJEhyXvBMS9Oqq15vvxJyMmHfu8p33e/AfJh4CWj29QJI4j2gFacwswyQwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776091; c=relaxed/simple;
	bh=toXHHTbqeffryJhHki02NqbDsdW7aRSndGKlscFHQkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tG9pJKCkMPu9RnDR5iX94WPOEaCdxeJc029JwYpSRyk+gcEbuMtlwnJAbnlTmNvl60zQjQEIMYyYRDOPct/gjbSv9DbjQ+axuoYzWupQlgu4Zxrh0vUTCGYcCma3vRCMq3+No1H5SZZzB9nvrZ+4cVa/zyB/vjxH5wHYGKd85PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lg8wZKjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D184C433C7;
	Mon, 12 Feb 2024 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707776090;
	bh=toXHHTbqeffryJhHki02NqbDsdW7aRSndGKlscFHQkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lg8wZKjp289xTkn6gV3mdgQRoKqlXRvvQATwOA1IG2m/OTQpgOiYrm2yBj4G1KKd4
	 FQlmTMd0pvfrJFq1i2sJEH09Z6I7u9n+Tduca9LcEiOqio1rjP0x5COybTadQ8Z1z+
	 X8pbUtQI4nKViZmFpzSfobpvs1K8hwmigTdO7PlE=
Date: Mon, 12 Feb 2024 14:14:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Bernd Edlinger <bernd.edlinger@hotmail.de>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] selftests: damon: add access_memory to
 .gitignore
Message-Id: <20240212141449.a72329a7ea28fd9ff828d1eb@linux-foundation.org>
In-Reply-To: <20240212202356.73461-1-sj@kernel.org>
References: <34986860-41e5-4d03-a0c5-72af12e7e97c@gmail.com>
	<20240212202356.73461-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 12:23:56 -0800 SeongJae Park <sj@kernel.org> wrote:

> > 
> > > Also, note that this conflicts on mm-unstable.
> > 
> > Should I use mm-unstable as basis to make sure no conflicts are introduced?
> 
> DAMON selftest patches could be merged in mm-unstable or linux-kselftest
> depending on cases.
> 
> If you rebase this on mm-unstable, it might conflict on linux-kselftest.
> Letting Shuah merge this on linux-kselftest and asking Linus Torvalds to fix
> the conflict in next merge window could be one possible option.
> 
> Or, making this split out of this series, rebase on mm-unstable, and asking
> Andrew Morton to carry may be another option.
> 
> Andrew and Shuah, may I ask your opinions?

I'd say base it on mm-unstable so we don't have conflicts for people to
deal with?

