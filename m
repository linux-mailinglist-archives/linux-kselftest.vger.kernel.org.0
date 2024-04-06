Return-Path: <linux-kselftest+bounces-7344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478089ACFA
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82091F215B0
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2284E1BC;
	Sat,  6 Apr 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5ZISUpw7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739618C1F;
	Sat,  6 Apr 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712437488; cv=none; b=DtR3EjvYZ8XXsAEvDQGP5VSyiutnLBNGGUC19ht98mgeR+Za9bUBfhB22Ha9bCTfiNTkXsGMbYeKjQaxU2Q4O2GiaPSezZJh1bnT6neqsyS1SwlD4JFL0P7x812UFPnxgiVs55JV5PMm6XGMMZzZR5bpYn3WCsnPjZidgGNHvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712437488; c=relaxed/simple;
	bh=64IYSKKJE5J1rChJs6720PfQX+7NKQslncXK2DYIEq0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eK5GzRhupKphRMfdxmdG73226xg73XFMA1+TOIdoQcVxLUL81YTplQf96hoJ2DNtI7a2WtMN1Kg0diuLHD602VMkjFhUkKg4diuJmVFRrIHsIOwxEMjWW1cv3U5UwkDdSP9k/LvZDLVYEk5TGdMj7zbDsT4HnTbvjADm5SHWN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5ZISUpw7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712437485;
	bh=64IYSKKJE5J1rChJs6720PfQX+7NKQslncXK2DYIEq0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=5ZISUpw7LX0vnCMpd1kfQoGuXQnhpMsio7mI8JzUfQm9eQfr24L9rhV9uothnUGbR
	 Ijf2eO5yZ5iB/8uPLqwLzv08Q/YuRiLBoUW2u7AtYOdZhc5mLuboO8UeBciGTqrHKK
	 Q5h6yErd8L0rHsDllpfuia7GhTXMOY/ieso1tvKgrCR8aC2RdpFKbblko4haLOMd7Q
	 oalS9NRwI6TP72Jg+Pvnx2tmpmxWMlx0tvS9N2M6y5EuvpULgoUJTwqsU1qe/Ei5ut
	 4M4MMWeoUW869POgdJ8rontwmgpWHZoAc9XA3CLI60skkwe3D42bMOFOtHhY7CChkY
	 emrxcpm7punHw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 483B93780894;
	Sat,  6 Apr 2024 21:04:37 +0000 (UTC)
Message-ID: <470d67f2-dd6f-48e1-8f42-a6c72e2d98e7@collabora.com>
Date: Sun, 7 Apr 2024 02:05:10 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Rutland <mark.rutland@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Default to verbose mode when
 running in kselftest
To: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
 <20240325-kselftest-ftrace-ktap-verbose-v1-2-3785199809da@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240325-kselftest-ftrace-ktap-verbose-v1-2-3785199809da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 9:15 PM, Mark Brown wrote:
> In order to facilitate debugging of issues from automated runs of the ftrace
> selftests turn on verbose logging by default when run from the kselftest
> runner. This is primarily used by automated systems where developers may
> not have direct access to the system so defaulting to providing diagnostic
> information which might help debug problems seems like a good idea.
> 
> When tests pass no extra output is generated, when they fail a full log of
> the test run is provided. Since this really is rather verbose when there are
> a large number of test failures or output is slow (eg, with a serial
> console) this could substantially increase the run time for the tests which
> might present problems with timeout detection for affected systems,
> hopefully we keep the tests running well enough that this is not too much
> of an issue.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/ftrace/ftracetest-ktap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest-ktap b/tools/testing/selftests/ftrace/ftracetest-ktap
> index b3284679ef3a..14e62ef3f3b9 100755
> --- a/tools/testing/selftests/ftrace/ftracetest-ktap
> +++ b/tools/testing/selftests/ftrace/ftracetest-ktap
> @@ -5,4 +5,4 @@
>  #
>  # Copyright (C) Arm Ltd., 2023
>  
> -./ftracetest -K
> +./ftracetest -K -v
> 

-- 
BR,
Muhammad Usama Anjum

