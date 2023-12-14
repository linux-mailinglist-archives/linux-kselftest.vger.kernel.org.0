Return-Path: <linux-kselftest+bounces-1961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C36813AE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7547E1C20B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 19:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AB69794;
	Thu, 14 Dec 2023 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZBJ4R2IZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2368EBE;
	Thu, 14 Dec 2023 19:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB018C433C7;
	Thu, 14 Dec 2023 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702582858;
	bh=K9B2txQTgSN99zWiymlTobnzZROd0qplmIqjISRpvQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZBJ4R2IZRRRmCnfDh77WXtFkNC4CWWem9aaV9bQ/gtkE1e1KAqpTBTvDniPwCLNWq
	 y1AS5HkupWrkEZ48wVv+Lct/2IKsYS7w+iab947cADM689VNdCBaPr/NxKIRWU4jTC
	 +ELPAKemP2y9hD2EbUWxZFECFBe8sqKJYLOUprVI=
Date: Thu, 14 Dec 2023 11:40:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>, James
 Bottomley <James.Bottomley@HansenPartnership.com>, kernel@collabora.com,
 "kernelci.org bot" <bot@kernelci.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: secretmem: Floor the memory size to the
 multiple of page_size
Message-Id: <20231214114056.ec687939a411961db10e73df@linux-foundation.org>
In-Reply-To: <20231214101931.1155586-1-usama.anjum@collabora.com>
References: <20231214101931.1155586-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 15:19:30 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> The "locked-in-memory size" limit per process can be non-multiple of
> page_size. The mmap() fails if we try to allocate locked-in-memory
> with same size as the allowed limit if it isn't multiple of the
> page_size because mmap() rounds off the memory size to be allocated
> to next multiple of page_size.
> 
> Fix this by flooring the length to be allocated with mmap() to the
> previous multiple of the page_size.

I'd like to understand how this was noticed, what the ongoing effect
might be, etc.  To help decide which kernel version(s) need the patch.

> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>

Which is one of the reasons we're now placing a Closes: tag after a
Reported-by:.



