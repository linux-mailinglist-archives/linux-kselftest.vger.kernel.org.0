Return-Path: <linux-kselftest+bounces-885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA97FEC07
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F7C281F64
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFB38FB0;
	Thu, 30 Nov 2023 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Rj6QOEfZ"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 01:40:11 PST
Received: from mail.katalix.com (mail.katalix.com [IPv6:2a05:d01c:827:b342:16d0:7237:f32a:8096])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2CAD40;
	Thu, 30 Nov 2023 01:40:10 -0800 (PST)
Received: from [IPV6:2a02:8010:6359:1:4d3:e723:472d:b106] (unknown [IPv6:2a02:8010:6359:1:4d3:e723:472d:b106])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 3B89A7D219;
	Thu, 30 Nov 2023 09:34:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1701336898; bh=ErXmxPvBEc8Any6QeP1YRnOLa/336/55/jQeFDo6YzM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<d8b511d0-b5ec-d0b9-86d0-62b821735a78@katalix.com>|
	 Date:=20Thu,=2030=20Nov=202023=2009:34:57=20+0000|MIME-Version:=20
	 1.0|To:=20Hangbin=20Liu=20<liuhangbin@gmail.com>,=20netdev@vger.ke
	 rnel.org|Cc:=20"David=20S.=20Miller"=20<davem@davemloft.net>,=20Ja
	 kub=20Kicinski=0D=0A=20<kuba@kernel.org>,=20Eric=20Dumazet=20<edum
	 azet@google.com>,=0D=0A=20Paolo=20Abeni=20<pabeni@redhat.com>,=20S
	 huah=20Khan=20<shuah@kernel.org>,=0D=0A=20David=20Ahern=20<dsahern
	 @kernel.org>,=20linux-kselftest@vger.kernel.org,=0D=0A=20Po-Hsu=20
	 Lin=20<po-hsu.lin@canonical.com>,=20Guillaume=20Nault=20<gnault@re
	 dhat.com>,=0D=0A=20Petr=20Machata=20<petrm@nvidia.com>,=20James=20
	 Prestwood=20<prestwoj@gmail.com>,=0D=0A=20Jaehee=20Park=20<jhpark1
	 013@gmail.com>,=20Ido=20Schimmel=20<idosch@nvidia.com>,=0D=0A=20Fr
	 ancesco=20Ruggeri=20<fruggeri@arista.com>,=0D=0A=20Justin=20Iurman
	 =20<justin.iurman@uliege.be>,=20Xin=20Long=20<lucien.xin@gmail.com
	 >|References:=20<20231130040105.1265779-1-liuhangbin@gmail.com>=0D
	 =0A=20<20231130040105.1265779-12-liuhangbin@gmail.com>|From:=20Jam
	 es=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCHv2=20
	 net-next=2011/14]=20selftests/net:=20convert=20l2tp.sh=20to=20run=
	 20it=0D=0A=20in=20unique=20namespace|In-Reply-To:=20<2023113004010
	 5.1265779-12-liuhangbin@gmail.com>;
	b=Rj6QOEfZ4awl8QwOIsGr3q3RpCGkvjvOGdkVjag9es8YnHCVFjMM71M+7Zsppd0MS
	 NHOh7kSnrIupARwOwRF5eu+Cqe2ICTffn/fyh0jSToQCCU43XRWHNaG0WbBnBnheej
	 jFlJGZpMmvy3bDZFC4F+3yGiPTMZUJqfayqrxNayOVu1Ky0jMsDrOOSbVgNlfKYW3x
	 SsG4cro+gejTGFsAfcxO9X0+s4F8EwZ6sKBE/oCD9N4px+l4tfdM9q/7dqnZ2zFXbb
	 CF0lh615Cje/sdJgDaJandtHre3Sf/w84BwAbMzbvtVwrfzLZSk8fDuWjWr10/QvRI
	 36TrNMUSAoveA==
Message-ID: <d8b511d0-b5ec-d0b9-86d0-62b821735a78@katalix.com>
Date: Thu, 30 Nov 2023 09:34:57 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
 Po-Hsu Lin <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>,
 Petr Machata <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Justin Iurman <justin.iurman@uliege.be>, Xin Long <lucien.xin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-12-liuhangbin@gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCHv2 net-next 11/14] selftests/net: convert l2tp.sh to run it
 in unique namespace
In-Reply-To: <20231130040105.1265779-12-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2023 04:01, Hangbin Liu wrote:
> Here is the test result after conversion.
>
> ]# ./l2tp.sh
> TEST: IPv4 basic L2TP tunnel                                        [ OK ]
> TEST: IPv4 route through L2TP tunnel                                [ OK ]
> TEST: IPv6 basic L2TP tunnel                                        [ OK ]
> TEST: IPv6 route through L2TP tunnel                                [ OK ]
> TEST: IPv4 basic L2TP tunnel - with IPsec                           [ OK ]
> TEST: IPv4 route through L2TP tunnel - with IPsec                   [ OK ]
> TEST: IPv6 basic L2TP tunnel - with IPsec                           [ OK ]
> TEST: IPv6 route through L2TP tunnel - with IPsec                   [ OK ]
> TEST: IPv4 basic L2TP tunnel                                        [ OK ]
> TEST: IPv4 route through L2TP tunnel                                [ OK ]
> TEST: IPv6 basic L2TP tunnel - with IPsec                           [ OK ]
> TEST: IPv6 route through L2TP tunnel - with IPsec                   [ OK ]
> TEST: IPv4 basic L2TP tunnel - after IPsec teardown                 [ OK ]
> TEST: IPv4 route through L2TP tunnel - after IPsec teardown         [ OK ]
> TEST: IPv6 basic L2TP tunnel - after IPsec teardown                 [ OK ]
> TEST: IPv6 route through L2TP tunnel - after IPsec teardown         [ OK ]
>
> Tests passed:  16
> Tests failed:   0
>
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: James Chapman <jchapman@katalix.com>



