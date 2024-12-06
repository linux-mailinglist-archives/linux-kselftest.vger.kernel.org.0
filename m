Return-Path: <linux-kselftest+bounces-22924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D29E77C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA3283879
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF21FD7BF;
	Fri,  6 Dec 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OfuALeJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB71CD213
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507959; cv=none; b=jUbLnUfzi7Wm0heEoVUMZ3MQq0OcpJACOncSKURnfyea05I+94rgUWtH9DW1u96IZG6LHmpR5pBuD0qEonjjqPLnnyldSjhi6lj9PVCyLFZYgYPqlBtKpHTxplNA8CzB3daydAefsaKL8zt4UhD4q/y6m07kE1wqIIwLPdCnOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507959; c=relaxed/simple;
	bh=C7/IjrZPAe7jrd6+Hvq7qkkD7bICDlJFHdbE7CmOEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmFmi11OQWoZ1NTgtibLBmtKlQQ+aJJnOWXsbLshMjlciB439szC/UxDetAPw0gci5M++lm2+noXxUuyCaMFD3h+PDkSHLV2OOrQgSK8x84BtZzxQs1mgwtYK5hq1GsUStLLYUY5/F2vZULWMfQQr4CCui9DEMGWPTbzuj7bSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OfuALeJw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72599fc764bso1950886b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733507956; x=1734112756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXWTnS4ACRG69KERwtrtjSEjtFzKArian+QB5LBEOK0=;
        b=OfuALeJwEBFahJQqD6+JikVEowM5iKse4P5UTho6ywR5DQhoR6FYDDvFCcvSsWxB4+
         Etvt39nLzLVrsoEU7p+jCZn48LJB8Q7b3ctVV2Z2d/br4bz6DaofuLC28MZRr0hOrLlW
         Q5md3+NdEhM/nmdEHtGj4YR3PNLpHSjaJecdcswCzb+t0CErbqj4O7mHEK+FH72IwO0v
         BXbqzR6Uf9HvxymXMAniW7/16xb+YZdGgegV31J6cO0Qx6Re143ZgpJY9Z/aTu/oinkV
         wPAP99bkEYhcCIqHw9FI4bZsEsq9FtbMrdH1zQ64CALN4mYPERu0AHOfYUnJU8aqdEYX
         oe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507956; x=1734112756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXWTnS4ACRG69KERwtrtjSEjtFzKArian+QB5LBEOK0=;
        b=mbvUnWdaGiM0Wn9FOmVRE6ybBtjaFxth4Jivma0+lr0Bmn0JTHVA+x8/k1qE8MAYZe
         4R8E6qySZT4xyahURsi/AqpIkieroO+BB6BAS+ju9xDlzOPKmjbm+EevFOoYQnspm6Uv
         VPv3vG3LzoGRTBMrdRn4u+fGPyM4Wg+tq1Uti/nLJd3+R8o9PrSq0y/bctCqtbYspLzb
         SU27zdJ4c/F3XGqvR1QyvMgTvBCI7/0MGif/NUp4XiUHzffnYCIMOeaQVn9/gczJD34L
         KVt7jGiia7Iu/RoFfFwwQrSak1zDUzWg/Vm9R0iiVAaHyPPO7w+hA9Wn9994hFxeQI5P
         Toiw==
X-Gm-Message-State: AOJu0YwtG8qwy7REzrg30GmLfhFabX7LKg8DnRGpTobRRZwS9Sb7xWoc
	FWhBsePFgNyvoDGIj1RSuHc+G9JXJFdyjY5yQzBJ/l0lsKSQMpBxXTKPFGlubOE=
X-Gm-Gg: ASbGncv/2WFiGhyU54x1zJ9/0uX0LXCO62abT0+4S5fbYX9fEr8gW/fibGJn1+xe0wV
	B3zdYxCEI7OA2Dggk+Fl5FDXxi0icagkVmJFyCnkPFoz0sLSloWx1uSKgSM1MxNMr1zThWf5EGz
	UhJ6TOglnz2rSeNCt7JnjZYmY3RZqJIh1LWivaKskIXLs+Y5mCotrLPI7sJVSlPE5rbMxE+7FiD
	vlpN6L4/xmr7viVZVdmZSYZFQnZzhv5L3Q1UN3H20INVw==
X-Google-Smtp-Source: AGHT+IE8qx0uEW+Lby99GPzuztrI/Tze8sHzsHxtrWCEM5K3xCHJB/gtU8TFHEdMyknysnx83WZqKQ==
X-Received: by 2002:a17:903:2b08:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21611afca0amr56824085ad.20.1733507956637;
        Fri, 06 Dec 2024 09:59:16 -0800 (PST)
Received: from ghost ([2600:1010:b0ba:197a:c0e9:4a0e:e502:edf9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efc906sm31536465ad.166.2024.12.06.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:59:16 -0800 (PST)
Date: Fri, 6 Dec 2024 09:59:13 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
Message-ID: <Z1M7cUPhV6D6yXlX@ghost>
References: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122073725.1531483-1-lizhijian@fujitsu.com>

On Fri, Nov 22, 2024 at 03:37:25PM +0800, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>      filesystems/statmount/statmount_test_ns
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>   sorted the ignored files
> V2:
>    split as a separate patch from a small one [0]
>    [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
> index 82a4846cbc4b..973363ad66a2 100644
> --- a/tools/testing/selftests/filesystems/statmount/.gitignore
> +++ b/tools/testing/selftests/filesystems/statmount/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +statmount_test_ns

Thank you! This is still an issue in 6.13-rc1.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

>  /*_test
> -- 
> 2.44.0
> 
> 

