Return-Path: <linux-kselftest+bounces-24768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56AA1675D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B51662CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0431865E2;
	Mon, 20 Jan 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="ff7SyRVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697F481CD;
	Mon, 20 Jan 2025 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358270; cv=pass; b=BMweKur0NUIn5E1JDXybxCm79Hy4h4+IKK/iCgdmhd+H++uDaXhcDuFhYvCuZ+R3voyylUQsYuI+bezmhG+HGXmfLlj8beWKB0q3iFO1qoB0J61FWyjx3EEBLpnZOFG9Y+FIsxx67llkvHiP53MmNRGY04zxBhmMKsgBNlioZlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358270; c=relaxed/simple;
	bh=al+xlw43j8Y2mPF1n6V51mVC0Qr6Oam/tZ0JS6bY/9s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DMqUAlMrYC/7BgV+8XEn7GZOdwg53r6dDrHmMc3c/B6VWrzw/Bo9KJh00QXQCNORho2fc7TdT/CvSTcehAcU/JyId7KCu1QvQ8jTVxnEVzdExFkGm3Cd7Ha2sEOorW+0PvlGMSPhvFDL58dBGZnvv7NhpOKdMMvwlKhDCaWS3X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=ff7SyRVQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1737358256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4PYzYrGNvRAZ2YjHs+jdsTlvERDq9QCXzm8wJW4VYeYkW33BiA+aEqNtbtRft8/nG6LZqNc8XbuY5UShrDp/iFGAG1jo4U0+WH2EDKRYX3BiTl4Fu4tVdQtwkDUu7IUd/ZWrELes34GM9Z+C9tz8iVTbAK2ybAkyV0ZOlzimBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737358256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QlvgLFwRRoClGPLIHJJo9Quhclrfr/hiTDD18T/O444=; 
	b=ipP3CoNLRo4r6lywIWKT/wW6OK3zGWrQEGF5zYI3BzS546wXW5ZSe/hrAqiBV1WJH5rU4gnI6BY57kP/6HCdscU3zVDyekRvm79TLevxThh++Ip53u9W/Pp8DwmIsJNYE/Yazvhc9EhGvXKktf7Dy0v9LJJhokrRkg1rBdINqfk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737358256;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QlvgLFwRRoClGPLIHJJo9Quhclrfr/hiTDD18T/O444=;
	b=ff7SyRVQjNXxD22W3AB4k2NumvWByzO/JyZQ25Lbht25MAqRqPH+1B2s+bHzGi3o
	jh4JttqXeCtFTpeiZS7Xy2JGyi+9CPt9+Y15QlX5sWNeJZtYGFR2kzkv1bp3Az4VlQC
	m5PSgC8v6aEFnyih9K2Fa8wKR3mY86bIiBWN+oEQ=
Received: by mx.zohomail.com with SMTPS id 1737358254028920.6291236623549;
	Sun, 19 Jan 2025 23:30:54 -0800 (PST)
Message-ID: <e4549965-bb0c-4b46-b796-265704290e42@collabora.com>
Date: Mon, 20 Jan 2025 12:31:22 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, amer.shanawany@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/capabilities/test_execve: Initialize the
 variable have_outer_privilege
To: liuye <liuye@kylinos.cn>, shuah@kernel.org
References: <20250114054129.73331-1-liuye@kylinos.cn>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250114054129.73331-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/14/25 10:41 AM, liuye wrote:
>     Uninitialized variable: have_outer_privilege.
>     Fix it.
Please improve the description. Explain how the current code
is wrong. After that add:
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Signed-off-by: liuye <liuye@kylinos.cn>
> ---
>  tools/testing/selftests/capabilities/test_execve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 47bad7ddc5bc..c9617b38d6f7 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -83,7 +83,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
>  	uid_t outer_uid;
>  	gid_t outer_gid;
>  	int i, ret;
> -	bool have_outer_privilege;
> +	bool have_outer_privilege = false;
>  
>  	outer_uid = getuid();
>  	outer_gid = getgid();


-- 
BR,
Muhammad Usama Anjum

