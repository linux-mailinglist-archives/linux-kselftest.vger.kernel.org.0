Return-Path: <linux-kselftest+bounces-24177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10747A08620
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 05:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D962318891F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 04:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417D205AA2;
	Fri, 10 Jan 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWp965nR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA3B661;
	Fri, 10 Jan 2025 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736482157; cv=none; b=F/1WH6GFAGzwM8kYmG06VcErRKgxcoEN9Twq/Cy4+J4t/RwC5msPr4FkRyVgQfy5czlbe+XFvWQN2CKKmzjyledda2mJrNG3esyp/GjXmmBwec6etqjHJk15Ln/2U7Z6PEOatwQRuNbHh5xgjoNudvlidrVup90Wqu+kocBq2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736482157; c=relaxed/simple;
	bh=fN1k0d6vbsE0+iO67xt+DGJKe4SdxMxiTgACV4vWfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC+2Zs6D9lkVE+O6O5V0oXJ8MeBlujGzmxL0tHsw5+uIyow0Fp9glppJ7jt7k6N6KRR48nvs1iXH1Wpc0RWk8LPgDJnU5T3tPM23z/HP0Vv6rldfOmf2c8Df+S+zLJVd85jrPMooK0Z2QBf85qlwGRJHpqT7KtAdXn0abKipsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWp965nR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21675fd60feso35319545ad.2;
        Thu, 09 Jan 2025 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736482155; x=1737086955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WcIPIwc0JhDfP3jSatfcuTE0xoBjfeC22KMLpqnla8s=;
        b=LWp965nR3MfIOPpZtV24+dJYEcRYah82AZ+a1urpwUyyjQJs2SyIpZvNYHHqZE04gm
         bK23qmMJio8ciVefOYILd7bsSty+ObT2qTaHD/7q8SsLI0ScjaK5Xv9Y2WZUf73DDjCA
         s19bAPT852DispQTBNNXnSwmJcqqQvrXQgNfUUZ+WpOmYTouYg8vjBLHxgXTgol79IH0
         FmLnvQCPrcGYvDwnHXOPySVeFu1ejEoeyk+VE7t9uE87xuxfoeVcmUyxAmwI6ilIqOV0
         1pkaqOAVnOlnHyuZn1t9dC9Ru3+CkwMMC2lyeE8Z2HCpvlCeX12F+lWMDCFlVogBoKik
         RkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482155; x=1737086955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcIPIwc0JhDfP3jSatfcuTE0xoBjfeC22KMLpqnla8s=;
        b=qgEjTNdQrz9YcqW5B71KD8FBaplzXdj24xECuwqxPOIUsjKWTV4NU9U8m5sSaZMa02
         rIH0/LZ7OyPgaQ1ayu0JuKJLoalaUKenqIIq9IsceF7S61BtQHo/T+X7W1JyTHvodCuV
         maXA1R1XU8QE2zvTRvmYYvtgHw+gF4hLXr/cBvvmwN+vK1a/saNMKaEaahFUXU0V3vAJ
         VUuhfifKgBl03bWyrCmD8A7pLVEpw9tq+X9s22jbyzSJYPVyxXtw3UmD8taRcTEmFaVv
         snfA3PDnYQxIgYPK7ZyHX0IEVcDbfIJQJQRyE37r5OQBaTUF8Fli7cnme6/mEKfHW+JY
         t1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVWkFn47N6UgPe0WVkr64mn78F8mJsR0E9bM9yVZiQdOghJRrsmnlvFh+QA5hxLDhVCIfVHdOyf@vger.kernel.org, AJvYcCWS5XkEOsP45yIBc1wAsScGCwllxpZHS7C2RYC7orC7tLTtfZPQC9FJUwSx89fd5RF8pQxnd5NtjrF0BPu74DCx@vger.kernel.org, AJvYcCX85nqyIgTpLJ5JOQR5NP5DoNGk3RAqyft/hI1mgQNwbekn5bjPpKaaY+xZmmpDjfPx5bvbyxEsh+9Ph90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnecmSXOxTSlZtWow2bNMjBosTe5KmHsoAoWwq+nq2RqSTWE4W
	HwGc+bZ+1/AflBH9jzUMyyhSz2qbmo3sdWBk9YiNwbqOOIEFsNH3yyPaVtVxPVg=
X-Gm-Gg: ASbGncvPNXIT1QiyZdWl6G7grKa1WSzz9qCnYy8TfqhpKyLatlVI7EjX2o8MFenFuLS
	18Zn3udj0gPv7wh4sXrX3DzGTkPfobTcDMdEBtvxabwe7KfPRmBqh8YzLQUK4JJchZkwiklwuU7
	H5sjNTW6ecEpu46XjyNniLSMk7myyV8TixF5OPHw95q1TCYEobirG08S67pDSogRay0TLU9X1wJ
	qlZpG3rhuXVo1BVY2r3kdoLw+elp6kio43uswR6krgDhY6pT9elv1KQHNNl9w==
X-Google-Smtp-Source: AGHT+IEjk2/ZLMouXDj6tlGREyrMRmd1z64cbAmKign0zA9nwRc0222GvyxKXO7lpoelsyVx7A2DFA==
X-Received: by 2002:a17:902:ce88:b0:216:356b:2685 with SMTP id d9443c01a7336-21a83f46a03mr135480345ad.11.1736482155107;
        Thu, 09 Jan 2025 20:09:15 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c958sm5424375ad.174.2025.01.09.20.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 20:09:14 -0800 (PST)
Date: Fri, 10 Jan 2025 04:09:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net/forwarding: teamd command not found
Message-ID: <Z4CdYzmSn2cySE_h@fedora>
References: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110000752.81062-1-alessandro.zanni87@gmail.com>

On Fri, Jan 10, 2025 at 01:07:44AM +0100, Alessandro Zanni wrote:
> Running "make kselftest TARGETS=net/forwarding" results in several
> occurrences of the same error:
>  ./lib.sh: line 787: teamd: command not found
> 
> Since many tests depends on teamd, this fix stops the tests if the
> teamd command is not installed.
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 7337f398f9cc..a6a74a4be4bf 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -784,6 +784,7 @@ team_destroy()
>  {
>  	local if_name=$1; shift
>  
> +	require_command $TEAMD
>  	$TEAMD -t $if_name -k
>  }

I saw team_create() has `require_command $TEAMD`. Is some test called
team_destroy() before team_create()?

