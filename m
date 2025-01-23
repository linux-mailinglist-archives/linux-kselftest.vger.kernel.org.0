Return-Path: <linux-kselftest+bounces-24991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABFA1A1CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 11:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1696A7A21A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC520D518;
	Thu, 23 Jan 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjircbjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6E20C472;
	Thu, 23 Jan 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627993; cv=none; b=toHh4yuRdwT5rEK6B1aoGopjHoLno/AKz/fILo+WPJBOV3wBZNZCUQ/7Y2Uuql0QbAfYAWCk+GJRmBjgxo65xSwFWnq8UOKOWMz0M1evHeDdssI9UJEOgEFFFhAmZB5fmUS0SfoKOcS0/+GdQXhnZOqa36r+aLO+2kSjNyNWJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627993; c=relaxed/simple;
	bh=BqRZR+7Y7rSeO4LNNmDsfSt2O/GY348iQhI5BPtj1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbLE4cuPJ5Zs2aqiHzBqzhA8V8Zcvp24fmXdoEfj9I3dxjCthL8LHwSsLxyu83Kn40ApsjG7fQNz0IM4Ce7KzPTHVjUZ/czlvhUXxazNuq9u0kRB0gY2UORW3K4bkjYIGcJtK2LqF3Fz/+YfUYfW6ah9D7vmlBjHEQ1XnZTqs6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjircbjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06F4C4CEE1;
	Thu, 23 Jan 2025 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737627992;
	bh=BqRZR+7Y7rSeO4LNNmDsfSt2O/GY348iQhI5BPtj1x8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjircbjgtul1fSMMKzWV+9o8M5kXZwKHIgf46ORtN2fHsh8xu6jKhuEJkpDZc/4r1
	 hzw+D0TY2Vawz0gjF+WhmmMuIJU92J180ClFgvlrNKWhIZ8OGlUK9FQTgfMK1+NERH
	 dtv6b3zxlAVi7LPN0q1tB2TCTjJZLpI3bE3f1cHNDDQp41346j+tbXZSmcUUMS8Oov
	 ktU+wiHqwF+aElv+VzCABL0xtkHq3S8Y9WQHvrHK5hfO2Vc/2Dl8ySapY7nBxaeOOZ
	 a1WiQXcgCEkrK8o4vsrK+vyiil6mvVFyTm5gXBkKIux3NedUUq0yGa22N+Sy9Aesbt
	 Q/XJUHKQp+34A==
Message-ID: <8ee5ad75-c550-4559-b46f-e511767b3302@kernel.org>
Date: Thu, 23 Jan 2025 11:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Content-Language: en-GB
To: Hangbin Liu <haliu@redhat.com>, Jan Stancek <jstancek@redhat.com>
Cc: martineau@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora> <Z5IBPOGvfPozjrl5@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <Z5IBPOGvfPozjrl5@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jan, Hangbin,

(-cc <eliang@kernel.org>: wrong address apparently)

On 23/01/2025 09:43, Hangbin Liu wrote:
> On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
>> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
>>> Package build environments like Fedora rpmbuild introduced hardening
>>> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
>>> and LDFLAGS.
>>>
>>> mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
>>> to a mismatch and build failure, for example:
>>>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
>>>   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
>>>   /usr/bin/ld: failed to set dynamic section sizes: bad value
>>>   collect2: error: ld returned 1 exit status
>>>
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>  tools/testing/selftests/net/mptcp/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
>>> index 8e3fc05a5397..9706bc73809f 100644
>>> --- a/tools/testing/selftests/net/mptcp/Makefile
>>> +++ b/tools/testing/selftests/net/mptcp/Makefile
>>> @@ -2,7 +2,7 @@
>>>  
>>>  top_srcdir = ../../../../..
>>>  
>>> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>>> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)

Thank you for the fix, it looks good to me too:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>>>  
>>>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>>>  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
>>> -- 
>>> 2.43.0
>>>
>>
>> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Hmm, net-next is closed. Not sure if we can target this to net since it fixes
> the build errors.

I think this should target -net. It should then have a Fixes tag (and cc
Stable). Not sure if we need to backport that all along. Maybe enough to
use the following one, because I see it fixed the same issue in net and
tcp_ao:

Fixes: cc937dad85ae ("selftests: centralize -D_GNU_SOURCE= to CFLAGS in
lib.mk")

BTW, I guess you will need the same fix in
tools/testing/selftests/net/lib/Makefile and
tools/testing/selftests/net/openvswitch/Makefile.

@Jan: Do you mind fixing them too please? Also, please next time add the
target in the subject, e.g. [PATCH net], see:

  https://docs.kernel.org/process/maintainer-netdev.html

@Netdev maintainers: this can be applied directly in -net, no need to go
through the MPTCP tree first. But it can if you prefer me adding the
Fixes tag.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


