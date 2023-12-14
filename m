Return-Path: <linux-kselftest+bounces-1928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4738135F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AF9B21828
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC05F1D6;
	Thu, 14 Dec 2023 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkSvzWFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50711B
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d351cb8b82so10267985ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702570505; x=1703175305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=ZkSvzWFe4GfrTmBb8iUOsSMZShHZoC/6pFizlZJfB9ONOgN3UTUwkKgX7kuJyqDJbT
         kavajsdaTI6rnXuGy85d33h+u8VKloOrALanp91z+RAAw++psw1KGHgu8zFL0gR5oymo
         S2PjEMBmoHCB52+2P6XENFdmySM51D5bZWxYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570505; x=1703175305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Ou2BN/NSSGCNvRe4VvolyrUm7oUAf2oh76V3K9T9M=;
        b=MHTOfGjRBFOJ6uGCzJ4EQTwAI5M/H+ithEewYpeF+cDzJT/8CAhKKMDYC1KU5QfjIO
         21ku5pBOKASUsrxDVfZ1Z2Kd7itR0+BI+Q64CGqc86Emgez7UOznvYCeUaBQlmVGEjXy
         z3iAUGBkI9ZbqMUMksRupUwMEAkV8l+YEDDsfE9r6cWuBFY2B3cVdD6QcJZstjcxU2F9
         Dj1TTI+yL7Bq9ZrlvPFb5zJyXZOolMRoI7m1rLsxl7iW+1w1pMw9HvQhMEj28Q6CzpIo
         8YskQDgbXYmQ+9mSHWjxApby3XAe0JNhRGCi5tNx+6khVd1pckbLKepizFlC+ewQ8wz+
         7/og==
X-Gm-Message-State: AOJu0YyJ+91+UgKH/lMoFZn8HWkp1i45hjESaNCix2UdLiHu94PNmC4k
	xmBL+UnW3G0RlbKUcpah80vmxg==
X-Google-Smtp-Source: AGHT+IH+ytQj5wa72LYKC5YIjqTselzMKodTANBeg8JotZhzXxmhWvXBDTQzTxLBsP0QwKZwCFxenA==
X-Received: by 2002:a17:902:eb82:b0:1d3:4c35:17a0 with SMTP id q2-20020a170902eb8200b001d34c3517a0mr1926746plg.120.1702570504783;
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001d1cd7e4ad2sm12549781plf.125.2023.12.14.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Date: Thu, 14 Dec 2023 08:15:03 -0800
From: Kees Cook <keescook@chromium.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 3/5] overflow: Replace fake root_device with
 kunit_device
Message-ID: <202312140814.314B59CD@keescook>
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
 <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>

On Thu, Dec 14, 2023 at 04:49:17PM +0800, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

