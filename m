Return-Path: <linux-kselftest+bounces-1331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7885807B77
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 23:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D78D1F219B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC147F69;
	Wed,  6 Dec 2023 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sn7Sha/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FBD59
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 14:38:42 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce9c8c45a7so40210b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701902322; x=1702507122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+4oPNNVBI0NPUQNcE82sxUMnJJvgGad4QF6v1JsIK8=;
        b=Sn7Sha/E4sdNZ3QX4Gy40HA0h0Aqj277xP5CTOaB8vLsWuk8m9Z3EN/yTMUHcbwT+J
         x1P/kOETqM92AsYS242cfKsxAVD2/fp364MGNeCeBcLVNaooJiZ8hBTfzcZy0xrJhzSV
         51b6L4SvM7XE2pnRpSJHWmmLJogxkumx3h7do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902322; x=1702507122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+4oPNNVBI0NPUQNcE82sxUMnJJvgGad4QF6v1JsIK8=;
        b=CT2q2QQSv9cv2TC2P1iCyZBtfONXIjYoZONbs9yCw87LsN5zgAzFWvquO4BssnWKoW
         2Slb6CkjwHibWUrYf4eZiF3qPYhHOFc1RMKQor+0QTyoCtBEgUvfuQNXJ4CJIGTkyB2F
         hcye8tvbIC92VcVmzC6c/TA0b4OYlwMFa3MkKw5ljLXOj/LEfTsuv7Q7ipC019oz2HY3
         7tlROED7+yl+Tg87UQb5/SY/uVjnmyZhc6pYlzTCOM/stlfq5hfRmVIaEDHjjkreI69l
         LSbgWPLkymY4th3tjm5FohwNi1x0QzTCZ8S1XhpncKeRLw56SittDtHfr6JiZcpZvkyi
         ScIA==
X-Gm-Message-State: AOJu0YxLhh83kAillCNcvdMpGmz9Mldt5m8SzWp6VSI1uNMynhV3PSFa
	xG06sZ0CTl/AwvCwfUn2/YqqBQ==
X-Google-Smtp-Source: AGHT+IHTO6Bm1YpVvYyKzmSzmx2nP0B5WjacD55ZsWjTp5zZqxQfRGUNO6A8B1rAllGZoH4U9W4bXA==
X-Received: by 2002:a05:6a00:1ca5:b0:6cd:fd5c:3c01 with SMTP id y37-20020a056a001ca500b006cdfd5c3c01mr1524853pfw.15.1701902321833;
        Wed, 06 Dec 2023 14:38:41 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b006cb60b188bdsm19755pfn.196.2023.12.06.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:38:41 -0800 (PST)
Date: Wed, 6 Dec 2023 14:38:40 -0800
From: Kees Cook <keescook@chromium.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-mm <linux-mm@kvack.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: WARNING: CPU: 6 PID: 474 at include/linux/maple_tree.h:712
 mmap_region (include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
Message-ID: <202312061435.E57F367C16@keescook>
References: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com>
 <ZUzmlhvRv66I3J6P@finisterre.sirena.org.uk>
 <B4299DC4-57CF-4CB2-ACB1-A215F429BF6A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4299DC4-57CF-4CB2-ACB1-A215F429BF6A@kernel.org>

On Thu, Nov 09, 2023 at 09:45:26PM -0800, Kees Cook wrote:
> 
> 
> On November 9, 2023 6:03:02 AM PST, Mark Brown <broonie@kernel.org> wrote:
> >On Thu, Nov 09, 2023 at 06:57:08PM +0530, Naresh Kamboju wrote:
> >> Following kernel panic noticed while running  selftests: exec: load_address
> >> on Fastmodels (FVP) running Linux next-20231109.
> >> 
> >
> >Copying in Kees and Eric who maintain the exec API.
> 
> I'm traveling tomorrow so I won't be able to investigate this for a couple days. A quick look makes it seem like this is only happening in -next? (This warning was recently added to __mas_set_range?)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/maple_tree.h?id=02eccbc51164b43c5dadc3e5b40922c757075e08
> 
> Adding Liam...

Did this get addressed? I still see the warning checks in
__mas_set_range()...

-Kees

-- 
Kees Cook

