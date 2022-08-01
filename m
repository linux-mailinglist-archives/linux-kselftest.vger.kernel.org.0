Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F5586D90
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiHAPTu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiHAPTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 11:19:49 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86DA33371
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 08:19:46 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso8439518otg.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Aug 2022 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4KphHhaoyXc371JKTPQphkPCqA2NS8jh1IIkyTneq4o=;
        b=62EB/TFA4EuJYasg0ku1Dzr9dF033+9r1gXM0z+QJ7j/FuTK5jhbf38GBxyKpAP1ji
         7Drz7ejxjN9DxPHD/ANUEK6L3cZPI9kd1/4JsiNCkcd8r0EE7Y31h8eUk8Q4T4JCYL3I
         wG9l4kSHTD9SNnUXEVcwOcs77YOob6wKHSNIg0dih6qNHzqlFov+sSv9NIQMHsPnI7y5
         H4PYESNlKNYjX61q+2qeK+YdhaBuvc/wNy56XLdYm/ndygfjSy8HPh0I7D2XR9miZcy5
         E6TRQoilJz8V5YJiz//4+CWH/Ith4r/ncRDxeHNXkGgVVHLxKgv/rSkb4eGyDgYXYkRb
         1VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4KphHhaoyXc371JKTPQphkPCqA2NS8jh1IIkyTneq4o=;
        b=pBVNNYby1VVz67zjVzkG09mFPEzlqFC+AtYL0/XUGw/vtIiq18JZs4LGJRO/u4gH+5
         nUuAjjbAqx9vYwrIEnYUJ+WvHJKpajRvVAlefBe7xQ659Z9IAuaJpewS3G6a6Br/z+ja
         Xbieq+7qTfyvYoLOszBa9VxZL0xqe/90Lz7gdllO3c7o8QWETVxTNWSSHwExf8vyZavg
         jGqi1FN4GIfJsDajZaiutfBoy5Ulud8Z4iVO9imNDQoPZCXud874J0YpwwlLVq3EA0wr
         G9cKa3cu1XgTJq2/iR2tJjBc4dB0b3Az4ge9QYZ9Q4kXXQC0/zZS7/vgYkxpNX7IC/jZ
         CqmA==
X-Gm-Message-State: ACgBeo36wng5cNNsJRa0XYqcIbAX9jsEetrv8qigeaFWwKHpEpW1+lLm
        Fwkxh4EX7sAKQyKDrt8R4vbyztUxffW3ZABx8ZMz
X-Google-Smtp-Source: AA6agR58TUz+jQfBltCbxRg6WZrQY7oenMMZ6MBjbTUxC7EEAw7vmQXEqpFoYsjefFs4nmqFahyuv4TBVZlaC3y3xi4=
X-Received: by 2002:a9d:7a99:0:b0:629:805:bca4 with SMTP id
 l25-20020a9d7a99000000b006290805bca4mr2748972otn.26.1659367185883; Mon, 01
 Aug 2022 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172808.585539-1-fred@cloudflare.com> <20220722061137.jahbjeucrljn2y45@kafai-mbp.dhcp.thefacebook.com>
 <18225d94bf0.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com> <a4db1154-94bc-9833-1665-a88a5eee48de@cloudflare.com>
In-Reply-To: <a4db1154-94bc-9833-1665-a88a5eee48de@cloudflare.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 11:19:35 -0400
Message-ID: <CAHC9VhQw8LR9yJ9UkA-9aPNETQavt25G-GGSs-_ztg6ZpxNzxA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introduce security_create_user_ns()
To:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, revest@chromium.org,
        jackmanb@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 1, 2022 at 9:13 AM Frederick Lawler <fred@cloudflare.com> wrote:
> On 7/22/22 7:20 AM, Paul Moore wrote:
> > On July 22, 2022 2:12:03 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> >> On Thu, Jul 21, 2022 at 12:28:04PM -0500, Frederick Lawler wrote:
> >>> While creating a LSM BPF MAC policy to block user namespace creation, we
> >>> used the LSM cred_prepare hook because that is the closest hook to prevent
> >>> a call to create_user_ns().
> >>>
> >>> The calls look something like this:
> >>>
> >>> cred = prepare_creds()
> >>> security_prepare_creds()
> >>> call_int_hook(cred_prepare, ...
> >>> if (cred)
> >>> create_user_ns(cred)
> >>>
> >>> We noticed that error codes were not propagated from this hook and
> >>> introduced a patch [1] to propagate those errors.
> >>>
> >>> The discussion notes that security_prepare_creds()
> >>> is not appropriate for MAC policies, and instead the hook is
> >>> meant for LSM authors to prepare credentials for mutation. [2]
> >>>
> >>> Ultimately, we concluded that a better course of action is to introduce
> >>> a new security hook for LSM authors. [3]
> >>>
> >>> This patch set first introduces a new security_create_user_ns() function
> >>> and userns_create LSM hook, then marks the hook as sleepable in BPF.
> >> Patch 1 and 4 still need review from the lsm/security side.
> >
> > This patchset is in my review queue and assuming everything checks out, I expect to merge it after the upcoming merge window closes.
> >
> > I would also need an ACK from the BPF LSM folks, but they're CC'd on this patchset.
>
> Based on last weeks comments, should I go ahead and put up v4 for
> 5.20-rc1 when that drops, or do I need to wait for more feedback?

In general it rarely hurts to make another revision, and I think
you've gotten some decent feedback on this draft, especially around
the BPF LSM tests; I think rebasing on Linus tree after the upcoming
io_uring changes are merged would be a good idea.  Although as a
reminder to the BPF LSM folks - I'm looking at you KP Singh :) - I
need an ACK from you guys before I merge the BPF related patches
(patches {2,3}/4).  For the record, I think the SELinux portion of
this patchset (path 4/4) is fine.

There is the issue of Eric's NACK, but I believe the responses that
followed his comment sufficiently addressed those concerns and it has
now been a week with no further comment from Eric; we should continue
to move forward with this.

-- 
paul-moore.com
