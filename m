Return-Path: <linux-kselftest+bounces-26473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B9A32A18
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 16:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5073E166935
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF2211471;
	Wed, 12 Feb 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIkPJqgP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726F20D509
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374307; cv=none; b=NK3x7eCgtxvpfvBCZ3XJiS/76nomNAdv95ddJKWVjQUlmfRIljozRB8GLamUhUWou9DUv0U9wU1XbbjthEbRCzcSQ8LnpA89caMxTJnDd5hjZc9wrcmYIIDUlorPA3+szswXfftvf6zAR0SbgjxBmrMDNg/zHI9wMYApbTSPknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374307; c=relaxed/simple;
	bh=Kd+6DzKTiuHkjzGkdtLbyCkTyy0yaluQp17EPwunXIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc0YlaXCT4FPnLocz2VZXny0X2vZxK3gmlc0jAwiUOKhTcb/56aQW8jzEIPTSmAPC17yaMG0AqbXasPUYeEhoOo1f1QXMeS46C+3QE7Z47zXODDlVNHNN1VvcQwpFfR/DymgRx1J24XbsZaPfmCt51mxPiuZsCfiLKzG62zsOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIkPJqgP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1128683966b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739374302; x=1739979102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSq+cHNnWSDiFyg3hiZUKEZKM5fOb5ovEsLt9hQ8kFA=;
        b=hIkPJqgPGbTqULf5gs3Rgx2UTz5aOKzJbJ9ZXALg8IrKNljYc1CqD0j+Zo1gNlV+BF
         AekVcgRwwv4WAG5zUxATu3raVe/HGhEPHQCoOw9kv5lFMfByW+H00YBRs/YkIJQw727S
         b0jOUoNtFsPOemdcidWNlj7YFsS8ZBOYv2lfJe2E5AE65fLi2aFYwaeCyyZCkHvmd5NA
         +kZF1BPUZZ9g/dNd7g7k1SSUgBE2hGekdcF1kcqMSqBoN/GIqzVLi6xX6GSV7cPNNcaN
         +0SOsQLtEZPLAbna3hjAA0fe4y8ojBrF5ZEVY6u/MzykFAqKcQPfOzdSPcMeWRSEXyYN
         CXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374302; x=1739979102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSq+cHNnWSDiFyg3hiZUKEZKM5fOb5ovEsLt9hQ8kFA=;
        b=dM/+fUz9W9RwX9BfAx8hh9vQ3pi3cDA2ybhrARvxkA8wFh/hPg/eyqxqa139cFcfxk
         pva+GwNYkEUgl5RGQC+yBGmZc+mJN6V4vFC2GMNgXV4ykD+k9IibLVh8A+kJPewXEzb6
         jHXhCZTOFOaelSa8ue56c5duo8YHpoIEeUZnD125wf0jFQ1h+WQEjw1lnnY7Twkc0X6K
         Wxwlr7fh0BIf5jren9HVmZNjhHd5Y2h2m1pHT5SmuHtq3PrVwmDUfABKDi8KOpQOFUoN
         XQ/7TVOwn8r57sp/OF6c+5yCNlA5B7XaaCg3Serct16zjIES43yAUeJpxH8usC8Yg+Wb
         nwrA==
X-Forwarded-Encrypted: i=1; AJvYcCWrqA9r3DsaF0gKd/yGolZ/xAF2HnJLwEnSUg2TyohKAc9doi7L3yiwO3a8P7lWAYyLnqjeGlgjlSpx8JSkBI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWURA93vlGrAR3a4SGlOQL75KfTZjYCMlBGIEBVsL3SLga57F
	bZ0GZffYKmSVSgyfZ6JCXRTYFsmMGY9fRiOWTA7WXGjeRALF2zuhSPWpvwz5IHI=
X-Gm-Gg: ASbGncuvTG5VKxppB523Ta1yokHGbJpjkYqL5xnW3QJTQVythayLUzAFrbsjqv2rcYd
	BKT/f6xOBKaZfj4+Rd5ElQa3ZF3AVF9bfRexPSQMQ/FLCxv6VoRHjtFhqTsV17WldWdJrysyB7L
	WDMr4XYw3EscC3E3J9arK+dOrtN5ZL+/2Gl37PBQgq1yt6ce2DxDD1eQMwqtcL3hNp6wdT7BW7N
	39Kg+hUY1eoJAT9uPaodsWVUxu0aJ7Bu/5fMj0eLRkQ6q1KI0s+He48a/TAtISeLL4+8Y0CFhq6
	VJ1eGKq60ES810Y4iw1H
X-Google-Smtp-Source: AGHT+IEL4lA8s78vp0Gg7MOmptz86X5Vg+sujBASU2RfYgzLtUU6Y26AXdNXUW7VE46t0p06RX/ymQ==
X-Received: by 2002:a17:907:60d6:b0:ab7:c426:f33 with SMTP id a640c23a62f3a-ab7f34a8230mr346620066b.56.1739374302011;
        Wed, 12 Feb 2025 07:31:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b4aba036sm737804366b.45.2025.02.12.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:31:41 -0800 (PST)
Date: Wed, 12 Feb 2025 18:31:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: oe-kbuild@lists.linux.dev, David Gow <davidgow@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
Message-ID: <30998382-ee63-4a4e-8287-cd21c649b849@stanley.mountain>
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>
 <3dabe058-2308-4990-8e5d-0af1efd27431@stanley.mountain>
 <CAJ-ks9=mKzgLhJW0dV-L8eFtkW-xt8v3GM51V4QF5Ef_ENKLvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9=mKzgLhJW0dV-L8eFtkW-xt8v3GM51V4QF5Ef_ENKLvA@mail.gmail.com>

On Wed, Feb 12, 2025 at 09:33:46AM -0500, Tamir Duberstein wrote:
> >
> 
> As an aside, how can I compile with the warning settings used by
> kernel test robot?
> 

This is a Smatch warning.

https://github.com/error27/smatch
https://github.com/error27/smatch/blob/master/Documentation/smatch.rst

Run smatch/smatch_scripts/kchecker kernel/locking/ww_mutex_kunit.c

regards,
dan carpenter


