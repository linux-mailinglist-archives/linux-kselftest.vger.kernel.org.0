Return-Path: <linux-kselftest+bounces-36209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A5AF0361
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426873A27DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5427FB34;
	Tue,  1 Jul 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZa0mg3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F020277CBA;
	Tue,  1 Jul 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396962; cv=none; b=dD25nrPVulqfVBegRjgI4eQO3s1AN8Wtr4ywq6EF3pIBUpq/Rqqpn3gj2ADyEyfPsLEhZmB3LWNx2Yzu5+H3RxxyHPEixBO4DmAeJNeO1pgtO8gpzAhrMLTXaLRpLTaRlacxLajkRWzC4ydM/GeMWQL0ZgXnpcH4xFu0nxlhUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396962; c=relaxed/simple;
	bh=GIDM07D74e88J5iKzzjQjxabKCpfk+BcWb9tNgQsLUM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TB1cqAJptazUM1udLkRNtGS9mQw4micCxYqw7Me9dkMKC+xij96yZThve/LdST+p+OO1HJ7EXrYZGBZ11vlTujmpzaB+SE8mP1Nrysw27J30FeTtlD/NoRr43Zyc/gdbXwdtRTMTl9YuJIW1ugr/UJt2vVvYev1H5Hrdn5Oj/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GZa0mg3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955BC4CEF1;
	Tue,  1 Jul 2025 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751396961;
	bh=GIDM07D74e88J5iKzzjQjxabKCpfk+BcWb9tNgQsLUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZa0mg3hI39Ery9ChDXGj/+uw+L0iw4iNlMP6kQ0ymtqJ3t1OCZLx6TANzt+G+hFy
	 1H78KJtC5r5JcINGoqnlFA40ruqom5hpo+8dWzG0RcXsWUlD2WAIDo5Gkq2/qTjJKC
	 Rce9UXZ4PTNsYeO107+n7wNaT2uIoaRCqQq1hS/k=
Date: Tue, 1 Jul 2025 12:09:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Henriques <luis@igalia.com>
Cc: "Achill Gilgenast" <fossdd@pwned.life>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] kallsyms: fix build without execinfo
Message-Id: <20250701120920.49cd122526b3032a4db1e218@linux-foundation.org>
In-Reply-To: <87ecuz51eg.fsf@igalia.com>
References: <20250622014608.448718-1-fossdd@pwned.life>
	<20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>
	<DATW4DAU81FO.388H7H1WSUKAB@pwned.life>
	<DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life>
	<87ecuz51eg.fsf@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Jul 2025 17:19:51 +0100 Luis Henriques <luis@igalia.com> wrote:

> >> No, since backtrace_symbols is provided by execinfo.h.
> >
> > Is there some status on it? I saw you picked it in mm-hotfixes-unstable,
> > but it got dropped out again.
> >
> > Is there something I can do to push it?
> 
> FWIW I can confirm this is indeed a regression.  And specially annoying
> because it has been backported into stable kernels (even if having kunit
> tests backported sounds odd to me).
> 
> It would be great to have this fixed, or reverted.

OK, thanks for the reminder, I restored this.

