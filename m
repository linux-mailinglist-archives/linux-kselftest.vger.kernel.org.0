Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A5DF3345
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfKGPds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 10:33:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbfKGPds (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 10:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573140827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvX43Yt8f1KmhrSO4MMUnXCam2xLej1oS+7lZhjHYoc=;
        b=BtiFxPji7C3YbKAlCeyIUAv0q+lR2PWPWt3uCMLWyJ15a6XdOHSUZe+L2dqwsQD1scoIFR
        1sH9WjsNcOlyxBMKBZus87klOHfhM5KNtgsfY7rwUAgQQ6zde7MB17jSMTl7PI0zgUoufd
        xkTvvT7I6gp45Dcj/BgUnZAdD70mef8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-DCCGyLk3Pu2aRJgQRH16_g-1; Thu, 07 Nov 2019 10:33:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017FC800C61;
        Thu,  7 Nov 2019 15:33:45 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B002608B3;
        Thu,  7 Nov 2019 15:33:44 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz>
 <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com>
 <alpine.LSU.2.21.1911071549340.21726@pobox.suse.cz>
 <c84834ae-2382-f1e7-6924-268e05df1bf3@redhat.com>
 <alpine.LSU.2.21.1911071619380.21726@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <d7518cc0-2166-a5cc-9d3f-f70bbbfc3725@redhat.com>
Date:   Thu, 7 Nov 2019 10:33:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1911071619380.21726@pobox.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DCCGyLk3Pu2aRJgQRH16_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/19 10:24 AM, Miroslav Benes wrote:
>> In my test, I had a kernel tree, but only wanted to build the test modul=
es.
>> Once I did a 'make modules SUBDIR=3D' or 'make M=3D ...' KBUILD_EXTMOD g=
ot flipped
>> on and the modules lost in-tree status.  No amount of googling could tel=
l me
>> how to build a single in-tree directory of modules :(
>=20
> "make lib/livepatch/test_klp_livepatch.ko" should do the trick. "make
> lib/livepatch/" only builds the object files and I haven't found a way to
> make it link .ko modules other than specifying them one by one directly.
>=20

Forgot to mention that this works too, but I was looking to script it=20
and not have each .ko hardcoded in a series of make commands.  Anyway,=20
it's a strange use-case and it was something I was only cooking up for=20
an in-house continuous testing scenario.

>> And then it seemed that
>> opening the tests for OOT modules was reasonable anyway.
>=20
> That's an interesting idea. If a module is in tree, it is under our
> control. So we know what "testing capabilities" it offers. I guess that
> with OOT testing modules the selftests would have to be smarter.
>=20

It would probably go hand in hand with custom test scripts that would=20
understand the OOT module capabilities, I think.  I doubt anyone will=20
try it (besides me), but the grep filter was there and it was an easy tweak=
.

-- Joe

