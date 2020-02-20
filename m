Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6A165898
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 08:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBTHix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 02:38:53 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21909 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgBTHix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 02:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582184333; x=1613720333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=oTbUz7ad+lxKA3pu5K3OeA9Qrfs1WDg7rWJbe6s8SN8=;
  b=nN5J0iDjN42HNmj0aa1xR/FKNfZUiilZIxHwzJXPJ3m3W3SEZ7jzj6LI
   Iaf9a3HdI+RepUlWTmd6SI6cKfKv2yukdxC4w6OPPCS20ZuLJT6eFScVF
   KaaWTn5JTAkRf/vlgfFu7IzUkDQLZu7xFQF+yqXLDJJrrYNxa8fLqHWwg
   U=;
IronPort-SDR: 7oia2wUGTnZSKhBsUHoyFHSu4XYOms7J8LTwX6c8QbdH3mOgpX/FUSxZkCcb291HIO2wy49XeQ
 +TIudoxoYDrg==
X-IronPort-AV: E=Sophos;i="5.70,463,1574121600"; 
   d="scan'208";a="27647351"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Feb 2020 07:38:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id D2639A3168;
        Thu, 20 Feb 2020 07:38:48 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 20 Feb 2020 07:38:48 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 20 Feb 2020 07:38:44 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH] docs/kunit/start: Use '_KUNIT_TEST' config name suffix
Date:   Thu, 20 Feb 2020 08:38:29 +0100
Message-ID: <20200220073829.18382-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g444shArgbdwaCdM3VBb9c7M1s7BJ5Dho7KEBU_fCsaJOw@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D24UWB003.ant.amazon.com (10.43.161.222) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 19 Feb 2020 14:16:03 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> Sorry, I didn't see this until now.

Even I also almost forgot this.

> 
> On Mon, Jan 27, 2020 at 7:32 AM <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > It is recommended to use '_KUNIT_TEST' config name suffix for kunit
> > tests but the example is using only '_TEST' suffix.  This commit fixes
> > it to also use '_KUNIT_TEST' suffix.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for finding this! :D


Thanks,
SeongJae Park

> 
> Thanks!
> 
