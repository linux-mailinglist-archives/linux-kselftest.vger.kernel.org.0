Return-Path: <linux-kselftest+bounces-48559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C69D0650A
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 22:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2233029D16
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9D337B86;
	Thu,  8 Jan 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b8QOh+mY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF4336ECE;
	Thu,  8 Jan 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907732; cv=none; b=Ax+8IX6IVZ5x4t8J2E4ubN0z0bna5r6/G66gs3mHiAPw25o6APAHbowIOjLVcSFNJ2IQOSx+BgfNdnQojX6PXOa/XoVJTtnMx66oeHZ4gfz3Oj5ujZOWIxwnrS2TAnQLJPa3zrzkv1uBSwQ40AOaYtMWgRNdA3JYwURw6W0qCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907732; c=relaxed/simple;
	bh=nQwKD5GkV//Z8D4OWEudEfPuww3mHD9u3zSANae+Gms=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ilz3raEEQ82agFRj87EahBfvm4wfWUIFqBFvnDPokHcPc2rMOsC9tDfYPdl8E3DaOcHSTbmRgDu/BgtjrYcl0axUEzBS3cI7eIkGB4b6FWvirNexOHYywjevOtAPZ/vQTz6Y+1UZOzYjqiomwC5N5F2+imDRAhGXEajR1Bxk1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b8QOh+mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2ABC19421;
	Thu,  8 Jan 2026 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767907732;
	bh=nQwKD5GkV//Z8D4OWEudEfPuww3mHD9u3zSANae+Gms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8QOh+mY/lUlw15paCcPsXhQa9G2Q64vnD465C/TmnlZmJOSgDbJ2UVzqgHtP4GKA
	 RwM9PgZFfl29Dn/qy8WqHHhdoJVG6Q4U1dhpseM0utFcsotwB4uO3aQfvO1S0BQgzd
	 /K502UcXbROCfTqOA71Qgqj7sMD+rdaR+GWjZE+w=
Date: Thu, 8 Jan 2026 13:28:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: fix relative path
 handling
Message-Id: <20260108132851.bb6b7813277a5b40ba3aec8f@linux-foundation.org>
In-Reply-To: <20260108031604.12379-1-sun.jian.kdev@gmail.com>
References: <20260108031604.12379-1-sun.jian.kdev@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 11:16:04 +0800 Sun Jian <sun.jian.kdev@gmail.com> wrote:

> run_vmtests.sh relies on being invoked from its own directory and uses
> relative paths to run tests.
> 
> Change to the script directory at startup so it can be run from any
> working directory without failing.
> 
> ...
>

hm, why?  Is that a thing people actually do?

Is anyone going to actually test this feature?

> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -5,6 +5,10 @@
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>  
> +# Ensure relative paths work regardless of caller's cwd.
> +SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
> +cd "$SCRIPT_DIR" || exit 1
> +

Alternatively we could check that we're in the correct directory and
error out if not.


