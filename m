Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925358EE8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiHJOj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiHJOjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:39:21 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E815354649;
        Wed, 10 Aug 2022 07:39:14 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLmrH-0007L9-Nn; Wed, 10 Aug 2022 16:38:55 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLmrG-000Ego-Vy; Wed, 10 Aug 2022 16:38:55 +0200
Subject: Re: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark a
 function to be sleepable
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com>
 <YvKRYRjJdXbAWL6Y@kernel.org> <c9e73d7aa51a47c585b935a41dbf1924@huawei.com>
 <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e807779b-e72b-e197-b833-43373e87d3df@iogearbox.net>
Date:   Wed, 10 Aug 2022 16:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26623/Wed Aug 10 09:55:07 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/22 4:25 PM, Benjamin Tissoires wrote:
> On Wed, Aug 10, 2022 at 3:44 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>>> From: Jarkko Sakkinen [mailto:jarkko@kernel.org]
>>> Sent: Tuesday, August 9, 2022 6:55 PM
>>> On Tue, Aug 09, 2022 at 03:45:54PM +0200, Roberto Sassu wrote:
>>>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>
>>>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>
>>>> This allows to declare a kfunc as sleepable and prevents its use in
>>>> a non sleepable program.
>>>
>>> Nit: "Declare a kfunc as sleepable and prevent its use in a
>>> non-sleepable program."
>>>
>>> It's missing the part *how* the patch accomplishes its goals.
>>
>> I will add:
>>
>> If an eBPF program is going to call a kfunc declared as sleepable,
>> eBPF will look at the eBPF program flags. If BPF_F_SLEEPABLE is
>> not set, execution of that program is denied.
> 
> All those changes are looking good to me.
> 
> Thanks a lot for keeping pushing on this patch :)

This single one from the series got already applied here:

   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=fa96b24204af42274ec13dfb2f2e6990d7510e55

>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>> Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
>>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>>> Signed-off-by: Hao Luo <haoluo@google.com>
>>>> ---
>>>>   Documentation/bpf/kfuncs.rst | 6 ++++++
>>>>   include/linux/btf.h          | 1 +
>>>>   kernel/bpf/btf.c             | 9 +++++++++
>>>>   3 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>>>> index c0b7dae6dbf5..c8b21de1c772 100644
>>>> --- a/Documentation/bpf/kfuncs.rst
>>>> +++ b/Documentation/bpf/kfuncs.rst
>>>> @@ -146,6 +146,12 @@ that operate (change some property, perform some
>>> operation) on an object that
>>>>   was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer
>>> to
>>>>   ensure the integrity of the operation being performed on the expected object.
