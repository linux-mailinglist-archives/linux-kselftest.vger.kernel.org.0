Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73E1328EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 15:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGOdk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 09:33:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGOdk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578407619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIlISc+oFNSUFYsXBbt0s1bPhdRwU0QuyhBE/WUY0LY=;
        b=gU2K27p8Z6R8JiXoBxApgt7/kPhp/RxyWMCjrIQEz8tyQstueXvcENXvAVxO3OItYonvyk
        OuN+Q6eb7V3GDTFs+PMCKB/uh0qQxaEe1i5z6DtK+z/I+WEvp3HRy4TVzzlTKv9oGnX6am
        GsRHNHUaujmqSvcvoKJ7gkNP1ostWEI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-3AlNr6BLODuxzAIXc3Oayw-1; Tue, 07 Jan 2020 09:33:37 -0500
X-MC-Unique: 3AlNr6BLODuxzAIXc3Oayw-1
Received: by mail-qv1-f71.google.com with SMTP id ce17so34747qvb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 06:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIlISc+oFNSUFYsXBbt0s1bPhdRwU0QuyhBE/WUY0LY=;
        b=h2v8WwdadzhuQAkwntvjCwH1MpoBDcyt6afsgtYxN5hV/ytcWLbH9Omhu9NWxQ+nDO
         lE1sk2qIY2F0qw2zgUpEnaig1CiMJSTaxHkyFNyGkzOeFz7rpiJ/rJBsvi5aIZRm45zE
         C3UraR0e8AV9wuDQuNkhAE7lBtqDvgnNWIzgEBb8bCtNvA5iWd3cjinndzUPZw27mo0s
         MaJdWeEEWM98CYUomTx8WBW81jWMJfHZsPKH83OTy8siQLPkxVb/nvwLp+yK4Nj9/c14
         +tYSFCkIVdmAeZvCyhvAKKZyrSqoyX9l7oE27zEkxoMrnu6qSrzTJWZHIwB1TpqM7Dy9
         rFhw==
X-Gm-Message-State: APjAAAVx3cdr3H3+WfPHShjiRAHKwPAF3Nc1rekexaVbTQaz+W36DMhZ
        eGpZRodRHb0PciVQJL8ro9lzD/ZA5EWB8M+X/J4LIW3DpPYIKlDFBAhn8H+QAxVaFzvZ5L77bQJ
        gbufszUqegNI+F2UOK+Xy4hmPVi2O
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr89412682qko.204.1578407617059;
        Tue, 07 Jan 2020 06:33:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIGMDr1WALhNYI3XjsUL6aYAw4TNtgyas8iR6yCDYV5GmJoDkDtGiffkZzxsW1v0I7msmFFA==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr89412659qko.204.1578407616724;
        Tue, 07 Jan 2020 06:33:36 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a19sm22455306qka.75.2020.01.07.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:33:35 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:33:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
Message-ID: <20200107143334.GF219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-2-bgardon@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:54PM -0800, Ben Gardon wrote:
> While userfaultfd, KVM's demand paging implementation, is not specific
> to KVM, having a benchmark for its performance will be useful for
> guiding performance improvements to KVM. As a first step towards creating
> a userfaultfd demand paging test, create a simple memory access test,
> based on dirty_log_test.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

It's fine to start with x86-only for this test, but imho it would be
better to mention that in cover letter, or reply to reviewer comments
on that you removed aarch64 from previous post.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

