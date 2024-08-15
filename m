Return-Path: <linux-kselftest+bounces-15384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB05952A03
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE71C21296
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6717AE11;
	Thu, 15 Aug 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0pHQfrH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F017ADE3;
	Thu, 15 Aug 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707353; cv=none; b=g2zau1NrpgjNWZ78UlQvJFAQCb/7g/NHTtqVFzbusRQbQ/MjrXB70blH47XofTSudn5PDOjBQJpRZz7IVBKlesGtdBzEYehHGlNULl3hEB4U4Gc9MKRUAEjuaCrCGAiUzTtwan1mk6f/w8TLZEX0XaUCfIpGmngF8q4AfGz6DrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707353; c=relaxed/simple;
	bh=/ClYCRhRXoARnrFGFZjHo8wcQMVacH8aXVCfxJFOCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHT+bMuSRZCyd3a/5bHpRUX11DprvUskuRfrU/+y43/vkgAZJ9P0QHapjYh6dmNwH8kRElR3QGkopirws1aeieTnZOoIp6q4X7majEWCWyrqeF+ryfOW7Hqr/lYCCUs9evNZ2YORnsPv9VtKxiGjJElb6GazVVnT48QrSbmcbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0pHQfrH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201ee6b084bso5812605ad.2;
        Thu, 15 Aug 2024 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723707351; x=1724312151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVdDh2W/DflIXN0zSp6BYnyUoARG2HTuRmiCmWARiGo=;
        b=C0pHQfrHng3jNyXSH9Qa/A/91ErkMPEafg8GaE0dgb1VRnL3rYv27wShsamqHVRSIV
         N62RSjNvHX9EImAD6vvMBTSeTv7TSpm4pmaJkklg44T9VzWi/pJ3TCNffi426YIS6cw5
         5jL9dPpbtXxxlfjSE2wSd62uyW729NvxvMYRJOx+NEtTpGpwcqPTQpOzcvIbkn9JPr+F
         n1XeVW5HE/3sJ5nf13ogp4os7xCyj8xODwnVcZ8oULqOJolvikcuE3/+GyyBU2K7Hv/W
         x2C6II0BiwbAw/1CMco+nTlqRhhx5hVawivUT6GCfEcWqeiF6EXOnXZlBDSWpj65To26
         aWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723707351; x=1724312151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVdDh2W/DflIXN0zSp6BYnyUoARG2HTuRmiCmWARiGo=;
        b=fNx6bTGCeTeoWL2OJpF+1ohKHPK/nEbVGVAqy38eDQx6uCWqUiNpLhyKls9UNGUbCw
         4Kis7ZEdfSWHpP6zXBkhaz0/1QAxoGh1KXpF34PeO+qY/GRqwQ/rGj0SJgLvU+3ZzoMc
         nRSNOU7gtFVmzBXyzGNhpaDH5p7yziTR7WZchHYZDBZPTi0Gx4uvyJ08brlCulgJqsGN
         QKl+RXSDw9ZjGvLhDk2VNZ3qZvcWCa2TDZQtqtlhtM0Vzc6bCzY9R4np7KeTsuMU3tPn
         OpXPDRnMxYFZZhUQdb5ynYbUQKimp5laAN0/xyfCkshD0+4l8lPLOBhB23f+beafLsAZ
         NEFw==
X-Forwarded-Encrypted: i=1; AJvYcCWDx9fWeVnvBx+lYcka2yPdFouOko8QSYJ23K9eA4L8DJJPgT4LqkJrntv/PThDtMYayRun+hWJzVWyThuEYqbSlmD4CJObN4Bf6It44NpMg6EHNnifkWyQUZPrx+MolqU2oRC+
X-Gm-Message-State: AOJu0YztHMPxFJ06fBgD7r+V047YWmo3bkgy+p0D2qNuD7RxxtRWQQyV
	LZG7hcz5d4wT2MeV6uANgdSStREU+Q2maOuG3Zjy32isMFvY/GsV
X-Google-Smtp-Source: AGHT+IEB1o4GZqA/yBACJA/I3OSxcH2OQMPFJY4wQdT0+6qsaym/npdQtE3ve32iDnp6RbuB/9ROqQ==
X-Received: by 2002:a17:902:d2cf:b0:1f9:fb48:7cf9 with SMTP id d9443c01a7336-201d64d0255mr64396895ad.63.1723707351109;
        Thu, 15 Aug 2024 00:35:51 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031979asm6025415ad.81.2024.08.15.00.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:35:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:35:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuba@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <Zr2v0Q-wJr_LTAzs@Laptop-X1>
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814173121.33590-1-abhashkumarjha123@gmail.com>

Hi Abhash,

You need add target repo for the patch. e.g. [PATCH net] selftests...

On Wed, Aug 14, 2024 at 11:01:21PM +0530, Abhash Jha wrote:
> The word 'expected' was spelled as 'exepcted'.
> Fixed the typo in this patch.
> 

Here you need to add the fixes tag. e.g.
Fixes: 136a1b434bbb ("selftests: net: test vxlan pmtu exceptions with tcp")

> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index cfc849580..62eceb385 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -1347,7 +1347,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
>  		size=$(du -sb $tmpoutfile)
>  		size=${size%%/tmp/*}
>  
> -		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
> +		[ $size -ne 1048576 ] && err "File size $size mismatches expected value in locally bridged vxlan test" && return 1
>  	done
>  
>  	rm -f "$tmpoutfile"
> -- 
> 2.43.0
> 

