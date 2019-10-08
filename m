Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D394DCF99B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfJHMQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 08:16:37 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42427 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbfJHMQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 08:16:37 -0400
Received: by mail-qt1-f170.google.com with SMTP id w14so24856693qto.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMRBEmvr/0+C4eSur48+05eunJVcl+/Y23nSATspD+o=;
        b=FGj96vJFdgIaORXYiNbhFecOtCzt4j/C2xMW+MPxiqQ/1rngL70lWAD9rs827oxlKn
         tysP07UFMggTAC4WLoZuvFL0xAHfP5su+GC0CQjtu30LTbInUXN0eNS+oL4+dTDYRPNy
         QrOhLcGTh2fbbg+h5lRD8TC92UfWT+iseqWsxxoqKJT6QL+yTdxcsTYlc3sXRygZVcEP
         P2rXFc68H6tc2HHj5J+Ymwd6xxZiLDptfbPRw3Fd4KgxP0jycZDz5gYyglKU5W4yd5wq
         uzqYTphwcEkdsEfiRKqcu2F/QS8AKUKPgMIl5GCTS4xGcKH+ae22QROaEsTuxtN+0Z2E
         rtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMRBEmvr/0+C4eSur48+05eunJVcl+/Y23nSATspD+o=;
        b=L9LJ/na7WpayiKJowyuX0O58iWpEe5oInVUFTTZ/LEe2PYe7m/Cd5EMZ39bmQYqiV1
         K/oBACeOxdjeZENi/lV59b0sKU+qxKfAJUdk1cR/GZ/7SJNGw4YlmTqIMnyAmjfn97kL
         vfMrxwKcN7st6Yf607FTRQHasopyvwk4tCMOf7E1BptNagQKVogZqRauMAd7rcc0xDIn
         2TJqK/3pdzEI/vZgzQ4AMiOnNUvYy0MbqGZSjEP99U///TvQhkx75YoETGShQVpfvbz9
         t2fEzQk5S7f3ANxgegWgBgGjgu0QlE8Bgi4sh+KaabSOr0VI4QrsCgs4CplG/G1NzPau
         vdyA==
X-Gm-Message-State: APjAAAWv9b9ryoaALXMNE5ONoLcMjp/xcQJOIh9BaJJMod7EhL4ntN3R
        FTpLBFfVwXaebDwCid4f9FgNh300xE2KlrBoY9Rr/g==
X-Google-Smtp-Source: APXvYqxMyFJnZAQcVvA9CTZ54QUsrCp4849HLutjfyoNsGiW3lnJeBJ3sj2MhCPNU/U9W9Ox2ajx/n7bKu8eKaqIa6g=
X-Received: by 2002:ac8:646:: with SMTP id e6mr6456151qth.57.1570536995827;
 Tue, 08 Oct 2019 05:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
In-Reply-To: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Oct 2019 14:16:24 +0200
Message-ID: <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
Subject: Re: syzkaller reproducers
To:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        George Kennedy <george.kennedy@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 8, 2019 at 1:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hi Shuah,
>
> We discussed collecting and uploading all syzkaller reproducers
> somewhere. You wanted to see how they look. I've uploaded all current
> reproducers here:
> https://github.com/dvyukov/syzkaller-repros
> Minimalistic build/run scripts are included.
> +some testing mailing lists too as this can be used as a test suite
> If you have any potential uses for this, you are welcome to use it.
> But then we probably need to find some more official and shared place
> for them than my private github.
> The test programs can also be bulk updated if necessary, because all
> of this is auto-generated.
>
> Thanks

+more people who expressed interest in the test suite before
