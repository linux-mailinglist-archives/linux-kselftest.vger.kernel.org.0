Return-Path: <linux-kselftest+bounces-16984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD5968A93
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB4F1C21E3F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C31CB520;
	Mon,  2 Sep 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuvi6b0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551081CB50B;
	Mon,  2 Sep 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289359; cv=none; b=q9lAGHBfSZJNQvdl6OrggZTyS4aKB96KznL2OIyzcao8Ijj5VMy4Z00/3nJDvEHbZa1SwL9EicZv83eYG8EcemeKNidj0HKqbrX7ez/iSOqYA3DCIB88Z8YDll13rzKTC537pXXsNmwrXGKjO2Rv41KxpSbPyyq4cYT0dyMtAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289359; c=relaxed/simple;
	bh=12r9nwPY2sNoh+N3Yz2k8TmxMUwMdZ1KcNB+4cMQAv4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Eg8SmTvEnG5JeT3lLXu9CsCDK7TUwvehRDBLId54jBi8xGi98dUW4Vreyxzkyi0L0xiY79MLuG/SNWQy7ZiJwEGqxW8286+DMsEzh/4DgW3A8t912MZVW2g8s1Qs/PkmURgbz03eEV7mtvAzEWDz+GTnnZdS10GNVH+0CA8/uuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuvi6b0E; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf92f96f83so21377456d6.3;
        Mon, 02 Sep 2024 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725289357; x=1725894157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+NYxBYK5mSMtNyhT1Dp1KYTYMYvA0Ifp+MV1r2Yzhk=;
        b=Uuvi6b0EfBQ4WbBAF7S5+8qUiDSfg3pnDZcfrz/ki6uAaKvgVdX8qy3C5SWeTnK5xZ
         7DFFRq+PJ0+hG5G0eiOnvl1yYVZ4zHWaozreSSJfWBgzbGz12C57suk0BVjbTv8qZ4DP
         Z535gCfzGoOV8eK33Oi/xqZp2YnYPEs20IVhuZ6WtDUpsjJB41z01JUXbbJmMIqGY9jI
         a6zL5YYEWwQ/+mikTzpq0dXJI/tn1+e5JuCFYzRrOhyN52GxrOuxnkx9kp1YwGCumYbT
         xGourQoHkqgymZivfWvZ3E0Sw+XeCfNw/+5+9PSv/ECrJVKCjOSJOdSF1c6Ys0YlI1xr
         7dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289357; x=1725894157;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+NYxBYK5mSMtNyhT1Dp1KYTYMYvA0Ifp+MV1r2Yzhk=;
        b=Ryt50S6mrlBp4mxyp4y0Pfrx6epcmlYIsJHXnTYsOwl/8Z30ZNQ3HWm/iPuoq2J45I
         SblB80AjFIKNdZbWVH+U86hkjVjwiEnMmHdgtN57Ki5L+i5GhFcuZTrSxrWrEw2AP8cJ
         Am0JMTVA5Lb/fdGjEyZkK43KsezMHTQej3BQTB9GkrQ8lJuwZ6ppUnrudEgK+026pLss
         KP2o3MPfzLGvE6I8i10UgBK7dg57k23xddA0vNM0psCSsVgm7eqbLVtpQppiNWUtbRFE
         SuFBDJz1b/XdtybtQX51EvYXDsmBEYOl+O1v2VUXFeLj05wxjUp90ytvLvwEzNbDX8Ru
         KUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVAc7/H8BQ/mqb19rVCkqPbV74+07inqq4InSBmS+P7SakJ8B+EJO++6HsuZ/sL9go2ydQ5FRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdt9FqSmv6E4RGJxNRJ8r/rb0vPxG39ylo4MkmEuz2Nx0jUmAo
	5DhOOVENad4HBof03QYHW3OGnayf1NFHrXJGzi6EhDxtE8f2z224
X-Google-Smtp-Source: AGHT+IHARmc6JE8kolMeuT4oODmynHrR+j9YpuVPAjEpo6fPrClfnaI+WiFlCYYT4smESjvW8AOYdA==
X-Received: by 2002:ad4:4149:0:b0:6c3:5597:406d with SMTP id 6a1803df08f44-6c3559740e4mr83680126d6.0.1725289356779;
        Mon, 02 Sep 2024 08:02:36 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca6a89sm42793596d6.113.2024.09.02.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:02:36 -0700 (PDT)
