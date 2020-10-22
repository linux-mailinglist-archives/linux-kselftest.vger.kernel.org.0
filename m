Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA93295873
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504017AbgJVGfy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 02:35:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:45059 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410587AbgJVGfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 02:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603348554; x=1634884554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=kKiOca2316EJ9vxPoAwD2unEw6cWiSMyllmPhS2/EUI=;
  b=Ay8Kpd7xAAnaoCfBeqpNCdqpGq9mbC5zigvuCdQ91nDNLb3N12+KOoDj
   SBWfPt/ZJj7oWbMMF157aJfQ53Y5JyE/wtFue03MKs8gSaZtC9wC0iTbU
   /9W0zZ7ABQ6hhzkO2MMHvnNKhLU9ADD+n+lg8EecIuLjS8gpBm2e7k2+L
   I=;
X-IronPort-AV: E=Sophos;i="5.77,403,1596499200"; 
   d="scan'208";a="62625133"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Oct 2020 06:35:48 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 20EFEA1D36;
        Thu, 22 Oct 2020 06:35:45 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.64) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 06:35:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
Date:   Thu, 22 Oct 2020 08:35:26 +0200
Message-ID: <20201022063526.12554-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g44CxPuXbHund397PJSQPHGhWy1-7ij7JnJNzCO0NF6dCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.64]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 21 Oct 2020 14:32:52 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> > used UPPER_SNAKE_CASE naming convention that usually means it is
> > constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> > default config in '--build_dir'") made it modifiable to fix a use case
> > of the tool and thus the naming also changed to lower_snake_case.
> > However, this resulted in a confusion.  As a result, some successing
> > changes made the tool unittest fail, and a fix[1] of it again incurred
> > the '--build_dir' use case failure.
> >
> > As the previous commit fixed the '--build_dir' use case without
> > modifying the variable again, this commit marks the variable as constant
> > again with UPPER_SNAKE_CASE, to reduce future confusions.
> >
> > [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks :)

> 
> Thanks for this! This is something I meant to fix a while ago and forgot about.
> 
> One minor issue, this patch does not apply on torvalds/master right
> now. Could you please rebase this?

Surely of course, I will send next version soon.


Thanks,
SeongJae Park
