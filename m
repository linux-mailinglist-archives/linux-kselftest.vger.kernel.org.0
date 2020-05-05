Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD71E1C5FE2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgEESRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 14:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgEESR3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 14:17:29 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C2220663;
        Tue,  5 May 2020 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702649;
        bh=oZIhy4uAhQMfRftPSAxXEs0/SUwk5XbjQFCfi1/11+o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fYBbpjo91qL2bwN6FFFUcLIk0cn3McB4ntM5Qt+Rrvckuh/34djzMcYKkrf5Umuym
         G0X2rpkq9+fFecmn/LBEwtxYj2swjIIAPRxsGVdZ0sKb8t7MDrhLmSLSz3PzMON8oM
         9rHKTFfE0VbReNi0WnRWnKbEJI23LGHeGbxhUnCQ=
Subject: Re: [PATCH 0/3] selftests: vdso: Add a selftest for vDSO getcpu()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <fa32cdad-b7f0-caea-3ebb-811f26be85e2@kernel.org>
Date:   Tue, 5 May 2020 12:17:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505174728.46594-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/5/20 11:47 AM, Mark Brown wrote:
> This series does a bit of a cleanup of the existing tests for the vDSO
> in kselftest and then adds a new test for getcpu().
> 
> Mark Brown (3):
>    selftests: vdso: Rename vdso_test to vdso_test_gettimeofday
>    selftests: vdso: Use a header file to prototype parse_vdso API
>    selftests: vdso: Add a selftest for vDSO getcpu()
> 
>   tools/testing/selftests/vDSO/.gitignore       |  2 +
>   tools/testing/selftests/vDSO/Makefile         |  5 +-
>   tools/testing/selftests/vDSO/parse_vdso.c     | 24 +--------
>   tools/testing/selftests/vDSO/parse_vdso.h     | 31 ++++++++++++
>   .../selftests/vDSO/vdso_standalone_test_x86.c |  4 +-
>   .../testing/selftests/vDSO/vdso_test_getcpu.c | 50 +++++++++++++++++++
>   .../{vdso_test.c => vdso_test_gettimeofday.c} | 10 ++--
>   7 files changed, 92 insertions(+), 34 deletions(-)
>   create mode 100644 tools/testing/selftests/vDSO/parse_vdso.h
>   create mode 100644 tools/testing/selftests/vDSO/vdso_test_getcpu.c
>   rename tools/testing/selftests/vDSO/{vdso_test.c => vdso_test_gettimeofday.c} (84%)
> 

Thanks Mark. These look good to me. I will apply them for
Linux 5.8-rc1.

thanks,
-- Shuah