Date: Mon, 02 Sep 2024 11:02:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 jmaloy@redhat.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d5d38c1d4b_61388294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240901051821.94956-1-kerneljasonxing@gmail.com>
References: <20240901051821.94956-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF
 support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> three things:
> 1. rename tcp_so_peek_off.c
> 2. adjust for UDP protocol
> 3. add selftests into it
> 
> Suggested-by: Jon Maloy <jmaloy@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

A few minor comments. Nothing important.

Subject to Stan's point about .gitignore:

Reviewed-by: Willem de Bruijn <willemb@google.com>

> -int tcp_peek_offset_probe(sa_family_t af)
> +int sk_peek_offset_probe(sa_family_t af, int proto)
>  {
> +	int type = (proto == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM);
>  	int optv = 0;
>  	int ret = 0;
>  	int s;
>  
> -	s = socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
> +	s = socket(af, type, proto);

Removing the SOCK_CLOEXEC because not relevant to this single thread
process, I suppose?

Not important, but no need for proto, can just be 0.

>  	if (s < 0) {
>  		ksft_perror("Temporary TCP socket creation failed");
>  	} else {
>  		if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof(int)))
>  			ret = 1;
>  		else
> -			printf("%s does not support SO_PEEK_OFF\n", afstr(af));
> +			printf("%s does not support SO_PEEK_OFF\n", afstr(af, proto));
>  		close(s);
>  	}
>  	return ret;
>  }
>  
> -static void tcp_peek_offset_set(int s, int offset)
> +static void sk_peek_offset_set(int s, int offset)
>  {
>  	if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
>  		ksft_perror("Failed to set SO_PEEK_OFF value\n");
>  }
>  
> -static int tcp_peek_offset_get(int s)
> +static int sk_peek_offset_get(int s)
>  {
>  	int offset;
>  	socklen_t len = sizeof(offset);
> @@ -50,8 +54,9 @@ static int tcp_peek_offset_get(int s)
>  	return offset;
>  }
>  
> -static int tcp_peek_offset_test(sa_family_t af)
> +static int sk_peek_offset_test(sa_family_t af, int proto)
>  {
> +	int type = (proto == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM);
>  	union {
>  		struct sockaddr sa;
>  		struct sockaddr_in a4;
> @@ -62,13 +67,13 @@ static int tcp_peek_offset_test(sa_family_t af)
>  	int recv_sock = 0;
>  	int offset = 0;
>  	ssize_t len;
> -	char buf;
> +	char buf[2];
>  
>  	memset(&a, 0, sizeof(a));
>  	a.sa.sa_family = af;
>  
> -	s[0] = socket(af, SOCK_STREAM, IPPROTO_TCP);
> -	s[1] = socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
> +	s[0] = recv_sock = socket(af, type, proto);
> +	s[1] = socket(af, type, proto);

Same

>  
>  	if (s[0] < 0 || s[1] < 0) {
>  		ksft_perror("Temporary socket creation failed\n");
> @@ -82,76 +87,78 @@ static int tcp_peek_offset_test(sa_family_t af)
>  		ksft_perror("Temporary socket getsockname() failed\n");
>  		goto out;
>  	}
> -	if (listen(s[0], 0) < 0) {
> +	if (proto == IPPROTO_TCP && listen(s[0], 0) < 0) {
>  		ksft_perror("Temporary socket listen() failed\n");
>  		goto out;
>  	}
> -	if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
> +	if (connect(s[1], &a.sa, sizeof(a))) {
>  		ksft_perror("Temporary socket connect() failed\n");
>  		goto out;
>  	}

Changed due to the removal of SOCK_NONBLOCK above. Definitely
simplifies the test.

Just note that error test is == -1 or < 0, also for consistency with
the rest of the file.

> -	recv_sock = accept(s[0], NULL, NULL);
> -	if (recv_sock <= 0) {
> -		ksft_perror("Temporary socket accept() failed\n");
> -		goto out;
> +	if (proto == IPPROTO_TCP) {
> +		recv_sock = accept(s[0], NULL, NULL);
> +		if (recv_sock <= 0) {
> +			ksft_perror("Temporary socket accept() failed\n");
> +			goto out;
> +		}



