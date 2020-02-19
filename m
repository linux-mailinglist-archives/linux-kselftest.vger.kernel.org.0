Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F09165256
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSWSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 17:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgBSWSK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 17:18:10 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B889206EF;
        Wed, 19 Feb 2020 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582150689;
        bh=AXnbOh2nyCYDjmRNHp01cqLKWdZnvLDJhpOUR1uau9c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a7CIckuq1biRb27wgRWDNoOXnMDB4iWPaM4U8gSN8tFPj9BxzFDKPJi3wMvAm+jn0
         wrHzvOY7Zz7LszytwFLT4041qxJ8ddHV4FZqmX4RHQlrICpkOlgLQxNzPQKXzomQ1H
         noWT6Qas13+w30P+tFtc+f/rHuR1iKfOEHppzNOw=
Subject: Re: [PATCH v2] kunit: run kunit_tool from any directory
To:     Heidi Fahim <heidifahim@google.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     frowand.list@gmail.com, shuah <shuah@kernel.org>
References: <20200218221916.239951-1-heidifahim@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <be2a28e9-6e5b-37a7-b298-2fef410d3be3@kernel.org>
Date:   Wed, 19 Feb 2020 15:18:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218221916.239951-1-heidifahim@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Heidi,

On 2/18/20 3:19 PM, Heidi Fahim wrote:
> Implemented small fix so that the script changes work directories to the
> root of the linux kernel source tree from which kunit.py is run. This
> enables the user to run kunit from any working directory. Originally
> considered using os.path.join but this is more error prone as we would
> have to find all file path usages and modify them accordingly. Using
> os.chdir ensures that the entire script is run within /linux.
> 
> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for  the patch. In the future please include changes from v1
to v2.

I am assuming this v2 addresses Frank's comments.

> ---
>   tools/testing/kunit/kunit.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 3f552e847a14..060d960a7029 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -26,6 +26,8 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
>   KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
>   					'build_dir', 'defconfig', 'json'])
>   
> +KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> +
>   class KunitStatus(Enum):
>   	SUCCESS = auto()
>   	CONFIG_FAILURE = auto()
> @@ -37,6 +39,13 @@ def create_default_kunitconfig():
>   		shutil.copyfile('arch/um/configs/kunit_defconfig',
>   				kunit_kernel.kunitconfig_path)
>   
> +def get_kernel_root_path():
> +	parts = sys.argv[0] if not __file__ else __file__
> +	parts = os.path.realpath(parts).split('tools/testing/kunit')
> +	if len(parts) != 2:
> +		sys.exit(1)
> +	return parts[0]
> +
>   def run_tests(linux: kunit_kernel.LinuxSourceTree,
>   	      request: KunitRequest) -> KunitResult:
>   	config_start = time.time()
> @@ -130,6 +139,9 @@ def main(argv, linux=None):
>   	cli_args = parser.parse_args(argv)
>   
>   	if cli_args.subcommand == 'run':
> +		if get_kernel_root_path():
> +			os.chdir(get_kernel_root_path())
> +
>   		if cli_args.build_dir:
>   			if not os.path.exists(cli_args.build_dir):
>   				os.mkdir(cli_args.build_dir)
> 

thanks,
-- Shuah
