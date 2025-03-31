Return-Path: <linux-kselftest+bounces-29961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27618A76DDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 22:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488D23AAB76
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FA21517E;
	Mon, 31 Mar 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p7xFmnsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D626AF6;
	Mon, 31 Mar 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451456; cv=none; b=fLZoGvHIPZEpqvuMTi2cwxiY/upv4faoxlwToS37PUfDXjuq9G/j/lnjsKoQUtw1kQF6q+8vRaJPv3r/iHKIOMZ1Fxu0PXMFZsokCLh0qnf1GxO3byrrxAxJXay48aP54xHNyIGS8D8CgbMB95B9Y9+yWez0uKmJvV3TW9F1y54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451456; c=relaxed/simple;
	bh=NqtQdTTKBk90PE6rOvmIiG6SuLyKZuY/iKiGQK5aPzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/ax7MqkEUrtVxOkW6RCHC9KVcU5/JbInQsTWCgsUN2GvhuaH8zO4e/1I+bCm3P1RQDYyRkqPxBuUmB9Zjt7i1wqZ/e5XIAKoYJd9itecY55aTgbp3g+JJEaP9x4Q2m0erJCqLhfjjsSJaPyhPMffWiqT/CBtutM0dpzhwc/koY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p7xFmnsw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42BE7210237F;
	Mon, 31 Mar 2025 13:04:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42BE7210237F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743451454;
	bh=XJ3cM3fyOzY7C4trpXWA3EuNua3sgvIg+XAA9hZ/OFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p7xFmnswoUHz+XdMufJMEpyfgvmZqESS1BFeAQ6xLjy2deSBmYumgYo3pbZMX1XLm
	 0fe5BMwk1AM0TVr3OsCkt51s6d699+sxxml52LdZp1kDm7LiDQPWOQDeB/kMvXe8Uk
	 D4Dl4BkmVAckQkheMYpHa+IbwwlUu8slKPjIdfQw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Mick?=
 =?utf-8?Q?a=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Nick
 Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 3/4] hornet: Add an example lskel data
 extactor script
In-Reply-To: <Z97yiwQwzHmVy2p9@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-4-bboscaccy@linux.microsoft.com>
 <Z97yiwQwzHmVy2p9@kernel.org>
Date: Mon, 31 Mar 2025 13:04:02 -0700
Message-ID: <87a5916k7h.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Fri, Mar 21, 2025 at 09:45:05AM -0700, Blaise Boscaccy wrote:
>> This script eases lskel developments against hornet by generating the
>
> 1. What iskel?

It's a "light-skeleton". I'll remove the abbreviations from this
patchset's commit messages. The jargon is hard enough to grok as-is. 

> 2. Why hornet is here in lower case?
>

Typo. Thanks for finding that. 

>> data payload used for code signing. It extracts the data out of the
>> autogenerated lskel header that gets created via bpftool.
>> 
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  scripts/hornet/extract-skel.sh | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100755 scripts/hornet/extract-skel.sh
>> 
>> diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
>> new file mode 100755
>> index 0000000000000..9ace78794b85e
>> --- /dev/null
>> +++ b/scripts/hornet/extract-skel.sh
>> @@ -0,0 +1,29 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (c) 2025 Microsoft Corporation
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of version 2 of the GNU General Public
>> +# License as published by the Free Software Foundation.
>> +
>> +function usage() {
>> +    echo "Sample script for extracting instructions and map data out of"
>> +    echo "autogenerated eBPF lskel headers"
>> +    echo ""
>> +    echo "USAGE: header_file output_file"
>> +    exit
>> +}
>> +
>> +ARGC=$#
>> +
>> +EXPECTED_ARGS=2
>> +
>> +if [ $ARGC -ne $EXPECTED_ARGS ] ; then
>> +    usage
>> +else
>> +    printf $(gcc -E $1 | grep "static const char opts_insn" | \
>> +		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') > $2
>> +    printf $(gcc -E $1 | grep "static const char opts_data" | \
>> +		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') >> $2
>> +fi
>> -- 
>> 2.48.1
>> 
>
> BR, Jarkko

