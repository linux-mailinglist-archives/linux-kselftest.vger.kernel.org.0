Return-Path: <linux-kselftest+bounces-819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518747FDABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053E81F20F83
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14FC37154;
	Wed, 29 Nov 2023 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gSS0f7dA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD28A3
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b86f3cdca0so2163077b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701270245; x=1701875045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4Ao7lBgcd+ybKERFuAK+nkaWPQkkI/HHB0oBMFxsuY=;
        b=gSS0f7dAo5U6qPxA1nJZhCvK3efZkpX2hHe1X5YJwzEYgO1JPkVVR74+2rL4K89BLn
         O2Oy2+0zz+PYTICB8bkCYCerNH0YnDWaZZdXfZUhScHR/Pet9FXUsyqoFJigyzdOuZpm
         nlN8Pk+4TBBKdq+mkP3ZYilYOIE7XNbdx1z8AlNuTPpdiSALL1VyENFlDySig7htomBJ
         aVpig6LbmyRTnvE3lnpXOSogTLzqmfRGmQBD8rjkUjbX3RyKeZ4Jx6KHRwmA2lGyoEE9
         ZosTbaORpqwBrcDEWOYSSZnUcGAlW1LN7cpy/zGh1c0obLUR4qkPjld8uSxgXjHRffbx
         JY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270245; x=1701875045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4Ao7lBgcd+ybKERFuAK+nkaWPQkkI/HHB0oBMFxsuY=;
        b=BDTtnizv7VOm6HSpgAtNoxh1Z+SAJKmCFgcC/4vkW1SlA1MExQbIwin2ewykJlF9KL
         FIowLFQEtOil7CNmRWBGbPEaowOXrgKBycG7FAGoiqNuVk6VfZVphktSWASESzADUhlq
         uOlOKv2wLiwla+mpY/jDYPLRxiOtk09EsRo/MlADDXnhKMBB4EBRBYEIg7/X5PbZh7mw
         fdQYXPqJNsLL6MsCjqs7ibP6WdfCpvZ6Nb4OCy9mu+FJO+iIGt4Yx1NKp5U0RujKtnj1
         ph7y94wgXzkI3Io8Ge/ePXNeLNuEZ7IqYs76KDYv1PUBCYye64cu18cVETDOxbEGVJG7
         D9lg==
X-Gm-Message-State: AOJu0YxIc1zWBpUtzTm/EsmamuoGbS0bb7oqJfXh6ZuXbXu4drqW6lG4
	TVkJYVWffi/uk8+ByxnTHDGnCQ==
X-Google-Smtp-Source: AGHT+IHD70IfG8FBZ3xYBo0dZ2qCdJIWjr46lOgat1KTOIvbAN1mbw/QRSgQ4yJcSH/qhXAu2olYow==
X-Received: by 2002:a05:6808:1288:b0:3b5:84b0:6be6 with SMTP id a8-20020a056808128800b003b584b06be6mr28312075oiw.47.1701270245316;
        Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id r10-20020ad4522a000000b0067a769e2259sm198042qvq.141.2023.11.29.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Date: Wed, 29 Nov 2023 10:04:03 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
	vitaly.wool@konsulko.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 2/6] memcontrol: add a new function to traverse
 online-only memcg hierarchy
Message-ID: <20231129150403.GB135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-3-nphamcs@gmail.com>

On Mon, Nov 27, 2023 at 03:45:56PM -0800, Nhat Pham wrote:
> The new zswap writeback scheme requires an online-only memcg hierarchy
> traversal. Add this functionality via the new mem_cgroup_iter_online()
> function - the old mem_cgroup_iter() is a special case of this new
> function.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

