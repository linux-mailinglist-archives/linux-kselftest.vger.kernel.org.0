Return-Path: <linux-kselftest+bounces-18380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DBD986ADA
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AFA1C2105E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8131714A3;
	Thu, 26 Sep 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPySTgRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112F37B;
	Thu, 26 Sep 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316783; cv=none; b=QlUHt0OKk78Ej4mLkCeFSlXXtGMRSN1tzNWwe6YP9zjHyIcMjfnn0APlj6elRs9LdX2xIBbUksEawiivJNWYazM0nMw9K0TEMlI5sebXfbvGLMHsrjUwnOILsK3oYjt4MlVZ8hCFnyVArSbAsMsOCVUJ10Cx4dEsT/0w+Kqn7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316783; c=relaxed/simple;
	bh=VjYhNWGf61II4CY2QxOBu/gnUytEAceOX8dWG0RVpL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hokAwxnP7yR1QjD9paNEDKg/PMmmrpAh/PGZDhxORmXbE+T53l108wTOL1kLAEHu4O43U71jSpzDoBNb0yGTZCHGmjWzAy1l3SSDhIoIxt8eftonZ6M5sc0e7vyQK+r35Xi4v3fAApnjHgi+ow0QcspbkUoPDkhf+zyQUQWBmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPySTgRY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db238d07b3so332217a12.2;
        Wed, 25 Sep 2024 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727316781; x=1727921581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKbqGClK9XuI5to7fNeVcZww22R2M+z08fDYXnkwHOA=;
        b=DPySTgRYpRSSmQgazZGeTWwjbCs7gaEBFO+RDwkacHEnkq1RcVG8tp3c22q7qIP5Ud
         ZnPB1FKr0rx1eLUHYKhrN6E+mGUwB2Qy9ui1974pCzaAlTdukXlyUAZvMCBMQsnfWteh
         oRoQD5177ujAPJcIlqWN9PrDwRLWL92ICyh2xw757P3B6tiKSkcKibCtzo25rnP25JqD
         ym+dCSIxUkZ6l+QjDHjdXE8kuZkQ/vriR8X8olyErwE525t9ammQweWxFQhX43GDCYx0
         w6H7KQRDsiAYNwR2vGTLCD+zlHmoHC6RqR6L+id8QAkqUKJddF07ErdHOoP9wyE+XW3l
         qKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727316781; x=1727921581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKbqGClK9XuI5to7fNeVcZww22R2M+z08fDYXnkwHOA=;
        b=bltUU26GGRkuy2dCkAvHc+jwjHgz57IHsVIUcQO3pXfF90EfayHDrv7yfMZv7IdHmf
         C8DzLMvgIabNOkwp/yhVrYJVWX0FToZ4k5bguFlwOPqt02Mf811L21ew1ewWPJ1Q11FD
         tUXGS+hF4SobkRRDDiEDRR7wfL2AcVI5TqxveX5lYYfLq8dvnlAbDp6tPFEIBqkfieWe
         xPcFcdpnb4sQU3E1vqywiE76PBXoW8Ti8rr4TSZGKzjHplGu4rAzSEJ47nDJ8M8Gj4TU
         NkCPM4I6LDAolny1JuMgHXkz56mldufvzH30aOPtW+DrwZ0LdC2zIBo0GK2C6loHWwKA
         AuLg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJrDdV5ly2R5fOZrgTuOWJ9t/50xV4QCLocnbczZbX0GWbTZ5ZZErWETrf4zqPj74AZN/eY0xV+MRrzYBt4Dc@vger.kernel.org, AJvYcCV0pxnonmHSYS3zeOK1r2QgNBsHiFZtAOYLhXI2MgyfJK1mfCRhQEHv6U8MhgBllOltaHOlaH9cK6A/2AU=@vger.kernel.org, AJvYcCVXDlFP7lpvoElWeYta162piskiePWs4lYGKwxYNKqZqJiUTkGjKZ05VEKsoi6WSoovcOT6zjOo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0N9wfkqIV8jTRIRxmnQpKqzopONh0vYaEF/pRDHnR0LTSRmE
	z1Q5oTL/rKQK4vLbAsHYggdXDGAQLZtcjvvPlBqjv2H6zfhZ0qLYkHYbV9LOdD7XgQ==
X-Google-Smtp-Source: AGHT+IFYcQSZQCHuj55PggHLx3bP9KBNAy6SA4mEMJ+O/Vvb7sFmAxPMVqtdc9RD6/JUJ3tKHOqGjA==
X-Received: by 2002:a05:6a20:4393:b0:1cf:d746:22d0 with SMTP id adf61e73a8af0-1d4c6f307aemr7221549637.1.1727316780917;
        Wed, 25 Sep 2024 19:13:00 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c3a9sm3323292b3a.168.2024.09.25.19.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 19:13:00 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:12:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kacper Ludwinski <kacper@ludwinski.dev>
Cc: davem@davemloft.net, kuba@kernel.org, vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix issue related with assigning two diffrent vids to
 the same interface.
Message-ID: <ZvTDJyKatBVpgqMj@fedora>
References: <20240925043724.1785-1-kacper@ludwinski.dev>
 <20240925050539.1906-1-kacper@ludwinski.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925050539.1906-1-kacper@ludwinski.dev>

Hi Kacper,

When you post a second patch, you need to add PATCHv2 in the subject.

On Wed, Sep 25, 2024 at 02:05:39PM +0900, Kacper Ludwinski wrote:
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
> ---
>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> index 9e677aa64a06..694ece9ba3a7 100755
> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> @@ -202,7 +202,7 @@ one_bridge_two_pvids()
>  	ip link set $swp2 master br0
>  
>  	bridge vlan add dev $swp1 vid 1 pvid untagged
> -	bridge vlan add dev $swp1 vid 2 pvid untagged
> +	bridge vlan add dev $swp2 vid 2 pvid untagged
>  
>  	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
>  
The patch looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>



