Return-Path: <linux-kselftest+bounces-8217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DCB8A74C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9A21F21736
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839D1386C8;
	Tue, 16 Apr 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czd1Fgw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B81138496;
	Tue, 16 Apr 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295910; cv=none; b=FoIM8jaHth/zeQc8mh9HXqLq6T5XK/QxQGzbDgsMb8MiO/GpVAQyGrZxMZu4AlXzaiV/vbee6lzQLTxo6tAbX2xNu0v5GbQdBzQp9DPKElxOtiPC3HL3e54Gn3P65pezhOxWneB4H0j3EOYr7FQYZwnwam7yjuxH4du7Un2SmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295910; c=relaxed/simple;
	bh=/g1Qb9ZIXohbsDDomF8O5WJs2/QuzbWsl0pkvJOfmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0iAyuOqTx5k9WOmsVOnSmjZynGU7Dul9Sej6+PhYjWpHFFBURgWSgZ1oaVnT1dzNkD8eE8lOf7TYiiB1GXlI4r4jVLWtkCRnKqSw7NvBYXkGrrmJpUzX1v1bt9DR5W7zOXrMC8eEeLiAKABFK5XVY5F2G0/N/SgauvGunLWcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czd1Fgw5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3206745a12.2;
        Tue, 16 Apr 2024 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295909; x=1713900709; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W2OGUTS0A9tOC4rCeQ7/73mUP1Q5seVrFrFA/nLuwE=;
        b=czd1Fgw5DlMA6N1X/W/ahrGUkcYGhTmZ8dT407C3biU1k4hUqRAXA0aChu/aaiz6KZ
         weu7/WPvLAgSX1+uNucJH/h6sOPhiLx8SUu2oiYWrRmEE3Z3788brOft8dBFeHYFRYE6
         1/t5OERXgca0Me2k+4N+NJTcDM1GbYxhzLAj9hTuBZohkWreG7RorgujKYwHv7Qcr+51
         ZAmM6QbshBPTWEb3uY9y/JxA0YfzzIY8aDCX5WO8AprM+fxHbbD4HX39kbMl6GOTmQUI
         YRqnhwz6nSqY/ZHVljJEQSmoJ1gUkIlV+5lNXXxSFv9SOWb40KeHI03WVxZlfgkpQSrN
         m0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295909; x=1713900709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W2OGUTS0A9tOC4rCeQ7/73mUP1Q5seVrFrFA/nLuwE=;
        b=F5Owbai0AbOL0M8J/AhTfxYeSSYFWHRyaSQq9hjpw0UnApXUeDQ341T2cmA0klwUrr
         MhT4NNnE0ntbTvqB6eJHj4f2cxOZz4jsw8/BNvMuSWYcb8YGPiuyT2o2vyABgqMMIMn2
         Hf3tjMHF4xS5njIqVD626s1KLB9B96cmCKtEKNzc128SOkvmN7QLjSScIYtTei+rXAhR
         LUgkcLx/UQscI1pqHlm+7IH2K1sQ5vEhG0DEMkdpG1k1mOYn+i0DrvC8d2iT/YYixAHC
         Up4vtEjEaFGiq7HLOadnCbi9pA03sx9HPuBkTwRXtCfb0q3hhoB4i/xHvjjpX12Xzsuz
         TSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwuiLrd2RwRIo4c+vJeTlkZQAGcHtcP+njuvwhkrq5wucJ7TF7N/fS0XTJOchAVKtdtEJdr7TIunNN1z+xOmjg5JFXQfhx8lkwipRfyblvW4MMzKXXmbzWjmIXIkcVoKi0nTxEkO5yxvq9tDecK2nL+BRvdRLfzanzc/sG9dtCzhF5dOZXgXTY
X-Gm-Message-State: AOJu0YwIKbp82KNBPkE6V76RRZwBKvZdrjHd/M8HD9paC0sbDLKPjIP2
	1CcXvw3rNG6yHCcABEMEDXLA8h0rq/OK2C9GTZ33TzkMaq8qDGaP
X-Google-Smtp-Source: AGHT+IHSNs1U4Cgka+Ov+53HT7BldDE7a5hg9YtpBWTXFDs32OYniFi0zuiHVl1am1uunK7pt1vfSg==
X-Received: by 2002:a17:90a:fd14:b0:2a2:ddc0:4bf8 with SMTP id cv20-20020a17090afd1400b002a2ddc04bf8mr11933603pjb.31.1713295908568;
        Tue, 16 Apr 2024 12:31:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a25bf61931sm11108889pju.29.2024.04.16.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:31:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 09:31:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 4/6] cgroup/pids: Add pids.events.local
Message-ID: <Zh7SI8LaSTEq4Bj4@slm.duckdns.org>
References: <20240416142014.27630-1-mkoutny@suse.com>
 <20240416142014.27630-5-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416142014.27630-5-mkoutny@suse.com>

On Tue, Apr 16, 2024 at 04:20:12PM +0200, Michal Koutný wrote:
>  struct cgroup_subsys pids_cgrp_subsys = {
>  	.css_alloc	= pids_css_alloc,
>  	.css_free	= pids_css_free,
> @@ -416,5 +469,6 @@ struct cgroup_subsys pids_cgrp_subsys = {
>  	.cancel_fork	= pids_cancel_fork,
>  	.release	= pids_release,
>  	.dfl_cftypes	= pids_files,
> +	.legacy_cftypes = pids_files_legacy,

Ah, you restore it here. I see what you're doing now. It may be better to
reorder patches so that .local is added first or just keep the legacy file
behavior temporarily altered than removing them altogether, but this isn't
the end of the world either. Can you please explicitly note what you're
doing in the commit message?

Thanks.

-- 
tejun

