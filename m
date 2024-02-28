Return-Path: <linux-kselftest+bounces-5538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DB86B00D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC3D1F213C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D114A4F9;
	Wed, 28 Feb 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uqK1EiTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C03BBEE
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125944; cv=none; b=V/jrzE4awdLttBwKrDUaIGnR6pzDWsH66k3CQh7KQMAJ93k06d5qNjJ4TEnsr893IHHekfMvRBP0Iv+S8N3qTifLPw4hX1VziLPfC6UsS4d1MTaq/gZcnW/diC2sa4UfE2sBmBFxX31ak/3xvmwTpGK2TePZNll3Urq2WG+/O14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125944; c=relaxed/simple;
	bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGCOLskSXt6uKCsEwGN+2dAPKqQzzW84h7snQXAcs2wTi4BPjG1bini2mJNyYM+UJGwjOB9gvHXln40ahRQxU0dPxkuJTwCcDI+VKltB5+zTzYsYBP6s0QOCrWbg64MabKquU9O27bpkXZh6pFPygvBUSHbUOZ1CZqUHWoTOQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uqK1EiTh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so3735136f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125941; x=1709730741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=uqK1EiTh3xel+0qm7EhNE1wrmPIkHwBuvsPN9ed1KKFieLgrMMcj875f6MPNHStiO3
         5/tgtrcsgWS/1QpPJATY+kIh/6WGvKESqnCypzvq3Hf6u6bbQ+SwBAJ0svB4wq0CGoIs
         JidN1OVsX66nsMI5C/qbqXNzYTz+/RrryIDTbYsg1Tp4PwvLQRfz4LWtaSE25nARWCL4
         0HZSJmDLBaXpTd3akC45U1hXQB5dOGfNIuD7F03HDO60NSsCynekGmd88OfZplUsc7Y8
         4RGWr3cAKne7MCn+dQhT62U5z72CHmXK/58lqkVebazcJij2xNhxnQOQOHIWDmknXI+M
         QAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125941; x=1709730741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=abhAOdUyU2sEujF/Q2GA7hlqlN3aBCFwOKI3zPXEa2A96cvsFC26Ap4jouQJNp4eQK
         bo1nC7U3axIGLNZSCONgQPT/vpWfx3hKbjk/xdDZd709pkBEVHidWAOLTQXmEFVHuwOc
         jUlrSdVINhmHPdXH+b/f+7XfohYK+ZAJzd8IoydskDDB91ETDdG2PRf9FEc+wG55MGcF
         icOJVa5AgLs/pnhxkBOUoUI4At5uPqiM/7P8gpmFag8LH+jqGi2A4aGKBQbRZQP0NQoc
         qUKSc58hq0aYVrJ+CEedVQm0vVQushlTl8KKkn8uOx8VqzO7h+Q19ZnOI/r/OptivTVJ
         jsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhBgosG5tBQOyqqpDO/vbd3Tug572b21LazG1VJjt85p7N4fvMlSVFohneKz+GFZT/BoHuwtQCRSfXdXf1bfb0p6pnFt9OlykMnXNRZv4r
X-Gm-Message-State: AOJu0YwwY5HObzlcgsqDPaD29KUk4Be0d6MD9fT/e6IOZS3l533QH/8i
	l5ouGJx9VwguM6hRzFq3jkhNKZSz+BDIx1NCCboYPDeJbuEHyxzCtH0QHnSnfsI=
X-Google-Smtp-Source: AGHT+IEm2GPfTV3ssQeU4XVkZjEXwj0yIajzxFEe5Z89HZRUR1knrmaQTBO7zoB7PCjicKbgFQLtoA==
X-Received: by 2002:a5d:698f:0:b0:33d:2d07:b567 with SMTP id g15-20020a5d698f000000b0033d2d07b567mr9499056wru.24.1709125941487;
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm11954467wrb.68.2024.02.28.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Date: Wed, 28 Feb 2024 14:12:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8xMsNFaF6ZE5AS@nanopsycho>
References: <20240228120701.422264-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228120701.422264-1-pvkumar5749404@gmail.com>

Again, you sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

Could you please avoid duplicates like this? Also, note there is 24h
rule not to repost the same patch. Could you please read:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

