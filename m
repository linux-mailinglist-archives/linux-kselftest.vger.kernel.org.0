Return-Path: <linux-kselftest+bounces-15312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9949519EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A4A1C210B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AE1AED27;
	Wed, 14 Aug 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssByd1aw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA21420A8;
	Wed, 14 Aug 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635128; cv=none; b=fPNG3NBS8DnUj/+77ksT+KqSbYjVdqweT3SBH/vtyN2KtsaAJ4wnFxNS+9raaqb3d9NBiF2sKA8iF5Xe6B5zdknZOLBHI6f+LfehcY0aJSmSOYiKmbODMJyPFIqUwjtTCIXkCz/4s54hiPFUE4ELYwub5+6evtkyg2dCSB2i6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635128; c=relaxed/simple;
	bh=AWE3CobVL05Gs8NLBwN0sPmICHJ3iutsNZuS3OojKLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS46kgPWeUg6OeKrfKnPZNFekrGTMi+Br4UGLzf7uwUVFQD8hji2a3PwdMbLHvIHthXjvJYV4j9bTkZ671B6JNlUmMk/bKU9eKrnd0PbzT3BqL8H5fA5esCRW7V7yT7KcqncJ43/8jxysVfMK3nfqrnahLRHlaKTJf1U8UF3bQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssByd1aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE50BC32786;
	Wed, 14 Aug 2024 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723635127;
	bh=AWE3CobVL05Gs8NLBwN0sPmICHJ3iutsNZuS3OojKLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ssByd1awoSbcCzi7aTkTckxm+kJMN601gT9A9I0ycGleIO7LsS5QttvS3Bs1nP4qR
	 3ie3I216kNjnh8ZkRQs6JUpFjJdu6EpprWCVv4TntxzGkUDH1be5/RqWNNPmpFtlIQ
	 h8cne6kKlT2qc5TbHVX0zz/gFRSb5sxlRBWKC/nl0WfRfvegTz4cC1H0X4Afk2rsIm
	 7lqGqBFjzBQqNb62Z19eNe4Ipr2btSgyFr5gCbbPYrIzCiYOs+56lgCYoAWqNZyc/C
	 X24Nhnth36xuG7VOX8hmvaEDlMzKdFyQCTA14TgOxCmLlD+xef+F5dDmcG1P8OS8h2
	 s1anNbIwJn6cQ==
Message-ID: <af896c55-723e-4c2b-b153-132f863e2f68@kernel.org>
Date: Wed, 14 Aug 2024 13:31:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Content-Language: en-GB
To: Petr Machata <petrm@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 David Wei <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Geliang Tang <geliang@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
References: <20240813183825.837091-1-leitao@debian.org>
 <87r0arl5qw.fsf@nvidia.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <87r0arl5qw.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr, Breno,

On 14/08/2024 12:24, Petr Machata wrote:
> 
> Breno Leitao <leitao@debian.org> writes:
> 
>> Adds a selftest that creates two virtual interfaces, assigns one to a
>> new namespace, and assigns IP addresses to both.
>>
>> It listens on the destination interface using socat and configures a
>> dynamic target on netconsole, pointing to the destination IP address.
>>
>> The test then checks if the message was received properly on the
>> destination interface.

(...)

>> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
>> new file mode 100755
>> index 000000000000..e0e58fc7e89f
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
>> @@ -0,0 +1,223 @@

(...)

> +NAMESPACE="netconsns_dst"

(...)

>> +function set_network() {
>> +	# This is coming from lib.sh. And it does unbound variable access
>> +	set +u
>> +	setup_ns "${NAMESPACE}"
>> +	set -u
> 
> It would make sense to fix lib.sh. I think this is what is needed?
> 
> modified   tools/testing/selftests/net/lib.sh
> @@ -178,7 +178,7 @@ setup_ns()
>  		fi
>  
>  		# Some test may setup/remove same netns multi times
> -		if [ -z "${!ns_name}" ]; then
> +		if ! declare -p "$ns_name" &> /dev/null; then
>  			eval "${ns_name}=${ns_name,,}-$(mktemp -u XXXXXX)"
>  		else
>  			cleanup_ns "${!ns_name}"
> 
> CC'd Geliang Tang <geliang@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
> Matthieu Baerts (NGI0) <matttbe@kernel.org> who were in the vicinity
> in the past.
Thank you for having CCed me.

I don't know if lib.sh needs to be modified: setup_ns() is supposed to
be called with the name of an existing variable. Can you not define this
variable before?

I mean: the modification from Petr looks good to me to support 'set -u',
but it sounds safer to define the variable before in the script, just in
case it is defined by in the environment, before starting the test, and
not taking the expected path.

Note that in all the other selftests, setup_ns() is called with the name
of the variable, not a variable like you did, e.g.

  NAMESPACE=
  setup_ns NAMESPACE

instead of:

  NAMESPACE="netconsns_dst"
  setup_ns "${NAMESPACE}"
  NAMESPACE=${NS_LIST[0]}

Maybe better to do like the others?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


