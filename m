Return-Path: <linux-kselftest+bounces-33466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6680ABF746
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928CE4E7A95
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5218DF9D;
	Wed, 21 May 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="r9tzsjMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111618DB14;
	Wed, 21 May 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836527; cv=none; b=ROhw/bpTFUyEd+2EX3AIfU0i1TjeOWu03L7s9DlrR4jxSYe5oZBiAnfNo7HWsbkPLFIvvkaV1fnixJ7yCqdhgeIQ5S/cyNWi/fHt44s+WIFmxUxCBsl9Tv0Smd5OBwlJVypEOZRZEbCpOeEStCIP00WWMmKGG+OU+m8SNGfr1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836527; c=relaxed/simple;
	bh=7X2bDw7QnzI+Ry95G/GHDrSBj9tycNP3+ulwGxSrXgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZo0EunJssC4zhdEZ2OZyFZO1rGOQIvsGTl1SZQdL3sesKbl/CGI5nnofctcXctyueTe39O2KNViYD9WAfAlyEjEbv6Lf5jfX90i18He51YVP4Bi4SwFrGKvuCmG2eQcpNlHOsbn6RO2dGX2W9L61UVqRIiqcZrT64lfpHgwDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=r9tzsjMa; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Hk6HuahaZpEs6Hk6QuvpuY; Wed, 21 May 2025 16:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747836452;
	bh=1p4bBOM6X/rWnNjj84c+v68lEDBrduzX5mBWWcyQmak=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=r9tzsjMaVrP1Qp77I+48WpcjD4FydBs0ftajiJPZViYAe48B7LJTSj2CH2d+TKOO+
	 16OhFfgqrot7pKbj0snZf7Kq/jjbHZHDWLFhoxR+JFNn6MtRdI1RkTR8oKEh9EdBsV
	 M6AW+ZJ7x+SHIYn5Sw3ZvdxEwrBteX4uYcrkgV1w+Sj6T3gr7Q2BOLbvSkPFi9/FXF
	 tl8sfUam/WhcLu/INgfXQE3Ej7nfpZO5+gY7R15XIv0lS0W8rlChYVbAK8J/qnmBy3
	 b0koIuIKbpkSzKgr3XEo9cRNnYt3QHHTcGJNvVPJejunkvGcoZOBQUDlo+Y9pDTriR
	 fIrPZaas4zfYw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 May 2025 16:07:32 +0200
X-ME-IP: 124.33.176.97
Message-ID: <e5487982-2a7a-44ca-95d6-f270a7533749@wanadoo.fr>
Date: Wed, 21 May 2025 23:07:16 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: can: Import tst-filter from can-tests
To: Felix Maurer <fmaurer@redhat.com>, socketcan@hartkopp.net,
 mkl@pengutronix.de
Cc: shuah@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
References: <87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 at 22:16, Felix Maurer wrote:
> Tests for the can subsystem have been in the can-tests repository[1] so
> far. Start moving the tests to kernel selftests by importing the current
> tst-filter test. The test is now named test_raw_filter and is substantially
> updated to be more aligned with the kernel selftests, follow the coding
> style, and simplify the validation of received CAN frames. We also include
> documentation of the test design. The test verifies that the single filters
> on raw CAN sockets work as expected.
> 
> We intend to import more tests from can-tests and add additional test cases
> in the future. The goal of moving the CAN selftests into the tree is to
> align the tests more closely with the kernel, improve testing of CAN in
> general, and to simplify running the tests automatically in the various
> kernel CI systems.
> 
> [1]: https://github.com/linux-can/can-tests
> 
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Thanks. I will send a follow-up patch which will add the support of physical can
interfaces.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


