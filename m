Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF44152014C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiEIPo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbiEIPon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 11:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFB9B2AC3
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652110848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f20KjEs82jGqw96l1DoBfDRekni2iSTjN+mGw5ax9tc=;
        b=WtK/h+FKwISW+tiWsmC2mny1CN08+Pzfwcm3xd096KXQlVm+RZE/0eYVFSRKH1KjXArzsD
        apwRomu/sh2AB0mvLDPyjHANOYOblWwrwS0HBrY33/qsEJI8OdNvGjHj/OYA+ro1Pl/kYE
        DPrNFHg9o+rdXP+PYTLLM77Cq9YSKxw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-MBlBrtTdOM-GxFYmJjO0Uw-1; Mon, 09 May 2022 11:40:46 -0400
X-MC-Unique: MBlBrtTdOM-GxFYmJjO0Uw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8396E811E75;
        Mon,  9 May 2022 15:40:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A56A455D9F;
        Mon,  9 May 2022 15:40:45 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
In-Reply-To: <Ynkw2I4IlNEvyhRY@sirena.org.uk>
Organization: Red Hat GmbH
References: <87wney4svy.fsf@redhat.com> <YnVNADyaft0WkNHu@sirena.org.uk>
 <87levb3u1s.fsf@redhat.com> <Ynkw2I4IlNEvyhRY@sirena.org.uk>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 17:40:43 +0200
Message-ID: <87zgjq3e9w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 09 2022, Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 09, 2022 at 11:59:59AM +0200, Cornelia Huck wrote:
>> On Fri, May 06 2022, Mark Brown <broonie@kernel.org> wrote:
>
>> > I would expect them to work, they seemed happy when I was doing
>> > the async mode support IIRC and a quick spin with -next in qemu
>> > everything seems fine, I'm travelling so don't have the
>> > environment for models to hand right now.
>
>> Thanks; I think that points to some setup/config problem on my side,
>> then :/ (I ran the selftests under QEMU's tcg emulation, and while it
>> looks better, I still get timeouts for check_gcr_el1_cswitch and
>> check_user_mem.)
>
> That might just be an actual timeout depending on the preformance of
> the host system.

Our mails may have crossed mid-air; the tests finish for me eventually.

>
>> >> where $AXF contains a kernel at v5.18-rc5-16-g107c948d1d3e[2] and an
>> >> initrd built by mbuto[3] from that level with a slightly tweaked "kselftests"
>> >> profile (adding /dev/shm).
>
>> > What are you using for EL3 with the model?  Both TF-A and
>> > boot-wrapper are in regular use, TF-A gets *way* more testing
>> > than boot-wrapper which is mostly used by individual developers.
>
>> I'm building the .axf via boot-wrapper-aarch64 (enabling psci and gicv3,
>> if that matters.) Didn't try to make use of TF-A yet beyond the dtb (I'm
>> still in the process of getting familiar with the arm64 world, so I'm
>> currently starting out with the setups that others had shared with me.)
>
> I'm now back with the models and it turns out that while qemu is happy I
> can reproduce what you're seeing with the model, at least as far back as
> v5.15 which suggests it's likely to be more operator error than a bug.
> Trying to figure it out now.

Ok, thanks for looking.

