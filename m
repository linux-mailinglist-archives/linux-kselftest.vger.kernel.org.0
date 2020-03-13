Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C710184D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 18:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCMRPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 13:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgCMRPr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 13:15:47 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F2C206B7;
        Fri, 13 Mar 2020 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584119746;
        bh=DKVElybsjLDvAU1zHyX3rQlN2QwCuWEYTxh2dGG82oY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S3EXNcORNhvHYil3IrQUOmh+G4aQjFVNfj+/5coCCPOZEAGFzPS/ZRFQtcmPh9AH6
         ynJBLiSZCIa2l3dgeCF4mXngPhlgzBNz19kAm/2djRuSFgJwG5NdTBG31wdtT76qV4
         J6zZH4XMtE6cskhNhzI1lTgIKRWz8zn39au6Nj3E=
Subject: Re: [v2] dma-buf: heaps: bugfix for selftest failure
To:     Leon He <hexiaolong2008@gmail.com>, sumit.semwal@linaro.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>,
        shuah <shuah@kernel.org>
References: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8613a6fb-1f3f-81e9-54c9-7356ce99cf87@kernel.org>
Date:   Fri, 13 Mar 2020 11:15:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583589765-19344-1-git-send-email-hexiaolong2008@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/7/20 7:02 AM, Leon He wrote:
> From: Leon He <leon.he@unisoc.com>
> 
> There are two errors in the dmabuf-heap selftest:
> 1. The 'char name[5]' was not initialized to zero, which will cause
>     strcmp(name, "vgem") failed in check_vgem().
> 2. The return value of test_alloc_errors() should be reversed, other-
>     wise the while loop in main() will be broken.
> 
> Signed-off-by: Leon He <leon.he@unisoc.com>
> ---
>   tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index cd5e1f6..836b185 100644
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

Please see my comment on v1 for this.

> @@ -357,7 +357,7 @@ static int test_alloc_errors(char *heap_name)
>   	if (heap_fd >= 0)
>   		close(heap_fd);
>   
> -	return ret;
> +	return !ret;

This change doesn't make sense. Initializing ret to 0 is a better
way to go.

thanks,
-- Shuah
