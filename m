Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB630F48B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhBDOFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 09:05:13 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34338 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbhBDOCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 09:02:48 -0500
Received: by mail-oi1-f181.google.com with SMTP id h192so3808131oib.1;
        Thu, 04 Feb 2021 06:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeTSTNxgLE2BT0GTudXgmFb4g9IjjW+lbLXDMlVfRik=;
        b=TayjHr3xoIKT+tycHZA5L2VXO5R5KwW4ABcVHRuhzsTTWhVo5RFpIJtAgBAi0MrrXL
         6VYj0Atyszn93pH08SAF1mERLAaAoU1ZmFv6SGmsMGlW88/8s8Br8gIUC0HMc0FUzySV
         GvZwdpv+UB+h8ZsQYotxm/+J77HGIQoYNlJlJauhoYAxY527s0rNB01EX3LU+iirdAAS
         +aZoVfFTBFWR/FBG2f7Zvvh/02GvhadZzxvAmRgi+fM3h4Zg5H19KyRyUNhe75H/SIRM
         37ueKvjAgrBt/uBi/+xRpdgpfA/lPFO59E+qfSNs9SeXA5vRAUHx3yvVjrmNyznPCGmq
         hFqQ==
X-Gm-Message-State: AOAM531nxWUbs5tx1XeGvY5NGpCwiobZonpIyxfKpIsNqZqO68wXC414
        8cGkRiStr94W5pQMOZuqOwW6vgS3jOEhlNCWq9U=
X-Google-Smtp-Source: ABdhPJwIMkZ9crB5RzPfP0aiVhmh61qrbaAU2HVxqJSpznq2cpzmYfpLAgUbYTQO/oABbafz5fjdh/q7MscPh0Ye06E=
X-Received: by 2002:aca:308a:: with SMTP id w132mr5018580oiw.69.1612447327733;
 Thu, 04 Feb 2021 06:02:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612314468.git.skhan@linuxfoundation.org> <8d11eec80d6668065fb35a0b025c3614b67bf798.1612314468.git.skhan@linuxfoundation.org>
In-Reply-To: <8d11eec80d6668065fb35a0b025c3614b67bf798.1612314468.git.skhan@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 15:01:56 +0100
Message-ID: <CAJZ5v0i8-HpSAk=HGOgVN1RTLup4Rh0WTt0H3LQh1EfuWE-e+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drivers/acpi: convert seqno to use seqnum_ops
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

First off, please indicate the component in the subject, for example:

"ACPI: extlog: convert seqno to use seqnum_ops"

On Wed, Feb 3, 2021 at 7:12 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Sequence Number api provides interfaces for unsigned atomic up counters
> leveraging atomic_t and atomic64_t ops underneath.
>
> Convert seqno atomic counter to use seqnum_ops.

Apart from the above, it would be good to say why the change is an improvement.

It looks like the rationale is that using struct seqnum32 would allow
tools to easily detect the usage of sequence numbers, but is there
anything else in this particular case?

> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/acpi/acpi_extlog.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 72f1fb77abcd..16a4928645a1 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
>  #include <linux/ras.h>
> +#include <linux/seqnum_ops.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
>
> @@ -93,8 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
>  static void __print_extlog_rcd(const char *pfx,
>                                struct acpi_hest_generic_status *estatus, int cpu)
>  {
> -       static atomic_t seqno;
> -       unsigned int curr_seqno;
> +       static struct seqnum32 seqno;
>         char pfx_seq[64];
>
>         if (!pfx) {
> @@ -103,8 +103,8 @@ static void __print_extlog_rcd(const char *pfx,
>                 else
>                         pfx = KERN_ERR;
>         }
> -       curr_seqno = atomic_inc_return(&seqno);
> -       snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
> +       snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx,
> +                seqnum32_inc(&seqno));
>         printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
>         cper_estatus_print(pfx_seq, estatus);
>  }
> --
> 2.27.0
>
