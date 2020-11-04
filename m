Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006652A679F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 16:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKDP2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 10:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgKDP2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 10:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604503718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OzvLPilVuFx00ghPxfGHTtJOpDXHfZFvWBiD6OmUMv8=;
        b=dcQnQrggJHE/Zm8D5/A/DLKfgv88OrNvTuSIlcbJZDpRqTp38Z2dS56/gtnkbE7HFxBprG
        XMpBesVjK7YYo54IPXKP+K9BtUt08zT11n8nmuUj13tqGuDGkW+L9ruGzeGx2fhHHmTntI
        ozBYpdQF2wACrjz3sSbeOILjlBHBLgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-3YsTLM5uMWGiO6aEmwJwCg-1; Wed, 04 Nov 2020 10:28:36 -0500
X-MC-Unique: 3YsTLM5uMWGiO6aEmwJwCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32D710A0B83;
        Wed,  4 Nov 2020 15:28:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E00719650;
        Wed,  4 Nov 2020 15:28:26 +0000 (UTC)
Date:   Wed, 4 Nov 2020 16:28:23 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 2/5] KVM: selftests: Factor code out of
 demand_paging_test
Message-ID: <20201104152823.qxdlbygza7ykn5x2@kamzik.brq.redhat.com>
References: <20201103234952.1626730-1-bgardon@google.com>
 <20201103234952.1626730-3-bgardon@google.com>
 <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
 <20201104150017.GN20600@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104150017.GN20600@xz-x1>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 10:00:17AM -0500, Peter Xu wrote:
> On Wed, Nov 04, 2020 at 01:16:31PM +0100, Andrew Jones wrote:
> > If you don't mind I'd like to try and cleanup / generalize / refactor
> > demand_paging_test.c and dirty_log_test.c with a few patches first for
> > you to base this work on. I can probably get something posted today
> > or tomorrow.
> 
> Drew,
> 
> Would you consider picking up the two patches below in the dirty ring series if
> you plan to rework the dirty log tests?  I got your r-b so I am making bold to
> think I'm ok to ask this; I just want to avoid another potential conflict
> within the series.

Sure, no problem.

I'll go ahead and get that cleanup / refactor series out.

Thanks,
drew

> 
> Thanks!
> 
> [1] https://lore.kernel.org/kvm/20201023183358.50607-11-peterx@redhat.com/
> [2] https://lore.kernel.org/kvm/20201023183358.50607-12-peterx@redhat.com/
> 
> -- 
> Peter Xu
> 

