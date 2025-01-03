Return-Path: <linux-kselftest+bounces-23870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DACA00A0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33A1163FD3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC571F8F09;
	Fri,  3 Jan 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dG6cqRvJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A25190049;
	Fri,  3 Jan 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912381; cv=none; b=GUFggrjB4xi4/l57iZjcXqEZ2aOqxdqwoGMmtfEYunMp3GYZRfLeW7iSkTyF+RtEGlaCsXrPBUvOSkTUNF/F4lTwEm9g/aZwfn4PXbpEGCAZ7mskUgH0sEyLSt/7NAqJT4vt8dvjnLq9u1T2Hn0DGZ/BgJdJKU2cZH2RIUI/a7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912381; c=relaxed/simple;
	bh=q/A2OUQ7y1ThGKTsA3RgK4qE9vSBuk3Ek8fBby8ysVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La6k0VSGkl8s3MH8Wtv+xuwFstCV3ZuErT96Mfuue9f6sP2bO0wN8uLqmqPvPMIsBJTKKvI5fbkfpzseJH2SNp2ZHMwTq9hUqKpdxpsJ0B0UVYtZuxWZQCyW/AHN2YQKeT9FjKaZBWe2FkKUhLPCi6Lw/5SY+awcexTrrR6f5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dG6cqRvJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4038240003;
	Fri,  3 Jan 2025 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735912376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pC6/K17Fqa/UTd240daBQTUsMBS6IYkMe8d6L0ZU79E=;
	b=dG6cqRvJk0uhouwFsVuqS0dYMK04ybegaHSBXqXu51n8ZwIWrT9jO+TAwo6qlfu+vsp808
	rabbOP/agJ9lnX4VPHGhYojmspzbu3iHE/tgmgsQmk1yi9kslzGt9hE6gi2QcsYI7SJuj4
	27pwbK5gnB/EzWeuRtOWzZX8uWcUjaA6ihUkXvam4ijKDDwrtJ91f+Ckjj3PCQZrYSbylP
	J5Q+5QU/C2xlyMEqynP172TqHMXpCui0M2TjzGhrivKe7WTLv/JhjubhwSgwO69UXcph7s
	sOQBdvtjWuvQ+lZEACn78GCSU/AM75WSlZPmUrY4Du2s8SbezQ1mQBW0cosxQw==
Message-ID: <a895f79b-8311-4930-bd59-2937d09b92c4@bootlin.com>
Date: Fri, 3 Jan 2025 14:52:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about test_xsk.sh
To: Magnus Karlsson <magnus.karlsson@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kselftest@vger.kernel.org
References: <e3d0bd36-c074-4cda-b6e1-5f873453ad30@bootlin.com>
 <Z3cTnjss5soyUobX@mini-arch>
 <CAJ8uoz1r0dDna9tZwm8Q62dks18DHdstF8dkpm-q+_nwOUmbdw@mail.gmail.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAJ8uoz1r0dDna9tZwm8Q62dks18DHdstF8dkpm-q+_nwOUmbdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Stanislas, Magnus,

On 1/3/25 10:36, Magnus Karlsson wrote:
> On Thu, 2 Jan 2025 at 23:31, Stanislav Fomichev <stfomichev@gmail.com> wrote:
>>
>> On 12/20, Alexis Lothoré wrote:
>>> Hello all,
>>>
>>> I was looking  at other test candidates for conversion to bpf test_progs
>>> framework (to increase automatic testing scope) and found test_xsk.sh, which
>>> does not seem to have coverage yet in test_progs. This test validates the AF_XDP
>>> socket behavior with different XDP modes (SKB, DRV, zero copy) and socket
>>> configuration (normal, busy polling).
>>>
>>> The testing program looks pretty big, considering all files involved
>>> (test_xsk.sh, xskxceiver.c, xsk.c, the different XDP programs) and the matrix of
>>> tests it runs. So before really diving into it, I would like to ask:
>>> - is it indeed a good/relevant target for integration in test_progs (all tests
>>> look like functional tests, so I guess it is) ?
>>> - if so, is there anyone already working on this ?
>>> - multiple commits on xskxceiver.c hint that the program is also used for
>>> testing on real hardware, could someone confirm that it is still the case
>>> (similar need has been seen with test_xdp_features.sh for example) ? If so, it
>>> means that the current form must be preserved, and it would be an additional
>>> integration into test_progs rather a conversion (then most of the code should be
>>> shared between the non-test_progs and the test_progs version)
>>
>> Since no one came back to you, here is my attempt to answer.. It is a
>> good target but it is indeed a good idea to preserve the ability to
>> run it outside of test_progs framework. Maybe we can eventually run
>> it with the real hw (in loopback mode) from
>> tools/testing/selftests/rivers/net/hw. And I don't think anybody
>> is working on integrating it into test_progs. But Magnus/Maciej should
>> have more context...
> 
> Sorry Alexis for the late reply. I have enjoyed a long vacation over
> the holidays.

No worry, I did not expect quick answers with christmas holidays coming, thanks
to both of you for your answers.

> I agree with Stanislav's reply. The only thing I can add is that we
> really want to preserve the ability to run on real HW as the majority
> of bugs we find are indeed in the zero-copy driver implementations. So
> these real HW/driver tests are more useful to us than the self
> contained tests using veth.

ACK. Based on your answers, and since test_xsk.sh seems to also cover many core
features regarding AF_XDP sockets, I'll work on integrating this in test_progs.
I'll see if the code can be shared between a "on hw" test and a "test progs"
test, and if not possible (eg undesirable code dependency between different kind
of selftests ?), at least replicate the basic AF_XDP tests in test_progs.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

