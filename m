Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4D59A6E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbiHSUMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351749AbiHSUMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 16:12:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3910650F
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:12:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id c4so3288937iof.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TWnGx0tsPzDsYWN5IvwyG0/F4n3/lHDuvrydVsnCdTg=;
        b=FamF99POPr6PtKGcfiAFaDyK/px9/QEUZ9jAWq0VuRMjBQuH/SIEycINUXdEisf8wJ
         GB5Fp0sV/9jsr8SHRoKkycJAodjombPVpppk1giNuh7jurYysChORzMPgyHKQdBRx6Yi
         bMQ8CZykRl92tAcPu+aCfb2R1BHuyiGBmYyICNbj6NOdCbqR0y056zBRI5sucULdSXWP
         iBSs6go4YjTUccStqlOuQrHTd0ys3ntGBcGxqR0SgI4W+Fz4sL7vOXN4324d30h8iu/T
         k8P9H+ggVIlKLOTUU3V6HrleaFRS/uGb9Vw8lQ57cl7kluTFPaNsmbjckIsP6sE3O2xR
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TWnGx0tsPzDsYWN5IvwyG0/F4n3/lHDuvrydVsnCdTg=;
        b=pNuABZzUKCi/hHkBV6ZnU9FGfI99KpMDJAGBjpumSGIaGZNbVM66P+eFMblX9pXM6x
         YhH41dOA6AKQpemvyRjgtQuvez3xjeY2w8Hq3zET+QpSPS0l1ALHDSdlCGAxOWIDs5MZ
         LilOR7qpBAQHo+qqMixnlDuJJT65VmORpuVMxhmb+vLYbhw+aBqY9/lF99SYXmD3qyJO
         IznehdtzZ2jhTyJ/0bljzL7T5oeWj600bsTmkZkUGgIn9QPbycR0X9AeV61VlCCSBg99
         bH0lulV98ETwbY64XtAS6gYOefKPwNnsVz6avK/6EE5yiVM5+gQTjIg172c2ON79jhQR
         QnaQ==
X-Gm-Message-State: ACgBeo0v5MSbfGcLNO5CoL/JV2vkEFcXmZMINB8SO9hzomoa0XSj/edI
        911EEovwohPrbNCakDANCxg+HrJlq4yYFk/51vjoqg==
X-Google-Smtp-Source: AA6agR7vH6bU/CcMRlqauAdte2pei9jmt+xQRqGJlV8ch8ekID2WY8/GjnEURxqW3LnsWWhfJJAGPXkSfSDz0FeaHIw=
X-Received: by 2002:a05:6638:34a8:b0:343:4d0a:5984 with SMTP id
 t40-20020a05663834a800b003434d0a5984mr4292780jal.167.1660939967732; Fri, 19
 Aug 2022 13:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
 <20220817214728.489904-3-axelrasmussen@google.com> <Yv3bnouKb7242Ama@kroah.com>
In-Reply-To: <Yv3bnouKb7242Ama@kroah.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 19 Aug 2022 13:12:10 -0700
Message-ID: <CAJHvVcjd3GtjJ2yr0gNDGHCqc8RZUYXCYaj8eEgo1TTLBjNYSQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 17, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 17, 2022 at 02:47:25PM -0700, Axel Rasmussen wrote:
> > +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> > +{
> > +     return 0;
>
> If your open does nothing, no need to list it here at all, right?
>
> > +}
> > +
> > +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> > +{
> > +     if (cmd != USERFAULTFD_IOC_NEW)
> > +             return -EINVAL;
> > +
> > +     return new_userfaultfd(flags);
> > +}
> > +
> > +static const struct file_operations userfaultfd_dev_fops = {
> > +     .open = userfaultfd_dev_open,
> > +     .unlocked_ioctl = userfaultfd_dev_ioctl,
> > +     .compat_ioctl = userfaultfd_dev_ioctl,
>
> Why do you need to set compat_ioctl?  Shouldn't it just default to the
> existing one?

I took some more time looking at this today, and I think it actually
has to be the way it is.

I didn't find anywhere we noticed compat_ioctl unset, and default to
the "normal" one (e.g. see the compat ioctl syscall definition in
fs/ioctl.c). It looks to me like it really does need some value. It's
common to use compat_ptr_ioctl for this, but since we're interpreting
the arg as a scalar not as a pointer, doing that here would be
incorrect.

It looks like there are other existing examples that do it the same
way, e.g. seccomp_notify_ops in linux/seccomp.c.

>
> And why is this a device node at all?  Shouldn't the syscall handle all
> of this (to be honest, I didn't read anything but the misc code, sorry.)
>
> thanks,
>
> greg k-h
