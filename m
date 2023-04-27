Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAD6F0D54
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjD0Ui4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbjD0Uiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 16:38:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA33C15;
        Thu, 27 Apr 2023 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=mb+mw9RoqPzSHwk13zdaZsc81X0xQJcY8tYM6v4FHUI=; b=IJYieqMbLLhnFwjYIv3DzoJbc6
        w/TidPHt60tuVQEEqr2cd6v1r0PgUuRcEGqsd5mmjkhtUxKBI+bRystWAwkyNBgHUWnF/eScr9Y1D
        NUFJjXWNu0P+iFi3KSriG6s92Hs7HbV+W6GKOKq89rnxvBCa1RK18Wp/YKF6orgZz+N7SRi5Bztl3
        JdTCK7zs1vA00180MS5iE3vhv4mAFhqt5zHIgBaCaKf96yuXanhbB6jkHLhpqZtboKduPUu8sHk8R
        P1OlEVE9sL9+XsUtmh4QkdM4ghZlhzBJAbQ/3POrDxAABHgDZ9AHYPISto+BDensactLlt7QlGYcF
        acSlnwJQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps8OB-00019O-KX; Thu, 27 Apr 2023 22:38:51 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps8OB-000VKx-9i; Thu, 27 Apr 2023 22:38:51 +0200
Subject: Re: [PATCH v1] selftests/bpf: Do not use sign-file as testcase
To:     Stanislav Fomichev <sdf@google.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
 <ZEq+u0CWs8eO2ED/@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <66b8d805-06db-a0ca-9a69-b715d03d4f5e@iogearbox.net>
Date:   Thu, 27 Apr 2023 22:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZEq+u0CWs8eO2ED/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/27/23 8:28 PM, Stanislav Fomichev wrote:
> On 04/27, Alexey Gladkov wrote:
>> The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
>> but the utility should not be called as a test. Executing this utility
>> produces the following error:
>>
>> selftests: /linux/tools/testing/selftests/bpf: urandom_read
>> ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read
>>
>> selftests: /linux/tools/testing/selftests/bpf: sign-file
>> not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2
>>
>> Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
>>   tools/testing/selftests/bpf/Makefile | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index b677dcd0b77a..fd214d1526d4 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>>   	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>>   	xdp_features
>>   
>> -TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
>> -TEST_GEN_FILES += liburandom_read.so
>> +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file

Given you move over both of them, the commit msg should be adapted accordingly
since it mainly talks about sign-file, less so about urandom_read.

Also now that you remove the TEST_CUSTOM_PROGS, we should probably also remove
the other two instances:

tools/testing/selftests/bpf/Makefile:91:TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
tools/testing/selftests/bpf/Makefile:156:        $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
tools/testing/selftests/bpf/Makefile:674:EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) \

>>   # Emit succinct information message describing current building step
>>   # $1 - generic step name (e.g., CC, LINK, etc);
>> -- 
>> 2.33.7
>>

