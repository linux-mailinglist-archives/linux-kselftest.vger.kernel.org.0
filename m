Return-Path: <linux-kselftest+bounces-24041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAAA050FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 03:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEF43A2269
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE556446;
	Wed,  8 Jan 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3t+pXwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2D2594B9;
	Wed,  8 Jan 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304412; cv=none; b=D0m+JtmFi9i69SkE3G/NhTc7Ck/5V7gfuF3ZJ3bu3+8NSxmEIsjMQ/pdrUIpiUPVplFCDqHGyt/PHxIPpCuLyXWm/yKMj4uXl8ihMd2ngrJmJo++8tDDCkAPaMlpm4JQ0m0lHRFBS2KL2Twqt59LGLmeKN+Ut7yk9uDF9MDAItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304412; c=relaxed/simple;
	bh=9eWmdF6gs0tLkHhvzbNzvV9+rB0KFa6F0HYvPhFDViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJIcCH+1FjrHDl2FZ4X57G+UPtorRUI5Ri/iY2Y2fqn8A+liJqogxsN0uu38AtGhZw8M1oZ5sOTmjtzYYrC3OeAHN+UH6jOO4+S1QFO4kQ2uziiLGopK7vKKNNMZ3d+NqFREoHE9QQV6bgHszRX+JwE/Oq9vSmjkmgbGeYHQOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3t+pXwD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so208766665ad.2;
        Tue, 07 Jan 2025 18:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736304410; x=1736909210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwMIaOWIX6HK6xtZj32qqz+aCv3HfqyGs0CSVnT0OGc=;
        b=b3t+pXwD0O77OgXICkQ3J68IpCc6D2fOk01q841mbFPelFLZKKn3iPAUQjO4GyjZYj
         qCcp2UwLxCZVDYPxSyIL3ysZgubJpZv3ycKyS0fBztzRGtTP+9Zu8u2ZS0G3Gr4p9s7c
         Jzm80yBn2G3TYr20zEbaWd3+HPQimFsnRsIvip6sdJTan/uXi2fOijEVKEHWxGN2/94q
         hVFUpQom7z5Pz4JniLSDIXVn+39seDRpUorEMq39OX/PVAKxj05ldQkaikPfZfIBZGBz
         2sKxUzdegpCUhtl+xyZ67XKdP6zCGi3W3XOdTe/YUF8+s0D4evM13J29VyJhl75AHHP5
         QTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304410; x=1736909210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwMIaOWIX6HK6xtZj32qqz+aCv3HfqyGs0CSVnT0OGc=;
        b=oE97Os0R4SLRZ/05defASBZxEj318hJBV8zw9OMrMOqtOpDf2QEgxgEvrUMwSlyB0U
         I6ggSvjIWwcqSbWFVvzjq7XiOuwbWJJaoc7MaEPtcAVLEq9MhXs+G0sGoOJur1RdBbrL
         x335rXVSMzpBWzRnXURM3QSfy7dfIFttYbpmz2tmIzc140+xU0h/iZodx6/Nuk+47xMC
         D82xrFyqADYcLxSYeKrg7/d7t9uJQ73UYknA1IhsMjIzvzrxrs5nqsr+W2blGb6ZROpu
         IRl0iV7apMWoKj/TObkMjthVYRRzV4/KWk3a4i512MkpJYWSNDa0sC00LcnzhhR+2qlF
         rNhw==
X-Forwarded-Encrypted: i=1; AJvYcCVDtcOsTAHwDxNnhKYFIZeWEe7CWwIORC1kzo2PWxzuEZzYJACOAKbCvLzZYbpf+ONohf5Tnd5I4q+ZVE8ytLCR@vger.kernel.org, AJvYcCXcQ8LQtWAHHhYbfhY5LTENcIELLHMMHDPV1dsCqnTDfNTjVsm91cdkyY+NY7XfFnAR3u4OJi1j@vger.kernel.org, AJvYcCXoEC84U1ozQFiwZLMPzKhvNgxvmp5tBMgh2/wE32gkAeTXJmdenO85MRR55EvDLJs2ttAsmebC6K+d+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkTCdbnTd2Jd8hTkkRIWMWV2MPJKQJ8HofeFKmxc1639OJDL3
	LBQbonLON7/Cf7xgd/xfOQcAUanEPk1X/VDAaYNSjYwN7OTtWJld
X-Gm-Gg: ASbGncvAmoHeFQRjR9n/i5qDIYA9ze48Qkr0H96Df5KONFCGd66LYDbcZtolNH+fzR9
	ZVoC5O97wu5Ch9temqr6P2jBoPccZ2rYd1Fkh706mx/qYIQNMdXrOAJOBxq0o3M6wtwSMVbRsFr
	hmE+8/2AiOJgZm2BkOgsFy/IPhltWLr1FeMAq1+9yBUgk4N1Vo772/X4uyK7y4VnD3I+OW75bia
	XOnJqAXnr0Iy6pxq6uVxoRNSu8jltBCC1/n6GxAFdwD2QWAFH4wi6dsyF89Uw==
X-Google-Smtp-Source: AGHT+IFWAl/uDIwvcJXeb2PkQ0/f6+UTvUH+WsAb/7LCQZYCq1eMHz9xtQSe4bIMQ/T7oHi8QGnAmg==
X-Received: by 2002:a17:903:1cf:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-21a83f4cd36mr21203355ad.23.1736304410114;
        Tue, 07 Jan 2025 18:46:50 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7356sm317570365ad.193.2025.01.07.18.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:46:49 -0800 (PST)
Date: Wed, 8 Jan 2025 02:46:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z33nEKg4PxwReUu_@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
 <Z3u0q5HSOshLn2V0@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3u0q5HSOshLn2V0@fedora>

On Mon, Jan 06, 2025 at 10:47:16AM +0000, Hangbin Liu wrote:
> On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
> > > > Re-locking doesn't look great, glancing at the code I don't see any
> > > > obvious better workarounds. Easiest fix would be to don't let the
> > > > drivers sleep in the callbacks and then we can go back to a spin lock.
> > > > Maybe nvidia people have better ideas, I'm not familiar with this
> > > > offload.
> > > 
> > > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > > Hi Jianbo, do you have any idea?
> > > 
> > 
> > I think we should allow drivers to sleep in the callbacks. So, maybe it's
> > better to move driver's xdo_dev_state_delete out of state's spin lock.
> 
> I just check the code, xfrm_dev_state_delete() and later
> dev->xfrmdev_ops->xdo_dev_state_delete(x) have too many xfrm_state x
> checks. Can we really move it out of spin lock from xfrm_state_delete()

I tried to move the mutex lock code to a work queue, but found we need to
check (ipsec->xs == xs) in bonding. So we still need xfrm_state x during bond
ipsec gc.

So either we add a new lock for xfrm_state, or we need to unlock spin lock in
bonding bond_ipsec_del_sa().

Cc IPsec experts to see if they have any comments.

Background: The xfrm_dev_state_delete() in xfrm_state_delete() is protected
by spin lock. But the driver delete ops dev->xfrmdev_ops->xdo_dev_state_delete(x)
may sleep, e.g. bond_ipsec_del_sa(). What we should deal with this issue?

Thanks
Hangbin

