Return-Path: <linux-kselftest+bounces-11037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522538D68EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BB1B26664
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86A17D342;
	Fri, 31 May 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L8rqakxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907217CA03;
	Fri, 31 May 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179638; cv=none; b=RlWl/dWnumZ2OxQgR4wLl4BWd2gIRzwG1DPm1JsHB3H1lS8/XOTGpf9HFmD+fMwYi58zG/YK736UFUuKrnbkSBCKxZvDifQ0TB5w/XZQkZnWAW5niTu7DdLNwMAJhVS2IBeSTVoZaOAFoDmDrAXhtC3UOZxN4/wdZwtpNSizn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179638; c=relaxed/simple;
	bh=lWA5De/Nph1YZ1g22EWNzpiguD91rQzN+5CCcZm+bMM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fadfGx0bHOA8smdc4+njsIB0/92kkUDzzFCZ0sq8VdvZJMAaflqYAEIsoEErNbSzqdZxAfE6/mbK+rnT+rDW/fGEIu+mdAJILT3R3D5MahkHaMNrsjrSQP5tY+iNn1tcyc4wFAdOYhPQ7g2gb3eM0aQdmzxhPsIMmfBnHU59vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L8rqakxR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717179633;
	bh=lWA5De/Nph1YZ1g22EWNzpiguD91rQzN+5CCcZm+bMM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=L8rqakxRD+pKp7ESqw4JceYyUmeVQrkEzsJNGlRf2j7RKiQoYgewUBAHg3oluHbJr
	 WGs5BoFE/pH5lxjLJKpt3xwXE7P9i/x8qBw63bx/8lR9C/G8BZHfG07lHa8PQoPO6F
	 GFWqMZbVWNn/vRaq+uC6FppliauEyxAxTrFHV9ptR+96RwhAgsOI18rbXwo3pFblsV
	 gnVlCDSVyhtQXMHciFqFi285CMK6vqdOgfA1Hd/cCFkFbTTv4XTW+71sDZV17Qdfxq
	 iiELmv83MFjvWIJadIxUz0hJ4k3pl4VXTPrd7UaWmVXt59EDZg47f/UVmw6j8bfWk9
	 sss0UDHkVou1A==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 20ED137821E2;
	Fri, 31 May 2024 18:20:29 +0000 (UTC)
Message-ID: <89e07c93-a54d-4cc2-8ee1-664389ffcdd7@collabora.com>
Date: Fri, 31 May 2024 23:19:57 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list: test: remove unused struct 'klist_test_struct'
To: linux@treblig.org, davidgow@google.com
References: <20240531151801.128792-1-linux@treblig.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240531151801.128792-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 8:18 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'klist_test_struct' has been unused since the original
> commit 57b4f760f94d ("list: test: Test the klist structure").
Probably a fixes by tag would be needed here.

> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  lib/list-test.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 0cc27de9cec8..383ee0ad582e 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -1201,12 +1201,6 @@ static struct kunit_suite hlist_test_module = {
>  };
>  
>  
> -struct klist_test_struct {
> -	int data;
> -	struct klist klist;
> -	struct klist_node klist_node;
> -};
> -
>  static int node_count;
>  static struct klist_node *last_node;
>  

-- 
BR,
Muhammad Usama Anjum

