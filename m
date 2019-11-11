Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A27F764F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKOWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 09:22:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42520 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKOWo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 09:22:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so13995435ljc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2019 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q6Ic4KHmL2oPLqwtq9oO2+Aaxq9lOPnDyaM0GuYG2s=;
        b=tSG6cZwTtukcRbi0eWqvq7DsBDFbFCmFCycdd3bvXfB330J8jnwEY7rnaqH+QvOQhq
         eBqdU45xQm40U7dcNo5iOp3DFWmZE9KIJfYrPxUpAAAzd+W8vJUZR9WO77NdTj8ms9Dv
         GeZhBDpleHJtZmIwtsuJg4dERBUz7nzy//j8d6dDN9SiYCsCcIKEcrfvyMpT11NlP3JM
         e9nwqiM8WrotCAvlD8b5bY26WrZm2YihssZatloCz+sY/IkHUAQn5uEL5WjJbHciAIJq
         B94uX2vXQpNUBLcrBbmL5GmhWKLo032BP3kcyxs37uPIb3NQxxU5YxC17vhgwfiRR6Wl
         dAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q6Ic4KHmL2oPLqwtq9oO2+Aaxq9lOPnDyaM0GuYG2s=;
        b=fnSdZs/n3Jd05/b9ku/hKeYBE+PKyqA/gkgMPap7h63CsryUuxGuW9u4rdigfEwf2a
         cYYQp+KdvO9HzOPJCETwAev1IdV7OorWzhucAWBTEIAsTD14uupL9cUHd2HrBMirS17J
         KaIbACSAclZoHoeDcdtkR40kquxPE6ggzGcNWxNzhw5hDZMpBGG2+OUsYwqOSNfjp9JX
         zMEkPWEzlP6FYJtGO15qgTaeoGfCFp87qgwM2QARkidPSxPUq/PuDMpGrSvOt+flisbP
         zJnB4gDDS3DFAMKTgRkdCA700sfCOM+CIqaDTkH4kXkVwbt1imwX6pMVuePTAFdjnapm
         Iztg==
X-Gm-Message-State: APjAAAXRgELa7snfZtN2P4GuCbSs0FA1GwsCqAhEHxocsg6toINi6Ah9
        T+z6hfY+6LzhaFvJcMEELlN34sRYT8VVXe5GRvhVSQ==
X-Google-Smtp-Source: APXvYqy2MkTs4zJnjZqb4OH8Xuxf9ZqN/TQMc4ey0G7YfcEEFe7Wou5fJUTTyGh7rgcPFJZs7XDxwut1mDuZPxufmIU=
X-Received: by 2002:a2e:b163:: with SMTP id a3mr15817576ljm.72.1573482162152;
 Mon, 11 Nov 2019 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20191110092616.24842-1-anders.roxell@linaro.org>
 <20191110092616.24842-2-anders.roxell@linaro.org> <20191111124501.alvvekp5owj4daoh@netronome.com>
 <4ce79d06-e8af-6547-240d-50e3038a6ae7@iogearbox.net>
In-Reply-To: <4ce79d06-e8af-6547-240d-50e3038a6ae7@iogearbox.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 11 Nov 2019 15:22:31 +0100
Message-ID: <CADYN=9KHgAq5Birmba-imeZeFtgQW=d_EVzh5p+h74fxv4HRew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: test_tc_edt: add missing
 object file to TEST_FILES
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 Nov 2019 at 14:01, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/11/19 1:45 PM, Simon Horman wrote:
> > On Sun, Nov 10, 2019 at 10:26:16AM +0100, Anders Roxell wrote:
> >> When installing kselftests to its own directory and running the
> >> test_tc_edt.sh it will complain that test_tc_edt.o can't be find.
> >>
> >> $ ./test_tc_edt.sh
> >> Error opening object test_tc_edt.o: No such file or directory
> >> Object hashing failed!
> >> Cannot initialize ELF context!
> >> Unable to load program
> >>
> >> Rework to add test_tc_edt.o to TEST_FILES so the object file gets
> >> installed when installing kselftest.
> >>
> >> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> >> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >> Acked-by: Song Liu <songliubraving@fb.com>
> >
> > It seems to me that the two patches that comprise this series
> > should be combined as they seem to be fixing two halves of the same
> > problem.
>
> Yep, agree, please respin as single patch.

OK I'll respin it to a single patch.

Cheers,
Anders
