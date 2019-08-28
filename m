Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01916A009F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1LXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 07:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1LXn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 07:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 895E0AEE1;
        Wed, 28 Aug 2019 11:23:41 +0000 (UTC)
Date:   Wed, 28 Aug 2019 13:23:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, shuah@kernel.org, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
Message-ID: <20190828112340.GB7466@dhcp22.suse.cz>
References: <20190826233240.11524-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 26-08-19 16:32:34, Mina Almasry wrote:
>  mm/hugetlb.c                                  | 493 ++++++++++++------
>  mm/hugetlb_cgroup.c                           | 187 +++++--

This is a lot of changes to an already subtle code which hugetlb
reservations undoubly are. Moreover cgroupv1 is feature frozen and I am
not aware of any plans to port the controller to v2. That all doesn't
sound in favor of this change. Mike is the maintainer of the hugetlb
code so I will defer to him to make a decision but I wouldn't recommend
that.
-- 
Michal Hocko
SUSE Labs
