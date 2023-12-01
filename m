Return-Path: <linux-kselftest+bounces-953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9628008F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC21C20BA4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE420B3E;
	Fri,  1 Dec 2023 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="mcWH1h3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83310D7;
	Fri,  1 Dec 2023 02:49:44 -0800 (PST)
Received: from [10.28.30.211] (ubuntu.user.uliege.priv [10.28.30.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 31AD0200CCF5;
	Fri,  1 Dec 2023 11:49:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 31AD0200CCF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1701427782;
	bh=yqTmpjxC+vmCiRMzZ6JjEUlZ7fEf3rMCw5yimOIcRAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mcWH1h3tptTWBjigd9kGih1J5RsKH/tfPJFzy4ad2ULxaNrvkFCCSZ0rw4RRKobJv
	 Aibh1OpWzT7s4ocFMTF9q4QD1zgkqEBuGHklelIm0fWrsH6sAe0zQMMLzSiK2RQjb8
	 qmG1U6d2eL/NEqWTKDmjMevD5Cjo79QM3jEw8lc12U0pBm6S9jRQTj0/19723e6p9d
	 IUxCfjmhx1w+caXR92fIAUyAxdUMaMDsBNRlwajCa5cDJ2Z8HaiFohjblN9aIobkIx
	 pyePFpoTApHCMCbUSbk5onJ1flTksOljZ7rEtKs8Y7SRe4NzEwifhyThXrZToQQi17
	 C6QcNFQmIkIUw==
Message-ID: <699fb67c-efb4-4fc9-bf18-a2ddeffbcdb7@uliege.be>
Date: Fri, 1 Dec 2023 11:49:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 10/14] selftests/net: convert ioam6.sh to run
 it in unique namespace
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
 Po-Hsu Lin <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>,
 Petr Machata <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Francesco Ruggeri <fruggeri@arista.com>, Xin Long <lucien.xin@gmail.com>,
 justin.iurman@uliege.be
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-11-liuhangbin@gmail.com>
 <4ab6e843-fd60-4abf-a23f-c8032e617f5c@uliege.be> <ZWmAk9637Oo4HYOU@Laptop-X1>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <ZWmAk9637Oo4HYOU@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 07:43, Hangbin Liu wrote:
> On Thu, Nov 30, 2023 at 02:28:51PM +0100, Justin Iurman wrote:
>> On 11/30/23 05:01, Hangbin Liu wrote:
>>> Here is the test result after conversion.
>>>
>>> ]# ./ioam6.sh
>>>
>>> --------------------------------------------------------------------------
>>> OUTPUT tests
>>> --------------------------------------------------------------------------
>>> TEST: Unknown IOAM namespace (inline mode)                          [ OK ]
>>> TEST: Unknown IOAM namespace (encap mode)                           [ OK ]
>>> TEST: Missing trace room (inline mode)                              [ OK ]
>>> TEST: Missing trace room (encap mode)                               [ OK ]
>>> TEST: Trace type with bit 0 only (inline mode)                      [ OK ]
>>> ...
>>> TEST: Full supported trace (encap mode)                             [ OK ]
>>>
>>> --------------------------------------------------------------------------
>>> GLOBAL tests
>>> --------------------------------------------------------------------------
>>> TEST: Forward - Full supported trace (inline mode)                  [ OK ]
>>> TEST: Forward - Full supported trace (encap mode)                   [ OK ]
>>>
>>> - Tests passed: 88
>>> - Tests failed: 0
>>>
>>> Acked-by: David Ahern <dsahern@kernel.org>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>
>> Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
>>
>> LGTM. Just one question though. Is there any reason not to use cleanup_ns
>> everywhere? There is the following diff (actually, 3 times):
> 
> Hi Justin,
> 
> Thanks for your review. There is no much intend. I just use del ns for one
> line change. And use cleanup_ns for multi line changes. I can make all
> ns delete via cleanup_ns in next version.

+1, I think it would make sense to use the new API everywhere for 
consistency.

> BTW, I will use `cleanup_ns $ns || true` in next version as cleanup_ns
> could return none 0 in PATCHv2.

Sounds good, thanks!

> Thanks
> Hangbin

