Return-Path: <linux-kselftest+bounces-34179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3178ACBD5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E70188F31E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028E2253A7;
	Mon,  2 Jun 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KzzsNTFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B2F9EC
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903624; cv=none; b=LnWB4dUQ4iN3eV6L5fBfLDDdkeQWRowagvphUuwBclncHXKddaW8bDklcNjtztB1EX5IQx0pqCEshIfLlNrVj2Cgn6QiJGUAxQKAAr0zZDKLgiandHUJGNgBww8P4hwJT/8bydr9As8FuQpjeAfA31SABMb2XkqCysByq4ajZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903624; c=relaxed/simple;
	bh=4A6/DFadQ6PEoiQRDBjp3zfAlAKxeoFH4k1O19zzaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCyNNRkjJv01/rec43GTkXHZxIGYaFvqS28eS4Rq3C5XqmLSLhNSLh1aWgnQ/mw6xWGFptpjceGFIHSbtcAZ769sWlJZPOh3jws48LTmrCbhDljPK7V9Jo9gQxJrmxjU5N6Dn2JYmqLKjXQ+cW3xzXptfksO0pQCoQqGZn+eoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KzzsNTFe; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso14524445ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748903621; x=1749508421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGNygOz2PUzKUKDRozF3XmR1BLxdv32LAzNyS4YZMko=;
        b=KzzsNTFe5pS2A4lxxzLR74YtXHL3DgbBMfIGnoR5NbEK5Drvh/5H5Nmw9U9XbY1hpc
         fVWGMA9Bu6L8KHbavyFPqiHlefuY26fAsyx7tsUtDXz0884xl0qD4PWUDhuzDJ+geucW
         lQzQ+47RpZB+Xn2DKrUMjoBKya1tt8RHEx8+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903621; x=1749508421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGNygOz2PUzKUKDRozF3XmR1BLxdv32LAzNyS4YZMko=;
        b=BTSRib43dCbrxsl05DwJTTITjHsos+WDP2AVXx2tVAx8cCwLiNT/irAXL+QZC8lVar
         SIi77i5bJe602de1ZUWDJeMoBlKm1p3sySJ1dv3iOn7yMKaSk3AUw245L/zQzH2SMQpq
         J8+Q1nlmELfPuysNLuBATWN6KzE/uLuAO5uugKvcqBj+5Ivwes+LzobHC6baBFRD0yES
         X/W/oxfbBDOxGL8GBPPnJH5UeH9yQfMFKPHQaoDp5LhblO0eLNGV1FA8kkhTjX2cGdIt
         we9sb0yL/tSzSMHW+fxbFo5p5wPR6M6KCYAtmJdk2hEMv5cKMpZigTzHHDpf0BOcG0bB
         JpLA==
X-Gm-Message-State: AOJu0Yxnnqw1Svfv7cx85WNmDwuk0+tgeF/fy+FkfgU5oeUIQ2o6PDia
	qEpMQ43seYn+qbghTWl3WbMaDwUKTKns7nthaihg4P0gzgKZBIsJHGiW9L/M2nAHvpA=
X-Gm-Gg: ASbGncsanzlw5jt+szeKC4K9vkOOp/Bjf21WVRmaRkWbeyodX/ktxIqeFg64HKm1iyM
	oQ6IZI3VfDDfeaxKm9guK8Ht6YNMpzSprUwPf2tPklAPSiGjStbbqk0kO1Y845IAYfWgfGi6D+n
	/YU5WIwPf2KmhtEA8Wz5XDacWP4dCRYj7JB+yZFKDumHsiAbxGiVwEytv+87TvEbr4lRHqwb9Uw
	6OhwhIQkrGEq3kBJw9kEYuyHCwpTZMcbEQFIxSINEaa4fUTJ7yZsbCtlVG0YDZpga60dXvEwlnD
	6tCDgouVlpYm4V9QGTPUcxwkUTU72hoyQPOiCzBXbrwuhv6Tq/B3TPFc8jn8Fw==
X-Google-Smtp-Source: AGHT+IF0xbLpXUt9eRmOQdLbCz/+5KPlrOqNN3OTQBxtKEQe70WAV9CDZv7hCKzlBIA2qwn/X91AYA==
X-Received: by 2002:a05:6e02:378d:b0:3dc:7a9a:44db with SMTP id e9e14a558f8ab-3dda33922a8mr95638915ab.16.1748903621299;
        Mon, 02 Jun 2025 15:33:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7ce29d0sm1990151173.0.2025.06.02.15.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:33:40 -0700 (PDT)
Message-ID: <99f32bcc-0754-4414-b69e-c4d5d000f216@linuxfoundation.org>
Date: Mon, 2 Jun 2025 16:33:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/filesystems: Fix build of anon_inode_test
To: Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan
 <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250530-selftests-anon-inode-build-v2-1-74c47eeeacd1@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250530-selftests-anon-inode-build-v2-1-74c47eeeacd1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 04:42, Mark Brown wrote:
> The newly added anon_inode_test test fails to build due to attempting to
> include a nonexisting overlayfs/wrapper.h:
> 
> anon_inode_test.c:10:10: fatal error: overlayfs/wrappers.h: No such file or directory
>     10 | #include "overlayfs/wrappers.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> 
> This is due to 0bd92b9fe538 ("selftests/filesystems: move wrapper.h out
> of overlayfs subdir") which was added in the vfs-6.16.selftests branch
> which was based on -rc5 and did not contain the newly added test so once
> things were merged into mainline the build started failing - both
> parent commits are fine.
> 
> Fixes: 3e406741b1989 ("Merge tag 'vfs-6.16-rc1.selftests' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Rebase onto mainline and adjust fixes commit now the two branches got
>    merged there.
> - Link to v1: https://lore.kernel.org/r/20250518-selftests-anon-inode-build-v1-1-71eff8183168@kernel.org

Looks this will have to go directly to Linu's tree or vfs tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

