Return-Path: <linux-kselftest+bounces-8216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5D8A74AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC3282D7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D9137C49;
	Tue, 16 Apr 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs7SGRHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAD137C3A;
	Tue, 16 Apr 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295685; cv=none; b=pjSfZf34GWwUV931Do0OARNt9Jg966bka1Q6In0tjgew+gsBwppT5IHHC91mNly4SlboBeygIX3yLY/rxTtWz9EJOC/V/IIGjreeJJ7eMAL+34RmARX/UfIauii9/PEgQ6MtUVDaXkAARyD7rLaU9bIV7gCsYfdF8m4ZJhVLcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295685; c=relaxed/simple;
	bh=6oYvzJCewT/Y7/t2YqN6eF5ZDY7C7jCDP57CX3DncwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCFSfUCpRJt4L3dWYQzfVTceqZRhx0TUjoq9N9V9k7D7AefEQbWVUCh1fn7N6dIdj2BEsX6aXr0NsngaBvx0BnEEnAbizQx5hg6k3T5z4j4ta9x2Lt1sGKTcw494kg0kgTdPIEfTu4tVE8ZmLSIDIRGklfVej4Boh1c3zHJaAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs7SGRHw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ece8991654so4325122b3a.3;
        Tue, 16 Apr 2024 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295681; x=1713900481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxdtFVH/2uAQXMgoryBXaitmMAXcOlHSCzHSVcK2yX8=;
        b=Zs7SGRHwVGy5a81UpiHdjq+SrKb89AhDxIMYV7UlqCiT8EsP/1IWC49xIWg/bto7jw
         hTZ6iu0HoKNBcNu1rcBdmgJW7CCn22WxM6PYwPb7QMgTGh5hMuOvhULOe/lApyIKUPc+
         TLiaPT1GWb+w+47dnI5xgM+2uqVK6vbqlPIcozODQe8a8lzpwcuUBJ4dRxGe2l+jvmwC
         wz0BB4VzeQLVC5RBYihtclLms3hSMbci5ZrdYhRtNqtGV4DnOiYbIaa3Bw/Nc2b8pcXZ
         ErjjhRh4RwfNUbiVU5ln5PqP6C+r2//8vTJJnaT3fvNdrppm/M0uPFDaVtXemb1ABEjc
         sKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295681; x=1713900481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxdtFVH/2uAQXMgoryBXaitmMAXcOlHSCzHSVcK2yX8=;
        b=DdmJxwZ8z0qwLqeQT9iqkdYgMxzKUINJ0Egjmu/WdB0ht0YcZfy7SZckqepFt6y5Gx
         KGmRZIBnpq/IHg6ETzswgqHuBBzFZqMsVFOOdzaRBuWtqajgDmLZn+R1RsUEEauk9Fkc
         bNu6pAN4n0cowOZcGZHCwS1oJ8+itGkeuk2vSj7BMvWRg/c6A72uqeGsS45vEYLq6BUm
         rrXGUBLeB5b6+YQ5ftJTCHwEbGz2cEB6k9PcSymzZxdtVIwIATJfHXPtGowXnTRZrjb0
         VGx8zznn+AGfTNsGJRb1Xx53wMtxd9BlOT+xcWgX5iSXzXASW7sKgsNrCz3rLT7VR4ba
         veOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/1/ZWwqXA52V/DAlDFtiR+cfnbPBeq3kPL+iEek8++F5Fp0t2arNN3GaeNa50xxwyFxRyqBA8xnOHauvV7XWpSTJL3j5ElHdCwajdp6qepvSIfMTyV3cWTZI/kJ3NduZ5uJR1bv2Hau1ClxHMRY413Y+aHIigCM2IGI16ohFKdsBv2gj2pz7
X-Gm-Message-State: AOJu0YyvA3MhkiRrF2b3nOiLQXoiGcnvpPOqzhDUJD4shHswapYkfatQ
	tHtf83uVPeE/ODiCeW4vE+TsVDUI62ZCtiUHiz0hsj7DnVBNcLOn
X-Google-Smtp-Source: AGHT+IH6kU8OuJb3xZ9IFdmnokhNioWx/0Q0BMH1o8FRGdSgawP4Y8Zt0KlHai50XIRd+tDLbK9X+Q==
X-Received: by 2002:a05:6a21:8cc7:b0:1aa:5a22:5eca with SMTP id ta7-20020a056a218cc700b001aa5a225ecamr1934625pzb.31.1713295681372;
        Tue, 16 Apr 2024 12:28:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id 20-20020a630f54000000b005f75b45c771sm4573406pgp.38.2024.04.16.12.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:28:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 09:27:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 2/6] cgroup/pids: Separate semantics of pids.events
 related to pids.max
Message-ID: <Zh7RP2Tw4Gve85lQ@slm.duckdns.org>
References: <20240416142014.27630-1-mkoutny@suse.com>
 <20240416142014.27630-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416142014.27630-3-mkoutny@suse.com>

Hello,

On Tue, Apr 16, 2024 at 04:20:10PM +0200, Michal Koutný wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 17e6e9565156..108b03dfb26a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -239,6 +239,10 @@ cgroup v2 currently supports the following mount options.
>            will not be tracked by the memory controller (even if cgroup
>            v2 is remounted later on).
>  
> +  pid_localevents
> +        Represent fork failures inside cgroup's pids.events:max (not its limit
> +        being hit).

It might be useful to be more verbose with the explanation. I'm afraid the
above may be a bit difficult to understand if one doesn't already know what
it's about.

> @@ -379,7 +401,6 @@ struct cgroup_subsys pids_cgrp_subsys = {
>  	.can_fork	= pids_can_fork,
>  	.cancel_fork	= pids_cancel_fork,
>  	.release	= pids_release,
> -	.legacy_cftypes	= pids_files,

Hmmm.... doesn't this remove all pids files from cgroup1?

Thanks.

-- 
tejun

