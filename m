Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404B119C307
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgDBNtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 09:49:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727734AbgDBNtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 09:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585835342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRYOIM9RD5rPKV4o1MvvC6ajpiY3rykWsJveuXILyf0=;
        b=V3zE8BGQ1hrAaC443v13fDIcVBCS2SzznzQyKhJaBZKP59ZupBa+PHudL7QuoXQonqUE57
        moBz79sEUcDhTbYWSO8/sNeP4IxdA05qAE3plFV7uHMGcQWYkJ4qQqWGmix3Uc6alHzyxQ
        aPTdzNVhLjrMpJ66aiTsw0ABhUsoT/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-_BcmWwjoO_6vLsTQP3GR2g-1; Thu, 02 Apr 2020 09:49:00 -0400
X-MC-Unique: _BcmWwjoO_6vLsTQP3GR2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF76149C7;
        Thu,  2 Apr 2020 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60F0FDA11C;
        Thu,  2 Apr 2020 13:48:53 +0000 (UTC)
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
 <20200331081632.ithcwuzjyjhiwphy@kamzik.brq.redhat.com>
 <b261aa4f-87d5-2ac8-9f66-9f10e1a0803a@redhat.com>
 <20200401063817.gb5f4ah45qvtqkhw@kamzik.brq.redhat.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <fef1fa29-b189-aa97-eea4-0340a72a6f67@redhat.com>
Date:   Thu, 2 Apr 2020 10:48:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200401063817.gb5f4ah45qvtqkhw@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/1/20 3:38 AM, Andrew Jones wrote:
> On Tue, Mar 31, 2020 at 06:42:21PM -0300, Wainer dos Santos Moschetta wrote:
>> It would be nice to exercise the code by adding slots with different page
>> flags. But for this test that simple checks the limit, the use of
>> KVM_MEM_READONLY is enough. I will change it on v2.
> It would be good to test more memslot error conditions as well. Do you plan
> to expand on this test?

Yes, I do. For example, check memory slots addresses can't overlap.

>
> Thanks,
> drew

