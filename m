Return-Path: <linux-kselftest+bounces-17847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B6976DAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB43A1F28E6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4A1AD24B;
	Thu, 12 Sep 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+9HFMWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D5A5F;
	Thu, 12 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154589; cv=none; b=E8+qnqEZkTVjAxvOG7+dYrnNrGOF0bhlBC1kDTwC7QMaG5pT+l6DXhlo9AHJMAi1ERxfpGBhBX39RgkSb1DkBaICU5bG8TpO8yckjgZxXMvRl3DDgdJhAvl4UdfmhUElmxPTNCIG+JnMBibG8KfQHE7pu5rTNZKeCAPUD4+t0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154589; c=relaxed/simple;
	bh=T0AliTqjWVI7nePlIXW52YXenMw2yEMOQRhgyzxECEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6jQVPHwyeYMQE+0jgVlbJbS0ctL3W+ZFcmGF1PxmNqAPQiFVLyn1FG4zki8PnbhElPVxLpJujc0ljKPxPv+morL7PyTA6A4LwKKKYiCcPwQfb7n4qHUCWnLvhQpA16uhgQ3aeUhxxd9uiUZksMw+92YxOpu8Q2zl8bXhP8MiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+9HFMWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E34C4CEC3;
	Thu, 12 Sep 2024 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726154588;
	bh=T0AliTqjWVI7nePlIXW52YXenMw2yEMOQRhgyzxECEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+9HFMWkFJ8NiBllFIfBh2SxPwiqN+FP8B72hyx2DrnUx6hwbbGh3vbIxeizFc3EI
	 4E38ldH8ZCRonz/pKgOT9iOIEO5gj6wfN/0qebLwWKk4y2xMKl7cMOHkaAYaqMMp5M
	 0F0eh+PTD5cLB75dCrQMNXxRrRW7gJEF1A38PFP/XDYJMZt2OnSBQlfSOqpzUAga6H
	 sW55le4uwUzIlzDge3w4a9FpUXwQzKgaQ554tV0sOfaJW5+txX0O8TPD9pGl0fRtqv
	 pJSRqgLUqb72SllEZpBA/4X3WNlPzgRYZygxeN1upUEmiT/qkq2Ygv0QjGp5d4/GBw
	 YfDrPpYlwwEDQ==
Date: Thu, 12 Sep 2024 08:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
Message-ID: <20240912082307.556db015@kernel.org>
In-Reply-To: <20240912063119.1277322-1-anders.roxell@linaro.org>
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 08:31:18 +0200 Anders Roxell wrote:
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 3b7df5477317..fc3681270afe 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -64,6 +64,7 @@ TARGETS += net
>  TARGETS += net/af_unix
>  TARGETS += net/forwarding
>  TARGETS += net/hsr
> +TARGETS += net/lib
>  TARGETS += net/mptcp
>  TARGETS += net/netfilter
>  TARGETS += net/openvswitch

Please make sure you always include a commit message. Among other
things writing one would force you to understand the code, and
in this case understand that this target is intentionally left out.
Look around the Makefile for references to net/lib, you'll figure 
it out.

The patch is incorrect.

