Return-Path: <linux-kselftest+bounces-21415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9B9BC18D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A01F22AC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E91F755C;
	Mon,  4 Nov 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vMo30yro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE0139CFF
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763844; cv=none; b=rwmqo/dsUng+snt7EYFb+tbsIGHlthSsyB23jKROYw+Ndqcpu2zogqxKAsv5KwiQTjkPXneAYHdeGKiYXyv70YrwRnjbnkGFV5NdDCp8tazGMNGdZ0nCNR9i3viVTN/pteyaHXrxPMatCHFAB9X0iXKVGR+w7qSio4Uwuy6Z65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763844; c=relaxed/simple;
	bh=SWw/bUm3U36lZL9LqPNs1Smne8M+vxXN8DRpjmhsjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFQlevHwQfwbQqrrEGwWQQcj/ob1hG5OoirhVFmxSmvrCUIrINAoBcyf2GzAKSq4q6vZgvTjvSnleys/YG0g2V7CZYncMVy8Jw277jul1ggHkIl6ec5xBE3lvdGJbEFy1DGmNbAagJkvxCQ3BuqOD1iSTmxcbMuoUvp/Ba8Eynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vMo30yro; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72061bfec2dso4498224b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763843; x=1731368643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLcYMUnBRWzZFj/LVt8ipuQ3xIo4NMpvPvL21fi6cgU=;
        b=vMo30yror5SALiYRLyWeP5DupiJyqGVdGZnOqKAApa5NkbQzHbbjMdiCXOKa2QNZTh
         QDpH9KYCSGuk0whbALSR6O3o+jZw9KM7IGVW08jEq26coeKLdC2kwM8L4trV4bhuqzIa
         fcASmAjoHoUtNAQLoWGbC8tHUBd8Qc9x80O7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763843; x=1731368643;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLcYMUnBRWzZFj/LVt8ipuQ3xIo4NMpvPvL21fi6cgU=;
        b=e2J5OaiXKHafmn/MHTSivzYWdgBgcbZoh5ZEYOZKQ8oek/Xlzlsw4o9ddiVyMC9cwp
         fiXOzDVaY2gUoiWIe4+4GWGXHAzejR84GHrPd1BsdxPk/N2BQf9EqSshuC9+uln9ELIN
         iCLzsaNN/yM/UWtDYOjCKsdURsgPAHoaL3N25p40UiwxLhh4KckQ7mEpRnSUbZg898lD
         89sVBSCKHpPqDraM2Q8Mn06+8OShcROlFl6g//lW3tBBMLqF3KxBpBWtIoS6y8bGFEx0
         AabGxCeojP2EZ5rXLGitV6NAj8U/6hbHbfMLk4y8BPMVpD+6gEZQPXIReM5uHaZU/Zny
         gQPw==
X-Forwarded-Encrypted: i=1; AJvYcCWQgulstE/taLTU3AHyM0i9ZwkFeQif9VJ6awni5+iLjyLS+arCEpWvVxpMwfCbxHLSTq1kwFIV2fB9FV3CsJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xY0YGU5Fh/vsAiFXjRrMUl5t3ZFCooA4QNMc+zsIYIxVMPEr
	19xnSkR6A0Si8KwPxuG8k4+1N4cFQwW+f4AP4LRK2MID1czXCaSINohczEXL8Rk=
X-Google-Smtp-Source: AGHT+IEGtFKolQhFGH05In7ielsZJ18Moa0FaaFb1UggosOAGgKMTRSbOdnL36KtC0el2mXqC0AN+g==
X-Received: by 2002:a05:6a00:22c5:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-720c967e609mr22973839b3a.0.1730763842620;
        Mon, 04 Nov 2024 15:44:02 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc313502sm8231067b3a.182.2024.11.04.15.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:44:02 -0800 (PST)
Date: Mon, 4 Nov 2024 15:43:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 02/12] selftests: ncdevmem: Separate out
 dmabuf provider
Message-ID: <ZylcPyrfG8ATZYBo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-3-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:20AM -0800, Stanislav Fomichev wrote:
> So we can plug the other ones in the future if needed.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 203 +++++++++++++++----------
>  1 file changed, 119 insertions(+), 84 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

