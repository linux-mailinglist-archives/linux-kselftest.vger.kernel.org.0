Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C06F0CD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjD0UF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjD0UF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 16:05:26 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D2359D;
        Thu, 27 Apr 2023 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=gUdQqSB70eOPUq7yX+9RzGvH6V4bI9S8SRAVMdNM5n8=; b=iCQsTqXFNo3L5y+k1Rf4a2wpoB
        3NlGxhZ4Tycl26wePNMqqDSDFJVwveF2FOpR4TFHUFz7k2RrHwk3FKc7TzZ8WO7dftacwgdJ54rKG
        zacclXGTCllJO2j7pMHcGECyli2mL5Am3SITJbVVVBhm45wgOBXWEttRWq6d8dTc/USxyPEGgf9Fa
        xrKvjWX0qFrLXyXWLmcQu7pAoFpk4IiQaMi6J7n8VZRMbFtKCJm6GjkoPfGYnLcwJ0SMEzvvl0Myp
        40nLk1BeQnX983JSrAnV6naizObaSmEG9ZJQN0Cly/pMYtK7TH1EVTtBK0HRq3YSc4FHzh5Vme4bE
        4nqa357w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps7rB-000I5U-4Q; Thu, 27 Apr 2023 22:04:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps7rA-000DyF-HV; Thu, 27 Apr 2023 22:04:44 +0200
Subject: Re: [PATCH bpf] selftests/bpf: fix pkg-config call building sign-file
To:     Jeremy Sowden <jeremy@azazel.net>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230426215032.415792-1-jeremy@azazel.net>
 <e1bd99a4ea209277d657f7fb7ccdc26451113fc9.camel@huaweicloud.com>
 <20230427195814.GE415348@azazel.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e0ce3c40-bc47-02a3-5e89-e74916a58630@iogearbox.net>
Date:   Thu, 27 Apr 2023 22:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230427195814.GE415348@azazel.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

On 4/27/23 9:58 PM, Jeremy Sowden wrote:
> On 2023-04-27, at 08:52:27 +0200, Roberto Sassu wrote:
>> On Wed, 2023-04-26 at 22:50 +0100, Jeremy Sowden wrote:
>>> When building sign-file, the call to get the CFLAGS for libcrypto is
>>> missing white-space between `pkg-config` and `--cflags`:
>>>
>>>    $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null)
>>>
>>> Removing the redirection of stderr, we see:
>>>
>>>    $ make -C tools/testing/selftests/bpf sign-file
>>>    make: Entering directory '[...]/tools/testing/selftests/bpf'
>>>    make: pkg-config--cflags: No such file or directory
>>>      SIGN-FILE sign-file
>>>    make: Leaving directory '[...]/tools/testing/selftests/bpf'
>>>
>>> Add the missing space.
>>>
>>> Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
>>> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
>>
>> Thanks.
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Roberto
> 
> Thanks.  I was having e-mail problems yesterday when I sent the original
> message with the patch in it, and it didn't reach some of the
> recipients.  I'll send it again with your `Reviewed-by:` attached.

No need, already took it, thanks. Looks like patchbot did not reply. :/

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=415d7a49cd796a11cfbeaa360b13721bba5117bb
