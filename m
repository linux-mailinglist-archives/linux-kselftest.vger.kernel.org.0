Return-Path: <linux-kselftest+bounces-4880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D485880E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADD7B21117
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F3145FE6;
	Fri, 16 Feb 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SIo2CdYl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0051E865
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119146; cv=none; b=sxbTKhILjWdlSzmawUHLzHI2ArXizhRUqoyPzKN6FhVnGjKy+l+C8dlFYP7eCtyyBYXaHXjG5yeXDHqlKNFckQ4Pws8mu418BR8c2GZmE7rZgLddoG7Pim+MJyOj/tQJYHiHu5vrN/ObzqTAVAp4IVE16sM7W6UyJHm6BPFpSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119146; c=relaxed/simple;
	bh=BaWe4bMmpPNIFme2TB4IMKoF4JCB3A9aQpd7EHxHVYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahijzRau0kLqFW1GDmNPwAOeYQ12xTVA4I4P5zjoJl5ciHPvF1BI7Ed4WkpxfB0KBhWwHniBZceTaGfdoo+3Bmpuflndpqut3Z+EO2vwONNw2PtTQ6F097UZXAeBBcIlmRT0S8SbtcmsKRI7a7G887wGkbvZsvFDa4nI0UeKfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SIo2CdYl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e09ea155c5so934396b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708119143; x=1708723943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sXIGyK5fJBS6Ih9dubAjV9UnamZEvWqzmWKeqKFQcw=;
        b=SIo2CdYl4o6nmM8vf4cuQewqFnKbwwWRSwN77XgB1+PzXvqjRUrLRab4SmfaZiN/XD
         7yUWNUCxdfYd6gMCfQxG8lK2pL5WYuT43kr0TdSMSn7KPvX+zv8Hs9JO3m1rPosBckKa
         9+F+rKUAsTtdlFlVoAzy1MDUEZe6gktzJY7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119143; x=1708723943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sXIGyK5fJBS6Ih9dubAjV9UnamZEvWqzmWKeqKFQcw=;
        b=o0t8U/Aj7Y4tKY+CNA1gDgnr8Xet+s4y7OCIFJCwpmn2P/aiLlNjy0VA5oYRiXjTbU
         lVgAilQ60xvYektpnXZ2Lj0WZlClwzhFxpM+aZnCL72itBSl64lYx6TT07y3CRNdon9K
         QHrs31H93P32YpYXfq4vkxSPWBdm0PY7JfY1k0htQqbz74eNhb3MNv9WfR87ZG/E3glo
         lITZ8cGwk3Rsg6vGB3jzZ/iWquWqB9tJUbBsDRdv2cPCSm9bzxKgAJUpZd85EupoU9fu
         nZUXZik0HbmjrV7+0a8wU3Mile0rcGKcPWrxPaCyBoZJ1spg7UITM0glMT1wKtOd7dot
         UuyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfIgihyajR5BCbvfdSsxvBtOCrQfFXG7g8t59/o/e5d5UwJW5GnWGB7dTng1QMKVkkeR0VfRmrXVkOZFrR3LYzwKYiLIQCKSf8y86s1ZdR
X-Gm-Message-State: AOJu0YwY5HJYQZ5W0MX8lf9bB6oS8cNuZowNzYnjBXUff0hIGABADQj3
	8kr/44+7RuXb0JikCCeZB0V7Kg2uIIplGsBbdZJKKX95CdOAyRj+5xmQ/e2DfcLfiRM9OAtbBSc
	=
X-Google-Smtp-Source: AGHT+IFuEiX6j8DiaCOSSkq9g3NAQytMa+JQBiTjrmoweTW4grnjh79jt7WMWs5n6/iVNwUaQiRcVQ==
X-Received: by 2002:a05:6a21:168d:b0:19e:9c82:b139 with SMTP id np13-20020a056a21168d00b0019e9c82b139mr6259963pzb.45.1708119143182;
        Fri, 16 Feb 2024 13:32:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n12-20020a63ee4c000000b005dc4b562f6csm361538pgk.3.2024.02.16.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:32:13 -0800 (PST)
Date: Fri, 16 Feb 2024 13:32:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: kselftest_harness: use common result
 printing helper
Message-ID: <202402161328.02EE71595A@keescook>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>

On Thu, Feb 15, 2024 at 04:41:15PM -0800, Jakub Kicinski wrote:
> First 3 patches rearrange kselftest_harness to use exit code
> as an enum rather than separate passed/skip/xfail members.

One thought I was having here while porting other stuff to use XFAIL was
that in the strictest sense, XFAIL isn't like SKIP, which can be used to
avoid running a test entirely. XFAIL is about the expected outcome,
which means that if we're going to support XFAIL correctly, we need to
distinguish when a test was marked XFAIL but it _didn't_ fail.

The implicit expectation is that a test outcome should be "pass". If
something is marked "xfail", we're saying a successful test is that it
fails. If it _passes_ instead of failing, this is unexpected and should
be reported as well. (i.e. an XPASS -- unexpected pass)

I think if we mix intent with result code, we're going to lose the
ability to make this distinction in the future. (Right now the harness
doesn't do it either -- it treats XFAIL as a special SKIP.)

-- 
Kees Cook

