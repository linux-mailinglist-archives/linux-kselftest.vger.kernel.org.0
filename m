Return-Path: <linux-kselftest+bounces-41077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54241B50906
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA81C60E53
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2663B27587E;
	Tue,  9 Sep 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGEhTVhz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF931D389;
	Tue,  9 Sep 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458771; cv=none; b=prT7Tz/uGXMUM3NUav76RHgCSPkfd12HKuloR9kuYmHRuBYTXXmvWiftpomc3FFFAcjdviCai2xTsCLtEr9GsrGYv/14i+/7qfKeHWPiOmcjx4NMAyA0WQHVUGR61DePbJXjlYEKBmh4XLTs6nOabqhJxvWHVBO2euIdlHqrU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458771; c=relaxed/simple;
	bh=G+xredoRO8trDt6TpAD1Efsnd/kOMjzofCvJAyIx+ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pntKlIYzScH9pOV7UHPd4axqx19Q4EZ0WSvm2MM1sVprPmRMHbnLyRZyyLTTtoKGbf1rMfO7Bt4P7l3S9X3kUJzSugjNEMDe1Twj7RESrerafKs7vNWbsf6iDCQdwK9kP34JxaAzsh6diOaay6vwTA/51yTvlAHnVAflA2XqMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGEhTVhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15450C4CEF4;
	Tue,  9 Sep 2025 22:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757458769;
	bh=G+xredoRO8trDt6TpAD1Efsnd/kOMjzofCvJAyIx+ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGEhTVhz5242qDU0ONaRDCRQR6KYRT72o30fRm2VdE2cQ//INLSe8I8JxEmL/do2S
	 m2msIxvYqCj/Mwx74PTdRGpSaIMGaFhwjem80yq/G4cwc0IH2bK5PKtwcGF2oYF8rf
	 HoqHHw5+KaFRX2TYlddexh4VbvnOwfA4xcY3DWdowNyuz3hey4RgMe86p70yokJHfV
	 C91+oJODaFIy95nWcXlCIUG/kTGatHJQ7OUWSojT6z/weLNJKJrGg2S/XEk2tj9p1v
	 fYFYMfcAlbeg10GVDs7gj4BHz6yxq4PBXXxJs3C6Sr20UsO1ZNhuTQPfsrdaUcPe0R
	 SgQmh5nI70Ayg==
Message-ID: <263f7204-6f5b-4bbc-8c05-222cdb04fb15@kernel.org>
Date: Tue, 9 Sep 2025 16:59:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: replace sleeps in fcnal-test
 with waits
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250908200949.270433-1-kuba@kernel.org>
 <20250909153346.4fa8c369@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250909153346.4fa8c369@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 4:33 PM, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 13:09:49 -0700 Jakub Kicinski wrote:
>>  kill_procs()
>>  {
>>  	killall nettest ping ping6 >/dev/null 2>&1
>> -	sleep 1
>> +	slowwait 2 sh -c 'test -z "$(pgrep '"'^(nettest|ping|ping6)$'"')"'
>>  }
> 
> This makes some ping tests fail.
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/289602/129-fcnal-other-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/289602/128-fcnal-ipv6-sh/stdout
> 
> I only tested with debug kernels, but the non-debug get upset.
> I'll resend just the wait_local_port_listen changes. If the change
> gets more complex it's probably good to separate them out in the first
> place.

That is surprising to me. I will take look tomorrow.

