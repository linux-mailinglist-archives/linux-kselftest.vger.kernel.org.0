Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E919A573
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgDAGib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 02:38:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731735AbgDAGib (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 02:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585723110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCSSEclj0ae09gTP8bn9O3K6yRcTAt/8Yi29buWbaxw=;
        b=B0s5qLL2k0eamZOMT6HG7t4kHFL4xZnrfeQI6Q8edEUGKzgoXJ2wz6FGFkhJXzxLea06FD
        s8D11wtWfps9fzpObRyio/NJiGDk/lGJBf58W6PDOCQBAEXI+x2QYt0DPOrZyRKASfTVxq
        t6Wi3EF762Ih67Ei7qckrzB+Wpa6SXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-MkT21KpwPa-iJMpbhwU6pQ-1; Wed, 01 Apr 2020 02:38:28 -0400
X-MC-Unique: MkT21KpwPa-iJMpbhwU6pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B511A107ACC7;
        Wed,  1 Apr 2020 06:38:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3800B10002AE;
        Wed,  1 Apr 2020 06:38:20 +0000 (UTC)
Date:   Wed, 1 Apr 2020 08:38:17 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200401063817.gb5f4ah45qvtqkhw@kamzik.brq.redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
 <20200331081632.ithcwuzjyjhiwphy@kamzik.brq.redhat.com>
 <b261aa4f-87d5-2ac8-9f66-9f10e1a0803a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b261aa4f-87d5-2ac8-9f66-9f10e1a0803a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 31, 2020 at 06:42:21PM -0300, Wainer dos Santos Moschetta wrote:
> It would be nice to exercise the code by adding slots with different page
> flags. But for this test that simple checks the limit, the use of
> KVM_MEM_READONLY is enough. I will change it on v2.

It would be good to test more memslot error conditions as well. Do you plan
to expand on this test?

Thanks,
drew

