Return-Path: <linux-kselftest+bounces-6470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958A886173
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 21:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE11C21971
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414713443B;
	Thu, 21 Mar 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="NhgpRkmp";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="J11aJGIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2F56B98;
	Thu, 21 Mar 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051721; cv=none; b=QwAAxv4RGyIaM1M4tsOiwka8PFoNxs3eaYAszOqTD+roQKNUyOEjMSuWUY5CEVLgps92BTXU0U9f5nm/l7Uv5FoEldmOzX0ypQMOZxEuV3Xv75qX6BegQN8ylAVih7VEMUQk8S2R34DSmlNQuG+sTn3V/d7u+2GiWb00lggtZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051721; c=relaxed/simple;
	bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZDhWXcaFe33w92Aot7Ogg2xMAqDi/bgVgrWEJ0n0514OB1AhsnctrXFD6f9h+Wekf3mQ8sqXrXPPW8ynRzz3k1FrmJR8BWPaqe1NGTwKHYwe8llJvUE2JAkCBoQxuCdC2uVuqZkVudxQgYbnMdUvwHkuqCV6k8rD/AI6Gj3Rfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=NhgpRkmp; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=J11aJGIJ; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 522E660177;
	Thu, 21 Mar 2024 21:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711051711; bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NhgpRkmpaELC3IgHFCQSNu7fqQEPrvN5IsFBw9UTqN0QeoDPNZOgJes0i7r8MkFPA
	 7CFDdj+rDmrasfbKNl4yAoRKFKD/JkA0IZnxbVuvlY+KkPz+boZD3vIS5d5HPOWcrD
	 5ie23M+5Ct9qLSHgqrFP7h8J+goIRqAnVFvsQZ8PsdGxSl3YeyypBVCNzXa9mTFx/C
	 2hMgT3vTgo7QOz/TaVEzS09KbdQldMD0R7s4MLxgDoEwfLAGIqCISwGsw9J87tA9zr
	 vwc68SPtkqUu9RGhuAO2AoFxq4uNkrJA3HMNsBBKy7LcGDlKYL9+kdqqDSuJIYV01v
	 MGTxhPNg549YA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K_VLVDRACGJo; Thu, 21 Mar 2024 21:08:21 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id 52A9760171;
	Thu, 21 Mar 2024 21:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711051701; bh=QMqBRt3qEO8LJ5O3+VuzCT6Y+LAtdZG1pvlw1Zc6YBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J11aJGIJN7evfjv67dCMlKaaKGTR1GoGMvraFsn/F1yw7zaGMAVxH/uXWjf4x3dwX
	 KUTy+0hCuMjJT+fTx8LlNhi5ZR5hb4UccsNHhkuN+yppcAgxgNdYFjkaZB5VuJArUB
	 UH29WEoryFs/lXzDS4YwYj/lGoeYM3mhjN3lnloT9+N/MY6wQVJp+rwCqnf6wA0yBS
	 qPqlEvf7I7oQzFIuPdQ75/GauwTQMMXcsvAWu4Qp1JGGjMz7rOzeixOAuWY6NPjSDr
	 +a21v3PcEKzHgbEA20ttLZUm+AqPR2xosM39deK6PizCBIUJJc6phwUZ4IrZgkVd1j
	 utctc85mSBFCg==
Message-ID: <88bef146-bc24-4b6f-8f84-09b818061372@alu.unizg.hr>
Date: Thu, 21 Mar 2024 21:08:18 +0100
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

