Return-Path: <linux-kselftest+bounces-30039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D56A7991D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 01:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9709916DD81
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655791F460A;
	Wed,  2 Apr 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am3VYutG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510626AFB;
	Wed,  2 Apr 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637801; cv=none; b=BsNG9Jsn6ptdZKJROfFRp1kAQ0xDK2JcaH8Csi58LaoHUFbVvylHJIp6gyDl0xN12x9V9DfhvlWoRt4P/DnxyotrhQPN5eE6cbqQDzdp4N64bbO7N9L0F56LpVh/f2RcHex+uRku2/0dFMBG0EJHrXMy96h/Wck8k4Pn2mJJ3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637801; c=relaxed/simple;
	bh=pRKN4RJ+ClNeiAeT+SXblO6J0J5VOZahako4m+scu+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5JlNtjtgSd1oBB7rqRAPlME/AdoQgQy4XJg9Vu0hy4vzKDMRBE+qGim+y+9xIlTLrTVzBCu3Bt2wGeIgBEQZkrXYz6DPn0w9g+pfZlzW1S3cdyD8KwMp2ycT4nXlqsO8T9K0aaPzb3qV7XtfeOi8lokKM7xTc7J+tRSiWLKBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am3VYutG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225477548e1so3826725ad.0;
        Wed, 02 Apr 2025 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743637799; x=1744242599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgDfFzvRu4V5qJwEASsCRfXCYgidop5Mrs7vCCMeeOw=;
        b=am3VYutG590jeXDKQZxfouIN8kF1Yu1tvCNiYa6HstsJxyzFcO4p9zGWaHIj+hcmpD
         r7Sp2iOycVYvyfbptg10JuDkSkcPKxytM8RUxXY4njW2F1Fnnb6G3peLJiSWwFa6hfpC
         gBPIBDJ/OnesNlSUN3Nc8nYp95a62T+Q+G+lbaqWbkUc9ePm4d4WailaOcCKBQOI0Eyf
         qzCeZILWf7osAx8Yx7AzrgsJtsOxPsVjFy0EsEIczdeWxnlcg9rZva5Wng4KaKjUF4nD
         tWYfzr9cKDcdUAVlbXXMcduOJM4g1qydzJB8Jd+gkuUckchNZYgGOHQEJliMXXAeFPPP
         DhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743637799; x=1744242599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgDfFzvRu4V5qJwEASsCRfXCYgidop5Mrs7vCCMeeOw=;
        b=JORO9Nf/WyFx8B+0jGt1jSHy56XXtvjnCty6DMpKPxdg+J5AQNfwN49w1KIkCFJiq6
         usQNewOe9TlwlFJ5kFLETlzu1DVMaLdWKBUZRjP4LrFN+0N2kob36oJF1tloLkKwxJqo
         PN2xWQGB5qdTUF7V0stX3Kmh2w8sVo4XBkHoKLaMnm7+13CwtiOXjLpXt+YH+lYKN7yX
         lkZ32Nn8v8L8riJxMlg1rvc4PvoZbWycJN/n3nhtAaQ2DmpRK4PqolSaCdV0hPLGH5Kr
         DKndich/XJw0U/emFMcwFsJDOCo6ZuQ336/060wDccn17YW9xR2BTdZwAT89aMXTsrDo
         mIlw==
X-Forwarded-Encrypted: i=1; AJvYcCVX5kOHVLApP7u1ejaLpZ3deIW5wsg2WinOXUMBZNJPZCsgxgryxROG+sqVJbrMX+AHk6e0csz3@vger.kernel.org, AJvYcCXA6Li23beWHx7Y1mdca/mYsfPT7XpPQPEEMij/i8w7y1V/2WvAkAXRClJapvoO+jQzFGUFbi7/3f5AX95dGGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvDQga9GFzBcPzIURiZwDzks9EqwAEH92/K/3c0hvxMBbhQMh
	woBUyGcNTx/uehAEnNCh05TyiWlxjwEd/2zgZybQ7WZ5ho0rlJcS
X-Gm-Gg: ASbGncvMERkxEleei3P+2OPZ0P3XbXIDZtE/ZsmmeG+YmtHh73pfrU8HRuR1jN01ytI
	jvizM/Le0XxecgkR6/L+wQj6uQFWqyrkiGqITz3gQdumK/5COSshaRgD8mpIPTDFQCIA7IA6pNy
	PNBQXLpiSqX9geWG706ESzYG+GYdQpS8WQ/mMZB9ASIlZoIqm1S0vUfC+pGsyWlQcI/4hZ/iPLw
	zutTgyYxu7/QXOv1uTEaAmPAbhGPKiHuUyt5nLeGvA2yzXF/39tUDEgWE+cdMXKcJG0/5bwNYp0
	yy2M4QVuf72Y+eDhS4ACg6WaoUHFkYLTJJ12jOPACr8v
X-Google-Smtp-Source: AGHT+IHyThICtb76IOv96dPuhTPs2KE1alV+KAitw929VSlGUdv/BrbieypehUVZ+QpDDz5ApozEuQ==
X-Received: by 2002:a17:903:19ef:b0:223:33cb:335f with SMTP id d9443c01a7336-2292f9493e3mr292458145ad.3.1743637799009;
        Wed, 02 Apr 2025 16:49:59 -0700 (PDT)
Received: from gmail.com ([98.97.40.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772ee4sm1543075ad.233.2025.04.02.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:49:58 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:49:37 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk,
	mrpre@163.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add ktls selftest
Message-ID: <20250402234937.riknwzpwdmly4byl@gmail.com>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
 <20250219052015.274405-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219052015.274405-3-jiayuan.chen@linux.dev>

On 2025-02-19 13:20:15, Jiayuan Chen wrote:
> add ktls selftest for sockmap
> 
> Test results:
> sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls disconnect_after_delete IPv4 SOCKMAP:OK
> sockmap_ktls/sockmap_ktls update_fails_when_sock_has_ulp IPv4 SOCKMAP:OK
> sockmap_ktls/tls simple offload:OK
> sockmap_ktls/tls tx cork:OK
> sockmap_ktls/tls tx cork with push:OK
> sockmap_ktls/tls simple offload:OK
> sockmap_ktls/tls tx cork:OK
> sockmap_ktls/tls tx cork with push:OK
> sockmap_ktls:OK
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Thanks Jiayuan sorry for the _very_ long delay this fell of my list
and I missed it. Thanks again!

Acked-by: John Fastabend <john.fastabend@gmail.com>

