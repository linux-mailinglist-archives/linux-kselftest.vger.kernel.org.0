Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBF620D74
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 11:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiKHKgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 05:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKHKgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 05:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7640918
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667903711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaAhJO6YJxCUy0qLzJPY5v+gPU2l/x5Y41FTzwGsB+s=;
        b=K8DhwfOX2tx8TsEowy4O7djS7up3Y146mILuvvqVYSH5gG26NK6rxkF3gXhEtqsiuQws3b
        EmiAExQq42xUH51Sh+GiZ7CULDujIEOFZBSF7YjbzsZPjdkATS+zBFPpMWL3X6zYE4+EZj
        sqnI73x40OvdwVTz7AFCZE0987JcUdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-ah5IEpZaNEeHNi7qrAIfKg-1; Tue, 08 Nov 2022 05:35:06 -0500
X-MC-Unique: ah5IEpZaNEeHNi7qrAIfKg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A095C101A528;
        Tue,  8 Nov 2022 10:35:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE9C47505F;
        Tue,  8 Nov 2022 10:35:04 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: clone3: clone3_clear_sighand failed - Bail out!
 Failed to clear signal handler for child process
References: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
Date:   Tue, 08 Nov 2022 11:35:03 +0100
In-Reply-To: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
        (Naresh Kamboju's message of "Tue, 8 Nov 2022 15:28:55 +0530")
Message-ID: <87h6z9ka3s.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Naresh Kamboju:

> selftests: clone3: clone3_clear_sighand failed on arm32 and i386
> but passed on arm64 and x86_64.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> # selftests: clone3: clone3_clear_sighand
> # TAP version 13
> # 1..1
> # # clone3() syscall supported
> # Bail out! Failed to clear signal handler for child process
> # # Planned tests != run tests (1 != 0)
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> not ok 2 selftests: clone3: clone3_clear_sighand # exit=1

Not sure why you are reporting this to libc-alpha.  We'd like to help,
but there doesn't seem to be anything glibc-specific in this report?

Thanks,
Florian

