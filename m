Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5141B1E3021
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 22:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403818AbgEZUkP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 16:40:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391344AbgEZUkP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 16:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590525614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI364zi/wryAJLpdZYgpXb7/ufwHHKVQ6Q8jqyVuF8Q=;
        b=bHL8vPjNNHheqsOCEQGd/P5aKUeo+zkJrhdam5jiuaOkj8EqFPk2DbkM0rVhsLV3fGGmvX
        qGhvveegvIjMHlWKCLBDSBDQwY4IyfcU8nhXrohejOpIzCw7OSyl7MeK+wa+k+4fb6XQOh
        XJK7w31GMQrovpAvYPcBkvUeCkusYV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-_5UcDM9sMnu4IPkMan7vLQ-1; Tue, 26 May 2020 16:40:12 -0400
X-MC-Unique: _5UcDM9sMnu4IPkMan7vLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFB11005512;
        Tue, 26 May 2020 20:40:11 +0000 (UTC)
Received: from [10.3.112.17] (ovpn-112-17.phx2.redhat.com [10.3.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A740C60C47;
        Tue, 26 May 2020 20:40:07 +0000 (UTC)
Subject: Re: kselftest OOT run_tests
To:     shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <xunyblmcqfuu.fsf@redhat.com>
 <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <fcd9debe-4bed-df1a-d5ea-69e0a8d0ac98@redhat.com>
Date:   Tue, 26 May 2020 16:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/26/20 1:13 PM, shuah wrote:
> On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
>> Hi!
>>
>> I'm wondering how out of tree check is supposed to work for make
>> O=dir run_tests from selftests (or make -C ...) directory?
>>
>> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
>> boolean building_out_of_srctree") and without)
>>
>> make M= ... does not work with run_tests.
>>
> 
> Kselftests run_tests target isn't intended for building and running
> tests OOT. Also make M= doesn't make sense for them.
> 
> There is no support to build OOT at the moment. I would like to get
> a better understanding of your use-case. Can you elaborate?
> 

Hey Yauheni, can you CC me on the use-case explanation?

We currently do something really silly for the livepatch selftests on 
RHEL-7 for CKI that requires building them as pseudo OOT... in our case, 
we'd like to just be able to do something like make modules_prepare && 
make M= lib/livepatch, so perhaps a bit different... but I'd be curious 
for which problem you're currently trying to solve.

Regards,

-- Joe

