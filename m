Return-Path: <linux-kselftest+bounces-15432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704939538C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16276285584
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8E1BB6BA;
	Thu, 15 Aug 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2xt2+Mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DAC147;
	Thu, 15 Aug 2024 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741656; cv=none; b=R2ELOhHwbAn2UcTEu2oEacYqKXlPM7FfjLOxOI4PZvNam+WLtVUm/EC8hMQi56jsxH565CFGCQPe3B78a0w9DJeOrNflccdLetcZO+aRynRgHURvyoMCVLePzXepTuRj7ICs9jn/QgUBvmxbeolUbbdCnTEUywX9UL3sWwEIgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741656; c=relaxed/simple;
	bh=bZXdxt5rsuaIjfCsiuPdc+57GZgVL8e6hq/aP3YNeoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO5PW5f4jabowGjfyLzkjXC3L27/4fFc7K2AfVwKFfsAtOcVWbdWHwJK+QGagOOR2TpuYYoA629TPJSLxIgEyXcALYl3/Q1B6NBZW2XW8akQE6hg0aOXJvJvuElE7rOjNMlhyRagnBS5OkVqHTzRpz8/MxNT6/lLczobGHq3EfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2xt2+Mp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so12713811fa.1;
        Thu, 15 Aug 2024 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741652; x=1724346452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZXdxt5rsuaIjfCsiuPdc+57GZgVL8e6hq/aP3YNeoA=;
        b=k2xt2+MpSKULg+TSp4Y1kH4aMC35DbpMfV/a2b+rJnQ2ZOZnkL9vMNhRzELOeGAEzm
         3OgXIDDHuFuB5qtQGp2gSwgDJGefBbjQNt7xinpV/SiI7WJWg9ozhTvxKyDpThFmyekL
         JkCP+l8LU6tX8du6RwhZnl8gn2QBdujWns6HWu1viAnnUYfEkLHCFcwbMEUeomuBdlJh
         rTuNrDz0MEkLUP18qmafVu/3mBAl3nH0FyH/N5MbQb7e4vqegHU1+Wn7uA2C1gtl5ki4
         9ojmzZ1rPaYCCnukqkuYsYS/M24nfkHpZveF4JIr8Q9Zs1FcBSxpaBjx9MmFFs0kpXef
         9hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741652; x=1724346452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZXdxt5rsuaIjfCsiuPdc+57GZgVL8e6hq/aP3YNeoA=;
        b=BaWEuhP/G38bn2K4m4bGNtgi0lDl4PUF03qmN7Hv8O31FeVRVm9xhJaX/Gm9BPAOSl
         oKzIabcmsu/fMXENphEWnbEcsk6QgqyHbrpAsxiDX9l97J/LF3JeGQKuXCwHnqe6ejsi
         BEShSx3J5nf9gKdy8H+knoMMQvXj0gfe6Wl9yOnqAFvrWZP28JLJDsJmwGxd4ZY71CHE
         pPu/YnZmTYITLP7QuTwvZhLa3wI4pdEAhmFuSJI25nzUlG4ZcI2Ui3NzNYXZqeWpsSNQ
         3EOekTVM86y2RrpllYLEkedivbAHfvkPG0RYXngvg+QEyMYG+xMz2IX94/9ZmpNw07tE
         VAUA==
X-Forwarded-Encrypted: i=1; AJvYcCXURssdIBx946diZAW6igtH9F8QVdHRzqfD45apLe7Vn7DQDgJigoyrZ4tMnf0OqfJcY6NnwCmLCa0LehHYByble5KkKMLFaoklpJoAmXyLsLq1mSSSl23Cs2+GXOmIuTKkASxg
X-Gm-Message-State: AOJu0YwWz8yImTraTMgqzi2THkoC79aojT4h2EDxyX7eTfQoq6XVp06S
	4bY+7h8VBNefsAwdLaR6EVQ9Sb4AcmsFxWyKpBHUEvxzLT5VnyQ703Sj5maxzuQyFMtFQ3ZSNQu
	f14tYdkAy3y7eAd2ctev0OX+c2PRTU6TvMGgDEQ==
X-Google-Smtp-Source: AGHT+IFrape4a46TIlcp9lo77AaAcqTx9xazVqA6BRWifosAN2sBEsBPed5/P4Ew2wsNSvRNfWzhfLlUqL3RgVX3mlw=
X-Received: by 2002:a05:6512:1110:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-5331c6b050cmr72282e87.30.1723741651823; Thu, 15 Aug 2024
 10:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com> <20240815125321.GA632411@kernel.org>
In-Reply-To: <20240815125321.GA632411@kernel.org>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Thu, 15 Aug 2024 22:37:19 +0530
Message-ID: <CAG=0RqKvw58-aN1onSjzc+WwhXk8uh_Ak=Po5gQyOmZUNgvaKg@mail.gmail.com>
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
To: Simon Horman <horms@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I agree with the correctness of this change.
> And I verified that with this patch applied,
> coedspell only flags false positives in this file.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,
Thanks for the review, Should I still send the patch again with the
fixes tag and the target repo for the patch as suggested by
liuhangbin@gmail.com. Or is it fine for now.

Regards,
Abhash

