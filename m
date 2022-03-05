Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C34CE41C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Mar 2022 11:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiCEKLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Mar 2022 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiCEKLe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Mar 2022 05:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24264D9E9
        for <linux-kselftest@vger.kernel.org>; Sat,  5 Mar 2022 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646475043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uP1EZwK12VovZoxEdkUXW5CRQDWRv4FFnOIIOb/Aux0=;
        b=IETLmhnA2bN+25e9unMKV7nVlOb8oK/9T0ip1WXwFapI6O7zzQT1grLRv8FzKhQ7lZNEZN
        Tlkg2/J0m326BVkPXfDe6tpPre4q+T5TaNzyjR1wq8Pt+dS2wEfEKe+HivOQZfOpi7GSSe
        dVeulamfmPK0sD5o4DswJaFyS1HH/So=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-x88na9xAOwaZgtcJn-3bzg-1; Sat, 05 Mar 2022 05:10:42 -0500
X-MC-Unique: x88na9xAOwaZgtcJn-3bzg-1
Received: by mail-pg1-f197.google.com with SMTP id j5-20020a63e745000000b00378c359fac3so5957466pgk.2
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Mar 2022 02:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uP1EZwK12VovZoxEdkUXW5CRQDWRv4FFnOIIOb/Aux0=;
        b=vGtI9W3x0lSYn5j3AtNJjCnaJJHj4GwWv0by7j6VOyaBaWn778jBxwLoYHPELXClTp
         t1gWFIYjpCHkiW7i8czNtyoDmdL79SaZAAL88B/731WCUXg0HYsm1RoWbx1Yq5pF5EGq
         cnwqQFRly9VAqUq9Pf4zn0YdQUHX3paQi5ktSXyouo8P4hEYp6eOY92J43m/+CjmhHnK
         btDak/y8gvO4VvF8o9SJ4y1eH5rtyo9xZylnRm7SN3AshUV6Sx8zglcgYaYFr8mEAEpo
         V0aZlR0L17n0sFCm6atfPqMct/39uS8KmsqZmYobJ9FR9m7IQWbcT0P+cCo6LcDMoeG5
         8kSw==
X-Gm-Message-State: AOAM533O23ef5TldNmTThv+dpcg72NhbbxgkrJCIOYWRrTVqnE6kvs5f
        o4BNIUBMkI7kH7BXKT+SlXwjphq2Fh/IPWRfctN1xZY2btY0LyARj0HIUJAUwmkGj9ESiPzcttG
        Wc3VPmE5l1rjK/Qj0q8EYL9nV1dJpjSaaUxWZQYJQPj36
X-Received: by 2002:a05:6a00:3006:b0:4f6:54ba:3581 with SMTP id ay6-20020a056a00300600b004f654ba3581mr3132718pfb.83.1646475041662;
        Sat, 05 Mar 2022 02:10:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdMa4XGi5GgPncj0jNwlqnMBkbMcQKLgvKlNPPZy7+Ffim9IJzJb2EaijCC7uk1SuFaJIhvGBjTDkg2OrP65M=
X-Received: by 2002:a05:6a00:3006:b0:4f6:54ba:3581 with SMTP id
 ay6-20020a056a00300600b004f654ba3581mr3132702pfb.83.1646475041419; Sat, 05
 Mar 2022 02:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-6-benjamin.tissoires@redhat.com> <CAPhsuW63HQE_GWFrz-t9_Uyq3KK3raYeG_x7OYMGR02DHzQ1=g@mail.gmail.com>
In-Reply-To: <CAPhsuW63HQE_GWFrz-t9_Uyq3KK3raYeG_x7OYMGR02DHzQ1=g@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 5 Mar 2022 11:10:30 +0100
Message-ID: <CAO-hwJLuwiHgzmRonNBOU3yOZJBkBVktqgSC8yzHi_UwnSUyNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/28] selftests/bpf: add tests for the
 HID-bpf initial implementation
To:     Song Liu <song@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 5, 2022 at 1:41 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 9:31 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The test is pretty basic:
> > - create a virtual uhid device that no userspace will like (to not mess
> >   up the running system)
> > - attach a BPF prog to it
> > - open the matching hidraw node
> > - inject one event and check:
> >   * that the BPF program can do something on the event stream
> >   * can modify the event stream
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
>
> Does this test run with vm (qemu, etc.)? Maybe we need to update
> tools/testing/selftests/bpf/config ?

Good point. I'll give it a shot. I was testing on my devel machine so
it was quicker to iterate, but I completely forgot to make a run at
qemu with the scripts in place.

Cheers,
Benjamin

>
> Thanks,
> Song
>

