Return-Path: <linux-kselftest+bounces-369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EC7F291A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051A228260B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE33BB5B;
	Tue, 21 Nov 2023 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j65JvBpU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11109D8
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 01:42:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40842752c6eso23789715e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 01:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700559757; x=1701164557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFo9KPKmFK7WqzXwym/48RniSRgiZpvp+lNPOreiEFY=;
        b=j65JvBpUptIHNcFEhAJk0iFw6YMB730lUNSU9RxlEP0jEFmP9/m78yBxi9CptNHyI2
         62NtSsp4FiK+8/0GyOigt13rEnQuog5Cjqxw0fDWqIMtmvxZWDb+C+jHrOr6NWLZjBTZ
         X+ayrigretPeRDNHhFjEqO1d18RUxYdIQPzI8cY4UuFJ9Ztq2rIadHNlIxmUOtDS7oyb
         iN18O12T8i143rbyMg3KaAtZRwuCMCa/gqYDx6ibFkkd2hPKrNKQCwkNcZIJYLmSY0HM
         9HEkYaU46h28Db6nBvhFy57dqX8Mo6w/4S/CUKI1rpuIBU/1tACtLqjq3PjaTQ/bwDkx
         HwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700559757; x=1701164557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFo9KPKmFK7WqzXwym/48RniSRgiZpvp+lNPOreiEFY=;
        b=eZo/y5KbDVSAAyFmYl4/vINiNN8dK1iM/qUwbWwWd4tXALCJ8+1zM7NC2gfTIIi9Os
         MeLxWjpgisgZz+yXfZiTlJYYSOuQ2gAttTUMXZTPdp/zAyMsdmh7GHGX0hhlAiAzZEfZ
         9sFSbbmk1JiQos1a7UGX9QKZdNw8g9xqGbG69p4zSGI/FhJNZ+ucV82U7BTSb2wVYcTI
         Jt8b4A8uJVb1AfttOBCoD58TzCS9xtLtRNpaYwnUv/thMF1XPLWflpHFcLxVuEtafB4l
         Fq/EWAar0dOgXJNt/Z9wSQGQ1JztPh9cFZED5ifvPS//LC3LR746Z6Y9HcqvsQHGpOeB
         G1Iw==
X-Gm-Message-State: AOJu0YyWYwLU6JplLZ6AE5j2oiG7wUkQFfi1ajJ1DVRpLRjW9ZLeaG9/
	MKPQHradOxfs8c8bGi/w5XfNLg==
X-Google-Smtp-Source: AGHT+IHIyVqWoNqJSzyFRtD//B41b3mRhSXS014z/c9urGhK0lZKNPRhwj0Rcm/ITAjDFfTbjoZB3g==
X-Received: by 2002:a7b:c342:0:b0:40a:4a7d:606b with SMTP id l2-20020a7bc342000000b0040a4a7d606bmr8053233wmj.40.1700559757371;
        Tue, 21 Nov 2023 01:42:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040588d85b3asm20872413wmq.15.2023.11.21.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:42:37 -0800 (PST)
Date: Tue, 21 Nov 2023 04:42:33 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ivan.orlov0322@gmail.com, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mathieu.desnoyers@efficios.com, shuah@kernel.org
Subject: Re: [PATCH v1] selftests/media_tests: fix a resource leak
Message-ID: <a0cdd2a9-08db-4b9e-aba4-7837df7fd2eb@suswa.mountain>
References: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
 <20231121093238.5376-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121093238.5376-1-zhujun2@cmss.chinamobile.com>

On Tue, Nov 21, 2023 at 01:32:38AM -0800, Zhu Jun wrote:
> From: zhujun2 <zhujun2@cmss.chinamobile.com>
> 
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
> 
> Hi Dan Carpenter 
> 	
> 	I believe that the Linux kernel code is sacred and should strictly adhere to C code conventions
> 

*sigh*.  You do you, I guess.  This patch is pointless but I don't care
whether it's merged or not.

regards,
dan carpenter

