Return-Path: <linux-kselftest+bounces-4230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC984C978
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F16E1C2589A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BDE1802E;
	Wed,  7 Feb 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC0K+VOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F01B7F2;
	Wed,  7 Feb 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304594; cv=none; b=IUglc4KxgntRZZLU6siXbnEHBfwnY2trvEJcVZCAxwGIpeuTXSc9wH+U2qkbHWwaDu2LZf/0IQDMj5kSAD2C4sWWje6iYuRL6sUH36KgDd2qXE68gkY6NXW8wTpRCQvfG1Vn6D5dGX25OFKoSzLmCj6Xyz5/T1P2xJ2cSK6u+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304594; c=relaxed/simple;
	bh=l3MsN/ES7901YOcnJySmu+Vj1bW3DJqVxY6rCun9I2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6KHm71MzwsqMpSZImEi74gStdtxrfry0N1DY1TXh66eKgnNSYCshBFdL0rRz/ghJn1Sk5CB8FdRXTpLrgzVj3IjPPodiwUxzvH/KR0YsAJef+iGr93L84ymQ23iGo+j6SArjo7WxkQo5iAfDeyhubxvmKT0QjL4xGWTUz2ozpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC0K+VOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88E6C43390;
	Wed,  7 Feb 2024 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707304593;
	bh=l3MsN/ES7901YOcnJySmu+Vj1bW3DJqVxY6rCun9I2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qC0K+VOqbmbyyNLDHt8A4g2btW8FnCnlzz3oTNDaZ4J4TE7B/3qrH3sYaBTnULzj+
	 8TO7kzQKUtDDJ1fgVvRdvRO1bwzhgHtEazkMFyMYiwxtG1eciqN0HdFk0Ch5fqggRZ
	 nckkod5D447u1OCpeke8tk979Me2A7CKAc+YJx7lzumHMK4hEI4+92L/WvcMi0kU8a
	 Q/F/UIPysf8FuiY0W86wyuM9AX2j2c66hcsna4PsDvr0OzkFrW12+d+ilevPT8d0um
	 Pv21msHP0qkjoOMCJ3EhAuV5ccHokGpyZZ/yXEo6viEJZ76jq1ubm1ipYpFrhu5BR8
	 DFpWhmLeTNlIQ==
Message-ID: <be5e4878-18a7-4de9-b03e-55298a84ab0f@kernel.org>
Date: Wed, 7 Feb 2024 12:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: cope with slow env in gro.sh test
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Coco Li <lixiaoyan@google.com>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/02/2024 16:27, Paolo Abeni wrote:
> The gro self-tests sends the packets to be aggregated with
> multiple write operations.
> 
> When running is slow environment, it's hard to guarantee that
> the GRO engine will wait for the last packet in an intended
> train.
> 
> The above causes almost deterministic failures in our CI for
> the 'large' test-case.
> 
> Address the issue explicitly ignoring failures for such case
> in slow environments (KSFT_MACHINE_SLOW==true).

To what value is KSFT_MACHINE_SLOW set in the CI?

Is it set to a different value if the machine is not slow? e.g.

  KSFT_MACHINE_SLOW == false

(please see below)

> Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that the fixes tag is there mainly to justify targeting the net
> tree, and this is aiming at net to hopefully make the test more stable
> ASAP for both trees.
> 
> I experimented with a largish refactory replacing the multiple writes
> with a single GSO packet, but exhausted by time budget before reaching
> any good result.
> ---
>  tools/testing/selftests/net/gro.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index 19352f106c1d..114b5281a3f5 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -31,6 +31,10 @@ run_test() {
>        1>>log.txt
>      wait "${server_pid}"
>      exit_code=$?
> +    if [ ${test} == "large" -a -n "${KSFT_MACHINE_SLOW}" ]; then

Maybe best to avoid using:

  -n "${KSFT_MACHINE_SLOW}"

Otherwise, we have the same behaviour if KSFT_MACHINE_SLOW is set to
1/yes/true or 0/no/false.

But maybe it is fine like that, and what is just missing is adding
somewhere how KSFT_MACHINE_SLOW is supposed to be set/used? :)


Not linked to that, but a small detail about the new line, just in case
you need to send a v2: it looks like it is better to avoid using '-a':

  https://www.shellcheck.net/wiki/SC2166

(but here, it looks like the usage is fine)

> +        echo "Ignoring errors due to slow environment" 1>&2
> +        exit_code=0
> +    fi
>      if [[ "${exit_code}" -eq 0 ]]; then
>          break;
>      fi

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

