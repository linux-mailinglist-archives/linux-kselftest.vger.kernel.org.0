Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A41FB5DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgFPPRP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 11:17:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729627AbgFPPRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 11:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592320633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DzSD8rSRTPiP9kOLG6lDIkt11X+pbq+5vdEcao3or80=;
        b=YkmdHbLdB2iEZcrtuY3a01kWx34/K3ukB35/oD6VqXcPBXBONGOExmU6BNPFv/Oyb58DRh
        oK9TRlnycHwH2Oc/FPvvB7WJsKSUSAjiULxhOtECp+UMy7GhhkYhi45aakcfENpxremPUx
        VPNrv6XVK820Ke+dhyVWTSLAcWpREUk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-vMcJReZgPjeUXGPQt3MplQ-1; Tue, 16 Jun 2020 11:17:11 -0400
X-MC-Unique: vMcJReZgPjeUXGPQt3MplQ-1
Received: by mail-qv1-f71.google.com with SMTP id a4so13991235qvl.18
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzSD8rSRTPiP9kOLG6lDIkt11X+pbq+5vdEcao3or80=;
        b=Glf9vBkvhYPkwL2Ui3y2YO2cCi73ar1q6MlKjuN9XUpcMQtHcmWBnAtJ0m9w38P7vv
         kU2imLZKgwAa2JkRlQUp+OCNWjcOQWHwODyJXBbDj8BC6Nqy2+gkjc5mxRvyxD1h4e1S
         TT0LoQa2aAaF+0P0Cc4SERNbyxfKLrsTCPXDNC6YJxpfDe3eEDroM8gjGfS3zgTYLEZX
         BXZFwr4InAmYnZiPBj5aNPBfMaK/burjd9Y5jyh+yTBCT3/g/5ZjrJtQ8YuuOZak80fs
         G0loFKkk9ByB1+MYNBAeN8Z+zJKSMazP5BzZfXisrZM3lGFVouX9A6V4yeZq1Y3Ehghr
         W+AA==
X-Gm-Message-State: AOAM5338/09qbQneidJuPTHdAgknQXGDTtfHnXgl61RQ1qJGPSp1Un31
        sx6Sm+zIcWxOSkk9JJAWt8AWd4uxj1Vh7qPE6Y2Ya3W/grpGrq+j2rVlGb+frtJIk6oYHrCh9Tr
        iEaMZVQGIffFnyTa0GsOlgXLFg4SN7tPA977PlKgkIiIX
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr20659812qkj.94.1592320631198;
        Tue, 16 Jun 2020 08:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhfVwldfmQoamEb+64JZ052zy0sJJmSX0MiLsUc9HmsYRQbP8S1iPl67CiWVSZtG/RGJJ0JSpBxFEGdvVhaVU=
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr20659789qkj.94.1592320630943;
 Tue, 16 Jun 2020 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200615172756.12912-1-joe.lawrence@redhat.com>
In-Reply-To: <20200615172756.12912-1-joe.lawrence@redhat.com>
From:   Yannick Cote <ycote@redhat.com>
Date:   Tue, 16 Jun 2020 11:16:59 -0400
Message-ID: <CAKMMXfbE1kfGnXZoC=rG_zVfE+0JndsBt4Azh8BLJ4HJVKAikQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] selftests/livepatch: small script cleanups
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For the series:

Reviewed-by: Yannick Cote <ycote@redhat.com>

On Mon, Jun 15, 2020 at 1:28 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> This is a small collection of tweaks for the shellscript side of the
> livepatch tests.  If anyone else has a small cleanup (or even just a
> suggestion for a low-hanging change) and would like to tack it onto the
> set, let me know.
>
> based-on: livepatching.git, for-5.9/selftests-cleanup
> merge-thru: livepatching.git
>
> v2:
> - use consistent start_test messages from the original echoes [mbenes]
> - move start_test invocations to just after their descriptions [mbenes]
> - clean up $SAVED_DMSG on trap EXIT [pmladek]
> - grep longer kernel taint line, avoid word-matching [mbenes, pmladek]
> - add "===== TEST: $test =====" delimiter patch [pmladek]
>
> Joe Lawrence (4):
>   selftests/livepatch: Don't clear dmesg when running tests
>   selftests/livepatch: use $(dmesg --notime) instead of manually
>     filtering
>   selftests/livepatch: refine dmesg 'taints' in dmesg comparison
>   selftests/livepatch: add test delimiter to dmesg
>
>  tools/testing/selftests/livepatch/README      | 16 +++---
>  .../testing/selftests/livepatch/functions.sh  | 32 ++++++++++-
>  .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
>  .../selftests/livepatch/test-ftrace.sh        |  4 +-
>  .../selftests/livepatch/test-livepatch.sh     | 12 +---
>  .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
>  .../testing/selftests/livepatch/test-state.sh | 21 +++----
>  7 files changed, 63 insertions(+), 81 deletions(-)
>
> --
> 2.21.3
>

