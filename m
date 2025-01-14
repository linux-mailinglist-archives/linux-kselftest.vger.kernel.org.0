Return-Path: <linux-kselftest+bounces-24468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE87A10D6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C167188B351
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D91FAC5A;
	Tue, 14 Jan 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giKj94Lc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5181FAC37;
	Tue, 14 Jan 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875104; cv=none; b=MwRcLfBFzhzJCRvgkUtBPT40sHAHXUmuvOk/FD6uxXISDM92LkUXpmtXAZSUcgrZ41gsdEGNCm7UKdhaJKYLmKRRrdkvwxCtxkrjbEL41bura3tZ0O/727xba3cKG/LFW1oOX0wFLd/oUztdVtL3RJfB78uu6xwCsDz/oDtpcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875104; c=relaxed/simple;
	bh=lfITl1hV7HSdyCxSQYiXEzetpxQr9wCU32zXGTxsDGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/fCQ/tWNzLG99QsjSZsTlLMqVvsiSOk+E3QFe2+RCepT4Y8Z/2AZqAE0+IEqgM+mZZsVP6RLwmghHov8sPs6oYyn7khBIOCsx2uXMEFMK2MzjYBNCToMdxmqLV938APfheFSkPB0vm0YZNm0PxHwNe7EPGzyUudVuADDRUebDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giKj94Lc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso41104565e9.1;
        Tue, 14 Jan 2025 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736875101; x=1737479901; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYGUe64gxerF/HU3IG52omjn7xuMOnbvQ42b4szHS88=;
        b=giKj94LcmAOh6dFSGCPOYy2WLmHoBbs4PiQ2j7KqkM/uumxbGFAUaxpc8DnX5aEzjJ
         jp7SNcBR1vH4TG50ZRlgYiivSZDnUrTuwP/Sq/YLvf1+mTEJ341nIvll5Pzs8GsS0C3S
         YRACCzxJIa0ULAlgXISyYfJoqNGXB9pP8Vy6Z2BMCrtPJdNLWwpu3DMHA3QO82NIgoZi
         7UW4+sfDXaOlPTBAa6o7G2W4Kh73vFMHc1K9EGtHodSZ6CZJ5N5+e0LjT3WfEI7v34ql
         gQ+AXmfyDNuNCWeW4xa+VMIZ1fbtHoZ13VicNYhsl2hdtw/b+W2Z7163atEJalI5WqrG
         qe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736875101; x=1737479901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYGUe64gxerF/HU3IG52omjn7xuMOnbvQ42b4szHS88=;
        b=YAjSrEFp9yKD0BbLH9mtK2f6HW2Ghv4xN/KX7bTZCbaEYCYVhdQp/7wZWzT+G9/rMv
         xQwpqS0c2/ayG0Hl398FRTztHOUrZ70gXmanbCxlEUh2h/66yd7c1U1LvmEhFJULlnwS
         83wylk2B3+cWoN5KLJKU8Pcne7lC4+Ztf2XX+rOuTIqcDaDCRroAREVh92izVwsAw9qA
         Pgx07l90XIxtQ4boXSbuGieUX3uPLTTi3e7wPt8YRssbI+CJceHe+HXNKPkeFWMM06Og
         aV3N5u3Z0H3KntzD3r1T43h1lPolqtBC7Bhg5FRcuoiFFV/GCd6jZNYCA5mmzmNr1+54
         Jcug==
X-Forwarded-Encrypted: i=1; AJvYcCVCpx6ZfQNsCnK5oSNnnqCIK6SJgoJ8M49t98DtPPicHKdy/Eml5rYak04FO6nly4+9ygqIW55owEnNm0n5TXI=@vger.kernel.org, AJvYcCVzuJAKgVfAKL8w/b9RjVFz1UCyWgYaMul9B7rbJ7Xd09HAtfLD+rKmBd+cmef9dzrSQIeWBH76DgSz704pieLA@vger.kernel.org, AJvYcCWOyFrvl3eKQ51TVBSKHl5qdyNN5tNrnub1mNPos42PC/Z7tl1hZDa8943TTt7URraH0dM5N6ZNjc978lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16aTYzIPXZ23W3Gsb7vb4Rxk4YeMxvNaxjvb41tVqAJ2x6JV0
	j76lQMP6Nrr7Wbfegzlt6yar55JFimjdZsGX8ROcmA1q20w9y9/S
X-Gm-Gg: ASbGncu5NHK5E5vm81DXYJT7zp/WfRMgkvEoBnWQIneW3VXgUaVdJLdzfc6L50HwcAV
	8avh0YJkfzEeZcAmkhqgHs6QywCXCXEzqUJnw6qRiFCR3nlmWfUlAa6nXsiH+OQF7qAiK0saGPd
	7gJVaeJ9qa+ixF4vkhV/J9IR2O2FSW40ZLt1Rz7mO483/AFs2H8MesV9fMV3J54WGgSXPfyaVK3
	zqjJDip3YmqgNo0wgUyK3gh1oGjqTelMBWIPCDL4JH8Lgrsbi6Ee7+3C5Wjt1wUXPAOoQcJ1RjV
	KN+H4SimzGkQ7AAqvBCw
X-Google-Smtp-Source: AGHT+IG3mWtyGgJuwKxhcEZalkLI8ph/rLux/zMEGyE2gMJUUPVUcTv9Ikx9hKHlk2OMasJI7f5OoQ==
X-Received: by 2002:a5d:584d:0:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-38a872d2a33mr24734020f8f.10.1736875100744;
        Tue, 14 Jan 2025 09:18:20 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm15312122f8f.78.2025.01.14.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:18:19 -0800 (PST)
Date: Tue, 14 Jan 2025 17:18:19 +0000
From: Stafford Horne <shorne@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for OpenRISC
Message-ID: <Z4acW3Yyq4BSXSPv@antec>
References: <20250110102248.3295944-1-shorne@gmail.com>
 <20250110102248.3295944-4-shorne@gmail.com>
 <cf78a480-e38f-496c-931c-cd889fb29d59@efficios.com>
 <668be2b3-4db1-45e9-bf2d-558c237db57f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <668be2b3-4db1-45e9-bf2d-558c237db57f@linuxfoundation.org>

On Mon, Jan 13, 2025 at 03:58:31PM -0700, Shuah Khan wrote:
> On 1/10/25 09:16, Mathieu Desnoyers wrote:
> > On 2025-01-10 05:22, Stafford Horne wrote:
> > > Add support for OpenRISC in the rseq selftests.  OpenRISC is 32-bit
> > > only.
> > > 
> > > Tested this with:
> > > 
> > >      Compiler:  gcc version 14.2.0 (GCC)
> > >      Binutils:  GNU assembler version 2.43.1 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.43.1.20241207
> > >      Linux:     Linux buildroot 6.13.0-rc2-00005-g1fa73dd6c2d3-dirty #213 SMP Sat Dec 28 22:18:39 GMT 2024 openrisc GNU/Linux
> > >      Glibc:     2024-12-13 e4e49583d9 Stafford Horne   or1k: Update libm-test-ulps
> > > 
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > 
> > Thanks!
> > 
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> 
> If these are going through risc repo
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> If you would like me to take this, let me know.

Thank you, I will take this via the OpenRISC repo.

-Stafford

