Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02567A362
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 20:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjAXTuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 14:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjAXTuG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 14:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD273A246
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674589762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R85STr6GIhhr+ztwclj6pO6G7kZRrikgcAMPHnfe248=;
        b=eFk4/9hgL7Rawca+FgAOSo6KsKSCLyFdoD1Oho0erKm7DBFBrCjyYb0AowPhD1puH2HD6h
        fMXNOmjgsRgESJjLzSdbXInofgi2rj+FwLs6+BMJw+A6S3Fvfvwn05h8XALqgOHl/clh20
        M4QGMN+4xMvnt0ldxMTsfuwBi7qr4jY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-DPXXo9B_Msyz0xGCQENbSA-1; Tue, 24 Jan 2023 14:49:21 -0500
X-MC-Unique: DPXXo9B_Msyz0xGCQENbSA-1
Received: by mail-qv1-f70.google.com with SMTP id l6-20020ad44446000000b00537721bfd2dso73546qvt.11
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 11:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R85STr6GIhhr+ztwclj6pO6G7kZRrikgcAMPHnfe248=;
        b=RUyheu/OC3lbItwVYFZ1SnLbHzJ328nRHkLaWiNho1PQBdLLr/JLr6J1d6AzII6MXK
         zE+FBq41d0hF5ELdDOpL+AON+DRkvrkvioPvGhe2AXM5nxsoz/yAjvZu/Nq5uISLJRSz
         Lg1AXoYntIQ64i/bNroGWdPHRl1GEjnCcSSTZBpGvHffiaxAX2DtfH1lgCUUo/OFLtSx
         ouye70wbVF+ujZsql2LyuXXXqtzjf2v0UZyVepIqQvZhRHfMgo2zE7fm44lapEnpD/Aq
         q6x18nvsbrUhfpy3gy/1KL1m1ar0SZx5vMZdYBXuXeBJJnGkr+nO3acuHkvNyeHYKyQh
         RItA==
X-Gm-Message-State: AFqh2kr0rvE9l9fBzBPmWRrvCa7w5tR5ANqfreBqma1rswzpq5IylKHg
        e+D52iBNtKJ/QFdWLPF8E1FaYZeNiK5OSpfOU/AMA6pNCt0W79ufNGN29/xCF+/W792Z5vtHikD
        vgIdVzkbstpIGIzXleqa+I+14kjUw
X-Received: by 2002:ac8:4758:0:b0:3b6:36a0:adbe with SMTP id k24-20020ac84758000000b003b636a0adbemr40222105qtp.6.1674589761218;
        Tue, 24 Jan 2023 11:49:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1WuGrk9av6WUp2+OZodLHrIX79DJLQmWseM2cM1QbiDQQOkRVcd+zhy6zkWOiNmjgkRdG5Q==
X-Received: by 2002:ac8:4758:0:b0:3b6:36a0:adbe with SMTP id k24-20020ac84758000000b003b636a0adbemr40222080qtp.6.1674589760880;
        Tue, 24 Jan 2023 11:49:20 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x12-20020ac87ecc000000b0039cc0fbdb61sm1789700qtj.53.2023.01.24.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:49:20 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:49:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
Subject: Re: [PATCH v7 0/4] Implement IOCTL to get and/or the clear info
 about PTEs
Message-ID: <Y9A2PsCS7gfKWfaM@x1n>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <Y8hutCGec6je5toG@x1n>
 <0eb79bb3-7384-11c6-a380-c027f09305f2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0eb79bb3-7384-11c6-a380-c027f09305f2@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 06:15:00PM +0500, Muhammad Usama Anjum wrote:
> > Firstly, doc update is more than welcomed to explain the new interface
> > first (before throwing the code..).  That can be done in pagemap.rst on
> > pagemap changes, or userfaultfd.rst on userfaultfd.
> Okay. I'll add the documentation in next version or after the series has
> been accepted. Initially I'd added the documentation. But the code kept on
> changing so much that I had to spend considerable time on updating the
> documentation. I know it is better to add documentation with the patches.
> I'll try to add it.

Yes, logically it should be the thing people start looking with.  It'll
help reviewers to understand how does it work in general if relevant
description is not in the cover letter, so it can matter even before the
series is merged.

> > There're four kinds of masks (required/anyof/excluded/return).  Are they
> > all needed?  Why this is a good interface design?
> Then, CRIU developers Andrea [1] and Danylo [2], asked to include all these
> different kinds of masks. I'd thought of these masks as fancy filter inside
> the kernel. But there wasn't anyone else to review. So I'd included them to
> move forward. Please let me know your thoughts after reading emails from [1].

The idea makes sense to me, thanks.  I just hope "moving it forward" is not
the only reason that you included it.

Please also consider to attach relevant links to your next cover letter so
new reviewers can be aware of why the interface is proposed like that.

IMHO it would be also great if the CRIU people can acknowledge the
interface at some point to make sure it satisfies the needs.  An POC would
be even better on CRIU, but maybe that's asking too much.

-- 
Peter Xu

