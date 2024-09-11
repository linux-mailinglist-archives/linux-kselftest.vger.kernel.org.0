Return-Path: <linux-kselftest+bounces-17757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF19975826
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88D91C2606F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61521AE058;
	Wed, 11 Sep 2024 16:20:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521D1AD9FF;
	Wed, 11 Sep 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071640; cv=none; b=GJVrDXoo1O9cERCRyCdNK6kfgslRqbqSDVFLL3cbbQ4NXzpsU8CmjaxC2AgBIi0SaLnNiK8ApmPcEx2ww9hXwMYBfN9tt3u0i5mQt9ML4mOxkl1HB8uUakArqMWF90P+r2R4jIi95su22JuEzG7pRwCAKC1O/echb/UeYGwkVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071640; c=relaxed/simple;
	bh=hmQWQXEbqM0N/56sUuANRJu6lllrB/AHwe4ycC1dMYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru2+wNuW2ENw+FCZDprmVOvnBlkYK0cdUhzg1heEgg3P4dOwdEj1/db/2MLfa+SdqJK5X7h4j7TKP+/iii+yWWS4fiwksoLkwWVgIFZyW66rwIM89Ku4rXYdZWjnqevEF74FL5kPBRRc2xVjXegdhJp//Yq17mMrxl1p2Hgz+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D452C4CEC0;
	Wed, 11 Sep 2024 16:20:39 +0000 (UTC)
Date: Wed, 11 Sep 2024 12:20:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
Message-ID: <20240911122042.1b3b521b@gandalf.local.home>
In-Reply-To: <ZuFMK7yndArZo4pA@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
	<20240910162335.2993310-2-vdonnefort@google.com>
	<20240910124541.23426cee@gandalf.local.home>
	<14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
	<ZuFMK7yndArZo4pA@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 08:52:11 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > selfttests/ring-buffer  
> 
> Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
> yet to linux-next.

Ah, I missed that you updated the selftest in one of your other patches.

That should have been a separate patch, as it works with the current
upstream code (just tested it against 6.11-rc7). That's my fault for
missing it in the review.

And after applying these changes on top of it, 6.11-rc7 still works as well.

But since it's in for-next, might as well keep it there as the merge window
is about to open.

-- Steve

