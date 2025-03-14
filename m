Return-Path: <linux-kselftest+bounces-29042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA57A611D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1121B620E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680B1FF1CA;
	Fri, 14 Mar 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gvg7MuZ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FC1FECCD
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956927; cv=none; b=mvlhUT6778mz0bQNjpIIJ6VzpxJsFPaOQ796pjRX/7gRkUdA/Us0NzUdVjnAn7Bvh0kW5M7FTLTGJD8yJYRXg/8aL2gLw+NcWxAAma3wNpUIYR5L7oMBfN2gu9MYvhlSMby2tqXTn7+RJxFKc2I6rLk8lyMqcohaRYGoTdbV+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956927; c=relaxed/simple;
	bh=9jK0f3uZnQq3BPWPfouIRDNoRNT6gfQkiuDANJz56G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpE/KohWeXE3lrLqya2vlMxMTD2Zf5knSP+St36JrHpeK5bdpLF2RVqElZjnyByN/2ODanPLN4BdMVdrQDsYD05M4SQPBxrp7E/weQAXcrY1x/XvDRNYl/l2gX4STbzEvtrmZxqB6ta8Yxe0AzH77U+7nHrApl59sWeMW8i6AfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gvg7MuZ5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso13934725e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741956923; x=1742561723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jW0gDL8Kna/PJVCnp4wFYE71t7XWzYqNhyjthOw/IdY=;
        b=Gvg7MuZ5mox6DGPByIB6bz8VbOA57qlGzMGE+Y+woagnaNbdOdGpstrzWKONKqnhIy
         BakllLtNMlA3dDporsaoLw+Dt1ccrmgqRWYbJkVU5jDzsdRjiE9HkaMXa2hSAAMHw1Om
         emBSVGIMgraMD4Q1V2heUPlb5vsjkOyk9BbU8oOoLbBSIEomaBe58ea/lVUm7ulF/4gR
         eseugb4z6sZWp+TI0/XjmfpY40VJsfBc966VIMgv8chhI4+vr/DS8Y03EKvAqV2XGrSR
         ZDF62VtcAWgwiHo7APlwEN6DqD0grBjnYNwgA+GtAAYpRpmoXIbi8QD/spMZvDlQiUxB
         qMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956923; x=1742561723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW0gDL8Kna/PJVCnp4wFYE71t7XWzYqNhyjthOw/IdY=;
        b=ifN+dGLLFi5SSKhGuU6heOKVpSwUVgO1utrOpzCWlM116B6N2p9SA6RqcxwuOqsJQN
         WvZnurmjpNdP2wFrlJ5oVMx9FPDpvw2EZIvgqVRzl4lk/rYa45YD8V6F2FvI/RNXdpth
         WaTsGVz2SqK9lh/cwRI0v1FCjRMJCRG3+B6QzM0FzqYSox0B0UCmnEbOP+dwFWAFgs/S
         VV0H5OFfpeb+nCsTqgjahUz7LpdgE0h5wOzSSB8Qqy66zTDgHxF88hARH76N6+JlpMVH
         orhFu4e0IlKlbLCJ1xn3tEua7fqUvXd+fh9HM+triLNkR4PIA4SchkcHtIRRx48nRHmo
         1xPA==
X-Forwarded-Encrypted: i=1; AJvYcCV1MHWk01JW7leXGoXtJzfYC63Exw6knA5k1yeVSlplR/7cnr40ilg1H/m5biwgj7GCH2a4brnM5whAyZ3+hwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEX+IztZuBUVVTC/kjFQ3unzVCvohjO4V241vT62Y4Hgi4OnX0
	y/y41hLnuPuEvKgILNLflIke0xGx0m1CZsr5nH/PAD4HsTYEgQpZ3SzVlU/5orU=
X-Gm-Gg: ASbGncvH6v/jSYUkb+kpiHbkxFKXKwv4rmdrPrxwOYYgicF6Ry5IR5jJu3nkD3K9XR0
	H5Tj+uPXnMt6JEwMQuNPp9gqu0jgm4h734In5jarkW2ZerVt9k1NrV/QvstZPuG2/JmT2TLc7Nd
	cklnS8xdvtKYyyJpcqAlc7587ZECioB7N4H0/ILkxABHDy/O2Q4QSmhAUQaVzCyOjaz8sfDIeTg
	LP3kdr6pLdCQ/YIg6XXJMHsbM5TcJUGuC+OGyB9re1AvGOA0Vqa1PZzhRR60dp40uz48VEMRGIp
	oK40oPnJsuI5EQtS23Gsg8xiKXafiROe1L13vnHKAzLemZ8=
X-Google-Smtp-Source: AGHT+IGP/UzftlRh1pjMmvEXqf+wXC6TdWjAmGoFJkKf2HYEtOlmmlvDDOzWeFGP8hSZWK0Rt4MT2A==
X-Received: by 2002:a05:600c:3591:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43d1f1d26cdmr29402245e9.2.1741956922903;
        Fri, 14 Mar 2025 05:55:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe152ffsm16623115e9.13.2025.03.14.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:55:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:55:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 4/6] scanf: break kunit into test cases
Message-ID: <Z9QnOGdEaOP28YFv@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-4-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-4-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:37, Tamir Duberstein wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

