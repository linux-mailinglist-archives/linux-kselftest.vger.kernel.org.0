Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9ABD642D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 15:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfJNNgs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 09:36:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38651 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJNNgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 09:36:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so16690499ljj.5
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwbPVljcr0NSCLljc0OrTvv7XNYrir6ZBXGML3SSjPU=;
        b=05qWHKg+TrOwztU4ZAot6PDVHWWpQZxid79fo7XRrrioC8Lnc3sSuSc2AYMczUkUSw
         CkbNN+k3FcFi080be2vjjn8VAsMeKfzSxNry3wbMacWHSYD0iwRiSW+AeUri83swD8Ya
         07bYiepu9TWx+9bjcdxDEYSx7lUiZXk/7r+Uk0lWt6YChTAkfWPzx4sZgPoS6PDO2CIF
         bzGesDWFfKoCqzRXCov9hjmYv210ylBItSLFgcc9qIkV9ap9/GtKMLysd6ACbBQjRD2k
         Ek0s+DYRtOUJ3qyhNrUBsKbjbqFLbc4Y9tZ7aIIEiBUKZjs91A6JWVekds0tHqWssr8T
         7c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwbPVljcr0NSCLljc0OrTvv7XNYrir6ZBXGML3SSjPU=;
        b=snUrtk5euonkUE5jxBmnUQMJLQbi6mdFHzyDByxpNjQda/DtnCUBac0Z6HCyw2cZk6
         7FMWghVlYofJ+Ehif1kF1qumsn2qQw0sJlPeR/Lirn7VuPzVsKAh1gHLP7doPdeiwMic
         ItxGC+gwV2dJcMyi3jubHl60V7gNmBIqYfADR0XhIyP+7XeXKeo7QRiJCac45V21qvlQ
         LU6wCNKTfh1BFNSh4irBwAeH2r2GFZpytUP/il+rPeJrT1mvGMQDvO/evIBexHaJhyBN
         xgC1Z2I1bdljJF9e1jYPu88oWNZ9BXq+7JlPjOR/CnXPPtJ6KoYoGM/99Ss+eXB/TeJq
         ZmEA==
X-Gm-Message-State: APjAAAXKtWGepKTgcbCQRecuk8f+rbHO4oSfgc/uxMEbAw2KF9Ic4jlB
        u3caGZocQYUwsMr7TlKST8E3Zg==
X-Google-Smtp-Source: APXvYqyM5oyga4VW1RouFU2Br7VQCRYE/EjO/xLpNOZBGALk/H00a8Cezl8WSlGhqQd/ZpQ+hGkhyQ==
X-Received: by 2002:a2e:9d3:: with SMTP id 202mr16473401ljj.112.1571060206393;
        Mon, 14 Oct 2019 06:36:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t8sm4215037lfc.80.2019.10.14.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:36:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BF773101288; Mon, 14 Oct 2019 16:36:44 +0300 (+03)
Date:   Mon, 14 Oct 2019 16:36:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup_benchmark: add a missing "w" to getopt string
Message-ID: <20191014133644.ecjlss24e5fy7tkl@box>
References: <20191013221155.382378-1-jhubbard@nvidia.com>
 <20191013221155.382378-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013221155.382378-2-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 13, 2019 at 03:11:54PM -0700, John Hubbard wrote:
> Even though gup_benchmark.c has code to handle the -w
> command-line option, the "w" is not part of the getopt
> string. It looks as if it has been missing the whole time.
> 
> On my machine, this leads naturally to the following
> predictable result:
> 
> $ sudo ./gup_benchmark -w
> ./gup_benchmark: invalid option -- 'w'
> 
> ...which is fixed, with this commit.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
