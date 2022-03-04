Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B7B4CD8CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiCDQPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbiCDQPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 11:15:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B4158790;
        Fri,  4 Mar 2022 08:14:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F19981F46AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646410452;
        bh=E2LGBSxjIQabf0bhUjv3Mh0qf9oY5wW2xSYGdoaQSxE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J9MMbjEO8Vy4G1dcC7G1yQdRQ9ENG/jVUp0O6noQk/Ma9SU0TLw8UG8CkNW2jzY5b
         veOgEMQBVj9OJM1zt6lBrNmxVrWnsBgnUSoWp8GUf5DT7cQYXjUQRj0pGetcZX+kEw
         21ju2TRlhS+XJIr3CEVqM4YYBBNA68UdKjiI97IhBvVbBOqzpvtqCsDgZB83MFvyuY
         1RJyljs9KALlkEydSHqQo0YtWxP1+RAK+EZZIEiiULoAbrgWRWdFWMHvHe3DBrYx5c
         eIsqA8VwNkmev52sWjJzCbJdrjnJqHeXHxms2Vxfb+I/NvDZw7ZQ49br7OGtWBx4ic
         Dxl2RU/jOHsCg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
Organization: Collabora
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
        <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
        <6133317f-4da0-3aae-f352-b75f0f94dbd4@linuxfoundation.org>
        <87o82mkhif.fsf@collabora.com>
        <ee9b8c8b-0d27-bd01-e10d-9062c32f2486@linuxfoundation.org>
Date:   Fri, 04 Mar 2022 11:14:08 -0500
In-Reply-To: <ee9b8c8b-0d27-bd01-e10d-9062c32f2486@linuxfoundation.org> (Shuah
        Khan's message of "Thu, 3 Mar 2022 14:46:08 -0700")
Message-ID: <87r17hg0fj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 3/3/22 11:39 AM, Gabriel Krisman Bertazi wrote:
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>> 
>>> On 2/28/22 2:37 AM, David Hildenbrand wrote:
>>>> On 24.02.22 22:23, Muhammad Usama Anjum wrote:
>>>>> This introduces three tests:
>>>>> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
>>>>> check if the SD bit flipped.
>>>>> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
>>>>> 3) Check soft-dirty on huge pages
>>>>>
>>>>> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
>>>>> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
>>>>> same issue that he fixed, and this test would have caught it.
>>>>>
>>>> A note that madv_populate.c already contains some SOFTDIRTY tests
>>>> regarding MADV_POPULATE. Eventually we want to factor out
>>>> softdirty/pagemap handling+checks for easier reuse.
>>>>
>>>
>>> Is this patch unnecessary then?
>> It is not unnecessary since the madv test doesn't cover the bug tested
>> here, afaik.  But, as mentioned when I originally submitted this patch,
>> it should be merged into selftests/vm/madv_populate.c or, at least,
>> reuse that existing infrastructure.
>> https://lore.kernel.org/lkml/87lf553z5g.fsf@collabora.com/
>> 
>
> Oops this one came in a few months ago and appears to have slipped
> through and didn't get the right attention. Sorry about that.
>
> Please resend the patch and cc all the everybody on this thread.
>
> I would like to have your patch reviewed and looked at first. This
> patch needs rework sine it has several comments to be addressed.

Hi Shuah,

The patch being discussed in that thread is the same that Usama is
proposing here, minus a few modifications. Usama has taken over the work
to upstream it.

We just spoke, and he will follow up with a new version that addresses
the coding issues and reuses the infrastructure from madv_populate.c

Sorry for the noise.

-- 
Gabriel Krisman Bertazi
