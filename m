Return-Path: <linux-kselftest+bounces-36108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB5AEE1FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9FF1663ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BABD289E00;
	Mon, 30 Jun 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7R4irFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722D28D8C1;
	Mon, 30 Jun 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296190; cv=none; b=s/GTDoi8JBUJUO0d9qXaT8HKkgvM4Wn72nFM8jAZ+s8K9/Tymvh0I2aZ8/CXdADFY6IasQfvswRp27BiC4s0PlbDz1XRIXdEU+opTrhpsuKasoI2HEUkHyFxJkof0op5k0S6aoR7a/KoPr9XyxF14fK4KjXvlvsvILirgK6jy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296190; c=relaxed/simple;
	bh=4SKYFeUksCtdAm02+LT5zp81+dVjpryciV93lI6OVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0WWxlzTAdLUKEObMb/kjU3hUtqFtjJizXc4EpFSOblmiRLVQULwoVUvOnm4u68HQrmj6sYUWSwHGpyIsROOfbQDqw5MY3ld3/fsrQuyt+pY4vuaRl15izAlMywxvL6MxdCG4sFASAmIvBCLnat+dsZwuv7eaOedF1jOTwG/AM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7R4irFL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso1623119a91.1;
        Mon, 30 Jun 2025 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296188; x=1751900988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4guoPOp9S8hneC+/OUvibBq2rBtRIktL3l8cPV4z/c=;
        b=W7R4irFLmpUKhQyoS/7gruJgTfTlTu4X56a960Skv7Zvw+TW0AuakySrnYy1j4Oj+q
         6B7Pzc9o6cjPiiQMCzXCX0z76Gut06PYj+Z0JhfZKpmaKpB69WXbvP+ZScGCnNSUj+61
         A/SAJ7heZ0Urb662Nl4SxzYck7sQ+9+SG4UfWkcA7DvzryV3MV4oGtORn8Jau5/6Bz90
         hK88GTjm3LYfoDLkymnyUCd6WpZSyqgwfQkyYhrlYwLYe51foVmwyx2NtP2JuOciLO03
         IxpRXMGGEE8Yw0LzkSGGwfKUYKMgXjt3BNChNoQok3aq31tIRMR+m9nTfjIw8LlOTLkO
         g9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296188; x=1751900988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4guoPOp9S8hneC+/OUvibBq2rBtRIktL3l8cPV4z/c=;
        b=FcD8LuDSUE9DmLYydxhGUGhCy+fopV7C39WnYxKphNTjwWOBNo5GDAuchec/yPfrDv
         F6YHHMnWps5OhkudUhZcNRXVLv/rsIRq7NjTiRJ0+OAKQdWghI+5HWVGfVnngWtZ64o4
         9yvTOqWpWeeUigHVx9m45rx1H1Enc+LC/tqPt83J/SML2cMvnGJ3EnITOAyptskpsI+3
         N/WOZ1vSN7yPrPhUkXUYIlyvRkv+jl1Njv7vma3CHB1lsGHsbMe4SvtDtW2LWJcgfSXS
         v71cReiKVY4WAaT3L0tz24Hf8MtIv0RCsWb//IdCPbAPrUyQmmzj40rF5wuY34Njknn9
         KjIg==
X-Forwarded-Encrypted: i=1; AJvYcCUsAKJhao/EbZTHkqXgZnGTryxMLfu9wvrdmS7cZArgUrafvRiJqnV1DbLYNvbNZ4soNo/DErjm@vger.kernel.org, AJvYcCWR01YyxiU4f24bRSVLBXKX7wlryZ6gvZ51CkkQaVy4IG4qQsIXCd+SJS2smGdKJG/QU472eKMM8qD5nwtdFeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmE2zuJfEd2Ndl0Gz8KTIEH1Tao0pbF8JZE2gv3p6qumPK6T1Z
	6mMAt0pi4KFjrNjyqM0XdDQllqeP22y9EOJGsojvCuQJOr4La+U/h+0=
X-Gm-Gg: ASbGncv2xB57MgCm6goq0IkqMqkfz9ALOyLkpwIFaPmR+i7hSUBbC2W1WPgECctWzJc
	sd4+wP7x+wTEm0ZkChNYxzfdISLc2CtY1rDr0BjYpVk54WR31yVJ2LJFjL/92bXVmjTzC7myte1
	qVxNdM5HAL8TDViS0FfQ/MskNmmKFmR3Kl+u9VRPZfWNK1WNnVhm0b6C7zuHCn0AEwREtdEzfBV
	gBrXJg7k47jvLRR6/fSbGjJc3LoY1z6NMuNacm4W6hLOS/dteuUNimjnFKxZ65pL0deLNAAPHAs
	WyQH5iByH8C4tBpAmm9S3MDeyeTn5/1pbaQN63abYOLl3RNV9XYwjcRkAd9t5vDQm8bRpxU17xJ
	2bcpOtIIt6aZ/UKlgHsKS2Gk=
X-Google-Smtp-Source: AGHT+IEPIgfjEBpbrM7EHhEJLTgGAYVR2G14rTnVcaqOeVmyfRniYNr3CP0RMkTub7HiMEfmhY8ZeQ==
X-Received: by 2002:a17:90b:4b49:b0:313:dcf4:37bc with SMTP id 98e67ed59e1d1-318c930f9f4mr15352262a91.34.1751296188124;
        Mon, 30 Jun 2025 08:09:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c13a270csm9222926a91.16.2025.06.30.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:09:47 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:09:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: devmem: configure HDS threshold
Message-ID: <aGKouujd9Y18lmQw@mini-arch>
References: <20250630092818.1449599-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630092818.1449599-1-ap420073@gmail.com>

On 06/30, Taehee Yoo wrote:
> The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> change it automatically.
> Therefore, configure_hds_thresh() is added to handle this.
> 
> The run_devmem_tests() now tests hds_thresh, but it skips test if the
> hds_thresh_max value is 0.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index cc9b40d9c5d5..d78b5e5697d7 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -349,6 +349,72 @@ static int configure_headersplit(bool on)
>  	return ret;
>  }
>  
> +static int configure_hds_thresh(int len)
> +{
> +	struct ethtool_rings_get_req *get_req;
> +	struct ethtool_rings_get_rsp *get_rsp;
> +	struct ethtool_rings_set_req *req;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +	int ret;
> +
> +	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
> +	if (!ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return -1;
> +	}
> +
> +	req = ethtool_rings_set_req_alloc();
> +	ethtool_rings_set_req_set_header_dev_index(req, ifindex);

[..]

> +	ethtool_rings_set_req_set_hds_thresh(req, len);

Any reason not to add this to the existing configure_headersplit? Is it
only for tests?

