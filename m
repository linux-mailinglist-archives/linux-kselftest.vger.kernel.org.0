Return-Path: <linux-kselftest+bounces-4388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC384F1D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F3F1C23FA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE7664C0;
	Fri,  9 Feb 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbWSOCi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD5679E1;
	Fri,  9 Feb 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468999; cv=none; b=pLpBA+/8UVXXqw6pO8FBSk9xCyNtZy12aCS9qShgyzOWF9DCCCqDIOYhFum5ypmdDorZNv442LH75q+fU/+HpWUpiranG6Q0IWFCtjPtIQ1DoQSxLAU8useq4C6R9bmZkxJbZ03agh0Eap+8/VQlQ4sGePywwPTYFPm1vEx2UUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468999; c=relaxed/simple;
	bh=3VJQhWL+BEgjcpz3bfsyEQkmOXkf+HFehq3CcxyDIfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La9nyuPJJMNTYSfTLqaz5VihTFu30JlslPatQmhjzZ9b5HhZ3CKqoGgq+CMEdQ4E/z9/E+WhRrSwzHoH6aL2MgUkKECZIrovBlI3hTLn9uqbynOKySpVpc1wKbMnKTjuMUqPyR+6y3iXyfzNOyRKX87C6HNUu2vdHwH5fH4a/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbWSOCi2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a29a93f38so256218eaf.0;
        Fri, 09 Feb 2024 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468997; x=1708073797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXzQ3GxI3rgnGSAEjmDMYgmgUiVi/kT+qT/2C8dWdV0=;
        b=DbWSOCi2+Ji3vV1vTRv9I3/1nf7HjAkIie11dHQNDwLzobapnUEJgdLyEkimuUiZQQ
         jpOimjwOA7pGvxWQiCxCqYCvqrE79cLgv3qdcd8W3dlR7JWYVksEqUVv+Cmf6a27wb1F
         zSOUfPdJMQ56r0hlDExPrFlQDIXps9yXWmgCoaBGl8dxuydjuf4ozonBe1FOYyAYN10N
         t6nZIMlNrkU/pqMEAObkj1U3U7N+7wdcDR9EW2cfIcIELcC0kXoGbZsTL2N902S5UvVe
         QLCEytYV598dVfeDW47PDYOgN3i4MMiOM2zSy+md8haVsfb7l6Q7IuIid41Zm6eTUCX3
         QnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468997; x=1708073797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXzQ3GxI3rgnGSAEjmDMYgmgUiVi/kT+qT/2C8dWdV0=;
        b=rM5wDJVL1xr+MJ/uo6cwo2temca1FMzEdkW9gXG7A+q2bXAvnrAIOau83lXW+zC0RM
         bAQt5J7XsLorzOoszroFog5vFcxOb7od70FM17Ebl67J28GO4fR3OPJNSFb8KiChV5ph
         VCz1BL/45QNqNsFxmXjC0tQ3ZBDZRylnUTV3EwmSNVF7tJfp8KkdQBy71TeRIImhD+iQ
         CLhMV8Zzhcq8kT5b5sCOZwPherARf6Yozhv+PW7XQgCZKK0IsT2kJc2Oo2wZdDdt90nx
         kJRIlMr3WUWlCaB1uVO5YsFHN90OvcZoMsj0Bfd0seJUdK/jbeh4H9UGvh3vSR/U74cE
         lK9Q==
X-Gm-Message-State: AOJu0Yx2uR2OyUaiHxguQyi+0YR1VlNT19lxKT/J1O2hIMcEKZ3p1hP/
	3o6v45it3zjnP1vdVGIJ3o5EJVg/hwRlkkM+n5n/S3/yN2T11FSU
X-Google-Smtp-Source: AGHT+IENdHbnMExcJBgI/ohTU+5+09wo/QfJpJlErdfArl89ZcP+fQbcUirAUBhOzmQGFmCc+im03g==
X-Received: by 2002:a05:6358:5283:b0:176:2c3d:fb35 with SMTP id g3-20020a056358528300b001762c3dfb35mr945649rwa.20.1707468997461;
        Fri, 09 Feb 2024 00:56:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEifufI8JViEBfracgZOLfzFfhvy9+XlRLVccV88YhcWNwsV56opgJIhYxesAqnfYyOO1gfXPx0l8q7Lz658Qy/eKojrP88wbyUAf3ZHqWK/FnZxwJ5NDbLfv2kRWfVwM+tockTa7Obo/xvtLgYmJDYgtYPVyPmW5o7MQktpY4M0Bf8KmU2ZBh8+6iWMtf+Xwbr09Px7VGy5y8a6g6Vvz6W5HgZqXlKDTDzVOPCSo/ePONN/pS86vsmSM2EBImS+vz5LTR3JpYMf9HI4+UcIb7gr4ZuMWt
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e10-20020a056a001a8a00b006e03a640007sm1133473pfv.71.2024.02.09.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:56:36 -0800 (PST)
Date: Fri, 9 Feb 2024 16:56:32 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, shuah@kernel.org, petrm@nvidia.com,
	razor@blackwall.org
Subject: Re: [PATCH net 0/4] selftests: forwarding: Various fixes
Message-ID: <ZcXowE18kPIgIc-M@Laptop-X1>
References: <20240208155529.1199729-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>

On Thu, Feb 08, 2024 at 05:55:25PM +0200, Ido Schimmel wrote:
> Fix various problems in the forwarding selftests so that they will pass
> in the netdev CI instead of being ignored. See commit messages for
> details.
> 
> Ido Schimmel (4):
>   selftests: forwarding: Fix layer 2 miss test flakiness
>   selftests: forwarding: Fix bridge MDB test flakiness
>   selftests: forwarding: Suppress grep warnings
>   selftests: forwarding: Fix bridge locked port test flakiness
> 
>  .../selftests/net/forwarding/bridge_locked_port.sh |  4 ++--
>  .../testing/selftests/net/forwarding/bridge_mdb.sh | 14 +++++++++-----
>  .../selftests/net/forwarding/tc_flower_l2_miss.sh  |  8 ++++++--
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

