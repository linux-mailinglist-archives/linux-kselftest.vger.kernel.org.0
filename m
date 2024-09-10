Return-Path: <linux-kselftest+bounces-17624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26C973DD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C47B26A3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC81A2561;
	Tue, 10 Sep 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjkB9ZE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E9198842;
	Tue, 10 Sep 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987345; cv=none; b=YC2r/YeXMf0v5VY/nEv4kob/UORFYBDdix68ygiN4m5odTQZ4cR/qpATnCxmQgeo2TKAiPfTk7okxZMlfggB2SKAaqJ//w+nibXZwvfb5Yu8lXSLO9TuP/3x43jNPLV/PJ7rMdpUJx4SNNUpFjFdqKFz2Lxcz6kqfu5tioSiaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987345; c=relaxed/simple;
	bh=JScXB/yDn/yMAalsJJVsnq7kUH4Esc0s3LoE68Z1fOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9hT+LHGUQSIAuW/G0JGUlCFvF059vvpAKrAuP8oBmj6lRP2Z7lTD3dF1ZxFcH3WYB+hhKXNrK7SRwb3U69E3tPBCwy7orzqrJhKPMjtdt4r4EBfj8twe1ERBRnvEUN8oYxycTP/PgvQanVJBJgT5T4HtSyYkA4C1x4aHusBP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjkB9ZE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA44DC4CEC3;
	Tue, 10 Sep 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987344;
	bh=JScXB/yDn/yMAalsJJVsnq7kUH4Esc0s3LoE68Z1fOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjkB9ZE6VOjrqBUcRfRB/IGW/03aiRntCIPbyiZBeqvHxaI5jKv9MwDaEG8DDCVms
	 WBhJcAiQ4Cq9+12kFHqyGjbeONBmBIgn0n72KfpVQYgC8Cyl9UroP9T+nGG3iddOaY
	 zmVEODx+AgQcJsB+zhOqAoZB7x3hKqjF50j3BlxAU9gjugH8ptsITaLY+Elxlr7MZi
	 CpuAiqBlceiAqOg8kIcTrYvnqA9Bp0rCsSxI84V/pvG0URubh74hfOPnisgrrcm4Vb
	 x73mUjdHWviA8aqphwPn8GbvnM48SNF3nyS6Gs/iX7VRUUVMeRdWM4apgyyiY+yvcF
	 habjts3Llgr0g==
Date: Tue, 10 Sep 2024 09:55:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RESEND v2 07/19] fscrypt: Include <linux/once.h> in
 fs/crypto/keyring.c
Message-ID: <20240910165542.GA2642@sol.localdomain>
References: <20240909075641.258968-1-ubizjak@gmail.com>
 <20240909075641.258968-8-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909075641.258968-8-ubizjak@gmail.com>

On Mon, Sep 09, 2024 at 09:53:50AM +0200, Uros Bizjak wrote:
> Include <linux/once.h> header to allow the removal of legacy
> inclusion of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2: Include <linux/once.h> instead of <linux/prandom.h>
> ---
>  fs/crypto/keyring.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 6681a71625f0..82fcc5683649 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -22,6 +22,7 @@
>  #include <crypto/skcipher.h>
>  #include <linux/key-type.h>
>  #include <linux/random.h>
> +#include <linux/once.h>
>  #include <linux/seq_file.h>
>  
>  #include "fscrypt_private.h"

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric

