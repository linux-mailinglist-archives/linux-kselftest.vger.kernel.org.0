Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95F12174B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfEQKwr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 06:52:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41355 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfEQKwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 06:52:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so6346328wro.8
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2019 03:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=THITi5Ip2HZ6an/B3Z/ms2Jjg0WRC9J/sBGO0PYgdbc=;
        b=sVtyAXSeolqgy0bt7iIlp6JpEmFXw7YNRPyl4kkT49v4qicwu1c7MYpeG2mgpex4u8
         dB5bzpOz4505B5OMsUdbPTkIGD7krd+Sm3sVbDYizx8aU7f86qFLFMY0fZblbKbCaNhL
         ltQrDzmxmjwTQPF00faFB9sK3gqEiyjXlBnAw6cfPQgT8aIZVuvR6nxwXqYU+XXAmBWH
         XD104efZ1DiBpaZlpBPTvo5N0nR63QXFMHNRS0CsbuQWUDNxWME+KG5YioV+lhCZbD2K
         lVuWWDF5RcOQM8+3O8ebn9OoH0g4STmB8KOjp2jP3WFzFLOF1Qz1Qx+ZlB0DCcBlImpB
         YMmw==
X-Gm-Message-State: APjAAAU5l7TfOsZkcs1S/HEHoEs5+42s08sq/AQyNTDtrAmCVfxV80Ol
        4O3xBPvXrswa4HzRby83kcQL3w==
X-Google-Smtp-Source: APXvYqzrLeyFl5EV/wWskuT411hf56OPfOJJunq74SqJHKK1uD/Uh8MkanrXrSd3sejTv6btaJBv6Q==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr19990925wrj.230.1558090366191;
        Fri, 17 May 2019 03:52:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z8sm7123481wrs.84.2019.05.17.03.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:52:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
In-Reply-To: <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
References: <20190517090445.4502-1-thuth@redhat.com> <20190517093000.GO16681@xz-x1> <8736ldquyw.fsf@vitty.brq.redhat.com> <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
Date:   Fri, 17 May 2019 12:52:44 +0200
Message-ID: <87zhnlpd37.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas Huth <thuth@redhat.com> writes:

>
> x86_64/vmx_set_nested_state_test.c: In function
> ‘set_revision_id_for_vmcs12’:
> x86_64/vmx_set_nested_state_test.c:78:2: warning: dereferencing
> type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   *(u32 *)(state->data) = vmcs12_revision;
>
> ... how do we want to handle such spots in the kvm selftest code?
> Compile with -fno-strict-aliasing? Or fix it with type-punning through
> unions?

These are tests, let's keep code simple. Casting my vote for the former
option)

-- 
Vitaly
