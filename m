Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0244EB59
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhKLQbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 11:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhKLQbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 11:31:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75FC061767
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 08:28:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c4so16442958wrd.9
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jm/9aT9jRBR6ZhI5+PJGLeU9Rc0MA4U4sjZIHizRX90=;
        b=qY3KcSprmORov8UU3vOQUJruSJCu+OT1KY1RTSiBfoB6ltMs/mR7ruQKBDyYycNTOb
         LvrveW+A0nBZzGzWPLKn9f8M2OCVn2sEkz8HiRd9s2EbLqBj8TbkrMuOwtPQ71iJbeF9
         XSm+fHOMriUiPKhT0vMvH+Dod5RlSoPQBZvx7QcnJEpwKkAyttHqDj1n8177ylG12Rtt
         M0psdL+Ewzedqf9WnHmHClOlmkel2NfoZvjno3aisPVk545nQjiHcTXflZS/W/m1XRQg
         WtkoARhjkmgEB4ctZucKYK948vAvB4eyyUBvOnlY3N5VbvTLlVMrxUm5MMN6FWoBZ/tY
         zieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jm/9aT9jRBR6ZhI5+PJGLeU9Rc0MA4U4sjZIHizRX90=;
        b=2bKZuQVWsTXEMcoL285IJ5VvGF90Y1YvCSFpAwB3ZGDMmuMl9zE4J4bXVw0V1HhJgE
         lwftHbe75HmCMl5yMrqVOcfv8wYoyG/0DwtDJ3KzWA+jzuXM5q52CDGE+0by01lTUEC9
         hHr9TT9L51hh88t8fs6L9WGkmI1QxGgAq/x9qhNmdQ0qXx5ttD/b8pjUT1YgVTXdwd9C
         rcjuNmNLj0eS/0kEPDs+fhbdUq0JD7QZzgkb/u91iafUs/UP+O8mtajJsuG7bq0Opoem
         XABN3OrA67HPo1i/HWGSB5ag4BOx+q9fEQXOYOYpYfbtX5KBUymmGLahQDZTgODWaztc
         AF5A==
X-Gm-Message-State: AOAM533G3pcEaOn+UZWXhiunYfBkVTTPVe0zLymVwss8UoymB3U2pRvB
        h918VFiw7ZyczmLVCehJkYH7DA==
X-Google-Smtp-Source: ABdhPJzvGDi2wEcjn4Lt8KrrqyaiABRoewpQXovZoe5KQO+xO9F5kAUc1df+smSlUYAjFKwfVdJL4Q==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr19581890wrw.439.1636734530376;
        Fri, 12 Nov 2021 08:28:50 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q8sm5973962wrx.71.2021.11.12.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:28:50 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:28:28 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
Message-ID: <YY6WLDizLBxnhgnP@myrica>
References: <20211112155128.565680-1-jean-philippe@linaro.org>
 <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 12, 2021 at 04:17:21PM +0000, Quentin Monnet wrote:
> 2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> > building") uses the target libbpf to build the host bpftool, which
> > doesn't work when cross-building:
> > 
> >   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
> >   ...
> >     LINK    /tmp/runqslower/bpftool/bpftool
> >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
> >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
> >   collect2: error: ld returned 1 exit status
> > 
> > When cross-building, the target architecture differs from the host. The
> > bpftool used for building runqslower is executed on the host, and thus
> > must use a different libbpf than that used for runqslower itself.
> > Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> > build makes its own library if necessary.
> > 
> > In the selftests, pass the host bpftool, already a prerequisite for the
> > runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> > the bpftool that's already built for selftests instead of making a new
> > one.
> > 
> > Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> I realised too late I should have cc-ed you on those patches, apologies
> for not doing so. Thank you for the fix!

No worries, I usually try to catch build issues in bpf-next but missed it
this time. I'm still slowly working towards getting automated testing on
Arm targets, which will catch regressions quicker.

Thanks,
Jean
