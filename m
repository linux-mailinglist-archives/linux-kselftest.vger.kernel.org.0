Return-Path: <linux-kselftest+bounces-16562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0E962D9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA2F1C23B62
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E1A2C0F;
	Wed, 28 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN6muLzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B81DFEF;
	Wed, 28 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862406; cv=none; b=FuJ8DPp89R2e9jrLpZEm7xdjSg2otw2B9szxDJ+cLL9fIyNXDiP6SY4oaOn5/gLcOg35m5+8p0+L9QvViWsjmbGUCgpb84/N7gJe68Xh7YhZEbM8t/Lm32EbX9hxBH4LRyVQkCpSyAtMCeNMwGkRDxiNBMHda402lunwh8R14n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862406; c=relaxed/simple;
	bh=6joG1ah+F9oA9+x2jKor8l69Mf7Dd9hG4wWcxTYi8/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpamfyGex1TT1m3dksQRbywkKWOS4njZ4wjbna2Yq785ih0N5mXVWUs8MH5dTkVV+8naQgz0No8UCDWjr/CVycXxPfBK2CHtvb9JgR3epPlew6eq2VZ8UJjCYz7G0au2tO57R6qd0M7G3fpSA5hiD/EtPKO1/vccIZvc1NfgE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN6muLzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D9BC4CED6;
	Wed, 28 Aug 2024 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862406;
	bh=6joG1ah+F9oA9+x2jKor8l69Mf7Dd9hG4wWcxTYi8/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SN6muLzj+XWpv5z5Dc0ehvj12rsj3jd4iXyWxmIdQwN+s33G1ArrI79pno5wRgK0z
	 YRJ4P18M2KTqiQtF+bGwQt5AKHQ7FWCNDTqzKi5rL+bpyPjBumCgQdAgpQs4bxQWgQ
	 NW8WPjy1MRCNm089AzGSBS9YwnfJdGGzWLhRBTD0WQi/FssF7V/ysrLvz/phA/fEE/
	 lmIfEOl5YPG29hkbv3rDiI+d+o56NWdaP2rsxtaChuOKDkuIk7IYeqQQDdMHKVJQ1k
	 8zvZMHLMcsKCxOVET2xVpe4EPU8c7S8vSilU4zVSlDVZIQpwIDxd5RZmszmCB7hPcM
	 NVA8aIjDQUqaw==
Message-ID: <741ffe46-f0a4-467f-8f3b-d510c752b2bb@kernel.org>
Date: Wed, 28 Aug 2024 18:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Content-Language: en-GB
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 ncardwell@google.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 fw@strlen.de, Willem de Bruijn <willemb@google.com>, martineau@kernel.org
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Willem, Paolo,

Thank you for this series, that would be great to have the CI validating
these packetdrill tests!

(Having the Netdev CI validating these packetdrill tests was part of my
suggestions for the discussion we will have at NetConf :) )

On 28/08/2024 16:03, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> Adding Mat(s) for awareness, it would be great (but difficult) to have 
>> mptcp too in the long run ;)

Thank you for having Cced me! Yes, MPTCP's packetdrill is still not
ready for upstream :-/

But we could eventually have a runner on our side doing the validation
of the MPTCP packetdrill tests.

>> On 8/27/24 21:32, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>

(...)

>>> A single script is much
>>> simpler, optionally with nested KTAP (not supported yet by ksft). But,
>>> I'm afraid that running time without intermediate output will be very
>>> long when we integrate all packetdrill scripts.
>>
>> If I read correctly, this runs the scripts in the given directory 
>> sequentially (as opposed to the default pktdrill run_all.py behavior 
>> that uses many concurrent threads).
>>
>> I guess/fear that running all the pktdrill tests in a single batch would 
>> take quite a long time, which in turn could be not so good for CI 
>> integration. Currently there are a couple of CI test-cases with runtime 
>>  > 1h, but that is bad ;)
> 
> Very good point, thanks! This is the third packetdrill runner that I'm
> writing. I should know this by now.. Let me see whether I can use
> run_all.py rather than reinvent the wheel here.

If you use run_all.py, you might want to merge this PR:

  https://github.com/google/packetdrill/pull/83

On MPTCP side, we run packetdrill using:

  run_all.py -t ${TAP_DIR} -l -v -P $(($(nproc) * 2)) ${PKTD_DIR}

For our case, it is easier to generate the TAP output in a different
directory, but I guess that could also be part of the standard output.

Also, if we have to limit the number of tests being executed in parallel
with -P, to reduce the instabilities.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


