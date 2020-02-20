Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A38165351
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 01:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBTAFw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 19:05:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42906 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBTAFv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 19:05:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so25726143oih.9
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On4/X6XTdlAfrZHKoVhgecOTEOux4GHMdiEnySmBdt8=;
        b=VK+0jpevVkZp/UHyagl40Y2dezLtobNOAkPWNA2EFwgtAnqWXAvRKL2fUDYjIIYuOX
         5sD5qSv5bL+cr76lEQf4F46fwYdhqauQO/x/HQNTZ0vVr6HL9LZOVD6/suQ3H0O7Caep
         qwIOgwYDsQ9Dgev+b1WryYQ43HfiGsFPeyaTa2mBQ9iRyhI96dyn+5Msdo/n+suooF0w
         b+VcqixzW9m6IGvKS6k2wPw3kiwfoRYj6ynaXhaSWThUHIR+lDRULTcPDalnZsalZW69
         X6syUyxegauMHYLgPzslGiMCLpScqFt1HGn7ExxFY9FrlOAiKd+ceTkoGJ2L7dqWkMOa
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On4/X6XTdlAfrZHKoVhgecOTEOux4GHMdiEnySmBdt8=;
        b=cJjxZwbNK1X/QM2AgNKXArzslC+5pOL9KROVTNv6ar+zWuei40MR5JiyOzLBVeEipQ
         wthjO8Y6zoUDBgTaKmbIVaegQNflYxtM+xqMN0DPvVNk+aaIbQW3QaWRO08cS38DjPzS
         4AyQztGeT2AmhEzo5DyYLeyQuhH0KmQq2FUFhmZulTyYyAUTXzuPa40IDhBzT813LEAF
         hsrrOxz+QWhraRLagJtHJEDCG99wb/mfbNLSuQ7fpQv8hHX+dYz3QXogmWsaiRmWPW+a
         SQSAPx2BiOXl4epI1h+X8a8JCII4UMTUvVCEalhEtakmGFIAR46I8tO3HJtVq01JevrM
         Bh2A==
X-Gm-Message-State: APjAAAXk1CkwNVCgifCtM2oSdhIbMtNeaJQiE8ABAZG6loqOXW+kXREj
        QqFKLLOcfebdur1mgCLN/Z/hrEkqct7Pcsc4AbVdNg==
X-Google-Smtp-Source: APXvYqx7kVH16uapNvK9tOipvAvk7gTbvKB9LtiGZMaNftmOXBmHqRRY9147oKxDVcrMXpx3fHZc1RbJlcQ1qSDu6Mg=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr183736oig.103.1582157151087;
 Wed, 19 Feb 2020 16:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-8-almasrymina@google.com> <37a49c35-567f-1663-33cd-3dac150020a0@linux.ibm.com>
In-Reply-To: <37a49c35-567f-1663-33cd-3dac150020a0@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 16:05:40 -0800
Message-ID: <CAHS8izOumQZJw9yDLSJz8buYc8oUL8oiex8Ji62QcpTX4J6G_g@mail.gmail.com>
Subject: Re: [PATCH v12 8/9] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 12, 2020 at 12:50 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
>
>
> On 12/02/20 3:01 am, Mina Almasry wrote:
> > The tests use both shared and private mapped hugetlb memory, and
> > monitors the hugetlb usage counter as well as the hugetlb reservation
> > counter. They test different configurations such as hugetlb memory usage
> > via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
> > MAP_POPULATE.
> >
> > Also add test for hugetlb reservation reparenting, since this is
> > a subtle issue.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Cc: sandipan@linux.ibm.com

Hi folks,

Sandipan provided a Tested-by but this is more or less the only patch
in the series that is awaiting review. Can someone take a look?

Shuah, you started reviewing this months ago and I addressed the
comments. Maybe you can take another look?

Thanks in advance!
