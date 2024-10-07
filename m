Return-Path: <linux-kselftest+bounces-19177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C174993653
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3549283DF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872FC1DD549;
	Mon,  7 Oct 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IbPcAiMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465551D319B;
	Mon,  7 Oct 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326249; cv=none; b=jHPnvvvqIXAzcxaK6c7UGsVSdZRcbiuocuqOclrJxCfjfDKUZJJLFYIU9Az6afB4vNZDBhkjcMdajIRAr9TncCSgzLgax8fbdHIOOwVChuaqajrU6wAymsOGT8yefDyB+jlyjLAM8MHAn88olEO+k/bVhUqvbyWxmqzU6RMT4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326249; c=relaxed/simple;
	bh=wRg+HfdO+gs4fgGG1seEJqKPZGtRXpnXIzsg53QX0iM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=diCYUenvHwEDA4xPSU/pAk/3xJh06DGh8T5MiQhPyyh51QzJnY/mFzi71YY/GcAI/Oj4c5C5PjAp0tCuJRjGAv72I2O3KOruYmLtXod2sNtke/pU9gDFXvYXzeqFcu2dKW+whfBjcmBZVtJ/XjfZIyNzsF0Ad8YtoPflw+GnMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IbPcAiMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0212C4CEC6;
	Mon,  7 Oct 2024 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728326248;
	bh=wRg+HfdO+gs4fgGG1seEJqKPZGtRXpnXIzsg53QX0iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IbPcAiMyNjqiAGrRPjyhYTuZBT/oawOW0dwxwrvVO5qn985Kb+l044YgfGRa3UoQH
	 pULia859F0NiGMizSD0W9UeLw/Q1/YcoHdsis9wkH7b1QUisPG5TZp6/XN6ScPHDpb
	 v5MBk4jH0p9xBkvVpqFSqcD3U5PXwKMaKY/xkh5E=
Date: Mon, 7 Oct 2024 11:37:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [RESEND PATCH v3] list: test: Mending tests for
 list_cut_position()
Message-Id: <20241007113728.8ea63f3bd0c46ca1728bf921@linux-foundation.org>
In-Reply-To: <ZwQKW6-YTGwEo1F6@vaxr-BM6660-BM6360>
References: <20240930170633.42475-1-richard120310@gmail.com>
	<CABVgOS=8-UH4Exnh8nw3zws9xrcearCvH8_NDFC_tsZL+KhJ8w@mail.gmail.com>
	<ZwQKW6-YTGwEo1F6@vaxr-BM6660-BM6360>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 00:20:43 +0800 I Hsin Cheng <richard120310@gmail.com> wrote:

> > I would recommend updating the patch description slightly, as it's a
> > little bit confusing as-is (partly due to the early version having
> > already been applied and reverted).
> 
> No problem, I'll refine the commit message, hoever, I want to ask do I
> have to send a new patch for this ( since the commit title and commit
> message will be different ) , or do I just resent the patch with RESEND
> v4 in this thread?

Please just send the complete v4.

