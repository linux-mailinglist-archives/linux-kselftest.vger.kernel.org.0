Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5451F9C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiEIK1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiEIK1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 06:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B5E28E4D6
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652091738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1D+xFiUi4ihoABdmy5q5Cd5BL26SejXkNmfk43CPxo=;
        b=IkTZpRvZnONq+tuVwL8JaAjP//px8tKHcmNpZ0wrN8d72ewBNX0ECz7jOh8SZWK8FB2SXh
        4shtA//wKSEyvnD03Q73FZ0uv9km4cflNJspGuod4pDlOLHCetUwD9vdd/TqsBDBifqOsg
        avD8GuCkAwJDCZFPt6UeV2AxdIp/rcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-p9vbl0osMrigf5Rne3xECQ-1; Mon, 09 May 2022 06:00:02 -0400
X-MC-Unique: p9vbl0osMrigf5Rne3xECQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06C5C811E78;
        Mon,  9 May 2022 10:00:02 +0000 (UTC)
Received: from localhost (unknown [10.39.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9421AC15E73;
        Mon,  9 May 2022 10:00:01 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [ARM64] status of MTE selftests?
In-Reply-To: <YnVNADyaft0WkNHu@sirena.org.uk>
Organization: Red Hat GmbH
References: <87wney4svy.fsf@redhat.com> <YnVNADyaft0WkNHu@sirena.org.uk>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 09 May 2022 11:59:59 +0200
Message-ID: <87levb3u1s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 06 2022, Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 06, 2022 at 04:50:41PM +0200, Cornelia Huck wrote:
>
>> I'm currently trying to run the MTE selftests on the FVP simulator (Base
>> Model)[1], mainly to verify things are sane on the host before wiring up
>> the KVM support in QEMU. However, I'm seeing some failures (the non-mte
>> tests seemed all fine):
>
>> Are the MTE tests supposed to work on the FVP model? Something broken in
>> my config? Anything I can debug?
>
> I would expect them to work, they seemed happy when I was doing
> the async mode support IIRC and a quick spin with -next in qemu
> everything seems fine, I'm travelling so don't have the
> environment for models to hand right now.

Thanks; I think that points to some setup/config problem on my side,
then :/ (I ran the selftests under QEMU's tcg emulation, and while it
looks better, I still get timeouts for check_gcr_el1_cswitch and
check_user_mem.)

>
>> [1] Command line:
>> "$MODEL" \
>> -C cache_state_modelled=0 \
>> -C bp.refcounter.non_arch_start_at_default=1 \
>> -C bp.secure_memory=false \
>> -C cluster0.has_arm_v8-1=1 \
>> -C cluster0.has_arm_v8-2=1 \
>> -C cluster0.has_arm_v8-3=1 \
>> -C cluster0.has_arm_v8-4=1 \
>> -C cluster0.has_arm_v8-5=1 \
>> -C cluster0.has_amu=1 \
>> -C cluster0.NUM_CORES=4 \
>> -C cluster0.memory_tagging_support_level=2 \
>> -a "cluster0.*=$AXF" \
>
>> where $AXF contains a kernel at v5.18-rc5-16-g107c948d1d3e[2] and an
>> initrd built by mbuto[3] from that level with a slightly tweaked "kselftests"
>> profile (adding /dev/shm).
>
> What are you using for EL3 with the model?  Both TF-A and
> boot-wrapper are in regular use, TF-A gets *way* more testing
> than boot-wrapper which is mostly used by individual developers.

I'm building the .axf via boot-wrapper-aarch64 (enabling psci and gicv3,
if that matters.) Didn't try to make use of TF-A yet beyond the dtb (I'm
still in the process of getting familiar with the arm64 world, so I'm
currently starting out with the setups that others had shared with me.)

