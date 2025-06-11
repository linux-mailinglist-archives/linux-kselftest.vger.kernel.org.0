Return-Path: <linux-kselftest+bounces-34743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC70AD5A80
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C287188C7FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203C1A238F;
	Wed, 11 Jun 2025 15:22:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F11632D7;
	Wed, 11 Jun 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655364; cv=none; b=leh3IJjDaR3cy3HKibTJxpl7Uc2l2VLCEwKYuPd/PRTEC+6dC+d0E0bLR7js5udII3dbYOiUpPlCyYXnOKZpWO3rko5UL11nuiFasIp4oMRChKg7axTf6rdcdaUVQk9OwnM76paEkxD0sMiabk3lHbA5nhKMoDyrn7gooHZ13TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655364; c=relaxed/simple;
	bh=TW1ayCBNW5Vb+2luLmQ00rgDDT1bn12Np1BcZIBx7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1EMMTlbfhK17aB84Be7hmLIIk8FDPHHCgLdJc0x/bINvBKpRtvFVood1v+/X/QLF64oznmDkMOPPfa0kHrrJe/9N4WuBHhigXah1PNB/pHfr1wX+CDyXDNhyXvbsZBhMwl8WRCm0O3ZjRrj24MDjQ+JFLwb8nr+4FlVXbJt648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so1989670a12.1;
        Wed, 11 Jun 2025 08:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655360; x=1750260160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSnJBPEx6odgfaU8N5kmsIPZPJwYZq/K2WTwH3zBoJA=;
        b=MMd+0b/PXDPj0+j82KrgrpuNuDgmz4xdTbLB4w6KTHy+YJ4fOnjSGW6A/ajz95QpNp
         9a1YrlXdLH21Zg/A2lDmPu+HMECAaZ0UMue7WTAhhTZwlSHnB77ZZrAVjTkOTv3qxSwh
         0CkCAS5ijHsOgmATxIhqPH08jOacXzhn9oPkRJJTHpGd40MM+Y9PYyNobuu4owGilk6z
         2apDRmfSzQvShA7cKYztaHunoYYrH8HNv2MvjiDOmpcT0KZNYCExPkY+8thdoBdzDqvx
         pOEG+KEXuL4Uee8MFYPm78GpEz/fcack/uiSBmmrXJqmz4JrZ94UgOB45lqLEJ13fnOj
         xMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqrAhbL7Yl0wIxu3kpZRmFO07/BKy3Rz1j8cLzDzzyV4IEqiepzbzhZfloj0QsD4Ixku9ruZ7a@vger.kernel.org, AJvYcCVWbtHpBJWJMCIi3aUNQPxTrx9pOQhHDEO2bB97omKb5FU+F80xjnqCGlPKMXSBSuR148KwvowW2BYa3Uu1Pkaf@vger.kernel.org, AJvYcCVvyFsWkHxC9O7aFrGx26o4hPBzIWxREJQnpTp2/irLzGl6TtrgBFWWzPNnfeti0138lfy3EJU6IzKe+MBX@vger.kernel.org, AJvYcCWSpv/Cehu7HhYuhfJMym8COuwfoPw0tP0E72dDAIyyszrwwH+UOImmiRga0pZ6yklU4PYAwCuQ6ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FaQOxR/j+0+GNa4Kh8X9oqVuj5eTKSmfDieDonur4dN5t/P8
	uP3Jh3QyyFXpPwzNRsGOUHYn9WGJjehBbMUQRl7FD1enhwotr/SKU48z
X-Gm-Gg: ASbGncsw7WFfkAA6rMHMMin0m6HZofGeHvYnUbilVuk3r6kbRm3/83TvEIa21K8+iPC
	OhW2HJfgG8GoGN6y3hJ4+B2m388NVNVJ7m4yX0iQCFGC3QjsdwOoa2pfTJ2T+e31PrZak6V/tO7
	aNvq+Kc2dMcC+LZ4oAlbL9oDICAPdckmk1aLlUnzaftUf/mTK2WkL9Hc46B63mIJIene6ODujRI
	dEL+b3kzFVIiPSl8ibpvSSNxxaPaaN3Sf1uui2DazSvrHH79iXOd8dApxJLv2GT7g6/jBgKpHDd
	lpre2o/hYJsTbyYNKwSNSziIneiA6gc6DwifYy2ZOP3OdTqoDR79PQ==
X-Google-Smtp-Source: AGHT+IG3vasi3xQDrC942RMkJzAr5DOPhWYhyEtc5CKb+1W1BKeUx1PM+YlMfA2JSV833lGzUJx/iw==
X-Received: by 2002:a05:6402:40ce:b0:602:a0:1f2c with SMTP id 4fb4d7f45d1cf-60844ec0490mr3365625a12.9.1749655359752;
        Wed, 11 Jun 2025 08:22:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607fbbdaadbsm3995293a12.51.2025.06.11.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:22:39 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:22:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] netconsole: implement configfs for
 msgid_enabled
Message-ID: <aEmfPfxxkB3FxIkx@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
 <20250611-netconsole-msgid-v1-2-1784a51feb1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netconsole-msgid-v1-2-1784a51feb1e@gmail.com>

On Wed, Jun 11, 2025 at 07:36:04AM -0700, Gustavo Luiz Duarte wrote:
> Implement the _show and _store functions for the msgid_enabled configfs
> attribute under userdata.
> Set the sysdata_fields bit accordingly.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

