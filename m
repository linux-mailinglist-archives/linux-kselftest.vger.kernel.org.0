Return-Path: <linux-kselftest+bounces-22013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114019C84C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F8BB22487
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA671F6690;
	Thu, 14 Nov 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSr/QRSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1802163;
	Thu, 14 Nov 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572380; cv=none; b=lRzlmQot0v0r2+/gcJEeCXT4z9Xpo3P7sO+ep2HJeBLj2/xc8aZMdIUhk2HzV9DnhZxGuaTTHl3Fj1gAEULn6fqRkExczUgTnrIh6Euz1eG2W1rdJFDQ1RMGfxoPviQx9ZfohdEAwaMJEFl1B9o2cb4S7xWwlM556AnKf/XBIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572380; c=relaxed/simple;
	bh=gr/Bb2Vt0SDODfXNsh76nYoRzNRqWXffGbu65rI6TMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piKTqSUXbOvAQMJqvDRqsm/YClq8HE8P3Q0w4Gc8gby+Dv8FE2o/ljUHrtpcmqyQgp7fN+huNq9LQ9lXnx/LzfqwUb0yTYPsHlr8FqLuJk5yv93rS7+W5nDUks7lL6O3tRXd03CUoOcipxfylo02i9uXivK1NLi655zWleQQ6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSr/QRSJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720be27db74so217218b3a.1;
        Thu, 14 Nov 2024 00:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731572378; x=1732177178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkppDczKCwdEMXZdTfXwfq5j87EUrvC4VQvk9N0ACY8=;
        b=KSr/QRSJ/L9oFSyQYHFGLCszLlZNa2tJKeoSyG5zRPMIfTjD5F/ldQ/PNoCYD2Og0L
         ZwQp8vwJN8fH2apinrRYhYegMlU4QKXPTK4MDviJnWMeF3dIu6aIzUEdkRmpls1b9qcv
         g2zOiG59wAWOiusJEjb03wRo6AKvij4GkS+yheADWxlOOyNtqTksPGDPpHcGrPjsy8r5
         5SXLlfZSyYmWQygxtceYuwhlX/q26iWsGt/Nu6BuLxnJSUKO0+OYWUcwhgxZ3eSYk7jL
         Thf1WFRHzzPOxJwhW7lcLHTAPY+oxqDFPrv6Pml4KayhVn7kw5VHI0W5BmLQ4x3aWWYA
         fWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731572378; x=1732177178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkppDczKCwdEMXZdTfXwfq5j87EUrvC4VQvk9N0ACY8=;
        b=cbn3i0mpQ2XIFxO0pzlR8pl5b9Xz5B7zBsQUnODZMBbHc2F9Eyog0t/gxynnKOBFZh
         Weayps+5a+jAFN/+CVn0gO+HUjOLMZaAZSa/1UVW+K4qlCXRQLF2v2k1U40ncOzytyri
         +J47WjbGoMYxKb6BYwz/B+wBSrOokUOFT05aSAY4Yz/40nD1Ml9JEeYqadSYLUraS44X
         Pf0NL1dCs5qvhazCKkXJwq0RlIa/aXZaKfc0C4pL6hb45EHg9kJBPHOc6lgcGBDI2KSb
         7aDHMJawzk+vSSXn7UJ5bu8LBTmNAMXXOqTvDvOTqxwYuDNLObU9mdOCcnmnqRfrBktq
         ugrg==
X-Forwarded-Encrypted: i=1; AJvYcCVSqnd0RCrggTLgFqmcLQbidp2iPkqtm/M+ug5vuC3xgC7xuEIiKF8hYXWNaA1cU9Vf2m8Y3LXbKowon+dQfwPx@vger.kernel.org, AJvYcCW3mrAOdZ1L5aa70N+/xu5U1Dt4+KTjS9XgBHtGL9SEeBFVZ5AosqI8EKUtvkn+2JM56ZIFErOfpjqh5IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgPVnyxFPNDeJtcO2f1H1pUYQPIE0+e9o2hy3OjQ1RMVTgD3c
	7XuTUns+qz5S0kphDPm4z1wqXTwMYa4Q9VJ4YrDpyb0ckp194J/U
X-Google-Smtp-Source: AGHT+IH081bQiD7dlDPgizFKjXG43zFe3RxUsXxD7TjKkRsoo/EqPf47e9/nCNrECI73ap/tk/WF2A==
X-Received: by 2002:a05:6a00:4645:b0:71e:6fcb:7693 with SMTP id d2e1a72fcca58-72466795cf4mr4328115b3a.12.1731572378136;
        Thu, 14 Nov 2024 00:19:38 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a5cecd0sm711243b3a.25.2024.11.14.00.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:19:37 -0800 (PST)
Date: Thu, 14 Nov 2024 08:19:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <ZzWyk9QHb9qseMYO@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-3-liuhangbin@gmail.com>
 <20241113115612.1717575a@kernel.org>
 <ZzVZoe_N4_h4qWVP@fedora>
 <20241113184312.7a33a83d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113184312.7a33a83d@kernel.org>

On Wed, Nov 13, 2024 at 06:43:12PM -0800, Jakub Kicinski wrote:
> On Thu, 14 Nov 2024 02:00:01 +0000 Hangbin Liu wrote:
> > > # [+300.25] tempaddr not deleted for 2001:db8::1
> > > # [+0.16] tempaddr not deleted for 2003:db8::1
> > > # [+0.07] FAIL: mngtmpaddr add/remove incorrect
> > > not ok 1 selftests: net: rtnetlink.sh # exit=1  
> > 
> > Is this tested with patched kernel or unpatched kernel. On my local side I got
> > 
> > # ./rtnetlink.sh -t kci_test_mngtmpaddr
> > PASS: mngtmpaddr add/remove correctly
> 
> I believe you that you run the test before sending.
> But if it doesn't pass in CI we can't merge this.
> Just a shot in the dark but does it also pass without the -t ?

Yes.
# ./rtnetlink.sh
PASS: policy routing
...
PASS: enslave interface in a bond
PASS: mngtmpaddr add/remove correctly

I will modify the test with Sam's suggestions and see if it could pass.

Thanks
Hangbin

