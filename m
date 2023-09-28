Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41E7B259E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjI1TB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjI1TBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 15:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FD194
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695927642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sYeSXBF9ox8JewI5CgNTTLRvL8aO3BLx9jhzfMOKFj4=;
        b=QjNtzCoJ5EOExnq24+bYDcwu6r01Gn5n4rMxKPHfOCmZhaR9EL8i5oKjmKzaOWCz6lPPXe
        yly/Y3/PFhc70N7kozIBH9VArHOFrQ1xDAUgMTparxeJ/Xm8/H+5GHj9rE/uHrXmPGI+0W
        MWxZqw9s2+93otpLg/79+ElIUmClIM4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-XsBl20GXPSe2H5MjTMZAVg-1; Thu, 28 Sep 2023 15:00:40 -0400
X-MC-Unique: XsBl20GXPSe2H5MjTMZAVg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65623d0075aso44773256d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 12:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695927640; x=1696532440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYeSXBF9ox8JewI5CgNTTLRvL8aO3BLx9jhzfMOKFj4=;
        b=IwDFQTt9E0BditlVz11rE/ONJq2u+FRHUL2l3quRqOemz0T8WGlLCqtgDVf2YS9le9
         2EB5hzrmjiWHxymwZS9D0jBTs77ZGfjM0xr1nLzDPNrFJwvZDKlXRH6ah+tXkmPnkssG
         2qgDu1igwZS2hAY0vnQxcB+QjgxV7Qq4Tl4AGX7hxRZzsMFUHYDUUiCdJ+vPSiZR1dPh
         M1/tV/KeIvrmmtkTMefqRV1oi+uhGUIhg4d+OesV02jciSXSA8CKhz0ehj5/N1MJOKjK
         MaD7no9okBQpLpncTpAvK/low3koPNLOqMcDPgPjPd8Yz7YXDuDS9/AHKCFfxIFGnFeK
         TEGg==
X-Gm-Message-State: AOJu0YwxtDwYbeAQPoRhDP084x635kQLgZyYJj/A5l141PeNedpNFkbd
        F1Qj2Efh9/Jj0CbTQqwka2d4ukzEkRC3dcXF9v+8EYZExs4AhBa/8d6x6SEZQt1kzUWpceorqNh
        8TzAJcK90u8HyGOKN+3XeyrztC07s
X-Received: by 2002:a05:6214:509b:b0:65d:482:9989 with SMTP id kk27-20020a056214509b00b0065d04829989mr2048561qvb.5.1695927640396;
        Thu, 28 Sep 2023 12:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3uis8ZcMwGkA2LhfKt3i7NAV8nmQaJXoWJnDpIdTIO5n+q2tK4lmY4mR5a342HyQijvEuHQ==
X-Received: by 2002:a05:6214:509b:b0:65d:482:9989 with SMTP id kk27-20020a056214509b00b0065d04829989mr2048511qvb.5.1695927639908;
        Thu, 28 Sep 2023 12:00:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id k13-20020a0cb24d000000b0065862497fd2sm3723831qve.22.2023.09.28.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:00:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 15:00:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRXNVGI73SfX1lu4@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
 <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 07:15:13PM +0200, David Hildenbrand wrote:
> There are some interesting questions to ask here:
> 
> 1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not? You
> most probably have to mark the PTE softdirty and not make it writable.

I don't know whether anyone would care about soft-dirty used with uffd
remap, but if to think about it..

Logically if the dst vma has !SOFTDIRTY (means, soft-dirty tracking
enabled), then IIUC the right thing to do is to assume this page is
modified, hence mark softdirty and perhaps proceed with other checks (where
write bit can be set if all check pass)?

Because from a soft-dirty monitor POV on dst_vma I see this REMAP the same
as writting data onto the missing page and got a page fault
(e.g. UFFDIO_COPY); we just avoided the allocation and copy.

The src vma seems also fine in this regard: soft-dirty should ignore holes
always anyway (e.g. DONTNEED on a page should report !soft-dirty later even
if tracking).

> 
> 2) VM_UFFD_WP requires similar care I assume? Peter might know.

UFFD_WP shouldn't be affected, iiuc.

Let's first discuss dst vma side.

WP_UNPOPULATED made it slightly complicated but not so much.  The core
should be that REMAP only installs pages if it's exactly pte_none():

+       if (!pte_none(orig_dst_pte)) {
+               err = -EEXIST;
+               goto out;
+       }

Then it already covers things like pte markers, and any marker currently
will fail the REMAP ioctl already.  May not be always wanted, but no risk
of losing wp notifications.  If that'll be a valid use case we can work it
out.

On src vma, REMAP ioctl should behave the same as DONTNEED.  Now we drop
the src pte along with the uffd-wp bit even if set, which is the correct
behavior from that regard.

Again, I don't know whether anyone cares on any of those, though..

Thanks,

-- 
Peter Xu

