Return-Path: <linux-kselftest+bounces-6292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD087A29E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 06:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8103D1C20E88
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 05:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0BD111A9;
	Wed, 13 Mar 2024 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IIKu5lI5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECD13FFB
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Mar 2024 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307425; cv=none; b=prgRVB+PINt1N6oVlB/6TtDF3Ql4OgCaeovJxn13iXpENGSefqIS1Ey3rK1Xcw8AhBzLp9JnoFjJEgxpLOEmhznQWuyWjg3pPZMtSZ7P282ZkH3NrVaEGaKfqi4JlzU22PK++dp/87ZCTySavTqkqb/60WG+A/e+VT4THlcKphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307425; c=relaxed/simple;
	bh=zYil7VB1TCYdWVBYlwEPEVqd8EWzj5DvATtjlgOwLv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8cq1WcanBvRDbJHw4Cb/tPUb2YQaUp8QTLlkdS4cldgIJ1Crgd1Zxm9Sw3h9H5g4tu3pXSbBDlJfRFyBPKnl99atoAmCfzBDXhrmb7U8Qx39UkWmWJEojSrYtNVWe1HK6avO+pug0CSvzLe52sPadkwYsdsXWYYkkqRprOTfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IIKu5lI5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6b5432439so497060b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710307424; x=1710912224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCdhNj8nwtztGikhrapa3sVqt7Ox4agy0aN+y1rOFmw=;
        b=IIKu5lI5PCyZ4r7I1/i2o0/e6NVIghYcyIlxqGToNBYfXUYFdFC1xLymwLzB3SqrYc
         bhS96H8PRMOtA7qc2ddD89jbv+rsl8e5KdWAMZpGZnUUOM9qaH5LRtyZi1ukJ6s9TSz3
         DPI1pNZxs2iy9EZQNu8NqF9CTnd6SFtfhgceU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710307424; x=1710912224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCdhNj8nwtztGikhrapa3sVqt7Ox4agy0aN+y1rOFmw=;
        b=iq656Ps1v1Jj0QntcHSwLsPfvOEVRTttNmOJuwhebNmxDBlaI8nuxv0yKguNJreihS
         nKmyD40HrO/jnwuzZsA0l83OPf6xPg+VVcyXTp+FiaAX2LzsGTIVfLRSoulmAINQ8Zda
         F3u4RoUgn8TGbdZ6XDeJj4n4RWLuWmiUr2ZQCAujax39Md4y5KM2seKNQU9YjT9dUmBp
         NgQKE9SRjTjuBkFS4EA3/h9PjOGJrMto9mizgoiFpszEGBlLB53NhPtHx7QpL5judTAf
         UwRK4+QttWeLmVGd/DVG0DqscVqPVZP30tVBTuDu1fPP3ryVfM3YWf23t7FzJPl1xu25
         sLNA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Cr+/avF1D4KzAQ62oSH7i1baHfryZSu6sQkyR/gKyx5HjjZyD/C83hMyEnQfeGn573zjm+FlCHIz9mYVYtXuMsYZRjKg7+X7Flho85nU
X-Gm-Message-State: AOJu0YzYm55kCOBuB8ziXxXA4A1PZi/mM3F9CRjIUY4AaGsarIfEb7pS
	mY+j2W1pp8oGeqfGSN7gH8Zw6wrpi1+S99QGjQnUstizyc76gW3aBWyn2xBk1w==
X-Google-Smtp-Source: AGHT+IH9R+us6nR+IwvQwvyyM4nIyZhEcwNSG04D99omPj917ht3+knS4iZkhrRYBAUX2jm+JhbjcA==
X-Received: by 2002:a05:6a20:d904:b0:1a1:5039:afe2 with SMTP id jd4-20020a056a20d90400b001a15039afe2mr2559506pzb.19.1710307423947;
        Tue, 12 Mar 2024 22:23:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b001db5bdd5e33sm2169948plh.48.2024.03.12.22.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 22:23:43 -0700 (PDT)
Date: Tue, 12 Mar 2024 22:23:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Message-ID: <202403122219.F96418D@keescook>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
 <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
 <202403071238.AC7BD90@keescook>
 <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>

On Mon, Mar 11, 2024 at 10:08:36PM +0500, Muhammad Usama Anjum wrote:
> On 3/8/24 1:39 AM, Kees Cook wrote:
> > On Thu, Mar 07, 2024 at 02:22:27PM +0500, Muhammad Usama Anjum wrote:
> >> I've tested this patch. Still getting same failures.
> > 
> > Okay, thanks for testing!
> > 
> > What environment are you testing under? It would seem like some unexpected
> > userspace conditions exist that the test isn't prepared for. (I was able
> > to reproduce one error with /bin/dash, for example, but not the others,
> > so something must be different in the set up.)
> I'm testing on Debian Bookworm with v6.1, v6.7 and next-20240304 kernels.
> I've tested it on another VM which is also Debian Bookworm. The default
> shell is dash on Debian as well.

Thanks! Okay, I can reproduce these failures now under a Bookworm
install. I'll keep investigating...

-- 
Kees Cook

