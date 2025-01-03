Return-Path: <linux-kselftest+bounces-23858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE96A00836
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C718846D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0311EE7C5;
	Fri,  3 Jan 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnPqv8wy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29781145B3F;
	Fri,  3 Jan 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902341; cv=none; b=CyyDVkJ4l/O9uRV3k4LWHyxdjoc0vK4kkzaZWEsOPfv90pGOIF0p5LwZ1t46fO59CfdB9D7d74ZR6p+BfNkSPHhFxYi3X7WnQpfzy/4eDr5GL0bVTdEyqdd5jxv7IqUlBAm2W1TBIYhD47rdJF1kNOdwycDfrYzjjl+ZdooNv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902341; c=relaxed/simple;
	bh=YJI8It9MLER1LAtNqJj8grd3+cHthltZ7t1UimIG/2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN3j/RqY6QDBvTHAFyhr570KLTRUMPY7HHNTIagtb4N+6x+/c5dQh2MY09Drpirh7Yfkn+ISeOBEhMr6KGnxVy4Sm0fby5Kl8Y2jAg5tHry+AU30F97LxWuOKdA4e+IXDbhGVIYGKHsxrTPphLFaKHehSrMk5/0OwQ5gbI6VgHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnPqv8wy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2156e078563so145964825ad.2;
        Fri, 03 Jan 2025 03:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735902339; x=1736507139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9+1cdB54JxSAt6rsZOAJ9Py80cC+MG3NaFmGLHVZJk=;
        b=NnPqv8wygXq5fxTI/WqMZyfma2X2i+dgqaob8BmrDC6OlfS80l1oAKIkhea3vgNgGE
         h305AWiBftqfIsSLHOVgnNhDU1et/57gLlb+kuQMIxrPmb1hAG9S7FRDlzo9IeOik52a
         +9ZqhJ+j7qoh5N/+qzrqPCHLdlTAuNwqSQDy+7n0QzQ7+V8X1j/tqSTlvK+OfKXTELTD
         D+b0VV2vr0VuwxNxtDYmYCB3hX4XdcI8252kFbNE2XDqdTZe4Yh68jlcVUAAxlYeDwzg
         ec2bcpyD4/+SuzDHSworqWjq/vdQi1+C1Y14KdYX4ZAl1hTPo6FHXsmD7GfI90plpzPU
         jxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735902339; x=1736507139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9+1cdB54JxSAt6rsZOAJ9Py80cC+MG3NaFmGLHVZJk=;
        b=AA9yYud3yfYttYxvydmKb+qRKiKFWScB1g7diS7IhN/Gr0ATTBN3UpC0/yCaNnd22A
         IRSF/Q98PtSaQdlgp8MpnBKg6W3St4NQMAH8Ky4RajgayGy3lIfE8EZx8+4uAI1FGnEl
         EBrvEVzy0wlWDOt3SXRprYDiE9KoqULHxWlE1UyGz1lxt37v7ZY0HRiJO9UrDtxPjjFo
         bFeAOapeAFxsd2BkjhJusvGi02+nfOgbeX0eV5uBn62KZ/hmDsa0Cdpq2nSqjwydN1EM
         0vczABLDbVUzBNJK/sYGViwFpzPNwqTYIytS61r5/SjeSEeBx3pCiCOecF/iHLlspAvj
         ZqHw==
X-Forwarded-Encrypted: i=1; AJvYcCUWjvkLlhodOXE+WRaiIWhPEYlltktQRq+MprkrQQdWW6pf42aaq2AazYFBovKHWgKcb6/XauRu@vger.kernel.org, AJvYcCVbZUlB8H83eG2lOY22VB2DS8RLsopoE6fuTv4HAmJYrEwCW2Jkyz+Msbutu8kxtGPj0TqLAbGav967y8K1jyj3@vger.kernel.org, AJvYcCXcosO1JhciQKmw+6pz8EYhljasO762wWs3rRh6LqVwfFhAsUWH04QijZTdD1rw+0TqZNWqo1pWSjl1Vnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9y7AI3xepA52Y+wGa2B1KRX1ItduxeB50bDctKMePBvtqIRC
	S7QVrFGBvlvVQciHjCtwza7HqYIDvSnLwGn+7VrgOAFKj/jYlUxc
X-Gm-Gg: ASbGncu8g4i4p79aiW4aHN+igBb4hjlPhvXNhJKKJFFx78E0Xu7BANU8tdT0S+5nOTk
	8m4fMjhEkbgOmKDE80QTfGx4LRuYg0dN+Sv2jhOBnyhRaUSVbdrb9lpr1qhFirO0UuxWYBSxVrZ
	aXF+Fw/39PbJ/cKOlTJk16tb9XPUSMcoX2gKGD4nulgmmO/hCvq9fLgJJBsrmNAXZSr5vcnvO2G
	8ySIf9/GJ6t9gx8fY6Lykofcv4ezf17/80FYz5THQNNQdue3p1Y22Q2/R9aQg==
X-Google-Smtp-Source: AGHT+IEAJwmWKitLMiuIZmgoiD80ix3TQBXfgpvIVKEOkWoxuJR2d+vMta+Z0Y486kLspb3BxXgjpw==
X-Received: by 2002:a05:6a20:c88f:b0:1e1:dd97:7881 with SMTP id adf61e73a8af0-1e5e05ab1c7mr72577954637.23.1735902339382;
        Fri, 03 Jan 2025 03:05:39 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816459sm26833490b3a.23.2025.01.03.03.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:05:38 -0800 (PST)
Date: Fri, 3 Jan 2025 11:05:30 +0000
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
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z3fEevpdYybWQunU@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
 <Z1vfsAyuxcohT7th@fedora>
 <20241213193127.4c31ef80@kernel.org>
 <Z3X9pfu12GUOBUY6@fedora>
 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>

On Thu, Jan 02, 2025 at 11:33:34AM +0800, Jianbo Liu wrote:
> > > Re-locking doesn't look great, glancing at the code I don't see any
> > > obvious better workarounds. Easiest fix would be to don't let the
> > > drivers sleep in the callbacks and then we can go back to a spin lock.
> > > Maybe nvidia people have better ideas, I'm not familiar with this
> > > offload.
> > 
> > I don't know how to disable bonding sleeping since we use mutex_lock now.
> > Hi Jianbo, do you have any idea?
> > 
> 
> I think we should allow drivers to sleep in the callbacks. So, maybe it's
> better to move driver's xdo_dev_state_delete out of state's spin lock.

Thanks for the suggestion, let me have a try first.

Hangbin

