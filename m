Return-Path: <linux-kselftest+bounces-29611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2324FA6CBAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946CD171E29
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A27233737;
	Sat, 22 Mar 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKc6cP3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998581F55EB;
	Sat, 22 Mar 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664335; cv=none; b=sT8HpVTMH875pB4qBN8yVYJcwCFHNMJtS2qjwvHcBZbR/8Cyo7mWtXE6Owjs9E7SgiqWJjfAZVZWjei/gTCQ4Gplsizoew+34JBZbVq3x/wdMVKSMBu+CR43NMpDdcO4UuWULlLaYabpLiLHvWxkYmSZvRvob37KM7LHmt1ZqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664335; c=relaxed/simple;
	bh=bjDpxSKcnPu0+pzY23LNYW7pSEhfX3YSIpEfSZvb9sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opekfzYAPmT5Rbxt+dKPtGY8vMZs9uPr+TB0380eLgnLPrE2pbkRuPf7ATg/j2NJsXXDEUUquP3UnE6wnk5Vavv18IWwqvfDNnycCYc9xF05BfpFBPWdLVlN/P5YMPiosYw7ZgjFkeiTGWCkKgSam81ykfPM0e1nbChp8t3FTz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKc6cP3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84907C4CEDD;
	Sat, 22 Mar 2025 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742664335;
	bh=bjDpxSKcnPu0+pzY23LNYW7pSEhfX3YSIpEfSZvb9sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKc6cP3Nl35qxWAUTOE15kH6VX6SRBGiDe30WmISTRAspYjVvccVwIYZ4nz1eycsu
	 5urS4MTxNWCvBQSv3agXlCpNtMGxFZfVaJf1kIaGdtY4+il7HxGtTHJ7OeoyNyP7Fq
	 qVDNrIBHorIhw5jCreteU874jxpv/3RjP7Vu/DaeOJlOwEjdo9XTGbuvJQfkXSjBxW
	 x8iscSTAilJVFRoJDhTZwgsSBMpHsuDJmQYFdl8h/r9wH/WWuxEgjVVmVnwsww3eyJ
	 uD0OlS47bANRUpnY1lUrpK+a4HVaMURAAn9LWqchboM6IX4MXZALoIM7Pz3lwaALDG
	 SrEVBm0r48yDQ==
Date: Sat, 22 Mar 2025 19:25:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 3/4] hornet: Add an example lskel data
 extactor script
Message-ID: <Z97yiwQwzHmVy2p9@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-4-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321164537.16719-4-bboscaccy@linux.microsoft.com>

On Fri, Mar 21, 2025 at 09:45:05AM -0700, Blaise Boscaccy wrote:
> This script eases lskel developments against hornet by generating the

1. What iskel?
2. Why hornet is here in lower case?

> data payload used for code signing. It extracts the data out of the
> autogenerated lskel header that gets created via bpftool.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/hornet/extract-skel.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100755 scripts/hornet/extract-skel.sh
> 
> diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
> new file mode 100755
> index 0000000000000..9ace78794b85e
> --- /dev/null
> +++ b/scripts/hornet/extract-skel.sh
> @@ -0,0 +1,29 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025 Microsoft Corporation
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of version 2 of the GNU General Public
> +# License as published by the Free Software Foundation.
> +
> +function usage() {
> +    echo "Sample script for extracting instructions and map data out of"
> +    echo "autogenerated eBPF lskel headers"
> +    echo ""
> +    echo "USAGE: header_file output_file"
> +    exit
> +}
> +
> +ARGC=$#
> +
> +EXPECTED_ARGS=2
> +
> +if [ $ARGC -ne $EXPECTED_ARGS ] ; then
> +    usage
> +else
> +    printf $(gcc -E $1 | grep "static const char opts_insn" | \
> +		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') > $2
> +    printf $(gcc -E $1 | grep "static const char opts_data" | \
> +		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') >> $2
> +fi
> -- 
> 2.48.1
> 

BR, Jarkko

