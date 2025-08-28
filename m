Return-Path: <linux-kselftest+bounces-40154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF482B39683
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29545467001
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717262D7D2E;
	Thu, 28 Aug 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Ai0oZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455B79DA;
	Thu, 28 Aug 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368631; cv=none; b=rpBkrDGp2bDPBZdR6AvkJszMEmdSm+SYxy0dwH6KdYHi3qHAlOwfAVEdxdp8Dcw1d/w3iVAAbHgrJr+MYfWIsHhSpkNPmRdSaprnVmAxXnIZa2qOGS8NSz/9phf+SDgG3sTbPgKHRKhJHz1FHdwBgLBIHD2lIXQe0elrt1rAo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368631; c=relaxed/simple;
	bh=/wfpzR0IeOuJryZPOkNOky05v6lmr91pjRC2wFXEOlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+9/q72MF5zUjt2/yw2u6Te6HaRKvl6JReiFDBsX8DXhjEbmVCUAGGAf8mxnsZHK7AE1PnrHmFT2vVJnBGOdjQJX8bm0w7LaHmmw0oykYsmnSaRG1cBbqjd2P9ns8km6i9qTYc99XvyV78WAelYF3ePPPoN2lAxnNSESP2t+B5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3Ai0oZe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so498146a12.0;
        Thu, 28 Aug 2025 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756368627; x=1756973427; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsYlmHfU3hwTMO0ZELDyq62SrO+5nMwqV4kPXeXXGBI=;
        b=a3Ai0oZe1XcWuu+TaFLu0DpVJBTlF1ADyjrAo7Z1yjTZIE7VFp+nMyUxUZICs7GOfo
         A2/2n1erR3xh7Tj3sxSy0habsmzgjW4KI5t/J+wFEMTw6ooms7WIKU75BLl1YxCX8M/2
         5HFKQOlWWhvOLolaBg8q/+tnDoPT+3YqXVRElUONUN0n+HIk6q+YCvBOGgF/hQ837Psd
         gTkX3vrsqMrFQJJsE/NfbClo4UjqWVGZAGyyeXfzATe5yYt7W6D50qOdcRikQ5ioi3Eb
         uiS56iLgZ7iIcQnu7Rw/wifshbmRqxS0yAQ3iiFc+UHWMkoYyFzuRaQBC+fhOCFKy57N
         O0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756368627; x=1756973427;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WsYlmHfU3hwTMO0ZELDyq62SrO+5nMwqV4kPXeXXGBI=;
        b=mUvHR23KNOcPf/wLaFXwVyZQN4PkfFbnUGOmyUC1QpQRWCjIF7W1fdvo5Asr0DtbB3
         jklcdXKN2L1L8eDYPWNxfWgLpx/CX+lctWTfheOBop5EP2FOVjVMega5kBf+2QF3r278
         w7qqbqSq9zYWeSPEMqDsccD0+V1DutBXesbgxhLjNE99nxqQgeScKtTsqqEsjQxApp/p
         OgLORlrpbxC48sxGfD1JKqqKdehi4vTy8dwqhno3TaPXjfiCOeOk82Ro34bru4NRHhq+
         1qH8DFkk8piMgaqd5tYqC2QAhn0xZa1AYlIIk40VGgCua2nfUMRK6TXkoMgex5wOHPiF
         fd7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuHRQgyvZi7TQKEO1PMW3NYDuUOa4pNi5mLYTbENMmB2h5tOwmWeuvt7EC2Il9EKCAzYzMVNC5q2aAvzc=@vger.kernel.org, AJvYcCWG3VvSQJutbgbWWMdaGsNaB6PxdgL+6fFwfztlUSnQIw8lVmlRgLf+s1vPxaQfiSjEAGE4rNqwZoJkKcJLTxvc@vger.kernel.org, AJvYcCXLA1JTzbBRPw3Z/6v9VL1O5OvWjA1bJ62OijKOvcNmk/tqB9C0mhLJGL0mn8eyDo91YOPX6SB6jmBthhGfU21Iu2cR9Srr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hehCa580MIriUM87lQDG1Yb7XR5nT5nyFGS9MQmg6KpOrE2k
	Z8W6dg1WG8dkmccnD3k53AEP+YyC+2WvqbEXqSIBJACSNiwNH1dP8l/8
X-Gm-Gg: ASbGncu9VVhpXdasZPwfJkbP/tw8D/jrD7YJDAgN34gfVgN9OV2JJr5FcKqxHqxcEEi
	0u2jwFhT2R+rq+lE4fgb4h7c8i6c6uBbJrthKybYSuBxwfGVD5FWBaBmqCEGQRfeVkjIZMhAvZ3
	9fAntosMN+YmcE6HYnyymopg5OROjpJ1k41YCQvaF8EaCkBs0EvZfwb4U5nEZRXbQsPEXjHhtNl
	k+0gOlTavuGMxDNxdEdaa5dj0dKEV9P53GzoML+T3KIUZTaa9+jNvprrckQuMzfvuovOKs8Ujk4
	IKK2C3qIAtocLpmbjhf9X1vYkqr2soeofkpu7sfJOvBl0cE6MhLEZmrJzAgN2T7eHcBjVPZgzrt
	ojRgG82YI2KhgOl9DesTzJM2jIrWsKr1RvCKap/rMR6ixBJg=
X-Google-Smtp-Source: AGHT+IGIthkWv6z5MdlsIhO9u//UvPeOJujLKVBOFVuuS4souaYefx3hzHkd5Tzm4EztK/4S7+XRVg==
X-Received: by 2002:a05:6402:270f:b0:61c:6968:d1a5 with SMTP id 4fb4d7f45d1cf-61c6968e6b3mr10645149a12.25.1756368627342;
        Thu, 28 Aug 2025 01:10:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c533e96dfsm9090558a12.18.2025.08.28.01.10.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 01:10:26 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:10:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, mic@digikod.net,
	gnoack@google.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ming.lei@redhat.com, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] selftests: Replace relative includes with
 non-relative for kselftest.h and kselftest_harness.h
Message-ID: <20250828081026.yx6vgphtsf4pmr3y@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
 <20250827144733.82277-3-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827144733.82277-3-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 27, 2025 at 08:17:33PM +0530, Bala-Vignesh-Reddy wrote:
>Replaced relative path of kselftest.h and kselftest_harness.h
>to a non-relative path
>
>Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
>
[...]
>diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>index d30625c18259..ccbb1958d467 100644
>--- a/tools/testing/selftests/mm/cow.c
>+++ b/tools/testing/selftests/mm/cow.c
>@@ -27,7 +27,7 @@
> #endif /* LOCAL_CONFIG_HAVE_LIBURING */
> 
> #include "../../../../mm/gup_test.h"
>-#include "../kselftest.h"
>+#include "kselftest.h"
> #include "vm_util.h"
> #include "thp_settings.h"
> 

Well there are too many changes and I failed to apply this one on current
mm-new. So I just manually change this with patch 1 applied.

This fails when I "cd tools/testing/selftests/mm/" and then make.

The Makefile in selftests/mm doesn't include ../Makefile so ../lib.mk doesn't
know the new CFLAGS when I do build in selftests/mm directory.

-- 
Wei Yang
Help you, Help me

