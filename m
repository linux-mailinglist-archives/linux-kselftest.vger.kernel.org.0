Return-Path: <linux-kselftest+bounces-8669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8688AE043
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B2D1F21BBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C056B9D;
	Tue, 23 Apr 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rUPopUxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A5320E;
	Tue, 23 Apr 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862174; cv=none; b=EGAVaqx0aLoNCjex2hQq1twOQBzKgaRsNwjo10/3FmeSAVDKI/HAxoi2EO7L/8fVwAIHcirC4YE4QAE/ZQISIbFzCzEVmlkC3QKnZhBTcatWyrLKUcS3ulm6QBlddMIrqafnd3H1jqNHsoqXUUs/UFJ4tQbgdetgPavubmhaa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862174; c=relaxed/simple;
	bh=6/vUskkjXBSmbcUaFdA4C9ObD9hupo6oExR69oZ9qF8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=onDZFtaTk5oieucO6C7FJh/HE931JBqcC9mxHzA4YxkzhCIfJi01nhsn7IrRKwiE1Kk2x4eCffrQYGsF0UnZRQTd+PP4PsirqKWlQh4bI6OckDccq0F7mZMkRgg6CG0lgAHFkqrd+6mFFi//EqkQQcSkjkx1eKtyWM59pejgJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rUPopUxp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862171;
	bh=6/vUskkjXBSmbcUaFdA4C9ObD9hupo6oExR69oZ9qF8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rUPopUxpix3KnYCdyuoaaaVitsuJiQdIMSsjqZ4ViiKs+AvYkESibS7Lt6Twd1Knp
	 KtEIQp/Lw/DW49tq7SQW9HevBvkym+ZCgGbri9faDSNDGIAimnkYM2llcXDan4nFbg
	 CB1S1aFVOIW07tsXlDNWs5uEcI+NTXlxmkFwNnat5g8Wcfp5QjEFHksH3GGXU8rI0o
	 dRr0bnYWGpuVYLJXsxYraja73NZ5jBw56d0bfSOwRsXgDgdpTjgsHkxa6N7TPckAKX
	 Oz2N7/TwuD+fMRiCYU2BC9hFElcyRgvj4Fe9Cx5PNLpY4hUcUpbQYq7311FwVGj3tX
	 KfQGOK5Ap0AHg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F4593781183;
	Tue, 23 Apr 2024 08:49:27 +0000 (UTC)
Message-ID: <981053d8-c67a-4958-9016-5f19c7884459@collabora.com>
Date: Tue, 23 Apr 2024 13:50:01 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in config_name
To: Kunwu Chan <chentao@kylinos.cn>, kunwu.chan@hotmail.com,
 pbonzini@redhat.com, shuah@kernel.org
References: <20240423073721.2001016-1-chentao@kylinos.cn>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240423073721.2001016-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 12:37 PM, Kunwu Chan wrote:
> There is a 'malloc' call in config_name function, which can
> be unsuccessful. This patch will add the malloc failure checking
> to avoid possible null dereference and give more information
> about test fail reasons.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index 91f05f78e824..22398696ffd6 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -66,6 +66,7 @@ static const char *config_name(struct vcpu_reg_list *c)
>  		len += strlen(s->name) + 1;
>  
>  	c->name = malloc(len);
> +	TEST_ASSERT(c->name, "-ENOMEM when allocating config name");
>  
>  	len = 0;
>  	for_each_sublist(c, s) {

-- 
BR,
Muhammad Usama Anjum

