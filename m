Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F5792C9F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjIERl3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjIERhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 13:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388176C04
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693933491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiG7LMI58PbxxQ7NC4rZfW+AyfhbvsaLPh/UOZNP78k=;
        b=JPRahlb4deVQUNjJB+fS6xu9zJhed3VppD+r2KCW0ZcJPpWtJ1C0jCDbG2za8m0gCNIl70
        n2Rg0WCDzW7DDPdULi49kWfucDHCfta+dHLvCIkTrlld3WFL9s+Ju2Zn1+mlP/WNiC1Yup
        nUx3xn5yP1UcVnXGL7mJzxYur/vuKhg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-j9vJhjXcOjWqfSdsL5P9pA-1; Tue, 05 Sep 2023 12:20:09 -0400
X-MC-Unique: j9vJhjXcOjWqfSdsL5P9pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B0A11C09CC6;
        Tue,  5 Sep 2023 16:20:08 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C0EF2026D68;
        Tue,  5 Sep 2023 16:20:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Tometzki <dtometzki@fedoraproject.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
        <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
        <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
        <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
Date:   Tue, 05 Sep 2023 18:20:05 +0200
In-Reply-To: <20230902155850.ca1d32c16862cbe54ebd36ef@linux-foundation.org>
        (Andrew Morton's message of "Sat, 2 Sep 2023 15:58:50 -0700")
Message-ID: <8734zs7ft6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Andrew Morton:

> OK, thanks, I'll revert this.  Spamming everyone even harder isn't a
> good way to get developers to fix their stuff.

Is this really buggy userspace?  Are future kernels going to require
some of these flags?

That's going to break lots of applications which use memfd_create to
enable run-time code generation on locked-down systems because it looked
like a stable interface (=E2=80=9Cdon't break userspace=E2=80=9D and all th=
at).

Thanks,
Florian

