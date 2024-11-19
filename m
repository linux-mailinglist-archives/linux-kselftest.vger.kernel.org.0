Return-Path: <linux-kselftest+bounces-22245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C69D227C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCFDB230AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF61AAE33;
	Tue, 19 Nov 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Czr6kP3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AD146A73;
	Tue, 19 Nov 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008487; cv=none; b=uF7MBiLmr2hQM5sx8t5seljSc0REDtdDOfAhgaJOrusyvTX94XMilGEX5E/F66IQ5RKjSi8EJpH9kJYo+cxtulvSi0IvahQoIl1+qLTiGzg01XsVTStN02ACfEyGpESMWrGvgDS5dGc+cQIS5r8gd/QqZQPbeFtHjD24zEUhXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008487; c=relaxed/simple;
	bh=l6hYH+I/d3+UJSlXa8HB0USEK3x/u7b1hmfa+gelN5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH5+8tiPjq+aT5FESD41EL3Hr1MNVB5RKbkOxYvYwL7/tq8e+wduc71DCq18RedxwwufC5HAFz972JUK05gL1JBIuCwxaiD2NWXYjosRm3HDEeZDGfOL56pbmZzsO6QeI8RHJQ27hTgTQWFFEVchBePL25uTesRCBLwo/UoEanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Czr6kP3k; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC911BF210;
	Tue, 19 Nov 2024 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732008483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJFJAzaHJtAyyv/3A38xMOz0wya1baJ7i0fcR4cZHE4=;
	b=Czr6kP3kyFhvkCye2LC+mi2d7NSViteSWrHph0CH1VvIWXvZ/yKKRSUK2xKWW33oCbAbsd
	cdPa9iqHQ/+F8FGddQkwZoAweMTvqNRZlVJGXxfMiT2l1Wd3ApVJ5vjjUqFSmgq/RqyI+l
	Ask/QVWKzxDLCP4uQfEyOe9NvX2G4KA2OtdUx9lCBOyms6dAHUr8ji3XcVCbmlgmRFbCVN
	NuYRBrf7oB9p9T8WHGdZkClVRSWhRM0XV+whP05wnAeI+E5rUMt9f621lJC8WG5vqPD1YM
	SyexSHszd1nK5Ti58uplcnlnpJn+5URDVkOWwo1gI1xYcNkV1TwtEpZ/JG0E6Q==
Message-ID: <ffc76427-8268-4d48-ae5a-430b1129f6b0@bootlin.com>
Date: Tue, 19 Nov 2024 10:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 12/13] selftests/bpf: migrate bpf flow
 dissectors tests to test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-12-ee4a3be3de65@bootlin.com>
 <ZzdyswzsKSYwkY__@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZzdyswzsKSYwkY__@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/15/24 17:11, Stanislav Fomichev wrote:
> On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
>> +		if (!ASSERT_GE(err, 0, "do_rx"))
>> +			break;
> 
> You seem to be already doing similar ASSERT_GE inside the do_rx, maybe
> drop one?

True, I'll drop the inner ASSERTS to align with do_tx.

[...]

>> +static void port_range_shutdown(void)
>> +{
>> +	remove_filter();
>> +}
> 
> nit: Maybe use remove_filter directly as .test_teardown? These extra
> wrappers are not adding anything (imho).

Yeah, I initially added port_range_shutdown to make init and shutdown functions
"symmetrical", but in the end that's purely cosmetic. I'll use directly
remove_filter.

[...]

>> +		test = (struct test_configuration *)&tests_input[i];
> 
> nit: What's the purpose of the cast? Is it to de-constify? Can we
> change run_test arguments to accept const struct test_configuration
> ptr instead?

Yes, that's an omission on my side. I initially thought about making the test
runner function rewrite some fields in the test configuration, but I finally did
not need to do this. I'll drop the cast and propagate the const

Thanks again for the review ! I'll prepare the next revision with all your
comments addressed.

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

