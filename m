Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4716329A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 21:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBRUIp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 15:08:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41958 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgBRUIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 15:08:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id j11so11123940ybt.8;
        Tue, 18 Feb 2020 12:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GA0KuIfGABhOq0CUZZFDmrHlxV/p9BLpPzwXbBYkT6w=;
        b=VH+/6iyQaWXpOVM/tksOiDfVtqV+g3zIewTJ3+yv5g79algXW8S4fAiRQTZIf57bWT
         bc8azjUHSpQI6aQnkQcBbk+V6+0wKC97Tq2d4lMHVT3ynMip6mu8r1TPZwdZ9SJ126qv
         C4RsYJtMpMxz9RKof7t/MZ/1cDhSe1czy1msd0E4mJTASIyJ/Y6pOS2s8W3xcQJ/ZMIE
         SFfu2qiOyBcNTfFBBk9vsxxZUQahY0GPZF+GscB6WSOadwxM7ptUpxkgK6eI+xemycfZ
         3Rq29xowj1BJST62mg5Nc0/pzQk5iNIbN5k1jWN6unjzn+0nKNQS0txBaZJ2EmqoT65e
         qwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GA0KuIfGABhOq0CUZZFDmrHlxV/p9BLpPzwXbBYkT6w=;
        b=Sb1f+y5t9fDJeZOsZ8YziHPcuXpFrRHP6N72x/uO59jDi3TlZwF9uxGcUyIvUFKynO
         Dgl94bdza/+fmY+Tiv1IhcAQ4FjnXkSj2JBLEFAk2T23kXiZPxZB/anw1NtgUrJlGJoH
         8p7NRg7P2751dFnMy9BOXEMkgqXmQfq9tCR3iKpdPyaTHeMMU8WeemjKUyIkl5xj01dE
         O5nWG4Jy1hqQcPfLWl3fY2M1NMNpRgS++1/fjgjm3jKFZIqB6Ouh4wELLcM+ftjxiw+S
         lKMHjRobCSfMLSnMTzXbuP2mIgiGDdJZQ5AH3Hv3mhr4Z9fAgQAks51GpRvzJ2Mx++Hp
         o9Yw==
X-Gm-Message-State: APjAAAW4fbFf8eWOq/2yMf71J0YzlI8ihogbnzntgqTMBXfNSyulIutl
        0tErqxqaMDgD7hZW/Ykx0I4=
X-Google-Smtp-Source: APXvYqwsgI1/m4hK5XA9ufQQDhlO98Nwo+hZt7ulEb9S13r2CWPRmPLWGn4TlXMK/CH9hSyhJu6a4A==
X-Received: by 2002:a05:6902:4b1:: with SMTP id r17mr19257720ybs.38.1582056523819;
        Tue, 18 Feb 2020 12:08:43 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id e63sm1933970ywd.64.2020.02.18.12.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:08:43 -0800 (PST)
Subject: Re: [PATCH] kunit: run kunit_tool from any directory
To:     Heidi Fahim <heidifahim@google.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20200211002551.147187-1-heidifahim@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <757222d7-ab88-8298-2ff1-2ea8b2fafadf@gmail.com>
Date:   Tue, 18 Feb 2020 14:08:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211002551.147187-1-heidifahim@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/20 6:25 PM, Heidi Fahim wrote:
> Implemented small fix so that the script changes work directories to the

> linux directory where kunit.py is run. This enables the user to run

s/linux directory where/root of the linux kernel source tree from which/

The existing wording implies that the cd is to .../tools/testing/kunit/

-Frank

> kunit from any working directory. Originally considered using
> os.path.join but this is more error prone as we would have to find all
> file path usages and modify them accordingly. Using os.chdir ensures
> that the entire script is run within /linux.
> 
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> ---
>  tools/testing/kunit/kunit.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e59eb9e7f923..3cc7be7b28a0 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -35,6 +35,13 @@ def create_default_kunitconfig():
>  		shutil.copyfile('arch/um/configs/kunit_defconfig',
>  				kunit_kernel.kunitconfig_path)
>  
> +def get_kernel_root_path():
> +	parts = sys.argv[0] if not __file__ else __file__
> +	parts = os.path.realpath(parts).split('tools/testing/kunit')
> +	if len(parts) != 2:
> +		sys.exit(1)
> +	return parts[0]
> +
>  def run_tests(linux: kunit_kernel.LinuxSourceTree,
>  	      request: KunitRequest) -> KunitResult:
>  	config_start = time.time()
> @@ -114,6 +121,9 @@ def main(argv, linux=None):
>  	cli_args = parser.parse_args(argv)
>  
>  	if cli_args.subcommand == 'run':
> +		if get_kernel_root_path():
> +			os.chdir(get_kernel_root_path())
> +
>  		if cli_args.build_dir:
>  			if not os.path.exists(cli_args.build_dir):
>  				os.mkdir(cli_args.build_dir)
> 

