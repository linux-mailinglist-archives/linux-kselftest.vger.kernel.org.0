Return-Path: <linux-kselftest+bounces-21414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2B9BC184
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A0D1F22A8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138411FE0F4;
	Mon,  4 Nov 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oa0wm5Jx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED51E571C
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763324; cv=none; b=JQbU5h8oQb9Lxd6tAfP2IaU60YjKd/ysQzEhggovuOcyO+iGrVzY6YxaGz9JLqplodx/Uf59ZubGs2x6IEAbEfT+nn90riJ0IJJPXrXYQZMUl+ATBu+03rjm03rtsr6FDWnMP9CUUIlAk9XVHXaMXU52udibbyVtdIvfdpPOEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763324; c=relaxed/simple;
	bh=g12YJMdjzc4EaRnpMnl81wcVbqzgZX9A6uefhMb5jAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGNVh0+S3qfpMWCS7l4H7wDGDz6uAevaTVNO8HGd1rfpfhJgVIaXTENeDQcygS6zzmwoO/IfSfQiptsQJx+cQ9IU3BdTxEDWDJknqE/BCAvwguOcmA6yBbJVAc/eGyuYKrHq0WFtZtxfUy2D5iUcEmMoS64vc6gm1qhDjqfXdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oa0wm5Jx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cceb8d8b4so30927885ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763321; x=1731368121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=oa0wm5JxwZwci18yD/EmRq5Fag/WtQ3B3zpIBVmgCBF+dQOMyfiZOJ75FoL31UTuSq
         67QR5A+icRih96pHufUChzTw6GJEjKWtpFPSjLH3zOTA8OaoU6nFhWpKXfmCdcR/f5Xy
         H1zYpBGzd5pudrrJ4qiF+bu7NbHIuT1vz17gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763321; x=1731368121;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi7VyO8VZ7qQS5FFWVGxyjaV3VYO4ky56v65hKGcG2M=;
        b=rBvBIC+6dQZ/tl27QIBRng2yN8975G6RXeaPXOCEqJ6pfY/DoFCA41GSOC6SykExiH
         ZW9S38p/F5R9iB/LH++OxoW6M9dvW/BEDSHd24ihnImYpDUpYjOHhJmyJtL5F252ot5X
         yyB+tO4k75tI3yWYSFA9+CLx3+zgYfUKTM0D0K/9Ye9lThcGDBSfp2IstuTpXANeQVKi
         eKzXG5Ls+CXxWtyxRSSwHWQHzXwwfjOw3Zd4njLVCiaiS9e68FmO6JPoQqkpcOa2VTRE
         KGfovetVaU3//BElmLShyrfzN0+mOoTN+mxCFeU6FI5/x7HaacmONHPPkz/AuBw880uG
         jlDg==
X-Forwarded-Encrypted: i=1; AJvYcCUQfwze/V2pXjP2/jJQWCv9PpkA+Uaoi2nxcnWQT4TaFkN12Mkw9tu0275pIcoezn6R8OdeZmV9aWaxxdEaH3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYnz09U1WPWJxHqUA2VPshwYU/Ml1+S6eF3O5pF6Gzf3JCNaM
	KmItDitI/lO9JvL6NUYDM7P8JlHxtNBjP3rHXPDV/uJ/EL6zXoqjBZuLw3YAdO8=
X-Google-Smtp-Source: AGHT+IF75w+Ptq7bsaSssIf5M48gQfiKPC9x4jCAu+t9iSu+zcEnnB0a2FVmbeW4YMy00MxPy3Pi5A==
X-Received: by 2002:a17:902:e5c4:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-21105716ef4mr243171585ad.17.1730763320701;
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2bf7sm66763055ad.173.2024.11.04.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:35:20 -0800 (PST)
Date: Mon, 4 Nov 2024 15:35:17 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 01/12] selftests: ncdevmem: Redirect all
 non-payload output to stderr
Message-ID: <ZylaNahW4yhA0uC4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-2-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:19AM -0800, Stanislav Fomichev wrote:
> That should make it possible to do expected payload validation on
> the caller side.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

