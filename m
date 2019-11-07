Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC28F3298
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 16:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfKGPNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 10:13:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389336AbfKGPNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573139628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkVgQDxm2qT15SebbYvvhcz43L6Pm7KZuXb1KTLwcPU=;
        b=RcdhfDDdATjF72peHT1STAzZvuTSQ7Xf/wVco9SFk7j07DqL/B8GOvldwgGSvsxXZmv4NT
        0B7ZAGtG13x8xi/50sEusis+XI4qh3qvIDNZnA6nZZxmMzB72SeDqXWG7+Hv5DuWukOqDC
        B7wIejzIUT7974b/U4yhITUiPIOIqPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-PpkO9uF-NVizqDisIKnL-Q-1; Thu, 07 Nov 2019 10:13:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 170651005502;
        Thu,  7 Nov 2019 15:13:44 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F98F608B2;
        Thu,  7 Nov 2019 15:13:43 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz>
 <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com>
 <alpine.LSU.2.21.1911071549340.21726@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <c84834ae-2382-f1e7-6924-268e05df1bf3@redhat.com>
Date:   Thu, 7 Nov 2019 10:13:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1911071549340.21726@pobox.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PpkO9uF-NVizqDisIKnL-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/19 9:53 AM, Miroslav Benes wrote:
> On Thu, 7 Nov 2019, Joe Lawrence wrote:
>=20
>> On 11/7/19 3:42 AM, Miroslav Benes wrote:
>>> On Wed, 6 Nov 2019, Joe Lawrence wrote:
>>>
>>>> The livepatch selftests compare expected dmesg output to verify kernel
>>>> behavior.  They currently filter out "tainting kernel with
>>>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
>>>> modules.
>>>>
>>>> Further filter the log to also drop "loading out-of-tree module taints
>>>> kernel" messages in case the klp_test modules have been build without
>>>> the in-tree module flag.
>>>
>>> That is true, but "tainting kernel with TAINT_LIVEPATCH" should be prin=
ted
>>> out even in this case. check_modinfo_livepatch() is called for all modu=
les
>>> and relies on MODINFO(livepatch, Y).
>>>   > So either the bug is elsewhere or I need one more cup of tea.
>=20
> Ok, the above is not relevant here.
>=20
> I'm only wondering about the execution steps, because supporting modules
> lib/livepatch/ should be built as in-tree. No?
>  =20

Ah, I see.  Well as you noted they are modprobed, so theoretically they=20
could come from anywhere OOT, right?

In my test, I had a kernel tree, but only wanted to build the test=20
modules.  Once I did a 'make modules SUBDIR=3D' or 'make M=3D ...'=20
KBUILD_EXTMOD got flipped on and the modules lost in-tree status.  No=20
amount of googling could tell me how to build a single in-tree directory=20
of modules :(  And then it seemed that opening the tests for OOT modules=20
was reasonable anyway.

-- Joe

