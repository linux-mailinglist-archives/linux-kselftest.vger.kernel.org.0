Return-Path: <linux-kselftest+bounces-22126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A279CF9DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 23:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7491A1F257A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B6190676;
	Fri, 15 Nov 2024 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+F3wir6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69195824BD;
	Fri, 15 Nov 2024 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710075; cv=none; b=UfgquokJrurdR5MYoZHhIlJN3vw9TarEkPRE5Am8rOOkmo+/5TFb8u0BGWLqPqCLpL5i7Y3RCq9jSR2gPIHkca7pKhr03b1kavoKIg5nXtaJyRHZAeasBuzrwbmjNGO+2oVcqHgZ5lzaQcstVdTvsbLpXXW/mExkW2BDuu8dBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710075; c=relaxed/simple;
	bh=NyeAX+WeerufLKm4g1qjr93Jb4WTEJuErUmiML1uyyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrz0oNgAMVvHvZheRhgRwrY9GKJDC8upT6Ldb/6ZPYmVUSFForOp5NeFXoApQ4iJPLn4QIY4E66ng4kC1G90COg6QRPm6UV4GOQtsd0NfYsSmCi1taKBHY510MXtz4JzRWCjOIE4zp6JPWkzvXAgrbf8wMS/8odyfr00YUdZN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+F3wir6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63981C4CECF;
	Fri, 15 Nov 2024 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731710074;
	bh=NyeAX+WeerufLKm4g1qjr93Jb4WTEJuErUmiML1uyyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+F3wir6bUghSdUfPAcSQck5zK5r6nNiD/0hsMJ9nRcL9xZKShM/jBUSrt0MBb58b
	 k6EDcu0TGunKL6o2QARtxMgR+uz0bKaoGHInfmb3E4aS2AfVqsosOdHE+pBCvirAtO
	 IYNBfS8ACxQwFFkVomIwhudRXAKXA3GDmtXgaZxkKSzMHFsP9/mlYjzbXaE55PpdVK
	 g8nv1c9f7nRxTAvnwm3LCwfuiMw1j5W/iIvHmQjjqWltAz6N0v17iP9rYZlNPtVcsb
	 pB5/WuO5oFoK9q5pwC7poxDo7FYoBtuiZDjHqF/hNC1JZzz4UHRkp96oGW+yB5EjEs
	 sxu98wqBnD/ww==
Date: Fri, 15 Nov 2024 14:34:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Duyck <alexander.duyck@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Aishwarya.TCV@arm.com
Subject: Re: [PATCH net-next v23 1/7] mm: page_frag: add a test module for
 page_frag
Message-ID: <20241115143433.05a3671e@kernel.org>
In-Reply-To: <ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
	<20241028115343.3405838-2-linyunsheng@huawei.com>
	<ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
	<a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
	<ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:12:09 +0000 Mark Brown wrote:
> > As above, I am not sure if there is some elegant way to avoid the above error
> > in the selftest core, one possible way to avoid the above error is to skip
> > compiling like below as tools/testing/selftests/mm/test_page_frag.sh already
> > skip the testing for page_frag if the test module is not compiled:  
> 
> Since the tests currently don't build the test systems are by and by
> large not getting as far as trying to run anything, the entire mm suite
> is just getting skipped.

Yunsheng, please try to resolve this ASAP, or just send a revert
removing the selftest for now. We can't ship net-next to Linus breaking
other subsystem's selftests, and merge window will likely open next
week.

