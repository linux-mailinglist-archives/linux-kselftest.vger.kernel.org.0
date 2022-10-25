Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9960D75F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYWwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJYWwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 18:52:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A4237F6;
        Tue, 25 Oct 2022 15:52:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 192so6277108pfx.5;
        Tue, 25 Oct 2022 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dscgs+ydXpa+zSr9O18VpmGVPw+9ObsVjtPwWI+z0tQ=;
        b=YpEuvcynWg6m4SNXhwiG02g9kX1rwoHcG5XAO5DXI5N1CjhuOjLvY2ZDo2dBun5MYl
         DpQkxtb+C4v0TiMyk3xrsZKr94rK6c1LoKqDTURSIOzNw1JwLhfvQMyQwaUQlZfZyKqL
         eqayQ8KDxmUAqbZxoAYiu7dZQCcPmiX1IX1jbFtOcbcpMIO202acV54izcEUekE0Th5b
         PFXfqYsIThxQcVU6KgoooAr7KoXWR2cA6IhxGupbPZTRogPhNcVsLLDS0ReUN65sqPDF
         ls9rufg6MPOe2epBvJMi0I5IZkvvW/hXL6EJ4B4/Q5jB1Pf7ldQqH0sU2jyCUaW4ao7U
         +pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dscgs+ydXpa+zSr9O18VpmGVPw+9ObsVjtPwWI+z0tQ=;
        b=oOT0CeH6AZvHoylZL7WUR9Lr37K5Hu6hYb4yc9IiFOdWBCa9QI8vf8ByRRxoize5Yd
         YAtVg5iriwmjJLDmxv5UJ1vBhUCZ7JEQLkN66qOUX81igzUu7xhl1rP37nSk1D6mh0Kx
         Pex/kWHPZdRFRXcJm5mzHig+uLZOYct9/C0FdKj4G4UXKZLup8/rVkXz8gurtON5PvQg
         V8z4oxkaM9KjEMeTR2CTfWq0FodWde3Gyqrd/6DzTdjzE9+UQ4v7vE+mwePKI/mQZSKQ
         IlSuz8yJd3iSjOranFjwiHySDpT7K/p9BGKclgm2GKOZUEodn8GvJ29FYo4PXD9bin4N
         9q/A==
X-Gm-Message-State: ACrzQf1uCK4gq3rymIfXd2zj7n7ZTkN723S7wDdaLy9+TSOyJBb8dMFr
        wEqGlLpiLS9s6/E7jehQ9oI=
X-Google-Smtp-Source: AMsMyM7p6gWAuxiYfm8U+Y/0FXoYG7KaQBMzcSl5jlvs7QKCqfk4eaNintgPpBQGcNis1bmNDJ/VsQ==
X-Received: by 2002:a05:6a00:234d:b0:561:f0c3:cde1 with SMTP id j13-20020a056a00234d00b00561f0c3cde1mr41159268pfj.34.1666738342857;
        Tue, 25 Oct 2022 15:52:22 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:500::5:9233])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561cf757749sm1834754pfz.183.2022.10.25.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:52:22 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:52:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH hid v11 02/14] HID: initial BPF implementation
Message-ID: <20221025225219.i3pi7ewue6xqeig4@macbook-pro-4.dhcp.thefacebook.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
 <20221025093458.457089-3-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025093458.457089-3-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 11:34:46AM +0200, Benjamin Tissoires wrote:
>  include/linux/hid.h                           |   5 +
>  include/linux/hid_bpf.h                       | 102 +++
>  include/uapi/linux/hid_bpf.h                  |  25 +
>  tools/include/uapi/linux/hid.h                |  62 ++
>  tools/include/uapi/linux/hid_bpf.h            |  25 +

...

> +++ b/include/linux/hid_bpf.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __HID_BPF_H
> +#define __HID_BPF_H
> +
> +#include <linux/spinlock.h>
> +#include <uapi/linux/hid.h>
> +#include <uapi/linux/hid_bpf.h>
> +
> +struct hid_device;
> +
> +/*
> + * The following is the HID BPF API.
> + *
> + * It should be treated as UAPI, so extra care is required
> + * when making change to this file.
> + */

I thought at the maintainer summit we discussed that it shouldn't be
treated as uapi. There is no need to draw this line right now.
If the whole concept turns out to be useful and api is stable
then promote it.

> +++ b/include/uapi/linux/hid_bpf.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_HID_BPF_H
> +#define _UAPI_HID_BPF_H
> +
> +#include <linux/const.h>
> +#include <linux/hid.h>
> +
> +/**
> + * enum hid_bpf_attach_flags - flags used when attaching a HIF-BPF program
> + *
> + * @HID_BPF_FLAG_NONE: no specific flag is used, the kernel choses where to
> + *                     insert the program
> + * @HID_BPF_FLAG_INSERT_HEAD: insert the given program before any other program
> + *                            currently attached to the device. This doesn't
> + *                            guarantee that this program will always be first
> + * @HID_BPF_FLAG_MAX: sentinel value, not to be used by the callers
> + */
> +enum hid_bpf_attach_flags {
> +	HID_BPF_FLAG_NONE = 0,
> +	HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
> +	HID_BPF_FLAG_MAX,
> +};
> +
> +#endif /* _UAPI_HID_BPF_H */

Not sure what is the purpose of this uapi file.
Since it's enum the progs can get it from vmlinux.h.

> diff --git a/tools/include/uapi/linux/hid.h b/tools/include/uapi/linux/hid.h
> new file mode 100644
> index 000000000000..3e63bea3b3e2
> --- /dev/null
> +++ b/tools/include/uapi/linux/hid.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + *  Copyright (c) 1999 Andreas Gal
> + *  Copyright (c) 2000-2001 Vojtech Pavlik
> + *  Copyright (c) 2006-2007 Jiri Kosina
> + */
> +#ifndef _UAPI__HID_H
> +#define _UAPI__HID_H

This is a copy of include/uapi/linux/hid.h ?
Probably should be a separate commit to make it obvious.
