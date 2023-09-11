Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1379AD69
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjIKVTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbjIKNjx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 09:39:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA7CC3;
        Mon, 11 Sep 2023 06:39:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D03C433C7;
        Mon, 11 Sep 2023 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694439588;
        bh=+9srjINeKNt/1Wh3YwTUXUqr5Tf9xG7aEal0R+t5o3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtrGc7bTRKLv4EUs0y1DkLGPtq+xhldaIQ+Bbhd1GOXJ9q4Fkd2IEeWlWol7B8Hod
         EM7Qv0lYJbhCch5pEv9KD5t44AuP0BTZLdv5zUrAgxOniuoe6gHmBr8f/ZoR881G3q
         qZVZmG1RmNK006SsQEEC/tVAs2Ru3t8kQyF1kXNUB9rGqy632xS2IuihWE9hQPnCwC
         Yacd2Cvmw2akSUzLHU78i0XJJ4NCZd1f4Nb5Uw1XIPXpTK05SUNcmwE//kok3Q0N2C
         Fj5aGVs6z0nN0/06Ajhwf4FGHQEEngfXz9/kTp4X6RkXm3YN4pcQEewZ26flJ9nAs6
         4B4UsVy5r6EVw==
Date:   Mon, 11 Sep 2023 15:39:43 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests/hid: ensure we can compile the tests on
 kernels pre-6.3
Message-ID: <hnmbc2vo6ylihwvxbmtiylw6kseqbyk5iydne4vmshssjhrcac@ijbyzhoeag34>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
 <20230908-kselftest-09-08-v2-1-0def978a4c1b@google.com>
 <d168d22ba2133d3b38a09ee0e8dbbe0fa97f72d0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d168d22ba2133d3b38a09ee0e8dbbe0fa97f72d0.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sep 11 2023, Eduard Zingerman wrote:
> On Fri, 2023-09-08 at 22:22 +0000, Justin Stitt wrote:
> > From: Benjamin Tissoires <bentiss@kernel.org>
> > 
> > For the hid-bpf tests to compile, we need to have the definition of
> > struct hid_bpf_ctx. This definition is an internal one from the kernel
> > and it is supposed to be defined in the generated vmlinux.h.
> > 
> > This vmlinux.h header is generated based on the currently running kernel
> > or if the kernel was already compiled in the tree. If you just compile
> > the selftests without compiling the kernel beforehand and you are running
> > on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
> > definition.
> > 
> > Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
> > to force the definition of that symbol in case we don't find it in the
> > BTF and also add __attribute__((preserve_access_index)) to further
> > support CO-RE functionality for these tests.
> > 
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  tools/testing/selftests/hid/progs/hid.c            |  3 --
> >  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++++++++
> >  2 files changed, 49 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
> > index 88c593f753b5..1e558826b809 100644
> > --- a/tools/testing/selftests/hid/progs/hid.c
> > +++ b/tools/testing/selftests/hid/progs/hid.c
> > @@ -1,8 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2022 Red hat */
> > -#include "vmlinux.h"
> > -#include <bpf/bpf_helpers.h>
> > -#include <bpf/bpf_tracing.h>
> >  #include "hid_bpf_helpers.h"
> >  
> >  char _license[] SEC("license") = "GPL";
> > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > index 4fff31dbe0e7..ab3b18ba48c4 100644
> > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > @@ -5,6 +5,55 @@
> >  #ifndef __HID_BPF_HELPERS_H
> >  #define __HID_BPF_HELPERS_H
> >  
> > +/* "undefine" structs in vmlinux.h, because we "override" them below */
> 
> Hi Justin,
> 
> What you have here should work, however I still think that the trick
> with "___local" suffix I refer to in [1] is a bit less hacky, e.g.:
> 
>     enum hid_report_type___local { ... };
>     struct hid_bpf_ctx___local {
>        __u32 index;
>        const struct hid_device *hid; // this one should be in vmlinux.h with any config
>        __u32 allocated_size;
>        enum hid_report_type___local report_type;
>        union {
>            __s32 retval;
>            __s32 size;
>        };
>     } __attribute__((preserve_access_index));
>     
>     enum hid_class_request___local { ... };
>     enum hid_bpf_attach_flags___local { ... };
>     ...
>     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
>                                   unsigned int offset,
> 
> 
> (sorry for being a bore, won't bring this up anymore).

No need to apologies for trying to make the code better :)

I specifically asked Justin to not use this because I intend the
examples to be here to use the same API in the selftests dir than users
in the wild. So if your suggestion definitely makes the header code
much better, it also means that everybody will start using `___local`
annotations for anything HID-BPF related, which is not what I want.

This header file is supposed to be included in the BPF, and IMO it's not
that important that we have the cleanest code, as long as the users have
the proper API.

Feel free to share your concerns :)

Cheers,
Benjamin

> 
> Thanks,
> Eduard
> 
> [1] https://lore.kernel.org/bpf/e99b4226bd450fedfebd4eb5c37054f032432b4f.camel@gmail.com/
> 
> > +#define hid_bpf_ctx hid_bpf_ctx___not_used
> > +#define hid_report_type hid_report_type___not_used
> > +#define hid_class_request hid_class_request___not_used
> > +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> > +#include "vmlinux.h"
> > +#undef hid_bpf_ctx
> > +#undef hid_report_type
> > +#undef hid_class_request
> > +#undef hid_bpf_attach_flags
> > +
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <linux/const.h>
> > +
> > +enum hid_report_type {
> > +	HID_INPUT_REPORT		= 0,
> > +	HID_OUTPUT_REPORT		= 1,
> > +	HID_FEATURE_REPORT		= 2,
> > +
> > +	HID_REPORT_TYPES,
> > +};
> > +
> > +struct hid_bpf_ctx {
> > +	__u32 index;
> > +	const struct hid_device *hid;
> > +	__u32 allocated_size;
> > +	enum hid_report_type report_type;
> > +	union {
> > +		__s32 retval;
> > +		__s32 size;
> > +	};
> > +} __attribute__((preserve_access_index));
> > +
> > +enum hid_class_request {
> > +	HID_REQ_GET_REPORT		= 0x01,
> > +	HID_REQ_GET_IDLE		= 0x02,
> > +	HID_REQ_GET_PROTOCOL		= 0x03,
> > +	HID_REQ_SET_REPORT		= 0x09,
> > +	HID_REQ_SET_IDLE		= 0x0A,
> > +	HID_REQ_SET_PROTOCOL		= 0x0B,
> > +};
> > +
> > +enum hid_bpf_attach_flags {
> > +	HID_BPF_FLAG_NONE = 0,
> > +	HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
> > +	HID_BPF_FLAG_MAX,
> > +};
> > +
> >  /* following are kfuncs exported by HID for HID-BPF */
> >  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> >  			      unsigned int offset,
> > 
> 
