Return-Path: <linux-kselftest+bounces-7394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD0D89BE99
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238371F22295
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE56A32F;
	Mon,  8 Apr 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZTtdS40X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912865BAD;
	Mon,  8 Apr 2024 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577861; cv=none; b=FvnOS7YIb6N8mgVG5urG2dI9x4KFGnl2HkEnSBcfszkurqk7nXLayQMCVu57mcV6ZKdQr/R/pElflGWHeX5j52d68o8g2hQeZu8qq+S1p9xlJUW/ta6sEQG7tDGrDZzLqnDnNO7GBUKZ4/fFmy6QdRcHWtOZ2GXTr2MX2ICtN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577861; c=relaxed/simple;
	bh=0ZKNyQdKBROVhYNVqucQYJL92ZoOSW1dLVeb4QPSfKg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=opZJE5igXthY66ozWxdHfqLS7NWTvfhIyM7hLpJWx1x6bwgN+2hGZc0zxftNbUYvAsNmx6Mhb8Wp2DaiQOjBqg8tm8DA5KFT0OVU52GvrlyuRiOmlWGftJr8NRszKf1snwGSI6RE/Cd9CHkagz1gb3Y6jv7xjuMpqRRdE7b+xHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZTtdS40X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712577857;
	bh=0ZKNyQdKBROVhYNVqucQYJL92ZoOSW1dLVeb4QPSfKg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZTtdS40X29dqKTIyheUlr8HdjyRLHTd7PL7GFZvvGqGFolZFvoWOVChTwJPhklG/4
	 oyoMx2UjY/WKW7JwuJ2o4Fgy/0G7RMQRkQcwzzUT/zes8BgJbOcG1KyTVFj+1PeU++
	 uu85JxMf7WsQIk6FPK13vs6cRwqDvgtfenJo+Tsceuw3tZih+2lzl/W6ioxw50CHZk
	 tf3bj7R+wCEY3NFES896wHAmbPsTaGXq2Gj1VJcolcH+KqqGTtvDF8bvqK93rHqHZB
	 zzRPzQGeoX4TreiCwFNFr3eXZ8F+0pzJYNy4Zvih9yfnosVCNirpyA9pNsO0wD8u75
	 hu9g6WUPJaOFA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E397E37814B0;
	Mon,  8 Apr 2024 12:04:11 +0000 (UTC)
Message-ID: <4bae7682-801e-498f-88c9-9c9d45364bfc@collabora.com>
Date: Mon, 8 Apr 2024 17:04:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids
 controller
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
 <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
 <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
 <oosadt3f5i3qsvisrxe6hrs46ryfqbyxyk3a6jimd7cqczjtcw@dvlsm7eh3b6r>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <oosadt3f5i3qsvisrxe6hrs46ryfqbyxyk3a6jimd7cqczjtcw@dvlsm7eh3b6r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/24 5:01 PM, Michal Koutný wrote:
> On Mon, Apr 08, 2024 at 04:53:11PM +0500, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>> ksft_test_result_report(tests[i].fn(root), tests[i].name)
> 
> $ git grep ksft_test_result_report v6.9-rc3 -- 
> (empty result)
> 
> I can't find that helper. Is that in some devel repositories?
Sorry, I always do development on next. So it has been added recently. Try
searching it on next:

git grep ksft_test_result_report next-20240404 --

> 
> Michal

-- 
BR,
Muhammad Usama Anjum

