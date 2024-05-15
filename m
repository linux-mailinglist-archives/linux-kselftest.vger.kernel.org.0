Return-Path: <linux-kselftest+bounces-10219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2D8C5F59
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12621F2255B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F443374E9;
	Wed, 15 May 2024 03:14:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EBC38385;
	Wed, 15 May 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742848; cv=none; b=ULx1r9RpVRm2lDYhoLZu3c3eijKn7ECF9JLKo6XLbDbzakkewPsW8IedOTRUxaNNbOAvZOd3QqjRcBNnPk+KhwTBJuZCoLqUPpRMVNqJLlWJvUyTUKrYWLCNXohlJcl+owyH83PJYdOIguGLfsjEq90hcxzJOKxvK8cDdQ1fyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742848; c=relaxed/simple;
	bh=nB1m7j2Q3vEqktywIoGVfNTqMXYMw9gbBScV7i4x0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5IWINe3Bvxy+8GeP5La3r1srhnFtBODgDit+jlRdpk7XAiTa4muAuiQ9iLny1R7YM77Pejh50IQO+4gtP96kFEFwPtKF0uhdGmMBw4GjUwFq86UD1728ydU1EX3BaM3mByps/HHPFVchln3847CsilYzBs9AboKP0dw4HCvGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 44F2wB5O001379;
	Wed, 15 May 2024 04:58:11 +0200
Date: Wed, 15 May 2024 04:58:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
        jeffxu@chromium.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
        rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <20240515025811.GA1232@1wt.eu>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net>
 <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org>
 <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92453.1715730450@cvs.openbsd.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 14, 2024 at 05:47:30PM -0600, Theo de Raadt wrote:
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > I worry that the non-atomicity will one day be used by an attacker.
> > 
> > How might an attacker exploit this?
> 
> Various ways which are going to be very application specific. Most ways
> will depend on munmap / mprotect arguments being incorrect for some
> reason, and callers not checking the return values.
> 
> After the system call, the memory is in a very surprising configuration.
> 
> Consider a larger memory region containing the following sections:
> 
>   [regular memory]  [sealed memory]  [regular memory containing a secret]
> 
> unmap() gets called on the whole region, for some reason.  The first
> section is removed.  It hits the sealed memory, and returns EPERM.  It does
> not unmap the sealed reason, not the memory containing the secret.

If we consider that the attack consists, for an attacker, in mseal()ing
the beginning of an area to make sure to pin the whole area by making a
future munmap() fail, maybe we could make munmap() not stop anymore on
such errors and continue to unmap the rest of the area, for the purpose
of not leaving such a theoretical attack vector work ? After all, munmap()
currently skips wholes and continues to unmap the area. But then what
would prevent the attacker from doing mseal() on the whole area in this
case, to prevent it from being unmapped ?

Wouldn't it be more effective to have a non-resettable prctl() allowing
the application to prefer to be killed upon such an munmap() failure in
order to stay consistent and more robust against such class of attacks?

Willy

