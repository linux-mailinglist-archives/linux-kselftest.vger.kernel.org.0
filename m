Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FF64A56F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiLLREK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 12:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiLLREH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 12:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855D26CC
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670864587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7GxBA4qW0FdZRbMQPW5n8Q6OaZIVNCM6Md3jYNsKrg=;
        b=gV3UC2dmVooXUpYoy9K25IYvQ9AXYyYaBKXMsBo51Z5T9hUP6LQIXxJOYN4e1BcYRU3HgP
        Avwa+G4YgZtntFSRipPjP+gec65bt3StSJEOEOLukSTcVqoJBeMc11aGeGwYoP0C3PIr3j
        Hws8mbHJ8MIF9FTrrP/a1FXqnWBdC/g=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-FQX5CTiaPcWcIt3GJSkCTw-1; Mon, 12 Dec 2022 12:03:04 -0500
X-MC-Unique: FQX5CTiaPcWcIt3GJSkCTw-1
Received: by mail-io1-f69.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so235838iom.5
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Dec 2022 09:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7GxBA4qW0FdZRbMQPW5n8Q6OaZIVNCM6Md3jYNsKrg=;
        b=Y3Z0X8pv0jstdWRYwkKuwt5gKgtBPIUUoe9B/Lk1qqmLfV1zMqKOgtrbBlrsWH2oFv
         UFg0Bu6Cgwkhr/ROXJ/q+CPp+BCMhPV9PsV85KmdwyRbDtGGRGr2blAotswGO1ZXvOT+
         NAbIfByJujvPMfYCBqp5N4E22wsAk1gyBTvtschSmhbH0xPKVbPwI2cAVVMdAQ8cZu0o
         R44iqa3jrz+bb+9hsFNo9dbuA1XWdtmg8DWJhlMU7/ZoLaFRR/kL4ciWMI5kQzdmiEjO
         ErOcDKX6FdT0lj1m8fW4YD4VgCV9uHzfIpg0whBH8N5BGnzpLFuWrsupYGVjjN3mZq0T
         fPTA==
X-Gm-Message-State: ANoB5pmbklgAiaNnJfGW6Cc8uPWBnGtBTWHGiJLv/XJiXBnE9vev0lzB
        YxCdT8z2F35SUyq44WitDtJOjgWpU02Lb8T0qmKlKuqA4i+zMLuGYQg7vhsFxUqKI6lwGichjIQ
        lVpWAHjjjH8hlgXBqf9Z7n7Cf/hvxoCQkK2eyweIyWgds
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id w2-20020a92db42000000b0030326c0e1femr19505896ilq.102.1670864584075;
        Mon, 12 Dec 2022 09:03:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78vVv6O5v0AaOvNCy3ZY7DHOhwUvmJHVpzW4vlVEy2P9BFQMDFFE0qYXuJ4gUjqxDmNFyMJjL8dyQD9Gfzg7o=
X-Received: by 2002:a92:db42:0:b0:303:26c0:e1fe with SMTP id
 w2-20020a92db42000000b0030326c0e1femr19505893ilq.102.1670864583782; Mon, 12
 Dec 2022 09:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com> <20221103155756.687789-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-6-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 12 Dec 2022 18:02:52 +0100
Message-ID: <CAO-hwJ+fYvpD5zbDNq-f-gUEVpxsrdJ7K-ceNd37nLxzBxYL+g@mail.gmail.com>
Subject: Re: [PATCH hid v12 05/15] HID: bpf jmp table: simplify the logic of
 cleaning up programs
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 3, 2022 at 4:58 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Kind of a hack, but works for now:
>
> Instead of listening for any close of eBPF program, we now
> decrement the refcount when we insert it in our internal
> map of fd progs.
>
> This is safe to do because:
> - we listen to any call of destructor of programs
> - when a program is being destroyed, we disable it by removing
>   it from any RCU list used by any HID device (so it will never
>   be called)
> - we then trigger a job to cleanup the prog fd map, but we overwrite
>   the removal of the elements to not do anything on the programs, just
>   remove the allocated space
>
> This is better than previously because we can remove the map of known
> programs and their usage count. We now rely on the refcount of
> bpf, which has greater chances of being accurate.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ---

So... I am a little bit embarrassed, but it turns out that this hack
is not safe enough.

If I compile the kernel with LLVM=1, the function
bpf_prog_put_deferred() is optimized in a weird way: if we are not in
irq, the function is inlined into __bpf_prog_put(), but if we are, the
function is still kept around as it is called in a scheduled work
item.

This is something I completely overlooked: I assume that if the
function would be inlined, the HID entrypoint BPF preloaded object
would not be able to bind, thus deactivating HID-BPF safely. But if a
function can be both inlined and not inlined, then I have no
guarantees that my cleanup call will be called. Meaning that a HID
device might believe there is still a bpf function to call. And things
will get messy, with kernel crashes and others.

An easy "fix" would be to tag bpf_prog_put_deferred() with "noinline",
but it just feels wrong to have that for this specific reason.

AFAICT, gcc is not doing that optimisation, but nothing prevents it
from doing it, and suddenly that will be a big whole in the kernel.

As much as I wish I had another option, I think for the sake of
everyone (and for my future holidays) I'll postpone HID-BPF to 6.3.

I actually thought of another way of removing that trampoline call. So
I'm not entirely going back to the drawing board hopefully.

[a few hours laters]

Just as a preview, I am reusing the bpf_link idea: when we call
hid_bpf_attach_prog(), this creates a bpf_link, and that link is the
one that needs to be pinned. Whenever all the references of that link
are dropped, I get called in the link's ->release() function, and I
can force the unbinding of the hid-device to the program at that time.

Way safer (no refcount mess up) and no optimisations can interfere,
now that I am not "tracing" the bpf core code.

Cheers,
Benjamin

