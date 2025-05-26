Return-Path: <linux-kselftest+bounces-33795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE74AC4142
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE1169562
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68538384;
	Mon, 26 May 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGqh7FC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F37433AC
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269299; cv=none; b=K7G9XUxojTXia9sdMVOdyL2+v73xAgW2uifmAbxOUIu/nGJfM4nV5eHUGGGGYX6VAy/plKQSUXt4ezv3nGgEDmDFGTD3Ne+btLd39bUUsTU5mlAyqv7X5NPaO9ro69fTn+DwNmPTiZmd0m/XzRhTBLo7c/Kb30YHeew++4gnBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269299; c=relaxed/simple;
	bh=uKXhWPOILNcQquoiuD69dBT+Mmz/yWe+XilXIUZIOFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5fah+oXyFBSS94RC8YvUqKA+bRkE2mogwUkV+r3ihD5kGvqeoE+vDa8hHWd3d1vre+v3vWGb/pYiFXCqDdhBBy8fVwYvHpD36oT7YNNWNyWkj/x9iNRWZ0+WglenSSWExLgWNlbAD9unADdjEOeMsfBUCbiMwZvZurBbDQpjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGqh7FC2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 May 2025 16:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748269285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/56synuCCnJoxo5M+YtSLlSsLFpX8j3sUa2PtLr5C/U=;
	b=IGqh7FC2NcAjELjoBFhOeDtIIyeciLw2yEwMU43R7ItqYqYDw5KGQ3ZXLu6rP/nuctszPW
	k2q0WZFsNYFSNEP2edFk42EfD8Euun9yne0oW0Q3KvGEccceZAiQJ7Fuc1d7J6mZuLWu9a
	VRUzWkV9GhHQibbTditkhG2L9dQF8t4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 04/11] kbuild: introduce blob framework
Message-ID: <20250523-slim-dancing-mussel-c7a5f1@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-4-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kunit-kselftests-v2-4-454114e287fd@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 09:42:41AM +0200, Thomas Weißschuh wrote:
> Various subsystems embed non-code build artifacts into the kernel,
> for example the initramfs, /proc/config.gz, vDSO image, etc.
> Currently each user has their own implementation for that.
> 
> Add a common "blob" framework to provide this functionality.
> It provides standard kbuild and C APIs to embed and later access non-code
> build artifacts into the kernel image or modules.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> Due to its closeness to kbuild this is currently added to its MAINTAINER entry.
> But I can also maintain it on its own.
> ---
>  Documentation/kbuild/makefiles.rst | 23 +++++++++++++++++++++--
>  MAINTAINERS                        |  2 ++
>  include/linux/blob.h               | 32 ++++++++++++++++++++++++++++++++
>  scripts/Makefile.blobs             | 19 +++++++++++++++++++
>  scripts/Makefile.build             |  6 ++++++
>  scripts/Makefile.clean             |  2 +-
>  scripts/blob-wrap.c                | 27 +++++++++++++++++++++++++++
>  7 files changed, 108 insertions(+), 3 deletions(-)

Thanks, looks good to me and I like the design!

Reviewed-by: Nicolas Schier <n.schier@avm.de>

-- 
Nicolas Schier

