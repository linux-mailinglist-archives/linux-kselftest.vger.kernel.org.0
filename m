Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEC164E6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSTFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 14:05:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36348 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgBSTFy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 14:05:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so24921002oic.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=MRO7yMzk7yDrFx6YlaBjQipExwOAAl5oZs4Uw3k4YEf0IGCO46qz9pNv7mKfRtdLmz
         PEMy+4mqqmhwK9gt+RfIID4sYXypy6kmfz1f3/bMfc/HE8wlsqQQGiSvYEAjvEeIOtHa
         S6UhvT56lMx/7KvHuGwTFmdLS+x63NJs9cvcUK6OyY4jAYlq0NtF8+Y90oLe3sYVYbZG
         Z4C1gt9hZGvCpniRgDi27fhm9UHQPo3FBAsRTSTIXvJ0SCAfmlCJZJvUqjqxhIhm85Eo
         FcWe5DtoCsHrj7vx/oU+0Nb9bnw/5FAhoH0jlTXQwKcUoHzNp9GTA2nYG/bf1Wm2UWLP
         W65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3W3v+68ig6DpCsCj7cxqvrURO7RlrIPZ7rtuczBdEw=;
        b=huw4Ne9NrSMrITiH7UubUWNBTJMfxyNzaw41/IUBNfTVM9dfm20CB6U8Nz1WfaCCob
         KBl1CPPeWJFjBvmPxW0MmgpH3ecnmT7IwybP38+JaBCHt75T9u4/n3fYYzlbmMauMXPC
         mbMhmok8rEhd55dPt2s08Acxq1op/1C7Eha5xutN0fa71OjV6X2Yh8TUsJafcXY+1KvE
         AstA88mjGATkrgD06uQDMeBfRHEK+L5X1vZS+4bxwN8/TVxLB2S1fIkxqrWoE+uv9cPO
         p8d4OdYCQTMdzHitBDwBycH2Eo5NiTiuwSN6vVjvvz+YmsXnKqsfS3Gvwa6K/BhOUFAI
         UzcA==
X-Gm-Message-State: APjAAAWx4ekC4EXDAH6+O8Ye87YiuFFYu4V1VxlkaLFtaKiTuIcje8gI
        eYRlrE0GPSc6roDUMHjjdLzC2ebdxF9qHIaOufkzyg==
X-Google-Smtp-Source: APXvYqwEay32tZ67d1pnpiUQv4wvXQaJmUw10KBTCy/isaFzhTkheZJm6RN/SlMhPx5MtBPryEnlPcoCjQaeEkl+B1s=
X-Received: by 2002:aca:1012:: with SMTP id 18mr5372313oiq.151.1582139152379;
 Wed, 19 Feb 2020 11:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
In-Reply-To: <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 11:05:41 -0800
Message-ID: <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > These counters will track hugetlb reservations rather than hugetlb
> > memory faulted in. This patch only adds the counter, following patches
> > add the charging and uncharging of the counter.
>
> We're still pretty thin on review here, but as it's v12 and Mike
> appears to be signed up to look at this work, I'll add them to -next to
> help move things forward.
>

Hi Andrew,

Since the patches were merged into -next there have been build fixes
and test fixes and some review comments. Would you like me to submit
*new* patches to address these, or would you like me to squash the
fixes into my existing patch series and submit another iteration of
the patch series?
