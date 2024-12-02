Return-Path: <linux-kselftest+bounces-22656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E89DFB5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C8B161BBF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7C1F942D;
	Mon,  2 Dec 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="buje1gWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB0481A3;
	Mon,  2 Dec 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733125162; cv=pass; b=h22mw5Kr8kzJJZACnXmi45R00r5C5N10CZ0NAGGRzkl+l/vHmGG9bS6+KjnhLgNWJly7M0++akzrdZ+ycx+YP78c3JgQtZojdRi3CWeSrzNRrWSDUfY0LveP4r4rGMaZnT7YfRgNAsiLQZPhFjmM14B5BztmgH4xVNIB6l1tZ0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733125162; c=relaxed/simple;
	bh=61BP2GUzASsh4S4+wep4TJiD8LUfV+EiTco9XZG6hIk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lNEpOPvxv3LaCvElGIkMSxsf4Y5ms2SL5mv+koDgCLs1HiccoAC2e2zK2xfu6v4h5sKSD+5R9KJ2bzG+yEoW86oWBTB7AqAaNf1ViTHdPebmXmN41TTqATMu+W62jwnmuAQCOQFFOvGAylCYV1JKcK+3ZaktwOE1GDBUIUFcgjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=buje1gWk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733125140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RgKn6VI5uA9ACVsRIzs7TP61Fp7wLVqmT1BfWRLWy5YOPAqtEj4X5cBMz3adZduxZizkCViJqdFIdZdMH9W5XB/SOBGvHcfGwisN0oMq25lEuzClvDwH4sL+kWeqUoNrNS+pRAShVpTKUvyXjxbN5aDNgPZ4mzAmIi6e0Jigwtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733125140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pn0em6wd6SAisHSdrQcweophVQpONURlNTUNeW89LEI=; 
	b=ABKQXrQl5tfQ3Z8i6OFNuBPXfDUQkc713WqPe8f4glpEc6gSmIdaPMCkvELtrtRYYxykx9+xjfxFD95RfmohJe7YPzfouxRqrf1zB8lfPDR+6QAgwxfm/PNn0XnUuOVeBQPZvU5OLj7A73R8O9xde/I3ZDKDUjabM1xJGJZO0e0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733125140;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pn0em6wd6SAisHSdrQcweophVQpONURlNTUNeW89LEI=;
	b=buje1gWkCBucZ6XMpbPx0KedTIoSLb12BrIpSlAs3w2PXtIBY70+fL5zBgXrCSW7
	rHvhFJIOJcPJq4fs6N5JMHfP77xqNNOTrC3KdjUzYHTJeBtX0Y+nn/Znve488iXm6Id
	v7tEix/ECp6uxRh4lVfTJN19XD375pz6OTf68e7s=
Received: by mx.zohomail.com with SMTPS id 1733125139493491.50264494103646;
	Sun, 1 Dec 2024 23:38:59 -0800 (PST)
Message-ID: <124fb122-f5c9-4857-a4ea-5a632ec3c448@collabora.com>
Date: Mon, 2 Dec 2024 12:39:01 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, nathan@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] selftests/ipc: Remove unused variables
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
References: <20241202045827.4704-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241202045827.4704-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/2/24 9:58 AM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Delete variables "msg" and "pid" that have never been used.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/ipc/msgque.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index c75ea4094870..e9dbb84c100a 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -194,7 +194,7 @@ int fill_msgque(struct msgque_data *msgque)
>  
>  int main(int argc, char **argv)
>  {
> -	int msg, pid, err;
> +	int err;
>  	struct msgque_data msgque;
>  
>  	if (getuid() != 0)


-- 
BR,
Muhammad Usama Anjum

