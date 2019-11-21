Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8081057BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKURAP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 12:00:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35267 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKURAL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 12:00:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so3857013oig.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDymYy1Cr6msxqeKtzOvSyToG0ApR3Ly++FnBPiFfAU=;
        b=f+VuCObIDRfrJmbTAA4m3SQhOXNZ4pbf+ZyigT8J2YciKJHX1toKS54ABD40/HbC1d
         7Pkwsh8oyyINQzVpjfjsJLe3RxxCFvky++3gAGs9me3lgi9X2Cs94Bu46By7m8IZ2aX6
         6VCe60NDY4cCmQm2ZZlTacWdZ6Ps9MXHsxEoPPvq4YYJFGrJauw8LzXEJJdEFg7nFNai
         NT0xpYhDehIOprr6cUNw9YoHqOqwfQCKgM0QWVQ6U7LVeCnx2wYwSu33Ka73HmSeIHM7
         JqrB5AsBrlMh6M533DPgzCdMMVEMlw9v2LJQn2e/uD0VclTth1B3dpfknn3iLontgkuH
         3IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDymYy1Cr6msxqeKtzOvSyToG0ApR3Ly++FnBPiFfAU=;
        b=uQZOkkEC6aOy8c38HkUAzZXsbv7elKKpFBkKRJQmD2JNDxedesUWGbc0GCo4BtlAw7
         yKhBWV+2n8FJplMq44+Zapyw0ic1NMj8GwnikB5YF4QxJxBI14E7WX2t9FMT1UI5NA7h
         Am7VkAcx6YO2AtYuRBHkQz3L7a4/d8hp0FY8BMGI0D0oN1ZqO6K3357un4M5JlkjK9Et
         MVO/89E3Lax3fXcqrZnw7jHSYbSjnN8M+Q0on70YCXHZ84QSBFpDWM+MvGVC7ePV5JTT
         nXog1VuiFd0u2xrnhKE+TXjsUSt04ihZSwHUTd/4t3mMo50bz5c/3D+8EoQ/U4IFazqT
         wpZg==
X-Gm-Message-State: APjAAAXtl1/bGfzjPO4RfNkJRZrmBZexsWINjJyAbz6WFkYZkx7uIk9B
        epF/aZabXZxPKn0FKkFGqZZs9qW7FEwpnjXNd6/vGg==
X-Google-Smtp-Source: APXvYqzaKFA5sHA2BoiQUxyQp/rlYSGdVkc2qiU+T2e7CfLgs6CP/GdyTJIUkjrV/y2OAJbT5zFGq6OvhTpLAGKVq9Q=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr8187454oih.73.1574355610298;
 Thu, 21 Nov 2019 09:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20191121071354.456618-1-jhubbard@nvidia.com> <20191121071354.456618-6-jhubbard@nvidia.com>
 <20191121080555.GC24784@lst.de> <c5f8750f-af82-8aec-ce70-116acf24fa82@nvidia.com>
In-Reply-To: <c5f8750f-af82-8aec-ce70-116acf24fa82@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Nov 2019 08:59:57 -0800
Message-ID: <CAPcyv4jzDfxFAnAYc6g8Zz=3DweQFEBLBQyA_tSDP2Wy-RoA4A@mail.gmail.com>
Subject: Re: [PATCH v7 05/24] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 12:57 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/21/19 12:05 AM, Christoph Hellwig wrote:
> > So while this looks correct and I still really don't see the major
> > benefit of the new code organization, especially as it bloats all
> > put_page callers.
> >
> > I'd love to see code size change stats for an allyesconfig on this
> > commit.
> >
>
> Right, I'm running that now, will post the results. (btw, if there is
> a script and/or standard format I should use, I'm all ears. I'll dig
> through lwn...)
>

Just run:

    size vmlinux
