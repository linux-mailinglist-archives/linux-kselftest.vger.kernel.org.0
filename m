Return-Path: <linux-kselftest+bounces-43655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59EBF614E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 13:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02F4A4F8A89
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C031A050;
	Tue, 21 Oct 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB8Ry7nU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFB269D17;
	Tue, 21 Oct 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046557; cv=none; b=KQe+gSZ8VwojfsA5pqLBPB/bqpu/DtE6EFe7QLioD5NLkd4QoHQuOgPazjAumDV6G1+ra0bi8X7iRvlf10hewn/Hqfvio4KM9jMj/WAS4L3tuZDjTAZBmXmfUkZEN9KVY8E+OzfFYd0HSx5OYIf4Z5UePg90QVxPgFs75xM7EGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046557; c=relaxed/simple;
	bh=dGF3MJ1EmOtzDX5b+6Z26q2tCtCiz2znprvPe5dXjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7cRFESM1vOnIDcsbAmBjrQcDS8ZC2Wb42w5tKMLL6hXa2bU9X1oqLBbu3KpxYcR4AsbRGCblHBNmHsU0nKUvwnjvK5EZ4aU++IXjKA15cmH0Gg25Zz4z9KF/zW9VibdsrDcMGo/4eJNkQ6OHmR9SDRLzKBjFXKVZnHRZBmUeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB8Ry7nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5C6C4CEF1;
	Tue, 21 Oct 2025 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761046556;
	bh=dGF3MJ1EmOtzDX5b+6Z26q2tCtCiz2znprvPe5dXjBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB8Ry7nUCv1GxdY+7Sc3T4YKMCvzbe9L/Q3iQgvK+dPKTj5W5h6lO1jeHn5idyXVU
	 v+11tM6BpgZe5iDpkVt4DIaVKz4tcjlNsaDMj3z0j/MMXi6wdCWTWKItYxPeZV6o2C
	 IjMxFc1QEVrwBerLRmtMMcdh2ZpCb+o0sxM1oczNrciFNf6hP6dSqRaSp2EDlWlhVH
	 rU67P4Gmb6uaufgkwJJjJ8ROb/mi7zYDK769JdherTqucDl5OSzMApYxfJZZxQkv9h
	 M/bivuqeDVj3oSwyRyC6MHLVpLXLxBJVY2kXUbhn+S3AbhQ9kE37aCTEXUuDehqXHf
	 8Vbc7TZCrwGTw==
Date: Tue, 21 Oct 2025 12:35:52 +0100
From: Simon Horman <horms@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <aPdwGJGUxhqiocBX@horms.kernel.org>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021092917.386645-2-wilfred.opensource@gmail.com>

On Tue, Oct 21, 2025 at 07:29:17PM +1000, Wilfred Mallawa wrote:

...

> diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
> index 36cc7afc2527..ecaa7631ec46 100644
> --- a/Documentation/networking/tls.rst
> +++ b/Documentation/networking/tls.rst
> @@ -280,6 +280,28 @@ If the record decrypted turns out to had been padded or is not a data
>  record it will be decrypted again into a kernel buffer without zero copy.
>  Such events are counted in the ``TlsDecryptRetry`` statistic.
>  
> +TLS_TX_MAX_PAYLOAD_LEN
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Specifies the maximum size of the plaintext payload for transmitted TLS records.
> +
> +When this option is set, the kernel enforces the specified limit on all outgoing
> +TLS records. No plaintext fragment will exceed this size. This option can be used
> +to implement the TLS Record Size Limit extension [1].
> +	- For TLS 1.2, the value corresponds directly to the record size limit.

Hi Wilfred,

Unfortunately make htmldocs seems unhappy with the line above.

.../tls.rst:291: ERROR: Unexpected indentation. [docutils]

This was with Sphinx 8.1.3.

> +	- For TLS 1.3, the value should be set to record_size_limit - 1, since
> +	  the record size limit includes one additional byte for the ContentType
> +	  field.
> +
> +The valid range for this option is 64 to 16384 bytes for TLS 1.2, and 63 to
> +16384 bytes for TLS 1.3. The lower minimum for TLS 1.3 accounts for the
> +extra byte used by the ContentType field.
> +
> +For TLS 1.3, getsockopt() will return the total plaintext fragment length,
> +inclusive of the ContentType field.
> +
> +[1] https://datatracker.ietf.org/doc/html/rfc8449
> +
>  Statistics
>  ==========

...

