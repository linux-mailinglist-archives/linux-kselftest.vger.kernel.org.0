Return-Path: <linux-kselftest+bounces-8188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928118A7244
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD592819E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE413329F;
	Tue, 16 Apr 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T3Jz4KJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58C10A22
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288485; cv=none; b=oyj9Le5OuMpqUspU+7wRSR6AeEmMT/nR7JXfquvdpabUVUqudiF8SUQ015j3HpvOhMETWLvyuvadnlqgQeKpVNAl3StUT54EfMC/aicPNQ6MYndyR6x4nltm2/89Jpad/UiWoERl5vFqygFVUIgQnLaybXRT1rHVjFrVPmQ/eTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288485; c=relaxed/simple;
	bh=P9tX21C2H32XeRZpclyE1jUdcQxT5hx7EiLUM0Xs90o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvdWRHdi62cHm/MPFtbTyIvV3KVJMqby4rAD+LABt1Rb/wau2rgJGRKquPmCix3sYIg7092DJCrSmQ1XUOHY9SyZm4zQgFM6ta2e1kao96xYiU3UzolMd8rmsRg+GDydldOWf2Qf8P2qN0NYJUgnIlUOWq8pg5Ppc+VWj9TOxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T3Jz4KJm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4f341330fso39020925ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713288484; x=1713893284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbYixWM2CqQRL1wOMDrzHbCtgA+kuvvqBpiFHzx5mPI=;
        b=T3Jz4KJmnyq/mTIRQ0mnFEDpa8wKySv7YgYqQnu9UivT9y7iBBrKCtqCHQ9AwQcjcI
         46vAdaph0tV8XogvavUwHlrPVsiXkEa8VxHf4SauwBJFTdvRYB3+CFHAheCf4HilFJ2u
         iqGTZAHqZZto8HFgVIoteloaIQ3+r4azZG3YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288484; x=1713893284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbYixWM2CqQRL1wOMDrzHbCtgA+kuvvqBpiFHzx5mPI=;
        b=Lt9OA/7wDOnC2fWDfHNOoZ7augw7qavWq/Mt8v3YJ4N4+FhZiCbDaSeN6mb1S9T7Zf
         d777hTJrRsXbiKMgZiUP3moWnriuepZLatTIkfOkv1O1R5EiG9W048eOaqqVdwi12Uwz
         PrYZWEZOK530jjdrDdrdVMGhjNm9dt+awSXZgt52h/VwBxVH4tZVW9fJZz63ZGn0UmNS
         fZUI+PoHKujXhgDKrybDtxRVajgjPW1ecV6kurm36cLoSHzDRc/NfKNhxXVrocYsaBrO
         lNfS4kBm/76S//d8HkRzLQHmp4nC3C11dw6v8PNP8HixImwM6b41958eNLhUN0gUIRRB
         yHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXknxewd5gqnTk+M8yNzT5yiIXMClsQ5uTlrH3gKlpG25kIDVd90cXQI8XUzZW+kaGDMm6kXxQURVk7D4oGaLPnKSA5xfQbqAJCafCgggb
X-Gm-Message-State: AOJu0Yz+bxM7JkZhXraeCVld5Rs+YKaKWgJhegMdESBJ1mwWhumYIdUJ
	ZqT4Jy2L+VWuBNzSodZvTdANhddu6if4mWdd6YRVhSzWOxi4Zo7avNG8PjZjUQ==
X-Google-Smtp-Source: AGHT+IHbN76rCh1Qe3W01Nc2eeKTGXKJ8Gpa83X/WpafmSVHalfqd6xohNVPAcA7T0vL3gX2KQ5VZA==
X-Received: by 2002:a17:90b:3bc7:b0:2a2:672f:ef6d with SMTP id ph7-20020a17090b3bc700b002a2672fef6dmr10647646pjb.49.1713288483774;
        Tue, 16 Apr 2024 10:28:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090a051000b002a2e4b593cdsm11862530pjh.51.2024.04.16.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:28:03 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:28:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, kernel@collabora.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
Message-ID: <202404161027.63F4D4FDEB@keescook>
References: <20240416152831.3199999-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416152831.3199999-1-usama.anjum@collabora.com>

On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> The -static overrides the -pie and binaries aren't position independent
> anymore. Use -static-pie instead which would produce a static and
> position independent binary. This has been caught by clang's warnings:
> 
>   clang: warning: argument unused during compilation: '-pie'
>   [-Wunused-command-line-argument]
> 
> Tested with both gcc and clang after this change.
> 
> Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

