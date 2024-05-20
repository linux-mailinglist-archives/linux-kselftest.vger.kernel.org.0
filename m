Return-Path: <linux-kselftest+bounces-10415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EF8C9780
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 02:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08CD1F2102F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7D2BD18;
	Mon, 20 May 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uJZPEt6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD923BB;
	Mon, 20 May 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716163227; cv=none; b=OGMjlBnMUDKcvNT0vMHGJM+DejxxA8VLkPogrcgyNrmiqK7vtBAsWnZUZODSdFjaW/On6VdR9ihEaKOlHsiVbgpZB53sO70zDM7B/+9Rk8ojat0c3laxzXHqYt5pw8Bc6A70w3JH0iLj3hXq4uiTtNGLcYUJeP66RNaHZuCe4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716163227; c=relaxed/simple;
	bh=K7ZdYke6mZmulP4ruJdT4qcASJpvqUrfFF/cByhd60g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IE8NetejBn/sjMdxd9s/ij3yxmD5r9PH8edY2rWfq2B6F/Zr6GaG+KIeCiN2SlPqxd1bnUMxqnseqnLNCMfwBU4jDS42oAkQWp1a/dspLC6wbewFgYTl4G8li4okRZheqnjFwcDbOXNRCxwkXaWXm0w0qYX2FcwDCtL2AXgWvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uJZPEt6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC232C32781;
	Mon, 20 May 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716163227;
	bh=K7ZdYke6mZmulP4ruJdT4qcASJpvqUrfFF/cByhd60g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJZPEt6u0yI4sB5B3ecpMDU9I0b6fOLkd9ufi2t25EcTCkJKF5Lia2tXV7gf9Avum
	 MnrGy/0w34CNeNEdRg2NI7CcRNv242+GLp7YI/xpMfLJHn97CdGU08TwiSeK/TnpJG
	 +ThJICjFGkaWjfRwa0FQWU1+eEIqbY31jKGiRHrE=
Date: Sun, 19 May 2024 17:00:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 sjayaram@akamai.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: compaction_test: Fix incorrect write
 of zero to nr_hugepages
Message-Id: <20240519170024.c2e62a7b69b00bb30e86a157@linux-foundation.org>
In-Reply-To: <20240515093633.54814-2-dev.jain@arm.com>
References: <20240515093633.54814-1-dev.jain@arm.com>
	<20240515093633.54814-2-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 15:06:32 +0530 Dev Jain <dev.jain@arm.com> wrote:

> nr_hugepages is not set to zero because the file offset has not been reset
> after read(). Fix that using lseek().
> 

Please fully describe the runtime effects of this bug.

