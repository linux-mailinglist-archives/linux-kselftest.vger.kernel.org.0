Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAB1592D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgBKPUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 10:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgBKPUS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 10:20:18 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F49F2086A;
        Tue, 11 Feb 2020 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581434418;
        bh=Be6Zsbal8nGWhLXNcPwHMCsqIgYS3+azBCOwQNEdmPc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=zUHhURWQCUBRmuutm1dzvilmd3/emPKY+MziJgo3D7+JGOkdiwk6WWGndFe5kN+Tq
         iglQpVXrmMVxKRdsVygBI6f4CUMqqCHEntsT8lqtT+8t/jMCRRSE2qRMPQ7cKyteka
         s1U6bGyNVWGo4EgneWMVuvyn5vjB4OxTR/o5tieQ=
Subject: Re: [PATCH] Removing a duplicate condition.
To:     Isaac Young <isaac.young5@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200211113257.451781-1-isaac.young5@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3bace0e9-7ce7-aaea-9a6c-3949a6e52a08@kernel.org>
Date:   Tue, 11 Feb 2020 08:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211113257.451781-1-isaac.young5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please include subsystem and test name in the subject line.

On 2/11/20 4:32 AM, Isaac Young wrote:
> Signed-off-by: Isaac Young <isaac.young5@gmail.com>

Missing commit log

> ---
>   tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> index 098bcae5f827..0954c7a8aa08 100644
> --- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> @@ -823,7 +823,7 @@ void test_select_reuseport(void)
>   
>   	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
>   	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
> -	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)

This might not be the right fix. I think the check should be
if (saved_tcp_fo < 0 || saved_tcp_syncookie < 0)

at least makes the most sense based on the code.


> +	if (saved_tcp_syncookie < 0)
>   		goto out;
>   
>   	if (enable_fastopen())
> 

thanks,
-- Shuah
