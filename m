Return-Path: <linux-kselftest+bounces-9152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB038B7D84
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 18:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4549287016
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21461172BC6;
	Tue, 30 Apr 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MwqJNSEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF83E478
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495815; cv=none; b=dhY/e+6fyM9JnormA0D5gavDMv0sdUXY35V4eDe2jhixgupIMtFfIbKHnpcAkxFAMVcS7dMKdBbaMK+gHgVB3I7V8vfwXvYOqO0qJ8IV8xh7NZxCdIshVPFU48aKjNdv4IdLQd7u83HGQvoVxm435iv7E5B3NDMk5ubPGgVlmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495815; c=relaxed/simple;
	bh=B9pKs/nyNrJf9S9E7C6a6HGmfe6zf+FJV6/BPMT48fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBrjcpPTr7Y1mTr3QunxwgW+l3BMsg/2Ots0uBtTdUwjuxKBol4rX9MpaaqwponGu/Hc7uY3a2c7j5rB3auwOuXL82n/4bXN5NXBTbBehjcNmh46pKQRNHpdbSGtOt04tdE7l20v7ExFhQNyD9duqVR73KcLF/Jai8Kye+0jt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MwqJNSEx; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ed075a629so2239627fac.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714495813; x=1715100613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tIrMLB4msMRuE/7a2kEwzm2wzpyZXm5c5jjcBesFl94=;
        b=MwqJNSExZ5uNVylV+qzYSX6bi3e+demjBLsVZr9DW0+gQ3n9V8vTRUEEGtf3+mCu8G
         qXOMJWO/kQeWc5voSmF84tG1Fb227xzVQLw9v1zguLRwdpKoPh0aMAaqN0p68R0Tyo9O
         E4FC3lnbj+TPArb2e4KTbVQ4uuLdS6FmfHzvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495813; x=1715100613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIrMLB4msMRuE/7a2kEwzm2wzpyZXm5c5jjcBesFl94=;
        b=EDjqOLrtIzkh+53iFaM5WwzZsHxhs93ruk+2lCA+vUGQO09s2YhJlevpCNKJ+Z1o+b
         /lbp5JgCgewzZt0U9cl+9veWSN1uq2iVqSnWgT9tIvT9fptLsxIzGuQNvlDo6Qg6m/vs
         NzTr2VCgLjR+q3nXH2g+SEmKXpmf7XjKhe/IxwREfxtC1bzMjWqclCN5sm5w0HVw1TM6
         wp54ekFkw4xHnQnbi/LuAIrtN8KaOql4Hu1l+NPlZzetAdFNhU4oRJml1dUCvaXzY7CD
         fFGY9d1slGMVYg3fJ8uNzt8BGGy6qNg+k7udCwr1j1/ksuMae+ygnUI5dFNiKUl2z0hi
         UbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXo51vWtAJRBQIixSVLdIMP6FOYteZPi2CWRR5sfK5m2oszR9BoJlLTt1AljOzrFJ1Mhhhg51jx1NZpIWhuAY1YL89Cu9DCDo0RO8ijzqBh
X-Gm-Message-State: AOJu0YzX+LMxpxv1uRSLlIAWe6FSohG/a8qjkWxQzLodBfp9mzb8/1wC
	y4FGxEopboxyd0kYA7NUlNZNo8tlWpk3kHZP041MByP1BO2hm8JIJk1w3XOMqQ==
X-Google-Smtp-Source: AGHT+IEY6xgEVGkDB6bSjnp7aQznpujQEsy2JLgZMLFYQpA3hLHbk4RWYYAtkQVDlOPq8nMQM55x/w==
X-Received: by 2002:a05:6870:8707:b0:229:6d0e:203b with SMTP id k7-20020a056870870700b002296d0e203bmr11449246oam.50.1714495812769;
        Tue, 30 Apr 2024 09:50:12 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ge3-20020a056a00838300b006ecfc3a5f2dsm21255300pfb.46.2024.04.30.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:50:12 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:50:11 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fix Kselftest's vfork() side effects
Message-ID: <202404300949.28CC6811C0@keescook>
References: <20240429191911.2552580-1-mic@digikod.net>
 <20240430.eudae0Mahbie@digikod.net>
 <20240430081304.0cc6bd8d@kernel.org>
 <20240430.joh2lae1Ooch@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430.joh2lae1Ooch@digikod.net>

On Tue, Apr 30, 2024 at 06:38:40PM +0200, Mickaël Salaün wrote:
> On Tue, Apr 30, 2024 at 08:13:04AM -0700, Jakub Kicinski wrote:
> > On Tue, 30 Apr 2024 15:54:38 +0200 Mickaël Salaün wrote:
> > > Jakub, can you please review it?
> > 
> > I looked thru it. I don't have the cycles to investigate and suggest 
> > a better approach but the sprinkling of mmaps(), if nothing else, feels
> > a bit band-aid-y 🤷️
> 
> The only mmap that could have side effects on existing tests in the
> _metadata one, but in fact it would reveal issues in tests, so at the
> end I think it's a good thing.
> 
> I'd like "self" to not be conditionally shared but that would require
> changes in several tests.  Let's keep that for another release. :)
> 
> I also noticed that mmap() is already used in test_harness_run() with
> results.

Yeah, I was initially worried about adding this complexity, but at the
end of the day it actually makes things more robust. I'm in favor of it.

-Kees

-- 
Kees Cook

