Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A619EE0DD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfJVVev (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 17:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbfJVVev (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 17:34:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8252054F;
        Tue, 22 Oct 2019 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571780091;
        bh=jUbjg4767/wv+j5lNCFdODv+1JBsU0jaX9/eKGZSFIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zWqT3glZNumYk331bSdTaKzH5MY+FKnX+OGvsKMhKQV/QZVw2BTvk/oPqS1fj7Pup
         SQEr/gHWzTGULSnlVPHGkMpHX5vlWWLV05MVKyzy/iPZJfsqDFN/9kiGp2tPFlKk/p
         lbhIpifgdoIbGfIlim4hhg74ysxENvaUwCqmYuGQ=
Date:   Tue, 22 Oct 2019 14:34:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
Message-Id: <20191022143450.b3d9caa4f647a63c181e8311@linux-foundation.org>
In-Reply-To: <8892a2be-029b-f8c5-d984-8ff3b5c490ed@nvidia.com>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
        <20191021212435.398153-2-jhubbard@nvidia.com>
        <20191022171452.GA5169@redhat.com>
        <1095fd94-1c0b-de61-7ceb-c963e29575b6@nvidia.com>
        <20191022185701.GD5169@redhat.com>
        <8892a2be-029b-f8c5-d984-8ff3b5c490ed@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 22 Oct 2019 12:39:53 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> Admin note: this already went into mmotm, so I'm hoping Andrew will notice this
> email and add the Reviewed-by tag, please?

Always. (Well, almost ;))

