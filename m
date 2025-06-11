Return-Path: <linux-kselftest+bounces-34635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F081AD48CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 04:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F7188D4EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69113CA97;
	Wed, 11 Jun 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/RHaF5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA0286A9
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608523; cv=none; b=HF5CEl+YYnl1L9/lA3HggB/dve0Ph5om4luI6M/EngQ5MSs1fVPLaiZWAlVovJ+peFKPhoNB+TAW+f/KT7OY8QWE9bUWS9sfL6VWHy85txzx7MtCgph6ek6APoqPx4BB0WUgqK5KFb0c3WRoqis2B9r+iNtce9V6WVhsfYTHGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608523; c=relaxed/simple;
	bh=4FI0WPeLMzYhIxn7w29T7EI/XV7vuO2CuYNk1M2qzKA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5k9V5v4ywumr4DdrnqFeetSeJZXLzIqawaxbkOKmXbh3e/s6V4TQNcxROkM2WxsVMpfw9D/CNmQXqtetnYME89fjPdlTfbemDwb+cnOps4KkrDtL9Zb/h4OvDGSZs0b1fV0IMTQP3hEXkfdvPvTgHiaSJNXXyuUqf17qH3C+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/RHaF5L; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so5932088a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 19:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749608521; x=1750213321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7BrEoEQf3hgh1nJqpaUjfZovSFl8xHmpAxM1uu6Il8=;
        b=g/RHaF5LutG9BSyfq8xpimiBrqF1zDCZv+7Cpzrnt+9UDKBVYs2EGdi+CZDK9jmh4D
         dyGbOoisjPYmRPJ8SJKCyguBRIQDONxxjWZstcgctrFnQTC0y/yTWVcrtUzVdWy+dLGY
         8TBT5KVpFq7G8H7auT0R/QvXvK2G2FlHSfWW93FIDDVn5uH6PbvvHvFArUQKfGCptMYW
         32iINudXE1XPJBzqawrN62crrTL0fhqa6UU3iCjFUVZmbXpTOG0lVoPoiN/qOHfzVbAC
         wqO9SRJJlQguI5SH73b7VLtN/dtyyXFUg7lHyBOyIOYMCgPzo8q1xccKrgQU030w30tF
         0kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749608521; x=1750213321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7BrEoEQf3hgh1nJqpaUjfZovSFl8xHmpAxM1uu6Il8=;
        b=bmy4qDUpIgG5xq1zfGMwR/TRFphahHwwlCRRJiH91yayZCmKLTX3qh4RYTtAnbsZro
         TzIQq3CGzzwvlZ3cGnGoUpyNACcXFoxB3AVvlXAVVd5abVu0XcpUOr4tPHcs0fYW4ne9
         xbwHFXMGeq9V+CIvCU9SO9Rv7IBTOGy7fdjFf+kfjsjJfRGR1s+r/Z0qUKyJYwME4HYc
         Ag8Etq2pAvwBv9jdus8+NO5hNTsOfKuhgSDMf/ya75h3JQYViOsYGgRxNfcl2q6O4EoQ
         IJNrxLWGbrog2pLKIBlS4YUiBlqH3EA7cest6ri/i17pRtTjvoD7mQG9bWksi3AcZUkH
         fIhg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Jh/xg34jWQMj6nUcBWWzpUkmrN+mDqAOCKQWJnGPUrcDJVRj5gO7Srz3rd2eYs06SW73K5jCRYFp7S4wbjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzys+ZgynS0YnCSoye3oWEl2slQNvJ74hrzsyuyMcXKLvzFwSv
	ZPz6tK8g6qreKXEY6LO8p4ZEisjnqvuVdCrczstvBowK+MyZDO5YgeXJqudw8BEhGAQ=
X-Gm-Gg: ASbGncsdEUhhkwdLczW4Tk9sz1tCzXYstfNxESYkDxZ5P+pqKywPCbng+/NkV2hGtpC
	bCQqJsyrffN4r4AA++csALnF8di4cvD6l9cvpy/2X1B/FE3KtkCCDVT7WS6JAw99Vq12YslSqY1
	uaMUmWPjHgyBY3WY8g8WnLw3YuRoI2jTzYbEwJB2GwUOk7suydJG+b8cOvvsWY6lpTiCL1qKsDh
	LTg43chgF1a4ogr/7A3YwFXUyHgHSadIgwd18BJts7BN6dTF2Enx7SJbtY5j6BZf96mraKTWqHi
	K8v1A1m81mKmLGpEYfyNDIyA3XNIjMxzLtC4JtrXP0qKUS6LS5amLPWIwiPwuXPxcD0fckLG2sk
	PQArF56XnompbHt7lsSMz
X-Google-Smtp-Source: AGHT+IE93VRBD2OZSemlT+UAfZh0S9KEvAyq7txy33O2e5dOlxX78FEYOqGX/QJrHzdbu/VUzyK2fw==
X-Received: by 2002:a17:902:da8e:b0:235:1b91:9079 with SMTP id d9443c01a7336-23641af08b2mr26938175ad.32.1749608521330;
        Tue, 10 Jun 2025 19:22:01 -0700 (PDT)
Received: from ankitchauhan-Legion-5-15ITH6 ([2405:201:4042:d128:18a4:18f6:7c5b:fc96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603b6a5aasm77402835ad.112.2025.06.10.19.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 19:22:00 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:51:56 +0530
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] [next] selftests/ptrace: Fix spelling mistake "multible"
 -> "multiple"
Message-ID: <20250611022156.ov4gifa52fagjd3g@ankitchauhan-Legion-5-15ITH6>
References: <20250501060329.126117-1-ankitchauhan2065@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501060329.126117-1-ankitchauhan2065@gmail.com>

On Thu, May 01, 2025 at 11:33:29AM +0530, Ankit Chauhan wrote:
> Fix the spelling error from "multible" to "multiple".
> 
> Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
> ---
>  tools/testing/selftests/ptrace/peeksiginfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
> index a6884f66dc01..2f345d11e4b8 100644
> --- a/tools/testing/selftests/ptrace/peeksiginfo.c
> +++ b/tools/testing/selftests/ptrace/peeksiginfo.c
> @@ -199,7 +199,7 @@ int main(int argc, char *argv[])
>  
>  	/*
>  	 * Dump signal from the process-wide queue.
> -	 * The number of signals is not multible to the buffer size
> +	 * The number of signals is not multiple to the buffer size
>  	 */
>  	if (check_direct_path(child, 1, 3))
>  		goto out;
> -- 
I am new to the Linux kernel development and still learning the
development process.
This is the patch I submitted sometime ago. Not sure what to do next.

Kind regards,
Ankit Chauhan

