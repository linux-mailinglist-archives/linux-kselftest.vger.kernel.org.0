Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D813D784
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAPKH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 05:07:58 -0500
Received: from verein.lst.de ([213.95.11.211]:55148 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgAPKH6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 05:07:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6DD468BE1; Thu, 16 Jan 2020 11:07:54 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:07:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 1/6] mm/mmu_notifier: add
 mmu_interval_notifier_insert_safe()
Message-ID: <20200116100754.GA16347@lst.de>
References: <20200113224703.5917-1-rcampbell@nvidia.com> <20200113224703.5917-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113224703.5917-2-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The name is weird, normally we call functions like this _locked.

Additionally it will need a lockdep_assert_held to ensure the caller
actually holds the lock.
