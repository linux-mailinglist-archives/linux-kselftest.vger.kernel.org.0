Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23242312EE2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhBHKYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 05:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232157AbhBHKWT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 05:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612779651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+jPd/3FVQIk0Q7688Eeo9WA6mV19wQqL9xJua3uhWQ=;
        b=RmWbNN2Rw1CncCn4AKV1+2Rwj+OKvWBPMCYrh/Qxbl8lh7tC34iHGQb3pjNsvKp/z2qR7f
        z9tBlKh2vBJQ8bSyLh+ERkSLy2ufP6VJXHHqtjVQx0L4iitiHe4fAVtsNV4KAPqB9BMk7J
        +ZsdrKHgDn0dzcxufP5V4PJqbAU2DqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-OA3UsJVMNmmFBwdz5KPmnQ-1; Mon, 08 Feb 2021 05:20:47 -0500
X-MC-Unique: OA3UsJVMNmmFBwdz5KPmnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8945410066F7;
        Mon,  8 Feb 2021 10:20:38 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E7FD100F496;
        Mon,  8 Feb 2021 10:20:33 +0000 (UTC)
Date:   Mon, 8 Feb 2021 11:20:27 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Keep track of memslots more
 efficiently
Message-ID: <20210208102027.roclkurxiibpx6su@kamzik.brq.redhat.com>
References: <5e5d83b305077e3e65b130dbb31c131bfb831170.1612139762.git.maciej.szmigiero@oracle.com>
 <20210208101634.vfsr6zoxjnrguwuv@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208101634.vfsr6zoxjnrguwuv@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 08, 2021 at 11:16:41AM +0100, Andrew Jones wrote:
> > diff --git a/tools/testing/selftests/kvm/lib/rbtree.c b/tools/testing/selftests/kvm/lib/rbtree.c
> > new file mode 100644
> > index 000000000000..a703f0194ea3
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/rbtree.c
> > @@ -0,0 +1 @@
> > +#include "../../../../lib/rbtree.c"
> >
> 
> We shouldn't dip into kernel code like this. We can use tools/lib/rbtree.c
> though.
> 
> Besides the rbtree.c thing,

Oops, sorry, just realized the first '..' applies to kvm's lib subdir.
So this is already using tools/lib/rbtree.c

Thanks,
drew

> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

