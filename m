Return-Path: <linux-kselftest+bounces-9631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A608BEA5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73FEB25C91
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2A54BFA;
	Tue,  7 May 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSu0IwKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360310E6;
	Tue,  7 May 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101614; cv=none; b=TLlgZWhcBuKg1p1yFjEoWMcYTI9B7x54O5V9Klon/ooiIHYtcyl+xmYoryG1J7KGBGST3873yupxkIZu6ruBxzWlYyhJBtvVYWqCzE1ObqoYXDN260UgYCq9aGtLtTmDOdYF7PMBjIJF33u1rtmgdCGxcOu/TAGGzxJjlI24t18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101614; c=relaxed/simple;
	bh=I0KMSR0IFxJb+Wy8F+KtnXz3CBw9IWvYTFV+wlDZT6U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rboW+HPmoxEOe0yvdjYrfz9wofFji+FwM7avRJK2eCRIDtmO+TzHtpM1nroN3EjOT6kQi/ZXTzvrwMFST8cjvVryP7fQlcQwSsV4ZgEwZVjucnbguJmJK8pvnHx2zkz4FwiZ21d/1jhYpUSrjJe9oaDG0uRaWZ4A8LkZh0i792c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VSu0IwKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F757C2BBFC;
	Tue,  7 May 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715101613;
	bh=I0KMSR0IFxJb+Wy8F+KtnXz3CBw9IWvYTFV+wlDZT6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSu0IwKOE9sV4S/ghP+sxGR0Jv2NdyntyQAFtt6BVEYsxV/CGNKOJ9MWPv/kRgZ3z
	 FdP8B57RwJGeV7eAELA2EIFb6WOhTNr3/EZ/9WyZZJHlQoNlkfN+rOuSPZTEMdZ/ae
	 Fme0jRVdrq5/DGMwy4M+o29G/QQUziGnPgYCBIYw=
Date: Tue, 7 May 2024 10:06:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tao Su <tao1.su@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, edliaw@google.com,
 ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com,
 bongsu.jeon@samsung.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexandre.belloni@bootlin.com,
 jarkko@kernel.org, dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-Id: <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
In-Reply-To: <20240507063534.4191447-1-tao1.su@linux.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue,  7 May 2024 14:35:34 +0800 Tao Su <tao1.su@linux.intel.com> wrote:

> asprintf() is declared in stdio.h when defining _GNU_SOURCE, but stdio.h
> is so common that many files don’t define _GNU_SOURCE before including
> stdio.h, and defining _GNU_SOURCE after including stdio.h will no longer
> take effect.
> 
> Since kselftest_harness.h introduces asprintf(), it is necessary to add
> _GNU_SOURCE definition in all selftests including kselftest_harness.h,
> otherwise, there will be warnings or even errors during compilation.
> There are already many selftests that define _GNU_SOURCE or put the
> include of kselftest_harness.h at the very beginning of the .c file, just
> add the _GNU_SOURCE definition in the tests that have compilation warnings.

That asprintf() continues to cause problems.  How about we just remove
it? Do the malloc(snprintf(str, 0, ...)) separately?

