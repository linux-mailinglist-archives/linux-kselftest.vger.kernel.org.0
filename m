Return-Path: <linux-kselftest+bounces-34527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0EAD2A49
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB86718919B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 23:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB52253E8;
	Mon,  9 Jun 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wh9RSJH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B41FC11F;
	Mon,  9 Jun 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510441; cv=none; b=kH456rE+8DZ6ksZVZ1A1pN6MUrLL0Dpm2gAhwAppVcnLcjK75M0spnqkcxzTSZkJuBruItz9Rk6ETbBEvYlytRb23RU7XLXjknCesv7xtiSwFzLcWbJhaNsP3YPVvpjks7QX2zAuZWAe4N1WcSloaoQ0xMAFDpOD0BuHMzZ7IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510441; c=relaxed/simple;
	bh=3Tb0w0kU1Sgu0xE1w4h+IAmi/4DPbA/kezkuaf2xGTw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sVnAd5j+4POVC0lWq4CLzQbn3IW7LbGiN/8Q6Z5WUNXVZ0/w5W3vL5pCu502ibj0iC8kjrpG951o6fbgiDSCHD2Ry8Pp0ABet3diNr05FfmpKRcRJQGBqjr5gAFpP6TQeEb/I7MyqRU44QroNAGta84TLBvjGA/mXHymWoDb+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wh9RSJH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF294C4CEED;
	Mon,  9 Jun 2025 23:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749510440;
	bh=3Tb0w0kU1Sgu0xE1w4h+IAmi/4DPbA/kezkuaf2xGTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wh9RSJH1Mb2yvxBO8AT/fFg8dvi45imU0TNhRAs3DvBJrp916m1Y+JTzSKnucdNwO
	 j9cJrMfDdNZ/1vGH7eH8lFkwV8jxBM5WJL63/w8bkjR9Rl60Q1xr9UE3M2cJcBizTI
	 I3FO4F5sXzdfQ7SA2Az8zlTUfnoXKEGCX95fqtsc=
Date: Mon, 9 Jun 2025 16:07:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shivank Garg <shivankg@amd.com>
Cc: <shuah@kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: Increase timeout from 180 to 900 seconds
Message-Id: <20250609160719.9c07424afaf33651f64522aa@linux-foundation.org>
In-Reply-To: <20250609120606.73145-2-shivankg@amd.com>
References: <20250609120606.73145-2-shivankg@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 12:06:07 +0000 Shivank Garg <shivankg@amd.com> wrote:

> The mm selftests are timing out with the current 180-second limit.
> Testing shows that run_vmtests.sh takes approximately 11 minutes
> (664 seconds) to complete.
> 
> Increase the timeout to 900 seconds (15 minutes) to provide sufficient
> buffer for the tests to complete successfully.
> 
> ...
>
> --- a/tools/testing/selftests/mm/settings
> +++ b/tools/testing/selftests/mm/settings
> @@ -1 +1 @@
> -timeout=180
> +timeout=900

Gee, that's a bit crude, isn't it.  I have a laptop which will need 90000 ;)

I guess it's better than it was before.  Some sort of smarter monitor
of ongoing activity can be bothered about later.


