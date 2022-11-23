Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174F636A99
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 21:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiKWUOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 15:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiKWUOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 15:14:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF09BCAB;
        Wed, 23 Nov 2022 12:14:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ha10so8884260ejb.3;
        Wed, 23 Nov 2022 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1UyFy5Drye4uBDXMkB6oFaPbJiRKFehIbLKezTRaZmo=;
        b=YI9BrK5aA2o9y1J1/iG3EG/zL3T4BSwOkjW6ukianRmlbfo5q2KxX4JjrPoB2lGwl9
         LDJ+tfuSRb5TkXE6GtBss6dczu8GwJW6SL2cGRgt3jCacyMnEkAFGj2MF7pmG/LsPOhD
         9oQh6Vmr8MEKECg8EkbXP4ruUgzilW04RmyFPp5ZZu6eWQ/DDXG9ocqHvmD8UXfVhoGE
         FKzf3UPvLfX93hdtFVb7mz50/aAdT1urRA6RVyfMFMbfRSVuhGRt4nldKUIgsbKxE9+G
         enWGg+o4A1D6GblcUaik6+DZrB83Wos6McYxFqiiyQ9BWVC27qtfZCIGk6R8zQQARuAY
         CIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UyFy5Drye4uBDXMkB6oFaPbJiRKFehIbLKezTRaZmo=;
        b=bgNlZz0xqKTpCAw8MYaI2G1oMK4b0AFmGJwK6KaiknLnaZ1JNaQumoqzN+ki5LsIso
         8rpYvH5iseRsZXCxLoQgUpv/+EXfsaa4QQ+3Cgd9kxZLSxVlbkLV8IUtcvO/SBwKUZkM
         nCyY49qb/Odx3BU5U5txbnWZSg0bLrIIWB65gW/6jXPCmggPUzLWQ+aYTpg4Gy03rDEh
         yybZ+KkmxXyCPJJlbB5U4j6Ia3cnVVkFTe17C0Ovau59eU/PIzup8qpXo1xUkU/z9AfJ
         O+31LJipMGy1cnvMxHio9mPpGBNy2kn2PCtNyOcGOvhq8aBXe+FYq7ASAtIK/lthdmmq
         LvDg==
X-Gm-Message-State: ANoB5plZHVEmlyM9plw4CAIfbQp0Ul/U1OCvhZFh83lX9YeHcluzEac+
        xDZideSwyNNwZOk7nQ8QmBBPkRlz8tmKmgARzOk=
X-Google-Smtp-Source: AA0mqf5F17GGSffbGy3BvG2UOX3tDyNGk+5NF7l+Uw4Yk21/CigF6vqJPyNaUknoNsP+323hIcxGpEu2k2WMxgoPnGA=
X-Received: by 2002:a17:906:34d0:b0:78d:c16e:dfc9 with SMTP id
 h16-20020a17090634d000b0078dc16edfc9mr25447270ejb.327.1669234438938; Wed, 23
 Nov 2022 12:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
 <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
In-Reply-To: <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 12:13:47 -0800
Message-ID: <CAADnVQ+kE+EJ9LAfwge9ksC0LR8r+ShQNYi5g-MDajufXq8Yxw@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 23, 2022 at 6:53 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Jon,
>
> On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >
> > On 03/11/2022 15:57, Benjamin Tissoires wrote:
> > > Declare an entry point that can use fmod_ret BPF programs, and
> > > also an API to access and change the incoming data.
> > >
> > > A simpler implementation would consist in just calling
> > > hid_bpf_device_event() for any incoming event and let users deal
> > > with the fact that they will be called for any event of any device.
> > >
> > > The goal of HID-BPF is to partially replace drivers, so this situation
> > > can be problematic because we might have programs which will step on
> > > each other toes.
> > >
> > > For that, we add a new API hid_bpf_attach_prog() that can be called
> > > from a syscall and we manually deal with a jump table in hid-bpf.
> > >
> > > Whenever we add a program to the jump table (in other words, when we
> > > attach a program to a HID device), we keep the number of time we added
> > > this program in the jump table so we can release it whenever there are
> > > no other users.
> > >
> > > HID devices have an RCU protected list of available programs in the
> > > jump table, and those programs are called one after the other thanks
> > > to bpf_tail_call().
> > >
> > > To achieve the detection of users losing their fds on the programs we
> > > attached, we add 2 tracing facilities on bpf_prog_release() (for when
> > > a fd is closed) and bpf_free_inode() (for when a pinned program gets
> > > unpinned).
> > >
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ...
> >
> > > +static int __init hid_bpf_init(void)
> > > +{
> > > +     int err;
> > > +
> > > +     /* Note: if we exit with an error any time here, we would entirely break HID, which
> > > +      * is probably not something we want. So we log an error and return success.
> > > +      *
> > > +      * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
> > > +      * will not be available, so nobody will be able to use the functionality.
> > > +      */
> > > +
> > > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> > > +     if (err) {
> > > +             pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
> > > +             return 0;
> > > +     }
> > > +
> > > +     err = hid_bpf_preload_skel();
> > > +     if (err) {
> > > +             pr_warn("error while preloading HID BPF dispatcher: %d", err);
> > > +             return 0;
> > > +     }
> > > +
> > > +     /* register syscalls after we are sure we can load our preloaded bpf program */
> > > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> > > +     if (err) {
> > > +             pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
> > > +             return 0;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> >
> >
> > We have a kernel test that checks for new warning and error messages on
> > boot and with this change I am now seeing the following error message on
> > our Tegra platforms ...
> >
> >   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
> >
> > I have a quick look at the code, but I can't say I am familiar with
> > this. So I wanted to ask if a way to fix this or avoid this? I see the
> > code returns 0, so one option would be to make this an informational or
> > debug print.
>
> I am not in favor of debug in that case, because I suspect it'll hide
> too much when getting a bug report. Informational could do, yes.
>
> However, before that, I'd like to dig a little bit more on why it is
> failing. I thought arm64 now has support of tracing bpf programs, so I
> would not expect this to fail.

Unfortunately the patches to add support for such tracing bpf progs got stuck.
Florent/Mark can probably share the latest status.
