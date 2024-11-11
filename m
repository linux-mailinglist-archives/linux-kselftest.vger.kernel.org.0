Return-Path: <linux-kselftest+bounces-21787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A229C425E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38968284427
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EF19E836;
	Mon, 11 Nov 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OykWgHsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A84C66;
	Mon, 11 Nov 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341365; cv=none; b=krpo8970vxmO9/a7U+MQVzJBMu9t9mBbHugHYBUMFrUFdt+0l68e3uVrU1B4X/okI4a7mDIvfz+deoinumJKDxnO+ytw17GVMgnpU+JTWb6RDvmDLYB2SmIkXifAaumvDZSdRFDAoBmS5RWhkb4SCr+wzK1VBD8B3nlGZtirCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341365; c=relaxed/simple;
	bh=C3hDKPMi8ro/fFUzo65/nRh6MyMkcb3ANZPXN8ZCN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUiPt6lKZMR0Jp1shoHPVKej0wRRDb73nwTXgiQm3jbwSfe1DOiiqorbK1tFiWikOXrzaftO76QHBQXdEafssrtqfenTspYk9qR2DmlY62TQMvvDTVrcN+0p2Gg/CZi4OigFPMmYSyTkX/fgbiszPs0ttxpd8mMdYtxo/5Wqkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OykWgHsB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3654132b3a.2;
        Mon, 11 Nov 2024 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731341363; x=1731946163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iY+ZJgltXfrniLx2byn6UyLdUM6Quqst+Zysvv4BTA=;
        b=OykWgHsB/vfLvikTmuSDzS2IHV2mrtfEFsTf4b8Lyq2lfUi/QK0n8OmjO9JlEG3c0F
         LxKVo+JmAHm5nrMR5EAvDAARYcbJ+lWlsHrw2rO6Dw+Iqw+iKHBz3QMWjbBf9Ppg3XsQ
         pd9APnaBlcChbx1Rf1GxGrvUwoXVt/xToQ9vo1L0iJddEyhfNG7y3oi78a2TN0/vHZZW
         0WSkihCEC/a0RdU2CQHkK5NhD9/Pmc6iTExPTT9EcgwtfzeS6krsphV29gw3blz5QUji
         56KOX5QotQ6DXelVxAHWtpP6P2fAtEMgrDy0eDVrBuFLTb5VmolAo/X23Kag4YgeyJTA
         MZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341363; x=1731946163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iY+ZJgltXfrniLx2byn6UyLdUM6Quqst+Zysvv4BTA=;
        b=KoZhyqq3Y+78PXP+XgUJarnrsnekG5EFsApD5Qa3GhLEhtgfOWb6sOJEu4WlVY20sG
         OOeIfy2/E7fomaJdcahlsKRGxsaDLW49R+/FWfS+Ps5GleoBQ4IOVGwm1jQNsPUL0fKC
         qe1EK0r0LaJE2Z7qHFRxwfa/il1HpAcjnquvbl/zzAkCWyGq8kUg/wP1yO0cyBlcwsr2
         m69kUhu7GKiVQfd4ojeKR/nhdYpqftzm9B2H3Yqg2t6cLB5/acsAVhllVHEoi/S0WW9Z
         yuepz+a0fe9ky2lhvvB9yjne4qdSUCVdjp4zqLWipsSKRFSN7Ve+++B6tFshAvP68xBg
         mYxg==
X-Forwarded-Encrypted: i=1; AJvYcCVIjr3Ryx3gLP9Fbr1w62Wq/P5Fndr6vakBtofDFFD5kGK/qXAt6Nuy6hLHV89ZL0D/koTvWrkCzltVeo/uuvKM@vger.kernel.org, AJvYcCXp5vaDNgGTfRxRHcZvSI6q4Lncz8PXjNgmlTgmCHq8VpVvlOSE4nLbDhXk68t7HRXd7Nzf4iRq0COw5HvqSs8=@vger.kernel.org, AJvYcCXqrIB9AMEA/pMay2mW7eUC39CHRUh9OFhk66Vf+3cUT1ASlPmSedzzi75Q8jOn+cxsWpcsL0J/HDWLjvQV@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIa5gbgMp0svnGUtHpdHqvjnMwttV/vkMQ23k4E1oDJWC8aYx
	XoDiw7iXdoW6iGaLe1mqFjKY0+dKPLqEJWmgH3HQ4E4ETB0NadRI
X-Google-Smtp-Source: AGHT+IGdXJsqRv3gpfBkjoc2DyCKI8nNMGsBFd+J9EL531H+nYTk6Y/yjvFtSiSo7brOE0VEefpjIw==
X-Received: by 2002:a05:6a00:3c83:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-7241314669amr20370040b3a.0.1731341363367;
        Mon, 11 Nov 2024 08:09:23 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a1fd2bsm9265322b3a.167.2024.11.11.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:09:22 -0800 (PST)
Date: Tue, 12 Nov 2024 00:09:19 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
Message-ID: <ZzIsL7P7wDCP2VBR@visitorckw-System-Product-Name>
References: <b31a16ef-382f-4b8f-b4d5-1c4d93803779@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31a16ef-382f-4b8f-b4d5-1c4d93803779@stanley.mountain>

On Mon, Nov 11, 2024 at 01:54:09PM +0300, Dan Carpenter wrote:
> Kuan-Wei Chiu pointed out that the kernel doc for kunit_zalloc_skb()
> needs to include the @gfp information.  Add it.
> 
> Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Closes: https://lore.kernel.org/all/Zy+VIXDPuU613fFd@visitorckw-System-Product-Name/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  include/kunit/skbuff.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
> index 345e1e8f0312..07784694357c 100644
> --- a/include/kunit/skbuff.h
> +++ b/include/kunit/skbuff.h
> @@ -20,8 +20,9 @@ static void kunit_action_kfree_skb(void *p)
>   * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
>   * @test: The test case to which the skb belongs
>   * @len: size to allocate
> + * @gfp: allocation flags
>   *
> - * Allocate a new struct sk_buff with GFP_KERNEL, zero fill the give length
> + * Allocate a new struct sk_buff with gfp flags, zero fill the given length
>   * and add it as a resource to the kunit test for automatic cleanup.
>   *
>   * Returns: newly allocated SKB, or %NULL on error
> -- 
> 2.45.2
> 
> 

