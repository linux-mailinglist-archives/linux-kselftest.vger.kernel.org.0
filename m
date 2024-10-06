Return-Path: <linux-kselftest+bounces-19132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC1992009
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 19:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B6E281E8F
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50271189B84;
	Sun,  6 Oct 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="LLYYgAb6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81540101F2;
	Sun,  6 Oct 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236506; cv=pass; b=PWMOdZ6qaplUETHMP2my2hgVXFyyvpDLEI/MCmxeEavWDHwe1j2v7xYihK9d4Aef/2r9IhPqV3dL2rXbmHWuSWEMpZSq5YaTA9Jj3owSKs1LUSV9LLSiA/Cn5TLClkzYIxWUlJVMjvpjTsbnl4hWlsK4XodMlmapZZCtyDxSUEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236506; c=relaxed/simple;
	bh=NfD0HbTfp//JIl3ypk3BzpOdEf/T6/7fF9EVkCyTsnM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dlU2/lzdi4xqQZ7xcoGJWk+/8+ZenXgeUKibj6sl3EbcfusCLx7Xq1PCoMN7TGfcR5t6KVSW7btB82gnNQWV5lzi4EZziqb4VWdLNGB0wTt4W9hd3uZLvGXKyYDCLyfI64GvrDL1eytMAN3pJWz/qRdA2yAia1ubUNLTc0gF7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=LLYYgAb6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728236493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NWQpjLGFLbw8okY/q/XtJcm5NV+AViso+qLvHF42efxumiAu9WvOZhBu3LeH8114qGgG4EHhWxwJ1BctKM4JwDBJ+MQwdndU+ZkWd/qmBpqZt/5xBkj097vYx8OzdB0K0h7ZyUL+jqFXfTzIgdMVLfWCBVe0xypM/G1DM5TAHZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728236493; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A93CjsQnNr0qnT7z0z35aXHoaaCLMjNKIH0I4wSZV+0=; 
	b=d88aQQae7BG2VetwDg8JlZUiCbc6xkUCAwShyGbh+312eOst15NhEarxdUEbA165eZ/+cCrqaHE+Jkykdh1aQJ38DWlDSnq8YggOiMPDc9Qd3zFkFXZ7WQ5G5NaawsWMbxDWnFi308FyGkDdLYNuNBmzYwaWxEG15wbG/r7pbRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728236493;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A93CjsQnNr0qnT7z0z35aXHoaaCLMjNKIH0I4wSZV+0=;
	b=LLYYgAb6cfH6mcii90Asz5ctF2nLLG3A/1wpEfp4+D389C4fdxAc6Mq034GhNdZq
	hd7cKqxG2ae5Mzz2krQ7wC8Reg62sRlGuJvjAuP23Ny/eEHw8m9jODAU/CHW8M81bE4
	Nu+cJJfLQuRZ2ISmYBR6l8r8ZnuIRDEWKwUGlB5g=
Received: by mx.zohomail.com with SMTPS id 1728236491654656.430969093571;
	Sun, 6 Oct 2024 10:41:31 -0700 (PDT)
Message-ID: <bc607fd0-41c8-4603-9f50-4d912dbec6e5@collabora.com>
Date: Sun, 6 Oct 2024 22:41:22 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: make kselftest-clean remove libynl outputs
To: Greg Thelen <gthelen@google.com>, Shuah Khan <shuah@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241005215600.852260-1-gthelen@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241005215600.852260-1-gthelen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/6/24 2:56 AM, Greg Thelen wrote:
> Starting with 6.12 commit 85585b4bc8d8 ("selftests: add ncdevmem, netcat
> for devmem TCP") kselftest-all creates additional outputs that
> kselftest-clean does not cleanup:
>   $ make defconfig
>   $ make kselftest-all
>   $ make kselftest-clean
>   $ git clean -ndxf | grep tools/net
>   Would remove tools/net/ynl/lib/__pycache__/
>   Would remove tools/net/ynl/lib/ynl.a
>   Would remove tools/net/ynl/lib/ynl.d
>   Would remove tools/net/ynl/lib/ynl.o
> 
> Make kselftest-clean remove the newly added net/ynl outputs.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>  tools/testing/selftests/net/ynl.mk | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
> index 59cb26cf3f73..1ef24119def0 100644
> --- a/tools/testing/selftests/net/ynl.mk
> +++ b/tools/testing/selftests/net/ynl.mk
> @@ -19,3 +19,7 @@ $(YNL_OUTPUTS): CFLAGS += \
>  $(OUTPUT)/libynl.a:
>  	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
>  	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
> +
> +EXTRA_CLEAN += \
> +	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
> +	$(top_srcdir)/tools/net/ynl/lib/*.[ado]
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
BR,
Muhammad Usama Anjum


