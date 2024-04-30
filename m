Return-Path: <linux-kselftest+bounces-9156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BE8B7F32
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1731F25B3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDEC1802D7;
	Tue, 30 Apr 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNOhx/Da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA61802DA;
	Tue, 30 Apr 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499284; cv=none; b=tobsWvpcMAqRlxpM3opMyZMqA0tAQ7wq7aezX9rkW6WlyxY2/AlsEXPCnfRjDNPYw0LucNAkk76tNu2MEHA9D4EN6HC05AH9hcVkLGlXHfDgbNMwwqTYA5ss7KkwKFV8/ZIFWpy9saZzdzW9FWUjb90rRHMxtHgAvsv8/6MvCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499284; c=relaxed/simple;
	bh=hguz9e/uXlmV27IbGTzkIbjpFTvfznvOvHxVvt66hJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm9xPUaezlDho1hdrYhqM7UJPd2/o2fKWSSAE67FThjhZ1qjbUw6+DoZW+y6T5HtwxHxS2gmRnwfGjzLHWrTku+BEcDnhySx2Bcou7X5ByMS3FxXnyzIBEWmEDzPOVX2l8kD4OIf4c9nXpFwc7eCUNp+iz5XIbd1/FOIM44IybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNOhx/Da; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d4d80d00so7621844e87.0;
        Tue, 30 Apr 2024 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714499281; x=1715104081; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjanLQAoH5caJfTTxRxXaXQWVwYkN7FUId8LqRmIVpc=;
        b=aNOhx/DavZB6CaB7pIwVImORiSjBL/8JJo/hiSex3ViIFFtNUZaptvV4ULshAHG6gV
         cEYwbyL0IMsHa51rhx9AufJhNi+JAfxCSylSf63yO7uzEcDophDFg8T50QF4yt+sqNbX
         pHjQ+bRsP7GtUXKVfTGYhCBgX+j0d6VwTqZPslaDgEMYUYN5R4jsmHLaVpPI5vskZtc8
         GDnjQX7I44rvVU/OUgN63CWIr1s5PyKmp67R21A5d+PwTs8H5Bugw44w/frHVrzb6NKJ
         NTBb8gdfwA2PjOopcaGwUlrGWMuGdV+ulnsHFxbXbQ+/NUwg1+M1LfREvq0Pf0BKyqQN
         mSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499281; x=1715104081;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjanLQAoH5caJfTTxRxXaXQWVwYkN7FUId8LqRmIVpc=;
        b=NpL3SDG2Z18uFatIaxAcvw+HXShNvaM1wxtouYxmk1vG+nAGqoK36CLuHRblC/n10+
         /LXLV3c2MB3d3lgkPXnHi9ghHRJzcXMb1RRKDggEB++LgGDjv3+LXJYG6Rpa4tb3174D
         9ZBgdUSvj1Chjg2EEHTJKTKxV1wlHu1EcewmgF/IomrKv59MqK6DVplIRMJKclvWQA1w
         DZ8528+G3V16OJ4pDuobVhIToJjLEDgIRNIdEgCqghUwWwSsFzFRkuKnRlXXk2t+mi5T
         8fmTtyXqs2aGQ1+OejnYiAA5kBX8HTTvmnvbk5d5pjWDCCdevmwour3i/mh/Cl1fFCBi
         QhGw==
X-Forwarded-Encrypted: i=1; AJvYcCVflpsMjgUbNP5QyUwxh+rNjdlEe67Mh6tj2i8a4oKgsZWEMuSXBQkrXGjJEcSrrUkbbSfhnMri8X3bQlDRP5oD6iOAcWaO4UGLsv+gg0wJ
X-Gm-Message-State: AOJu0Yxt4RqHiO8i82FQWwTT484W3jp/j4O3Ez1B77ttGNoac7jolmXf
	3PovQOdJHoRt/cPfuvHFxYtsbcePN7C/lFkT//B73dl0PaCZSY9e
X-Google-Smtp-Source: AGHT+IGdwXEMTB9ffl1/wAiKMLRD/khw6JQdBSwbAizdtmTf8a/vsN6L1Pwzuw6LjJpITj85iC99Yg==
X-Received: by 2002:ac2:4ec8:0:b0:519:4f54:1ad4 with SMTP id p8-20020ac24ec8000000b005194f541ad4mr123491lfr.27.1714499280390;
        Tue, 30 Apr 2024 10:48:00 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id er25-20020a05651248d900b0051d416e8437sm1200382lfb.68.2024.04.30.10.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:48:00 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id DFB775A018C; Tue, 30 Apr 2024 20:47:58 +0300 (MSK)
Date: Tue, 30 Apr 2024 20:47:58 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] selftests/kcmp: Remove unused open mode
Message-ID: <ZjEuzoUMX1S19QGb@grain>
References: <20240429234610.191144-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429234610.191144-1-edliaw@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Mon, Apr 29, 2024 at 11:46:09PM +0000, Edward Liaw wrote:
> Android bionic warns that open modes are ignored if O_CREAT or O_TMPFILE
> aren't specified.  The permissions for the file are set above:
> 
> 	fd1 = open(kpath, O_RDWR | O_CREAT | O_TRUNC, 0644);
> 
> Fixes: d97b46a64674 ("syscalls, x86: add __NR_kcmp syscall")
> Signed-off-by: Edward Liaw <edliaw@google.com>

Thanks!

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

