Return-Path: <linux-kselftest+bounces-49357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D66D3A9E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5BBC300790D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC554364E89;
	Mon, 19 Jan 2026 13:06:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E203624BB
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828000; cv=none; b=FgGfp5CGDU49wdNoVf9XBhfM0SAmTs5RakvJvpxW7DOznAk2PXlhJfJX8ptVi6SS0P9qAo8A3O4lDS/2U/faQ61NYfnbsemsE9Y+OazvmP1Hc+QKw1ns9kMwJLH4u537sJ3gL6pK+oYfH+kWghHWPoOGuMF0/Nt/xNWXeEGe9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828000; c=relaxed/simple;
	bh=/Us8lcYjnMs3hYNfxM80VN6XaA/JNtNkcccthYwsPC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjs+RzCnWsJr2hkXoPmDLP+5onRZwqXP6rZ47IMJ3qEGbPsI+DsWwmbSVKrWSQzU6OYI4iKYsjqurVsfTwDNTUAhedAOJUIvYCBJRVqny5JPP+mwZNBE/MhwqTz6CIN3Yibv4eAT38buN4mPwqL7WNS2KhBuH18I6CHvfwdXi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4043bcd09f2so2776565fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827998; x=1769432798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJJUuT8FNDqR2jqcibTan0S0h66UkUo2QatHFq2fuGY=;
        b=f1nR8e1chP7oY+fLDEUtg3DC5VOxnGGsbtMzBUcuJyX0C1im0q7WlgK+SLJ+Dbawnl
         DChv+L+vGfLsVUJI8Rg/RS3O2WwhskAPZqtvoZ+HeMxoaCUVtsPa8rAfYQqJBT1M78zL
         bmkjbrcUaNq7rYusADQhsH9YUccI3AUIBwB0+6AM2O+NBymEe9YQ/OmTM9UGts/iGSoA
         j7wuIhgay6X6HVxBGI6DSjviZimUWOmuLMe9Pyc2PhRtvgaDjLogGiqzoWLReTmY/tzd
         UZEUf4aPm9m0IRWi+rZ/nZGNnapMPvU11DrPhWdudSZhVdUkwiKhtMmYiZJ8kIqZy0t0
         ZbEA==
X-Forwarded-Encrypted: i=1; AJvYcCWDEp1ahQjCTarnOfWChV4xjldqD65U22Fo71Vb2fpcljQYnYgWPSx8L44Gz1dCjOjgO/EudPOzRFADJmtGw8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUSiPZkP49kPDL57pkPhV/BYL+tZQ0eokf/VymISVjriqjYDW
	FfZwPnG30dgeywL0o7npzmkCB5A7IHyxSyPatwzyCsudtjigH9LrDALl
X-Gm-Gg: AZuq6aJ2DVSogxQl0cEBIaTJJhC6AkpmMrk887XXwniLANgXXrE8Cg40ZHJviFqBBQx
	8skz55lE4khKskBkbDGQ6iVvGtLeSrI6ObcrBxRwiMx5FdJF1Ny+Pm4JqPVgHPF4I05C8KE2EzA
	F+uD/Gj/tyMqdtrEmgqakJi3Ie0Hp80rN1XFWtYMmpdpFa1giD7l9g1SK8sLP+jhUWyHYo+Xq+U
	CLXKhKrI7Hygug4ADCJdo/UoRHIzo8fFHtx+HuAb4IeOvXt8FPxdkIdf02jvBCMeliTRpud18lM
	9cV3n2Z/st1hO3oLfrnTg8+cnPNJEiBiSDzvfRMU4OlmuKGdsoHmWXA3hpaHTbJYh/ygmEYwCLQ
	BFmcSsITZVNuUa0S2mQfEDi8xHwHmE6n8AsBzsDyQBGierI2SS8fEun2GGL0I7SrevLv0EaSqsu
	/dOg==
X-Received: by 2002:a05:6870:2111:b0:3e8:9dfb:8a21 with SMTP id 586e51a60fabf-4044c4b8903mr5238979fac.42.1768827998302;
        Mon, 19 Jan 2026 05:06:38 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5cf99sm6454072fac.17.2026.01.19.05.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:06:37 -0800 (PST)
Date: Mon, 19 Jan 2026 05:06:35 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/7] netconsole: clear dev_name for devices
 bound by mac
Message-ID: <eajjf6bdzw444nw2ggucsqcedhskheu4a3qogati2kxg6nj6c7@5iuyvjsp7nnp>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-4-4de36aebcf48@gmail.com>

On Sun, Jan 18, 2026 at 11:00:24AM +0000, Andre Carvalho wrote:
> This patch makes sure netconsole clears dev_name for devices bound by mac
> in order to allow calling setup_netpoll on targets that have previously
> been cleaned up (in order to support resuming deactivated targets).
> 
> This is required as netpoll_setup populates dev_name even when devices are
> matched via mac address. The cleanup is done inside netconsole as bound
> by mac is a netconsole concept.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

