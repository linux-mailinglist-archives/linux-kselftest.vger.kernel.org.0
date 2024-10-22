Return-Path: <linux-kselftest+bounces-20394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DF9AB061
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221211F22D48
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214DC19F135;
	Tue, 22 Oct 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fuLQxicX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41019E82A
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605966; cv=none; b=LsLde8xVBSRquvQHYjfwnzOnj0EUryZ5Mif4rRNqFhR8lPxRzOalrFpgxmRB8BxcDHcdcuYUWwxPLBt9ZHTlIljd0zoQ1Ii9thhWZAxPtOYJmkOlbeVqpPBpqwuSZAlo582b4VqL74B8VPyJJxnVGQeS+KDlD8G0Ra8fMQqU0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605966; c=relaxed/simple;
	bh=VZ6abSXXdL7OBXrDYbe6irIZnn/ZfdHgaS/ckd1GhDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spa9DOeejWq3GkndVZuH5H/0fQsFHg9mMBojLVMF8EMI4hUffeL0e9z4tDmUVIIhyslnk/tV2tv5i+AmTvBhkuCwrMtre3hG6pouWFwc7caqId+XUsc9nkQ0Hy8sVqkDuih3W2FJXiy7o54LXtVH1buu4XRcn7BduHjvCpM+GC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fuLQxicX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbe8119e21so41172496d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729605961; x=1730210761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbSnBGbFWyqRgNTgRUyXWcx49M0WCk/TnLV94eW6zWQ=;
        b=fuLQxicXDo7bzO0HLBDeWQznXT5Cbd5H5w8gDmT2yq5/uLpMfkOo9b9kaFgGu4ebX9
         q8illgKpDerflJmtkeznH12cfF8CP0hbPBCQxzVzs7/jinwxVqBrdzeEffuns70dGmHb
         4YcdhNCxkcA8IvkOiPDDclwveSrvNoMvDDJ8j+9fqi+MCO2m+XTlxQ3XXedQh5AyiHfA
         QsB2e2n82mSok9IfXzT/OooaBvtNyeSEYO0QQP94ugOPCsKo0K5/6ujkSE5UWydDDou7
         BW++gZvMxi+X53E+owCdSytk/tEIRpOwNDxHEVTm6fp9cS7dhShhLEetINM2eXy+kqIJ
         89xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605961; x=1730210761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbSnBGbFWyqRgNTgRUyXWcx49M0WCk/TnLV94eW6zWQ=;
        b=xDGyN+2MxwfjbcwLRH7+2ZjvllI0be7QAn7h1RgTidfcjNEi0aWX2ka/eyWg9UHgDm
         S1LSr6q32DtChiLAXVneEO2t4IolVKZcrlYBRCXtt14nWde20hE1OMN+gU1mQZyog6El
         cvQn7Awxk+UT5SojyIKbjIUan4OGmi68g4mlSIk78vqv8DZt1DsfJfworSlZ3Fm5b5Zm
         vSTU3B8saNslb+xrRVQQ1n02SA5XgWlsdw9THP6j8boMgPP0D2pi+x0ndMLTJjbzW2WT
         IAwSVd39uiiLFxxAUEHos4s1QhCPcWB35xqqfUyyzU11S2A/T2dJd5/Jit7SSgJw/WZe
         C8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkLS0dHSfNEN8O1uEefVHr1cMkYxa6MPB2NV18mPm4eTl+xz+snjqtwY5iimzGPhF0PRj1dbmRcAq9FwX3tRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iErCV19YGjOIKhT9i0grGkah4nhelZbx0jp9L8/9tG1BWdFF
	4q8l1KqO8ts697hm255C/wdXEAZNSRHkkbnMZ2TiP8RXAhF/yOBSLmeIA3G1+2A=
X-Google-Smtp-Source: AGHT+IEgGsNh+W2oLEbTW0uW5breigomGJPTIkJX5Ksh6Do8w+7tAga3OXpEpeS3XkgQFgDKJsGl6A==
X-Received: by 2002:a05:6214:5785:b0:6cb:3a1f:e47b with SMTP id 6a1803df08f44-6cde163e394mr169245556d6.52.1729605961181;
        Tue, 22 Oct 2024 07:06:01 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008aca25sm29087326d6.6.2024.10.22.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:06:00 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:05:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: shuah@kernel.org, surenb@google.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Subject: Re: [PATCH] selftests/sched: add basic test for psi
Message-ID: <20241022140556.GB219474@cmpxchg.org>
References: <20241022122158.2136-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022122158.2136-1-quic_pintu@quicinc.com>

On Tue, Oct 22, 2024 at 05:51:58PM +0530, Pintu Kumar wrote:
> There is a psi module that exists under kernel/sched/psi.
> Add a basic test to test the psi.

I'm not sure this is a valuable use of test cycles. The mere existence
and basic format of the files is very unlikely to be buggy, and such a
bug wouldn't hide for very long either.

> @@ -18548,10 +18548,12 @@ F:	include/uapi/linux/pps.h
>  PRESSURE STALL INFORMATION (PSI)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Suren Baghdasaryan <surenb@google.com>
> +M:	Pintu Kumar <quic_pintu@quicinc.com>

$ git log --oneline --author='Pintu Kumar' kernel/sched/psi.c | wc -l
0

Really? ;)

>  R:	Peter Ziljstra <peterz@infradead.org>
>  S:	Maintained
>  F:	include/linux/psi*
>  F:	kernel/sched/psi.c
> +F:	tools/testing/selftests/sched/psi_test.c
>  
>  PRINTK
>  M:	Petr Mladek <pmladek@suse.com>

