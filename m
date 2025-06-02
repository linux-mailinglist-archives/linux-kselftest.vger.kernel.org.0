Return-Path: <linux-kselftest+bounces-34122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74FACA9E6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39112189037B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC41AA1E4;
	Mon,  2 Jun 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiVj1q2F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D61A3BD8
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849065; cv=none; b=DHT5F2XXXdCJBTfs8ahAsOxXfJ46B6UOw1sicpnR6P/jJ38p4XdgWvYi7+rnQvlLH3g4jYtEZuaOTC3L5lXtw0CtNapCQnArwxSoVyb3fkhq+AeERPHhLV8en9WhXTyTmnfT1faucd3hNcyiWGHSkD7oRG/PvK/aZCKcnXFKXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849065; c=relaxed/simple;
	bh=Q21PoUgOrkYVhLx1T3USs15A8eDhsrRdYr+FrSfT+1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfCINuPqU3JGry6eMPBBpvPfQprvus5pdhHTkp+JNrPetkS2yX443jcxBDEcltKLH7p+v66cxCPAT+jQTh7xINxkdZ02qaWCzSM/n9HZqnAk48+cytBzlqQfaEEV21t06zk68633KPMz3HhCItjhVrTNOjPJkKoLDmCceiOYYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yiVj1q2F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so34769275e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 00:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748849062; x=1749453862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx0RaYDb88MYeeNdBYIWya8sxL0SHlDdzkxwTt2TDWc=;
        b=yiVj1q2FM9Z8AaN/mMdWYDuxgzf2QZ3dBN7R+zzUPbG2YPdGDgyowIa2qxNJY54CC1
         gBBY4uk2uueK01HesT/E2uWjQPX1mH/hryqusENNSomrHrZeUEXNEUggR2GyQkHQnEta
         JmC7PRsIPh3Za6E56KSVhPJdlJceAJ8YGKixtsGOa1+D94NvjtyUbCaDd5cUxCzd+XIN
         mmXD8BAgPmvJ2ReSYFb3IZAvyYHhT0n6VZZBVECg86LVFdrbB0QdQG0MXnGull7eaHbP
         +/1oAKdlOv3iKAIpSIsCAyTviyB/MaVli3GIr8rAUip7VW7ud75g6x8znXgDcR4TuFex
         OtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748849062; x=1749453862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx0RaYDb88MYeeNdBYIWya8sxL0SHlDdzkxwTt2TDWc=;
        b=mwsUhnKfGrVj4riuJmo1Tvlv5GfIOgtycqgpWs/uA4LD850GgMFNYP+eJuJrA2KEuh
         GPSeX1q49CsvQnE1G3BDzSLonQloH4vFDwxynT1FRhPvBBD2MwCW3q54E0ZnfQrO94Nc
         mAOsrURl69LBmKD5k5cnt0YEykPcy3ovTpOa843wq8V1YRUlfi7c5NS3x86BfIzKPTW0
         EkMEt5IXErJA1wfeQW7IJGOBEBZb3LAjmkjS207DltuRubKz9k+0gXIOU6frkSbFLxhh
         OYp9BR7aQ9S4aBvad8nx9zKJzsff4kd/kqCGSlOWHOlJ3QHZQUEur2BAcGUPLSmApfPc
         iKeg==
X-Gm-Message-State: AOJu0YyB1R3wXuUyyTzIF4AIHWV7vavWyAvjLRMYx/tbzKEeArx5hxRj
	a+ykJeFPQc/FaTHmILJXQEfJh+sOF5Y8lvLomn8Vn4SAkzk7hOdNrbYWYlDCRxeKs//EPYC5RFH
	gg7aM
X-Gm-Gg: ASbGncsju+/+ScS60MT2ZQ05mvpDQB2OY9pR0EsaYToGf3AgW8Lf+KtYPNBS8iERkUq
	60GDKo+wQJyCW6A5cbKgHTjnrQoGVw35QcvotC/96AbrquMKDm25gbIvTLLBPUX3PP4E5NsYWMS
	Zj0GACgrIyKILVuA0L1wmrv9rQQh0fhIv3GohCOITowHEI+votyiBAS5X+fHnG/J0A7sC/EP0LA
	s+tEkumzgGCEGy7R9J6kH1obFaRF8/qEzjbQ0rWGveDler/TowBmOINYfhMGR2Ifs6Ryvqq2FYm
	eT1nPJ9CEQ2hNJWCYMIMYqtE/cieIn3BCxnU6Xpei0H/i/UwDZ6wfBs=
X-Google-Smtp-Source: AGHT+IEVNyhdFOejr0L1LpDA1g7jRxs4kNrwm5NxBxAJbrQF2oeNR/IcwKlZ4fxQVZ9FMa1DqjLp8g==
X-Received: by 2002:a05:6000:144e:b0:3a4:d6ed:8e2e with SMTP id ffacd0b85a97d-3a4fe395675mr5771680f8f.41.1748849062063;
        Mon, 02 Jun 2025 00:24:22 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d8006952sm109189995e9.32.2025.06.02.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 00:24:21 -0700 (PDT)
Date: Mon, 2 Jun 2025 10:24:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] kunit: Add support for suppressing warning
 backtraces
Message-ID: <aD1Roe-z6o1Y5K2V@stanley.mountain>
References: <20250526132755.166150-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132755.166150-1-acarmina@redhat.com>

I like suppressing warning messages but there are still many cases, such
as mm/kasan/kasan_test_c.c where printing the warning message is the
whole point.

We should create a standard way that test bots can filter out deliberate
errors from unintentional errors.  This would also help humans who have
to look at test results.

#define intentional_warning_marker(type) do {				\
	pr_err("Triggering intentional %s warning!", type);		\
} while (0)

intentional_warning_marker("KASAN");

regards,
dan carpenter


