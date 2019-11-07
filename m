Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE4F31B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGOkK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 09:40:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726033AbfKGOkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 09:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573137609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+MY2sYzcnHY3V39bIbtZ31bBnAI347fLMR61CQm2ZI=;
        b=Q+7P2F5yeiPLjxdM0fgh6CjeZxY4W5vHMd23vcZYxisjYf57rCFspGffJT9wAAZUlxXIM0
        k8p8NtJ77Lg8gPtcqXfjTWrsolA2H4Bg9vp8+mm2S+xV7X4Kik4KtMOqRmhf2Jcx3UL2RS
        AeK69+KTS4N56SofuMam2sbWJfsF5Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Hm5JYGAQNN67qXq99eBSMg-1; Thu, 07 Nov 2019 09:40:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D372D800C61;
        Thu,  7 Nov 2019 14:40:04 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5943E1001E91;
        Thu,  7 Nov 2019 14:40:04 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com>
Date:   Thu, 7 Nov 2019 09:40:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Hm5JYGAQNN67qXq99eBSMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/19 3:42 AM, Miroslav Benes wrote:
> On Wed, 6 Nov 2019, Joe Lawrence wrote:
>=20
>> The livepatch selftests compare expected dmesg output to verify kernel
>> behavior.  They currently filter out "tainting kernel with
>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
>> modules.
>>
>> Further filter the log to also drop "loading out-of-tree module taints
>> kernel" messages in case the klp_test modules have been build without
>> the in-tree module flag.
>=20
> That is true, but "tainting kernel with TAINT_LIVEPATCH" should be printe=
d
> out even in this case. check_modinfo_livepatch() is called for all module=
s
> and relies on MODINFO(livepatch, Y).
>  > So either the bug is elsewhere or I need one more cup of tea.
 >

I'm only half a cup in this morning myself, but...

In my scenario, I saw in the kernel log:

   % modprobe test_klp_livepatch
   test_klp_livepatch: loading out-of-tree module taints kernel.
   test_klp_livepatch: module verification failed: signature and/or=20
required key missing - tainting kernel
   ...

and because check_result() only removes 'tainting' with grep -v, the=20
expected log message failed to match with the actual filtered message=20
because of the first 'taints' message.

So this change just adds more to the filtered out strings:

   result =3D dmesg | grep -v <filtered out strings> | grep <interesting=20
strings>

BTW, none of the callers of check_result() bother to include either=20
taint message since I think they are only ever emitted on the first=20
occurance.

-- Joe

