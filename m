Return-Path: <linux-kselftest+bounces-47721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CFCCDFC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 00:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE4630E474C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A02F8BEE;
	Thu, 18 Dec 2025 23:30:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E02D323D;
	Thu, 18 Dec 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100658; cv=none; b=KL/nNSpkcNgiroc5ehO725KsbAXGBmqzM+VfNgnqwI/jDZVHenzvLQUvx0Z1V+SMZjLDk7MIyEdoAUMn+BOqau7ATVBTjsqkOv8uMmxQ4PKAL3mFg80NMf87Jc7BU6vhgye4Wh0XAbM6nZBwU+80PgkrW+JRh5LJr5FRVUrvQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100658; c=relaxed/simple;
	bh=eGFZaTtclsxsQS4o39LSV8PZT3QVh0tn85GzPvl6eV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcBGCkmRz4FH5NAO45P6xqwdnxcj2wD4rCcCZaoh3yKXNZbTaBV//W8jUt4ry9UDfG1EPw1kjBYWe+D++CeSsTVg8QKuAU5g31mmdqpr8HJH5CsI819TLKC4XQzfhgxi96jzXwUdcB0I27TbrQFtkpF8FzWhZ95a21zeQ1PDhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D9051C0173;
	Thu, 18 Dec 2025 23:30:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 0D54D20024;
	Thu, 18 Dec 2025 23:30:46 +0000 (UTC)
Date: Thu, 18 Dec 2025 18:32:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thibault Ferrante <thibault.ferrante@canonical.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add test dependency
Message-ID: <20251218183226.6ada2ec0@gandalf.local.home>
In-Reply-To: <20230614105031.13543-1-thibault.ferrante@canonical.com>
References: <20230614105031.13543-1-thibault.ferrante@canonical.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u3a1qxs51s6n76mbxhid8ckf3kx7a77q
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 0D54D20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+QK2SHtCU+nytH6RlcfFlst+ekXBmNHpM=
X-HE-Tag: 1766100646-589045
X-HE-Meta: U2FsdGVkX1+V9LIcXeDKa1usnBm7NRdURbJdU/PQ2IX6Gz0RLOTsaTQheOcSEHmQtbW9+e5voj+qo4dktvLZzqVLB7RMGSPW8GSc5dOKebx4uP0nNexaPtX5B9zZfXrDNGEaMRVZ3+OoGJ/iDBBTC1nxb9IXgAp6fiENcue1/OPDxmxjQuBbtQqC1gtWL/cgnhgJjh3k00ryckzsl4Lef50ipzTjTOTklzUsWZ4MgaFFcWQ+NKnerOtp8x87KVvmt+o7xWG7PbplJryJ0CKNGDuK7ffahGN6xe9DVkWhgGWW/UOmyU0h2BcptRxUspS6kqHVhkQTzJhh5NQ73ODsqpKd5RVwCVLh2D0GJWgXfT/HTK06dAzwc0uA7S1aMmoRkhUEdRDZw4J19+7PWnaaM8p3V1qbm5iC

On Wed, 14 Jun 2023 12:50:31 +0200
Thibault Ferrante <thibault.ferrante@canonical.com> wrote:

> test_duplicates miss a running dependency and leads to test failures
> on kernel with specific configuration.
> 

Found another old patch. But this one still needs review.

Masami, does this look good to you?

-- Steve


> Signed-off-by: Thibault Ferrante <thibault.ferrante@canonical.com>
> ---
>  .../testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> index d3a79da215c8..0b5e4543e70b 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - check if duplicate events are caught
> -# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
>  
>  echo 0 > events/enable
>  


