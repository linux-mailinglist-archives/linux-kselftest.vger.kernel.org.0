Return-Path: <linux-kselftest+bounces-5831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FE8703DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F868281DFB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2F3FB19;
	Mon,  4 Mar 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jXduoCnJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751A3EA89;
	Mon,  4 Mar 2024 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561989; cv=none; b=iqKbg4NCkIGp6ydKB24Heyy7xoKl9c60xM+QLkvcPHelY/pW9Kwxm/S3vYj+Who5xtbU2xha8U32abgueE2+eKcjp53OPX9ResCnAVeBDKOayEpzhHe9sR4o9ALY/YYKo5IYFTuZi87g2Un9i5AFrOp615HXzVRwGD+dqokdgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561989; c=relaxed/simple;
	bh=yIwjiE4Jzff3Z6RlihGvSiuyIyME20oThR3476sqCaA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aumRqENatrbw1EH+3PBxyzl32awxJaqB3PdTHr5KtyN5Ve5Iay+Eg3PexFjZsQso8wwv/MDW5fwqaWrr2KmN4najIx5VMLR+4WgtFZLjhZE+DOEBIQ1RGtyGm2LhfByS2+52rK5gBUBrpc/5Vc13nebKqlZxwuej0Ac20I3ju6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jXduoCnJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XgpSqZI8VTYKxdvqODzSX8ByICMsPCDICmVQgFEltPc=; b=jXduoCnJcGxL9hNaLYmYL+XCbO
	+jkyio4C6vHsj1MtRWTE5tPc3KK+DiAOwDIlVQrOpdESSPXBKf8NfcXB3GF7nF4HXKlr1l6eRBf5J
	r4P52MCa1Sv3vYUHBVA8k7LY9Kp03JjeQPXKl/TSTnbUjiLOUr7Dv6kBF6EKASNnkU3cSZLDrdEt0
	OI9/Ie2pBcK7IrYCEa35aic+mQ9FQQfvtvzocE7wnvy6EQjFv6w/tZxuuen7rwsJO4HN2mGrA0Giw
	0oAfaxteUJb/b123ucNa0wVfDJYuAyRxZXA8os2+LnYrhM/9lev9S0IKI/hQb39P0nrESrpux3ZbN
	iJpy7Yqw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh9A6-000BrI-MO; Mon, 04 Mar 2024 15:19:26 +0100
Received: from [178.197.248.27] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh9A4-000A5M-Qh; Mon, 04 Mar 2024 15:19:24 +0100
Subject: Re: [xdp-hints] Re: [PATCH iwl-next,v3 0/2] XDP Tx Hardware Timestamp
 for igc driver
To: patchwork-bot+netdevbpf@kernel.org,
 Song Yoong Siang <yoong.siang.song@intel.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 vinicius.gomes@intel.com, florian.bezdeka@siemens.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, xdp-hints@xdp-project.net
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
 <170956142658.15074.12322285485014543685.git-patchwork-notify@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c87b4763-09eb-5cc3-c797-20ed8a25be0b@iogearbox.net>
Date: Mon, 4 Mar 2024 15:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <170956142658.15074.12322285485014543685.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

On 3/4/24 3:10 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> On Sun,  3 Mar 2024 16:32:23 +0800 you wrote:
>> Implemented XDP transmit hardware timestamp metadata for igc driver.
>>
>> This patchset is tested with tools/testing/selftests/bpf/xdp_hw_metadata
>> on Intel ADL-S platform. Below are the test steps and results.
>>
>> Test Step 1: Run xdp_hw_metadata app
>>   sudo ./xdp_hw_metadata <iface> > /dev/shm/result.log
>>
>> [...]
> 
> Here is the summary with links:
>    - [iwl-next,v3,1/2] selftests/bpf: xdp_hw_metadata reduce sleep interval
>      https://git.kernel.org/bpf/bpf-next/c/01031fd47305

Fyi, Song/others, took in the small, standalone BPF selftest improvement.

Thanks,
Daniel

