Return-Path: <linux-kselftest+bounces-38926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CBCB25955
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 03:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DF25A47D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 01:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E341238166;
	Thu, 14 Aug 2025 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBsIxElx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242A231853;
	Thu, 14 Aug 2025 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136698; cv=none; b=udNDMMAG38yZhYQUiT/NFcd2GpMoDpX4tHXz9KwYV8J8Ad+rGUIvYsfzO54rE7lns5CeB9dcl8mFGZ6c6/zEKne/ecSXp1S1kg+YA++lUf50Iw3sKYamvSkcErD3yCH3wCn05Peh166Paly682oykySCVY62uTc1DVr2Gee2H8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136698; c=relaxed/simple;
	bh=q2SGHb3APxGdMTmDmItq4Pu4zI6iiexqPHr9lgOY3DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ej5YkK2itbnWaz+D0jLsJ9m6VGSg4JeKvQjIHtA44XTrpWXFDjftlpcMH5YgH8ukvf2r2sRMGPlZSoUiafRTJf3H4PK5OitYIeZLqgmv806dkibF0t31+3TKAZh8bldr5k2JQWsw5VZXsaYvBQJh93f5T4JtC10pa1Vvnj4FQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MBsIxElx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OULRM4aV2FRJFBE1gYMM0RJzh8b5jot7eoMGHtiCmGA=; b=MBsIxElxqbQMTdHrM6BcYWZ0+4
	xcO7DUvbQHekl9JU9h0eEA/acArYZO0/c65dzpp7XBIumGFJqNYBpC68WOoKvWn8IZIeSjwbcvBQ2
	Bfaag3Z/VQZqmKIdoz8T7OV2W/PKYme6DAPAtt1HIM13lNWvbZlyTRIuKd/2SKxU4kh81c3L2Zo9P
	ytGu8bkFzPSKdQik9vbNYDAyKncI1gQIZTZJZzS79qYzN8z0qPjP/j8tp/WRh5RcgeYOHEr6tvUsD
	fEAyXRTq8T+QfnRyP/OFBEYNw00YCRTnHjkdrpGp0T3hcQRPDyabtEoq9K0FC8+lYi3DwHYZ+35aS
	iRTcK5Xg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umNEL-0000000FXu6-0gjV;
	Thu, 14 Aug 2025 01:58:13 +0000
Message-ID: <98ed6868-8030-4d10-b66d-c7e3d42886f8@infradead.org>
Date: Wed, 13 Aug 2025 18:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Documentation: ktap: formatting cleanup
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>,
 Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Tim Bird <Tim.Bird@sony.com>,
 Rae Moar <rmoar@google.com>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814012046.21235-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

For both patches:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

but I have a process question, I suppose.
Why send this patch series to the workflows mailing list?

(This is not the first occasion of this happening [by other people]).

Thanks.

On 8/13/25 6:20 PM, Bagas Sanjaya wrote:
> Hi,
> 
> Just a little formatting cleanup for ktap docs (actually only bullet list
> items fix in [2/2]; the first patch is trivial spelling fix).
> 
> Enjoy!


> 
> Bagas Sanjaya (2):
>   Documentation: ktap: Correct "its" spelling
>   Documentation: ktap: Separate first bullet list items
> 
>  Documentation/dev-tools/ktap.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 0bbc2548ea85e6bda835a08c6d47d46435945cda

-- 
~Randy

