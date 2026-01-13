Return-Path: <linux-kselftest+bounces-48820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77956D1632B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DFC2300485E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2842192FA;
	Tue, 13 Jan 2026 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="wMWtrBAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host10-snip4-10.eps.apple.com [57.103.64.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64517A2EA
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268795; cv=none; b=d0A9DzMoPkvZs6z1aQYxGwocG/CWlFNXGJeCvyM4+FM+KweLV/Y3Q15jX1rwS2UdpaNz4+d0dd+3fx011sZxTd86mhQ52o8nRydHiZeAs0RF2Yofj0WbxWytR9kPkDZ6SaVGs9MODtOnDBHCJs9ILkeFDpxKBECIIhWzGOxoIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268795; c=relaxed/simple;
	bh=Wlpk6teNdpx/5bPc1xVfOPVir77g7J1qOUi4Pn0mVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my0b5xz1mc6tpNwR+rJfM765wuY0wXq9VT0pvObpPWCpE9A33f5lQT/lxPpcjwDTzRb1qUmH1t0nDFUlWKds6ap42O0I/o3JOIBLT2O+ah1mJzNcr7nKNYa7kdqV5T56JZUCpyD3JOWNS7So00s/h4lQP1HZU5Rk35O56FiS6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=wMWtrBAl reason="key not found in DNS"; arc=none smtp.client-ip=57.103.64.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-15 (Postfix) with ESMTPS id 4601F180074E;
	Tue, 13 Jan 2026 01:46:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=ddEc/c9ojrsAOlEQSx2yx5MGR/4NIKwKKMN9dcKPKPY=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=wMWtrBAll9ixT3giz/Hz/g+sxCvHljBF4BGMce8ycg0X7Fd4iw/v/LWIE+gA32tRMTeiaAFlU03ZAE+OiBG2HGGwvOXPzf8mWHC5/Z6f0wPC7POJG3YBzGYls9+7kIC74+Ykk04rfc4TdewpPCTgEHVaEyZzXwUBRTSsTopXL0brW8EcR3hF3yEUPUYpx8nqYh2xPBnUxB4NPjOoFK5RG/vLW4My5NgpqfrNJqNdJFByIXl/H6kaloG4YQhpjM6ErbMHaUku7tadb5XKR/wuB6d8cGlb+0G+TkOdxNT9jYKyzRaMutrQ6M57imGPKYK+L8FebcZKXKly5YsgP88o/Q==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-15 (Postfix) with ESMTPSA id 0DC7D18005A8;
	Tue, 13 Jan 2026 01:46:29 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:46:27 +0900
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
Message-ID: <aWWj80LbRLLJll-D@desktop.y-koj.net>
References: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
 <4bdd89fe-914a-4baa-a9b5-a6e15168ba52@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bdd89fe-914a-4baa-a9b5-a6e15168ba52@web.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAxMyBTYWx0ZWRfXxGwMDP3a1pcl
 gHdaec8jOuQwt5RWKDQI+seAIYkqYOrHNMQHo7ruPx6PG85BWZ//FIV90ZToYYhhj5cZ8j9f1ef
 WflEX3kwcd28JMMkcHqlcmkwZwfYEC41DOfcfJycX2LWSqm6BggoRQFhf7gz0mVmyPD6Ovq18mY
 HcJ+8mF8nyxuJyZ7rDmc7XQqklMnmu3R4L2IclajMxmyWiBwZFPrlZXWj2Ceo1IsrkDmi4n9oR/
 iIYZ6/Alpec+GoXYJhFIsCJxv1U/tFK8tEFfsH06l2wUu+LyxzKwYf3azgH8sh+wIJrmEve2RXO
 pxUTLM6Iye7fBidS5n3
X-Proofpoint-ORIG-GUID: gGc9xyyB3KpGJe6BGKpPQq0FmMwbKlxr
X-Proofpoint-GUID: gGc9xyyB3KpGJe6BGKpPQq0FmMwbKlxr
X-Authority-Info: v=2.4 cv=Z/bh3XRA c=1 sm=1 tr=0 ts=6965a3f9
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JBawV9J_BYzm3OXuTVkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=798
 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601130013
X-JNJ: AAAAAAABwBrC3alMsQwZ3bNMTplneJvjl0mqMxr9CRjl/XFa2J9Iao2mD8XxG4F0IMMyoeUqzBqd/uNOSjOd4ZKLIVqSokxVV23RHr6B5suAJOLArf1SKVe4cypHcNkiViZExEFm0qABMGAiEi4eufUMu2L3rMGP89VWuNk8RLXn8YZf8a7mFk8B1jC56afdda/d9hWgGWy+etC1hXYrCuqvF7d+NcicLbmwlt4ltoeIuSDX6P4yMJXu18tOm7EkYhg+2/Dxqdpi1NMteaUrxyRohdJH/xW5YTbf7iHQ6I3B1KfBZR2/FkGQbJVy94L13F+4HM/FnekoEQ02mEFKBpsZqJm3E5R4/d4NlRlrHsMPiH9NfrAPnfHEn5AMwVT1xEE9usXSwttyaLMQZXsgzYLsFglLt/A9P66lVYfiTmLX4NRHaJBDyxWO14xWnJGePS8QxRhvFEN1V8BOk/WeY9GpgqwTtBX4EElky8V16k/b8qhN85M4RjvkaDPZJ18piiWMpAjLXb8L1jtT4VvZA85nsdX3CTSwfrCrICBAWsrEu68DLfiCQ6gsuC73ZyD8+uwAIue9thNTbwNOGa1TszrN+NbUxu4e+0Ou5KVihH/gkDLIgyBL1SHu2WqW1B4fOv4eHgFl1U6xVvFa6Xl9rt04VT5GGAicWs8v+Ohl8o3ifwhG9TVEzQW5uAs83oVPXF9sMpIACBDr6O18Ca2OvehcRcw7UX/8eFCEUyPmsZRRb91XgGEZ

On Mon, Jan 12, 2026 at 08:55:10PM +0100, Markus Elfring wrote:
> > This commit improves the error handling in …
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc4#n94

Thank you for the feedback. I will rephrase the patch description in
imperative mood as suggested.

(I also found a typo "cliend", which will be fixed in v2 too.)

> 
> Regards,
> Markus

