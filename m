Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28826184C0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 17:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCMQKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 12:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMQKX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 12:10:23 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8CD2072C;
        Fri, 13 Mar 2020 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584115822;
        bh=B47v85trEWvjV/lzKS2P3e07BiG8jYMtvyGlf1skrfw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=seaW/ZYd0aXN5SgqyFlnl4kSLtqoDKP8TliSQ3i0Q53m4sCK1YU8bJ1a6qlGaHr4X
         BrZee8SEmHmW8x9xOjqxZVr0dfAmp4VOxRChmKuYj1Khu6nkenoj1K0KEWcFg15I3P
         lcd/h45POIXuc49iOEqu8SdveQ9M50HQzZUsJeOU=
Subject: Re: [PATCH] dma-buf: heaps: bugfix for selftest failure
To:     Leon He <hexiaolong2008@gmail.com>, sumit.semwal@linaro.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>,
        shuah <shuah@kernel.org>
References: <1583300076-28392-1-git-send-email-leon.he@unisoc.com>
From:   shuah <shuah@kernel.org>
Message-ID: <9be2873c-79c2-2d02-f15a-1e6e0ff7e898@kernel.org>
Date:   Fri, 13 Mar 2020 10:10:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583300076-28392-1-git-send-email-leon.he@unisoc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/20 10:34 PM, Leon He wrote:
> If the 'name' array in check_vgem() was not initialized to null, the
> value of name[4] may be random. Which will cause strcmp(name, "vgem")
> failed.

Nit: "to fail" instead of "failed"


> 
> Signed-off-by: Leon He <leon.he@unisoc.com>
> ---
>   tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index cd5e1f6..21f3d19 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -22,7 +22,7 @@
>   static int check_vgem(int fd)
>   {
>   	drm_version_t version = { 0 };
> -	char name[5];
> +	char name[5] = { 0 };
>   	int ret;
>   
>   	version.name_len = 4;
> 

return !strcmp(name, "vgem");

While you are at it, why not change strcmp() to strncmp()?

thanks,
-- Shuah


