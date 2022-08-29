Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEEE5A50DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiH2QBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH2QBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:01:11 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F194754B8
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:01:05 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MGZt73sLWzMqD9B;
        Mon, 29 Aug 2022 18:01:03 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MGZt630S8zlh8V4;
        Mon, 29 Aug 2022 18:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661788863;
        bh=UDehGM8zok+fb4aL9IKQsjADGXsUJoA7AfyxVK4RScI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=UljJ9FrIJnA4nbsJvP/j21pbDxFUUDdLhmks9Cj0wPynT87BtPv5PPBr7AI+9BGzf
         7ub5XvC/972M0toGVuazsbSfU7iaoDsgNJipkBR1ZcCsRNGWgn4GnJtlLR/7BlV2sC
         QyyiRc3PRpqjk6W3cJQwufU2zHjI9yHG9YcbN/2A=
Message-ID: <de4620d2-3268-b3cc-71dd-acbbd204435e@digikod.net>
Date:   Mon, 29 Aug 2022 18:01:01 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-4-xiujianfeng@huawei.com> <Ywpw66EYRDTQIyTx@nuc>
 <de8834b6-0ff2-1a81-f2d3-af33103e9942@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next v2 3/6] landlock: add chmod and chown support
In-Reply-To: <de8834b6-0ff2-1a81-f2d3-af33103e9942@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 29/08/2022 03:17, xiujianfeng wrote:
> 
> Hi,
> 
> 在 2022/8/28 3:30, Günther Noack 写道:
>> Hello!
>>
>> the mapping between Landlock rights to LSM hooks is now as follows in
>> your patch set:
>>
>> * LANDLOCK_ACCESS_FS_CHMOD controls hook_path_chmod
>> * LANDLOCK_ACCESS_FS_CHGRP controls hook_path_chown
>>     (this hook can restrict both the chown(2) and chgrp(2) syscalls)
>>
>> Is this the desired mapping?
>>
>> The previous discussion I found on the topic was in
>>
>> [1] https://lore.kernel.org/all/5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net/
>> [2] https://lore.kernel.org/all/b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com/
>> [3] https://lore.kernel.org/all/c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net/
>>
>> In my understanding the main arguments were the ones in [2] and [3].
>>
>> There were no further responses to [3], so I was under the impression
>> that we were gravitating towards an approach where the
>> file-metadata-modification operations were grouped more coarsely?
>>
>> For example with the approach suggested in [3], which would be to
>> group the operations coarsely into (a) one Landlock right for
>> modifying file metadata that is used in security contexts, and (b) one
>> Landlock right for modifying metadata that was used in non-security
>> contexts. That would mean that there would be:
>>
>> (a) LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES to control the
>> following operations:
>>     * chmod(2)-variants through hook_path_chmod,
>>     * chown(2)-variants and chgrp(2)-variants through hook_path_chown,
>>     * setxattr(2)-variants and removexattr(2)-variants for extended
>>       attributes that are not "user extended attributes" as described in
>>       xattr(7) through hook_inode_setxattr and hook_inode_removexattr
>>
>> (b) LANDLOCK_ACCESS_FS_MODIFY_NON_SECURITY_ATTRIBUTES to control the
>> following operations:
>>     * utimes(2) and other operations for setting other non-security
>>       sensitive attributes, probably through hook_inode_setattr(?)
>>     * xattr modifications like above, but for the "user extended
>>       attributes", though hook_inode_setxattr and hook_inode_removexattr
>>
>> In my mind, this would be a sensible grouping, and it would also help
>> to decouple the userspace-exposed API from the underlying
>> implementation, as Casey suggested to do in [2].
>>
>> Specifically for this patch set, if you want to use this grouping, you
>> would only need to add one new Landlock right
>> (LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES) as described above
>> under (a) (and maybe we can find a shorter name for it... :))?
>>
>> Did I miss any operations here that would be necessary to restrict?
>>
>> Would that make sense to you? Xiu, what is your opinion on how this
>> should be grouped? Do you have use cases in mind where a more
>> fine-grained grouping would be required?
> 
> I apologize I may missed that discussion when I prepared v2:(
> 
> Yes, agreed, this grouping is more sensible and resonnable. so in this
> patchset only one right will be added, and I suppose the first commit
> which expand access_mask_t to u32 can be droped.
> 
>>
>> —Günther
>>
>> P.S.: Regarding utimes: The hook_inode_setattr hook *also* gets called
>> on a variety on attribute changes including file ownership, file size
>> and file mode, so it might potentially interact with a bunch of other
>> existing Landlock rights. Maybe that is not the right approach. In any
>> case, it seems like it might require more thinking and it might be
>> sensible to do that in a separate patch set IMHO.
> 
> Thanks for you reminder, that seems it's more complicated to support
> utimes, so I think we'd better not support it in this patchset.

The issue with this approach is that it makes it impossible to properly 
group such access rights. Indeed, to avoid inconsistencies and much more 
complexity, we cannot extend a Landlock access right once it is defined.

We also need to consider that file ownership and permissions have a 
default (e.g. umask), which is also a way to set them. How to 
consistently manage that? What if the application wants to protect its 
files with chmod 0400?

About the naming, I think we can start with:
- LANDLOCK_ACCESS_FS_READ_METADATA (read any file/dir metadata);
- LANDLOCK_ACCESS_FS_WRITE_SAFE_METADATA: change file times, user xattr;
- LANDLOCK_ACCESS_FS_WRITE_UNSAFE_METADATA: interpreted by the kernel 
(could change non-Landlock DAC or MAC, which could be considered as a 
policy bypass; or other various xattr that might be interpreted by 
filesystems), this should be denied most of the time.
