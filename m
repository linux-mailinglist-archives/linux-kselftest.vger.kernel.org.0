Return-Path: <linux-kselftest+bounces-40784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBDB43F9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AA563AEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D925214236;
	Thu,  4 Sep 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DwJadDQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F15746F;
	Thu,  4 Sep 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997497; cv=none; b=D1kWqzVPUQYy49uCoySsrNn280kLCJU2YvlD0FgYCs93pm91UAAAud6ivNcAWNoAAbHMLBGP9pdEiBLeIxBGrcWT5wzAH0pgoqzumEbBO7pDl3m1NdboJTquuGPhmKzcEcXnA0m+DvzON0OVH3c9A1/+H9La1zUY2pmELS766+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997497; c=relaxed/simple;
	bh=MxV7JwJ61a9n9FwtJO4bxB3gj6xnn5mgXnDIikA+P/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFni1dB/skb3h91Gpu4atvKl7BoaEH+0b3TaVl9bL/ucmCEZB9PV39QlUhV7GeTZraulB47zO5IBYGEFI2HZXt6RkNSifl2K7FwYMI5qr1KbFeOhNel7N2XNck5PUwVr96lDsPMT9OGzLgL3CE6TdD0nxEkAo6wU9tCIF9FhB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DwJadDQZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8E2FB4E40BD9;
	Thu,  4 Sep 2025 14:51:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 566FB606BB;
	Thu,  4 Sep 2025 14:51:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 294801C22DEBA;
	Thu,  4 Sep 2025 16:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756997492; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jo9JdRFpgoWnk9VE8Xpd3kfRbyqZU7+ZJUpiWh2ktao=;
	b=DwJadDQZ7gDOODJwVAcYXlNlKvT5MSRjqV6zsxQ6xeMfu5FT1TmaApB5K8CtcjrftUTXc7
	Ez3/zL6y9OTELOELiGVZXJ8c/iTzonrrNlsmig6wPB4YkXlYdhAfaTUSHIQbPQcpCLBzs2
	BIB1dQEwCYdNpFfc6CbSXXeCXJ+yvPsJQ9fYPRjJ5AHYUutPt3+vXpEPY/xkSY2HnaFzui
	/bsKTc4wG2X2gduspRiMJvE0M9eYjWXa38BJDhRcVzft/hPuMT8BIpd3iuv/q0/n2+YEpJ
	dzw10bZ9Q2qdpHWI13PupoN5IvKr0AA7Qn11YDdlerlkGtBy2ha0hqmAEmG8Hw==
Message-ID: <c07b1af3-3c98-49d8-80e7-926d8a536240@bootlin.com>
Date: Thu, 4 Sep 2025 16:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 00/14] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <aLmfXuSwtQgwrCRC@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aLmfXuSwtQgwrCRC@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maciej,

On 9/4/25 4:17 PM, Maciej Fijalkowski wrote:
> On Thu, Sep 04, 2025 at 12:10:15PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>> Hi all,
>>
>> This is a second version of a series I sent some time ago, it continues
>> the work of migrating the script tests into prog_tests.
>>
>> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
>> are defined in xksxceiver.c. Since this script is used to test real
>> hardware, the goal here is to leave it as it is, and only integrate the
>> tests that run on veth peers into the test_progs framework.
>>
>> Some tests are flaky so they can't be integrated in the CI as they are.
>> I think that fixing their flakyness would require a significant amount of
>> work. So, as first step, I've excluded them from the list of tests
>> migrated to the CI (see PATCH 13). If these tests get fixed at some
>> point, integrating them into the CI will be straightforward.
>>
>> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
>> tests available to test_progs.
>> PATCH 2 to 5 fix small issues in the current test
>> PATCH 7 to 12 handle all errors to release resources instead of calling
>> exit() when any error occurs.
>> PATCH 13 isolates some flaky tests
>> PATCH 14 integrate the non-flaky tests to the test_progs framework
>>
>> Maciej, I've fixed the bug you found in the initial series. I've
>> looked for any hardware able to run test_xsk.sh in my office, but I
>> couldn't find one ... So here again, only the veth part has been tested,
>> sorry about that.
> 
> Hi Bastien,
> 
> just a heads up, I won't be able to review this until 15 sept. If anyone
> else would pick this up earlier then good, otherwise please stay patient
> :)

Thanks for letting me know. There’s no hurry on my side.

Best regards,
--
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


