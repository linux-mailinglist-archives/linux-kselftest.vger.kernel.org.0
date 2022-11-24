Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DA637D40
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKXPvT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 10:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKXPvS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 10:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6131EC9
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 07:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669305023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RY55+mI/DdVynf6mJobax2x0nouP9gB/94T/eEnCQ84=;
        b=JhC5IsXvX2RUOh60Vb+22q02Kc/unNt7IEGDy/tw9Q5mNNFqSzrP20w/3NGXXnSWx3ek/0
        AHWiJ7sLFy6miJ7CsBI4SzL8+kQjcQWYeeSrTw4IYvqs7PylO3g3tfsJ+h43MEwSmW3vQf
        hhMFMwndpX5olYvtIsRFFUDDKHp3C2A=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-RDhmgD0BPuSM-E40QdOAgw-1; Thu, 24 Nov 2022 10:50:22 -0500
X-MC-Unique: RDhmgD0BPuSM-E40QdOAgw-1
Received: by mail-io1-f70.google.com with SMTP id t2-20020a6b6402000000b006dea34ad528so1018712iog.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 07:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY55+mI/DdVynf6mJobax2x0nouP9gB/94T/eEnCQ84=;
        b=hzSxUIKM3JX1GwqZnXfDX5N2njcdYKKde+HY10b/V3lvaE2Xe7mkwrgTkCLusgWPcf
         9c6HT1Qi/OhpBaiKm2Y8VuDHXxXP3KQq0t2VQk7b883JdlHwBJxPqmExy/Xz0/s/S8N0
         zXElornMCDKmMXHj3ZBiZ3qBUqGJSfxAAmzYMNOYkI+MUlgrSqfXPKjdCjZl+wZTA/ea
         TqxxKCUJAiZjULx/6vuSWfTj2WoQFTk2Y0BZvjiiEZkFzW24/n8e3kUxUChVVwyl9j+g
         zDSGgSaloPbef9iTXAOaYdO17DPJmjGpfWnlZp2eH4N8HGrdIp/qRcoCcDAwobMUKR2R
         EG1Q==
X-Gm-Message-State: ANoB5pm54Yemff/nBtCfEy7zZWD+vc8kxEobzySJgX1Vl+O+tNXi6paS
        b0eYNUORUWpULNvDJ3M5hNGaM/p8AmjmF960s+MInTFSWIEdo4kSJhAhsqOeHzGcmbFCnzKZF+d
        7FwfUy0iqgEG35TnuHKHjeKnKGV/2a9Tx9leC0BCYPD0u
X-Received: by 2002:a05:6e02:12c2:b0:302:e38e:761b with SMTP id i2-20020a056e0212c200b00302e38e761bmr2982593ilm.61.1669305021750;
        Thu, 24 Nov 2022 07:50:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50DvoaFAAKrDAN6ynBtlfajIpvDYjTyVfoAXhh1Q93IuTagRMPKBRzK4dRjX385fP/AwgqliXF5ra1BppOhJk=
X-Received: by 2002:a05:6e02:12c2:b0:302:e38e:761b with SMTP id
 i2-20020a056e0212c200b00302e38e761bmr2982569ilm.61.1669305021479; Thu, 24 Nov
 2022 07:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
 <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com> <CAADnVQ+kE+EJ9LAfwge9ksC0LR8r+ShQNYi5g-MDajufXq8Yxw@mail.gmail.com>
In-Reply-To: <CAADnVQ+kE+EJ9LAfwge9ksC0LR8r+ShQNYi5g-MDajufXq8Yxw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 24 Nov 2022 16:50:10 +0100
Message-ID: <CAO-hwJJGxvrLRGSt7g0T1rYiuCCigVzQ-L6yKLM1-44EpYqmsQ@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        KP Singh <kpsingh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 23, 2022 at 9:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 6:53 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Jon,
> >
> > On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > >
> > > On 03/11/2022 15:57, Benjamin Tissoires wrote:
> > > > Declare an entry point that can use fmod_ret BPF programs, and
> > > > also an API to access and change the incoming data.
> > > >
> > > > A simpler implementation would consist in just calling
> > > > hid_bpf_device_event() for any incoming event and let users deal
> > > > with the fact that they will be called for any event of any device.
> > > >
> > > > The goal of HID-BPF is to partially replace drivers, so this situation
> > > > can be problematic because we might have programs which will step on
> > > > each other toes.
> > > >
> > > > For that, we add a new API hid_bpf_attach_prog() that can be called
> > > > from a syscall and we manually deal with a jump table in hid-bpf.
> > > >
> > > > Whenever we add a program to the jump table (in other words, when we
> > > > attach a program to a HID device), we keep the number of time we added
> > > > this program in the jump table so we can release it whenever there are
> > > > no other users.
> > > >
> > > > HID devices have an RCU protected list of available programs in the
> > > > jump table, and those programs are called one after the other thanks
> > > > to bpf_tail_call().
> > > >
> > > > To achieve the detection of users losing their fds on the programs we
> > > > attached, we add 2 tracing facilities on bpf_prog_release() (for when
> > > > a fd is closed) and bpf_free_inode() (for when a pinned program gets
> > > > unpinned).
> > > >
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > ...
> > >
> > > > +static int __init hid_bpf_init(void)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     /* Note: if we exit with an error any time here, we would entirely break HID, which
> > > > +      * is probably not something we want. So we log an error and return success.
> > > > +      *
> > > > +      * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
> > > > +      * will not be available, so nobody will be able to use the functionality.
> > > > +      */
> > > > +
> > > > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> > > > +     if (err) {
> > > > +             pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     err = hid_bpf_preload_skel();
> > > > +     if (err) {
> > > > +             pr_warn("error while preloading HID BPF dispatcher: %d", err);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     /* register syscalls after we are sure we can load our preloaded bpf program */
> > > > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> > > > +     if (err) {
> > > > +             pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > >
> > > We have a kernel test that checks for new warning and error messages on
> > > boot and with this change I am now seeing the following error message on
> > > our Tegra platforms ...
> > >
> > >   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
> > >
> > > I have a quick look at the code, but I can't say I am familiar with
> > > this. So I wanted to ask if a way to fix this or avoid this? I see the
> > > code returns 0, so one option would be to make this an informational or
> > > debug print.
> >
> > I am not in favor of debug in that case, because I suspect it'll hide
> > too much when getting a bug report. Informational could do, yes.
> >
> > However, before that, I'd like to dig a little bit more on why it is
> > failing. I thought arm64 now has support of tracing bpf programs, so I
> > would not expect this to fail.
>
> Unfortunately the patches to add support for such tracing bpf progs got stuck.
> Florent/Mark can probably share the latest status.
>

Oh... I noticed Jon's config was lacking CONFIG_FTRACE. So should I
also add a depends on CONFIG_FTRACE to enable HID-BPF?

Cheers,
Benjamin

