Return-Path: <linux-kselftest+bounces-29505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29FA6AA10
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CE57AD5FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8DC1E520B;
	Thu, 20 Mar 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="qYYy6ATc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D216D32A;
	Thu, 20 Mar 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485133; cv=none; b=IzCZg0OUSvIS10xZzu56AivTBwnwfechb82cRT8/nPbIlouLeVn0dg/Z6LSXh5WzWRprWf+4qg035awrqxBOsHN1Othwrvtc4eb7o7477q55GM8//W5h8GWaCWBJmPEsTepGPF+ZHDCWtAKCQiqTdMz34wbPankkNrnYEf+6/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485133; c=relaxed/simple;
	bh=bHTpOPr0Qr9IRi66gSGrUsv2kE/+/kUDZiXydOP11Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teNqGl2AXt9fXu4tPq999gcV9HA1nxCpxbs7v38ANFgOXas8erGilcxInQPadWgl2zPCFryhu0muCVYTYN4MpKwr0jm5T9oH5r0Hu7MOb7IYfkjVmA9CTBXfvWYbVaa5TX4LH+hfMehsWWChFHVHPrtbMRdb6XpdPzkE5x37jWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=qYYy6ATc; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [31.133.152.62] (rtr-guestwired.meeting.ietf.org [31.133.144.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 227A4200E7B0;
	Thu, 20 Mar 2025 16:38:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 227A4200E7B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1742485123;
	bh=/1XwTreUtkK7nSNVCLq6SBcOLAvHZEXcUJh2tq7APek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qYYy6ATcxAeUtGhZGTqjVJZOMx05S0ByHqp1Zl4qUtCfypJQS3mn6qGnp5WOcjUcC
	 qi1U72nQXQswJ/+xM7+KPMa0U4fH2PWN6HRGtAgFFGMMdX8TEdcAudf2rQ1He7X516
	 IyJJixceQOfaje8pQ0QW+bUOTrdf8wnmssqCHaxk1Ylw7FA5mfcjJcWUgHe/EPdCCX
	 M3wagZT3M0uERgx35gWcFQDZ4r/OzjGfdHOwnVFo+wfkC+x5ljJfMc1yqKjGoupxsY
	 m2wI+dn4ZaW0JaApvTsSB769/xPj7pkI3YiUvfYTBjXEEdGaO1oQ4hnqsjyQQi0WtB
	 WNx5dl64k9VnA==
Message-ID: <e5d0e758-f68f-4bf7-9fdc-b8171210e3a1@uliege.be>
Date: Thu, 20 Mar 2025 16:38:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] selftests: net: test for lwtunnel dst ref
 loops
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20250314120048.12569-1-justin.iurman@uliege.be>
 <20250314120048.12569-4-justin.iurman@uliege.be>
 <ffc4c4ba-7159-4a89-be52-9802ef21153e@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <ffc4c4ba-7159-4a89-be52-9802ef21153e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 11:25, Paolo Abeni wrote:
> On 3/14/25 1:00 PM, Justin Iurman wrote:
>> As recently specified by commit 0ea09cbf8350 ("docs: netdev: add a note
>> on selftest posting") in net-next, the selftest is therefore shipped in
>> this series. However, this selftest does not really test this series. It
>> needs this series to avoid crashing the kernel. What it really tests,
>> thanks to kmemleak,
> 
> As a net-next follow-up you could force a kmemleak scan and check the
> result after each test case to really output a pass/fail message.

Sure. Could you point me to an example doing that? Not sure how I'd 
force it within the selftest.

> Also, still for net-next, please investigate if dropping or reducing the
> many sleep below could be possible (it's not clear to me why they are
> needed).

Of course, will do.

> I'll take is as-is to avoid blocking the fixes for trivial matters.

Thanks,
Justin

> Thanks,
> 
> Paolo
> 

