Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7777F26330E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgIIPvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbgIIPvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487DC061757
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 08:51:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so4275860ejf.6
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=j+YHjrcPZ12jt2TR6VZ0SQLasTjXLm4QzCvH5I2QEq+TUS19U2aDKWvL4m3OSGEwX1
         27sy149nq1tT/ngLrFPEjv3Qwi7oeD6dbVzHxonhKo90/tZwF9WN8vcMJDyd50A8sMrL
         DzAzS4WAx8T4ldCFNWw2BLm0vsDAwPZU3f0wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=HU81Eed2leYyy+XyDYmLxv+yQ++ADM4rvQtC9RFmBWQiny/O2/MJ0lSQITPMrzB/PR
         bGkyjwTPOVSfvf0pAJsnWCIeV8Zm/7g2OzhNllgkWesBAMBVx9eeUrd8MpBpb8cxVjDp
         RayvmkwONyaimwZNAOsEz9O5o/cojdOG8BQIrox4s/6xf5lBu6cXzP6rlSzi1GTT08yg
         4HfxJ8z0DYB+ONMsePXSWrsEflvNKOxFhbC5wdnkQEk3kbK3zyzaOJ6hR5t6QesPNuFh
         T9Er92zNf2WQCdA7yuxdTwSdTP5gRdrWHSQcSK7fZrxOIyo7yqoCUGnxbwubT96Mpv8B
         bBcQ==
X-Gm-Message-State: AOAM530c7Gv435FCB3YDsGXBNInbQgqhjdVEAlWOkE25oP9r85cTaxk0
        blI5ljnZrc8SZG28IJBLSeUA7IV6G9IWLA==
X-Google-Smtp-Source: ABdhPJz4omn7xn5oarwE9DaIvcjRznlDer5axIP/K0pZRRWh+H3707/dTbc+SNR8I4dYo/EdSz5STg==
X-Received: by 2002:a17:907:2055:: with SMTP id pg21mr4432456ejb.501.1599666666614;
        Wed, 09 Sep 2020 08:51:06 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ec11sm2812324ejb.123.2020.09.09.08.51.03
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 08:51:05 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id r7so4235648ejs.11
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
X-Received: by 2002:a17:906:cec9:: with SMTP id si9mr4172770ejb.351.1599666663650;
 Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200827170947.429611-1-zwisler@google.com> <20200827200801.GB1236603@ZenIV.linux.org.uk>
 <20200827201015.GC1236603@ZenIV.linux.org.uk> <20200827202517.GA484488@google.com>
In-Reply-To: <20200827202517.GA484488@google.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 9 Sep 2020 09:50:52 -0600
X-Gmail-Original-Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Add a "nosymfollow" mount option.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 27, 2020 at 2:25 PM Ross Zwisler <zwisler@google.com> wrote:
> On Thu, Aug 27, 2020 at 09:10:15PM +0100, Al Viro wrote:
> > On Thu, Aug 27, 2020 at 09:08:01PM +0100, Al Viro wrote:
> > Applied (to -rc1) and pushed
>
> Many thanks!

(apologies for the resend, the previous one had HTML and was rejected
by the lists)

Just FYI, here is the related commit in upstream util-linux:

https://github.com/karelzak/util-linux/commit/50a531f667c31d54fbb920d394e6008df89ae636

and the thread to linux-man, which I will ping when the v5.10 merge
window closes:

https://lore.kernel.org/linux-man/CAKgNAkiAkyUjd=cUvASaT2tyhaCdiMF48KA3Ov_1mQf0=J2PXw@mail.gmail.com/
