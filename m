Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5E2F89CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jan 2021 01:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhAPALY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jan 2021 19:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAPALX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jan 2021 19:11:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E888C0613D3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 16:10:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y8so5532009plp.8
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 16:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bie5cw6IgM1/wPZEPjLzAx0dXtWLAo5L5+QElnLZ0lw=;
        b=JfcClhi8ThEbUx1xc/HweHvfS3oYjLxZglAOXkbN7XcScAUlZuDr2zU2+kD+vAp3/P
         3smdJHqUkHCBuuwZ7pHK20OTvgE40/xcI+Ti4kpzD8Wzb2ozimVi06xdFbU3erOGivDF
         MhuhsGC/a0f17cfDoXYVX3knC12e/7ZQylY/b4/tC5o9NdcA6FlMZwtdSxCi+u8n7xO5
         cXP6ium5H5iHbmssgy46DfEZKNubp6qlIV+O32p2jbZL4hCN6XBQbt0YtJl+uCrdlu7U
         UT6qGc8JOZuuYr0IBIs2+6dAcJa8ZA+cKaWnq8CWfErWLJLNMqwpN3ivxtEs7lO8LmZl
         N/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bie5cw6IgM1/wPZEPjLzAx0dXtWLAo5L5+QElnLZ0lw=;
        b=EFxL3CNzsL0H2vFKWgBSYndO7u3OgtQRvlzIPhpAfq04BjGy7lUKMEZoDCEON1Rsu2
         OeJSX4XKqqEf313zS3ND6ohUL+6vav3jvw8iOg5uEp+We3eKDjJRc9wtCORv7GuvRO4g
         1dNIaLfQFCaWBax5virLM2XacNhMN9uY7h5Etfs83EzVAE/oKyeX2UzxCWx2/bFRK91b
         xUP5X+W6XZwZFF6NiBb5ZnrclXtV11prRt3fC72C7+JkmHFIfnlTpj4NZ+Ls024S6gCr
         RjzHBoij5r8JHkFPlf0bPEF4NPiQap/idQ56qFAykWRfYadyFAXv+x/7Q5Zya7Tq7IP8
         w9fQ==
X-Gm-Message-State: AOAM530FY0BiEAg4YCkCTBiNo6oYAO1/Kk7yQUItVVuZ/GEhoYmwmUh7
        IRhAQkT5OFmq7mHvP6hLzX4H5uS86G1rWA==
X-Google-Smtp-Source: ABdhPJzCO7p96Akm/DHojJzNSqrjomr1S9QiWXoQxgHDqKHRdHhi0EUQ8a3kodg1g7reFX41E2Lkhg==
X-Received: by 2002:a17:90a:c8d:: with SMTP id v13mr13334657pja.75.1610755842662;
        Fri, 15 Jan 2021 16:10:42 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id l11sm9465799pgt.79.2021.01.15.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:10:41 -0800 (PST)
Date:   Fri, 15 Jan 2021 16:10:35 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Subject: Re: [PATCH 6/6] KVM: selftests: Add memslot modification stress test
Message-ID: <YAIu+7qu5OTRZXsT@google.com>
References: <20210112214253.463999-1-bgardon@google.com>
 <20210112214253.463999-7-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112214253.463999-7-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 12, 2021, Ben Gardon wrote:
> Add a memslot modification stress test in which a memslot is repeatedly
> created and removed while vCPUs access memory in another memslot. Most
> userspaces do not create or remove memslots on running VMs which makes
> it hard to test races in adding and removing memslots without a
> dedicated test. Adding and removing a memslot also has the effect of
> tearing down the entire paging structure, which leads to more page
> faults and pressure on the page fault handling path than a one-and-done
> memory population test.

Would it make sense to integrate this with set_memory_region_test?  At a high
level, they are doing very similar things.  Not sure how much code can be shared,
but I assume there's some amount of overlap.
