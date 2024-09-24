Return-Path: <linux-kselftest+bounces-18287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7529841E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA5C1C229CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B1155742;
	Tue, 24 Sep 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HCVimIaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD942154C03
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169469; cv=none; b=ai2yK9pLmm3vS9M2zqBeMmmPDm8mXh403svDZUYYPU7UuqSDcgBrgOnkGRJtLh+uYsSmp3akYT9yte5qlb0zz5C9oJlxhXsNAu+WnmSWLk9C2K6bq9xF8s8kTdl6wvAJh3vZYjZ/8RzFnN3yXzqfjnz5gIiezo2pEeXYLxM3eoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169469; c=relaxed/simple;
	bh=lifwU57IdaHrim70smgz6+zaKKAD/ovA/nD15yWAbWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si50RHYzUJAnbR3EdXTpjuSWMki6DUc5cP8HS/cQamaIExSXdVbI0QMhi++rjYguIF+GhjpRSwmtvMhITzA+dK/WNk+bX6WrpZT+FlhMpCzNw3boET15i1kOfFSYvpqIPokR2kPUKydVQCnv30EsNUwo8QF06W+Ubr8OkOEY3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HCVimIaX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c413cf5de5so7047316a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727169464; x=1727774264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TJBQey2syq4faSYlPyUUd0DDrhxKWRd+pg4UR04rt8=;
        b=HCVimIaXJWeCpo3bm0SwHyrm7qTpy6sUcLwdDr3lh7ugsJRFkkgfDmUJuh9GYSIwkP
         tAVXqvavXIie0TqmXcA2KMtFpqIkJ31z8obE3GBdDKOG1AfoQLFVX4v3WhO2cHb+7flX
         LZKIHhwnRPJHg2JC7lfPCRqhUbvfRxXckE4DsgPaQsQaWCHDaGJpKtRK6frCr2IKAoKR
         0LHiaZS79l8UK+5rIXo7l5Lz1jw/hv97THGQldDSf42ytRPbf3Ztd3WBabQoylFLA8Sq
         qPpHrPKWTpD5HKIMOi9JEBgwUF+GH+S2LLEhXqsN5gMwVF4R2/0kPpWYGbQkksIqcByt
         QxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169464; x=1727774264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TJBQey2syq4faSYlPyUUd0DDrhxKWRd+pg4UR04rt8=;
        b=BUYkOhfMfFMKYceZImN9CNG6/LTGQfC6A1nEh99Rz5obj/YCbdmNT8wjcXnYV8Zm/I
         PkinQbPjoF6YFuEVdpBSTEiM1TBK5lg4OZZJqaokRPX5UViPtIPh0TXcQ2s7zNlklQWY
         HY3AQmoGTTtnILWwjtjNil14NHXpw8zVA0uL336JHPYRZ0XbIgznx4vOKnFLfe8HMe95
         3FiQP/40Oo77JyVf+9OzgaaVN4vk72lbShErA2sSgB3aA/j5Xjrgxj2Obs+FuxQH05VQ
         9LNkAQhD8qjdwyzfIVsxJqHJca218YBbl8xI8xhrCDJfq8zaujmZLkFx0r/uRq1nc3xi
         z8GQ==
X-Gm-Message-State: AOJu0YxsnpMo2Ojvt8l15j2xQheZHONbAwOsXhvaKZ7wFY0v1ZEPUyQk
	j0L6Y+92KU2bjSvTi3ODXolzZt8hQVa+zkQ4vJXzxzyT1T0HyTD25MUXy6NtcqU=
X-Google-Smtp-Source: AGHT+IGsORPtjPRBPeev8eyG/YlXfAlEMN06wNUjYu9/j7siVEu6mX8a+VfIs+U3fjiFWqSttWhs2Q==
X-Received: by 2002:a17:907:d3ce:b0:a8d:60e2:3972 with SMTP id a640c23a62f3a-a90d4ffdd3bmr1314481466b.23.1727169464395;
        Tue, 24 Sep 2024 02:17:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f0b23sm61486166b.144.2024.09.24.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:17:43 -0700 (PDT)
Date: Tue, 24 Sep 2024 11:17:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Michael Vetter <mvetter@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] selftests: livepatch: test livepatching a kprobed
 function
Message-ID: <ZvKDtlu8i5DbTCh4@pathway.suse.cz>
References: <20240920115631.54142-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920115631.54142-1-mvetter@suse.com>

On Fri 2024-09-20 13:56:28, Michael Vetter wrote:
> This patchset adds a test for livepatching a kprobed function.
> 
> Michael Vetter (3):
>   selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
>   selftests: livepatch: save and restore kprobe state
>   selftests: livepatch: test livepatching a kprobed function

Looks good. For the entire patchset:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

