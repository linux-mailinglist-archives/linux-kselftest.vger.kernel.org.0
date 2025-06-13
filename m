Return-Path: <linux-kselftest+bounces-34926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BEAD93C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B1C1BC2DF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39FA223DC1;
	Fri, 13 Jun 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/AF6hBD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29120F079;
	Fri, 13 Jun 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835714; cv=none; b=ZLAYEGZ1tIPnW4M7vno7Sg0q7F2NdNaUh7ccmM8r8Xn8ClndKaH/+/oPVUx/7dLAmfjsE4TExgFsW2dCcarvGrkHO9bjgdcw93KusnTThhayjfsRn4P/5EXZQe9IXy6vy6gned4wNbVUYlQUWCI64h4Oxo/WmkfeIufpyxedwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835714; c=relaxed/simple;
	bh=oRxsJ/HGkpTXHDXprwByueHSfQ8saJgCOZDstd/VEaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYzbKG4OtBNKpRamJnOUaIcmPPZHuIRBJcR98HqwscIHooSROH9wWXsu23F5M9c5CjLJ+0HJoyZ+fPDjAH8GHY3pBt8oqR1dTqRCr/4glETs8ukzfVXCk37JAqtOYSeie3sFooTLSM5oj9gs9omviGxMiIqdqJstp5/h/UVxD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/AF6hBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A1C4CEE3;
	Fri, 13 Jun 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835714;
	bh=oRxsJ/HGkpTXHDXprwByueHSfQ8saJgCOZDstd/VEaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h/AF6hBDAPMF5II/x3wQTcaEVlqcj3bKm7vmydJDy1MDwId5awvHyQ4TtPtx6BoFu
	 BQjDZ8P7ECc9Ida/VmrqvI7rS6HdelYop4AHLP2ZZrPDHfwbBykGO+dvY2XxSJ0lol
	 4WfUh+/Mwv0/6wGkhGv9P44DMow3NQKv1ft1aPcTDWQJMfAY6ePX/KZB75F5tsomGQ
	 WF35FVBa2x9TS/821ygPo6cUe0/VG2RnDODj9XLGz3vjdI/pTPxO0XtdaF046Vn/8n
	 u/VZ1POprMPDUYybBfkyExT+/XAiT2ukSQ9szT8341a7orsX1vt1z3tyIJV9N0Abaa
	 iDaNmJYUkSZMQ==
Message-ID: <ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
Date: Fri, 13 Jun 2025 19:28:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1749757582.git.petrm@nvidia.com>
 <78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
 <20250613095755.54381628@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250613095755.54381628@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub, Petr,

On 13/06/2025 18:57, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 22:10:48 +0200 Petr Machata wrote:
>> Add tests for MC-routing underlay VXLAN traffic.
>>
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - Adjust as per shellcheck citations
> 
> Noob question - would we also be able to squash the unreachable code
> warnings if we declared ALL_TESTS as an array instead of a string?
> IDK if there's any trick we could use to make shellcheck stop
> complaining. Not blocking the series, obviously.
> 
> CC Matthieu, I presume you may have already investigated this :)

Thank you for the Cc. Yes indeed, I already had this case.

I don't think declaring ALL_TESTS as an array would help for this case
-- even if it looks clearer than a long string -- because I think
shellcheck will simply check if all the different functions are called
directly. As mentioned in Shellcheck wiki [1]: "ShellCheck may
incorrectly believe that code is unreachable if it's invoked by variable
name or in a trap. In such a case, please Ignore the message".

That what we did with MPTCP, see the top of the mptcp_join.sh file for
example [2], where we have:

> # ShellCheck incorrectly believes that most of the code here is unreachable
> # because it's invoked by variable name, see how the "tests" array is used
> #shellcheck disable=SC2317
If you add this at the top of your new file, followed by an empty line,
shellcheck will ignore this issue for the whole file.


Note: regarding the other issue you have:

> In vxlan_bridge_1q_mc_ul.sh line 766:
> setup_wait
> ^--------^ SC2119 (info): Use setup_wait "$@" if function's $1 should mean script's $1.

I guess you can also ignore it, or use "" as argument. If you ignore it
-- which looks cleaner -- I think it is always good to add a comment, e.g.

> # shellcheck disable=SC2119  # arguments are optional, not needed here.
> setup_wait


[1] https://www.shellcheck.net/wiki/SC2317
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/net/mptcp/mptcp_join.sh#n9

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


