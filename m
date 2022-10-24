Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF360ADBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Oct 2022 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiJXOdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiJXOc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 10:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B1D018F
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666616665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trlf8J9SEf2L59s+RkYAnLixFP1fn9n6wg9XCVdSXj8=;
        b=KTnqJ1gsR9QLYHGm6XHhWJFX0R3vxIxDdQvWFiBCwFqWHsapJrmJzMQB1y254vao52q+Ra
        M7sS05IJh9cIs4+KeRVWftHQ3JkM6/2WIKLlgvme3re9jn/u0O3wPSbOsuCI+sDZvemT89
        nSsQCzrFKxqvhLGkluqb1bqIrRSCJy4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-cOxQpbUyM6mTqyRZ5RWHvw-1; Mon, 24 Oct 2022 08:58:05 -0400
X-MC-Unique: cOxQpbUyM6mTqyRZ5RWHvw-1
Received: by mail-pj1-f70.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso1954641pjb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trlf8J9SEf2L59s+RkYAnLixFP1fn9n6wg9XCVdSXj8=;
        b=NcXfGiBL+ORmHMgsqApmR8Up9GRUZQ7trBPbUNGD0e1Do+4Dt7A24xMr/QlmE0uc1m
         VZB096VNUfEWGTfFvrh+os1aaA9J6Nc76UNy8658+f4A2pVbEegGgDMYTDWO7iLtIPQQ
         7GwBeSSnaK+/FPkUtS61KCMzm4BD1H/6DAf5h89fUkwFqHwzljB54ZIcUsfkAhCCEjoH
         p8stWDc6R44rLSRD7pn/33sp56shUYTVYgOydNAw1ktrVjdZ7hZrv5nTjquXz5PS/wha
         J6eX2fH7Q0RxvsDV0pbOfcKTp0D8aVf0bzrLu4qqHGC88+1D+NDUpNqAmRpe4oqXjqz9
         XUZQ==
X-Gm-Message-State: ACrzQf2ED9QQPrVxEqmMGiwaJYqb4CN5Bj7Cy4C0h5cxc00yrqssnkd8
        5m5bYp9MUriOPjr4f+36XIAfzG8sYT/mUbh34zXHqOrsis1V2KdUu5q4DpRTQOUvpcjkmcO+rj1
        1ZRdT4tUcc80zTmtbrZPNOVJeTa+0FzE0/A9DMg+mtrcy
X-Received: by 2002:aa7:8895:0:b0:565:e8b7:8494 with SMTP id z21-20020aa78895000000b00565e8b78494mr33933492pfe.82.1666616284948;
        Mon, 24 Oct 2022 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ATKwMjs8fR874pMc+dAGC/SR7UmEe44jSAvTRPQT9j1GVtVWmlm5v8nZMryXEA7LvlnBtw+wBsTve+EXGjdg=
X-Received: by 2002:aa7:8895:0:b0:565:e8b7:8494 with SMTP id
 z21-20020aa78895000000b00565e8b78494mr33933461pfe.82.1666616284691; Mon, 24
 Oct 2022 05:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com> <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com> <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
In-Reply-To: <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 24 Oct 2022 09:57:53 -0300
Message-ID: <CAAq0SU=w-upGGstmQgTh63zGqLZnEy1OpF+9FwAjSWMuyYyXTg@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 23, 2022 at 1:13 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
> >>> You are allowing userspace to spam the kernel logs, please do not do
> >>> that.
> >> Added it to help userspace understand the reason for the failure (only for
> >> the cases like request param issues and TDCALL failure). Boris recommended
> >> adding it in the previous review.
> > Again, you just created a vector for userspace to spam the kernel log.
> > No kernel driver should ever do that.
> >
>
> Brois, any comments? Do you also agree?
>

Maybe dev_err_once() does the job?

