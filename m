Return-Path: <linux-kselftest+bounces-48862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF3D197BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EA15303515F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8029AB15;
	Tue, 13 Jan 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="kniYjxpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster4-host11-snip4-2.eps.apple.com [57.103.78.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353728FFFB
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314141; cv=none; b=OA9PBJJim85NJ9sbcaw5nAFkKEB4FtPzbIfg77Bw8erK27lMmZOaCqV3pndmQ4lUeNYq0YJ8+C6uRBqbMZG/fm9ZIcyAJvMJd+hUg5WjC+WqgEIluHw0IKpidUGl4W/TJoLCsmPFdRWeee0HC8M24LE8ODHvrjnZsBBHRo7zUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314141; c=relaxed/simple;
	bh=So/GytmIyFefKTETm6v5F3X/wbvcCdhrK9s43Pcqp88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/O9DQoEjnPMlqn0uMJ6oQb4OlV31vkM0HyFu5H94/vr8Shrb1/wVHFksyjfvuAb6ApXgZgpavxW0dP+6VE5wn4eTLtVvkcrlNmn5UjQUGROARBQPyM3T08YJpGAICOh8sZmnwvHhS0jCiGQ61W/L/hQEo9qWrGnu08JLF97DjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=kniYjxpI reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id 6052B1801503;
	Tue, 13 Jan 2026 14:22:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=fmxsnE/L7NFB0ejvFSKTM8y9Gw52rQC2a6j27SV3+Gw=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=kniYjxpIcw+W0Ypplo5vQFdrd5zf3UO2//+/avcKMnS8R3U0IWeHZM7eAJA3jV68j8c5bLBj4qQp7A7Yyss2Tc0MnBRHWqZK8f1qP/tUbJI4TdjBQrsouIGOaB43oOtTgKGEQG2K2nZ0u7+jburBkItlfAC0addONr47vdUdIwNLH0CapHL0QiqeLU7DV4c67NJZDitgPdMDojGyBNmIYMxKYs16AQN7Q53QbQgdLOebo798xKPg5SbeLGW5iv7AheugF9Td0nmbssdSMD/uQURohEsU4pqf/KkQLvcAOdlMHBIPOzPEGoZ9k2oP0fIXqOLw3mCb4RobcMTStECOAg==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id 27BB91801534;
	Tue, 13 Jan 2026 14:22:16 +0000 (UTC)
Date: Tue, 13 Jan 2026 23:22:13 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: net: improve error handling in
 passive TFO test
Message-ID: <aWZVFRrhENOk_l6z@desktop.y-koj.net>
References: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
 <88ead962-fec5-4834-88af-c478ee2bf023@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88ead962-fec5-4834-88af-c478ee2bf023@web.de>
X-Authority-Info: v=2.4 cv=Kv9AGGWN c=1 sm=1 tr=0 ts=6966551a
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=sMBj6sIwAAAA:8 a=VwQbUJbxAAAA:8
 a=jnl5ZKOAAAAA:8 a=OB2aahCY2n3uGOuFrBcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3o_l8myHFtgA:10 a=zgiPjhLxNE0A:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: IX-QzqVa4XBnGw_bD4KU7-oq8BiSfyfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyMSBTYWx0ZWRfX1oxpEhxr4QYx
 eFz77APdkQdxdkbG+I13uv88jCWdRXZ59PFC7aydLJNhyhCoQ6gNKHDCgEiy70+ZAFUdBVL+hKq
 Lomq2RM0NHqV0oDR3qIusvTe1Y2+E3CODlzzFMOyny7WvLkIJQEnHU0m9uYbB+u/ZwUvNbZzyGw
 jKC7InWSZZ+edQ/5wh7Z1lsYb3YhDKfvnf/EvTxBkRTP09jYfHDrZ2ZvhDn3uGFC4nlAz9C/6n0
 VyrrnMF0QtLTidCIk36qdAZ5DQMUlgnVpMvkAN5YqeYBh7JV1NPsU6uI1QletJtoYim/RDuQa2G
 FzDkjwcDWtpv1mdKWYQ
X-Proofpoint-GUID: IX-QzqVa4XBnGw_bD4KU7-oq8BiSfyfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1030
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601130121
X-JNJ: AAAAAAABkxOfaRosJ03tVZJfoO7SWg4Ois74AQlyHGfy/1l9Wkq1pEpjLXxMarCdtU5pu3SPPWWko+AoVAZ6EGBahdPkQvj6hpJtbyRrUyHM56ZVlMvV4sGbyJMXTyAlJHlMcoWSXtoxF7NzBCvpJ6XopTeDJVQhcOJvGPevdpetwvDzpR+BR/GPrz3oysPxxeALKgKugMu9NAsm966Iu2Yi2lUwRJMujkY/1Z1ggYkxOskRvjPMTJLUw2uY5EtRF0UQRJL/R8kyaGBx46bIZDHTf/WyvwptaptiAKHiV9/1qnbrOBZ/E6PJYdIAF/UDgPTPLF2NzKVK9eGsID2ApOXAKOOqCtbr3/G9KGTTfvT5Q3D/hZmvuGwsqGLpsSgmxo3w2v0dntLrh5OLBXa69GF6DFJTHVVVLKV9XJnY9okFx7gDG04c+1vzUW6zKdfLu2flwhyG3R6p77jSUnpD+gpPSdNemy0pCQno9pcl2redO2C87A8TdWZ5YBwO6omUJk+AJ1OtUZ+YshZ0x9CbsWnI9yh1cqWp8uG5c2z4bDze6rt/7GP2SJGizd1dDr7BBQNSCRzFtNQ8v6999M3A0Lr12R+KJ5qKzywaLE9A8tRxGzWGk/9eCqNngI82s2Q8OINoiWa2XppzDqTmRsYsHhtP83ppP5OIAPegO+PUqu+3J6yQFQZl+q2DjObRz18WufDTPcIOLlc2bCwLwffYsIH9jOPrE6MNBCQqvaoHIA==

On Tue, Jan 13, 2026 at 10:46:10AM +0100, Markus Elfring wrote:
> > This commit improves the error handling in passive TFO test to check the
> > return value from … and  to fail if read() failed.
> 
> Would any developers and system testers like to care more also for data output failures?
> https://elixir.bootlin.com/linux/v6.19-rc4/source/tools/testing/selftests/net/tfo.c#L86-L88
> https://cwe.mitre.org/data/definitions/252.html

That's right. Although we can assume that fprintf() usually succeeds,
it worth checking its return value as tfo_passive.sh relies on the
content of the output.

I posted the v2 series adding fprintf() error handling here:
https://lore.kernel.org/netdev/cover.1768312014.git.yk@y-koj.net/

Thank you,
Yohei

> 
> Regards,
> Markus

