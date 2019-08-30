Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A17A3A11
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfH3PMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 11:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PMN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 11:12:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2BE23407;
        Fri, 30 Aug 2019 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177932;
        bh=8V3NVUeMC2JfI4D6VRgLVlFPa41Ds+EvfqE2GvzzqKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=x6EcA4t1bM+bXSxdaK3uC3DhfynKUEqlncFfHeSiRQH2WwF7W5aeTlsmXY0zxEDDg
         gw8kzBQDDToOkKMgD+D43UY4nQpnMnH0iZczC3a3fEno6awttQTUhVqh9ssK0TD3OG
         v2qPQ6jzlaH5BhEOQ6XtCrNsO1w/yoAJOyQwQa00=
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
To:     "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, shuah <shuah@kernel.org>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
From:   shuah <shuah@kernel.org>
Message-ID: <197ee603-6ea7-a3c8-6b62-e3ba95433053@kernel.org>
Date:   Fri, 30 Aug 2019 09:12:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/19 6:53 AM, George G. Davis wrote:
> Some systems have multiple watchdog devices where the first device
> registered is assigned to the /dev/watchdog device file. In order
> to test other watchdog devices, add an optional file argument for
> selecting non-default watchdog devices for testing.
> 
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
> v1:
> - https://lkml.org/lkml/2019/8/29/16
> v2:
> - Update printf for ENOENT case based on report from Eugeniu Rosca
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index c2333c78cf04..9f17cae61007 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -19,7 +19,7 @@
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:t:Tn:NL";
> +static const char sopts[] = "bdehp:t:Tn:NLf:";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -31,6 +31,7 @@ static const struct option lopts[] = {
>   	{"pretimeout",    required_argument, NULL, 'n'},
>   	{"getpretimeout",       no_argument, NULL, 'N'},
>   	{"gettimeleft",		no_argument, NULL, 'L'},
> +	{"file",          required_argument, NULL, 'f'},
>   	{NULL,                  no_argument, NULL, 0x0}
>   };
>   
> @@ -69,6 +70,7 @@ static void term(int sig)
>   static void usage(char *progname)
>   {
>   	printf("Usage: %s [options]\n", progname);
> +	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");

Can you split this line into two printf's. Checkpatch doesn't like
it.

printf(" -f, --file          Open watchdog device file\n");
A second one below for default.

On a separate note, I wish this usage block uses \t instead of spacing
things out.

thanks,
-- Shuah


