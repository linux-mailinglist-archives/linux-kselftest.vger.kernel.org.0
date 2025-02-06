Return-Path: <linux-kselftest+bounces-25925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6AA2A9CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B763AC54D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B201EA7E4;
	Thu,  6 Feb 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtqNQGBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41E1EA7DD;
	Thu,  6 Feb 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848343; cv=none; b=Pdw6SOCsRiDWhw1QKgAfT2Afj7uoqqi3zv3cnsuXNsYln/WMLP2ZLN6qhkVCIY7b0DwC+/U9YXJ8iEFq9eC6AuiYedHynjCtsWhddbVaob74RZ8otGur0yEl8au+viO97Dzncx7w8jJMTdgaD+N4FHWq3DakTXtVUNFB4aJzt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848343; c=relaxed/simple;
	bh=866pCCQhevpJWNwi8p1iELys8f3WtUfiDfCwIsMMthg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXngE4mYSUJ7LBMjZLCae2kYbBAgs4p+l0zSENiqdFFckx4o84hm8yDbpYWTiVJX7fnAnHF5pa1SdUDaU2YfZwZ42rqz3xtP4ROsL++nlsm/HKMnfxAOLNfIYG9yw0FEfVX45PJxC9JxhwsQI3maju+dkZ1PAXEbYbQ3V9gbbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtqNQGBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0030C4CEDD;
	Thu,  6 Feb 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848342;
	bh=866pCCQhevpJWNwi8p1iELys8f3WtUfiDfCwIsMMthg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtqNQGBKLfddqn6boR38G7eUq2Q9yAMwesApOGhsoB0QP3dBZCzkzZ1c1q+9m+okc
	 ky79W4u1Sn2zBDGgdtsDa3LdFKDb0v9eNyOek9qYZSLPll/Df92XhYZj56CcoFiYsG
	 bevseac7utg8eXGsJNMGsAUYvr4HU3WrZIgIk+zmEx4iXDoK2kDJhZgJTWcQyNHR/+
	 J9TH7sXhKkqIE3i8h3MzRwfQQ1IVb61YHAIogZAYXD2dYbHw9EA8JIq42cpdhpt6ki
	 9BETlENeadQ0Sk/ygXrl5+wj/yDaIEfWPFk0b9m7n5kIcJ3iVa55UfsLRm3W5oANho
	 fd90Fnfg3w/BA==
Date: Thu, 6 Feb 2025 13:25:38 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 09/17] net: pktgen: align some variable
 declarations to the most common pattern
Message-ID: <20250206132538.GU554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-10-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-10-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:45PM +0100, Peter Seiderer wrote:
> Align some variable declarations (in get_imix_entries and get_labels) to
> the most common pattern (int instead of ssize_t/long) and adjust function
> return value accordingly.
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Hi Peter,

These comments are is true in general of this patchset, but particularly so
in the case of this patch:

* I think a more succinct subject would be nice.
* I think the patch description should provide some reason
  _why_ the change is being made.

Also, specifically relating to this patch, I wonder if it's scope ought to
be extended. For example, the two callers of num_arg(), get_imix_entries() and
pktgen_if_write() assign the return value of num_arg() to len, which is now
an int in both functions. But num_args() returns a long.

> ---
> Changes v3 -> v4
>   - new patch (factored out of patch 'net: pktgen: fix access outside of user
>     given buffer in pktgen_if_write()')
> ---
>  net/core/pktgen.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 4f201a2db2dc..279910367ad4 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -850,12 +850,11 @@ static int strn_len(const char __user * user_buffer, unsigned int maxlen)
>   * where each entry consists of size and weight delimited by commas.
>   * "size1,weight_1 size2,weight_2 ... size_n,weight_n" for example.
>   */
> -static ssize_t get_imix_entries(const char __user *buffer,
> -				struct pktgen_dev *pkt_dev)
> +static int get_imix_entries(const char __user *buffer,
> +			    struct pktgen_dev *pkt_dev)
>  {
> -	int i = 0;
> -	long len;
>  	char c;
> +	int i = 0, len;

Given it can be achieved with exactly the same lines changed, just in a
different order, please arrange the local variable declarations in reverse
xmas tree order - longest line to shortest.

Likewise for the other hunk of this patch.  And I believe there are also
other cases in this patchset where this comment applied.

The following tool can be useful:
https://github.com/ecree-solarflare/xmastree

...

-- 
pw-bot: changes-requested

