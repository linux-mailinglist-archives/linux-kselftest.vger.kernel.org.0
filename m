Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E32A62AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgKDKzG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 05:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729597AbgKDKzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 05:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604487304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3u0+lkwsfiVe4d5JwGEYaEFEFtHacqRJXTy/nsAlx0=;
        b=QvVRp7HTFPjU6Ea6ibUGOdrb8A7Xx38hQTYIpDaEkp8DTlpfUBj72sFvyYdJM9EMwWmCKr
        te/HgfiEuazmRFPTY/+t5+Il5BeeiNQPdCiRQPA4GL6n9/QSnxRXk2Gkm8a4Ywx1InQ5Lw
        Qlj8tiHZGs+DctZIhn9RUN75DziRv7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-m8B7P33NNe-Xsxrs1Gxuww-1; Wed, 04 Nov 2020 05:55:00 -0500
X-MC-Unique: m8B7P33NNe-Xsxrs1Gxuww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 724DE8030D7;
        Wed,  4 Nov 2020 10:54:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C655B4BB;
        Wed,  4 Nov 2020 10:54:52 +0000 (UTC)
Date:   Wed, 4 Nov 2020 11:54:50 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 1/5] KVM: selftests: Remove address rounding in guest
 code
Message-ID: <20201104105450.t2frosra4mvixrwi@kamzik.brq.redhat.com>
References: <20201103234952.1626730-1-bgardon@google.com>
 <20201103234952.1626730-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103234952.1626730-2-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 03:49:48PM -0800, Ben Gardon wrote:
> Rounding the address the guest writes to a host page boundary
> will only have an effect if the host page size is larger than the guest
> page size, but in that case the guest write would still go to the same
> host page. There's no reason to round the address down, so remove the
> rounding to simplify the demand paging test.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 360cd3ea4cd67..32a42eafc6b5c 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -103,7 +103,6 @@ static void guest_code(uint32_t vcpu_id)
>  	for (i = 0; i < pages; i++) {
>  		uint64_t addr = gva + (i * guest_page_size);
>  
> -		addr &= ~(host_page_size - 1);
>  		*(uint64_t *)addr = 0x0123456789ABCDEF;
>  	}
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

