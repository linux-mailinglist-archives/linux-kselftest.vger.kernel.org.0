Return-Path: <linux-kselftest+bounces-27291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA5A40CAF
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 05:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089971712F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982B0157E88;
	Sun, 23 Feb 2025 04:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVmSGP37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A81362;
	Sun, 23 Feb 2025 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740284669; cv=none; b=nrUP+SOCGGUAl7K5Zjt2Z0S963eZkISicyLjvRLgduocjYEZD146vZpdeNR82cCxnwUci86/IkI+pj9VPXh4EfkOaRf333ISzmN62Zg5/iJdxCVGShp6koF57X+V1t6Q8WtmLDXqKCD+c1pg6RisAaO+Rt/XenVPlYngIS65k/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740284669; c=relaxed/simple;
	bh=4utJuDlOsvUYHCnvQ6QA0Gjx0TL5LAtKGca9nQJw+lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEFwhbWYAT0fPTmBeASAdnoWIfB4p8Q84HtAl8DQYO5248/GKKa1ds+C6oh+kU8BHrg7twrlW6CLkw1JHGOkNQhTVy18gSZcG8jGvhVIuLa4g5zcIa6jh01q233QXQwmLbveFjOpkgsW95tCUkWrh2Xt2rQ9FDdZIpEdjWRBO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVmSGP37; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22100006bc8so58266125ad.0;
        Sat, 22 Feb 2025 20:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740284667; x=1740889467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4utJuDlOsvUYHCnvQ6QA0Gjx0TL5LAtKGca9nQJw+lQ=;
        b=lVmSGP373YuY3CxVFhKk64ZjJwI/Qk45kHaE/B+EGACqTttPSUvUQ3ncVIWAoKHR6n
         +QOXeuTOF2Ufv69A05VGJsKpvBcbPheBoLUil8mC8WYyp7QXHVtHXqD3zOvghA/pSDa4
         WKG7xuuQKp9k6OzvaDfx3xLTbWQ2+Q4uxjt41gyHGd49HSh5OgZ2u6Gz5Gm4BqQU1myJ
         BSXASkuDPqXDm/Wvx36mQX46iVVZ8IrpIO117ANCGXg021CoJGLx76n09aHLvqhND9bv
         fM/HuJwwIw54QMyrIZbyiPSnD0AflUACnBDZu4Hj9YOHGshKf8Q7iyswS937z5huCWRl
         mk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740284667; x=1740889467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4utJuDlOsvUYHCnvQ6QA0Gjx0TL5LAtKGca9nQJw+lQ=;
        b=UhbYozASBg8bJY3IEenqcnI93MBLHzhlNpJ8qfVh4nG5VIj4o11mjnUY7M1hgHdL3v
         yiG8s72q2w+VThcWXQHcdNg74WJvoeYN3+LyLb3dD1EVb3t6eSJA1YeVmhfZ7druCO96
         d6h9H6sFCIm2Pyyi/mdpR9L2nX1TsnXilAuGB4d0IrrwU1hDUNKRzIFqoqloEQyer0EI
         s8Neq2HKQN15VegCKdQ83jASN5mYBAOwHS6+qbqeoHBjVILd+9sAlLXs4h7BA5w8VagO
         mqB/ywUcniWpcF2C7xcYewO7xibNbJte+YcBqmMHMVEh9rUyQygQinOfr6k4u8VbOt0u
         6Fog==
X-Forwarded-Encrypted: i=1; AJvYcCUXhJJT3NKwcuXFdffhgVc1c2a/e6uinApYId5krZgADxncRNhfoxKzPIR1BvH3QGa0a559wkMmoqonDYLjSjv9@vger.kernel.org, AJvYcCWs1IezDfPxbywSD50lNap0cT7Jt2cjCLBLarSX5qZWRpSzUI/kZOWrdIiAAVblttRYBZC7UcRjWQtmbYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtjeE27Fp8tqCJcNtrfNJNjMxy3j8azw/bcE/umbo+jlWLDzj
	ue10g0ravJm8QkcpUzbel8mNaYHWwHWunrLza8q4eWh1AMptQ9Nh
X-Gm-Gg: ASbGncsK1v1BqswrtyK90L5NlU/S4S4K/TBUGme6KLqHz5vqWKLEQr02Lw32nxyc5rV
	1Eq+OEbB9WE/NCYa/al0Nse3jIjbLBrxG53N4k7aema9DPSNE0Bc6GQYaCNPFLnIj0zia0L/6jM
	XTOH1iJhc4XzFwSJFOfVg4GQcY81gwy/hZHrVL/IoqxQoF3d3qwZBWNJryIRLV2/YUgmZ1A65vk
	bU1H0QBdS/eKpvncv92IBrKB0GSaHIqmZxhpQOg6eqbxDEWvXr5VvvjIMABcx9j2CElHQPHdpqm
	ETRxsz4U2s10RjGJcNcw8yyJ/Tv2ZYZVQq/hGmSKILC6ixk6
X-Google-Smtp-Source: AGHT+IETNzBByeQOq7EpOZLfBRs/ixt5hXArruM21mHPF3nbXPJTnmlS5y+q4HGQ3M6zAW3jcsqWZA==
X-Received: by 2002:a17:902:fc48:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-2219ffdde5fmr151052365ad.42.1740284667039;
        Sat, 22 Feb 2025 20:24:27 -0800 (PST)
Received: from ritvikos.localdomain ([2405:201:5501:4115:b161:5a88:9ecd:1b07])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7c6f419sm155327335ad.200.2025.02.22.20.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 20:24:26 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 99211ED9140; Sun, 23 Feb 2025 09:51:12 +0530 (IST)
Date: Sun, 23 Feb 2025 09:51:12 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests/mount: Close 'fd' when write fails
Message-ID: <Z7qiOE3EXo8BtdY8@ritvikos>
References: <20250222114709.50011-1-ritvikfoss@gmail.com>
 <20250222121249.50588-1-ritvikfoss@gmail.com>
 <zshes4xtyir7zrrybeqj2amrxyctwqnuvx2tqyktv4vsfstxqi@pvdq2rb5m47j>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zshes4xtyir7zrrybeqj2amrxyctwqnuvx2tqyktv4vsfstxqi@pvdq2rb5m47j>

Yes, the kernel will handle the 'fd' cleanup automatically, but
the existing implementation already closes it before exiting.
However, in case where write fails, its unhandled.
This patch addresses that gap :)

Nevertheless it's subjective indeed.
Thanks for reviewing!

Regards
Ritvik

