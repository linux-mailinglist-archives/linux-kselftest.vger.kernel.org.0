Return-Path: <linux-kselftest+bounces-9052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2908B5E44
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16BBB24E44
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897F839E2;
	Mon, 29 Apr 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKK2lQoL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2082D8E
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406219; cv=none; b=bXp2QMJUCAFaCQ/9fKKEf5DnB+ZNdZwu+DorPBd+dmqFLWLNu9Wfbg+WkDVXI9EX371V73qaKC88f1aWiWY1ItMT89vEPGLhNxPT9+OV6XUs1Usa15ORTVlK1XzehUTi0Rm4InqEqtck55hkAJ9YmVMZTmIZgYNH+N6rXJJbIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406219; c=relaxed/simple;
	bh=ln/ctlMET0+EokkOHdYMTIPRVvXKe1uFuslZLmp/Iu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMhdLqHYubng0tkL9vcVLZcKXI1kiL2h8e0UbxxColep/7tEUsS+O/wgYX++xwyLgEn1z0eSvQc4rrgZU50lI3/1uXP5jADKYC6tq7g4UudPRxVKWoRwsp9mr64BqqlpLr2U4Fc4spbuKFWdDNd9ZYG8GsP5pRxfekNu07yr5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CKK2lQoL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso3706162b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406217; x=1715011017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DjewcbYIq7c/TPoADj3iJGWkV17y2Ws3yovJos8PGaQ=;
        b=CKK2lQoLapZiR/sNUMRqFNiCKE5Y7gkoPczJm4eSU7aBUdfsxtUpPcuQU9Y86RAtbF
         cNkyh3H3of6pMiUZhFBHVGswTgQmz5/fgQHbJecGA8TahkDaBqhKhGXozT3WMJtX6hgK
         i2DisxyggRAuHUFGDMO1Y2XhBGmgroHf5liwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406217; x=1715011017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjewcbYIq7c/TPoADj3iJGWkV17y2Ws3yovJos8PGaQ=;
        b=Ky72TnSICSBZKCKkcZvRX1pAZ46SzcI+D4wVnBvPIfz6Su3aBOpHCkq0l3yjoO9f2E
         dmH3ZaGfMb18ejEn1YgFoIS8WxELqFhrP4n0bTxC5/3StbIkrTchMHqHC/7XIWM/YrI1
         /0h6bnyKCakxp0rm02TP/yATGnRYZ4buIt89N8GMqDwNtzqCj0UUD0S9xnOIxzsHLJCW
         aRvpBnBOjRPV8iExxoDCwgOjV6wmp6/Z0870k4sc3gYdBMTRMjncTrNo2cc+6ND56WgR
         LNfgV50fy+c8maxkYvU59ibhxkGpf8L5f/YUESfRg/6Iepe0tHcZsWZp3dv66llMo/0/
         SNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAceDbksULChLfXvmJzEOSXKMKOOEXNMxz/NObjZLMHh6F0pPUIrsGzscUQQez0AvYmoNwUs5ANckRLfGa8OdKNVE0fH4Qm2dhgDHg24RK
X-Gm-Message-State: AOJu0YzKPQjJCwgjY+VTSC7KK48fqqFBecQZ/OMEiIunAjwG4oWkppIo
	RK/msr+u3gurGuxRkbY22EH4zRuAywKXSVS/gaGMtA2xgdEA4pFfpUxiWu2ZWg==
X-Google-Smtp-Source: AGHT+IGtX8s9RQQ04uPZujtZP7zzSJsOPnFU3xFcZv3k8VNpW282v6ntNSFT3IphQP9NXnShf8WEJg==
X-Received: by 2002:a05:6a20:9f86:b0:1ad:8f18:8625 with SMTP id mm6-20020a056a209f8600b001ad8f188625mr57193pzb.28.1714406217557;
        Mon, 29 Apr 2024 08:56:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm19436778pfl.31.2024.04.29.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:56:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:56:56 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 8/9] selftests/harness: Share _metadata between forked
 processes
Message-ID: <202404290856.494B7F8A@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-9-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-9-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:30PM +0200, Mickaël Salaün wrote:
> Unconditionally share _metadata between all forked processes, which
> enables to actually catch errors which were previously ignored.
> 
> This is required for a following commit replacing vfork() with clone3()
> and CLONE_VFORK (i.e. not sharing the full memory) .  It should also be
> useful to share _metadata to extend expectations to test process's
> forks.  For instance, this change identified a wrong expectation in
> pidfd_setns_test.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

