Return-Path: <linux-kselftest+bounces-3760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E4842C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18A41C20E1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C247AE51;
	Tue, 30 Jan 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bINHCY6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF07AE4F;
	Tue, 30 Jan 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642006; cv=none; b=iQAFf1YJNjiovRzTiAj8K3NDJujaFIj8vmpCNh5EAVKU4s3xQa5VBi4vDJVkExjpi6+HhfskJlTdos3EexKMQPNCh6vQq+wuabtfVJppRiG5RTQCVaa50GrzoPyx1jt7cVgoZgraEJquS6u+E3kg2CYetSF/y8PfevSEucb+gQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642006; c=relaxed/simple;
	bh=adT4OqYy8v6Ge2E9RqXfbQ+yiyWokwacvsDUso18MwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1HlYzYEZuYTgLlzQerXrMagr7mQkDlKDG041b6kVrQz0j+fsmDi/eqdZwtUZ7DSk7C58btWSUoRclRKRV7a7VnbCxypzsGFfUCM2LeIrP3vXWODam3UyNV1rJSgCLIy7BndWk4hBV1NnpXea+n96W2gEt+WTxo2ALv751etc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bINHCY6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA80EC433C7;
	Tue, 30 Jan 2024 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706642006;
	bh=adT4OqYy8v6Ge2E9RqXfbQ+yiyWokwacvsDUso18MwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bINHCY6kOv9TuLTb5m/eg0+UwN0ZbMzU9SHS3sAUp3iqbYiqCl81PDUCkMdLyXCH5
	 4JdsoDVu6xpaP9U7Hy32qQfcZ3O1eaOomGBfIQJP5gMG468bsDDbHmpFBV7/geiOat
	 +R5ORSIIkm5mU2XbgAf/M0ExGhVpOrA9LBq48UTk//7ZSVjwow53GkWJBr3pBAWKh8
	 kUP0qmzJdOQMQ0Xbu+BUyFxnakYCRdxslatQq5MnHGQxGBv8qt9I6dN7fW26EHfJ8V
	 3phwVVHOuzYTuHhJgYsY7RyNnMAXJ7AO3JqxhFXd8ASHOHcq3+Y4nFcOkfMiLbifkG
	 jNXh4GxnPRYLw==
Message-ID: <bdf5b9dc-0584-4f53-8ff6-fd12d50bd837@kernel.org>
Date: Tue, 30 Jan 2024 12:13:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] selftests: net: a few pmtu.sh fixes
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Florian Westphal
 <fw@strlen.de>, linux-kselftest@vger.kernel.org
References: <cover.1706635101.git.pabeni@redhat.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cover.1706635101.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 10:47 AM, Paolo Abeni wrote:
> This series try to address CI failures for the pmtu.sh tests. It
> does _not_ attempt to enable all the currently skipped cases, to
> avoid adding more entropy.
> 
> Tested with:
> 
> make -C tools/testing/selftests/ TARGETS=net install
> vng --build  --config tools/testing/selftests/net/config
> vng --run . --user root -- \
> 	./tools/testing/selftests/kselftest_install/run_kselftest.sh \
> 	-t net:pmtu.sh
> 
> Paolo Abeni (3):
>   selftests: net: add missing config for pmtu.sh tests
>   selftests: net: fix available tunnels detection
>   selftests: net: don't access /dev/stdout in pmtu.sh
> 
>  tools/testing/selftests/net/config  |  3 +++
>  tools/testing/selftests/net/pmtu.sh | 18 +++++++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 

selftests are getting a lot of love right now :-)

Reviewed-by: David Ahern <dsahern@kernel.org>


