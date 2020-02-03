Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79091506CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2020 14:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBCNTZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Feb 2020 08:19:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44848 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgBCNTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Feb 2020 08:19:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so14561656ljj.11
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2020 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JVGRyQQaBReM02JrPoDmLBao0aPgpMTrxPDXDLtuBvs=;
        b=sHxNUX+2LzpyRJMjJ5Qfj9YCDSX6ExJg/Bd8Kbu6D3J1Pm6xg2/nCBLBUPM+5aDgph
         Vx13T6xRUazl2+5WDzyI2+KQ5Fwv9EnEICrEEivYt8zYofksOtWDQ0ieEYPnxb0jWoql
         2KXNT1xLabVpDbI6yu0pfXCX+ZkkKbcyN9i+rhwy9QqfIGMVfaGyVA3Fl5FlrA0MARbM
         fqCitH4ncSFtWXk3XtHIzHlxaXyvB4HPNozXmu/2hHRj2Rk8jnrIB7LYIzQ+bFvU3rx0
         zfqTJdh5FWcWe4I1vVRvwPei1Q5hrFlirNIRHGzVETfP4olS+o7cqE6CGB4YvD5YrwQv
         379g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JVGRyQQaBReM02JrPoDmLBao0aPgpMTrxPDXDLtuBvs=;
        b=MB/znltzeZ9meFTT7buknakQ20HsC/ElrinPUcDcbBaPbnH0q6/oCKa5lbYL0GGQNT
         wo7kXQSyJb3bVDdrONvizTkW7wtDmbyt3wxERl94y40CuevvznVTi4akwIiYRh0XIFMf
         izUs9pI+0peyabF+clpcBA4Q+VrQgPau/TwbtYZnwi+5OCLDd//NCIDVUzWkzqrgV66I
         kATNLDgM3Z7FXhVWdN96BwojLNWYB8FY9uVKgVtShd4LvhMAb4gEEBID3cB3qGmQB220
         cO7DA43CcSEkPq7TQsEvdx9QR/IP1tqtJuggm2qwNwXoGmaVyHGxxDZG+6crXe5kF9mo
         EGdQ==
X-Gm-Message-State: APjAAAWIWWH5ymoJnvBW8gyvCSo/AN1cGzRh7ynCRAyJ0w6mQ5KJTcHY
        jb0im3zRMTpobLopta2rzWXSkg==
X-Google-Smtp-Source: APXvYqw/kW5LBbvbpobmbtSlzot4JutREBTd02ZbvusFPkOi/RVuHv3ziJ7u01y8QC5aHMcpggWohA==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr14014356ljh.28.1580735962743;
        Mon, 03 Feb 2020 05:19:22 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z205sm8831859lfa.52.2020.02.03.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:19:22 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9F93C100DC8; Mon,  3 Feb 2020 16:19:34 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:19:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 03/12] mm/gup: pass a flags arg to __gup_device_*
 functions
Message-ID: <20200203131934.pxwmyemhgiqcb5j3@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200201034029.4063170-4-jhubbard@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:20PM -0800, John Hubbard wrote:
> A subsequent patch requires access to gup flags, so pass the flags
> argument through to the __gup_device_* functions.
> 
> Also placate checkpatch.pl by shortening a nearby line.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Empty line here?

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
