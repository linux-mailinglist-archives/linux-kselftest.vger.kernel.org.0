Return-Path: <linux-kselftest+bounces-3957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D98463E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75021C260F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9845018;
	Thu,  1 Feb 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="TiZBDohy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267343CF4B;
	Thu,  1 Feb 2024 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828086; cv=none; b=rqXSRhi4h7iWl5OPIgoYPp/QD1HI69VD94H1GKRTi46VHHU565A0ex8k8BgG386ukOYCuuuUyUDTNW4dvvzBEn8hqp4SH0NBtKyyDVvQbZpDOIInRD+nP63+uQvLvw7Afnlr94pHqGNjjJ043C3KYjKFoq27ajzpLF374kxaohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828086; c=relaxed/simple;
	bh=XsMwAIF76rMODU5cRJ7MLIKLNHM7v1QiXUl6eTcG0xU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=AuhFNXkiEkqejPysSTsMIfSqvwa2G4Z7cM077nieltIPGEKm+h28gX6z8cZAtQ0FcNOoao8J83jXHEgMSQ4vuIJIFCSxBDhIVWAnVTcTz1iAGzynLAvRdMWSBL1zg2xNKgIBu0lTWOmMowQ7ixcs6+mRe+Sy0/WSLogexoIbAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=TiZBDohy; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=XsMwAIF76r
	MODU5cRJ7MLIKLNHM7v1QiXUl6eTcG0xU=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=TiZBDohyHbdpRj+xxwCXvCYXxvhiRXXrJ
	S5SNPoBhVTGOk6VrlamHTcLXteDXC5MprNAkSEXbT69Hz0SLqyDKh16YqGxb0Au6RtPBi5
	FIC3VeWBDiOMvQDUggEKAkhRT47T1nV+Y903Err9B3dtebWMPFThHW2LJp47Z0TFaLog/x
	mJix6HajvMrPyRFsOVFOms6CUUMfdFi0xYzw1us3H4Lwx6BMZdxONDyYHlhevg+KoSruAF
	Ph/eldYteo65H2KYHSr3e5Jvte3+9qzoEhABb/hdhvbnOuqyT6YzNrVG2t3WzkCo+NZx7x
	EYjeDq1ZgFyk16WzhWngLzG7VDb9A==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id f79fa3c2;
	Thu, 1 Feb 2024 15:54:43 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
In-reply-to: <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver> <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Thu, 01 Feb 2024 14:37:35 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27178.1706828083.1@cvs.openbsd.org>
Date: Thu, 01 Feb 2024 15:54:43 -0700
Message-ID: <58408.1706828083@cvs.openbsd.org>

> To me, this means Linus is OK with the general signatures of the APIs.


Linus, you are in for a shock when the proposal doesn't work for glibc
and all the applications!




