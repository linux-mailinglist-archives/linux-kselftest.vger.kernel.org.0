Return-Path: <linux-kselftest+bounces-38482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB30B1DB1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA73A9C33
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66952686A0;
	Thu,  7 Aug 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brf6SW+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF72367BF;
	Thu,  7 Aug 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582237; cv=none; b=UTehySQc22yDcorWZB4CHe7qgc9mE+Vzu7e5f7gDWG+5g66xc9brENtkPekKz+wJuOBDZBxs2YgQUE6719nUHYxZTfng8OD/7ZGp7CHM5n0fRuzUqVFe+0853q4I5Hm5RUn195iX/qK18fRCMkFvMXjpiUnBfVgrJxxxYPB0/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582237; c=relaxed/simple;
	bh=wijCqtSFgvwfCnGWy8j3vxWrbKu6Gn+GUWOOTZgLR3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdjN2YeUtjJQsmteDvDXrDZx8p+NP7HQ7SboUmn3uXL+LrS9Y9KjESqmy0dLpAWTHs7w2nc4fAIa1DHY2fMzdr/PqEVh+ayASCySJ397lVIY1dsgT3bTTV7rm61tB7Tlsw9g5IzdIXw9l8dQvUsc9Cu9joniIoV4UllhPfuUWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brf6SW+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDB4C4CEF1;
	Thu,  7 Aug 2025 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754582236;
	bh=wijCqtSFgvwfCnGWy8j3vxWrbKu6Gn+GUWOOTZgLR3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brf6SW+gcSqUbaBUS+Fgzi6oxKy9Hme41RnY9oTbxW2vbJCaJF9Vhn4MoQgVRC72j
	 jPxzCxP2cWMV8dn2PXEItHOlK3k07GSGmSNMjG0b6OnXrVcUx+MKBKi8kHmRzSXa2W
	 6nIaFvFwIbOIGmQgjcrLc6V07wCzQZSHLlVLQ8Kk=
Date: Thu, 7 Aug 2025 16:57:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
	dvhart@infradead.org, skhan@linuxfoundation.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] futex: selftests: Add description for futex_wake_op()
Message-ID: <2025080753-utensil-magnifier-3301@gregkh>
References: <20250806183030.542453-1-devaanshk840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806183030.542453-1-devaanshk840@gmail.com>

On Thu, Aug 07, 2025 at 12:00:26AM +0530, Devaansh Kumar wrote:
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
> ---
>  tools/testing/selftests/futex/include/futextest.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
> index ddbcfc9b7..c77352b97 100644
> --- a/tools/testing/selftests/futex/include/futextest.h
> +++ b/tools/testing/selftests/futex/include/futextest.h
> @@ -134,7 +134,9 @@ futex_unlock_pi(futex_t *uaddr, int opflags)
>  }
>  
>  /**
> - * futex_wake_op() - FIXME: COME UP WITH A GOOD ONE LINE DESCRIPTION
> + * futex_wake_op() - atomically modify uaddr2
> + * @nr_wake:	wake up to this many tasks on uaddr
> + * @nr_wake2:	wake up to this many tasks on uaddr2
>   */
>  static inline int
>  futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
> -- 
> 2.49.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

