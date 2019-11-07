Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBBF3BC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKGWwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 17:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfKGWwI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 17:52:08 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298252085B;
        Thu,  7 Nov 2019 22:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573167128;
        bh=eu5ka6ACDTIaItRx6O+SrKq+xkXoDO9zSXD585wQsK0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yv0/OLzZq5Mx2TB9Vnrxpx/WYkc8AbruURfcEkSI3vaMIncalDS1BNpSqbJWcbE9W
         adEh8cSR4bWkMdzwUO6R3emrWLcruDs+6pGIx3mWjuNR6nLaxcKHJRh5RGLsv8WoWV
         /y6idw6TZvWnXTfwUh35RPDjyCTBouPf1jS9jEd8=
Subject: Re: [PATCH RESEND v3 0/2] selftests: fix prepending $(OUTPUT) to
 $(TEST_PROGS)
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, shuah <shuah@kernel.org>
References: <20191024121347.22189-1-iii@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <623856be-1bd3-54b9-6336-fd8daec2dfe2@kernel.org>
Date:   Thu, 7 Nov 2019 15:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024121347.22189-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/24/19 6:13 AM, Ilya Leoshkevich wrote:
> Hello,
> 
> Is there anything blocking this from getting merged?
> 
> 

Please see below:

> This patch series fixes the following problem:
> 
> linux# make kselftest TARGETS=bpf O=/mnt/linux-build
> # selftests: bpf: test_libbpf.sh
> # ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
> # test_libbpf: failed at file test_l4lb.o
> # selftests: test_libbpf [FAILED]
> 
> Patch 1 appends / to $(OUTPUT) in order to make it more uniform with the
> rest of the tree.
> 

It isn't clear what this fixes. In addition, this patch appends an extra
"/"

Excerpts from make kselftest-all with this patch applied:

linux_5.4/tools/testing/selftests/bpf//test_tcpnotify_user

I am not seeing any reason to take this patch.

> Patch 2 fixes the problem by prepending $(OUTPUT) to all members of
> $(TEST_PROGS).
> 
> v1->v2:
> - Append / to $(OUTPUT).
> - Use $(addprefix) instead of $(foreach).

I can't reproduce this problem - I ran

make kselftest O=/tmp/linux-build

This might be fixing the problem in bpf case. However, I don't think
this is the right fix.

I would like to see this problem reproduced on another test first.

thanks,
-- Shuah
