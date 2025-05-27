Return-Path: <linux-kselftest+bounces-33875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC9AC5232
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEBD4A133E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6627B4FD;
	Tue, 27 May 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROc71y4u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1F27B4F1;
	Tue, 27 May 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360065; cv=none; b=Rm5ZGZAwoJlrM5YP943OWzEOdW3cYt1YoeYDBXhdj/WXAZhtxBSFb3wLRkc5c6wj/LvljRZxNRcKih+eZGJIOXcyIbn/3I33PemybIxznMTrxwGckYDQ52p9Ep4MQQjxxDrtyiRoi3tWeXH91Yjt80vcPY+evlNocbXdFJejtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360065; c=relaxed/simple;
	bh=WJmvF5H/7jw2b7o2uIKkIgSniBMA5J4lw3RqRiXywQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvOXbqhowSTAeSWs/oav4DKJ0tv6Hk4X8jQRfohpwblwI/aufrfWsRb2Un+4YAbUq8s1zaC2Yuj6dqvDulG0rt7psHl5P//x46RUkyJxYB+F3QW6EbSqXBU3XlAmnkNEgySU+7G3BD2N0o6sl4eCYofuunwdCUtjACkgDF/TS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROc71y4u; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso2038399a12.2;
        Tue, 27 May 2025 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748360063; x=1748964863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjLtUxz6wUeu4W0YMSILHtgEpQqtx6Ch5uJATbKF6mU=;
        b=ROc71y4uTRvSnZ/2EXeGS9pMyzZ16OJGuoRhdRXScn/NU37XRNEvEUOqUU41eNe23g
         ULU5CS8ry0pLSDYG9W7h/hprdQUAnyUoINDUwNto+6KXwxT0Gqqcj1u52OSMwqD+xDGH
         x+ZnU1bxAruf7f769veuIB77eppsS1m9PCikMkh69Cqf5CmcEvvHS7V2OuD4zXUoPUbD
         5n/0WFqYF80pDGtY0yJe5DtSEQX9S+QZeF689YN7N+1E7//XUH0r85KmQqLB5tSKxi1B
         +pxjRXwC4NsLY+kJCcmcwExZQXf3kmrI9WL65pJcXPP5Sj3cbDn9sRELwq3Tgr+oqpW3
         6+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360063; x=1748964863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjLtUxz6wUeu4W0YMSILHtgEpQqtx6Ch5uJATbKF6mU=;
        b=BqcHiulS236/GxJoKa8WvHpAPkHAUIYcaHv7sY/qzZG4AM54B4gq/gPETiJcOHjg31
         l99IxR39Jk/xZb8JkTYr68KwvSV8fD665wMZ4lkoXZeed8/fwqNvIIsVAat5IS2ja3zZ
         rrUwD4az3/KWKvUSb/CMMT9frcpse+ELAJ3EExuSKN51NVtIy8eiOodCtI+sywmyku6i
         Vh+f6D+XN9kMK2559GmO6Al+XzOZocmDyfXLeeVPZCyfCBdSuridjWBIiwr7/M8A2z3p
         n51OmbVu1Thb3gBLT56ZA01mfy231y9gU4ge8tHAqHhjTu/aoh0ilVejW8obIXjiHN3J
         PNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmA1aF9GCXdLx8hHwDM/FnEvMvb8n8xgDvXCnYBSKbYdOXDMCdT5emxf+eRw2baEK/xd8VWKkoRl4BTwajjmp9@vger.kernel.org, AJvYcCXdKmrJuofoWnpH/JAJxo7CcFdbUwgcyuo4TO2/3Z0Py1ouGiF6lAxYqxs3fsStQmMMSwuT/q0DrEfQMU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkhnv8AYAgyagPAodqXczCQpvPu8QxVUJDnMdTavHLXx9aXgz3
	75n0L7MLykg2MwYNI3ZXP2qjPbjla0ZiASwUlUrDgQoURg6fC8uhBmA=
X-Gm-Gg: ASbGncsVaMiEhGsSzVUclIHr66Rv6w7BgIwpDlqufaxMeuWhhQNrs+hATwEzX3cct4V
	KcmOD2TfQSNqqCMtEo4sxuPUGsJ/Q825CUbM5ByuPpGziW7KZryfwwFlrrInnu9O1ZbGahUD4wa
	+mR9xAbFfGUHtGZwmWKGX318NmHjHtGOO+7YCIvJ+qwage8EoGEh7nGC++coDy3mVqQElKEq/zN
	6i7IjyNyw99zB8BCyYsgVo7k2kP4dfrd6ZPdmq/cY9NASdDAN+hKiyD5qUOlQB869l8/1jvStLU
	5EyR2J4GF6P5iy6CMdchjjjHHDEmcJuPW/jgOXhPqQ+I836kuzZuViiwGYurl/d9j63Cw/7sVke
	Bu84ieGlQB6dk
X-Google-Smtp-Source: AGHT+IGliIzVto7G0jYAWc7/nEzgIAhxJyNQHkEeZyPFbnAEE+bbHsQu3U8ocWji4MVAzWj/sGWzyw==
X-Received: by 2002:a17:90b:3596:b0:311:d05c:947 with SMTP id 98e67ed59e1d1-311d05c0ae3mr1028544a91.24.1748360063390;
        Tue, 27 May 2025 08:34:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3119ba04df7sm2411418a91.30.2025.05.27.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:34:22 -0700 (PDT)
Date: Tue, 27 May 2025 08:34:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v2 2/8] page_pool: fix ugly page_pool formatting
Message-ID: <aDXbfqvfBztXg8eM@mini-arch>
References: <20250523230524.1107879-1-almasrymina@google.com>
 <20250523230524.1107879-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523230524.1107879-3-almasrymina@google.com>

On 05/23, Mina Almasry wrote:
> Minor cleanup; this line is badly formatted.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

