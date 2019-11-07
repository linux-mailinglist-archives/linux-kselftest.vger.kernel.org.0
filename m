Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CCFF3985
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfKGUaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 15:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKGUa3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 15:30:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B04520869;
        Thu,  7 Nov 2019 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573158629;
        bh=jxP+xUaKqdxNcEtfYnYTit+YHglh3xOWm+cM0Cpa69w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HE7iYd9M5F1Yqbnl+O0NU9+4E2iUuOuG91eAORrb/MGR36jx4J7F5vlW/UdThtwle
         RfqTQctApDuptU7w/nt1ih9X8l7xkCltLwXgK5HQ9pgeEC7/GBOLwn3RWRu32ykHzR
         11PtgSo94jPHVD/ludgynWaRdLzXw6BB5OL8g5do=
Subject: Re: [PATCH] dmabuf-heaps/dmabuf-heap.c: Initialize features variable
 to avoid compiler warning
To:     Xiao Yang <ice_yangxiao@163.com>, john.stultz@linaro.org
Cc:     linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>,
        shuah <shuah@kernel.org>
References: <20191105094029.21213-1-ice_yangxiao@163.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0ec9a9e3-96a7-32e1-ffe6-125321a9fc4c@kernel.org>
Date:   Thu, 7 Nov 2019 13:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105094029.21213-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/19 2:40 AM, Xiao Yang wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>

Missing commit log. Please add one to show the compiler warn you are
fixing.

> ---
>   tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index ec47901ef2e2..5e3eeec299b2 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -154,7 +154,7 @@ static int do_test(char *heap_name)
>   	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
>   	uint32_t handle = 0;
>   	void *p = NULL;
> -	unsigned long long features;
> +	unsigned long long features = 0;
>   	int ret;
>   
>   	printf("Testing heap: %s\n", heap_name);
> 

thanks,
-- Shuah
