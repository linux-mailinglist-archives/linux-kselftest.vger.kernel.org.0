Return-Path: <linux-kselftest+bounces-36332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F56AF5B7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F9B4A16B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249F309DAD;
	Wed,  2 Jul 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fL+qJteQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DF309DD9
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467562; cv=none; b=kuPI1byoweYo8kBg7UnOuaBebI6hHJM4pAK4HctrbJ94B5Pi+YPr0uCvgbGdIQsbZrugyIsCNE9Af5ojtNf+EVpn0SAMvIKRKZwum27ihC43f1tgI7atxwHWIEfRU6+pXcCus1lnnFQe/nyi7x+zpdx28sfVg0Y322hlxDaHGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467562; c=relaxed/simple;
	bh=EahlvFfnghXvMghThmnVMSm4P+zVrUpRV5rzWBemzbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiCHDWUBViCEExvHaIs/vFLrUPF97VxU8Bs5PGbIusYSqtPR6KhLH+WI+ZAkHkDglnWq4LDIXhC7xcy8i14d7K7Iwb1rj9191wOR+fDlTuue/V5CxQ0T60oqslZAKYmq3wmjNqMd9gYE48MQ8pwcJRTdi1EkXSJKIlA+nbgTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fL+qJteQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Jul 2025 16:45:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751467547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ul6kWY/d97Gwtz7aZgKCmp9f2JhC+Ou2eTOqrOtf5Hg=;
	b=fL+qJteQhYZZgvw44lXrLGozXpO7yK77aDsg4ipcdo+YJNgCBDHgebsQJ3Bp0ICWFnXBRz
	+u4xTgVydJ9WnCo6tVWZJEa6JYGmjCEpcgwa3dGDl38gG9Mmi7EUimn8s5xmPL9Yo2Que6
	wFm+J2z5CGDmZ1CWlPEX7WOo0ssPc7U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2] riscv: lib: sbi_shutdown add pass/fail
 exit code.
Message-ID: <20250702-ff1645894982f3f00f68fc21@orel>
References: <20250624192317.278437-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624192317.278437-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 24, 2025 at 12:23:17PM -0700, Jesse Taube wrote:
> When exiting it may be useful for the sbi implementation to know if
> kvm-unit-tests passed or failed.
> Add exit code to sbi_shutdown, and use it in exit() to pass
> success/failure (0/1) to sbi.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/riscv/asm/sbi.h | 2 +-
>  lib/riscv/io.c      | 2 +-
>  lib/riscv/sbi.c     | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>

Merged. But I think a follow-on patch that makes it configurable is still
a good idea.

Thanks,
drew

