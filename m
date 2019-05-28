Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507202BD26
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfE1CRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 May 2019 22:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfE1CRU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 May 2019 22:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BF99C0528AC;
        Tue, 28 May 2019 02:17:20 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 605301A918;
        Tue, 28 May 2019 02:17:18 +0000 (UTC)
Date:   Tue, 28 May 2019 10:17:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alakesh Haloi <alakesh.haloi@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] userfaultfd: selftest: fix compiler warning
Message-ID: <20190528021716.GC22519@xz-x1>
References: <20190527151859.GA3217@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527151859.GA3217@ip-172-31-44-144.us-west-2.compute.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 28 May 2019 02:17:20 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 27, 2019 at 03:18:59PM +0000, Alakesh Haloi wrote:
> Fixes following compiler warning
> 
> userfaultfd.c: In function ‘usage’:
> userfaultfd.c:126:2: warning: format not a string literal and no format
> 	arguments [-Wformat-security]
>   fprintf(stderr, examples);
> 
> Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
