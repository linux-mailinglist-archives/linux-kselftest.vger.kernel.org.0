Return-Path: <linux-kselftest+bounces-13743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC9931A3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E84B22841
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788D6BFA6;
	Mon, 15 Jul 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6W1uv3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28642482EF;
	Mon, 15 Jul 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067837; cv=none; b=pwLakNwf6jLqFpM1SBTFsxayzboylXXtTv0qcZ1qUOXMErPEJdl35KzYE22cMMW89ttJ1S4xGQ7dln3PHkwfV3bh8fMARBXHWt62svnhT4HWp52a+XFfPH8VE4qlYU+UwC+cWqQuedksa5VSbr0Gty1XAj9Rg0xbVC7MDnZi9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067837; c=relaxed/simple;
	bh=rY+ZglPfTax4UbXbXo4++fWTE251iljFO+tNpvqsaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB03xnNUfvQjRFdIfAlHuIZj7X97jw23WvFQqN66doK0kjonQO0iVm1qGMn2GG+vaTnW/p2ND78zKUjYaZ9wROWz0mUAS9yOtFgKYd2uupVz9bdG/iis4fW5AEhpWT5e57bUXUc4GizXqkbQC1A4bBYP9Vc9s/pnvjQuFaqpNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6W1uv3k; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706524adf91so3933830b3a.2;
        Mon, 15 Jul 2024 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721067835; x=1721672635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xm6Kv57KRZBfQQs9+9DE/pC+uCpbt9UzvazBZL0I0GY=;
        b=F6W1uv3klPldVbwjgksJFFK33I17DIuawrvY+OEkkuU2Xf8QelZcCrc8xdFCvXwSBb
         YNp0crFCHK9Nc6WFubhX+cgewMMpaElqDEbx8pcBTf+uzbC1iuj9lusISYc6gs8G1dw3
         7L9jsUgg791DvSq9HEPZdVYtviH4AIY71GBbli4gIEZBLM5uVALefb5CYU/ZdtA56Mwy
         Iag4MvTaDVdfKCwMU3Q+TM2x4M993JCVbeL4x9uhA0EC+5Kpn1SKTePhdaXlEOvuOk+U
         yNHRWIn+OqRAmS0ipI510XAv/hR+xeUyfv+chRpVfaMHC0zKrdfo2nC1bWWZJJPgpfXU
         pOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067835; x=1721672635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm6Kv57KRZBfQQs9+9DE/pC+uCpbt9UzvazBZL0I0GY=;
        b=i5cDh7GYqBH192aUYh53gW9x9iuqtfG5npF96Jy3woFmXc6MY2gHdoo5lAULZatb5Q
         XrUuT/qjHm9IMZzxeDkrHraC69xWctiWguAj8pip9F/9KgsZe625JcjE0nsO0vxU3Nij
         6o+zFgD7zp7wb8esUdHHKPIWLWdJgA+6XazW5w/BJU+tvm6NkoMUFCjOX58s9/sGpxoZ
         vPFSv2TGk+N1VTJ+8wYoaQyLjajLFJzVm+27nK8dN4ef+26WQLsAwvJzZZq1OaJqKkr0
         F+N7FaJwrlnIeWRoDcdX4FruyKzJ/A+LAbK3H92nJFAREqWq+8+yVh6T6+0tCMEbMghq
         gLuw==
X-Forwarded-Encrypted: i=1; AJvYcCVOPAMRgZyakYmmT4yFpyN4VBfdciEqn6kDaRzRmzzCkSIPuNYz6yp0n75nQaInvUBVJQxAqawj16k5+z0OgbbimKzoHLi3EzttncOEgR+0
X-Gm-Message-State: AOJu0YzsXYQp6ajV5LV1ESBlXre9Evx9qh8Oenqy8IKZdbhE7T9l6gty
	BI1UXzFYQdScPYvgiVKpZq+0ypfdcbv2S/Q5uylsiZkW5LMmVhRW
X-Google-Smtp-Source: AGHT+IFAl4O1yBJNyYbJj9fZk4QnHCSt1N6houzz/EYyP5TB7e11xUSUZefrC3fu5k0s2lsjjeUD7Q==
X-Received: by 2002:a05:6a00:1307:b0:706:5dab:83c5 with SMTP id d2e1a72fcca58-70ba457cf3cmr584153b3a.0.1721067835244;
        Mon, 15 Jul 2024 11:23:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6aa1sm4705205b3a.77.2024.07.15.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:23:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 08:23:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>, void@manifault.com,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20240715: WARNING: at kernel/cpu.c:527
 lockdep_assert_cpus_held (kernel/cpu.c:527 (discriminator 7)
 kernel/cpu.c:516 (discriminator 7))
Message-ID: <ZpVpOTNCEn1LTuD1@slm.duckdns.org>
References: <CA+G9fYtg6tjSpVSN+OJRrSFhKcH5NkXVH7ccZMkXDpKjV5TYmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtg6tjSpVSN+OJRrSFhKcH5NkXVH7ccZMkXDpKjV5TYmA@mail.gmail.com>

Hello,

On Mon, Jul 15, 2024 at 11:19:11PM +0530, Naresh Kamboju wrote:
> The following kernel warnings are noticed on today's Linux next-20240715 tag
> on the arm64 Raspberry Pi 4 Model B and x86_64 devices while booting.
> 
> This is always reproducible: yes.
> 
>   GOOD: next-20240712
>   BAD:  next-20240715
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Yeah, known problem. Lai is working on the fix.

Thanks.

-- 
tejun

