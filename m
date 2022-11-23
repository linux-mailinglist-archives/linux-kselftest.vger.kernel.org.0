Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5BD636259
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 15:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiKWOtx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiKWOtv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 09:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB896CA00
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 06:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669214932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVwsHMkeuOJlctKFKAb4Da/8dTubU4VpbLh+0BeUA34=;
        b=CzUjOz8/g2FdPHGMjLQ201qm8fxOGt+3LayH8GZTcE1Bfr8hg//zhAZcWVSVl8+mCVkKIj
        5V4w0ijkzQ2sSGk35Swh6ex+HpZkPkmqm4nojtX2rHrvhZ1630+ethKt67c2WnI/XFJU9C
        Nv9o7YMjgGYnW+mJAQPwmZQHP6fsi4g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-q_X9WrCLP427g_k8AAxw5g-1; Wed, 23 Nov 2022 09:48:51 -0500
X-MC-Unique: q_X9WrCLP427g_k8AAxw5g-1
Received: by mail-io1-f71.google.com with SMTP id c14-20020a5ea80e000000b006d6e9b05e58so9364094ioa.23
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 06:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVwsHMkeuOJlctKFKAb4Da/8dTubU4VpbLh+0BeUA34=;
        b=Fsh3xdtPbYVFWgjfaIpGy+auMN8sgq2uURUa3jEIkiCTKnFA301KkKMzJVczdhoe7u
         jEz3AfNHNIPJtAn56RDbXMVfcfsV2g4SBbFuD0sRPTxebpLLC5+/lR1YVshUKRE7PcwB
         tOrMBRe1IgmfUqZdSk7rGYmZbEnJXzpmT9VC1l1Jgi6vx45diec4+2/B6DdAlc3v6RdS
         nVA/f1aGpPu8zRByVNbFiP1BtgaiAjY9C54lyS6CIDvqxQ5berucXBGGMTrgn4xGXXxZ
         6sOewqfhUts/5UrYptdWGxeTI0j8gB7DW8hOyWTnJ4FNFo8iaxx2wahyjIPLJd5flJgQ
         JQ3w==
X-Gm-Message-State: ANoB5pnptuTJLbRV8wH0H52aBZl3ea6DLyLRkB8FI0YfJstI7AnCm9Aw
        alBPkzj5fh5jARPDJ/aKI2nOJ5oo0N3RvASuPL6yWBC8sJuVN1cAIktJMNOxqNCaziQlRZzIyQj
        XgCCF/IZIL9Yu3bNZjTy9qNY8JxTReB7FubFC00TJ0GRK
X-Received: by 2002:a92:c691:0:b0:302:75c9:5d55 with SMTP id o17-20020a92c691000000b0030275c95d55mr4126277ilg.34.1669214931053;
        Wed, 23 Nov 2022 06:48:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7t6tBPN8sYXy8dh8uHxD1HawZPKG6isYlau3hUqFJFGOIk/LhU7kZ8leId0LJjjgLzaxuDzjr+0sIG2p/qtrU=
X-Received: by 2002:a92:c691:0:b0:302:75c9:5d55 with SMTP id
 o17-20020a92c691000000b0030275c95d55mr4126263ilg.34.1669214930760; Wed, 23
 Nov 2022 06:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
In-Reply-To: <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 23 Nov 2022 15:48:39 +0100
Message-ID: <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
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

Hi Jon,

On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 03/11/2022 15:57, Benjamin Tissoires wrote:
> > Declare an entry point that can use fmod_ret BPF programs, and
> > also an API to access and change the incoming data.
> >
> > A simpler implementation would consist in just calling
> > hid_bpf_device_event() for any incoming event and let users deal
> > with the fact that they will be called for any event of any device.
> >
> > The goal of HID-BPF is to partially replace drivers, so this situation
> > can be problematic because we might have programs which will step on
> > each other toes.
> >
> > For that, we add a new API hid_bpf_attach_prog() that can be called
> > from a syscall and we manually deal with a jump table in hid-bpf.
> >
> > Whenever we add a program to the jump table (in other words, when we
> > attach a program to a HID device), we keep the number of time we added
> > this program in the jump table so we can release it whenever there are
> > no other users.
> >
> > HID devices have an RCU protected list of available programs in the
> > jump table, and those programs are called one after the other thanks
> > to bpf_tail_call().
> >
> > To achieve the detection of users losing their fds on the programs we
> > attached, we add 2 tracing facilities on bpf_prog_release() (for when
> > a fd is closed) and bpf_free_inode() (for when a pinned program gets
> > unpinned).
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ...
>
> > +static int __init hid_bpf_init(void)
> > +{
> > +     int err;
> > +
> > +     /* Note: if we exit with an error any time here, we would entirely break HID, which
> > +      * is probably not something we want. So we log an error and return success.
> > +      *
> > +      * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
> > +      * will not be available, so nobody will be able to use the functionality.
> > +      */
> > +
> > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> > +     if (err) {
> > +             pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     err = hid_bpf_preload_skel();
> > +     if (err) {
> > +             pr_warn("error while preloading HID BPF dispatcher: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     /* register syscalls after we are sure we can load our preloaded bpf program */
> > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> > +     if (err) {
> > +             pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     return 0;
> > +}
>
>
> We have a kernel test that checks for new warning and error messages on
> boot and with this change I am now seeing the following error message on
> our Tegra platforms ...
>
>   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
>
> I have a quick look at the code, but I can't say I am familiar with
> this. So I wanted to ask if a way to fix this or avoid this? I see the
> code returns 0, so one option would be to make this an informational or
> debug print.

I am not in favor of debug in that case, because I suspect it'll hide
too much when getting a bug report. Informational could do, yes.

However, before that, I'd like to dig a little bit more on why it is
failing. I thought arm64 now has support of tracing bpf programs, so I
would not expect this to fail.

Would you mind sending me your .config so I can check in it if you are
missing anything? I am thinking that maybe I need to also depend on
BPF_JIT.

Cheers,
Benjamin

>
> Thanks
> Jon
>
> --
> nvpublic
>

