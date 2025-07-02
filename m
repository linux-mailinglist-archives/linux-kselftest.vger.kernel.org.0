Return-Path: <linux-kselftest+bounces-36228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE44AF0728
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BD41C0698C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154410F2;
	Wed,  2 Jul 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CVNb94Iv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6B184
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414766; cv=none; b=tMEfFQK+HVDZfIdrPFxXGWC22C6njhEMhBRGUxDBxl1t/vjqazp1LUxUScvWnRhj14dy7YWmtGXp46kxO4d7lZtr/TDyegM5jJihSP1ICAKkFzkSyjLdE6xlPOlivi8C+QWtPFKM+gp59hxbzW1Aw3EsJ7FYGn5NmEPuEfjldn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414766; c=relaxed/simple;
	bh=bIMTi4MWsgaUbmZu8ndOxvFLqagge7bVFXfE8u72634=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLQTqnwVDan1zgKaRnvxXOnOIMsow+chh2q9piFx3EtlmVYvjIxwp6OYQAXeeQvMT+wqvbLj9TQbOTiregFq51jkeMGBsA8M9dEFi3BBOWbD19TvXMP+VAj21jlxpQ1W9l8Hx3cXFp8DuXmeZ0x/k8A0GalgY7WMnx9s0gs8nuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CVNb94Iv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so5556609f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751414760; x=1752019560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce3zDRJVoRRIoVuOih+y1uZIYHn+OOhDiG27OLlb9rE=;
        b=CVNb94IvQLjV3Kc0WC6Ibs+Hn96TZhMGBiKW0BKCKqBQ/sFqmF8HLm7AQUDUtwqAF5
         P4svXkkMAxLVTWrrF7uLZUjdace7iRHzoET/dR+5G9BMn64vwp8OcDUU2h81O41g8kV+
         RDHL7G9RcMRjTwfBpDBDQi2QDm0w/RyiptwPLehfdv7Y0yXGeRNwCMwvx4cnngNMO4lc
         mVg8pEanOfRbrUKOmPkQFIIBAk6mqV7Q1BUjBaNQMGET9F/atmK+hTYylh5hOTa7VBbz
         MAFBmwvN5C46Shv1i+iv7K07DHXgxLZWHFPygr6k1W6aVQcR0neULyutljOw5NvQ3kgL
         JboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751414760; x=1752019560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce3zDRJVoRRIoVuOih+y1uZIYHn+OOhDiG27OLlb9rE=;
        b=DsP9aL1Gv+AxswR+/6/5Q2dxZlcI6X6tEyJMnAb943Y5sMVl/hUkGTC9Nsmz7s/DOf
         F+WW0upMSFXoE1a/TQis1AlqQ8U7B646Caz/DHFify07mBIbzdiGb/QH6Kzh6oZNIMoA
         qwnSppzkIPfDj9LA9DF63whag2vgXVR5Esn1U8QVjzXoNZ3Iimn45jFFcK18kgnuhxCU
         tp1J8fx+OCPsbdPrvjGRlhe+I7SrPLwVEa3ytAz0NDi/R3+PnZ00TgZ/VrUJbO+NOAzc
         u0t67V2V9Zz8YXVP8yJGGcYZBwo+omvYMgKk+r4REnqjDdf1mRjOqk7+qxXxbCo7Bwl4
         HHWg==
X-Forwarded-Encrypted: i=1; AJvYcCW+9eqWwjeL77UjXL500jH23a8uhQGbwQyDfMaELaxSI42mwLWS7Ss7x28pDwla8pQCoBw9BSbjtpu/Bjg49GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybjcjVKlFP7BFuOjpmE5dezZBCdbh8U1/MJcCaSjNW15pZ90Gb
	lVugcUH0hONaPEQgQ4vLdk0BxD8W+g/u95kIp8QNSYLnX5mDBRIT5+IajehKBZvqUA==
X-Gm-Gg: ASbGncucepCrl29OVfNPKIcc3Oz0RtLT6GUbFX/ts02AuPTnOwzfUyuVlx0AEgWLqVd
	m5tlCKKfR+aF6BzTWN8bXo/GZbWNhdkppldBQd7BFjnlxrD3dI57Lk8pogE4/UiZ23cSPUdevAx
	fb6by0mfZ/LEZxbfwtjj2fmGjGu7cO8co3ulMQMHzN9F9fIVmzBhC7eamIsBepxjNCVvBHDav1m
	eIjEQW/8gJh3JNGA+7WMSYhaKNJMkTfDqaoddxDUpMr3MLA+YqrxCnRd/ulYHdZtuTq0o2qAfg/
	9pB09XeCHNdnBnW/KuWI6ydKwoBOF52oNBbb/G15W7zfbfpYW9KXJNLJnEjjQA==
X-Google-Smtp-Source: AGHT+IHgFK+x5iOOCR7s+Jwca4C328dxRJPFWJLVCE70nVrrFL6mJkkvUSJeMxzZnHxSrAYyY3US1Q==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:d83a:eb4c with SMTP id ffacd0b85a97d-3b2013f8c90mr292003f8f.57.1751414760277;
        Tue, 01 Jul 2025 17:06:00 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14fd6b5sm12475850a91.35.2025.07.01.17.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 17:05:59 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:05:23 -0400
From: Wei Gao <wegao@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	ttritton@google.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
Message-ID: <aGUggwe_gJon_2E3@MiWiFi-CR6608-srv>
References: <20250701142313.9880-1-terry.tritton@linaro.org>
 <87ikkblkff.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikkblkff.ffs@tglx>

On Tue, Jul 01, 2025 at 10:34:28PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 01 2025 at 15:23, Terry Tritton wrote:
> > Futex_waitv can not accept old_timespec32 struct, so userspace should
> > convert it from 32bit to 64bit before syscall in 32bit compatible mode.
> >
> > This fix is based off [1]
> >
> > Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
> >
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> 
> This is still wrong.
> 
> If it is based on someone else work, then you need to attribute it
> Originally-by and omit the Signed-off-by of the original author.
> 
> If you just picked it up and adopted it to a later kernel version then
> you need to add 'From: Original Author' and preserve his Signed-off-by.

@Terry @Thomas, Thank you both for the mention in the commit. I appreciate being included.
I guess above options both good.

> 
> If you collaborated with him, then you want to use Co-developed-by.
> 
> All of this is documented in Documentation/process/
> 

