Return-Path: <linux-kselftest+bounces-29942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC791A760E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122341885021
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC091C84CB;
	Mon, 31 Mar 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYW7ZXwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDC1876
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408380; cv=none; b=XKM3fAm1lfThWm6/mHPa7lI+DdRKPAjCa8XuBBrWEPvL+cNZJ+Gy27/8wBNB8WmKXoejE5SYyqq9FSbRx5kMjHMt+iBnasB+qrJblmIIWJ4GZqmmdWigAYxpWZUeY4BRnY7msg+CRj6p4/ZqQ0hMKFdW0H4jMoLHTtLUe88qK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408380; c=relaxed/simple;
	bh=ZfJC0SeKdJDQbt1YZCchBbUcg7nBqFPWQB9hQRz76Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHSuB+DaYqQAw532OCXLl5KJFE2qZuOMmA2NeFmmazJ8Ybx+o9RO7SXV0cv/z82DfMZ1C2ru/DYsAJNI446C+bV+TJcrOYVSUParjQamUX+bx5VgQ3/Mx8WI/2rN8WOXya/WX4JRzFJqLKTe+4RAqacbIkY+njZeoDZN8qHmAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYW7ZXwr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso18330175e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743408377; x=1744013177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dem/AHZR7qF3cH79b+8VdRbhMuCiw79+oYYuDn1nDoI=;
        b=nYW7ZXwrLX1j6ndkWjLKlFmTOP8IFtRO1aRj9OhlprisCFwJQtJ3RKPln49b6Mmp95
         Y8nVE9GXzmYUdcO77/7AF5MHvhE4CELpr9VsVXZbK60CKet1wQGbykgDrFtiBr4SD1n8
         que9RNF7Oz8U3oL3GrTN/j0U6yTYUgBxC9EYs9sAUeoTN+sDAtMCzmAqIvKbSvt3y3C2
         y+YsIHuNJ14uqwHNrPa13jBfA02VwS13F4dlCaUkaGzbUBkeGIJ1el/YzMAJqxftHNzd
         rDWmFcZYwkJsux5d+ROGmo6ACx2FeB6/+Ks4q5BrFeUuV1yfXsffACZGuXbp8wSbeFzw
         dM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408377; x=1744013177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dem/AHZR7qF3cH79b+8VdRbhMuCiw79+oYYuDn1nDoI=;
        b=hrJGxHm19KARDar8SFs9zwtvG+2UDUIto5Rt7HJb0JNS2bL1sfE6CyNCcq2e9MXHvj
         V23hcB+PkAZzL9nEMFSIOqupkEZM33sIkwalfjazG6B94ELclC7w9fQUw+fI8p1ex40o
         nwqI/B5T921u3C1UaWYp5d3sSd0+GcVLaoPG5zojQGR5kfh3L4ytj/nnkmPgVLdrHmZv
         sGi6h3E77c44qUSI1RTJSZkK4SGuazDr5lQ7khLWE1wV2VsK6S8qSe9RaJoHO7x7Q6vW
         lr8iR+bZ0M6Q2tbFbrWeCliALAi7mGog0CQkqHsQrKHxleRstiMbp+2SiwjhsEdpiSwN
         bERg==
X-Forwarded-Encrypted: i=1; AJvYcCVPhGQFH0FeQ053sPbZH7xyRlLAtfPG96vbTxtoKXc4p8woG+8KTMHDY8yKtusY0IaU/VLwKFzz4olvKTLSULo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRz0fUL2qz2va8hCeI+ovD0Pa2lD+js9xXJZcIxbAQyJmGmwd4
	JfhNQl7m2azoAPGTPj6WgKOQ9vhQRr4dviaCcNPCa8+IM/Zb5wWJkUZEfOQTbEM=
X-Gm-Gg: ASbGnctwiZnwtetYXhd+Zreq4SMXUHMnbrmVh5GyTaMbD2pRlPtantRZjMa9RQaHBax
	qvlXrgEg2Wbip8eQrbq93Yz7m+J5cQ6Mwts2/3L1MxJ3diSsD0AApTQhAuwsbchRsRQyp3Cr0f0
	CIEzmVFO7gUFb+1l1HcK0DkUZS8+5koFiqwucYddZelOb/5S4BngQYcK9yr32ZiKQv+FXDlckZ8
	tX1BxfYKRx5hL4Kc/rM84iyk1tVib0CBh8fzNnl0mKTEY0N2aJPeVxMm4+Hp8DZl6Jim3CrMb9h
	s3QuFkzgn1MM6F+IHjvLzerO+Lojh+UWlzq3Dv1eCItGGdS+ig==
X-Google-Smtp-Source: AGHT+IH4vJ/KqgunlkK1ej1cXacAghtjETA+BJXj8kGxSrm8d1nKUfuPzSv/zW4Kld1su7UgbTv4Jw==
X-Received: by 2002:a05:600c:4f0d:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-43db62b5b62mr61296165e9.27.1743408376550;
        Mon, 31 Mar 2025 01:06:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d8fba3ef1sm117879915e9.2.2025.03.31.01.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:06:16 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:06:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Gow <davidgow@google.com>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] kunit: fixes backtrace suppression test module
 description
Message-ID: <8e4dcf64-898c-4334-8124-598964089f4a@stanley.mountain>
References: <20250329150529.331215-1-acarmina@redhat.com>
 <CABVgOS=s-NgS1tPOOPDstuVfTmsW9H0kP8nEQmtfFiubQeyvWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=s-NgS1tPOOPDstuVfTmsW9H0kP8nEQmtfFiubQeyvWw@mail.gmail.com>

On Sun, Mar 30, 2025 at 01:11:59PM +0800, David Gow wrote:
> On Sat, 29 Mar 2025 at 23:06, Alessandro Carminati <acarmina@redhat.com> wrote:
> >
> > Adds module description to the backtrace suppression test
> >
> > Fixes:  ("19f3496") kunit: add test cases for backtrace warning suppression
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > ---
> 
> The "Fixes" tag here should be immediately before the Signed-off-by
> line, without a newline. Also, ideally the format should be something
> like:
> Fixes: d03d078df162 ("kunit: add test cases for backtrace warning suppression")
> 

Yeah.  Everyone should configure the default hash length to 12.

git config set --global core.abbrev 12

I generate my fixes tags like so:

#!/bin/bash

git log -1 --format='Fixes: %h ("%s")' $*

regards,
dan carpenter


