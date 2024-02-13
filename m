Return-Path: <linux-kselftest+bounces-4569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699A853941
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E92853E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449C96089F;
	Tue, 13 Feb 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PEvAUkiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4293605A3
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847026; cv=none; b=ZkD00P6/s8LSew60MaK7qLzZc+U8Q4Q6gay6yivjAywZ55wCmu9rcykCahM64iFcdhSnr7PVrdikAUgNpU6Euq+OZIkVvxnD8I2fJ0A4qcOz8TxuzxePIuCR50St5xQVonhO1Fjr9kHs84SDKK2wF1v7sK9cr3NZ6/gXnkdIHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847026; c=relaxed/simple;
	bh=5S8T8V7DE2zdbZjbCxR1t2+r9jrp1nOpuzXvC06KeiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4cLhsJ+QxS+57MKMGo+AUVkTPBZAMR0RMTf9+juie7E07JFx6TjkFMbqsUuuCHjKMeF67jHPMSA2G+8ATZeYvwdepDOTMz2QoxHno21iUKhmXFJyxgZ4myxNp+SGUbEFHPdQd+eUidaHwRjwHTstEO/Nmhgs8WL20XJOSXP9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PEvAUkiq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70b0e521eso35344365ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707847024; x=1708451824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWUJEKGvkt1d8Oo4xr2/DShsZCrN4V06W6OJyQUPNW4=;
        b=PEvAUkiq+3mzfAPZ74jMaNfWBj16l67+PUC3VsmreNvXYms9Va7fuLDQfBdHnv4RrR
         rMSpXgeH2mr3E2j6UKQUmXFCAMBde367SPbBrpDbH2CFbIz0O9st/qN9zNXFWUF17Ssd
         Tdxeie3tzCNgRtdgNjrmjUlRUr86qzrJPBUko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847024; x=1708451824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWUJEKGvkt1d8Oo4xr2/DShsZCrN4V06W6OJyQUPNW4=;
        b=qgMX3TTejOTsQMDM1JISmJpDC1x1W4lrTFB7w4aLBpD0PP/B8cv2Cvfks8ydT7g5u8
         HJoVyFbWyVicW4ajB0ItF3/tdu/s707gdCsC8/vXYh8NqsYoaUC0zQ2sOdZJHLWIHwWV
         8J+s+Y74eZcNIzxwUXU7yWaaZij3zQtGa0ysC1U1LMHX0l/sIOefGjozQcvuqqsCQyN1
         3dsaZhdsF3Qm/Z7HTLiW5NIDtA3bC0j6OfkSlwJREZHrCldJJajevi+ZvqMTn5fMJBZC
         DkRBnq0CtQp2ZOQqvKE0yZc+z1OxJS3fqnfgkNkXfmL1PqlH4sgLd6YW76k5LrzVNCrv
         89LA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0QoiifSlOkm//OJaND8JMm/ot1gUjoDiRxutP9UaM0VO+185Jera0/4968qfYExGBGqfz+JRaKrnqfxcnYbze4m3jppDBMXp8iWCEOlZ
X-Gm-Message-State: AOJu0Yzzsy+rfZLK7krtlR0nbuWAOZ87JwFEgeDR4hpv1EjpsPNp2mOa
	FSaKPMIU85iJ8yE5EohkhKz+81EaZD3sQ7C8+I+HNk7hEVzN+QdNWyWATFancg==
X-Google-Smtp-Source: AGHT+IHCmNopIbIorHA6sFJtdmV4BL2uLqMvrlhF23u+CGR+TuwKsSyn7Y1bX68Jw2tMYvY8XcpVzg==
X-Received: by 2002:a17:903:2307:b0:1d9:dcd:c726 with SMTP id d7-20020a170903230700b001d90dcdc726mr335982plh.17.1707847024097;
        Tue, 13 Feb 2024 09:57:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuh8YxEWAzlZClNj6EBYXLJkXwmfSSc/Hpe3oiIDpYw8U4sp2liMIPLJvc5xQoRv5n2fnseI3BriDVPeq4+BBiT4FMqfiaTBO8aVf+DnKo7U7IEOdZ/WIC0ZVoUGoYfLynOCUem6qigqNngvPTLD2olppYHCBGCMmgtMYH7g==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r22-20020a170902be1600b001d9773a1993sm2337673pls.213.2024.02.13.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:57:03 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 3/4] selftests: kselftest_harness: support using
 xfail
Message-ID: <202402130956.E23884A5B@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-4-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:15AM -0800, Jakub Kicinski wrote:
> Selftest summary includes XFAIL but there's no way to use
> it from within the harness. Support it in a similar way to skip.
> 
> Currently tests report skip for things they expect to fail
> e.g. when given combination of parameters is known to be unsupported.
> This is confusing because in an ideal environment and fully featured
> kernel no tests should be skipped.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This is great -- I've been wanting an XFAIL for a while for harness
users but I didn't have the imagination to find a way to make it work.
:)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

