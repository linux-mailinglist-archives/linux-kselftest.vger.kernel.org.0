Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2E21668C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGGGi6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 02:38:58 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:38509 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGGi5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 02:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594103937; x=1625639937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5yEvq7StD06SmEX9yNGvdQ9oUgxXrCyeGSGmzeunTGI=;
  b=moOzwUM8k4COnZokJfpSfX/orx1iiFB6NzoeFTT9fq113Ykn4dJpOYRh
   Em+VPq2HCYOOO0KNBvTTgAaTcE5KILjJsKCki4r0wpC8tze9y0H52Olpf
   X6tP0C8HvOgEr3u64ubJ18oXVDiqPIR9k+4lzpyCq4g1oXIsqBNdHxHSg
   Q=;
IronPort-SDR: gH2xrJdS5ijwT+nBq3S1DTWStzGTKjk5Daw0r+1C9dWMlH+Ya1av1O8pVyNZpSEnw5+aAJNhoL
 cUSrbmMig/rw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589241600"; 
   d="scan'208";a="49642298"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 06:38:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 1559214177C;
        Tue,  7 Jul 2020 06:38:46 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 06:38:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 06:38:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Gow <davidgow@google.com>
CC:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: kunit: Remove references to --defconfig
Date:   Tue, 7 Jul 2020 08:38:25 +0200
Message-ID: <20200707063825.4361-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707043119.3016937-1-davidgow@google.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon,  6 Jul 2020 21:31:20 -0700 David Gow <davidgow@google.com> wrote:

> The --defconfig option in kunit_tool was removed in [1], but the getting
> started and kunit_tool documentation still encouraged its use. Update
> those documents to reflect that it's no-longer required, and is the
> default behaviour if no .kunitconfig is found.
> 
> Also update a couple of places where .kunitconfig is still referred to
> as kunitconfig (this was changed in [2]).
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=9bdf64b35117cc10813d24e1842cd8ee40ecbf19
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=14ee5cfd4512ee3d1e0047d8751450dcc6544070
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park
