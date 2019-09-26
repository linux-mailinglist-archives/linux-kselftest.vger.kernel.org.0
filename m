Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67CBF7C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfIZRnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 13:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfIZRnI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 13:43:08 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6219A222C6;
        Thu, 26 Sep 2019 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569519787;
        bh=l3u8zwd/je92ZKLnHrcm7WIepO60gLp+qlCHjGnjS24=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cn5kd0QOr/ovpE3xtPCxHwILI8IbDxOcajP93mQxc7ELlAXHNwPlGfV5070/PHb+v
         NKivLFKMgeluA/WEQIpbDWequ+ucHyvqnlVsY/E8lKa5zMrkhPxnfQA0brKTg0K8hQ
         gQUGHyfHOW24j5Tp8Xq78pAO1AeISBW8XaQhHKAA=
Subject: Re: bug in KBUILD_OUTPUT handling - for relative paths in kselftest
To:     Tim.Bird@sony.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <ECADFF3FD767C149AD96A924E7EA6EAF977BD214@USCULXMSG01.am.sony.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1b1e87f8-db1f-f641-45d5-b3e24381d85a@kernel.org>
Date:   Thu, 26 Sep 2019 11:42:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BD214@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/19 10:11 PM, Tim.Bird@sony.com wrote:
> I found a bug in kselftest KBUILD_OUTPUT handling.
> 
> The following works:
> $ cd /home/tbird/work/linux
> $ export KBUILD_OUTPUT=/home/tbird/work/kbuild
> $ yes '' | make localmodconfig
> $ make TARGETS=size kselftest
> 
> But this doesn't work:
> $ cd /home/tbird/work/linux
> $ export KBUILD_OUTPUT=../kbuild
> $ yes '' | make localmodconfig
> $ make TARGETS=size kselftest
> 
> I see the following:
> make[1]: Entering directory '/home/tbird/work/kbuild'
>   make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>   	ARCH=x86 -C ../../.. headers_install
>     INSTALL ../kbuild/kselftest/usr/include
>   gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o ../kbuild/kselftest/size/get_size
>     /usr/bin/ld: cannot open output file ../kbuild/kselftest/size/get_size: No such file or directory
>   collect2: error: ld returned 1 exit status
>     ../lib.mk:138: recipe for target '../kbuild/kselftest/size/get_size' failed
>   make[3]: *** [../kbuild/kselftest/size/get_size] Error 1
>   Makefile:136: recipe for target 'all' failed
>   make[2]: *** [all] Error 2
>   /home/tbird/work/linux/Makefile:1240: recipe for target 'kselftest' failed
>   make[1]: *** [kselftest] Error 2
>   make[1]: Leaving directory '/home/tbird/work/kbuild'
>   Makefile:179: recipe for target 'sub-make' failed
>   make: *** [sub-make] Error 2
> 
> This is due to the relative path for KBUILD_OUTPUT being handled incorrectly (I believe)
> in tools/testing/selftests/Makefile.
> 

Thanks Tim! I will take a look as part of my work to simplify kselftest
use-cases.

thanks,
-- Shuah
