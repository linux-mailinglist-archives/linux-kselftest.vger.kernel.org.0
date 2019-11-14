Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F56FC8D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 15:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNOYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 09:24:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41117 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKNOYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 09:24:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id o3so6934974qtj.8
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2019 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YfeA14uuuPzU+N+/A63W2LLCo3IHXwSL/EjkK/pHBoA=;
        b=PXwwk3aG8DnvtQt2WlwkDuxKtEq+rWhMjk6TRDPP6J7v2ijVF5ntwH71vv2+LPNGON
         FkVeLzwjcEl9zzEmJcuEcNJPI0Zl7WsDbJqqfHzJx7frAIJ4S82/egMXgAlt+KAcJs5S
         0YpEBfP/fz89eoYIu0n6MBzOFLoIJNnjToi1iA49/WI0O6XoZQkkV4XX2reLekkoZGQK
         hEjn4cS4z2FfZfR+/wP3JKdL+Zb6WUpjELz+FQdgwysAQ0W+7Mvxhucp+WoKHgkywQuJ
         Gn94aN6yEE/wOFmjywIASyQrf+GqPnHZOHIa0aufOfzY3JC+/kDSQvxS1fIRd78B2N8u
         w67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YfeA14uuuPzU+N+/A63W2LLCo3IHXwSL/EjkK/pHBoA=;
        b=OxswyPbuV2S1sqF/yZjeeDJ3BL+BJBnbf2r2Szz0P8PaSylVfEu/HGcrj6RsFEf4zL
         FUxv53eDnhaXhzDFSQilBu48UNwsng/nGRG61vILtznSLMRD4PeZqAHJNC5tT/SucPcl
         AEvKx5S8wfkzuo/aC4r03qtWJbZUWX3IXGEOKErYj2PcJ5tdst41TLtSfe1l8pz0lDxe
         W1pAqgsHCCETumKyznA5upMdiaHuSCo7fT5k6SEOHY5wcZiWPROfgTdd2FgPNOP6DEAo
         7IGTQFt9MNB3Ek/Vs9xLP2NomVdSRoJ+JU1c729cQ3tUpU3MHAsPv9a3M2rV1mZOx8F6
         gIJw==
X-Gm-Message-State: APjAAAW3Hzj8KL6gGofh6l5rgEJ5o/1wXLNdcKuaco9tOjkj0ZJdeVK3
        xFqeUjeZb623cEMnQVPq1fxl8w==
X-Google-Smtp-Source: APXvYqzjYBw8Uth2zEHa9ufAHHel74INCvkgWT2GGxMJP0HHyFDLnEKNDmKisfErW5qKeEy3am6PCA==
X-Received: by 2002:ac8:6757:: with SMTP id n23mr8291467qtp.345.1573741450490;
        Thu, 14 Nov 2019 06:24:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s42sm3125140qtk.60.2019.11.14.06.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 06:24:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVG2b-0000DC-9T; Thu, 14 Nov 2019 10:24:09 -0400
Date:   Thu, 14 Nov 2019 10:24:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/hmm: make full use of walk_page_range()
Message-ID: <20191114142409.GA785@ziepe.ca>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104222141.5173-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 04, 2019 at 02:21:40PM -0800, Ralph Campbell wrote:
> hmm_range_fault() calls find_vma() and walk_page_range() in a loop.
> This is unnecessary duplication since walk_page_range() calls find_vma()
> in a loop already.
> Simplify hmm_range_fault() by defining a walk_test() callback function
> to filter unhandled vmas.
> This also fixes a bug where hmm_range_fault() was not checking
> start >= vma->vm_start before checking vma->vm_flags so hmm_range_fault()
> could return an error based on the wrong vma for the requested range.
> It also fixes a bug when the vma has no read access and the caller did
> not request a fault, there shouldn't be any error return code.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/hmm.c | 121 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 58 insertions(+), 63 deletions(-)

Applied to hmm.git with Christoph's hunk merged in

Thanks,
Jason
