Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699178819F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbjHYIJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbjHYII7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7F1FF6
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692950893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9YDmP7EGByhxJ360XVPZoot7p/wWLTefjiD4Jsf+DI=;
        b=D5AdRIRQ+PsZyEehNHJdHa+xH1H+kqmVKop5dmLWK0ZgdruLAwUr4v1h1tMO9Kwc/281RX
        X+CqHzcYdcqDXUmJeGOvgarRwt7ids+lxYT+f+nSI2t9lqyJ+CnH43/9vPNmo+lF5E7GYt
        CSB2xAZgNSL8XD4gMbKdH0vkiwCcSO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Ig7gQghfO8ukmQa-XzVU0g-1; Fri, 25 Aug 2023 04:08:10 -0400
X-MC-Unique: Ig7gQghfO8ukmQa-XzVU0g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fefc7845a2so5699085e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 01:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692950887; x=1693555687;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9YDmP7EGByhxJ360XVPZoot7p/wWLTefjiD4Jsf+DI=;
        b=GDhf58yKxaajBXuD+ZHhFBVS82iYkRPm1JVxW14N9dv53S3xdr55CKdwpD+Vu3XKsI
         CcCmr6Kd8J31zHwI0sOubdvegVrb8EtcnVEo1pqrzcZXfDTu++pDtGyb93KDsYKYjLAZ
         PgnojkXH5I67R7ayRw7OjexK1ehJu9R1mLVbYFrDhayuNXuP4F1PWiGtzPkgHmFlX3de
         oLMR0jF72jT/ss1lPX6Ve0Im3bFqQKYfwDmA7gx3QGCFCjd4eaNXsIEs0pAdIbCzSb2q
         f1idFxfhLMNPZgc1b9arzoibyJuUNWAgcqrFLaVWSH8F4Inr9hSZCTdlyLyWjBCQo1kw
         dcLw==
X-Gm-Message-State: AOJu0YybxptS8u5sD65AOvkAjE7lJY9lUZviuSHFea7TDo4qVfFSpvZA
        8WSQYPKDxt/Ar2oE0heXRPapYCgnhTOuJODtb+xKeOSIiy3vn2MHwNqKHW8b0DMak7+f7X/4rdZ
        XgWGajHXw/M1K4pDSxA/4nPmx3kVv
X-Received: by 2002:a7b:cc8e:0:b0:401:b3a5:ec03 with SMTP id p14-20020a7bcc8e000000b00401b3a5ec03mr1618538wma.1.1692950887385;
        Fri, 25 Aug 2023 01:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB2QDeCnpUSinediuR+3DhAUb/uZh+8tLlW2HtMVIOL3fzEOVQGLx576P+9vuPymPt0laUbA==
X-Received: by 2002:a7b:cc8e:0:b0:401:b3a5:ec03 with SMTP id p14-20020a7bcc8e000000b00401b3a5ec03mr1618519wma.1.1692950887063;
        Fri, 25 Aug 2023 01:08:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:2bc:381::432? ([2a01:e0a:2bc:381::432])
        by smtp.gmail.com with ESMTPSA id k2-20020a7bc302000000b003fc06169ab3sm4672896wmj.20.2023.08.25.01.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 01:08:06 -0700 (PDT)
Message-ID: <56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com>
Date:   Fri, 25 Aug 2023 10:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
 <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
 <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
 <20230822214220.jjx3srik4mteeond@google.com>
Content-Language: en-US
In-Reply-To: <20230822214220.jjx3srik4mteeond@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Tue, Aug 22, 2023 at 11:42 PM Justin Stitt <justinstitt@google.com> wrote:
> > > > > Which kernel are you trying to test?
> > > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > > >
> > > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> > > >
> > > > I ran these exact commands:
> > > > |    $ make mrproper
> > > > |    $ make LLVM=1 ARCH=x86_64 headers
> > > > |    $ make LLVM=1 ARCH=x86_64 -j128 -C tools/testing/selftests
> > > > TARGETS=hid &> out
> > > >
> > > > and here's the contents of `out` (still warnings/errors):
> > > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
> > > >
> > > > I have a feeling I'm doing something fundamentally incorrectly. Any ideas?
> > >
> > > Sigh... there is a high chance my Makefile is not correct and uses the
> > > installed headers (I was running the exact same commands, but on a
> > > v6.4-rc7+ kernel).
> > >
> > > But sorry, it will have to wait for tomorrow if you want me to have a
> > > look at it. It's 11:35 PM here, and I need to go to bed
> > Take it easy. Thanks for the prompt responses here! I'd like to get
> > the entire kselftest make target building with Clang so that we can
> > close [1].

Sorry I got urgent matters to tackle yesterday.

It took me a while to understand what was going on, and I finally found
it.

struct hid_bpf_ctx is internal to the kernel, and so is declared in
vmlinux.h, that we generate through BTF. But to generate the vmlinux.h
with the correct symbols, these need to be present in the running
kernel.
And that's where we had a fundamental difference: I was running my
compilations on a kernel v6.3+ (6.4.11) with that symbol available, and
you are probably not.

The bpf folks are using a clever trick to force the compilation[2]. And
I think the following patch would work for you:

---
 From bb9eccb7a896ba4b3a35ed12a248e6d6cfed2df6 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 25 Aug 2023 10:02:32 +0200
Subject: [PATCH] selftests/hid: ensure we can compile the tests on kernels
  pre-6.3

For the hid-bpf tests to compile, we need to have the definition of
struct hid_bpf_ctx. This definition is an internal one from the kernel
and it is supposed to be defined in the generated vmlinux.h.

This vmlinux.h header is generated based on the currently running kernel
or if the kernel was already compiled in the tree. If you just compile
the selftests without compiling the kernel beforehand and you are running
on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
definition.

Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
to force the definition of that symbol in case we don't find it in the
BTF.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
  tools/testing/selftests/hid/progs/hid.c       |  3 ---
  .../selftests/hid/progs/hid_bpf_helpers.h     | 20 +++++++++++++++++++
  2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 88c593f753b5..1e558826b809 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -1,8 +1,5 @@
  // SPDX-License-Identifier: GPL-2.0
  /* Copyright (c) 2022 Red hat */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
  #include "hid_bpf_helpers.h"
  
  char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 4fff31dbe0e7..749097f8f4d9 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,6 +5,26 @@
  #ifndef __HID_BPF_HELPERS_H
  #define __HID_BPF_HELPERS_H
  
+/* "undefine" structs in vmlinux.h, because we "override" them below */
+#define hid_bpf_ctx hid_bpf_ctx___not_used
+#include "vmlinux.h"
+#undef hid_bpf_ctx
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+
+struct hid_bpf_ctx {
+	__u32 index;
+	const struct hid_device *hid;
+	__u32 allocated_size;
+	enum hid_report_type report_type;
+	union {
+		__s32 retval;
+		__s32 size;
+	};
+};
+
  /* following are kfuncs exported by HID for HID-BPF */
  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
  			      unsigned int offset,
-- 
2.41.0
---

Would you mind testing it?

Cheers,
Benjamin

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/bpf_iter.h#n3

