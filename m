Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7474D67A01E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 18:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjAXR1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 12:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjAXR07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 12:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3F4B896
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674581173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1//lKxOSoW8HByrjyrd9SNUigcEe/d5fAJWdteeAwY=;
        b=eA4CPmdYLdBkEdb03f5ztZPN2GoIevibFfTKykADN+rSdyfzZPZoEt9Vd/WSUajFVoRhjt
        Q7GCulxG8Xw5H4cd883tZGKQmZWncQuHjs/16xl5XbPKMSylU0xu6Odpb+hDwmLx59SHn4
        1Gq6nj7fp3zwUN2bmbjrrw4T8HmF0Xo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-zJ9a4VZJNn6j1bEYuS0MLg-1; Tue, 24 Jan 2023 12:26:12 -0500
X-MC-Unique: zJ9a4VZJNn6j1bEYuS0MLg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-4bdeb1bbeafso159315287b3.4
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 09:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1//lKxOSoW8HByrjyrd9SNUigcEe/d5fAJWdteeAwY=;
        b=VjADouHpuJSH5Mdcqjxd5ApQ/JWsRuBnQVeCGjEtyRni8Sav4Rwg1cWXjy94Tu9/0z
         sQQy0RNDZxx3ZmKjPj2svmAUzgHRbNBpB1iHOsdWY807UddxcPtY1g463fcJL90tAva+
         VwTgK2F3VYoK+MgXU0Jh08PvtXPCpJBpouQajDcCKRN59m44D1XS58nZ6wja+J1iVsRG
         A8JyPSeEBK5NmB+dtqKIkOrzwEEGFmCbQxAJooc49PPtji5laWK3N+eyUy1mO5QAu380
         p7sihT4naAu5D4PhLoj+7yLUh0n6M4lm4TEeMYt68A3PIMrvqzRhd4CdbHbwQu1apFgw
         wa/w==
X-Gm-Message-State: AFqh2kphwccLc5O7tRmlIOb/kgUNlIwNemBpJCFtOW+r5uIYz64l9ogj
        Y0r43RF9paLsc+sUGPMI67QrXzaL4zuccuSa++G297bf/mPVGXRQjXjsMYbNbJbwROsKRt+l60c
        7cqc0Kf3zjZewExAotusEf8N5vngy
X-Received: by 2002:a81:8187:0:b0:466:b529:e379 with SMTP id r129-20020a818187000000b00466b529e379mr20203150ywf.27.1674581171813;
        Tue, 24 Jan 2023 09:26:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuntBE/q4AbbQoO+OesA9EZ1i3Bp0xsn0vakOkRw+wyHlq3Frgixzl4rdgMcorwGfrkChzC1w==
X-Received: by 2002:a81:8187:0:b0:466:b529:e379 with SMTP id r129-20020a818187000000b00466b529e379mr20203110ywf.27.1674581171581;
        Tue, 24 Jan 2023 09:26:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id n22-20020a05620a223600b006fa22f0494bsm1736320qkh.117.2023.01.24.09.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:26:10 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:26:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v7 1/4] userfaultfd: Add UFFD WP Async support
Message-ID: <Y9AUsCxgitOI2lUA@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com>
 <Y8gkY8OlnOwvlkj4@x1n>
 <0bed5911-48b9-0cc2-dfcf-d3bc3b0e8388@collabora.com>
 <Y8lxW5YtD6MX61WD@x1n>
 <Y8qq0dKIJBshua+X@x1n>
 <328f54c1-171f-22a1-10c9-8b7a25bd8027@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <328f54c1-171f-22a1-10c9-8b7a25bd8027@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 03:11:20PM +0500, Muhammad Usama Anjum wrote:
> > One thing worth mention is, I think for async wp it doesn't need to be
> > restricted by UFFD_USER_MODE_ONLY, because comparing to the sync messages
> > it has no risk of being utilized for malicious purposes.
> I think with updated handling path updated in do_wp_page() and
> wp_huge_pmd() in version, UFFD_USER_MODE_ONLY will not affect us.

This is more or less a comment for the design, the new code should work (by
bypassing handle_userfaultfd(), where this bit was checked).

We'll need an man page update if this feature will be merged [1], and if so
it'll need to be updated for the UFFD_USER_MODE_ONLY section regarding to
async uffd-wp support too.  I think that can also be worked out after the
series being accepted first, so just a heads up.

[1] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

-- 
Peter Xu

