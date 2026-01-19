Return-Path: <linux-kselftest+bounces-49358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2ED3A9F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5527630028BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643D364EB7;
	Mon, 19 Jan 2026 13:10:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3C364EA9
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828213; cv=none; b=eNqB2kdwq17zecyopFtOYrjyQVAxhaNvZUoEIP/W45hoRQRL98lDX9ny07sXOF1b60HxdUvMGaL5xQnR2dERApnf+0LJglwZrZpY31rQY9ZvhDYXYNRQgsmVgwYYjmHr+gST+ryWgSYgaWQ0nQhCEhe84dk4VPnujKQhSp8BmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828213; c=relaxed/simple;
	bh=7Zau4Q3L+wZoTMe0dwbmPaGjdSy92gfx9V0yzD0gCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxtfs8oi2u/VR0qr2hddLKYQLdUkdvkYb97A9l/A1ZLLHSOeYCC3j35edWuNZPmDAW0I63DZiD6h3c76VprdTwH51Aj6AUavAZuuntYyTpsSlYTzD6IKJcYfyR4z1JeTIjaPOhs6B+NlpPHzCFIWHA24TQSuqkJKaHpTZpXcS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40438380b88so2652918fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828211; x=1769433011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcJjT+zAvg6W3xCA74ueew1cpFbuijNuFU3eUN6vwuI=;
        b=r/Q8QwnK0C234Yl0SaOxgrrc5Bw2AC55KsGNk8qOeb+nrYE/rUs/yCh9JWSbv07+0F
         7gksMzOUM1/U04ryocFac0e6VUywsHAM+gD5uoDYOAqJvfCiRRGMW7MIJhjSDjVaonQM
         rEdTwxJ5ZYMeWhL4MJOj2i/0dMchSP1jJPYoyRyIdCoJpPGPGua5amRVfx+YHGvr64wr
         uaGM6u4rS6ZnUGzT2DmijdvcplT/08tyGewlhRd6NpozISJMDajuLhgYVV6eM+WjR0Ng
         9Vwn7sCGqN7iEri+y1KKXthkQo5a5i3dkUFGv7XSt6CZmqpuwm1NbX+B97Mee1dRu8rX
         /Efg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Xq2OLs1lKBB5qnLS43V91EDN+fofHVhs8OIbEgTrLL77rgZIF8ktOuEUpuoWJ7QEeOTbrHJdTjdquWKX4xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLlbNuifx5GoZTNuUbRQ//0rxEDSoOlOBthliwrtfowe2qGug
	XnJzPLC8KP+xN3poH4OUqCRWLxs1Rul3hyKLkS9JBau4Q6m3XK+qYdLk
X-Gm-Gg: AY/fxX6HWC3dABMfr/9wxIj++zcIrnuMl8Ik0iSbBHUo/S92mBXz4ybnPS/9dFcwT6c
	ue3O999JftF7GBsrl2cfzipL7snGQ1wcrMkK91P+fO1dVqYlBoIBSe7CBY6eMRM2a7z1H9NDSk9
	/EvKY7KkN3aM5gJW0YHWti0Lbg91gFswlFcWrxi9nYosJt2ePOfRJzg+B9JKDfYwyuzuXY7hd6P
	NxGfR1QojI6TX7uhcf+U/o7Sbv8HqRydFEztilPRJe/5TEeVoxhg58ZT8KEybeg6+Bs9cLd+14N
	rQK62GFbR4uE3yqlIgiQg0MAxuKz9EKJto2yZGWoSA0HlS5is7Blj8cIO9cw6VW6mJaAfFuPMoX
	QJFjFHL4jJR8N2W7cg+jJ87uIxmZC8DW/KoNIiyaPX7cdpD1LnuMhnY5Uh06Qnb+N3O7wWU7/Z2
	v6gg==
X-Received: by 2002:a05:687c:2719:b0:3ec:2fc8:97a2 with SMTP id 586e51a60fabf-4044c1cf3d4mr3903361fac.19.1768828211425;
        Mon, 19 Jan 2026 05:10:11 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb51d4csm6787856fac.6.2026.01.19.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:10:11 -0800 (PST)
Date: Mon, 19 Jan 2026 05:10:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/7] netconsole: introduce helpers for
 dynamic_netconsole_mutex lock/unlock
Message-ID: <ss4qejqrx2vtzbv7gpq3n3b2na2hqg6jmjuzc7jgfubjuie2cq@ql56alvspndg>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-5-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-5-4de36aebcf48@gmail.com>

On Sun, Jan 18, 2026 at 11:00:25AM +0000, Andre Carvalho wrote:
> This commit introduces two helper functions to perform lock/unlock on
> dynamic_netconsole_mutex providing no-op stub versions when compiled
> without CONFIG_NETCONSOLE_DYNAMIC and refactors existing call sites to
> use the new helpers.
> 
> This is done following kernel coding style guidelines, in preparation
> for an upcoming change. It avoids the need for preprocessor conditionals
> in the call site and keeps the logic easier to follow.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

