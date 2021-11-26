Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1245F195
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 17:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhKZQUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 11:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhKZQSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 11:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637943339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIwlzQg5mrM5RLNTyqo8wjzNsYTDLGVsq/ojfDTmyas=;
        b=O73cnzdj49sz+N3WpMPUSp+nuZmeG9IpZs+Z2ZKsMYCKtZXXs+fvZRSYXP1W/OaUYOUIeh
        Pr7ca6f7/3M20Wrs6IDC1Gnf5CzOvZjrhz+qso/FP6Bp07dJGSVeEU9D/xfh/fZn9t6seD
        IPmPumH3ZPXaQbSd92LUvE/eGfwde5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-nxWDWnimNVij76QKU5574A-1; Fri, 26 Nov 2021 11:15:37 -0500
X-MC-Unique: nxWDWnimNVij76QKU5574A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE0D1006AA1;
        Fri, 26 Nov 2021 16:15:35 +0000 (UTC)
Received: from [10.39.195.16] (unknown [10.39.195.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84381604CC;
        Fri, 26 Nov 2021 16:15:32 +0000 (UTC)
Message-ID: <9545cab7-6365-b20d-fc05-82ace6368661@redhat.com>
Date:   Fri, 26 Nov 2021 17:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level
 Makefile
Content-Language: en-US
To:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211126154020.342924-1-anup.patel@wdc.com>
 <20211126154020.342924-4-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211126154020.342924-4-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/21 16:40, Anup Patel wrote:
> We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile
> which will allow users to pass additional compile-time flags such
> as "-static".

Is this just for debugging?  I cannot understand if it's used in patch 4.

Paolo

