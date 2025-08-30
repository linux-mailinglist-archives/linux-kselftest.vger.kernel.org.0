Return-Path: <linux-kselftest+bounces-40367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56851B3CFE1
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C235E31AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8431EDA0E;
	Sat, 30 Aug 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PewjnPN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005A7262B;
	Sat, 30 Aug 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756593030; cv=none; b=rq9B/vasUbqfd9nOmv9n8KW93mhbxVdVybs5+2RIk6IRLJ0BrFvvEx0S+SKQ/wjG+kcOjAgQXA44GSNqZ2MVMhH2t1jZBrVSj0eWTmB7e07bnUJaS+G40TarsUCUeFxN1Y1elw/teFjgMZEN6PstggVAuFl0OBnEq7/s5u+n/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756593030; c=relaxed/simple;
	bh=3yckfn5M4o5Q9YV735257akvinMkCAz5WrRXOWh65O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC5zKEIHnTRfcau7MWTEDySJiVDoIKDwQI9RCqa2NjjbWquJmFDIqUrcrN7A6bUpwjNm2uuxA3lrO9SF1NYYQrsC/wUoXYlLuv21Nd0Uiqm3/IRB6slKDL+ape2iLbVcXHaNwCx/bflMXD+HdHwQzqzKL3u6VA145co79L4MfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PewjnPN+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61d28950476so1447022a12.0;
        Sat, 30 Aug 2025 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756593027; x=1757197827; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8MnctxU6ATOf/IhsFdPXoMq8IG2wmGfWPzQafTwHWU=;
        b=PewjnPN+snk+7MMVQQ5qHksKSxaykn11QkgSEO29ApjKjRLCu39iW7oSMfO80fc0vS
         GqGMZXPCMtGXWJt2Lxgx9YDHoGHGnjrSYDF2xQvfMI+DIzkfENJx+f9EPODAQ8licoWO
         4P7RLrXbCv/UC4rJEU0j6IyfdVXSL8spyVzjGE67+zfsVPC9Zsar7RT5jSiLaxGu5EHC
         DubxOqe06RYi9n+/Gtcthf2mGf44qTmq0fMR7e1HACsNjtO3k09VYNwN18eP5KgrsOdM
         kehEGwKTAdfKk1nlZOAhVeFrpcIpA6p9VHkB9Bn5M9dzcnCThkts7dgYw7URWofY0781
         xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756593027; x=1757197827;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8MnctxU6ATOf/IhsFdPXoMq8IG2wmGfWPzQafTwHWU=;
        b=SaUsBBOGlRABoAF1reRsJA9t0WCCfUuWxeEymp0rWwIr572Tijhb4rtlbbaei/soeS
         6XnQ5TNOAIWy5c0dT5qyhgJ1hd9ZmKNnBwGXHi/zRFaZy9ujw5eu99oPX+qOmdj4J6g7
         wokUF8fJhEIeKo7SXVMPQTcjjZhGYcnArWbV1r5vsOhSph4yfBkQBn71X0Vm7KfHFpxc
         3hAP+mmbfGZoBJcqsmxv6Xo/w2MXsJl+KuJf5y6Fo7ZHzbX7ws6JJ1w1N/dQ49RJtQca
         mlFjRNyYyueWSE1mxXwg+1+FtyxGhq6Lo3lC38YSxgjMYIf6pir5nxaIkA4qEV06pJk1
         SBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxCzJpuoWV70F1xax0uSTV+BUtOQATR+xHyOtyHh5nOajBREHMmOlDQ0cgiyJWFmZFKy+pz6xdJOoegmOmm5So@vger.kernel.org, AJvYcCWNfLO9zkLHXpCApTPLzuJiu3eVsfXXa8X5dizruSholM/DWg/wdeVR4KRrrGK+4oSbWgm8SirRK6MxAHk=@vger.kernel.org, AJvYcCX/5JsCkYVWGHGgvdA/K7E52AEMLvn4lTn+I0TWzYBus0G5QonMMZV4G945fGVTXBnQBR3yBCwuamOpq5/g9UKmqTvo/1DP@vger.kernel.org
X-Gm-Message-State: AOJu0YyVU5P1p2N7/yqDaG0sTyKBMj+ogtNqeXAoks481Ll5WRpq8icz
	K+bDqweZGEYL9Fq8GYHCjocmZK5eAMII1wnmD36lQfA5knXSXKW1GBfXhXuIEA==
X-Gm-Gg: ASbGnctkdakeMuo6jBYIV2zeJhRQALmn0zHVgXScv/BZPV2MDextxwkjWNexeoPUboo
	dl8Tj/vYVeRYzi0f4PG06JlmnHC2ATYIKXOhd/m3uUNHXFxAZ1UHk7EDamzQ6xAmmqUONMXm0hy
	7dX1CfcMhLVjTIIwQBjY1YYM/RbxabOx6JYkPg3YwY/oDbhLTo1nJ9dTj3Tdp+r1jaaQJO8EM5O
	zpPzY3eJTljptZlH2+9W7iTlXJpOMFRHy/1sy/VcGDYVxS1fN23mF5REeQZY3Pymjkhmcc+rhTZ
	QuIZ856wCx5vw7ngFkLMytP4SvZgjXR/90JSODfZzItgDAw+LzEBTt9jw0o5dfY4W1uj3u7Ywl8
	NtS5+fTtX78f+ksydSDoeHxPjmEiGip0qyEhF
X-Google-Smtp-Source: AGHT+IHgIevwvPJgQjugv5dspNkhBDjgRpzWgftt1Ak0uBVHjapJ8gJPgLVgUmwdqoDwaFYpCFFxpQ==
X-Received: by 2002:a05:6402:4307:b0:615:77cf:782e with SMTP id 4fb4d7f45d1cf-61d26d80521mr2521515a12.25.1756593026831;
        Sat, 30 Aug 2025 15:30:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214bacsm4314351a12.16.2025.08.30.15.30.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Aug 2025 15:30:25 -0700 (PDT)
Date: Sat, 30 Aug 2025 22:30:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, richard.weiyang@gmail.com,
	Liam.Howlett@oracle.com, davem@davemloft.net, david@redhat.com,
	edumazet@google.com, gnoack@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, mic@digikod.net, ming.lei@redhat.com,
	pabeni@redhat.com, rppt@kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org, surenb@google.com, vbabka@suse.cz
Subject: Re: [PATCH v2 1/2] selftests: Centralize include path for
 kselftest.h and kselftest_harness.h
Message-ID: <20250830223024.sgkgnupykrif2v6f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
 <20250830163949.20952-1-reddybalavignesh9979@gmail.com>
 <20250830163949.20952-2-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830163949.20952-2-reddybalavignesh9979@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 30, 2025 at 10:09:48PM +0530, Bala-Vignesh-Reddy wrote:
>Add compile flag in lib.mk, to include the selftest/
>directory while building.
>
>Suggested-by: Wei Yang <richard.weiyang@gmail.com>
>
>Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

