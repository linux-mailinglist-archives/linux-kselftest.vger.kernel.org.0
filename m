Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2E1AC410
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894948AbgDPNxp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Apr 2020 09:53:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441728AbgDPNxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587045221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5Kvo8iqImptqYWsZSVRrcAXyDBLn+NV1FJvmlGAZQs=;
        b=RoTJFRbR4rzaOwNX7LcSs9elegXgI7fBsqdwi96HECy8futjYinQItzUlaftvuAqO0c7Yb
        jwQKfnWxXZxY4S1NGcuwObEHaIOcri0paPu1hRmE5RL6nVFuXREyfZvkeVOh9qL6cofR/c
        t3/UBI4k02MNHwYgJeIEBCfOdW1IRlU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-Jp9jT09POnuYER5EVKf3ig-1; Thu, 16 Apr 2020 09:53:39 -0400
X-MC-Unique: Jp9jT09POnuYER5EVKf3ig-1
Received: by mail-wr1-f70.google.com with SMTP id y1so1752508wrp.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5Kvo8iqImptqYWsZSVRrcAXyDBLn+NV1FJvmlGAZQs=;
        b=TcMu4Tp7HM3aJYAmw7WaHerQkqX8AqmSN2N6h30KcWRHwpI8MfGCats9d1QWBKE6Ap
         3m8p/WR6E567+1VDbx4oDDZJXF+z+c0GD29sX54TkW8gGgQ9m/mnXcw3n7fgEesZfgLI
         WOt2qB3xspZXB5uGEuOXwIXZd+v+Uf6sOH3yitCtZAKnMJkPPJsUZWOLHH9D/bYNfdVQ
         Gn1mY/d4QdfkUv8DrOVlbD6ub5Ik3F2BwA4ovXtCX1iGoyCaHu2ZxDbMvTy6fA1+8ea3
         UNb7pM+wbUmm5iplEv4pcmFa9xwvLUOtSJM2xKXXbRKYS6L5cikqNlwnbrZf9KuWW/uX
         bVKg==
X-Gm-Message-State: AGi0PuYzJfOse6VAoNaE2IQ7/qBF/dzZZGEQVp9S4r5bISy2jrERzTLa
        wB5mLYDAqkxEiH4brcE+MiiyRCx4Clo2TI3QkK3YHqnxY8tAcc3rQZGpySTwjCSs5SwCBPhTZXi
        sWy7dNiye/wsGIsmSonYuRnP31/m3
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr5041262wma.89.1587045218354;
        Thu, 16 Apr 2020 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJz8z7BCZnr8VscT/Dzs37ZSpW6T2prR2o4U8uyDX4us/2PqqegrZdIYt2ZRQvbdMEU26XesA==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr5041239wma.89.1587045218126;
        Thu, 16 Apr 2020 06:53:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id f23sm3585008wml.4.2020.04.16.06.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:53:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: kvm: Add overlapped memory regions test
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200415204505.10021-1-wainersm@redhat.com>
 <20200415204505.10021-2-wainersm@redhat.com>
 <455a01b6-506b-3c16-7ad8-327ad63292e9@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d05b77b-1e8b-2dfd-cbc9-5b09b685b630@redhat.com>
Date:   Thu, 16 Apr 2020 15:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <455a01b6-506b-3c16-7ad8-327ad63292e9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/04/20 01:57, Krish Sadhukhan wrote:
> 
>> Add the test_overlap_memory_regions() test case in
>> set_memory_region_test. This should check that overlapping
>> memory regions on the guest physical address cannot be added.
> 
> 
> I think the commit header and the body need some improvement. For example,
> 
>         Header: Test that overlapping guest memory regions can not be added
> 
>         Body:  Enhance the existing tests in set_memory_region_test.c so
> that it tests overlapping guest
> 
>                     memory regions. The new test verifies that adding
> overlapping guest memory regions fails.

I like Wainer's header and your body. :)

Paolo

