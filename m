Return-Path: <linux-kselftest+bounces-17625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EC3973E56
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB3286468
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FD1A255E;
	Tue, 10 Sep 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MYo1X4XB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222194A02;
	Tue, 10 Sep 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988408; cv=none; b=QWvx3BY81s5G0nxBDC6mjzh8uKlgrF/wl1tjza6xdp9NINE76DKVaQo2pduq3Mpq8gP+xX8M1WkBHwqCTg5KpBjwjob6Ic/1WnDJ4Ttk74oFjKY3IXp7nzamkjYY0C4XBmeL9XUdU3xRF8S3NRSWZ3i/B0dHKPQ280jfhdEZRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988408; c=relaxed/simple;
	bh=UebbCIcS/AqcSgOcs7SmG1zfsdWUr54cggHyV3w3J54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJliZ8bZF+MZ0rfkgXJY9Iob1lMiRUoybxz8KWvLmiqTYW9dXmMCLuTVKqMFrb4Cy0aENGmkxhIcgirQEPO8wriOVYCiAP5NcTO7tObpZl3suSOkjzGUCUzIPXKVy/DhnMSXf14AGirojIa92Lo+lgEQzyvMZogsP0YHeHo+rqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MYo1X4XB; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X39Jk3hpPz6ClY9D;
	Tue, 10 Sep 2024 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725988399; x=1728580400; bh=VhmV9oFSRsxf1YqVbemrPn92
	eKvNnqMS4KCaVT2K6OM=; b=MYo1X4XBYoXLUfKyol0i8lFTKOk2NaIWDRTxGCNG
	uKoOnMI5w0U/6b5FFZd7UDUCiRVlwq3oiJI1zW7xRRP9uh6nBg+9sKN2B77TnJlD
	bK/HawOGs8m00YgCnYQArT/y/BXi0U3IF9GyHWceEUD4s7nvcfCoTduzTohYzQd1
	T5zxUZJzoANEJAm5mOx4eOC1GzXwU2EPY/98crXPajt9SMVhFG6BlrjSLBNXDaBL
	fQB2LsOA4sytKDzRLjEV2g0NCquB8k+r9wdP1omWTldl+WHfRRwrP7Snlo6Cfdoc
	jD3Yx88NwPaTj5WXKdkwZwp7VMrPnTzVXqyqTshgUDsmaQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tJodp6nfa-sQ; Tue, 10 Sep 2024 17:13:19 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X39JZ1wvqz6ClY97;
	Tue, 10 Sep 2024 17:13:18 +0000 (UTC)
Message-ID: <7ea6ad5b-a569-4f0a-8fc2-fd66bff19387@acm.org>
Date: Tue, 10 Sep 2024 10:13:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 08/19] scsi: libfcoe: Include <linux/prandom.h>
 instead of <linux/random.h>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
 linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fscrypt@vger.kernel.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
 <20240909075641.258968-9-ubizjak@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240909075641.258968-9-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 12:53 AM, Uros Bizjak wrote:
> Substitute the inclusion of <linux/random.h> header with
> <linux/prandom.h> to allow the removal of legacy inclusion
> of <linux/prandom.h> from <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> ---
>   include/scsi/libfcoe.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
> index 3c5899290aed..6616348e59b9 100644
> --- a/include/scsi/libfcoe.h
> +++ b/include/scsi/libfcoe.h
> @@ -15,7 +15,7 @@
>   #include <linux/skbuff.h>
>   #include <linux/workqueue.h>
>   #include <linux/local_lock.h>
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>   #include <scsi/fc/fc_fcoe.h>
>   #include <scsi/libfc.h>
>   #include <scsi/fcoe_sysfs.h>

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

