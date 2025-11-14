Return-Path: <linux-kselftest+bounces-45640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACCC5D299
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4E884E16A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5B1C3BE0;
	Fri, 14 Nov 2025 12:44:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1570809
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124276; cv=none; b=XqeSnFioPUIfe/6SUcDdoqEQHTUdE9vSLsTQ3JvXHUC2Nq4b2dCM0xWtF+1I6doAROH9z2O57V7vr3fffs+N0P5z5o4WMTAmL7VAXKodG21HklNalSIeM1Iyu5r6rGs4UftDURk4/PuTsetByBHJYnxlfLDouPpOEixFp1GkXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124276; c=relaxed/simple;
	bh=eXrSxF7g8VtEK9XfVtc1KHkvCDAGmL1xr6MqPdBG0yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8TAovly8mE20CAIVHKo0CNpy08eMzg06Q7j7N+RlPxAapGo5zrh8rQsZ7AJ/NhxN9lvb+arkh4o34V0omGd7IDekDIpyM2wa7e8KYyuRFWyxwIiuYARefeOrjZxkityvv8Yq7tNRpFrXpSC+LLf5Z53n/EKkxjmfCRK3DQR/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e8372e33a2so1129680fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 04:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763124273; x=1763729073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoHpWXitx47FldIpJvkbxLdcbiPOnWRFPRWqGQ7Zchc=;
        b=BJ1YUlr/Po11RSTDJhdAf4R2Bc70+qxkghHjG42JoPCshsOsOwv32+2d856D1VA0Fy
         W+9lSlylwL46TMC285LiYIet1ZNx+miRfdc0ubLIfmeXZO0FChHWxpzhI+fJAy7fg0EJ
         B2rcZ8UHNS/w9d9ApSX4DCof6I/EXwEoLHrMgPFyhaegsVmhHa4VqZNPsb1Xo+8aKlcK
         +4x8VwkgtP4uNusWx+5jO3DmMJglMBNliOMXGn3fICdkQLykD7wD8rrSR5LMPKPwt1+8
         bEYy4mJdKwyGHahW34A7pzM7no9vHb1Umn/OrZa5PBrIbkpqJcq9oY5xlxRGgTnRDMBB
         390g==
X-Forwarded-Encrypted: i=1; AJvYcCW0Asb6hMMTsEva/myMaWL4alDP9KmlLIqGg8vviI4ecNbHGCumgLTBtv6l+y6DIEKfY//xuM6S4AQUX9KMvno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tJKU9Ttq7ON7bgGGFvYl0/C4QNdFOSnqRaNp8S3IdImHpaVE
	kDdo9mMPjVRoStZC5Fuy9Y+rwuN08bNIbh7i1+Aj6KqbHSJXc6/qpkod
X-Gm-Gg: ASbGncvqcDly4h9MG7FpjMKqh7CKNiBZKi61RqvCrI4hwXHz469HvPbgKsIU6E0Z92J
	dADBFT7DnoojW6mGSbHs7GZKtQgOHzXuvrPOlWHEHTpw5ajTTqqwBkik9jSamxLQtcLLWFPubpa
	fcewnfWNjsvUVxtnv7j6vYH067WpHuxXwMT6gwClWg3DYwqu+xI0N2vvOQlzxEFkgF03NLnur7D
	coCuEosyEuXxmQOSpFKHMnJy5Up4b0MssU8ABRDd9T0/dfeUIZzghhNnGELKKg9I5Ymn4EUouLd
	pXocFZLr5RIjOkVPU5T7zyZ9db89hGIjmtls1q/SwtouPu0TO97rOG4ggGHgZo4ZvNLq2JZXOb5
	53bwOJztsyh0AhFbCcfFgl2NIsXaB+YVJ9APBHRBw7y7hMIPjVea1p7pRZ3HZ+hJay3AW+Q2fB/
	7g/Q==
X-Google-Smtp-Source: AGHT+IGdY4QN+y+T94GClU1TS4vz/RxaQrGP+Y+G4NtveS2PNDD2vRqD3caT+pzwZRqBcbYn2m77xw==
X-Received: by 2002:a05:6871:2b17:b0:30b:e02b:c7f5 with SMTP id 586e51a60fabf-3e8691844c7mr1423649fac.40.1763124273396;
        Fri, 14 Nov 2025 04:44:33 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e8522ae6e2sm2610556fac.16.2025.11.14.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:44:32 -0800 (PST)
Date: Fri, 14 Nov 2025 04:44:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] netconsole: Split userdata and sysdata
Message-ID: <nmtyovnsn4edb2leysure4hjriwdkcjpvppcaatqbqifohupw5@osqesr4xh3y6>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-2-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-2-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:19AM -0800, Gustavo Luiz Duarte wrote:
> Separate userdata and sysdata into distinct buffers to enable independent
> management. Previously, both were stored in a single extradata_complete
> buffer with a fixed size that accommodated both types of data.
> 
> This separation allows:
> - userdata to grow dynamically (in subsequent patch)
> - sysdata to remain in a small static buffer
> - removal of complex entry counting logic that tracked both types together
> 
> The split also simplifies the code by eliminating the need to check total
> entry count across both userdata and sysdata when enabling features,
> which allows to drop holding su_mutex on sysdata_*_enabled_store().
> 
> No functional change in this patch, just structural preparation for
> dynamic userdata allocation.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

<snip>
> @@ -1608,13 +1575,24 @@ static void send_fragmented_body(struct netconsole_target *nt,
>  		buf_offset += this_chunk;
>  		data_sent += this_chunk;
>  
> -		/* after msgbody, append extradata */
> -		if (extradata_ptr && extradata_left) {
> -			this_chunk = min(extradata_left,
> +		/* after msgbody, append userdata */
> +		if (userdata_ptr && userdata_left) {
> +			this_chunk = min(userdata_left,
>  					 MAX_PRINT_CHUNK - buf_offset);
>  			memcpy(nt->buf + buf_offset,
> -			       extradata_ptr + extradata_offset, this_chunk);
> -			extradata_offset += this_chunk;
> +			       userdata_ptr + userdata_offset, this_chunk);
> +			userdata_offset += this_chunk;
> +			buf_offset += this_chunk;
> +			data_sent += this_chunk;
> +		}
> +
> +		/* after userdata, append sysdata */
> +		if (sysdata_ptr && sysdata_left) {
> +			this_chunk = min(sysdata_left,
> +					 MAX_PRINT_CHUNK - buf_offset);
> +			memcpy(nt->buf + buf_offset,
> +			       sysdata_ptr + sysdata_offset, this_chunk);
> +			sysdata_offset += this_chunk;

This seems all correct and improved, but, I would like to improve this a bit
better.

I would like to have a function to append_msg_body(), append_sysdata() and append_userdata(),
which is not possible today given these variables.

A possibility is to have a local "struct fat_buffer" that contains all these
pointers and offset, then we can pass the struct to these append_XXXXX(struct
fat_buffer *) in a row.

I envision something as:

	int buf_offset = 0;

	while (data_sent < data_len) {
		buf_offset += append_msgbody(&fat_buffer)
		buf_offset += append_sysdata(&fat_buffer)
		buf_offset += append_userdata(&fat_buffer)

		send_udp(nt, nt->buf, buf_offset);
	}

Not sure it will be possible to be as simple as  above, but, it will definitely
make review easier.

Just to be clear, this is not a request for this patch, but, something that I'd
love to have.

