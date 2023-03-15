Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD426BB8C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjCOP6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjCOP5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 11:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8885A5C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678895761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pw4eRnmgxAQbUslf97rTqSt6QU+YteWEHOJqAmSsx5g=;
        b=f1LWL7IMIis4SAKly7yDRpHblrZHwqCbK8FMuuy2EhwFSdc+gS6KYGX+q+89u2bhLQLtNB
        T14rMaeFHoLc2e/s/cmfrwdxAwyCqLimIYJXW2MIImM3bQe0I50+QSLhA1Pe/5YhKijSNV
        VG6lv0nPsg38HNQLSULjamHojRc6kd8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-47RhaqaeOYqNcN3oVHXr_Q-1; Wed, 15 Mar 2023 11:55:59 -0400
X-MC-Unique: 47RhaqaeOYqNcN3oVHXr_Q-1
Received: by mail-qv1-f72.google.com with SMTP id f8-20020a0cbec8000000b005b14a30945cso824146qvj.8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895759; x=1681487759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw4eRnmgxAQbUslf97rTqSt6QU+YteWEHOJqAmSsx5g=;
        b=usaef8OaoFGQfRJ1kdvaH+u3L3B68zlNA3FY3TOAcBEhKS2ot4m9DrOOSwwwxPZfcd
         9Z0HAiJfyDPheEGA5u7Jjl7bSBXBKfNzLFizlx2PnP0TSx+2nIaufN51sEzdEVI/FyXS
         /1gRgc7BWoDiF7CAcJZoZT6ry65FDwnsbhFjfDPkEVlDtdKzYVTzPcRz/ADNo2OCHtPm
         Um3kpmGmPwZcCrPa+IGKmlbKlKtLGMJXq8UqtqX6AoH6k//f7ZHaSVdzjVZWRNHUdvxt
         whxHFPaR1jf0vp6i+In929NncpqjnxrhIT3rZv9vOGAmmxL1jIlnWdedqaOqbhG7Tmlj
         MZiQ==
X-Gm-Message-State: AO0yUKUoowO0Jn0TC+0f4JrVQGwDA1/yc06VlTOai6FSnfy6NozjP1Rf
        gWVOW1D2UItDNwEBRJ87nJZjVY8RHyhTe/g6NV8nYRDciHVzEUXtKbdLjnblxR3wUAbABXhH/+A
        LVh68tsnZx94J7X9YiitdA0n8wIgp
X-Received: by 2002:ac8:5f0f:0:b0:3b9:a4d4:7f37 with SMTP id x15-20020ac85f0f000000b003b9a4d47f37mr7256625qta.3.1678895759087;
        Wed, 15 Mar 2023 08:55:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set/eKRMHgAx+CwCeLiCbX9cigeSt/aHmp3juRyE7h21eLYSzPFiMLvDtztWo7Q/hFkgkseO21A==
X-Received: by 2002:ac8:5f0f:0:b0:3b9:a4d4:7f37 with SMTP id x15-20020ac85f0f000000b003b9a4d47f37mr7256562qta.3.1678895758790;
        Wed, 15 Mar 2023 08:55:58 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t30-20020a05622a181e00b003ba2a15f93dsm4125741qtc.26.2023.03.15.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:55:58 -0700 (PDT)
Date:   Wed, 15 Mar 2023 11:55:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZBHqjBjj6nn1xeTM@x1n>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309135718.1490461-5-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 06:57:15PM +0500, Muhammad Usama Anjum wrote:
> +	for (addr = start; !ret && addr < end; pte++, addr += PAGE_SIZE) {
> +		pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +
> +		is_writ = !is_pte_uffd_wp(*pte);
> +		is_file = vma->vm_file;
> +		is_pres = pte_present(*pte);
> +		is_swap = is_swap_pte(*pte);
> +
> +		pte_unmap_unlock(pte, ptl);
> +
> +		ret = pagemap_scan_output(is_writ, is_file, is_pres, is_swap,
> +					  p, addr, 1);
> +		if (ret)
> +			break;
> +
> +		if (PM_SCAN_OP_IS_WP(p) && is_writ &&
> +		    uffd_wp_range(walk->mm, vma, addr, PAGE_SIZE, true) < 0)
> +			ret = -EINVAL;
> +	}

This is not real atomic..

Taking the spinlock for eacy pte is not only overkill but wrong in
atomicity because the pte can change right after spinlock unlocked.

Unfortunately you also cannot reuse uffd_wp_range() because that's not
atomic either, my fault here.  Probably I was thinking mostly from
soft-dirty pov on batching the collect+reset.

You need to take the spin lock, collect whatever bits, set/clear whatever
bits, only until then release the spin lock.

"Not atomic" means you can have some page got dirtied but you could miss
it.  Depending on how strict you want, I think it'll break apps like CRIU
if strict atomicity needed for migrating a process.  If we want to have a
new interface anyway, IMHO we'd better do that in the strict way.

Same comment applies to the THP handling (where I cut from the context).

-- 
Peter Xu

