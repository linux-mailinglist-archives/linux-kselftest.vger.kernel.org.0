Return-Path: <linux-kselftest+bounces-22094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD89CDF97
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEA0B22B2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB21BC9FF;
	Fri, 15 Nov 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeR7N49F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D2CA5B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676060; cv=none; b=GgngsSlv6ADPQfHYzhkzDyuG/ghddg/8TAzRq0+qAg/i02exdb/b7C+Xw2HNK9DIKEP79ryQ0qIs0kJMQUJXhMc9zyS+tAY6Mg25hujN8A9vDUj3Gjx7aqoUyrzuiFjKmj5gtLDVB9QMifTIW666hi5oImRZ+xhgvuuRcsYYHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676060; c=relaxed/simple;
	bh=dEY4bMcfjN2jDnrT5hwQmo7mPSnSCSRep4/jww4nqDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGhThStthGS0E0iT36Q19QaDGHPkZY8GdyAGaWPEhqKv/9oE91yEDCoDfD4YBxwDSBkiKXnL+NfQ3bU/8smHDDaq8ld1L3vS063GEcuF9DBKLnKi3flOBmj8HNqcDvXXQfmnEiW2VgPLcfnFwXTw+97dAeVyELm34uSgN+SgbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OeR7N49F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eac969aso10378895e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731676058; x=1732280858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiAfY0lvd8epGAfG9vNvMumF0065glHRGxW52XCXbkY=;
        b=OeR7N49FEZcEypjrT2B5wTO9I0SN3XO19ljXjY1GToDAbiwQtlcD3w86yI+MpGbKex
         G5D7T8Y9KKY9bXAEDXwYdQCCN9Oq9mchRtSPp5bdUkaNKpADhVkRIX7+nSXQJYicmUCq
         YZSUK0CB+cQRz0V1k/mdDKqHgrkpEU5Ospsp70McnQruzWO12wovDQ5hH5ofJ8lVGlwY
         HGNH9IiDTspUNqHrYVjogxryBXOGHgLVCsUEpsQuHeidNTd9kgapVSj4dH+YSfwjwsJr
         bcl/pfyC7Ox3HJUHiJm9fpmDWc+DfrCQkluNlmUMSC6FqRLEZkYHPV4A7oEnSkVI5tNH
         M/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731676058; x=1732280858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiAfY0lvd8epGAfG9vNvMumF0065glHRGxW52XCXbkY=;
        b=VAZztZ3ITJ2pqz5xk9vZ4hQtU0RcA1GNEQZhT3ujZ4f8UuDnGBAjIfPab+cR4Bq1cr
         DYC7O2uyGPmNOkaBV5fuMMyRdPlWXshdI9wzCBM9xwDqEL1w2tJ+c6t3yE4l+FQQEFvm
         WgoBO/V/rlTjyi7jbcJpav7Db7OqrLjGvuJSVn7sJWirLkW8wNrhfm339kGy6gWIgLLs
         rh7NKjk7ffBQMUS3yGX4jaht0v0PUdIu/Rk5NNANdNSSB+SdXpILka/67wmo68IEuXL4
         EhTcUbh2NeyUv5o4ny9BqR/tR8B3qfdTdu5SKBuy3DhOlu23cRJpWLNY/b4WUVy+5Sqd
         WP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXs3SFFnA/x3LyPCl5bY4sTuF1Y0pQRuNKV5WThW81T8WI+/BYOd8aDB3cnteE0Zn7Lgm9ZVshwgzAqQjJYSzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/Brzy/xcaox35kBFUwAYx1V75TdJvbx5Tcq9cqahtsRyJLwM
	ro0cZW2TDlmRnnIW4hDEzXnCBld/8Wb4euqgGSymTuuWP7nS/5MuoyRX/nVGotQ=
X-Google-Smtp-Source: AGHT+IFLypSUXKMXZQokl7jiW1yVHZc6DmXrur69Qui95mFW1vmj5vxRjJRCT3fWilyBKdsvE8W84w==
X-Received: by 2002:a05:600c:1c95:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-432d9726874mr70098235e9.3.1731676057729;
        Fri, 15 Nov 2024 05:07:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7878esm54044435e9.14.2024.11.15.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:07:37 -0800 (PST)
Date: Fri, 15 Nov 2024 16:07:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Kernel Selftests <linux-kselftest@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Ido Schimmel <idosch@nvidia.com>, stable@vger.kernel.org
Subject: Re: LKFT CI: improving Networking selftests results when validating
 stable kernels
Message-ID: <226bc28f-d720-4bf9-90c9-ebdd4e711079@stanley.mountain>
References: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
 <1bda012e-817a-45be-82e2-03ac78c58034@stanley.mountain>
 <c4ed1f88-e43b-4b12-bffc-faf27879042c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ed1f88-e43b-4b12-bffc-faf27879042c@kernel.org>

On Fri, Nov 15, 2024 at 01:43:14PM +0100, Matthieu Baerts wrote:
> Regarding the other questions from my previous email -- skipped tests
> (e.g. I think Netfilter tests are no longer validated), KVM,
> notifications -- do you know who at Linaro could eventually look at them?
> 

The skip tests were because they lead to hangs.  We're going to look at those
again to see if they're still an issue.  And we're also going to try enable the
other tests you mentioned.

regards,
dan carpenter


