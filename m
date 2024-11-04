Return-Path: <linux-kselftest+bounces-21418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A119BC1A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD41282D68
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E31FDF93;
	Mon,  4 Nov 2024 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xMzzI+UG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BC139CFF
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764119; cv=none; b=isM53GrsVGVFqVqhy7gbyoINp/sGsF/YOhePNH9/CUeDfuQJM1x4RW8QTUjR3W92N0j9n4exQrli/A2kucDGrXWfcxiGxCuMAt9DxVmz6gjf3C6VBqYcq0xRaCxFjXx3vfViWtfnXRzzL/OVaBxTa60194ql5lz4h7Ky379jTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764119; c=relaxed/simple;
	bh=fheCF/gyDLZgx3iDrdSIvn1qSVyQ83QryjFW9Al9qNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV49vfM+mANJnMKgjpmqEYz9mAd9G4XrlwpVH7JlzKqXjSmTgAVJv/Z1y66jr0SB5dPKFKnItf+JetPFoNmEbp9s6Td3p+wbwOXNaIPzdm5RZXGF1NGXWSWvojx6hD645rfM2I9nAGCrljQf1pKcsMXZtYPh3HNSF1zIxV1NTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xMzzI+UG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4e481692so4704001b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764117; x=1731368917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhLXEc7Psoc35/IvkhZF+2gK0RwcJpvg4PrUOsIjpfY=;
        b=xMzzI+UG4S2wDDhIKZ62R1Mu+Nvq8KGK0eG201Suggtz/P9eYV0TM/m2Qk5+zALbFi
         k5fbsE6Wvl+x37aHVQn9jgdcqq6Z3MpXCRH7vsWbMCmjwEpbTXHlCCm1BSwKnJBXjGM/
         CSJrsk0LfDqPizONcz571ZnZw9RPsxVipSkjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764117; x=1731368917;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhLXEc7Psoc35/IvkhZF+2gK0RwcJpvg4PrUOsIjpfY=;
        b=C/Nni1cohTAAO8t7lW8ABd0MjWnqYyqXLySAaIKRfvn1hNvxlj+9KB6u/hBlQt1zA+
         m0TDB6TJ2YxzQrJ0RIwTfMPdx1owfpEa7+eepvi8BnaMs+TwB6I3cXvxPCIJozyXZ/rw
         UUTIfBssKuLDFZHrZyfL3i8txZJZNb/M4idrEiq+YNxTGkBZOXZZMXRoWU0bvZHsaqkN
         k1hwD3/I0IyzD4HXAElzrhAApkT27rn3fYCDHwFDazJDmutjnxQEBUPy2GUXbFyeqlLy
         xgPRdgduQzIaf5Jg+B/WNbWeQVlxBH1hzgXQeLxyVtAjftPPNnWzfbel/HRRyF+KhEvQ
         iHXA==
X-Forwarded-Encrypted: i=1; AJvYcCW9gtc0QKCvM26fjWFQ5MapFIPvfjGpm5xFHDVdfSs9iIU8WsiMGkvWyfftlcciNo21N6/ZSQfJK9PHK3BDs7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnSJCfcYmOF7MUXdOxCxhaBygUGgTXKEXfk3NTacHxY+BKlZe
	urCyLoINNdRE/VvifN8q5FJaEDVLbqNn6o3SvIA941rbQOutrPjRBkAuiODyphI=
X-Google-Smtp-Source: AGHT+IHam0CH1GsyhrKIPmW17xNBcLAbEJeoQbL8o1S+FhQThyRs09uEiRGHTxXe793CArFiCPT6fg==
X-Received: by 2002:a05:6a00:88f:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-720c990b37amr18395998b3a.15.1730764116811;
        Mon, 04 Nov 2024 15:48:36 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8cb9sm8494097b3a.11.2024.11.04.15.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:48:36 -0800 (PST)
Date: Mon, 4 Nov 2024 15:48:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 04/12] selftests: ncdevmem: Make client_ip
 optional
Message-ID: <ZyldUYckz6Ja_rsk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-5-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:22AM -0800, Stanislav Fomichev wrote:
> Support 3-tuple filtering by making client_ip optional. When -c is
> not passed, don't specify src-ip/src-port in the filter.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

