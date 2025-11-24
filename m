Return-Path: <linux-kselftest+bounces-46396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1175C81F71
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 477204E70A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDB02C3770;
	Mon, 24 Nov 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQcv2Wfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC282D061A
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006415; cv=none; b=Y5yAWAZFqSStWzMLaDazbmsNO6XYCpM4+6GadcSvqsEueJnXBZiA8Iz4osjJ1qmN++0uFU+5DwJWRAg8Vm6z1XLBAjRfKFfQ49tFy8mC6zxXrZUukGMEIdRzXGFrDiwsIHHkpK8xIvTawcIRLfySUJt6niaJTRp+LMD8RoBvHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006415; c=relaxed/simple;
	bh=5QMUaB3UItvdOk2MFBD3uzK1qE9srvOCD3sKMnkMU7w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L65HwdCbipPRLn+SXJH5pbLQaA0WDpliFghzjh8ZHVODvk29fG/tdYNmY0BylRKOhmXpUUsNt986jGP0dlZZ2vYZmV0U/mip1onuqdDRtxxuZoTgLM/3n5xBguo31yV3yqm7qwrSbtcay7w/aJWtiO0tiCapmhMGcYK30tAAD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQcv2Wfs; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d4f2f13dso3757464d50.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764006413; x=1764611213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hvHQdU4GV30EKSntbN+1hV2iN97Sxz4IGxkWVntgLM=;
        b=GQcv2WfsBNv2Kpc2YsojWOmO1oHedfglyzir1ERidEop6Z8cMHcgRT8gl2Ku8tKn7o
         hBi9m1oCD9tGyam0Z+J63xafOOLN7Kgqjjl9oeY2n52wgMrIbvkPfXdmTNLLkjhLNUHF
         OdTQvrsbzOqu0ImtwJCGXIO5wxfEuz1ZGiComjQYUw8y2m6Xh+c5ELsKrkhtUvZNozjP
         J923F+I91pmK0OE34zUyTnsZAMebTPSWzM3r962tnx6O303xGy35dqhptnQjFB945off
         MNmYudhuFBLibwEo/FeyEl/fXI/q6dt/XCHczikDbNargi5ECQlRCtaVtTS1bngswy/a
         8Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006413; x=1764611213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hvHQdU4GV30EKSntbN+1hV2iN97Sxz4IGxkWVntgLM=;
        b=VPYEDhWs0elCNBG2MNQtLPO71NjfJZ5juYFpLa2J+G2slrq3UZHWnpNFDt6q710y+X
         FblUuVVb/5nS9Ao+mIG1fz9yqiDrVHHmeXEIfZpwSQ9ord0mftxCkjCu1WWI+GK5RbRI
         aVqTG1YSFV9T4PqHq/CNOeEEhjL/LT8QvfrKY8BPORdKC797j+rS54RjwPZeYNw857pH
         GIfDwegdNafyzHC2TzTpMQO8FVBTI+kAU9/L3YkZqX804BP0OkmZ3gpyzah2ipFMaoJQ
         zzx0fHpV9EuKQ1GBpxIslu3D7j9Inn6BAQsy4r7wYnLwZDFTfPnEDhaZuT7JP13nZs6u
         k+bw==
X-Forwarded-Encrypted: i=1; AJvYcCWKSlJ26sFEDC8C1GcBfAFy0Ad0NrcShB7TJWz4LYq7JBOCGbIKSwYUQiH0aI9rFKkGgdAcEwZi/NcMOlCsSIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgpVqQUEqQXD7ddlGFpctL5Ff6zJ2J24o4jXjyOwbvn8xGAnt
	b8nsDo6CDsrUJOfi6odcY6ALUwYe/uldJoD9jvWPzELvLwVlcl8KtnMe
X-Gm-Gg: ASbGncuGFnk6iWLM82hzZMvFM1xNXddH3VmzFN9AaOM1LqNykXRoUfL/pivF/RKMgW1
	YpSmWqIiao4WHW6x+/19MSzBhHAbl76RAViviX9C1X0uR0CZzv/dHG1KTkhZt3BDt3M+/nI1qkZ
	1OsFM0QSjE+5fBxzcOjNckde+N4QTPb38OvpVAf4rK5ANCwp7COorX3hIjRXVj6zSiH0i/OMRkb
	UfZAilRjt3WJQLIm+sZviIBp1UkjrWjGrzS9bpk9O5X0KzIIoOI22GZpOAnaBgH6SpYhoVCgGFZ
	ti68DsfH0NXxQFImZQ0lMrbHArYJvutb9Z3yIVboO9ICuUsQ4Ckh9KBTdPomq9hxo4lPYx+loI8
	ggH194U6qsUIbeNeVc8rBn6OO4WGOhxuPUtEsHYz/iajzUzMDkjAUDLVuQeQEf6Z/2nUwkEdMrd
	yTxzHVeVHLJU29LzUJANC+kKjMSkWOIKSJB9SkP/YFhnwcAryDxCUVbUOO6hMtasjZXVg=
X-Google-Smtp-Source: AGHT+IFZLS+sg4uY4W+GnSk7FxLFLQkNJQifO8MidMav+DX9v0PbFy6py458azKZF49Wq/pFCb5C9w==
X-Received: by 2002:a05:690e:4298:10b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-64302abbe69mr7439363d50.36.1764006412975;
        Mon, 24 Nov 2025 09:46:52 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a5decsm46733137b3.21.2025.11.24.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:46:52 -0800 (PST)
Date: Mon, 24 Nov 2025 12:46:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Message-ID: <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
In-Reply-To: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> by when switch default case taken. raises following warning.
> 
> 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> initialize these variables to NULL to fix this.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

These are false positives as the default branches in both cases exit
the program with error(..).

Since we do not observe these in normal kernel compilations: are you
enabling non-standard warnings?

> ---
>  tools/testing/selftests/net/so_txtime.c   | 2 +-
>  tools/testing/selftests/net/txtimestamp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
> index 8457b7ccbc09..b76df1efc2ef 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
>  	msg.msg_controllen = sizeof(control);
> 
>  	while (1) {
> -		const char *reason;
> +		const char *reason = NULL;
> 
>  		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
>  		if (ret == -1 && errno == EAGAIN)
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index dae91eb97d69..bcc14688661d 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
>  static void print_timestamp(struct scm_timestamping *tss, int tstype,
>  			    int tskey, int payload_len)
>  {
> -	const char *tsname;
> +	const char *tsname = NULL;
> 
>  	validate_key(tskey, tstype);
> 
> --
> 2.52.0
> 



