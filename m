Return-Path: <linux-kselftest+bounces-21190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231449B716A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 01:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD013B2122D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152A2BCFF;
	Thu, 31 Oct 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkrp1YEU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A622083;
	Thu, 31 Oct 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730336264; cv=none; b=tnG/hzsmmIRqGwebjhpYIzvALHA4NnsXh/Qivu/m+VOPrPkPfcjfbnnypXN9WEFmBvriiHcz19kR2NFzGpG6f0JBf+lHHfoQbtqg+pZOKIEHSw3pJur87m39ANvk4vx6If5Bu85B3WpfJZ13WaYod/fR7dywS7ui19Ku+U5z+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730336264; c=relaxed/simple;
	bh=a1c+CixD3ltK8J9yydPx3kFnyoohImJk2rDJGGK5ck4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qC/N+UOwPRlAob9EPO4Vkj89t0yhMqUxrj+qsuBCdD3CV5dw8A+J5dobw0end1hAvqMex+9zQZ+mJ2ehCWsCw/FK/v6NLJBN/5aB8AQrA4hdNVJF5H+XrB74wpvzJ6vbt5/u5Ra4IoUYX/MI3JetbCkyp8/ABsC2k9D/4oHUkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkrp1YEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2B6C4CECF;
	Thu, 31 Oct 2024 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730336262;
	bh=a1c+CixD3ltK8J9yydPx3kFnyoohImJk2rDJGGK5ck4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rkrp1YEUC8blhl7m8p6GcsDhe1M+pGYijx2mPSXcwi9grOsXJXe5p1Aa2DD4oNHv3
	 WFNVquOIIx+RS1pyJum0Xmk/QHmz/8YcEFh7SwchN16hMiUak6PVYSnBOn402ehCrV
	 66kmXPEvqQ6Etu38APYKVqLH67gRLwJCKcTuIiZSvj1nEOwd5klxbbtbrULNC7T/3Q
	 /sYqhqbAUnVxJv3NuP915ZQtVW8RJd9keuI6riru6i6Sp7cv6A8wQTw7oYHvEC4IUk
	 443tUoj2iypT3+MuN4Rqu1V5aZQJLXPNz6zCiI9t/hpcqfYSDpFK7MSWUSbSDCjjT+
	 aU+ea9abvaLcw==
Date: Wed, 30 Oct 2024 17:57:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@Oracle.com, edumazet@google.com,
 pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 akpm@linux-foundation.org, brendan.higgins@linux.dev, davidgow@google.com,
 rmoar@google.com, johannes.berg@intel.com, mic@digikod.net,
 gnoack@google.com, jk@codeconstruct.com.au, kunit-dev@googlegroups.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v6 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <20241030175740.49dc3e9f@kernel.org>
In-Reply-To: <20241023162006.1725309-2-anjali.k.kulkarni@oracle.com>
References: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
	<20241023162006.1725309-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 09:20:04 -0700 Anjali Kulkarni wrote:
> Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
> thread to notify the kernel that is going to exit with a non-zero exit
> code and specify the exit code in it. When thread exits in the kernel,
> it will send this exit code as a proc filter notification to any
> listening process.

While we wait for someone who knows about process management to review
this - could you please split out the whitespace / checkpatch cleanup
changes to a separate commit? They make the change harder to review.
-- 
pw-bot: cr

