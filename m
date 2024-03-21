Return-Path: <linux-kselftest+bounces-6471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55843886179
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE221C21BAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A313443C;
	Thu, 21 Mar 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="qTF7Ea2T";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="RxMk2VDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E5134404;
	Thu, 21 Mar 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051862; cv=none; b=eIc1J9fE5dPQtw1oK/kXtz+yFdnoDx4hvOmoESMf2JPk7HHzwL2UfOWn//8lED56HeSiYxDlIGHBQI9wPUlPI0ysbO3FJfWbTAt+B5E9cKa/zwasmY0LyVSEoZRQm7Ma42hcWnqc+Rkm5/Tzndtk6zLusMzRGQSy7EW/Y1G9S0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051862; c=relaxed/simple;
	bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmDDDIdm5A4TlQOM8rNGS4pgkxYhmTOSDQksbBEubAbpNW8hOiiyiy/cH417mpTJ/UuvDH0FHwBUxHkbOjlxyNI4VAXhqNHRHy4tjNrunZsvo2XouL60DPqUNQTuZanFAhw+GtZ9kG1e1pWTkiGkM97+nunmOzKCG09jW6Ptyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=qTF7Ea2T; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=RxMk2VDo; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 70F4960171;
	Thu, 21 Mar 2024 21:10:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711051854; bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTF7Ea2TZj0ZR8M2xBt59oIED5u0OnJ/1jaw5qjQRHg3LP1xsTyIB4JpgUYbxudhH
	 vWmK6PLGMXi51V42xlytWBA0fxo0sG4arD2zEG1tw2iCeVz5yAT4f4lSlthFX6aDUP
	 YDxdyDzHGn7Og/1WmcXoBuPlfOvcJkt8s0KffU6ux7qoOyE0ocqnWJcIZ9QqYgDrHX
	 sVy/CLwTOVgaHqt3naiaaWqr9LRn1Ugvw43aCP37rotI1GZKM3vPXWeVZv+voeA4Od
	 ackSVpmdxiMY5pDDGTAUB2TRxkH85euvzgvrVcBQL/Xpa3wqctFyViG1SwE5FwHMh2
	 IfzkJ2Q8a2lFA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pS2AF6Qr0691; Thu, 21 Mar 2024 21:10:44 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id 2802160177;
	Thu, 21 Mar 2024 21:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711051843; bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxMk2VDoS1Xe2p92oLh6nE2faWGkoGYE06lNsWwrBA9RiIjQN5uxdrP9N21zyc10J
	 KBo9E0kdJjNTQArZ/tIyDjkkofaRua/M+cK7wqURk+tfrnRO6qWwDNqM2wQhAEvtSI
	 JQyzIIP45dN2KyRypxycHoy4Cvgn0QDxzdztrF7lYmq4+g3ORtH7k6UeUcCdGmFBPA
	 P5m61aG1Rh40p1OzAy+XcHlzg0IUmU1Qck8qlkh0oymRiSwAR81BD8cju9HPIhSbXa
	 QSd1RBtHxlaLukwPb+JQ9DFTSrtw5JcQQZpYBONN1rAYnj5p+1AqmivFSQ2gfhHSoe
	 r7tC1vpJO2p9Q==
Message-ID: <a2bfb669-e201-44eb-9a16-38c671e8ef00@alu.unizg.hr>
Date: Thu, 21 Mar 2024 21:10:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
To: Ido Schimmel <idosch@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
 <Zfe2cGv_EWFAZXAJ@Laptop-X1>
 <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
 <ZfmgdVUmy-DgNklu@shredder>
 <87634afb-d14b-42ce-be25-1000591ee57c@alu.unizg.hr>
 <ZfrB7hATyOcl4RSy@shredder>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZfrB7hATyOcl4RSy@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/24 12:01, Ido Schimmel wrote:
> On Wed, Mar 20, 2024 at 01:47:36AM +0100, Mirsad Todorovac wrote:
>> On 3/19/24 15:25, Ido Schimmel wrote:
>>> Will look into it today or later this week.
>>
>> Thank you for considering this.
> 
> Can you please try the following patch?
> 
> https://github.com/idosch/linux/commit/58f25dd8766dbe9ac50c76b44f9ba92350ebb5c6.patch

Congratulations, apparently, your patch had fixed them all:

# TEST: Torture test                                                  [ OK ]
#
# Data path: MDB torture test - IPv6 overlay / IPv6 underlay
# ----------------------------------------------------------
# TEST: Torture test                                                  [ OK ]
#
# Tests passed: 642
# Tests failed:   0
ok 90 selftests: net: test_vxlan_mdb.sh

Please consider adding:

Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

at your convenience.

Shalom, and have a great evening!

Best regards,
Mirsad Todorovac

