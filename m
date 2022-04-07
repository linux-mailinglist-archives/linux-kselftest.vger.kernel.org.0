Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B24F8A18
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiDGVIA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiDGVH7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 17:07:59 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367337A83;
        Thu,  7 Apr 2022 14:05:57 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncZK9-0008IB-T0; Thu, 07 Apr 2022 23:05:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ncZK9-000Gtn-JM; Thu, 07 Apr 2022 23:05:49 +0200
Subject: Re: [PATCH bpf-next] selftests: bpf: use MIN for TCP CC tests
To:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <4da5ff038c442d4421b95580558fc981bb674e61.1649304888.git.geliang.tang@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <95302339-0954-fd26-7020-bb33bed88586@iogearbox.net>
Date:   Thu, 7 Apr 2022 23:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4da5ff038c442d4421b95580558fc981bb674e61.1649304888.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26505/Thu Apr  7 10:25:37 2022)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Geliang,

On 4/7/22 6:19 AM, Geliang Tang wrote:
> Use macro MIN() in sys/param.h for TCP CC tests, instead of defining a
> new one.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Thanks for your cleanup; we do seem to have this in a bunch of places:

tools/testing/selftests/bpf/prog_tests/bpf_iter.c:1195:#define min(a, b) ((a) < (b) ? (a) : (b))
tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c:13:#define min(a, b) ((a) < (b) ? (a) : (b))
tools/testing/selftests/bpf/prog_tests/snprintf.c:86:#define min(a, b) ((a) < (b) ? (a) : (b))

Mind sending a v2 which cleans up all at once to reduce too much churn?

Thanks,
Daniel
