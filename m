Return-Path: <linux-kselftest+bounces-12072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176E90B644
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582E61C229CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958114D6EF;
	Mon, 17 Jun 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="begfLGrf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F15847A;
	Mon, 17 Jun 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641481; cv=none; b=VlMBe4Ac+jIjpCBWWt2NFPLzv/hcCbrTUjS5CCPNfXy6RtveSECL5UCM5zskEOoZ0MawiOMEnxvTRVQ8Z+/Y5YJcJUAfnd/RD7H5Mv8mKg6UBbDLJXcMCQTe5ygFzVNkskIUYHfHJ9aRaxj0xicEuPETN3NFlpRb/BnYhJ7xxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641481; c=relaxed/simple;
	bh=91LV93NxbGXaObbWSRWn/awCE5cjNH9Ay/li5FynBT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DecOT51qP56eEHg10dAjVLJgRooZs08KNyeltGagM/ehOc/o4NYvozyUvhw2ENg5cNr6IWxgqSGkxIA55SXEZNZNPVs7dEkFvBMPuPOrniip2ORh2xVy2ek6TFRjAwnzjfQ9RwIlod3nYoggVLx2IBiP2Yfa1bxds2GLfbNK/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=begfLGrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0164C2BD10;
	Mon, 17 Jun 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="begfLGrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718641477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91LV93NxbGXaObbWSRWn/awCE5cjNH9Ay/li5FynBT8=;
	b=begfLGrfkwnWV142KKUjGxqZ3Zi7AJxslVOx8ShCJGRXAxyr3SAwysUeINd7Hyx0rdXrj+
	Q7qK7bxNfabF/iLFHzE/YWPJV7syZPK7+ymS/rZ1WzjG7h0sYhn4+eTeJEToIiI4xqKDAz
	D4cjcA58XiRC2v3cmOImkWi+t0ZWLvk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ccbc541 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Jun 2024 16:24:35 +0000 (UTC)
Date: Mon, 17 Jun 2024 18:24:26 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v17 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <ZnBjOjWOoANFwuAx@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-6-Jason@zx2c4.com>
 <13483c92-cac5-4a3a-891f-22eb006c533b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13483c92-cac5-4a3a-891f-22eb006c533b@nvidia.com>

On Fri, Jun 14, 2024 at 06:53:09PM -0700, John Hubbard wrote:
> I'm adding linux-kselftest to Cc for visibility, and I've also Cc'd you
> on a related selftests/vDSO series I just now posted [1].
> be part of TEST_GEN_PROGS. Fixing it requires other changes, though, as
> I've done in [2].

If you can get these into 6.10 soon, I'll rebase atop your fixes so I
can make this how you like it here.

Jason

