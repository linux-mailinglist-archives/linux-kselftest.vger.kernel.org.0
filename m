Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33442193196
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYUFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 16:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgCYUFe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 16:05:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4542620658;
        Wed, 25 Mar 2020 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585166733;
        bh=KQrQobMfXnFgSLgQMvsALc1syatq3RUPZzn2UmwaMVw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GV5JghfmqxWq3tY+RJacwokQxZRZmQbmJvX4q4IR9JKa+SwqragqcX5Y9e8cMtR7l
         xUOZj63b50DHIQeQTeZeYljtcmpe5aKFwQN3m0tm0/a6tjog6aJmnxYzgMDoAM7kEQ
         rv97ZvcPtzgSJdD3QMYQ96KFBwR3kD8UDDvoVTjk=
Subject: Re: [PATCH v7 kunit-next 3/4] kunit: subtests should be indented 4
 spaces according to TAP
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, shuah <shuah@kernel.org>
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com>
 <1584110682-3837-4-git-send-email-alan.maguire@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <dd82e9cb-6c88-58cf-933e-f2a644e09b15@kernel.org>
Date:   Wed, 25 Mar 2020 14:05:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584110682-3837-4-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/20 8:44 AM, Alan Maguire wrote:
> Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
> and use it to modify indentation from tab to 4 spaces.
> 
> Suggested-by: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> ---
>   include/kunit/test.h                |  7 +++-
>   lib/kunit/assert.c                  | 79 +++++++++++++++++++------------------
>   lib/kunit/test.c                    |  6 +--
>   tools/testing/kunit/kunit_parser.py | 10 ++---
>   4 files changed, 54 insertions(+), 48 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index f7b2ed4c..d49cdb4 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -84,6 +84,10 @@ struct kunit_resource {
>   /* Size of log associated with test. */
>   #define KUNIT_LOG_SIZE	512
>   
> +/* TAP specifies subtest indentation of 4 spaces. */
> +#define KUNIT_INDENT	"    "
> +#define KUNIT_INDENT2	KUNIT_INDENT KUNIT_INDENT

Sorry for a late comment on this.

What's the reason to do it this way? Why wouldn't you define
it as 8 spaces long string?

Also can you please make sure to run checkpatch --strict on the
patches you send?

thanks,
-- Shuah
