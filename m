Return-Path: <linux-kselftest+bounces-15482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDF954024
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED97286805
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDE482D8;
	Fri, 16 Aug 2024 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/O8gdI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE02A1D6;
	Fri, 16 Aug 2024 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780511; cv=none; b=OtMHwLEVmVCo1Yopu80qyhnVfVNzaRLXL9JYqTHjxoWnfRnwKHZ6PGsmH5/YxU9Njodsk8C7+kpxjSLZE5xBxbpKPhBjao0WoNYnWTzwFleviygsnI8woebQloGnAAikR8qGfQlYxK/8QtBuMx+dTYad6m4wom/NVKkY2KwDJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780511; c=relaxed/simple;
	bh=o/+DDGd1/Wbexz6Gbal1uojpi1Ysn1V+FWzSAZN2rD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEVtZebULiPSBTf5rKkN2lEBKzkOnWblIwvsshvi57o0aPGP2Js887usCMiKwDxQNTjeJOt72ab1d/bA8xqXzj4Nl2nePWuuw91xuRwMDOMm3XqETds0SwFYoZh+jXsXVP4v48ApQ/bfQGsFHSvl/EL8Y0W2hRkHnwV89yXR7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/O8gdI0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c99033d6so1011340a91.0;
        Thu, 15 Aug 2024 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780509; x=1724385309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNuYTEuPUHfsUReHgozJOW7b7xL4UsToICkgap6UCos=;
        b=d/O8gdI0zxBqlHxZsJGPFQJFz3sgSDH51L4peKyKSrD4gQQkE3cBaXJQlNp60SxqGV
         K6DSK4GntGAw2/MySAHDAqPlUx5ZsHe2HZd+d5oLBMBEX706BmonirO+kYUtYKU5aUrI
         tqjVt7+JJ4wNSiVqV8w4DKpOjlM4cOCE2s7aZz12sWIHo/nh/0XoWbWc1CnSvmPnZ0R2
         ncYURvqXTcYRu75vHqrkMjkP2ZFztyTputIaFkDRviGVePeMCIcJ8LbiSpRflebEinWN
         3M7iFF+mKFWg1WIaJD79jNQYd16jmHMEzPTkTCEHJTk911GORio5S8BNAaiiNZMXkbZm
         +sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780509; x=1724385309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNuYTEuPUHfsUReHgozJOW7b7xL4UsToICkgap6UCos=;
        b=dxV5/KQW7EDMqsDj0YHNiFVyCBmiZJo13Bz2OngSdTr4E5QHgY1aasDcv+7CWp6DIS
         cnnOtUcJmzPZUcgKZJtzddFhYAILM8cilYcW4pBVpeUCIFKUYDINcmrpqloXfG5iQmM3
         tkQoDvvBl5g98gGW2E/4BDw+vjYL8jPY0AH4rexJm0lRNkKlRMPVHT/hxj95HVqRJSLY
         GWzGM1/rPsc3iHj/gbyBmdLX2ydCm7S61cboIr8ixjYyPHbKatAGaGEEw22jbSqQkwuD
         ZJPnQQ3d+fpC/2qyDGysyP6K80U/oRufNdSOIt8oYHfM7M+zigWjDqzJKuV06XAfW8eL
         XEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8S1zhDJWjkUYJ3y6SYJ2XZCxI74NmY0DljEYfmjwAEDIQBTLcFs2uXYqUGfGn5PM2Tl6sB7wfP/trmhq2kBGN6p4BkVfl2LeyhuWxwIUuXPPf/MGAaSmxuaNEZduSMf1qv19UKRbZS6GY2HjZRjZU16jg3GmAcQAYp4K5RukkVicWRCGi
X-Gm-Message-State: AOJu0Yx1l2t4QETVD/1JpubpgQRxvvbOBX8tsiclmknNjWlO1YJEV74q
	7fvqjmDhH0JkFaZ+fpBOAZJmfW++fqnV2NC3sqUhMQo9mMds2aaB
X-Google-Smtp-Source: AGHT+IG7lAbb4wwRO6z2iiD5LVvjCZyq+J9yodmzxd12Gtjh1azYI/aPVWp6u25o6i0bxByQS9in+g==
X-Received: by 2002:a17:90a:f00e:b0:2d3:c3e5:b51a with SMTP id 98e67ed59e1d1-2d3dfc1f57cmr1895581a91.9.1723780508652;
        Thu, 15 Aug 2024 20:55:08 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac844e54sm4444203a91.44.2024.08.15.20.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:55:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:55:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Abhash jha <abhashkumarjha123@gmail.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <Zr7NlcFi7Bx_kdR9@Laptop-X1>
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
 <20240815125321.GA632411@kernel.org>
 <CAG=0RqKvw58-aN1onSjzc+WwhXk8uh_Ak=Po5gQyOmZUNgvaKg@mail.gmail.com>
 <20240815174508.GO632411@kernel.org>
 <20240815173818.12780279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815173818.12780279@kernel.org>

On Thu, Aug 15, 2024 at 05:38:18PM -0700, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 18:45:08 +0100 Simon Horman wrote:
> > On Thu, Aug 15, 2024 at 10:37:19PM +0530, Abhash jha wrote:
> > > > I agree with the correctness of this change.
> > > > And I verified that with this patch applied,
> > > > coedspell only flags false positives in this file.
> > > >
> > > > Reviewed-by: Simon Horman <horms@kernel.org>  
> > > 
> > > Hi Simon,
> > > Thanks for the review, Should I still send the patch again with the
> > > fixes tag and the target repo for the patch as suggested by
> > > liuhangbin@gmail.com. Or is it fine for now.  
> > 
> > Sorry for sending my response before I noticed Hangbin's -
> > I didn't mean to send conflicting information.
> > 
> > TBH, I'm not entirely sure this is a fix, for which my
> > rule of thumb is that it resolves a user-visible bug.
> 
> +1, same feeling here, I'll apply as is.

Thanks, good to know this.

Hangbin

