Return-Path: <linux-kselftest+bounces-22838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DB9E41C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AE228CB56
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4522D4F2;
	Wed,  4 Dec 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V96CZvVI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8022D4EF;
	Wed,  4 Dec 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331842; cv=none; b=rNXbS7cfJ2Kndg2WuXvb5V2OCrcGjlQ5tygKxlvq6D9eNoc/ojzGmZGhRVDmAufviAYOX1EkdEiFiPa2c/nu/p9GyDquhFETnBkt+fUJ+7kZHerUndRmDXQNPH6qT58u6DQRX7g+o/LlCKyBJR4o1t5ESfjeEEbJ7bAAS4bLPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331842; c=relaxed/simple;
	bh=XVgTMkaQnWZypDe9THXFjpn6WhpDQVlRzEGdbJ21auc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVhb29KDH94p90uYyNme0sxRwT3L/n/fSmaMPaECMU26SaiO28NQuYKo88zsibWeJxV2j4ntNVgnp6Jz4v7OaVJ+oLGRYW3cG8bSFeOVcUfleVdQaoZWwTlsO1eyrtldfWRn2xfWK5tH/YkFgjU9LtgW8AIQZEBz0KJFb72hEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V96CZvVI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215936688aeso36181295ad.1;
        Wed, 04 Dec 2024 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733331840; x=1733936640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKTr4vgYnNxGMKn6banAprynPQ5r+1qbhfcpS6aqFcU=;
        b=V96CZvVIAeIDbSR339ycQkn8fQPFM1TP1koc1FOWWutsMdah8Ipv0xKKiJF80pjRAA
         AcxkPNMCEZWRiSIaTM65GQ8XVYqR5jF/s6oqOoomCrb4vBXIEhUfmso5UAUyH5g9V89n
         kcVDmk1FVP7Ek+Xvv92qUQgpIVRzxQ9o7OtciYMcGgx3pSm25sJdqaNTgwPkxhpt4sPQ
         dZkUe7ILnH+PDWA4KUaM3rC8n+/l0A6uAHXsUlfRIfcHPfFhfKCVVCowFDFTLU7UZr/V
         49WCveQMlQKI0r2OkI35avLI4DBegYqEqUO7JlblLVmzwY5CYvHOV80ioJaoCR9k7hms
         p8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331840; x=1733936640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKTr4vgYnNxGMKn6banAprynPQ5r+1qbhfcpS6aqFcU=;
        b=oUd8Ahe6xDv/8PFOlzFPPJGIlwtx0N0SZNTWuyDTN0Q9OVDfNKq+b4pUBsMRDlQ9Cl
         J5iN3PjQU+J0W1tRdvkIvYz/2mHeXVMJLgvz8soJMK52f99d04RGS9ynL02HJIeV4Z5o
         aTdeu8ELII3Br4idNp58szaYcTIEZtgzI7Q+N6GgLdKEGWQFNchMDe6U3QIpHrnOYPfp
         fB4rBC8frwkqGen6Hgp7L45NelanqO6cDwW5hNrEgm46XHVPULKHXvP71qxIWuGq0/bX
         jpizMkJBX3ZJY3bUazy6kixBZC5VggR0Esdk3L1tEVE83KcEZdd5FXY3wwWx7tL/ifuH
         0Uug==
X-Forwarded-Encrypted: i=1; AJvYcCW+j6sfnpB09fJ691rmElBSniG5e0cxHMD8rraLHHbW+OnpUAGQjokzGWjozNe6jx4rNcsRokE/4sPfzQo=@vger.kernel.org, AJvYcCXOVJATv6VP+qaVVAJF2UOTeFNs+aY0y+kMYby5t0hqvAEFmej2c9rtZwghifN0ISOAcoB+BUPSe1rQ99HYS5iY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5KOrmlfKq6Y/rBb3lLoVop5RLtF5hSDsw3F/pgVXfeS/iTC6
	SqHAa230eOPwzupRbqsDbxckcp7WRVEopwahdqITe92E8RRHFM0=
X-Gm-Gg: ASbGncuwbuOSWTf5la3a1XzX7lDV7s3xVRgg9oVI9cza5CPFD1lZmqVlo2ge7UpBcLu
	B4NOoBsTUAVx5J8MfbHZy7074/w5/edNM4XX2F4e1KNz1KV3W4kS999eBoN8u6CXpu2O6tVgP86
	MR6JOJJm+yK3of4BAWrbyqkUGfC2IbSO4J7BoJxAwQiK6D6FFt5yLhAGxWu+psMyroRjI8zL0ix
	21653rTs7FiEPzUXjGfaRdhyPaWbo1NQpRX0g+rGLB14etb7w==
X-Google-Smtp-Source: AGHT+IEYXZCwcvxk0zUlAPN8190KFwdu2z0T1sD7+oO3vIVKyF1lwiAKg/8rSXCynIC1VMsPscWmJA==
X-Received: by 2002:a17:903:2450:b0:215:a05d:fb05 with SMTP id d9443c01a7336-215d007659bmr84925795ad.32.1733331839927;
        Wed, 04 Dec 2024 09:03:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155338c05dsm83350895ad.199.2024.12.04.09.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:03:59 -0800 (PST)
Date: Wed, 4 Dec 2024 09:03:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH net-next v2] selftests: net: cleanup busy_poller.c
Message-ID: <Z1CLftOC58tUs6ZI@mini-arch>
References: <20241204163239.294123-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204163239.294123-1-jdamato@fastly.com>

On 12/04, Joe Damato wrote:
> Fix various integer type conversions by using strtoull and a temporary
> variable which is bounds checked before being casted into the
> appropriate cfg_* variable for use by the test program.
> 
> While here:
>   - free the strdup'd cfg string for overall hygenie.
>   - initialize napi_id = 0 in setup_queue to avoid warnings on some
>     compilers.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - initialize napi_id to 0 in setup_queue to avoid clang warning as
>      suggested by Stanislav. Tested with clang 10.0.0 and 18.1.8

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

