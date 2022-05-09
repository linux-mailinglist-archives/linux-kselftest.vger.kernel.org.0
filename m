Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA452009C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiEIPET (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiEIPEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 11:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D726D2C96DA
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652108385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slp31txvRJ+dD2+/oLnVhE7gf3HRncvTSf+q+IK5c8M=;
        b=FPVWApT6YiedxwGgBRbxaGgwd+uB5R7coY3Bo1HJQB55hMfyS3lIr2LDsPbcnBNYQGEwMA
        sqVl+Qu/cSfrnNsDfpoDDgHX5WrgNqt6G7HiBcSY9d8RkJqMXDSdQoka7zMQazyDUq0KB5
        kFjVtHLwHPivWiYLxaQIklacCfGTDio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-tYLRIoRuMUKcPisgZAeaxg-1; Mon, 09 May 2022 10:59:41 -0400
X-MC-Unique: tYLRIoRuMUKcPisgZAeaxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BA5C811E80;
        Mon,  9 May 2022 14:59:40 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B9053CE;
        Mon,  9 May 2022 14:59:39 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
In-Reply-To: <87levb3u1s.fsf@redhat.com>
Organization: Red Hat GmbH
References: <87wney4svy.fsf@redhat.com> <YnVNADyaft0WkNHu@sirena.org.uk>
 <87levb3u1s.fsf@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 16:59:32 +0200
Message-ID: <87ee124uqz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 09 2022, Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, May 06 2022, Mark Brown <broonie@kernel.org> wrote:
>
>> On Fri, May 06, 2022 at 04:50:41PM +0200, Cornelia Huck wrote:
>>
>>> I'm currently trying to run the MTE selftests on the FVP simulator (Base
>>> Model)[1], mainly to verify things are sane on the host before wiring up
>>> the KVM support in QEMU. However, I'm seeing some failures (the non-mte
>>> tests seemed all fine):
>>
>>> Are the MTE tests supposed to work on the FVP model? Something broken in
>>> my config? Anything I can debug?
>>
>> I would expect them to work, they seemed happy when I was doing
>> the async mode support IIRC and a quick spin with -next in qemu
>> everything seems fine, I'm travelling so don't have the
>> environment for models to hand right now.
>
> Thanks; I think that points to some setup/config problem on my side,
> then :/ (I ran the selftests under QEMU's tcg emulation, and while it
> looks better, I still get timeouts for check_gcr_el1_cswitch and
> check_user_mem.)

...so these two tests are simply very slow; if I run them directly, they
take longer than 45s, but eventually finish. So all seems good (in a
slow way) on QEMU + tcg.

On the simulator, running check_gcr_el1_cswitch directly finishes
successfully after several minutes as well; however, I get all the other
failures in tests that I reported in my first mail even when I run them
directly.

