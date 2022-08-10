Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7E58EE56
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHJOaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiHJOaP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:30:15 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B4B57;
        Wed, 10 Aug 2022 07:30:13 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLmiV-0003ni-HN; Wed, 10 Aug 2022 16:29:51 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLmiU-000WMW-Um; Wed, 10 Aug 2022 16:29:50 +0200
Subject: Re: [PATCH v9 06/10] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>,
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
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-7-roberto.sassu@huawei.com>
 <2b1d62ad-af4b-4694-ecc8-639fbd821a05@iogearbox.net>
 <ecc84dd76f4c429bb55e6bd8fece376b@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d0c0cda2-9a79-35d7-39cf-aad8a12642d9@iogearbox.net>
Date:   Wed, 10 Aug 2022 16:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ecc84dd76f4c429bb55e6bd8fece376b@huawei.com>
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

[...]
>>> +noinline __weak struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
>>
>> Why the need for noinline and the __weak here and below? (If indeed needed
>> this
>> should probably be explained in the commit desc.)
> 
> Oh, I took from v3 of KP's patch set. It is gone in v5. Will do
> the same as well.
> 
>>> +{
>>> +	key_ref_t key_ref;
>>> +	struct bpf_key *bkey;
>>> +
>>> +	/* Keep in sync with include/linux/key.h. */
>>> +	if (flags > (KEY_LOOKUP_PARTIAL << 1) - 1)
>>
>> Can't we just simplify and test flags &
>> ~(KEY_LOOKUP_CREATE|KEY_LOOKUP_PARTIAL)?
> 
> I thought as if we have many flags.

I'd keep it simple for now, and if the actual need comes this can still be changed.

>>> +		return NULL;
>>> +
>>> +	/* Permission check is deferred until actual kfunc using the key. */
>>> +	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
>>> +	if (IS_ERR(key_ref))
>>> +		return NULL;
>>> +
>>> +	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
>>> +	if (!bkey) {
>>> +		key_put(key_ref_to_ptr(key_ref));
>>> +		return bkey;
>>
>> nit: just return NULL probably cleaner
> 
> Ok.
