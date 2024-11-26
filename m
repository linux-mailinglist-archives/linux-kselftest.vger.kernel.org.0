Return-Path: <linux-kselftest+bounces-22534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26309D9822
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A80F164A8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A11D4605;
	Tue, 26 Nov 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LjXmzCdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE41D27BB
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627117; cv=none; b=pPgynt1wu/taxCUaKzB7/A/NL4hEEv/Y+dMtFgw6QwUgTrNyQw5PCGmXpgxDUznXhgta9C86nI1geaZNPkSURh35fDywId2KoJYzpZoYtasjBhzZJVFQHpBMbjFHDPKMdjnCKLgB/FoOSqcuUsawqZYpnyy6HLJ1fp7NVcDnI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627117; c=relaxed/simple;
	bh=XvOczRYBHnqj6D4ESxktzkTKZPxGuV4JkG6dG5SfdTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioWN8LmyrkwWTKuB0vKTo5x//2pQ/nouWOT0Jet11hU70/csETh9b/2pyoMMLXoJ63t04h0CsQgibEox4VryJDv89YjC/4oNykLnQvPsBzGTSY1qgSRARHD8N81Jaf34krzRxjreFjHIVrHy6sRY33uv7ne0ElL4mux/6y5kH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjXmzCdv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so1971075e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732627114; x=1733231914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaXfKxew919ViwJMv5co2YOm9WoJznHpNhie1VQ2zKc=;
        b=LjXmzCdvIScCjXsJrKI7BUlXw/ogvQqZrE7ogbKCfawG7sPVTW/r2yLzkHRjgoFOAl
         Ju+jLwmC9/OZ22gOeC42n+91AOxESV2xd45CXrzGxdwuefih23ZMZJO0ZMqMcy2R3mwA
         0DcC2wGHhm+SScrURizhrfX5bwnrhQd4/Xvl1+pyaVNeKD7pwl87GtVzyFVtPi84jdJC
         JLudHHyA3kcZIdVP0fE1atuifeeTjT0e7i7lpB5fwd7/LL7yGMaFHhz7qRyTnev4cS9p
         /hJWaX3YsNlqD9j0oQTErqM0IbimmTe4jLY2PenWig8HVfUAo63b6En3u7MToe9VC5Eh
         lG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627114; x=1733231914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaXfKxew919ViwJMv5co2YOm9WoJznHpNhie1VQ2zKc=;
        b=GH4deEhK28OziUkG6ntJNRtJ2qH7+mSdurKJ/lJ4qtpxrGM5py45UGlLmTnYR/HsGw
         FDRZhuQ92+NP/190IPIAJd/33zRPmd9+LkWXGj9siejhUjgGx9KuBuWW+htx5wO8/Ia1
         qOMsZdOOviq5h2sW2y/C3qCxLtGvzlm0aN3B4uLDNw1L9R2oWZU/ADN0XxOYEMtJXbyM
         7kx5E8/6uCCdNCx15aCSMvX29Ukt3CF+K/RhqpxsJ+csysZbkZYZQ/xjOES1TXLuO5+R
         xO92wPZylRKlPUvUzpjRKm4pTtdsf3Ha0Uz0LCmma48N6KZPTua2ZLJZxrm8P9fKZ69a
         sUfw==
X-Forwarded-Encrypted: i=1; AJvYcCUUZhZhdv9TpF+InQAz+Y/LgLug9i20zThYOZZA0Uy5EdohXNsM7lUnaCzJ7kn47mvFiv2bxbEktWLTeJbpyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyML3O81NkuQmmnD3IndU0vTmrmrgSyX8NmcaA3DzkB9Xzyart
	gTB+9ZQj3izhB+6gK1b1sN8Wrk/Vq+CtLb5EQEAXF78O8RqfAVXdVyb4G0dqKOY=
X-Gm-Gg: ASbGncvAwJ4t1x+iWcLxLhGNyVzqp1LYSBiWlFWovwrYIBAl/NZ97bK7qTA5CwLeLov
	uyDQNjlag5eEq2HEuwvswrLfnXudUiu69zblCB0MsAySIHfG5xuVZG9PnXM24k7iymPhxfrv0k3
	xZ4xZxv2dWFtXPlHkvMd0p/IaswR9EmpBV98uHSalI4Pq8BuUAhUkB/GJC8bFa2cTpw1VeDpuIJ
	fmHnOW+rxRnL58ci1uL4UEjmEYFZx9lpXAT6pIZeURDCFhnRzo=
X-Google-Smtp-Source: AGHT+IFqrzqPLKiXN8EGHTiOqvtymXHH3HCsdhZtbH4hWUr3e3NQjnGkP9XHsrV6DaHZ2smDfxKoOg==
X-Received: by 2002:a05:600c:8a9:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-434a4e56629mr27530185e9.1.1732627113846;
        Tue, 26 Nov 2024 05:18:33 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349e80e51esm82131645e9.33.2024.11.26.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:18:33 -0800 (PST)
Date: Tue, 26 Nov 2024 14:18:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace
 hardcoded module name with variable in test-callbacks.sh
Message-ID: <Z0XKpjs53Da5nEvU@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
 <20241125112812.281018-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-2-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:12, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Replaced the hardcoded module name test_klp_callbacks_demo in the
> pre_patch_callback log message with the variable $MOD_LIVEPATCH.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

