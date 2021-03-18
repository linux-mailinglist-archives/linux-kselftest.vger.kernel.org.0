Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD0340C45
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhCRRzx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 13:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhCRRzu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616090150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfqMn6+5WJV+mW2DTjb8S4Co/uAn335F6nKNzcyyJ3M=;
        b=Y9hplB3TZlHD/owjRQNU/Y7Ov3sY/eBmj0mWycV+GRA5oBwdeE2zfLcvGF41hvGtj9zpC+
        ZY0Q6GXtTu3SU+0RGX6yEfoOesZ6ksOV1wrZKd8bQ3+tzz43dBJ/G6R/HepMZGGqsVTG8T
        2xvjgstb50Emah8hCLZrKyEl82rQtIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-AwVuuQi-PqefrEE1bjbagQ-1; Thu, 18 Mar 2021 13:55:48 -0400
X-MC-Unique: AwVuuQi-PqefrEE1bjbagQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13550190A7A4;
        Thu, 18 Mar 2021 17:55:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.196.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76CD260C13;
        Thu, 18 Mar 2021 17:55:45 +0000 (UTC)
Date:   Thu, 18 Mar 2021 18:55:42 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
Message-ID: <20210318175542.xv7qaehgx2cjmuvv@kamzik.brq.redhat.com>
References: <20210318145629.486450-1-eesposit@redhat.com>
 <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
 <c08773f1-4b84-bb19-cda8-c8ac6ffffdaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08773f1-4b84-bb19-cda8-c8ac6ffffdaf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 18, 2021 at 06:33:35PM +0100, Paolo Bonzini wrote:
> On 18/03/21 18:03, Andrew Jones wrote:
> > > 
> > >  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> > > +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> > 
> > Maybe we should give up trying to keep an alphabetic order.
> 
> FWIW I had fixed that but yeah maybe we should just give up.
> 
> > > +int main(int argc, char *argv[])
> > > +{
> > > +	if (kvm_check_cap(KVM_CAP_GET_MSR_FEATURES))
> > > +		test_get_msr_feature();
> > > +
> > > +	test_get_msr_index();
> > Missing return
> > 
> > > +}
> 
> "main" is special, it's okay not to have a return there.

Hmm, yeah. I always assumed the compiler would complain or that you'd end
up with a garbage return code. But, I just checked, and indeed not only do
you not get a warning, even with -Wall -Wextra, but the compiler actually
emits code for a zero return value on your behalf. Looks weird to me
though to end an int function without a return, so I don't think I'm
going to adopt this practice myself.

Thanks,
drew

