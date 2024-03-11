Return-Path: <linux-kselftest+bounces-6225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF8878895
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 20:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3281F218C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804E54BDB;
	Mon, 11 Mar 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="g0t3iAwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBC56B62;
	Mon, 11 Mar 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184460; cv=none; b=fq5szcaIYCkOxdbiAtM6AbVGnh77JJAW/AI0bVHLgOj7++AY59lEkpJFzDzIhJMyCe2osJXTuJZGy1x7Kw5Q9v+2GTml5zw6ppZxtvqEzTyBN2KO60SEz7r/jWCf3dj2kqd85Nlj9CkC3LTVyT3ohzPdsK9hocaD28X2ur+Qc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184460; c=relaxed/simple;
	bh=JuZL7oM7lKhmmzj290jDyn9KcxNQoNasVDvwUuItmEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzeONZvU/OSPaDCJvA6MXEeaiKK1LChNWx0oGlaaA5DObnZRohw/r5fUhpzaJ4WaYL2PoHhgDZipIMrsptneKCAonx73Kgv211stOt6C4BjclYG53Y1nos3dQ5tdKbKFRMTBZZtDYVdkFvn97+BpR5lY4VYceq3LLBuvt/vf4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=g0t3iAwX; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=FGf/tNhnC4YEzI6MSBG52sbqC4xqonb3q4yeuMw8Xfk=; b=g0t3iAwXXc+OmGjPUCKpaYYxEY
	4e1HCDEJMWgdxdzxOzZscPKhQp6IelAcdS5lyKRoNlSGeNe7jNhCjBUrOq1epQ52eqUd4PdxP3jlv
	0O3BSrwPC7rO9cdIrDh15mVdJOxXnJFotqy1g0XHugt5Z4VMAqYwOZk6ZKbXr72mlSTJ+TxhvTcWj
	rXIIfVlpiXyBXyKp1BrzMhddv8jQdMi83CIZ4A6FHIMIwaNZuIH0cShfzQLoVfpP+fSmVpUgAEANf
	EFjNG4jsJvWOP8zIkvc063waQdkX4PVR0olGY3pypVzFX7MIBJsQNJxWLz4mneduNbb6qYdjtBiqx
	xnlhk1+w==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rjkqo-003cD8-2X;
	Mon, 11 Mar 2024 13:58:18 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 04/31] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Mon, 11 Mar 2024 13:58:18 -0500
Message-ID: <4875514.GXAFRqVoOG@camazotz>
In-Reply-To: <20240219223833.95710-5-zfigura@codeweavers.com>
References:
 <20240219223833.95710-1-zfigura@codeweavers.com>
 <20240219223833.95710-5-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 19 February 2024 16:38:06 CDT Elizabeth Figura wrote:
> +static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
> +{
> +	struct file *file = fget(fd);
> +	struct ntsync_obj *obj;
> +
> +	if (file->f_op != &ntsync_obj_fops) {
> +		fput(file);
> +		return NULL;
> +	}

I just noticed during self-review that this fails to check the result of 
fget() for NULL :-/

I'll fix this next revision.

> +
> +	obj = file->private_data;
> +	if (obj->dev != dev) {
> +		fput(file);
> +		return NULL;
> +	}
> +
> +	return obj;
> +}




