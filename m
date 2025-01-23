Return-Path: <linux-kselftest+bounces-24998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D030A1A491
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BA77A1928
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5920E6FC;
	Thu, 23 Jan 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWYPuEkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756CD20C492;
	Thu, 23 Jan 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737636700; cv=none; b=gX1s+1QLUszctAJaZryBYVV/t42vacRRwCBMPaoUZfNvPYHjb7tZnD2Sr75d5dEBWlhklYamcXvV9/lb9w+waTGUmwunwDJkjjQDAX3tk8UAKQGCVJjyXve5sCDT4S9XsWSn7Js3iNoIGP05cOSBlsg+YOoGzKTXNzUnalD7uGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737636700; c=relaxed/simple;
	bh=iyuhhFYuuwZWkhs0Pb1PUjeLATyLrHTTa1AhyAXXdLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/93tEkV9rFVSYwTqmefxe+BDoZNolmdpUyDC/8i8UF6n1eTLayvbZVCwcmRAANz85Au2g/NFwFHoBhBDCXoNNXHatQiUTxGznzQUfpVvwhDjot27ISICyewDjSVTvU2BPpMseH+XRQX0QclY8VFCw7pNS+Sg5kn0DcpmyIZBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWYPuEkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D6EC4CED3;
	Thu, 23 Jan 2025 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737636700;
	bh=iyuhhFYuuwZWkhs0Pb1PUjeLATyLrHTTa1AhyAXXdLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LWYPuEkZPJu3U/daeZzYuj9GDuDQ6Snkts/a7ATihnfXLnCfg3hu4hl8adCrGJyag
	 GB0MDqTd3BshWkLWBXlQMEBKOqD1D73mqbQqP5VwUdi8v8Ro9QyQjFabEJwgXP+ecH
	 UTSZVhgYhZEciebb3cckRY6pRtlk/uKC+5YptL9hNl1klgLJKJX9287xJ5LNygqP/g
	 zFXNquY5sy2epg5z73y0u/yxu82eaqyQmiZZDOxrAbAkA7Bz/hAXZc++9EQbW4iIB/
	 kcHVF1+vrPJhEpIUTJ8JInIaQYscLf9vLZ/rcIZY5ZnqfLYFkrCdDxr6+baZl/M1EJ
	 QNq7pCaX6G3sQ==
Message-ID: <26ad0900-bd9d-464e-be9f-c1806b96c971@kernel.org>
Date: Thu, 23 Jan 2025 13:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] selftests: net/{lib,openvswitch}: extend CFLAGS to
 keep options from environment
Content-Language: en-GB
To: Jan Stancek <jstancek@redhat.com>
Cc: pshelar@ovn.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, liuhangbin@gmail.com,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <3d173603ee258f419d0403363765c9f9494ff79a.1737635092.git.jstancek@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3d173603ee258f419d0403363765c9f9494ff79a.1737635092.git.jstancek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jan,

On 23/01/2025 13:38, Jan Stancek wrote:
> Package build environments like Fedora rpmbuild introduced hardening
> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> and LDFLAGS.
> 
> Some Makefiles currently override CFLAGS but not LDFLAGS, which leads
> to a mismatch and build failure, for example:
>   /usr/bin/ld: /tmp/ccd2apay.o: relocation R_X86_64_32 against
>     `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIE
>   /usr/bin/ld: failed to set dynamic section sizes: bad value
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/lib/csum] Error 1

Thank you for the fix!

> openvswitch/Makefile CFLAGS currently do not appear to be used, but
> fix it anyway for the case when new tests are introduced in future.
> 
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")

Note that this commit is only for the Makefile in 'lib', not in
'openvswitch', but I guess there is no need to backport that all along.
Maybe the two modifications should be split, but I guess that's fine here.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/testing/selftests/net/lib/Makefile         | 2 +-
>  tools/testing/selftests/net/openvswitch/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index 18b9443454a9..578de40cc5e3 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g

(small detail: I guess the double whitespaces after the '=' were there
to keep the alignment with the next line, so probably there should be
only one now, but I don't think this alone is enough to ask for a v2!)

Apart from that:

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
>  # Additional include paths needed by kselftest.h
>  CFLAGS += -I../../
> diff --git a/tools/testing/selftests/net/openvswitch/Makefile b/tools/testing/selftests/net/openvswitch/Makefile
> index 2f1508abc826..1567a549ba34 100644
> --- a/tools/testing/selftests/net/openvswitch/Makefile
> +++ b/tools/testing/selftests/net/openvswitch/Makefile
> @@ -2,7 +2,7 @@
>  
>  top_srcdir = ../../../../..
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
>  TEST_PROGS := openvswitch.sh
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


