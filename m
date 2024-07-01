Return-Path: <linux-kselftest+bounces-12985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A268D91D7E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34441B21DC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 06:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE941C85;
	Mon,  1 Jul 2024 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1LOkTXUs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD43FE55;
	Mon,  1 Jul 2024 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814381; cv=none; b=inZ1/EimzwrlYcDv8EANXsxdXcncHwosNZyEbGKcDshwHB+fVxgB3exw9W8wo2bN0LimygAeGp37vPXvNTl/W8AFr3K8YPBbdBTv5ELzlSDzzsC2tsAdGrglaHVpGlwyNR8/f/e27cWu///kKjVX3XUGjq4NdD/vqvXH6dUHPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814381; c=relaxed/simple;
	bh=X8iWuQIJuigvsuHlJ9pv/IkeXIiDlnQcCs+cswdftRE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ixEF0TKXZXUDhUIvTwhOfsDFp8FB4Hi42lUMWIdOMdhZ5KjSLRzJbjUBG4Wim128+q2gCUT3ih7n9YnMBlsl3jz+BSgAA8LWPea08xyJGPzWe7sjSpvNADfrGLmwBbOESGfI3DpllCEjAsvTlrgoZoVUsU0IPGgLNCan+whttAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1LOkTXUs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719814371;
	bh=X8iWuQIJuigvsuHlJ9pv/IkeXIiDlnQcCs+cswdftRE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=1LOkTXUsCnme+dnlAqdkEZC+euD+0fsa3VYpyGoq+rN7MKfqG5dL+uAz52o2788xO
	 +K8RLn+Ug8bQHQI/ETuKr0EQCGguBsJTxJxBnlbDFD4Wb9KIcavdW1uobLjCHqFoEb
	 SC4M+kDH3OKCPM8ZLMRT4vh1vOU7wcq36QqxfRc7FZ2Pwhhdup0voTpWeExGPrVxIA
	 i08SzdwFeZ2iaOPRkPOvvwBZXFwMAYTCPZc9Lw1tOfvQWftrjoC1jh6l+Fdl9fqMmK
	 rXtneEcZckXVz5Laxz1DiaDGuHLbfZ7ALR29CMR0OwVa0NnusA6nqpioY7baoMTfFt
	 RsW0WvG1eNdHA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1E0E43782065;
	Mon,  1 Jul 2024 06:12:44 +0000 (UTC)
Message-ID: <bf5c0763-a075-474c-9e65-3bf689ecd092@collabora.com>
Date: Mon, 1 Jul 2024 11:12:36 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org,
 swarupkotikalapudi@gmail.com, amer.shanawany@gmail.com, kees@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org
References: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240630130038.3671507-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the patch!

On 6/30/24 6:00 PM, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checking
> of 'from' additionally.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Changes in v3:
> - Thank you for your interest in our vulnerability detection method. We 
> extract vulnerability characteristics from a known vulnerability and match 
> the same characteristics in the project code. As our work is still in 
> progress, we are not able to disclose it at this time. Appreciate your 
> understanding, we could better focus on the potential vulnerability itself.
> Reference link: https://lore.kernel.org/all/20240510003424.2016914-1-samasth.norway.ananda@oracle.com/
> Changes in v2:
> - modified the patch according to suggestions;
> - found by customized static analysis tool.
> ---
>  tools/testing/selftests/capabilities/test_execve.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 47bad7ddc5bc..6406ab6aa1f5 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -145,10 +145,14 @@ static void chdir_to_tmpfs(void)
>  static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
>  {
>  	int from = openat(fromfd, fromname, O_RDONLY);
> -	if (from == -1)
> +	if (from < 0)
>  		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
>  
>  	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
> +	if (to < 0) {
> +		close(from);
> +		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
> +	}
>  
>  	while (true) {
>  		char buf[4096];

-- 
BR,
Muhammad Usama Anjum

