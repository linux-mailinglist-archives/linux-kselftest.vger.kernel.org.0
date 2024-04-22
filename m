Return-Path: <linux-kselftest+bounces-8613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394A8ACCC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DF1F222C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338651031;
	Mon, 22 Apr 2024 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P3gPZ4q4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948D3D3B3;
	Mon, 22 Apr 2024 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789369; cv=none; b=Ka5tQoStCT82uIycUuEokbivpVwbi9sNXVKniL/VPxB0F9CXBiL/gAnTasaTXYVlgOnxOikDI615LBHGNDGb/R9MXgoYBJx3WkRMoCmLUMKyPUSiLNlyhjwFabHgpIEGHbGvh7lwpSShUnOViYaPgSHStzs3sKHZgZ6iCcsrNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789369; c=relaxed/simple;
	bh=bN2M+DqHgZ9izPWJVBySKXP2zEB6NbECifPMiFQFCjg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BY52n0lWnsktNzlMKAogNBramqtKm9wtTNMnWOE+1jRi0PURWdRY4P6YJrEUzMht8LphrIgx7SHkzaMmOFwd36xFfGX5V1MG1LWpFzZ3jSwo0cj+uDzGCEqNuiEO949jpOXhry03y13g28w2JFKeQouF4FCscdRDg23jlLlz3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P3gPZ4q4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713789366;
	bh=bN2M+DqHgZ9izPWJVBySKXP2zEB6NbECifPMiFQFCjg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=P3gPZ4q4iXLYOmYJaGl1rQ0gw5fe8e6v7pgcXKgfyieS8JVat0ycYYGcGyIPZtEqa
	 iunwX3Ouktro/DGnGmoUQVRFb2cB1ez8DIe9FeC650tmw7k5gsktUbPe+NNLfmuZjE
	 43G3vaSjtg4JWT0jrkhBITFuItxFWSSFWQw5Llzx2BB9TdfZI+VUWhlQinh7OfMhF+
	 WD/0SXmwFY8i96vbFIqzTqZMOPyds4QTf1IM6G8bOhHSxDlIndZOfbt93erSG5aaPR
	 OD0XzfXGx9TEP18QX3rSLnP/EygEtNc0AbA8NFqqoawVeSjD3UuOh8rcbuyUx5E0i5
	 B9Sb0xu4p+lHg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B9AA37820B6;
	Mon, 22 Apr 2024 12:36:03 +0000 (UTC)
Message-ID: <f461519b-34a0-4bbc-b528-8a137d833c08@collabora.com>
Date: Mon, 22 Apr 2024 17:36:31 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240414131807.2253344-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reminder

On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
> In this series, 4 tests are being conformed to TAP.
> 
> Muhammad Usama Anjum (4):
>   selftests: x86: check_initial_reg_state: conform test to TAP format
>     output
>   selftests: x86: corrupt_xstate_header: conform test to TAP format
>     output
>   selftests: fsgsbase_restore: conform test to TAP format output
>   selftests: entry_from_vm86: conform test to TAP format output
> 
>  .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>  .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>  tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>  .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>  4 files changed, 139 insertions(+), 141 deletions(-)
> 

-- 
BR,
Muhammad Usama Anjum

