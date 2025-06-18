Return-Path: <linux-kselftest+bounces-35322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CAADF811
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 22:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FCB189F13A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5921ADA2;
	Wed, 18 Jun 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tx6xHE3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8B1B78F3
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279933; cv=none; b=CG59KPuQi1GVDXhP8180Kutg1i+QwkIEU32I3ivgv+hdw9Nr1qz/J+qK15L4LYmbu7BRoT/6L3McKzfEaIZWuzz3SNgqNoMdQ6wnTWcn7HQpG2AYwmfbm/BKsZR2DPddJxBYk/hTbjQJAqQdJdivdPzUqHWO1aACun6TIR8jGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279933; c=relaxed/simple;
	bh=udfxxBUYqOxwF4CpJe01eYlAvRjWcIPtTrlrYNAkw1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SylJfrmHLxrGOvdq5AantLsYaDz2SyGvpuSl6DLQaNVspDh4NuX3Zr14Zjf1oU1aqsLThFymAI4/xM4BotatqlAOxph0vT8QYRgKBHUntg0ryeJkbPvtkw7j6MLEJsgbm4/hIq4bOemB/AipVOeybDTzqj3Nc4pWwpu4lOdenDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tx6xHE3d; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86d0c5981b3so867339f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750279930; x=1750884730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Y7/EqwIOfu/4i0R5S1fQpdZTumyIs1zK/W1iPvlsMg=;
        b=Tx6xHE3dr5yHfhCSAYw1ZM8boLJLe1tjT8s2V04jHLarNX5n7+d76DtwBP9aFpH0oq
         YzFwthNCK3gTvz0Ga+1dCmfwAqUCenpM0o+vUkQwZtgpp2frSKFQixUM+Iv3zQszVXbg
         ndyWdXNwPHKHhEvnGY0EdcrNhl+zdloqEA9II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279930; x=1750884730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y7/EqwIOfu/4i0R5S1fQpdZTumyIs1zK/W1iPvlsMg=;
        b=DrkpEns6MbJ6xOX0h8fx93WI7czT4OlQiErLrrI3/qFVSFu8ew8QO9t4ayTyYuG0UY
         uJ4WX34ADCHEyFxFCOQLeKTFbo4Aw8eEVhkMC84nxBWh4WpF6busfxLgdUoaRKzQXd1U
         N1h04ykaRqbki0jpjrivbsKXvF4P1ET03FVxs+Xx3Xe+Yflh4jJdswEWXAejY1gfK83i
         uW8cqSx5w9qaXzfkQx/KL6w8HbxXhDKB/ArWCqHF7d7PZo7Q8o0SHkwmxE//7zIcwmLH
         Ptxp47EthU45AkweQOCyTnSV8TvvG/q6jvtac+a2eIdIexq39d2ylPD4N1REb7xE6Lgd
         g5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWOw70RJnKw1gV2dv7gRS8glatOynnmhOCZrSGBT/jcodiYQ4BUBMkYy1PuDtKRFM591nOFJd7Rn6NNWWSW8XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BaI07X3ZvjMA2jaL19pSJ2Tu+RRxXUMpdWxDRI/jviI3hFG9
	2UTXsz4yRW/PQ2eajOfQmj0U9XIuxDb+KXks0kinozPjknqFnrQdSQyR0t3vuxen4RA=
X-Gm-Gg: ASbGnctqJrEjQ3d/0voP51brjjqJ1nN/N3whhh4lRdNVD5S9LSHetLx/Ieqn6q3y4V3
	uEF9AT/S0dhV6Tzv99wzpDedubMH7iEiBIk8Y40dakZXYxslTXUj8DUSMS9dt7ghu1UjWj4xW9c
	KlKXokXEyX42RE+HfH1ZEMNojjKGqyBqAmFjHska6PcZ10Y65g9vP0ER3BsuX1DdQlQf42AeB+D
	pn08USrU4dNB50lkZO77GqfO7Fbgv8pNoEXtA791UZUkjw0gUd/Dpi7UcS4ZkVpdDg1KqVftLxv
	vQQkCQ6CV+m8S3mvTkOi3rKgyRfWZ4Yr6TV0c4Em/wSRp7x5amFJhD8HG66QBzlbphBBdsTDnA=
	=
X-Google-Smtp-Source: AGHT+IFPfu2uaM1NocL4Z4iAcYmQ75ftw0wdya9PlU93jjCX0lxXWAzQlA6uFQLDr/7/ZZFP1+EZow==
X-Received: by 2002:a05:6602:3fc3:b0:875:acf6:21a with SMTP id ca18e2360f4ac-875dedc39afmr2110106839f.11.1750279930245;
        Wed, 18 Jun 2025 13:52:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149ca31b4sm2952500173.132.2025.06.18.13.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 13:52:09 -0700 (PDT)
Message-ID: <9940a310-5a39-4489-a1bf-0809e5914c08@linuxfoundation.org>
Date: Wed, 18 Jun 2025 14:52:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the
 abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/25 03:40, Chen Linxuan wrote:
> This patch add a simple functional test for the "abort" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
> 
> A simple fuse daemon is added for testing.
> 
> Related discussion can be found in the link below.
> 
> Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Co-developed-by: Miklos Szeredi <miklos@szeredi.hu>
> Reviewed-by: Miklos Szeredi <miklos@szeredi.hu>
> ---
> Changes in v4:
> - Apply patch suggested by Miklos Szeredi
>    - Setting up a userns environment for testing
>    - Fix a EBUSY on umount/rmdir
> - Link to v3: https://lore.kernel.org/all/20250610021007.2800329-2-chenlinxuan@uniontech.com/
> Changes in v3:
> - Apply changes suggested by Amir Goldstein
>    - Rename the test subdir to filesystems/fuse
>    - Verify errno when connection is aborted
> - Apply changes suggested by Shuah Khan
>    - Update commit message
> - Link to v2: https://lore.kernel.org/all/20250517012350.10317-2-chenlinxuan@uniontech.com/
> Changes in v2:
> - Apply changes suggested by Amir Goldstein
>     - Check errno
> - Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/

+ adding Christian to the thread

Hi Christian,

Would you like me to take this patch through my tree?

thanks,
-- Shuah

