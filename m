Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF6293557
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 08:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404627AbgJTG6z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 02:58:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55753 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbgJTG6z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 02:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603177135; x=1634713135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=91AgDhfvJvEb+DR7h51DjPS/NuVrfZllvIqhYuEyvRY=;
  b=Y5uspjaaoWXzlGx7JSqby6OBjB6D4IqTLZFo+c4oObgjhtKfNdS7brHI
   lSTtuXBDJ2qwNwRbkYjeg75A2cdZYuTdrF1epWXUsVSgo6T/XY4skiwjB
   73YNxtiAQ2BjiGU+kb9YHgsfWjfFueIXik3ZNGVPoZo4EzctKrNIg7kk+
   k=;
X-IronPort-AV: E=Sophos;i="5.77,396,1596499200"; 
   d="scan'208";a="60298389"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-41350382.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 20 Oct 2020 06:58:47 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-41350382.us-west-2.amazon.com (Postfix) with ESMTPS id 6E346C7490;
        Tue, 20 Oct 2020 06:55:18 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.35) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 20 Oct 2020 06:55:12 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <brendanhiggins@google.com>, SeongJae Park <sjpark@amazon.de>,
        <corbet@lwn.net>, <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <elver@google.com>
Subject: Re: [PATCH v2] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Tue, 20 Oct 2020 08:54:56 +0200
Message-ID: <20201020065456.24878-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201013063743.32179-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D48UWB003.ant.amazon.com (10.43.163.82) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I just realized I missed adding Marco Elver as a recipient, so adding him.
Sorry, Marco.


Thanks,
SeongJae Park

On Tue, 13 Oct 2020 08:37:43 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
> module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
> errors.  This commit updates the document for this.
> 
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
> 
> Changes from v1
> (https://lore.kernel.org/linux-kselftest/20201012105420.5945-1-sjpark@amazon.com/):
> - Fix a typo (Marco Elver)
> 
> ---
>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  Documentation/dev-tools/kunit/usage.rst | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index d23385e3e159..454f307813ea 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
>  
>  	config MISC_EXAMPLE_TEST
>  		bool "Test for my example"
> -		depends on MISC_EXAMPLE && KUNIT
> +		depends on MISC_EXAMPLE && KUNIT=y
>  
>  and the following to ``drivers/misc/Makefile``:
>  
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 3c3fe8b5fecc..b331f5a5b0b9 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
>  
>  ...will run the tests.
>  
> +.. note::
> +   Note that you should make your test depends on ``KUNIT=y`` in Kconfig if the
> +   test does not support module build.  Otherwise, it will trigger compile
> +   errors if ``CONFIG_KUNIT`` is ``m``.
> +
>  Writing new tests for other architectures
>  -----------------------------------------
>  
> -- 
> 2.17.1
> 
