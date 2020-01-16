Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662F713DD20
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 15:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPONO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 09:13:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33727 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPONO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 09:13:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so19224742qkc.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=520l2JLiKzJXg1t/Rg1LJ2QfApYXnB06j0gidqNWK58=;
        b=ivJGbNrKKevBAu3KtV1zpocVU5wd/m68yl62mnYvyvPVF8IJGvJlZNp6vb/jzePu1Y
         zf8xk9JI9hC4MEsK7uuZYFsrH+fHx1I+w4azdTlESYba+4xdP+X1qopzcrcWeiORTygz
         SRQ5jHvSLmjJWuX81TBQvRHo3mty6NG73RXCGWstN81R647lQsi0geld8aR51csMZoYE
         k26lxx/+qK8hSO8W6/k/oHOHdy19CbgyIzTDlz3U5sgcH+RiBy2c12LOHHlFDQQfKrSy
         ZGE3h8J8y6BhWBt2lQSPAieLjj/vaB6ptjZE6ZZjn8AuZtLua1uRakzC1Z0wv8sLyT+C
         d8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=520l2JLiKzJXg1t/Rg1LJ2QfApYXnB06j0gidqNWK58=;
        b=gSm4qT66njKGcR9hz3GsLP0vTd0nFgN25fii/AAgzwGHgxydLrQfiGn79j+AU2MmKU
         1JFTbu4F/aE0F5q2phwPIwgBBivhAJwnYytP0iIvU149ZXkLCgoF/S19WxX1J+1BrkH7
         okCRP/b7wTi5RquQV1o6c8stOsbO3m1K4vycgd0E74R7Ntx5DfpKNMWbuvIjng6tvWeg
         FHyxjutxEM+pUQsdhBGgZYbhJAKCFwhoYN1ftOcaXerDcZZVi/cNZ4gngMyxA/SDeHjD
         AYXwnV6xlIM102E/TujJrbkRqao1YFZL+Cp2+m44AfO6geClFUT+Sv7VmWD4Y2lbzl0a
         Fbog==
X-Gm-Message-State: APjAAAXsnoDv7AdHmOVo0N9ZhY9s6r+elnxuCKaHRp3+ylBegGw19ERo
        bQi1KDgC3sU7IFEeYPzGx3Igew==
X-Google-Smtp-Source: APXvYqwaAFHzaeePD+ZLa06AK6hw8Q1AGGqMYwQg3zqKNGu2Y61JuM5obBUDEaQ/+e046D9AnzZXAg==
X-Received: by 2002:a37:b402:: with SMTP id d2mr31920622qkf.195.1579183993212;
        Thu, 16 Jan 2020 06:13:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h34sm11371081qtc.62.2020.01.16.06.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:13:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is5tX-00040h-V7; Thu, 16 Jan 2020 10:13:11 -0400
Date:   Thu, 16 Jan 2020 10:13:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Message-ID: <20200116141311.GB10759@ziepe.ca>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
 <20200109194805.GK20978@mellanox.com>
 <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
 <20200109232548.GO20978@mellanox.com>
 <633a3dda-d4d7-1233-b290-53d36fb8fda1@nvidia.com>
 <20200114124523.GM20978@mellanox.com>
 <c9458a81-da38-928f-d8f3-814e06674bec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9458a81-da38-928f-d8f3-814e06674bec@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 15, 2020 at 02:04:47PM -0800, Ralph Campbell wrote:

> But I see your point if this sequence is done outside of the invalidate
> callback. In that case, if the driver shrank the interval, an invalidate
> callback for the right hand side could be missed before the insertion of
> the new interval for the right hand side.
> I'll explain this in the comments for nouveau_svmm_do_unmap() and
> dmirror_do_unmap().

Yes, this is why I'm not sure this is a good API for the core to
expose.

Batch manipulations is a resonable thing, but it should be forced to
work under safe conditions, ie while holding the required 'inv_begin'
on the interval tree, and the batching APIs should assert this
requirement.

Jason
