Return-Path: <linux-kselftest+bounces-10700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1A8CF588
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 May 2024 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CEB20BB1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 May 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97E1DA5F;
	Sun, 26 May 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IExAs+PL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072351FA5;
	Sun, 26 May 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749240; cv=none; b=kdlGbfcPRos/BlyzDCmde8n47bWdFhwBV4KSrGGKmD5QOrkPF0pMGJhfkCjBH9TtYDNGT7czxmSVeud02vzc7bRfRc9wU91u+qyFu0YSn9ZxXhYfdHbAcOh3xwf5N5tF4vkEM9T9A1dLJ8ez/2+TniWG8okV6ofM/VLzD8NPFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749240; c=relaxed/simple;
	bh=frnKVSu43OrJuRdMsz7rIGrcuSBmuhzMuZfwJ4GrIwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdv8QW3kkZNfn+ncpvaRrVlXgo9n24gY7bHHgX5ohiUvQGpTzvEsktohkTJ7rFnlEuXmssnROD5k5q7dxHXNHCc6DLA6lKAab/1OyZ1McFIFHFiRUW99b2bA0Jz4ge78uIzGZN7YlKuxhAr0tATYtr5oxH7CxZ0iGXZeMLMfTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IExAs+PL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b42d1caso15701685ad.0;
        Sun, 26 May 2024 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749238; x=1717354038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kY/rVz04n65zKIr3R5sTizybKZxPLRDpXYvpdpomf3E=;
        b=IExAs+PLJaqemuVASy1WjX5867HOFviHkebd7KxNhWWhOsUJMDsUyToPDm1CBTJ/CJ
         Q8ITtg3K7C6yrMo7Quy/xjCRmX+KBobx/IKExicKQXAJdj4UPXC4wqcUx5GL35bSFIyM
         4+TIjjMxh00xb+6hl3WDltXdxW8jNV5dxUkIDVEbJ3FelgdEsiPM8SFigeCnVMDqWpb5
         ZWxFK5ZqRIAK1kPMLfreha2ibKWmGvHTNEuGsDJFcJ2Tq+hHZm71/dPT4T9iByBobg6I
         i1wu/T1bU0CJKMZJxJv8N6+XFENesIF2GUVEK8CaDrbeMNlONb8qyV4dDVxU0+DwcYZN
         Y2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749238; x=1717354038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kY/rVz04n65zKIr3R5sTizybKZxPLRDpXYvpdpomf3E=;
        b=TsD4okR/74F2bUDFZ3MxdbT4TbsP71fTLLLqE5LzZcS9aNoGIfsqngxVcfpgQImG0e
         ctgpKkI/LIo25g+9JjK9gV0tjTM6tIgpjYsymZ7I+EcCehWctP6tOgYUcL+cM4uzSkQM
         x3uH+dZf4shGypng48cMv1PBtxsT4I4Uu1DHjA4w9hSeBhVPTmm+p8A29WD3fw4ltpqW
         MYCwW+1Yd9rg4tsQzLenzqTyI2eGZ280t4c+/6qW7+LWQwt7h3EjE1dPtJsrIuQ6QPzH
         RIBdjSHImlrbSq04VWXzJPIHVRtHiobB2xGEtYHIIflV4ahj1Uz8W+AEiDLHhVa8HtFh
         NB8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDgRYvHNRG8zlceyKzXn51cnuD2bcOhwE6WnIdekzoDWY5GTM6iryTGCSHACO8I6Oqy3C66cjn8VBmrftL2GTvpXUKP6mockmbvfxxUeMD1TUQvo4wHy/dS8xRibcK8tJAr5Nyttx9lBkAQ9rLG2w/Zs7tdRSGhxYU9QByFMIgyecEGkbo79ME
X-Gm-Message-State: AOJu0YxvM+WbYpn/qSeZ+W6ITEns6cBxklRuHam3qTXOWLANhKCca/OX
	7Krn0BqorhtoueNlezqlCZF+41OD/ooqu7KlfhPGr+KkEsEj5oW4tYXFnw==
X-Google-Smtp-Source: AGHT+IEyAc/rcWTRs8X1mfec50gk78YnBsoandfEtTwnYyq+aQgeZO61Y93KI6nEi33WUsJ6GlEo6A==
X-Received: by 2002:a17:903:32ce:b0:1f3:488a:bc54 with SMTP id d9443c01a7336-1f448d3510bmr90792645ad.36.1716749238115;
        Sun, 26 May 2024 11:47:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75e579sm45943235ad.35.2024.05.26.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:47:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:47:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v5 0/5] pids controller events rework
Message-ID: <ZlODtCOIjaAeItif@slm.duckdns.org>
References: <20240521092130.7883-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521092130.7883-1-mkoutny@suse.com>

On Tue, May 21, 2024 at 11:21:25AM +0200, Michal Koutný wrote:
> Michal Koutný (5):
>   cgroup/pids: Separate semantics of pids.events related to pids.max
>   cgroup/pids: Make event counters hierarchical
>   cgroup/pids: Add pids.events.local
>   selftests: cgroup: Lexicographic order in Makefile
>   selftests: cgroup: Add basic tests for pids controller

Applied 1-5 to cgroup/for-6.11.

Shuah, I applied the two selftests patches to the cgroup tree as the new
tests are dependent on the preceding changes. Please let me know if you wish
them to be routed differently.

Thanks.

-- 
tejun

