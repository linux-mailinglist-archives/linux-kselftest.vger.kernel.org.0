Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405B617282F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgB0SzL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 13:55:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgB0SzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 13:55:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so35570wrx.11
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V85YaAe8XR5oTJ96oXQ+ABPr+snDJtWcbgtmR0Qea4=;
        b=tvcOJ69LptQiNyIzqDTnQbb+0cH7+bJsKcKVrNn1ocnZu1vLfyskMvmxRkGO+mGr6u
         f2Ykbd9OTXcEGdrbFghUU1KgIrUIZeOT43FiPQgbZRlL5KpRxgL7wWg0AAtfFXJ0iWYR
         rpZj5k8cq/Fp+cVgo7T3U3PhCnOqckMoOQvYGsdHsn6A2+2q/7ejTDo3ypiwxgF5OwVe
         F2QO4IFnWh9b1iHODVBOjreYygP/18KqrjJpFhKp5RCQZWJ7p8R3/puyepM9lHxSvtFr
         QoX+v1NzdKAwqdlfF/td6PRIx8bVx/j3EGSJjuLCOzduvVqHMmIQ6DkYAG7ppOvqtkdR
         wIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V85YaAe8XR5oTJ96oXQ+ABPr+snDJtWcbgtmR0Qea4=;
        b=pcu5gNiAgDUOsX+xx74aLBu44l8P3lLI61lfBTqxgLunmGMqy+5w4YZicPhRcl2gJD
         Y2RnuoQrMj7PQhLwTWHIjRcdbyZMNS7kS1N88LuWIh3llBzebq+M/OZFKnABEH7wN2u+
         C0MHM6egL0G+MXDKA0ImZOZTvlLsDP55xL8OC8lGRTxnOZTC80ncIbtAZr6rsqfVAT4c
         wOs+elutHLYRa1pwfMgS1AFhRh/BlfmBHcHJmSBsOpXZnr+6xXYDRGiWvKq++EPU49CR
         aC+GEu1SYL4YbOpDl2BEjgw/KlQbNUhujVXuQBiOPaOkfUenJVlU/4OT6q6z4VQOIOEQ
         pSUw==
X-Gm-Message-State: APjAAAUVLQNOGAS363Dkss5oAyiu4CyjpZQW9XEFQyXWGKcGycyiLKM2
        vacV85v/3tmnweOH0Bcj/QaNCvORqmnJyA27i7Wg4w==
X-Google-Smtp-Source: APXvYqxqsioMAn9f18ckX2JCivtKIQRNEzVlRJ7K9EUTjk60nx17Q4stuJaYzodA9hVo7BuMRtl7HCJdy9LJNH66dxI=
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr248687wrp.203.1582829708486;
 Thu, 27 Feb 2020 10:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20200227063134.261636-1-gthelen@google.com>
In-Reply-To: <20200227063134.261636-1-gthelen@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Feb 2020 10:54:56 -0800
Message-ID: <CABVgOSkdphVaWhL1bBpC-vBgJ5pS144wD_g588o2_xxHXd=Ngg@mail.gmail.com>
Subject: Re: [PATCH] kunit: add --make_options
To:     Greg Thelen <gthelen@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31 PM 'Greg Thelen' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
>
> This allows use of the clang compiler for kunit:
>   tools/testing/kunit/kunit.py run --defconfig \
>     --make_options CC=clang --make_options HOSTCC=clang
>
> Signed-off-by: Greg Thelen <gthelen@google.com>

Tested-by: David Gow <davidgow@google.com>

Nice! This worked for me with all of the options I tried (and it's
great to see KUnit working on clang builds!)

-- David
