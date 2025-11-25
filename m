Return-Path: <linux-kselftest+bounces-46417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF6C835B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 05:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 943D034C485
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D613777E;
	Tue, 25 Nov 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDCtOaXw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C25125A9
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764046268; cv=none; b=XZNC3IS0ZeApwFWA7+PLgQFyroRAojhT151w7X5uiPNxnhY8ZOHsaDYM5ZtJaTVsrZsSxlcy2k8LOE7O5DLtw5JsDAT7dnLYfRbNe5jFCQAG4keAg6k2XLDl8/3nySt8wl9lSu7sfEjKw+WiATRBRrEWTF1q90k5lBJ8W40xyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764046268; c=relaxed/simple;
	bh=OLVBmPG8j6GzP76zDnYpUQ4h66yPa+aQNEhptFE8fAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pesW8o65aHD6F4vpGFP/ltY9Y6JusSusrPHNW5NlBfOp7ph9f2IaHgMlMqLCgkJ1dg3tDSCXed19XwXUMcCPDvfInp98v4mPztWNJuPibKX/+ErbeTC2q4Um7FYX6oN/+6nVtP6Yx5qLZRb88Wq+tjqKHRmadI0xxWpQ+KyVUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDCtOaXw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297e264528aso54172075ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 20:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764046266; x=1764651066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=So70PABuYmwiVS2rQT+weQWSpvcwtJRxFrB3jRHhBHU=;
        b=LDCtOaXwY1frpLYFXYgLHG/kYKTkPhJn33VXS9EJ/5n+id19mnOsIDG645jWSsxD21
         6b6mhMGfuy/3QXnUcs4StDH1aWC5SurZaKQBagUfeqpsQL1N1osuwj/D2nVTT3wtYAND
         ZZRcYDvtqs3QiJqvUgagQVw1/XqWjdGLNODNHiy2Q4nFMA3kvn2l0kK6nIrKVHV75CAG
         XXjoptE83zs+r68ZTb7pcgjzVgdsjI60Dyh/yzMT2fk1KitMkxwqrIq3HFJ5xrlzFF6/
         TWd42Ne+xyRrSNvpiamRW72D6jm8uvcg5nu+m3JiETvxvcuVdR4XQzRasFtuGQzIgqna
         bpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764046266; x=1764651066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So70PABuYmwiVS2rQT+weQWSpvcwtJRxFrB3jRHhBHU=;
        b=o6HFVIKEPhfPTw45cgEvyLKeCczX7VDj6Vn6xIRfyBZNHCFYUZOai3/wkgUyRyPRXA
         Ahen0ivHtC9xxL733t7yBqnM9qisXMAjO/PAOtIn2qjW36A+RadiOyFFbXYmaSZZQgNN
         BoeN5W1UJkF4xo7NzRH47RLthVLhBmZ5+f995PbSJEjJ+z5+ieQmvesmdGdRPr0KXsVD
         VmlZCbPsD7ocDDQdjKcVSRJLJNowndm4PXTYoE6c32u68DfeoKOH89Jczr6+XsMYnyOI
         JojhtU3Lmrf1K8pGC/oogNiofkOkD1gf0onbdIDgo3j9AKNu2nc1cw6YHgJjXFeoa6nn
         zzAg==
X-Forwarded-Encrypted: i=1; AJvYcCXV0Vh6mKqvURRzSIUaMaF/mIhn3QU090oVqq1DvBncaUNzw4IXQXmeIQlfCym8BkNiUW0zzrE/HMuaDPoSHgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzeI48O77pJ5CCins5gPOAfW/1gTelEp7r11G85g5JFjKtPoA
	GMW7w0yRgFEKq//tEGQ0q72xFBawljdUxsqRs1H1YS3ORSPXWaD3OGd7tWJXAm3R
X-Gm-Gg: ASbGncvDqQslHgvUd10vALYzP6DwArWPAk+p6QJqqXOggV1OBPAcLXpl5qj99+rUJBX
	QzK8+L0uVrQdXDN9CRt1NVtCASVd914qcbz3aJm7RQym9oZyRB32v2tvRKE5T74Cm/RAXgbwLbu
	Ro2EAC+Epy2tFYorqQ8Qw879dORzvJOMpaRd7d9vSJGKOSHALn3jiiMBwhLz56eqyZm3oRG/8CI
	CIfsnSYZwNUV6wO/26MjuE7XignAfvbWXnM04//TfVLYrmIghE/NS5INj6SJCMLxvxp6soWyzN0
	BphAjJbKv3gpsWHH7AN6Ggu5iSThNjKkKwTbdeqdTIdTggVPqaZ8b8FNwQiqe2KVNKtpgg2NI/l
	I9MscH/7BBGMGM4gLfu1PWYHjlTxA89XgUL3Nicc92/qthyLUPI7Lea/X6GBuvPMCrsFW29dPur
	mYSdhwGOQV89po4GrCaQn0DoDe5KsE07v91NMKw+/g
X-Google-Smtp-Source: AGHT+IEJwoNtA2LHTX3evIy+4lgKd/9gvNffA9k4wLYzMUw0MQbNJ15fvAYHaiTtKC/EccM+dCwBDg==
X-Received: by 2002:a17:902:d4ce:b0:295:5da6:5ff3 with SMTP id d9443c01a7336-29baaca4394mr18687395ad.0.1764046266020;
        Mon, 24 Nov 2025 20:51:06 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e32csm151690225ad.53.2025.11.24.20.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 20:51:05 -0800 (PST)
Date: Tue, 25 Nov 2025 10:20:56 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2] selftests/futex: Fix storing address of local variable
Message-ID: <aSU1sMZ3yf73PZc_@fedora>
References: <20251118170907.108832-1-ankitkhushwaha.linux@gmail.com>
 <cfed2906-291f-41e9-a6ba-4884a7380d17@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfed2906-291f-41e9-a6ba-4884a7380d17@igalia.com>

Hi André,

On Wed, Nov 19, 2025 at 12:28:37PM -0300, André Almeida wrote:
> Hi Ankit,
> 
> This should be "Remove the static..." as noted in the kernel documentation:

Thanks for pointing it out. I forgot to change the patch name according
the changes. I will send v3 patch with correct patch name.

> 
> "Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
> instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do
> frotz”, as if you are giving orders to the codebase to change its
> behaviour."
> 
> Please have a look on this page here:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks
-- Ankit

