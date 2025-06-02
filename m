Return-Path: <linux-kselftest+bounces-34181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C89ACBD7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB1618926C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B40205AB9;
	Mon,  2 Jun 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlX5fJuF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4CC2E0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904490; cv=none; b=tmfjkFFYrICIE0d+gCi23ZCHkWwXEvO4eb6Lj35ZtJw48d7+qaWd92gSB0D7mIXrlVW6tpDHt8E1ZkGEte+lmOuyc9FmNM4hj990HR2rlrnUIaZJQoUinXpfWgCVvUdAl33yMg9hMRynxrGN+6LeJX9BkmjmxHevdfrz90xxTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904490; c=relaxed/simple;
	bh=dV8jNwoaHn3pYzAQqE0xKwHO/o+oj5FSIrvUimpRDk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8qn2Oxu9+Lrni9Ltn41/VJytdDaCaoDXxZkY9jWGYht7UdmiG1w7LxZFe/zct0/yfs5Rg0ksrWWer260YmAw6R/mz3qoJmZo17kAgU+RS/zKPQXsT/jWBIBvbKsbQX3sxynAWlLSfgr6/vqNM7ZV0H+e8tPRgot/RHojhGnSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlX5fJuF; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86d00ae076dso93747139f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748904486; x=1749509286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0MPRxC3zSKa9lUKC3PPGWxNiqxgy6DGxhs8CNtCqjc=;
        b=AlX5fJuF8oQq+andlgeBt8tco6K++GKywsYfAMFGdEjTcqBFRqqcl9NwheZL20K1rl
         OKiZzVrYlzq096E+6tNrnTDQ4dP52A6bmT2kkAeWTR7JQUHICFNSYxe2ekdcZ17Uh6+N
         A+sK8OY0cWbG+kN4Du++HEpuexgJ8EfyyyuyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748904486; x=1749509286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0MPRxC3zSKa9lUKC3PPGWxNiqxgy6DGxhs8CNtCqjc=;
        b=wH1Diz8H+dh/o7+tQ4MkW36Bh1sZO+tfBC87z+ez7yJOopOIp+fU6Nn5ZkA2BqKKYd
         C2mmacTON5nwueVtc9C8KdNz2neTdPW2iIULre0GwINglLKdr11tsb5d4XzTH+wXkkoG
         DK73bdCW13u84A6WjffzcmbNR4L2g7tZHLxZq/kN611ptkItXGXQDrGmjZ51tTXlmDrM
         5QOULL6mxyusgkr+P9LD8oDv1FVB+yNbPhMhhwcd4AiUbkTlIA1SzmcjgrGkba4l7oWu
         qrIvCaHqXW3/b2E+g2spbTlHbtlLos9haUvXdnsqgwpZqZsdE7tzqUDhwnu8Wdf1YT1m
         nGQw==
X-Gm-Message-State: AOJu0Yy/++OQ0Rhw6NPRGxtDrmDoIc2sgLJBfFrheZH3jg6GVQlyW3X9
	mwcMYoJxsHg8vJUdFFJ31QLtJ4sltC2VLEi6Y69TBfW65tXnlSxePoyv0upYmE3SJjU=
X-Gm-Gg: ASbGncvBzO1X36R1KDii6gHg9xsgXx/qKKjBYtZb5pZ+wpZBnWWfc9p7Odhqhi1r0ir
	2yCleUVhIBWlb89XZtbWFv3TqytkNFonOk/g25XzblgB7UwdPCXefiW1cB1yP/jBAaPBepseSVJ
	0aah8Y8w99RWOQ1EjOBNfIvha2Bkejrv6Sooa9Bt3n01EZrWSxgjhqRucqCD71/e1N1UDaiLFa+
	pA6GzyMh9RbAYQJRZjjP6Qgkayl+COuhmmtCqJI5a5gOWQRGoTecV0IZe/1PVSV0Ef4SzxVrerJ
	BaxoQvjPfJajWhWxuVB8TgEYCdZEG9Ju4lgrH4cAKcMcpu4sti3HEHynqNoLdg==
X-Google-Smtp-Source: AGHT+IGcqPQ6Br4YkdnS67IYJqV4bo0xOj2HBlD5gFqWwiSIyNPUyz3F+NvBmsbbGyAdNmOLbKGGBg==
X-Received: by 2002:a92:c26e:0:b0:3d4:2ea4:6b87 with SMTP id e9e14a558f8ab-3ddb79ff68amr2712545ab.11.1748904486155;
        Mon, 02 Jun 2025 15:48:06 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd93546c38sm22951685ab.38.2025.06.02.15.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:48:05 -0700 (PDT)
Message-ID: <4a28c302-b37e-4963-86c2-87c5793c2661@linuxfoundation.org>
Date: Mon, 2 Jun 2025 16:48:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add version file to kselftest installation dir
To: Tianyi Cui <1997cui@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250529003417.468478-1-1997cui@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250529003417.468478-1-1997cui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 18:33, Tianyi Cui wrote:
> As titled, adding version file to kselftest installation dir, so the user
> of the tarball can know which kernel version the tarball belongs to.
> 
> Signed-off-by: Tianyi Cui <1997cui@gmail.com>
> ---
>   tools/testing/selftests/Makefile | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index a0a6ba47d600..246e9863b45b 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -291,6 +291,12 @@ ifdef INSTALL_PATH
>   		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>   			-C $$TARGET emit_tests >> $(TEST_LIST); \
>   	done;
> +	@if git describe HEAD > /dev/null 2>&1; then \
> +		git describe HEAD > $(INSTALL_PATH)/VERSION; \
> +		printf "Version saved to $(INSTALL_PATH)/VERSION\n"; \
> +	else \
> +		printf "Unable to get version from git describe\n"; \
> +	fi
>   else
>   	$(error Error: set INSTALL_PATH to use install)
>   endif

Why not use "make kernelrelease" to get the version?

thanks,
-- Shuah

