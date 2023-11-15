Return-Path: <linux-kselftest+bounces-186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF87ED77B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 23:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEED6B20A59
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714443AA1;
	Wed, 15 Nov 2023 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlkCkQTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F00A197
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 14:44:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7788f727dd7so7108785a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 14:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700088250; x=1700693050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnPNvgYVe/a3KXEsnvx4GNWysFw45MMaqeVr2951f4Q=;
        b=XlkCkQTRQrayA+u8rRgICNJcT9kOdTf1G87HZs9BvjdaHpNVJ84Q5IPEee9tEq6V2Q
         QlboSang2I73/U1smTY2yLLJR3116OdJpm3yKCacKkBLjWk74mQOQs1PshL0Ys/QDE0q
         YHPaRTkazBrwX2PV1YeTDOGHu3PVqGdayIMZYnxTM1VFrkO4hzjBM0u/DX8vOqvRgY3E
         GT/6dwkGGANrKUV5DdMKGe6gw4nRpWauSEjCgBkXQ4znBwbzRggxzVktvYqKOzvRa2bG
         MaseNbnig/MmS5uMXYTwkkOpi64FhbzvPKh1hEYfhyd55Me0cENWZ83Yz71Y8K/pli2w
         D3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088250; x=1700693050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnPNvgYVe/a3KXEsnvx4GNWysFw45MMaqeVr2951f4Q=;
        b=oKBiijBwmcgYb4Q4kawXPZ3jscCk8yYC7aTGG4Ma0nyFUHpHeFPbXOGgrN4kMBvp+I
         pfBh39/w9bZH5XUhH7RorLfR9hR1C91ftkLU2p2jjolnreUweCt2HRnQK0N3nTK/ES0J
         k0cSSsKNuD5YwpEndCm14rPPlUTgMv0tluWvXCD9rlog4CcIjjZXr5E1Bp6j9ID1ydLE
         Np4vezaH2q/mzznEGY0jmXQAwbTRnQEDoOJKmRkxEzSOFxb7RtPpEiaIpKT/81yHdHGs
         x0yVkp3UbboSICfWLy280e53BzPxbdaLXUeLQip9bBtGP/YznohkUHFJwOK9d5gWzBS2
         pkcA==
X-Gm-Message-State: AOJu0Yw6EmD7FabQ9xMfmXQdd2Z/jrESLQrdlq/npKMp1/PgN6bOpzMJ
	wP1qR8H5ZkTdc5KmeenUvaA01g==
X-Google-Smtp-Source: AGHT+IEXDa9AqDk6k23ASNVZlgKVGyl4b96qGCZ+OOAUM0YbtOUy7P5HZ7bH5z4OmceD3xsVsN2MMQ==
X-Received: by 2002:a05:620a:480e:b0:77b:c47e:727f with SMTP id eb14-20020a05620a480e00b0077bc47e727fmr7898555qkb.28.1700088250234;
        Wed, 15 Nov 2023 14:44:10 -0800 (PST)
Received: from localhost (ip-185-104-139-34.ptr.icomera.net. [185.104.139.34])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a16b300b00772662b7804sm3815744qkj.100.2023.11.15.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:42:58 -0800 (PST)
Date: Wed, 15 Nov 2023 17:42:17 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: mripard@kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	kernel-janitors@vger.kernel.org,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	kv-team <kv-team@linaro.org>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <8489c4db-6639-43f5-b6c4-8598652cdce6@suswa.mountain>
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
 <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
 <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
 <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
X-Spam-Level: *

On Mon, Nov 06, 2023 at 02:58:12PM +0100, mripard@kernel.org wrote:
> > But a similar thing is happening here where we have so many bogus
> > warnings that we missed a real bug.
> 
> IIRC, there was a similar discussion for lockdep issues. IMO, any
> (unintended) warning should trigger a test failure.
> 
> I guess that would require adding some intrumentation to __WARN somehow,
> and also allowing tests to check whether a warning had been generated
> during their execution for tests that want to trigger one.

I think this is a good idea.  I was looking at how lockdep prints
warnings (see print_circular_bug_header()).  It doesn't use WARN() it
prints a bunch of pr_warn() statements and then a stack trace.  We would
have to have a increment the counter manually in that situation.

I'm writing a script to parse a dmesg and collect Oopses.  So now I know
to look for WARN(), lockdep, and KASAN.  What other bugs formats do we
have?  Probably someone like the syzbot devs have already has written a
script like this?

regards,
dan carpenter

