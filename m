Return-Path: <linux-kselftest+bounces-17519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA3971867
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37EC1C22B59
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9A1B5ECA;
	Mon,  9 Sep 2024 11:40:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52841B5EA9;
	Mon,  9 Sep 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882056; cv=none; b=nAcawmbgm7Pk1n+iIBigB5AUNqjcoRxyY51GaIc6Uoails5Jt1bCreVuHfHgmS84KMquY0dAjFdyWMhF0PY3rkExzz+wHWon9KdARmCV/Is+0IC70oqFh6IMQ3fVdiiGU1BB1aKPG5ESso5nQpGQ8ywecSc6XLkTYFG8ONTyQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882056; c=relaxed/simple;
	bh=vg9YjjHmNzbRmFUZcNaHHDoCIEh4knOY2NV9RZ3gN1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJkM9Po4uc7WwWHKKMZueY8I63XW/y2z21Z6usW/MHexhO8CGi55zKT/ZGgRH1Zrlk5sXBFZZ39pvk3LWc/ccsutP1WBj1dl/qSp69cuFe89WveC+Hq61Z6fbIsJumQp6NJXxIVLRYBcIC8owVsxRTNXcK0795NUtvFvK0UGsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF98C4CEC5;
	Mon,  9 Sep 2024 11:40:53 +0000 (UTC)
Message-ID: <63c1a3b4-9427-446c-9a68-ae022b7b96ae@xs4all.nl>
Date: Mon, 9 Sep 2024 13:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 05/19] media: vivid: Include <linux/prandom.h>
 in vivid-vid-cap.c
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
 linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fscrypt@vger.kernel.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240909075641.258968-1-ubizjak@gmail.com>
 <20240909075641.258968-6-ubizjak@gmail.com>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240909075641.258968-6-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2024 09:53, Uros Bizjak wrote:
> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> ---
>  drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> index 69620e0a35a0..184460eb356e 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched.h>
>  #include <linux/vmalloc.h>
>  #include <linux/videodev2.h>
> +#include <linux/prandom.h>
>  #include <linux/v4l2-dv-timings.h>
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-event.h>


