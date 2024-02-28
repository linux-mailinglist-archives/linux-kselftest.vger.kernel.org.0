Return-Path: <linux-kselftest+bounces-5529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF5C86AEEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBBAB23DF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E03BBD6;
	Wed, 28 Feb 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QHS61vcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67E3BBC5
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122606; cv=none; b=UFLQYnzlrsQmzg+/pyIMltlGqLDmZRhuIQUXJ9Xl5oCC8csgR2m13lI8TdJHtFM9+cUzS5FPBMxSKMVBkUolvNpq7CVPksQORZa/PSXm7jBQT/rqD9gJQmbhx8cKV8HPCAn5KTy0jo+iVx78LXzKewoQkyUN0zr7ugu01xCnB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122606; c=relaxed/simple;
	bh=ldvpcSU35Jz8322hCmCPRQeBN5Om3WvOv278ShMhodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mhu0F2lTUrIjYk47Ej1Vdu+qiOJzQlL2CkIlzz4EG1q3mIyk2F7rnV+NE1svNUVsumej7zMJ1gq3Y3ytajBJ5GSilzovzBLW1QBt8CFpqRmmvf7tPGad6EPWRGPZhRUW9BfpslDrCl/4Uck9jBz+CgFKha1ade36Zcd4USZejIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QHS61vcU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so6999605a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709122602; x=1709727402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=QHS61vcUkC8hfyvP6v0Sq/ZIz2ET0IuZgWvTZ2rSB/iahiViBGhYrfYudweAek6+vw
         QWdsvTka4JKvlLQZZzok2mIApKElamkpZdtOJbkTcZNyptJl0SFejMtOCmiHvCAPab9/
         AcW1EIP7F1Hrj5Cces/gs0JykGXoqP1Mnw7wihye/b9wUOhVtFmh8UK2TcKsDVcI9L9A
         VmeWW3WdVixDqZ2LBUFqkRp16AGvECtm9I8Mppg+l+KEz9YsIsw5Exbq1GeCAsuq0gGc
         DLBdxqqTar5wYjzo+9jTFpzY0ZwbhQ19gd+aEIDTvlHHTiZCaeM8Z+Wk5vxghuwd8bgQ
         E+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122602; x=1709727402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=vPL/s5N0wedwHlm2qkV5OCML6ytCFSNZer/Kt/xhll6T8z/Y40HjUjPYt4GEv7B2uf
         OdajYSItiYlGdUE28yrDA8JTUISO7iH1Sfis2/ie0R9nvZ69PfDDCd7lCGYSWtfXZngq
         HSiHyVZOr3S3t44yIcTDpE4enwZiYTx2fEgb7wB1neeqDiI0jftclk++0pQfEUD5KZyq
         iuEDI5bL9uO4lT/dxawzmrA/etlcj9v8N6tKoD6wHqR0EPoyCHpayLX6JnO7+awHCTyo
         lbP0POMbWbiRl00fVBfVlov5D/7HaFr4u5V25PsolOyB0WfyG/YU4J36m1PLVMoC3a9p
         cu/A==
X-Forwarded-Encrypted: i=1; AJvYcCWL22Vu3E05HmNplPKGlOPPINcX8X+yrSMBnp6XGr1q0tOZrKGxBZm0G3jI/sVwR0hYDp5t2ki8jl6UQHuidcDkIpmQnULsl06y2CsQETtK
X-Gm-Message-State: AOJu0YxQ6iDy4Z1s8Jdsn70l8NcPzHyLJU0N+v9Oym0n/kZnD33hRAzm
	PcXdh1TZtpxAM0mAUTsd06Y/vZM3d7j9o4zCw7jVMwlc5GMhxfrr5uq/bBQ3z9/Jv432MErVPly
	b
X-Google-Smtp-Source: AGHT+IFe1CsGF2APUDiVY14PUctNwIaAU5Ml4MK3iHilwHYud1qRv7qvb0fStxtDtgtYfeA8cfHqyw==
X-Received: by 2002:a17:906:796:b0:a3f:5c5c:33ac with SMTP id l22-20020a170906079600b00a3f5c5c33acmr9860351ejc.62.1709122601794;
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906374e00b00a431488d8efsm1773598ejc.160.2024.02.28.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Date: Wed, 28 Feb 2024 13:16:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8kJgaOdJwe6BzC@nanopsycho>
References: <20240228082416.416882-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228082416.416882-1-pvkumar5749404@gmail.com>

Wed, Feb 28, 2024 at 09:24:16AM CET, pvkumar5749404@gmail.com wrote:
>Changes :
>	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
>	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
>
>Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

