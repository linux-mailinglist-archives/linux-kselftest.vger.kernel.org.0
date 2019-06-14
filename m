Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8D46CC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2019 01:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNXUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jun 2019 19:20:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:40652 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNXUh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jun 2019 19:20:37 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hbvUj-0008Az-6I; Sat, 15 Jun 2019 01:20:29 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hbvUi-000XyW-VT; Sat, 15 Jun 2019 01:20:29 +0200
Subject: Re: [PATCH] selftests/bpf: signedness bug in enable_all_controllers()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190613070021.GG16334@mwanda>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e81023df-a17a-57ae-854a-5b6e11ffef15@iogearbox.net>
Date:   Sat, 15 Jun 2019 01:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190613070021.GG16334@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25480/Fri Jun 14 10:12:45 2019)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/13/2019 09:00 AM, Dan Carpenter wrote:
> The "len" variable needs to be signed for the error handling to work
> properly.
> 
> Fixes: 596092ef8bea ("selftests/bpf: enable all available cgroup v2 controllers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!
